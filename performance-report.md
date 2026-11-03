# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-03 19:14 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41682452943)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.94s | 12.92s | 1.2× | 1.7% | **PASS** |
| Writes | 2.21s | 3.76s | 1.7× | 1.7% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 11.65s | 13.11s | 1.1× | 1.5% | **PASS** |
| Writes | 3.11s | 4.08s | 1.3× | 1.7% | **PASS** |
| Autocommit writes | 788.82ms | 2.52s | 3.2× | 5.8% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.69s | 2.95s | 1.1× | 1.8% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.63s | 3.28s | 1.2× | 1.7% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.64s | 3.28s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.98s | 3.42s | 1.1× | 1.7% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 458.10ms | 802.68ms | 1.8× | 2.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 580.58ms | 980.48ms | 1.7× | 1.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 551.04ms | 957.56ms | 1.7× | 0.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 615.88ms | 1.02s | 1.7× | 1.8% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.89s | 3.00s | 1.0× | 1.3% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.88s | 3.34s | 1.2× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.73s | 3.30s | 1.2× | 1.5% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.15s | 3.46s | 1.1× | 1.7% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 617.82ms | 853.77ms | 1.4× | 1.7% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 924.49ms | 1.09s | 1.2× | 3.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 789.27ms | 1.08s | 1.4× | 1.7% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 782.06ms | 1.07s | 1.4× | 1.9% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.73s | 3.01s | 1.1× | 1.5% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.72s | 3.34s | 1.2× | 1.7% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.60s | 3.30s | 1.3× | 1.8% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 3.08s | 3.49s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 190.88ms | 630.22ms | 3.3× | 6.0% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 203.70ms | 636.91ms | 3.1× | 7.0% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 202.35ms | 635.51ms | 3.1× | 5.4% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 191.88ms | 620.71ms | 3.2× | 5.1% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.89ms | 32.84ms | 1.3× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 12.04ms | 13.58ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 10.78ms | 13.15ms | 1.2× | 3.9% | PASS |
| mem_reads | `oltp_order_range` | 2.78ms | 3.37ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 3.78ms | 4.67ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_index_scan` | 4.10ms | 6.10ms | 1.5× | 1.8% | PASS |
| mem_reads | `select_random_points` | 11.26ms | 12.54ms | 1.1× | 5.1% | PASS |
| mem_reads | `select_random_ranges` | 4.83ms | 5.56ms | 1.2× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 8.12ms | 11.52ms | 1.4× | 1.4% | PASS |
| mem_reads | `groupby_scan` | 31.23ms | 36.01ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 5.95ms | 9.55ms | 1.6× | 2.6% | PASS |
| mem_reads | `index_join_scan` | 3.54ms | 6.21ms | 1.8× | 3.3% | PASS |
| mem_reads | `types_table_scan` | 1.14s | 1.29s | 1.1× | 1.6% | PASS |
| mem_reads | `table_scan` | 1.31s | 1.37s | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 116.32ms | 135.15ms | 1.2× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.93ms | 304.12ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 15.22ms | 27.37ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 52.80ms | 102.81ms | 1.9× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 38.35ms | 69.02ms | 1.8× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 47.71ms | 83.40ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_write_only` | 24.85ms | 54.44ms | 2.2× | 2.2% | PASS |
| mem_writes | `types_delete_insert` | 26.31ms | 40.34ms | 1.5× | 2.5% | PASS |
| mem_writes | `oltp_read_write` | 76.92ms | 121.18ms | 1.6× | 2.7% | PASS |
| file_reads | `oltp_point_select` | 94.73ms | 50.25ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 19.97ms | 15.56ms | 0.8× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 18.33ms | 14.87ms | 0.8× | 2.6% | PASS |
| file_reads | `oltp_order_range` | 4.23ms | 3.98ms | 0.9× | 2.7% | PASS |
| file_reads | `oltp_distinct_range` | 4.98ms | 4.94ms | 1.0× | 2.5% | PASS |
| file_reads | `oltp_index_scan` | 11.30ms | 7.74ms | 0.7× | 1.3% | PASS |
| file_reads | `select_random_points` | 18.55ms | 14.36ms | 0.8× | 2.6% | PASS |
| file_reads | `select_random_ranges` | 11.90ms | 7.34ms | 0.6× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.83ms | 13.26ms | 0.8× | 1.4% | PASS |
| file_reads | `groupby_scan` | 32.57ms | 36.33ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 10.15ms | 10.48ms | 1.0× | 1.3% | PASS |
| file_reads | `index_join_scan` | 4.49ms | 6.30ms | 1.4× | 3.4% | PASS |
| file_reads | `types_table_scan` | 1.13s | 1.28s | 1.1× | 0.9% | PASS |
| file_reads | `table_scan` | 1.29s | 1.38s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 215.19ms | 160.08ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 189.20ms | 317.40ms | 1.7× | 0.7% | PASS |
| file_writes | `oltp_insert` | 22.70ms | 30.83ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 83.07ms | 113.58ms | 1.4× | 1.9% | PASS |
| file_writes | `oltp_update_non_index` | 61.74ms | 73.61ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 71.29ms | 93.10ms | 1.3× | 1.6% | PASS |
| file_writes | `oltp_write_only` | 47.58ms | 56.30ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 41.53ms | 45.61ms | 1.1× | 1.1% | PASS |
| file_writes | `oltp_read_write` | 100.71ms | 123.34ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_point_select` | 47.97ms | 49.76ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 14.64ms | 15.27ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_sum_range` | 13.13ms | 14.61ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.36ms | 3.56ms | 1.1× | 2.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.34ms | 4.77ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.85ms | 7.82ms | 1.1× | 1.5% | PASS |
| ac_reads | `select_random_points` | 13.72ms | 14.26ms | 1.0× | 3.7% | PASS |
| ac_reads | `select_random_ranges` | 7.37ms | 7.39ms | 1.0× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 11.16ms | 13.14ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 31.75ms | 36.02ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.92ms | 10.57ms | 1.3× | 1.9% | PASS |
| ac_reads | `index_join_scan` | 3.98ms | 6.34ms | 1.6× | 2.8% | PASS |
| ac_reads | `types_table_scan` | 1.12s | 1.28s | 1.1× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.30s | 1.38s | 1.1× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 146.90ms | 159.74ms | 1.1× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.16ms | 63.99ms | 3.2× | 5.7% | PASS |
| ac_writes | `oltp_insert_ac` | 23.62ms | 76.70ms | 3.2× | 5.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.36ms | 94.70ms | 3.6× | 6.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.50ms | 71.48ms | 3.2× | 6.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.33ms | 82.56ms | 3.4× | 6.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.92ms | 81.23ms | 3.4× | 6.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.07ms | 71.90ms | 3.4× | 8.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.93ms | 87.66ms | 3.0× | 4.4% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.55ms | 40.47ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 16.77ms | 16.71ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 15.32ms | 16.06ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.33ms | 3.60ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.28ms | 4.73ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.95ms | 6.75ms | 1.7× | 1.8% | PASS |
| mem_reads | `select_random_points` | 22.04ms | 22.35ms | 1.0× | 2.9% | PASS |
| mem_reads | `select_random_ranges` | 6.66ms | 7.00ms | 1.1× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 7.98ms | 11.20ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 34.64ms | 37.65ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 10.64ms | 10.59ms | 1.0× | 1.8% | PASS |
| mem_reads | `index_join_scan` | 3.78ms | 6.62ms | 1.7× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.0% | PASS |
| mem_reads | `table_scan` | 1.23s | 1.52s | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 136.87ms | 153.02ms | 1.1× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 232.97ms | 362.04ms | 1.6× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 17.44ms | 36.91ms | 2.1× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 65.68ms | 139.58ms | 2.1× | 2.0% | PASS |
| mem_writes | `oltp_update_non_index` | 47.97ms | 82.53ms | 1.7× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 53.80ms | 103.80ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 27.77ms | 55.20ms | 2.0× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 38.68ms | 60.07ms | 1.6× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 96.27ms | 140.34ms | 1.5× | 1.7% | PASS |
| file_reads | `oltp_point_select` | 105.76ms | 58.93ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 24.51ms | 18.93ms | 0.8× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 22.86ms | 18.18ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 4.22ms | 3.87ms | 0.9× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.28ms | 5.06ms | 1.0× | 1.8% | PASS |
| file_reads | `oltp_index_scan` | 11.16ms | 8.78ms | 0.8× | 2.0% | PASS |
| file_reads | `select_random_points` | 30.85ms | 25.37ms | 0.8× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 14.20ms | 9.09ms | 0.6× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 15.36ms | 13.28ms | 0.9× | 1.1% | PASS |
| file_reads | `groupby_scan` | 35.78ms | 38.15ms | 1.1× | 0.5% | PASS |
| file_reads | `index_join` | 14.85ms | 12.01ms | 0.8× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.72ms | 7.07ms | 1.5× | 2.3% | PASS |
| file_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.4% | PASS |
| file_reads | `table_scan` | 1.25s | 1.52s | 1.2× | 1.7% | PASS |
| file_reads | `oltp_read_only` | 242.87ms | 182.28ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 257.66ms | 377.26ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.12ms | 42.61ms | 1.7× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 127.77ms | 159.44ms | 1.2× | 10.3% | PASS |
| file_writes | `oltp_update_non_index` | 107.23ms | 96.86ms | 0.9× | 8.7% | PASS |
| file_writes | `oltp_delete_insert` | 95.98ms | 120.74ms | 1.3× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 86.59ms | 68.19ms | 0.8× | 17.6% | PASS |
| file_writes | `types_delete_insert` | 71.94ms | 69.45ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 152.21ms | 153.00ms | 1.0× | 4.8% | PASS |
| ac_reads | `oltp_point_select` | 58.81ms | 58.69ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 19.91ms | 18.85ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 18.27ms | 18.15ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_order_range` | 3.80ms | 3.88ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 4.80ms | 5.06ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.55ms | 8.84ms | 1.3× | 1.8% | PASS |
| ac_reads | `select_random_points` | 25.86ms | 25.54ms | 1.0× | 2.9% | PASS |
| ac_reads | `select_random_ranges` | 9.41ms | 9.07ms | 1.0× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 10.71ms | 13.28ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 35.32ms | 38.20ms | 1.1× | 1.0% | PASS |
| ac_reads | `index_join` | 12.71ms | 12.00ms | 0.9× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 4.31ms | 7.10ms | 1.6× | 2.7% | PASS |
| ac_reads | `types_table_scan` | 1.10s | 1.41s | 1.3× | 1.2% | PASS |
| ac_reads | `table_scan` | 1.24s | 1.52s | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 172.23ms | 182.19ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.47ms | 64.32ms | 2.7× | 8.0% | PASS |
| ac_writes | `oltp_insert_ac` | 25.43ms | 76.35ms | 3.0× | 5.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.67ms | 95.19ms | 3.6× | 7.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.71ms | 73.13ms | 3.4× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.27ms | 85.97ms | 3.3× | 8.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.38ms | 81.24ms | 3.2× | 5.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.01ms | 72.62ms | 3.2× | 7.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.76ms | 88.08ms | 2.8× | 6.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 31.56ms | 40.18ms | 1.3× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 16.00ms | 16.66ms | 1.0× | 2.8% | PASS |
| mem_reads | `oltp_sum_range` | 13.48ms | 16.23ms | 1.2× | 3.9% | PASS |
| mem_reads | `oltp_order_range` | 3.05ms | 3.54ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.07ms | 4.73ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.71ms | 6.78ms | 1.8× | 1.2% | PASS |
| mem_reads | `select_random_points` | 20.58ms | 22.83ms | 1.1× | 2.4% | PASS |
| mem_reads | `select_random_ranges` | 6.30ms | 7.07ms | 1.1× | 2.8% | PASS |
| mem_reads | `covering_index_scan` | 7.92ms | 11.23ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 33.44ms | 37.67ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 9.23ms | 10.85ms | 1.2× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 3.32ms | 6.64ms | 2.0× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.40s | 1.3× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.28s | 1.53s | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_read_only` | 141.38ms | 155.45ms | 1.1× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 231.06ms | 355.90ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 17.60ms | 36.48ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 59.97ms | 134.38ms | 2.2× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 43.69ms | 78.87ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_delete_insert` | 49.07ms | 100.05ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 25.83ms | 54.66ms | 2.1× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 35.11ms | 57.33ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 88.72ms | 139.89ms | 1.6× | 0.6% | PASS |
| file_reads | `oltp_point_select` | 100.35ms | 57.53ms | 0.6× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 24.14ms | 18.86ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 21.67ms | 18.33ms | 0.8× | 3.1% | PASS |
| file_reads | `oltp_order_range` | 4.13ms | 3.88ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 5.10ms | 5.05ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 10.62ms | 8.69ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_points` | 28.13ms | 25.36ms | 0.9× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 13.09ms | 8.94ms | 0.7× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 14.99ms | 13.18ms | 0.9× | 1.4% | PASS |
| file_reads | `groupby_scan` | 35.02ms | 38.17ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 13.30ms | 12.21ms | 0.9× | 1.5% | PASS |
| file_reads | `index_join_scan` | 4.44ms | 7.03ms | 1.6× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.40s | 1.3× | 0.6% | PASS |
| file_reads | `table_scan` | 1.17s | 1.50s | 1.3× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 230.23ms | 179.18ms | 0.8× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 249.87ms | 371.50ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 24.75ms | 42.17ms | 1.7× | 0.9% | PASS |
| file_writes | `oltp_update_index` | 96.59ms | 155.64ms | 1.6× | 1.6% | PASS |
| file_writes | `oltp_update_non_index` | 93.65ms | 96.07ms | 1.0× | 14.2% | PASS |
| file_writes | `oltp_delete_insert` | 85.09ms | 118.04ms | 1.4× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 56.30ms | 68.61ms | 1.2× | 2.4% | PASS |
| file_writes | `types_delete_insert` | 60.58ms | 68.50ms | 1.1× | 1.8% | PASS |
| file_writes | `oltp_read_write` | 122.42ms | 154.68ms | 1.3× | 1.1% | PASS |
| ac_reads | `oltp_point_select` | 57.07ms | 58.03ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_range_select` | 18.89ms | 18.57ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_sum_range` | 17.28ms | 18.32ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_order_range` | 3.78ms | 3.85ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_distinct_range` | 4.76ms | 5.06ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.32ms | 8.74ms | 1.4× | 2.1% | PASS |
| ac_reads | `select_random_points` | 23.68ms | 25.78ms | 1.1× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 8.83ms | 8.96ms | 1.0× | 1.8% | PASS |
| ac_reads | `covering_index_scan` | 10.50ms | 13.24ms | 1.3× | 1.2% | PASS |
| ac_reads | `groupby_scan` | 34.87ms | 38.31ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 12.35ms | 12.41ms | 1.0× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 4.22ms | 7.14ms | 1.7× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.40s | 1.3× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.50s | 1.3× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 179.29ms | 184.35ms | 1.0× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.70ms | 64.09ms | 2.8× | 6.4% | PASS |
| ac_writes | `oltp_insert_ac` | 25.24ms | 79.59ms | 3.2× | 4.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.00ms | 92.04ms | 3.5× | 5.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.00ms | 72.03ms | 3.1× | 5.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.71ms | 81.55ms | 3.2× | 6.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.30ms | 81.14ms | 3.3× | 4.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.78ms | 73.60ms | 3.1× | 6.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.62ms | 91.46ms | 2.9× | 4.7% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.97ms | 43.93ms | 1.3× | 2.7% | PASS |
| mem_reads | `oltp_range_select` | 21.22ms | 23.90ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 18.04ms | 22.86ms | 1.3× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 3.77ms | 4.37ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.84ms | 5.61ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_index_scan` | 4.84ms | 7.08ms | 1.5× | 2.1% | PASS |
| mem_reads | `select_random_points` | 28.75ms | 34.75ms | 1.2× | 2.7% | PASS |
| mem_reads | `select_random_ranges` | 7.92ms | 9.56ms | 1.2× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 8.10ms | 11.50ms | 1.4× | 1.6% | PASS |
| mem_reads | `groupby_scan` | 37.54ms | 43.90ms | 1.2× | 0.8% | PASS |
| mem_reads | `index_join` | 8.24ms | 12.59ms | 1.5× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 4.28ms | 7.07ms | 1.7× | 4.7% | PASS |
| mem_reads | `types_table_scan` | 1.22s | 1.45s | 1.2× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.43s | 1.55s | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_read_only` | 155.91ms | 187.25ms | 1.2× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 240.77ms | 354.66ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.81ms | 35.12ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 72.25ms | 139.50ms | 1.9× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 55.55ms | 95.22ms | 1.7× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 54.22ms | 105.61ms | 1.9× | 1.7% | PASS |
| mem_writes | `oltp_write_only` | 29.80ms | 62.99ms | 2.1× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 33.93ms | 58.54ms | 1.7× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 110.56ms | 170.44ms | 1.5× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 104.91ms | 61.70ms | 0.6× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 29.46ms | 26.32ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 26.72ms | 25.33ms | 0.9× | 1.8% | PASS |
| file_reads | `oltp_order_range` | 4.93ms | 4.73ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.99ms | 5.94ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_index_scan` | 12.36ms | 8.93ms | 0.7× | 1.5% | PASS |
| file_reads | `select_random_points` | 37.48ms | 37.49ms | 1.0× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 15.58ms | 11.71ms | 0.8× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 16.33ms | 13.53ms | 0.8× | 2.3% | PASS |
| file_reads | `groupby_scan` | 38.94ms | 44.21ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 12.83ms | 13.94ms | 1.1× | 2.5% | PASS |
| file_reads | `index_join_scan` | 5.40ms | 7.45ms | 1.4× | 3.5% | PASS |
| file_reads | `types_table_scan` | 1.15s | 1.43s | 1.2× | 3.1% | PASS |
| file_reads | `table_scan` | 1.43s | 1.55s | 1.1× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 268.21ms | 220.50ms | 0.8× | 1.5% | PASS |
| file_writes | `oltp_bulk_insert` | 256.02ms | 368.10ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 26.78ms | 39.01ms | 1.5× | 3.1% | PASS |
| file_writes | `oltp_update_index` | 100.45ms | 144.44ms | 1.4× | 1.9% | PASS |
| file_writes | `oltp_update_non_index` | 79.53ms | 97.86ms | 1.2× | 1.3% | PASS |
| file_writes | `oltp_delete_insert` | 78.82ms | 111.51ms | 1.4× | 2.2% | PASS |
| file_writes | `oltp_write_only` | 54.57ms | 68.34ms | 1.3× | 2.7% | PASS |
| file_writes | `types_delete_insert` | 51.87ms | 64.26ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 134.03ms | 174.27ms | 1.3× | 2.0% | PASS |
| ac_reads | `oltp_point_select` | 57.23ms | 60.93ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 23.79ms | 26.01ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_sum_range` | 20.89ms | 24.90ms | 1.2× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 4.35ms | 4.74ms | 1.1× | 2.8% | PASS |
| ac_reads | `oltp_distinct_range` | 5.43ms | 5.97ms | 1.1× | 3.2% | PASS |
| ac_reads | `oltp_index_scan` | 7.45ms | 8.77ms | 1.2× | 2.7% | PASS |
| ac_reads | `select_random_points` | 31.69ms | 36.66ms | 1.2× | 3.6% | PASS |
| ac_reads | `select_random_ranges` | 10.53ms | 11.58ms | 1.1× | 2.5% | PASS |
| ac_reads | `covering_index_scan` | 11.25ms | 13.41ms | 1.2× | 2.1% | PASS |
| ac_reads | `groupby_scan` | 38.11ms | 44.10ms | 1.2× | 0.9% | PASS |
| ac_reads | `index_join` | 10.17ms | 13.74ms | 1.4× | 2.4% | PASS |
| ac_reads | `index_join_scan` | 4.67ms | 7.26ms | 1.6× | 3.1% | PASS |
| ac_reads | `types_table_scan` | 1.20s | 1.45s | 1.2× | 0.9% | PASS |
| ac_reads | `table_scan` | 1.45s | 1.56s | 1.1× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 201.92ms | 223.95ms | 1.1× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.99ms | 62.75ms | 3.0× | 4.6% | PASS |
| ac_writes | `oltp_insert_ac` | 23.18ms | 76.98ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.72ms | 90.10ms | 3.4× | 4.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.47ms | 70.84ms | 3.3× | 6.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.16ms | 80.47ms | 3.3× | 5.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.43ms | 79.15ms | 3.4× | 4.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.75ms | 71.35ms | 3.4× | 6.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.18ms | 89.07ms | 2.9× | 5.2% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 24s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 19.42ms | 38.00ms | 51.1% | 1.2% | PASS |
| `status_dirty_many_tables` | 21.43ms | 42.00ms | 51.0% | 0.8% | PASS |
| `diff_regular_working_one_table` | 16.84ms | 33.00ms | 51.0% | 1.3% | PASS |
| `diff_regular_working_many_tables` | 23.38ms | 50.00ms | 46.8% | 1.1% | PASS |
| `diff_stat_working_many_tables` | 23.36ms | 48.00ms | 48.7% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 23.63ms | 48.00ms | 49.2% | 0.9% | PASS |
| `branch_list_many_branches` | 12.52ms | 25.00ms | 50.1% | 1.2% | PASS |
| `branch_create_delete` | 13.62ms | 27.00ms | 50.5% | 1.0% | PASS |
| `at_literal_deep_history` | 13.84ms | 28.00ms | 49.4% | 1.6% | PASS |
| `diff_literal_deep_history` | 13.79ms | 28.00ms | 49.2% | 0.9% | PASS |
| `history_literal_deep_history` | 14.62ms | 30.00ms | 48.7% | 1.0% | PASS |
| `checkout_branch_clean` | 18.89ms | 43.00ms | 43.9% | 1.1% | PASS |
| `merge_data_no_conflicts` | 16.07ms | 33.00ms | 48.7% | 1.4% | PASS |
| `merge_data_secondary_index` | 612.69ms | 944.00ms | 64.9% | 1.3% | PASS |
| `merge_schema_no_conflicts` | 11.62ms | 24.00ms | 48.4% | 1.0% | PASS |
| `merge_data_conflicts` | 17.85ms | 33.00ms | 54.1% | 1.1% | PASS |
| `merge_data_conflicts_with_resolve` | 18.33ms | 34.00ms | 53.9% | 0.8% | PASS |

Version-control ceiling result: **PASS**.

## File remote performance

Status: passed. Transport: local file-backed remote.

100,000,000 logical payload bytes; 100,000 rows; 1,000 changed rows; 5 repetitions per operation and binary.

SQL timings exclude fixture generation, copies, database open and verification. Each SQL sample uses a fresh process with the OS cache primed by setup verification. SQL client cache: 65,536 KiB. copy_fsync times shutil.copyfile plus fsync.

Throughput uses logical payload bytes; destination growth is file-size change, not transferred bytes.

Nightly median ceilings require three-attempt confirmation; copy_fsync is a control.

| Operation | Ceiling ms | Result |
|---|---:|---|
| push_initial | 2000 | PASS |
| clone_initial | 3000 | PASS |
| push_noop | 10 | PASS |
| fetch_noop | 10 | PASS |
| push_incremental | 750 | PASS |
| fetch_incremental | 300 | PASS |
| pull_fast_forward | 300 | PASS |

Timing gate: PASS after 1 attempt(s).

candidate: 3dd9504.

Fixture file bytes: base 107,968,266; delta 115,878,997.

| Operation | Binary | Median ms | Min–max ms | CPU ms | Payload MB/s | Destination growth bytes |
|---|---|---:|---:|---:|---:|---:|
| copy_fsync | candidate | 405.660 | 402.226–506.096 | 31.156 | 246.51 | 107968266 |
| push_initial | candidate | 727.974 | 724.589–734.776 | 356.314 | 137.37 | 107956772 |
| clone_initial | candidate | 827.096 | 824.197–841.152 | 464.082 | 120.90 | 108475035 |
| push_noop | candidate | 0.524 | 0.508–0.571 | 0.285 | — | 0 |
| fetch_noop | candidate | 0.140 | 0.137–0.149 | 0.141 | — | 0 |
| push_incremental | candidate | 167.509 | 162.765–192.747 | 150.065 | 5.97 | 7909775 |
| fetch_incremental | candidate | 82.999 | 79.393–91.404 | 63.435 | 12.05 | 7910084 |
| pull_fast_forward | candidate | 70.341 | 69.293–73.833 | 53.839 | 14.22 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.54 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.78 | 295.012 | 109.784 | 47223 | 2337 |
| push_noop | candidate | 45.97 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.97 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.97 | 96.866 | 7.910 | 22413 | 125 |
| fetch_incremental | candidate | 45.97 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.97 | 26.497 | 7.911 | 7031 | 126 |

</details>


<details>
<summary>1 GB file remotes (observational)</summary>

Both database sizes use a fixed 1 MB scattered update and a warm OS cache. 1 GB timings have no ceiling while a baseline is collected.

### 1 GB file remote performance

Status: passed. Transport: local file-backed remote.

1,000,000,000 logical payload bytes; 1,000,000 rows; 1,000 changed rows; 3 repetitions per operation and binary.

SQL timings exclude fixture generation, copies, database open and verification. Each SQL sample uses a fresh process with the OS cache primed by setup verification. SQL client cache: 65,536 KiB. copy_fsync times shutil.copyfile plus fsync.

Throughput uses logical payload bytes; destination growth is file-size change, not transferred bytes.

No speed thresholds are enforced.

candidate: 3dd9504.

Fixture file bytes: base 1,087,718,031; delta 1,103,525,159.

| Operation | Binary | Median ms | Min–max ms | CPU ms | Payload MB/s | Destination growth bytes |
|---|---|---:|---:|---:|---:|---:|
| copy_fsync | candidate | 2657.349 | 2647.228–2686.083 | 376.901 | 376.31 | 1087718031 |
| push_initial | candidate | 8093.490 | 8035.915–8108.740 | 5847.435 | 123.56 | 1079566275 |
| clone_initial | candidate | 8732.432 | 8731.605–8755.126 | 8546.762 | 114.52 | 1102407326 |
| push_noop | candidate | 0.734 | 0.695–0.799 | 0.338 | — | 0 |
| fetch_noop | candidate | 0.232 | 0.201–0.243 | 0.234 | — | 0 |
| push_incremental | candidate | 1295.306 | 1285.245–1299.273 | 1291.142 | 0.77 | 15806003 |
| fetch_incremental | candidate | 272.743 | 271.429–274.727 | 266.432 | 3.67 | 15806513 |
| pull_fast_forward | candidate | 267.346 | 266.773–269.388 | 261.930 | 3.74 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.87 | 2091.380 | 1087.622 | 263376 | 20541 |
| clone_initial | candidate | 123.85 | 3522.742 | 1132.819 | 613538 | 32243 |
| push_noop | candidate | 47.12 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.12 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.25 | 619.282 | 15.928 | 150425 | 313 |
| fetch_incremental | candidate | 50.44 | 61.553 | 15.928 | 13729 | 313 |
| pull_fast_forward | candidate | 50.41 | 61.486 | 15.929 | 13725 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
