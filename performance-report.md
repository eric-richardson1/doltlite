# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-17 20:32 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.196.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/44150939125)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.56s | 9.78s | 1.1× | 1.5% | **PASS** |
| Writes | 1.71s | 2.78s | 1.6× | 1.6% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.52s | 10.03s | 1.1× | 1.3% | **PASS** |
| Writes | 3.96s | 4.17s | 1.1× | 4.0% | **PASS** |
| Autocommit writes | 771.82ms | 2.49s | 3.2× | 16.3% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.44s | 2.89s | 1.2× | 1.4% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.83s | 2.01s | 1.1× | 2.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.11s | 2.42s | 1.1× | 1.3% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.18s | 2.46s | 1.1× | 1.3% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 434.09ms | 765.07ms | 1.8× | 0.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 359.41ms | 581.94ms | 1.6× | 2.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 455.75ms | 707.11ms | 1.6× | 1.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 455.79ms | 722.55ms | 1.6× | 1.7% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.67s | 2.95s | 1.1× | 1.1% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 1.96s | 2.03s | 1.0× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.46s | 2.54s | 1.0× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.42s | 2.52s | 1.0× | 1.1% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 590.33ms | 826.15ms | 1.4× | 1.6% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.15s | 1.08s | 0.9× | 5.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.16s | 1.16s | 1.0× | 3.0% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.06s | 1.10s | 1.0× | 6.9% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.52s | 2.96s | 1.2× | 1.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 1.89s | 2.04s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.18s | 2.47s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.49s | 2.57s | 1.0× | 1.0% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 184.37ms | 610.83ms | 3.3× | 5.7% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 248.98ms | 715.62ms | 2.9× | 26.4% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 160.22ms | 536.25ms | 3.3× | 9.7% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 178.25ms | 629.00ms | 3.5× | 25.5% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.78ms | 31.45ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 10.66ms | 12.87ms | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 9.45ms | 12.18ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 2.61ms | 3.10ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.59ms | 4.31ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.81ms | 5.63ms | 1.5× | 1.5% | PASS |
| mem_reads | `select_random_points` | 9.71ms | 11.91ms | 1.2× | 2.3% | PASS |
| mem_reads | `select_random_ranges` | 4.60ms | 5.42ms | 1.2× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 7.94ms | 10.79ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 30.62ms | 34.90ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 5.76ms | 8.80ms | 1.5× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 3.30ms | 5.78ms | 1.8× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.35s | 1.2× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 103.85ms | 129.94ms | 1.3× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 176.39ms | 299.81ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.93ms | 26.78ms | 1.8× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 49.63ms | 97.35ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_update_non_index` | 34.48ms | 63.65ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 43.89ms | 77.85ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 21.50ms | 47.86ms | 2.2× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 24.49ms | 37.69ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 68.78ms | 114.07ms | 1.7× | 2.5% | PASS |
| file_reads | `oltp_point_select` | 93.06ms | 49.11ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 18.13ms | 14.79ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 17.11ms | 14.27ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 3.47ms | 3.37ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 4.46ms | 4.59ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 10.98ms | 7.68ms | 0.7× | 1.1% | PASS |
| file_reads | `select_random_points` | 17.74ms | 13.96ms | 0.8× | 2.4% | PASS |
| file_reads | `select_random_ranges` | 11.65ms | 7.33ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.20ms | 12.98ms | 0.9× | 0.9% | PASS |
| file_reads | `groupby_scan` | 31.60ms | 35.28ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 9.66ms | 10.28ms | 1.1× | 1.2% | PASS |
| file_reads | `index_join_scan` | 4.25ms | 6.02ms | 1.4× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.18s | 1.36s | 1.2× | 0.9% | PASS |
| file_reads | `oltp_read_only` | 204.10ms | 156.47ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 189.39ms | 311.90ms | 1.6× | 0.9% | PASS |
| file_writes | `oltp_insert` | 21.43ms | 30.13ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 77.31ms | 107.34ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_update_non_index` | 58.27ms | 70.10ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_delete_insert` | 66.47ms | 88.64ms | 1.3× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 43.94ms | 54.26ms | 1.2× | 1.7% | PASS |
| file_writes | `types_delete_insert` | 39.85ms | 44.06ms | 1.1× | 1.8% | PASS |
| file_writes | `oltp_read_write` | 93.68ms | 119.72ms | 1.3× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 46.17ms | 49.02ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 13.63ms | 14.85ms | 1.1× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 12.18ms | 14.18ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 2.93ms | 3.38ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 3.92ms | 4.59ms | 1.2× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 6.25ms | 7.67ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_points` | 12.56ms | 13.96ms | 1.1× | 2.5% | PASS |
| ac_reads | `select_random_ranges` | 6.97ms | 7.33ms | 1.1× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 10.44ms | 12.95ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 31.14ms | 35.31ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 7.22ms | 10.36ms | 1.4× | 1.7% | PASS |
| ac_reads | `index_join_scan` | 3.73ms | 6.06ms | 1.6× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.17s | 1.36s | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 137.70ms | 157.22ms | 1.1× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.00ms | 64.73ms | 3.1× | 5.5% | PASS |
| ac_writes | `oltp_insert_ac` | 22.55ms | 75.95ms | 3.4× | 5.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.44ms | 86.68ms | 3.5× | 5.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.71ms | 69.85ms | 3.4× | 7.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.93ms | 78.12ms | 3.4× | 5.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.75ms | 79.94ms | 3.4× | 7.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.41ms | 70.98ms | 3.3× | 9.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.59ms | 84.59ms | 3.1× | 5.9% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.23ms | 24.49ms | 1.0× | 3.3% | PASS |
| mem_reads | `oltp_range_select` | 11.55ms | 10.19ms | 0.9× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 11.28ms | 10.11ms | 0.9× | 2.9% | PASS |
| mem_reads | `oltp_order_range` | 2.46ms | 2.32ms | 0.9× | 2.2% | PASS |
| mem_reads | `oltp_distinct_range` | 2.95ms | 2.82ms | 1.0× | 1.9% | PASS |
| mem_reads | `oltp_index_scan` | 2.67ms | 4.66ms | 1.7× | 1.7% | PASS |
| mem_reads | `select_random_points` | 17.86ms | 15.48ms | 0.9× | 3.9% | PASS |
| mem_reads | `select_random_ranges` | 4.89ms | 4.33ms | 0.9× | 2.5% | PASS |
| mem_reads | `covering_index_scan` | 4.20ms | 6.62ms | 1.6× | 1.9% | PASS |
| mem_reads | `groupby_scan` | 23.15ms | 23.98ms | 1.0× | 1.4% | PASS |
| mem_reads | `index_join` | 8.46ms | 7.76ms | 0.9× | 5.1% | PASS |
| mem_reads | `index_join_scan` | 3.06ms | 5.96ms | 2.0× | 4.9% | PASS |
| mem_reads | `types_table_scan` | 811.28ms | 894.75ms | 1.1× | 2.8% | PASS |
| mem_reads | `table_scan` | 822.46ms | 915.17ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 79.21ms | 80.22ms | 1.0× | 2.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 141.35ms | 206.84ms | 1.5× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 10.69ms | 22.45ms | 2.1× | 2.1% | PASS |
| mem_writes | `oltp_update_index` | 43.39ms | 89.58ms | 2.1× | 2.9% | PASS |
| mem_writes | `oltp_update_non_index` | 32.15ms | 51.33ms | 1.6× | 3.4% | PASS |
| mem_writes | `oltp_delete_insert` | 34.27ms | 64.08ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 18.05ms | 34.55ms | 1.9× | 1.9% | PASS |
| mem_writes | `types_delete_insert` | 24.85ms | 36.11ms | 1.5× | 3.7% | PASS |
| mem_writes | `oltp_read_write` | 54.66ms | 76.99ms | 1.4× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 77.07ms | 38.01ms | 0.5× | 1.6% | PASS |
| file_reads | `oltp_range_select` | 16.63ms | 11.52ms | 0.7× | 1.8% | PASS |
| file_reads | `oltp_sum_range` | 16.19ms | 11.24ms | 0.7× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 2.95ms | 2.40ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 3.44ms | 2.88ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 8.31ms | 5.86ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_points` | 21.09ms | 15.37ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 10.25ms | 5.60ms | 0.5× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 10.04ms | 7.80ms | 0.8× | 1.6% | PASS |
| file_reads | `groupby_scan` | 22.93ms | 23.51ms | 1.0× | 1.7% | PASS |
| file_reads | `index_join` | 11.46ms | 7.93ms | 0.7× | 2.1% | PASS |
| file_reads | `index_join_scan` | 3.48ms | 5.06ms | 1.5× | 2.0% | PASS |
| file_reads | `types_table_scan` | 732.02ms | 836.25ms | 1.1× | 1.8% | PASS |
| file_reads | `table_scan` | 854.44ms | 949.07ms | 1.1× | 3.6% | PASS |
| file_reads | `oltp_read_only` | 168.99ms | 104.05ms | 0.6× | 3.1% | PASS |
| file_writes | `oltp_bulk_insert` | 221.62ms | 280.08ms | 1.3× | 6.6% | PASS |
| file_writes | `oltp_insert` | 21.62ms | 46.44ms | 2.1× | 11.5% | PASS |
| file_writes | `oltp_update_index` | 162.09ms | 178.45ms | 1.1× | 7.4% | PASS |
| file_writes | `oltp_update_non_index` | 136.60ms | 110.74ms | 0.8× | 3.9% | PASS |
| file_writes | `oltp_delete_insert` | 174.80ms | 139.50ms | 0.8× | 4.7% | PASS |
| file_writes | `oltp_write_only` | 118.13ms | 93.18ms | 0.8× | 5.9% | PASS |
| file_writes | `types_delete_insert` | 140.81ms | 81.68ms | 0.6× | 5.8% | PASS |
| file_writes | `oltp_read_write` | 172.09ms | 147.59ms | 0.9× | 4.0% | PASS |
| ac_reads | `oltp_point_select` | 46.56ms | 40.52ms | 0.9× | 2.5% | PASS |
| ac_reads | `oltp_range_select` | 14.51ms | 12.12ms | 0.8× | 3.0% | PASS |
| ac_reads | `oltp_sum_range` | 14.86ms | 12.85ms | 0.9× | 3.5% | PASS |
| ac_reads | `oltp_order_range` | 2.90ms | 2.54ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.50ms | 3.17ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.13ms | 6.17ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_points` | 18.51ms | 15.99ms | 0.9× | 4.0% | PASS |
| ac_reads | `select_random_ranges` | 6.99ms | 5.77ms | 0.8× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 6.63ms | 7.95ms | 1.2× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 23.39ms | 24.10ms | 1.0× | 1.3% | PASS |
| ac_reads | `index_join` | 10.80ms | 8.80ms | 0.8× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 3.21ms | 5.26ms | 1.6× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 726.39ms | 833.05ms | 1.1× | 2.8% | PASS |
| ac_reads | `table_scan` | 895.65ms | 960.25ms | 1.1× | 4.1% | PASS |
| ac_reads | `oltp_read_only` | 113.06ms | 103.90ms | 0.9× | 2.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 29.71ms | 72.78ms | 2.4× | 20.6% | PASS |
| ac_writes | `oltp_insert_ac` | 30.25ms | 86.02ms | 2.8× | 23.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 33.64ms | 100.11ms | 3.0× | 31.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 30.65ms | 80.46ms | 2.6× | 29.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 30.40ms | 110.11ms | 3.6× | 23.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 30.52ms | 86.44ms | 2.8× | 26.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 30.21ms | 85.78ms | 2.8× | 27.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.58ms | 93.93ms | 2.8× | 26.5% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 26.70ms | 28.66ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 13.17ms | 12.42ms | 0.9× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 11.82ms | 11.52ms | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_order_range` | 2.72ms | 2.77ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.48ms | 3.60ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.09ms | 5.09ms | 1.6× | 0.9% | PASS |
| mem_reads | `select_random_points` | 17.49ms | 16.72ms | 1.0× | 4.4% | PASS |
| mem_reads | `select_random_ranges` | 5.43ms | 5.10ms | 0.9× | 2.6% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.02ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 28.31ms | 29.47ms | 1.0× | 0.7% | PASS |
| mem_reads | `index_join` | 8.45ms | 8.44ms | 1.0× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.03ms | 5.41ms | 1.8× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 879.94ms | 1.04s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 994.97ms | 1.13s | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 108.85ms | 110.14ms | 1.0× | 2.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 180.00ms | 260.19ms | 1.4× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 14.18ms | 26.98ms | 1.9× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 51.68ms | 102.28ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 38.83ms | 58.03ms | 1.5× | 2.4% | PASS |
| mem_writes | `oltp_delete_insert` | 42.28ms | 76.52ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 22.63ms | 40.60ms | 1.8× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 30.82ms | 42.42ms | 1.4× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 75.33ms | 100.09ms | 1.3× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 97.15ms | 45.85ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 21.97ms | 14.46ms | 0.7× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 20.14ms | 13.54ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 3.63ms | 3.03ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 4.43ms | 3.83ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 10.37ms | 6.95ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 25.66ms | 19.04ms | 0.7× | 2.4% | PASS |
| file_reads | `select_random_ranges` | 12.49ms | 6.85ms | 0.5× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.34ms | 9.88ms | 0.7× | 1.0% | PASS |
| file_reads | `groupby_scan` | 29.84ms | 29.96ms | 1.0× | 1.0% | PASS |
| file_reads | `index_join` | 13.29ms | 9.74ms | 0.7× | 2.2% | PASS |
| file_reads | `index_join_scan` | 4.11ms | 5.74ms | 1.4× | 2.5% | PASS |
| file_reads | `types_table_scan` | 910.22ms | 1.07s | 1.2× | 1.6% | PASS |
| file_reads | `table_scan` | 1.08s | 1.16s | 1.1× | 2.2% | PASS |
| file_reads | `oltp_read_only` | 214.65ms | 136.52ms | 0.6× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 245.79ms | 331.95ms | 1.4× | 2.3% | PASS |
| file_writes | `oltp_insert` | 32.87ms | 50.07ms | 1.5× | 5.9% | PASS |
| file_writes | `oltp_update_index` | 165.14ms | 186.24ms | 1.1× | 3.3% | PASS |
| file_writes | `oltp_update_non_index` | 138.75ms | 116.50ms | 0.8× | 2.7% | PASS |
| file_writes | `oltp_delete_insert` | 164.94ms | 144.09ms | 0.9× | 2.1% | PASS |
| file_writes | `oltp_write_only` | 117.20ms | 94.26ms | 0.8× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 123.38ms | 84.84ms | 0.7× | 3.4% | PASS |
| file_writes | `oltp_read_write` | 176.49ms | 156.16ms | 0.9× | 3.9% | PASS |
| ac_reads | `oltp_point_select` | 49.38ms | 45.42ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 16.62ms | 14.30ms | 0.9× | 1.7% | PASS |
| ac_reads | `oltp_sum_range` | 15.01ms | 13.45ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.21ms | 3.03ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.95ms | 3.82ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.73ms | 6.90ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 20.13ms | 18.69ms | 0.9× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 7.79ms | 6.82ms | 0.9× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 8.57ms | 9.81ms | 1.1× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 29.04ms | 29.84ms | 1.0× | 0.7% | PASS |
| ac_reads | `index_join` | 10.66ms | 9.61ms | 0.9× | 1.7% | PASS |
| ac_reads | `index_join_scan` | 3.60ms | 5.69ms | 1.6× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 877.43ms | 1.04s | 1.2× | 0.8% | PASS |
| ac_reads | `table_scan` | 989.40ms | 1.13s | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 139.89ms | 134.22ms | 1.0× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.31ms | 54.43ms | 3.0× | 14.8% | PASS |
| ac_writes | `oltp_insert_ac` | 20.20ms | 68.99ms | 3.4× | 6.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.88ms | 77.70ms | 3.7× | 9.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.08ms | 58.53ms | 3.4× | 9.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.93ms | 70.38ms | 3.5× | 10.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.74ms | 68.08ms | 3.4× | 10.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.74ms | 63.38ms | 3.4× | 23.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.32ms | 74.76ms | 3.0× | 8.3% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.74ms | 30.21ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 15.35ms | 16.95ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 13.35ms | 16.07ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_order_range` | 2.88ms | 3.17ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 3.67ms | 3.98ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.58ms | 4.82ms | 1.3× | 1.4% | PASS |
| mem_reads | `select_random_points` | 19.81ms | 23.55ms | 1.2× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 5.81ms | 6.68ms | 1.1× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 5.89ms | 7.94ms | 1.3× | 1.4% | PASS |
| mem_reads | `groupby_scan` | 30.07ms | 32.85ms | 1.1× | 0.5% | PASS |
| mem_reads | `index_join` | 6.17ms | 8.91ms | 1.4× | 2.8% | PASS |
| mem_reads | `index_join_scan` | 3.29ms | 5.30ms | 1.6× | 2.2% | PASS |
| mem_reads | `types_table_scan` | 911.07ms | 1.04s | 1.1× | 1.7% | PASS |
| mem_reads | `table_scan` | 1.02s | 1.12s | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 113.99ms | 131.98ms | 1.2× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 182.29ms | 256.04ms | 1.4× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 14.47ms | 25.62ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 54.74ms | 100.01ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 41.42ms | 66.78ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 39.44ms | 72.93ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 22.32ms | 45.87ms | 2.1× | 2.0% | PASS |
| mem_writes | `types_delete_insert` | 25.51ms | 40.64ms | 1.6× | 2.5% | PASS |
| mem_writes | `oltp_read_write` | 75.59ms | 114.65ms | 1.5× | 1.7% | PASS |
| file_reads | `oltp_point_select` | 95.07ms | 47.59ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 23.85ms | 19.08ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 21.45ms | 18.11ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 3.78ms | 3.44ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.60ms | 4.25ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 10.98ms | 7.05ms | 0.6× | 1.3% | PASS |
| file_reads | `select_random_points` | 29.29ms | 26.79ms | 0.9× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 13.09ms | 8.63ms | 0.7× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.35ms | 9.98ms | 0.7× | 1.0% | PASS |
| file_reads | `groupby_scan` | 31.56ms | 33.48ms | 1.1× | 1.1% | PASS |
| file_reads | `index_join` | 10.40ms | 10.35ms | 1.0× | 1.2% | PASS |
| file_reads | `index_join_scan` | 4.13ms | 5.51ms | 1.3× | 1.5% | PASS |
| file_reads | `types_table_scan` | 877.54ms | 1.03s | 1.2× | 0.8% | PASS |
| file_reads | `table_scan` | 1.07s | 1.14s | 1.1× | 4.6% | PASS |
| file_reads | `oltp_read_only` | 219.62ms | 158.35ms | 0.7× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 236.27ms | 315.60ms | 1.3× | 4.9% | PASS |
| file_writes | `oltp_insert` | 32.32ms | 40.13ms | 1.2× | 5.8% | PASS |
| file_writes | `oltp_update_index` | 167.13ms | 167.00ms | 1.0× | 4.8% | PASS |
| file_writes | `oltp_update_non_index` | 140.80ms | 117.32ms | 0.8× | 11.3% | PASS |
| file_writes | `oltp_delete_insert` | 141.70ms | 137.03ms | 1.0× | 8.1% | PASS |
| file_writes | `oltp_write_only` | 98.89ms | 88.80ms | 0.9× | 14.9% | PASS |
| file_writes | `types_delete_insert` | 88.71ms | 74.43ms | 0.8× | 13.5% | PASS |
| file_writes | `oltp_read_write` | 154.95ms | 158.90ms | 1.0× | 4.2% | PASS |
| ac_reads | `oltp_point_select` | 46.85ms | 47.17ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 18.19ms | 18.88ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_sum_range` | 16.46ms | 18.08ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 3.40ms | 3.45ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.15ms | 4.24ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 6.30ms | 7.04ms | 1.1× | 0.8% | PASS |
| ac_reads | `select_random_points` | 23.89ms | 26.56ms | 1.1× | 1.0% | PASS |
| ac_reads | `select_random_ranges` | 8.30ms | 8.62ms | 1.0× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.85ms | 1.2× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 30.93ms | 33.27ms | 1.1× | 1.0% | PASS |
| ac_reads | `index_join` | 8.06ms | 10.59ms | 1.3× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.78ms | 5.63ms | 1.5× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 962.32ms | 1.06s | 1.1× | 2.6% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.16s | 1.0× | 3.9% | PASS |
| ac_reads | `oltp_read_only` | 151.84ms | 159.40ms | 1.0× | 2.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.90ms | 61.51ms | 3.1× | 20.1% | PASS |
| ac_writes | `oltp_insert_ac` | 23.30ms | 81.59ms | 3.5× | 21.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.89ms | 100.19ms | 4.4× | 36.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.59ms | 66.88ms | 3.4× | 37.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.70ms | 74.77ms | 3.4× | 29.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.43ms | 75.47ms | 3.4× | 16.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.33ms | 85.84ms | 4.2× | 54.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.11ms | 82.76ms | 2.9× | 15.9% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 45s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.70ms | 38.00ms | 54.5% | 1.9% | PASS |
| `status_dirty_many_tables` | 22.95ms | 42.00ms | 54.6% | 1.2% | PASS |
| `diff_regular_working_one_table` | 18.05ms | 33.00ms | 54.7% | 1.6% | PASS |
| `diff_regular_working_many_tables` | 25.38ms | 50.00ms | 50.8% | 1.5% | PASS |
| `diff_stat_working_many_tables` | 25.22ms | 48.00ms | 52.5% | 2.1% | PASS |
| `diff_schema_working_many_tables` | 27.19ms | 48.00ms | 56.6% | 1.5% | PASS |
| `branch_list_many_branches` | 14.81ms | 25.00ms | 59.2% | 1.2% | PASS |
| `branch_create_delete` | 16.52ms | 27.00ms | 61.2% | 3.2% | PASS |
| `at_literal_deep_history` | 16.24ms | 28.00ms | 58.0% | 3.1% | PASS |
| `diff_literal_deep_history` | 15.76ms | 28.00ms | 56.3% | 2.5% | PASS |
| `history_literal_deep_history` | 17.12ms | 30.00ms | 57.1% | 1.1% | PASS |
| `checkout_branch_clean` | 21.98ms | 43.00ms | 51.1% | 1.7% | PASS |
| `merge_data_no_conflicts` | 19.17ms | 33.00ms | 58.1% | 1.3% | PASS |
| `merge_data_secondary_index` | 696.43ms | 944.00ms | 73.8% | 2.2% | PASS |
| `merge_schema_no_conflicts` | 14.09ms | 24.00ms | 58.7% | 4.1% | PASS |
| `merge_data_conflicts` | 20.83ms | 33.00ms | 63.1% | 2.9% | PASS |
| `merge_data_conflicts_with_resolve` | 21.69ms | 34.00ms | 63.8% | 2.5% | PASS |

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
| copy_fsync | candidate | 415.556 | 402.809–531.116 | 32.623 | 240.64 | 107968266 |
| push_initial | candidate | 769.806 | 759.006–806.308 | 393.009 | 129.90 | 107956772 |
| clone_initial | candidate | 873.747 | 864.088–877.595 | 503.594 | 114.45 | 108475035 |
| push_noop | candidate | 0.606 | 0.566–2.373 | 0.329 | — | 0 |
| fetch_noop | candidate | 0.159 | 0.157–0.172 | 0.161 | — | 0 |
| push_incremental | candidate | 197.487 | 182.081–202.191 | 162.018 | 5.06 | 7909775 |
| fetch_incremental | candidate | 86.244 | 83.654–90.697 | 69.606 | 11.60 | 7910084 |
| pull_fast_forward | candidate | 79.286 | 74.786–82.356 | 60.498 | 12.61 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.63 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.78 | 295.105 | 109.784 | 47244 | 2337 |
| push_noop | candidate | 46.03 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.03 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.03 | 96.880 | 7.910 | 22415 | 125 |
| fetch_incremental | candidate | 46.03 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.03 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2656.787 | 2646.230–2680.067 | 367.383 | 376.39 | 1087718031 |
| push_initial | candidate | 6555.272 | 6531.419–6561.963 | 4301.093 | 152.55 | 1079566275 |
| clone_initial | candidate | 6582.219 | 6548.820–6619.619 | 6314.764 | 151.92 | 1102407326 |
| push_noop | candidate | 1.119 | 1.014–1.401 | 0.295 | — | 0 |
| fetch_noop | candidate | 0.155 | 0.127–0.164 | 0.157 | — | 0 |
| push_incremental | candidate | 935.605 | 934.217–938.710 | 930.183 | 1.07 | 15806003 |
| fetch_incremental | candidate | 250.113 | 242.438–253.267 | 244.792 | 4.00 | 15806513 |
| pull_fast_forward | candidate | 250.043 | 242.184–252.437 | 243.647 | 4.00 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.88 | 2091.605 | 1087.622 | 263431 | 20541 |
| clone_initial | candidate | 124.05 | 3517.801 | 1132.819 | 612324 | 32243 |
| push_noop | candidate | 47.14 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.14 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.37 | 617.463 | 15.928 | 149979 | 313 |
| fetch_incremental | candidate | 50.36 | 62.332 | 15.928 | 13919 | 313 |
| pull_fast_forward | candidate | 50.36 | 62.265 | 15.929 | 13915 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
