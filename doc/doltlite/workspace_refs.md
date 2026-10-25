# Workspace refs: dolt_workspace and dolt_workspaces

A workspace is a named ref that points at a commit, kept apart from branches.
DoltHub uses them for edits in progress: it creates one from a branch head,
commits each SQL edit to it, then fast-forwards a branch to it or branches
from it, and deletes it. Dolt stores them as `refs/workspaces/<name>`.

Not to be confused with [dolt_workspace_<table>](dolt_workspace.md), which
shows a table's uncommitted changes.

## Synopsis

```sql
SELECT dolt_workspace('edit-1');                       -- at HEAD
SELECT dolt_workspace('edit-2', 'v1.0');               -- at a commit revision
SELECT * FROM dolt_workspaces;
SELECT count(*) FROM dolt_log('refs/workspaces/edit-1');
SELECT dolt_branch('from-edit', 'refs/workspaces/edit-1');
SELECT dolt_workspace('-d', 'edit-2');
```

Open a workspace by path to edit it. The connection is read-write and holds
the workspace's own working set, exactly as a branch open does; each
`dolt_commit` moves the workspace ref:

```
doltlite 'my.db@refs/workspaces/edit-1'
doltlite my.db/refs/workspaces/edit-1
```

Then, from a branch connection:

```
SELECT dolt_merge('refs/workspaces/edit-1');               -- fast-forward main
SELECT dolt_branch('-f', 'release', 'refs/workspaces/edit-1');
SELECT dolt_workspace('-d', 'edit-1');
```

## Functions

| Function | Arguments | Notes |
|---|---|---|
| `dolt_workspace` | `name [, rev]` | Create a workspace at a commit revision (default `HEAD`). The name follows the branch [name rules](refs.md#names) and may not be an existing branch's name, as in Dolt |
| `dolt_workspace` | `'-d' \| '--delete', name` | Delete a workspace. It does not have to be merged anywhere |

Both return `0`. Like branch changes, they are durable immediately, even
inside `BEGIN`.

| Error | Cause |
|---|---|
| `workspace name required` | no name, or an empty one |
| `invalid workspace name` | name rule violation |
| `workspace already exists` | create of an existing workspace |
| `workspace name must not be existing branch name` | a branch has that name |
| `start point not found` | the revision does not resolve |
| `workspace not found` | delete of an unknown workspace |
| `cannot delete the current workspace` | delete from a connection opened on it |

## dolt_workspaces

Same columns as `dolt_remote_branches`: `name`, `hash`,
`latest_committer`, `latest_committer_email`, `latest_commit_date`,
`latest_commit_message`. `name` is the workspace name without any prefix.

## Revisions

`refs/workspaces/<name>` is a commit revision everywhere one is accepted:
`dolt_log`, diffs, `dolt_merge`, `dolt_branch(name, rev)`,
`dolt_checkout('-b', name, rev)`, `dolt_tag`, `dolt_reset`, and the
`db@rev` / `db/rev` path opens in [refs.md](refs.md). A path open gives a
read-write connection on the workspace; `active_branch()` there returns the
stored name, `workspaces:<name>`. `dolt_checkout('refs/workspaces/<name>')`
is refused like a tag checkout. Open the workspace by path instead.

## Remotes

| Call | Effect |
|---|---|
| `dolt_push(remote, 'refs/workspaces/<name>' [, '--force'])` | Pushes the workspace. It lands on the remote as the same workspace. Non-fast-forward needs `--force`. No tracking ref is written |
| `dolt_push(remote, 'src:refs/workspaces/<name>')` | Pushes revision `src` as that remote workspace |
| `dolt_push(remote, ':refs/workspaces/<name>')` | Deletes the remote workspace. The local one stays |
| `dolt_fetch(remote, 'refs/workspaces/<name>')` | Creates or fast-forwards the local workspace of that name |

Everything else leaves workspaces alone. `dolt_push('--all')` skips them.
`dolt_clone` (including `--lazy` and `--single-branch`), `dolt_fetch` with
no refspec or a glob, and `dolt_pull` never create a local workspace, a
local branch, or a tracking ref from a remote workspace. Neither
`dolt_branches` nor `dolt_remote_branches` lists them.

| Error | Cause |
|---|---|
| `cannot push a workspace to a remote with no branches` | a remote's refs must hold its default branch, and a workspace never becomes one |
| `failed to delete remote; 'refs/workspaces/<name>' from remote '<remote>'; workspace not found` | `:refs/workspaces/<name>` names nothing on the remote |
| `fetch failed: local workspace has commits the remote does not` | the local workspace is not an ancestor of the remote one |
| `fetch failed: local workspace has uncommitted changes` | a connection left uncommitted edits on the local workspace |
| `fetch failed: invalid ref spec: '<spec>'` | the remote has no such workspace |

## Storage

A workspace is an ordinary branch entry in the refs blob, named
`workspaces:<name>`. `:` is illegal in branch and tag names, so no user ref
can take that name, and the refs format is unchanged: older DoltLite builds
read such a database and see a branch with an odd name. The branch
commands refuse the reserved names: `dolt_branch` cannot create, copy,
rename, or delete them, `dolt_checkout` cannot switch to or create one, and
`dolt_default_branch` cannot choose one. A workspace never becomes a
remote's default branch.

## See also

[dolt_branch.md](dolt_branch.md), [dolt_remote.md](dolt_remote.md),
[refs.md](refs.md), `test/doltlite_workspace_refs.sh`.
