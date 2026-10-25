#!/bin/bash

DOLTLITE="${1:-./doltlite}"
REMOTESRV="${DOLTLITE_BUILD_DIR:-$(dirname "$0")/../build}/doltlite-remotesrv"
PASS=0; FAIL=0; ERRORS=""

check_eq() {
  local name="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    PASS=$((PASS+1))
  else
    FAIL=$((FAIL+1))
    ERRORS="$ERRORS\nFAIL: $name\n  expected: $expected\n  got:      $actual"
  fi
}

check_match() {
  local name="$1" pattern="$2" actual="$3"
  if echo "$actual" | grep -qE "$pattern"; then
    PASS=$((PASS+1))
  else
    FAIL=$((FAIL+1))
    ERRORS="$ERRORS\nFAIL: $name\n  pattern: $pattern\n  got:     $actual"
  fi
}

q() { "$DOLTLITE" "$@" 2>&1; }

echo "=== Doltlite workspace ref tests ==="

TMP=$(mktemp -d "${TMPDIR:-/tmp}/doltlite-wsrefs.XXXXXX")
SRV_PID=""
cleanup() {
  [ -n "$SRV_PID" ] && { kill "$SRV_PID" 2>/dev/null; wait "$SRV_PID" 2>/dev/null; }
  rm -rf "$TMP"
}
trap cleanup EXIT

DB="$TMP/a.db"
q "$DB" "CREATE TABLE t(id INTEGER PRIMARY KEY, v TEXT);
INSERT INTO t VALUES(1,'a');
SELECT dolt_commit('-Am','init');" >/dev/null
MAIN=$(q "$DB" "SELECT hash FROM dolt_branches WHERE name='main';")

# --- create / list / name rules ---
check_eq "create" "0" "$(q "$DB" "SELECT dolt_workspace('ws1');")"
check_eq "listed_in_dolt_workspaces" "ws1|$MAIN" \
  "$(q "$DB" "SELECT name, hash FROM dolt_workspaces;")"
check_eq "dolt_workspaces_eq_lookup" "ws1" \
  "$(q "$DB" "SELECT name FROM dolt_workspaces WHERE name='ws1';")"
check_eq "hidden_from_dolt_branches" "main" \
  "$(q "$DB" "SELECT name FROM dolt_branches;")"
check_eq "hidden_from_dolt_branches_eq" "0" \
  "$(q "$DB" "SELECT count(*) FROM dolt_branches WHERE name='workspaces:ws1';")"
check_match "create_duplicate" "workspace already exists" \
  "$(q "$DB" "SELECT dolt_workspace('ws1');")"
check_match "create_over_branch_name" \
  "workspace name must not be existing branch name" \
  "$(q "$DB" "SELECT dolt_workspace('main');")"
check_match "create_invalid_name" "invalid workspace name" \
  "$(q "$DB" "SELECT dolt_workspace('a:b');")"
check_match "create_name_required" "workspace name required" \
  "$(q "$DB" "SELECT dolt_workspace('');")"
check_match "create_bad_start" "start point not found" \
  "$(q "$DB" "SELECT dolt_workspace('w9','nope');")"

# --- the reserved namespace is closed to branch commands ---
check_match "branch_create_reserved" "invalid branch name" \
  "$(q "$DB" "SELECT dolt_branch('workspaces:x');")"
check_match "checkout_b_reserved" "invalid branch name" \
  "$(q "$DB" "SELECT dolt_checkout('-b','workspaces:x');")"
check_match "branch_delete_reserved" "branch not found" \
  "$(q "$DB" "SELECT dolt_branch('-D','workspaces:ws1');")"
check_match "branch_move_reserved" "source branch not found" \
  "$(q "$DB" "SELECT dolt_branch('-m','workspaces:ws1','x');")"
check_match "branch_copy_reserved" "source branch not found" \
  "$(q "$DB" "SELECT dolt_branch('-c','workspaces:ws1','x');")"
check_match "branch_rename_into_reserved" "invalid branch name" \
  "$(q "$DB" "SELECT dolt_branch('-m','main','workspaces:x');")"
check_match "checkout_reserved_name" "detached head" \
  "$(q "$DB" "SELECT dolt_checkout('workspaces:ws1');")"
check_match "connect_reserved_name" "branch not found" \
  "$(q "$DB" "SELECT dolt_connect_branch('workspaces:ws1');")"
check_match "default_branch_reserved" "not found" \
  "$(q "$DB" "SELECT dolt_default_branch('workspaces:ws1');")"
check_eq "workspace_survives" "ws1" "$(q "$DB" "SELECT name FROM dolt_workspaces;")"
check_match "internal_name_not_a_revision" "invalid" \
  "$(q "$DB" "SELECT count(*) FROM dolt_log('workspaces:ws1');")"
check_eq "workspace_ref_is_a_revision" "2" \
  "$(q "$DB" "SELECT count(*) FROM dolt_log('refs/workspaces/ws1');")"

# --- open a workspace by path: read-write, each edit a commit ---
WS_HEAD=$(q "$DB@refs/workspaces/ws1" "INSERT INTO t VALUES(2,'b');
SELECT dolt_commit('-am','edit 1');")
check_eq "workspace_commit_moves_ref" "$WS_HEAD" \
  "$(q "$DB" "SELECT hash FROM dolt_workspaces WHERE name='ws1';")"
check_eq "main_unchanged" "1" "$(q "$DB" "SELECT count(*) FROM t;")"
check_eq "slash_path_open" "2" \
  "$(q "$DB/refs/workspaces/ws1" "SELECT count(*) FROM t;")"
check_match "missing_workspace_open" "not found" \
  "$(q "$DB@refs/workspaces/nope" "SELECT 1;")"
check_match "delete_open_workspace" "cannot delete the current workspace" \
  "$(q "$DB@refs/workspaces/ws1" "SELECT dolt_workspace('-d','ws1');")"

# --- branch from, fast-forward to, then delete ---
check_eq "branch_from_workspace" "0" \
  "$(q "$DB" "SELECT dolt_branch('feat','refs/workspaces/ws1');")"
check_eq "branch_from_workspace_head" "$WS_HEAD" \
  "$(q "$DB" "SELECT hash FROM dolt_branches WHERE name='feat';")"
check_eq "ff_main_to_workspace" "$WS_HEAD" \
  "$(q "$DB" "SELECT dolt_merge('refs/workspaces/ws1');")"
check_eq "main_at_workspace_head" "$WS_HEAD" \
  "$(q "$DB" "SELECT hash FROM dolt_branches WHERE name='main';")"
check_eq "delete" "0" "$(q "$DB" "SELECT dolt_workspace('-d','ws1');")"
check_eq "deleted" "0" "$(q "$DB" "SELECT count(*) FROM dolt_workspaces;")"
check_match "delete_missing" "workspace not found" \
  "$(q "$DB" "SELECT dolt_workspace('-d','ws1');")"
check_eq "create_at_revision" "0" "$(q "$DB" "SELECT dolt_workspace('old','HEAD~1');")"
check_eq "create_at_revision_hash" "$MAIN" \
  "$(q "$DB" "SELECT hash FROM dolt_workspaces WHERE name='old';")"
q "$DB" "SELECT dolt_gc();" >/dev/null
check_eq "gc_keeps_workspace" "1" \
  "$(q "$DB@refs/workspaces/old" "SELECT count(*) FROM t;")"

# --- remotes ---
remote_suite() {
  local label="$1" url="$2" src="$TMP/$1-src.db"
  q "$src" "CREATE TABLE t(id INTEGER PRIMARY KEY);
INSERT INTO t VALUES(1);
SELECT dolt_commit('-Am','init');
SELECT dolt_remote('add','origin','$url');
SELECT dolt_push('origin','main');
SELECT dolt_workspace('w1');" >/dev/null
  local w1
  w1=$(q "$src@refs/workspaces/w1" "INSERT INTO t VALUES(2); SELECT dolt_commit('-am','w');")

  check_eq "$label: push_all_skips_workspace" "0" \
    "$(q "$src" "SELECT dolt_push('--all','origin');")"
  check_eq "$label: no_remote_workspace_yet" "0" \
    "$(q "$TMP/$label-probe0.db" "SELECT dolt_clone('$url');
SELECT count(*) FROM dolt_workspaces;" | tail -1)"

  check_eq "$label: explicit_push" "0" \
    "$(q "$src" "SELECT dolt_push('origin','refs/workspaces/w1');")"
  check_eq "$label: push_makes_no_tracking_ref" "remotes/origin/main" \
    "$(q "$src" "SELECT name FROM dolt_remote_branches;")"

  local c="$TMP/$label-clone.db"
  check_eq "$label: clone" "0" "$(q "$c" "SELECT dolt_clone('$url');")"
  check_eq "$label: clone_no_local_workspace" "main|0" \
    "$(q "$c" "SELECT name, (SELECT count(*) FROM dolt_workspaces) FROM dolt_branches;")"
  check_eq "$label: clone_no_tracking_workspace" "remotes/origin/main" \
    "$(q "$c" "SELECT name FROM dolt_remote_branches;")"
  if type dltest_expect_integrity >/dev/null 2>&1; then
    dltest_expect_integrity "$TMP/$label-lazy.db" 'skip:lazy clone holds no chunks'
  fi
  check_eq "$label: lazy_clone_no_workspace" "main|0" \
    "$(q "$TMP/$label-lazy.db" "SELECT dolt_clone('--lazy','$url');
SELECT name, (SELECT count(*) FROM dolt_workspaces) FROM dolt_branches;" | tail -1)"
  check_match "$label: clone_branch_workspace" "branch not found on remote" \
    "$(q "$TMP/$label-wsclone.db" "SELECT dolt_clone('--branch','workspaces:w1','$url');")"
  check_eq "$label: fetch_all_skips_workspace" $'0\n0\nremotes/origin/main|0' \
    "$(q "$c" "SELECT dolt_fetch('origin'); SELECT dolt_pull('origin');
SELECT name, (SELECT count(*) FROM dolt_workspaces) FROM dolt_remote_branches;")"
  check_match "$label: glob_fetch_skips_workspace" "^0
remotes/origin/main$" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/heads/*:refs/remotes/origin/*');
SELECT name FROM dolt_remote_branches;")"

  check_eq "$label: explicit_fetch" "0" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/w1');")"
  check_eq "$label: fetched_as_workspace" "w1|$w1" \
    "$(q "$c" "SELECT name, hash FROM dolt_workspaces;")"
  check_eq "$label: fetched_not_branch_or_tracking" "main|remotes/origin/main" \
    "$(q "$c" "SELECT (SELECT group_concat(name) FROM dolt_branches),
(SELECT group_concat(name) FROM dolt_remote_branches);")"
  check_eq "$label: fetched_workspace_opens" "2" \
    "$(q "$c@refs/workspaces/w1" "SELECT count(*) FROM t;")"
  check_match "$label: fetch_missing_workspace" "invalid ref spec" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/nope');")"

  w1=$(q "$src@refs/workspaces/w1" "INSERT INTO t VALUES(3); SELECT dolt_commit('-am','w2');")
  q "$src" "SELECT dolt_push('origin','refs/workspaces/w1');" >/dev/null
  check_eq "$label: fetch_fast_forwards" "$w1" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/w1');
SELECT hash FROM dolt_workspaces WHERE name='w1';" | tail -1)"

  q "$c@refs/workspaces/w1" "INSERT INTO t VALUES(20);" >/dev/null
  w1=$(q "$src@refs/workspaces/w1" "INSERT INTO t VALUES(5); SELECT dolt_commit('-am','w2b');")
  q "$src" "SELECT dolt_push('origin','refs/workspaces/w1');" >/dev/null
  check_match "$label: fetch_refuses_dirty_workspace" "uncommitted changes" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/w1');")"
  q "$c@refs/workspaces/w1" "DELETE FROM t WHERE id=20;" >/dev/null
  check_eq "$label: fetch_after_clean" "$w1" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/w1');
SELECT hash FROM dolt_workspaces WHERE name='w1';" | tail -1)"

  q "$c@refs/workspaces/w1" "INSERT INTO t VALUES(10); SELECT dolt_commit('-am','local');" >/dev/null
  q "$src@refs/workspaces/w1" "INSERT INTO t VALUES(4); SELECT dolt_commit('-am','w3');" >/dev/null
  q "$src" "SELECT dolt_push('origin','refs/workspaces/w1');" >/dev/null
  check_match "$label: fetch_refuses_diverged" "local workspace has commits" \
    "$(q "$c" "SELECT dolt_fetch('origin','refs/workspaces/w1');")"
  check_match "$label: push_refuses_non_ff" "not a fast-forward" \
    "$(q "$c" "SELECT dolt_push('origin','refs/workspaces/w1');")"
  check_eq "$label: force_push" "0" \
    "$(q "$c" "SELECT dolt_push('origin','refs/workspaces/w1','--force');")"

  check_eq "$label: push_src_dst" "0" \
    "$(q "$c" "SELECT dolt_push('origin','main:refs/workspaces/w2');")"
  check_eq "$label: remote_delete" "0" \
    "$(q "$c" "SELECT dolt_push('origin',':refs/workspaces/w2');")"
  check_match "$label: remote_delete_missing" "workspace not found" \
    "$(q "$c" "SELECT dolt_push('origin',':refs/workspaces/w2');")"
  check_eq "$label: local_workspace_kept_after_remote_delete" "w1" \
    "$(q "$c" "SELECT name FROM dolt_workspaces;")"
  q "$TMP/$label-probe1.db" "SELECT dolt_clone('$url');" >/dev/null
  check_match "$label: remote_workspace_deleted" "invalid ref spec" \
    "$(q "$TMP/$label-probe1.db" "SELECT dolt_fetch('origin','refs/workspaces/w2');")"
  check_eq "$label: remote_workspace_kept" $'0\nw1' \
    "$(q "$TMP/$label-probe1.db" "SELECT dolt_fetch('origin','refs/workspaces/w1');
SELECT group_concat(name) FROM dolt_workspaces;")"
}

remote_suite file "file://$TMP/remote.db"

check_eq "file: remote_lists_workspace" "main|w1" \
  "$(q "$TMP/remote.db" "SELECT (SELECT group_concat(name) FROM dolt_branches),
(SELECT group_concat(name) FROM dolt_workspaces);")"
check_match "file: push_workspace_to_empty_remote" \
  "cannot push a workspace to a remote with no branches" \
  "$(q "$TMP/file-src.db" "SELECT dolt_remote('add','empty','file://$TMP/empty.db');
SELECT dolt_push('empty','refs/workspaces/w1');")"

if [ -x "$REMOTESRV" ]; then
  mkdir -p "$TMP/srv"
  "$REMOTESRV" -p 0 --bind 127.0.0.1 "$TMP/srv" >"$TMP/srv.log" 2>&1 &
  SRV_PID=$!
  PORT=""
  for _ in $(seq 1 50); do
    PORT="$(sed -n 's#.*://127.0.0.1:\([0-9][0-9]*\).*#\1#p' "$TMP/srv.log" | head -1)"
    [ -n "$PORT" ] && break
    sleep 0.1
  done
  if [ -n "$PORT" ]; then
    remote_suite http "http://127.0.0.1:$PORT/repo.db"
  else
    FAIL=$((FAIL+1)); ERRORS="$ERRORS\nFAIL: remotesrv did not start"
  fi
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
if [ $FAIL -gt 0 ]; then
  printf "%b\n" "$ERRORS"
  exit 1
fi
echo "__SUITE_COMPLETE__"
