# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-07 17:43 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42388448453)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.86s | 11.53s | 1.2× | 1.2% | **PASS** |
| Writes | 1.98s | 3.28s | 1.7× | 1.1% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 11.08s | 11.84s | 1.1× | 1.2% | **PASS** |
| Writes | 3.36s | 4.02s | 1.2× | 1.7% | **PASS** |
| Autocommit writes | 706.07ms | 2.39s | 3.4× | 6.9% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.46s | 2.89s | 1.2× | 1.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.18s | 2.45s | 1.1× | 2.0% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.47s | 3.06s | 1.2× | 1.1% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.74s | 3.14s | 1.1× | 0.9% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 428.52ms | 766.79ms | 1.8× | 1.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 462.18ms | 717.34ms | 1.6× | 1.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 527.21ms | 860.23ms | 1.6× | 1.2% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 565.41ms | 935.21ms | 1.7× | 0.8% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.68s | 2.95s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.58s | 2.56s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.59s | 3.10s | 1.2× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.23s | 3.24s | 1.0× | 1.2% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 596.02ms | 830.55ms | 1.4× | 2.0% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.35s | 1.25s | 0.9× | 16.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 678.20ms | 945.58ms | 1.4× | 1.4% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 735.63ms | 1.00s | 1.4× | 1.2% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.58s | 2.96s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.23s | 2.48s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.51s | 3.09s | 1.2× | 1.2% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.81s | 3.19s | 1.1× | 0.7% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 205.56ms | 666.20ms | 3.2× | 8.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 210.82ms | 702.96ms | 3.3× | 31.6% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 154.47ms | 519.81ms | 3.4× | 6.4% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 135.21ms | 505.33ms | 3.7× | 3.9% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.66ms | 31.53ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 10.65ms | 12.92ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_sum_range` | 9.45ms | 12.21ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 2.65ms | 3.14ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 3.61ms | 4.29ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.84ms | 5.67ms | 1.5× | 1.9% | PASS |
| mem_reads | `select_random_points` | 10.00ms | 12.05ms | 1.2× | 1.6% | PASS |
| mem_reads | `select_random_ranges` | 4.63ms | 5.44ms | 1.2× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 7.90ms | 10.89ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 30.40ms | 35.21ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 5.75ms | 8.86ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.18ms | 5.66ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.18s | 1.35s | 1.1× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 103.82ms | 128.98ms | 1.2× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.36ms | 301.88ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 14.92ms | 27.03ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 49.29ms | 97.82ms | 2.0× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 33.94ms | 64.06ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 42.82ms | 77.51ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 21.13ms | 48.23ms | 2.3× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 23.84ms | 37.79ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 67.23ms | 112.47ms | 1.7× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 92.94ms | 48.89ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 18.01ms | 14.82ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 16.90ms | 14.32ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.59ms | 3.41ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 4.60ms | 4.63ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.24ms | 7.62ms | 0.7× | 1.2% | PASS |
| file_reads | `select_random_points` | 17.52ms | 13.74ms | 0.8× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 11.82ms | 7.46ms | 0.6× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 15.52ms | 13.10ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 31.94ms | 35.80ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 9.86ms | 10.25ms | 1.0× | 1.7% | PASS |
| file_reads | `index_join_scan` | 4.19ms | 6.07ms | 1.4× | 1.3% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.8% | PASS |
| file_reads | `table_scan` | 1.18s | 1.35s | 1.1× | 1.1% | PASS |
| file_reads | `oltp_read_only` | 205.58ms | 156.02ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 188.42ms | 314.91ms | 1.7× | 1.0% | PASS |
| file_writes | `oltp_insert` | 22.25ms | 30.32ms | 1.4× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 77.90ms | 107.67ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_update_non_index` | 59.11ms | 70.88ms | 1.2× | 2.1% | PASS |
| file_writes | `oltp_delete_insert` | 68.06ms | 88.97ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 45.91ms | 54.40ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 40.31ms | 44.57ms | 1.1× | 2.3% | PASS |
| file_writes | `oltp_read_write` | 94.06ms | 118.83ms | 1.3× | 1.9% | PASS |
| ac_reads | `oltp_point_select` | 45.76ms | 49.19ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 13.56ms | 14.81ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 12.19ms | 14.40ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 3.11ms | 3.41ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 4.06ms | 4.59ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.35ms | 7.54ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 12.43ms | 13.79ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 7.07ms | 7.51ms | 1.1× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.77ms | 13.15ms | 1.2× | 1.2% | PASS |
| ac_reads | `groupby_scan` | 31.15ms | 35.66ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.36ms | 10.22ms | 1.4× | 1.7% | PASS |
| ac_reads | `index_join_scan` | 3.65ms | 6.05ms | 1.7× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 1.1% | PASS |
| ac_reads | `table_scan` | 1.22s | 1.36s | 1.1× | 2.5% | PASS |
| ac_reads | `oltp_read_only` | 137.62ms | 156.04ms | 1.1× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.83ms | 69.83ms | 3.1× | 7.1% | PASS |
| ac_writes | `oltp_insert_ac` | 26.87ms | 84.93ms | 3.2× | 9.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.32ms | 94.40ms | 3.5× | 8.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.39ms | 76.46ms | 3.3× | 8.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.86ms | 84.46ms | 3.4× | 5.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 26.14ms | 85.76ms | 3.3× | 8.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.35ms | 78.07ms | 3.5× | 10.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.80ms | 92.28ms | 2.9× | 6.6% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.09ms | 29.41ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 14.18ms | 12.61ms | 0.9× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 12.71ms | 12.13ms | 1.0× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 2.91ms | 2.85ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 3.71ms | 3.72ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.42ms | 5.39ms | 1.6× | 2.0% | PASS |
| mem_reads | `select_random_points` | 17.77ms | 17.19ms | 1.0× | 2.9% | PASS |
| mem_reads | `select_random_ranges` | 5.46ms | 5.13ms | 0.9× | 3.1% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.16ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 29.24ms | 29.96ms | 1.0× | 0.5% | PASS |
| mem_reads | `index_join` | 10.08ms | 8.76ms | 0.9× | 3.4% | PASS |
| mem_reads | `index_join_scan` | 3.34ms | 5.97ms | 1.8× | 3.2% | PASS |
| mem_reads | `types_table_scan` | 898.26ms | 1.05s | 1.2× | 1.5% | PASS |
| mem_reads | `table_scan` | 1.04s | 1.14s | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_read_only` | 109.87ms | 111.56ms | 1.0× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.93ms | 260.38ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 13.74ms | 26.79ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 53.40ms | 105.46ms | 2.0× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 40.05ms | 60.74ms | 1.5× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 44.81ms | 78.58ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 23.14ms | 40.94ms | 1.8× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 31.96ms | 43.95ms | 1.4× | 2.4% | PASS |
| mem_writes | `oltp_read_write` | 76.15ms | 100.50ms | 1.3× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 97.71ms | 45.72ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 21.87ms | 14.48ms | 0.7× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 20.17ms | 13.93ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 3.68ms | 3.07ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 4.46ms | 3.87ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 10.35ms | 6.91ms | 0.7× | 0.7% | PASS |
| file_reads | `select_random_points` | 25.33ms | 19.10ms | 0.8× | 1.1% | PASS |
| file_reads | `select_random_ranges` | 12.55ms | 6.90ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 13.28ms | 9.91ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 30.57ms | 30.29ms | 1.0× | 1.1% | PASS |
| file_reads | `index_join` | 13.79ms | 9.66ms | 0.7× | 2.3% | PASS |
| file_reads | `index_join_scan` | 4.07ms | 6.00ms | 1.5× | 1.8% | PASS |
| file_reads | `types_table_scan` | 1.00s | 1.09s | 1.1× | 2.7% | PASS |
| file_reads | `table_scan` | 1.10s | 1.16s | 1.0× | 4.0% | PASS |
| file_reads | `oltp_read_only` | 216.34ms | 137.65ms | 0.6× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 288.12ms | 347.62ms | 1.2× | 16.5% | PASS |
| file_writes | `oltp_insert` | 27.52ms | 49.44ms | 1.8× | 19.9% | PASS |
| file_writes | `oltp_update_index` | 181.47ms | 200.09ms | 1.1× | 9.7% | PASS |
| file_writes | `oltp_update_non_index` | 157.29ms | 126.76ms | 0.8× | 13.8% | PASS |
| file_writes | `oltp_delete_insert` | 206.72ms | 148.96ms | 0.7× | 14.8% | PASS |
| file_writes | `oltp_write_only` | 132.97ms | 102.99ms | 0.8× | 17.3% | PASS |
| file_writes | `types_delete_insert` | 163.41ms | 103.35ms | 0.6× | 30.5% | PASS |
| file_writes | `oltp_read_write` | 190.78ms | 168.66ms | 0.9× | 18.0% | PASS |
| ac_reads | `oltp_point_select` | 53.77ms | 47.33ms | 0.9× | 1.7% | PASS |
| ac_reads | `oltp_range_select` | 17.49ms | 14.59ms | 0.8× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 15.40ms | 13.90ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 3.29ms | 3.08ms | 0.9× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.04ms | 3.89ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.87ms | 7.08ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 21.80ms | 19.65ms | 0.9× | 3.1% | PASS |
| ac_reads | `select_random_ranges` | 7.89ms | 6.91ms | 0.9× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 8.57ms | 9.93ms | 1.2× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 29.52ms | 30.06ms | 1.0× | 0.6% | PASS |
| ac_reads | `index_join` | 11.04ms | 9.38ms | 0.8× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.66ms | 5.92ms | 1.6× | 1.3% | PASS |
| ac_reads | `types_table_scan` | 890.09ms | 1.04s | 1.2× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.02s | 1.13s | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_read_only` | 140.18ms | 135.23ms | 1.0× | 0.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 25.92ms | 81.62ms | 3.1× | 38.1% | PASS |
| ac_writes | `oltp_insert_ac` | 31.03ms | 93.31ms | 3.0× | 40.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.40ms | 105.26ms | 4.1× | 29.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 25.17ms | 76.14ms | 3.0× | 34.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.75ms | 91.52ms | 3.7× | 33.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.71ms | 77.17ms | 3.3× | 17.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.41ms | 80.29ms | 3.6× | 23.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.42ms | 97.67ms | 3.0× | 28.9% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.04ms | 37.88ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 14.33ms | 15.07ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 13.88ms | 14.52ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 2.86ms | 3.17ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.63ms | 4.17ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.54ms | 6.09ms | 1.7× | 1.0% | PASS |
| mem_reads | `select_random_points` | 20.46ms | 21.76ms | 1.1× | 1.8% | PASS |
| mem_reads | `select_random_ranges` | 5.69ms | 6.29ms | 1.1× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 6.84ms | 9.86ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 31.46ms | 34.63ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 10.03ms | 10.58ms | 1.1× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.09ms | 6.51ms | 2.1× | 2.2% | PASS |
| mem_reads | `types_table_scan` | 1.01s | 1.32s | 1.3× | 1.0% | PASS |
| mem_reads | `table_scan` | 1.19s | 1.43s | 1.2× | 0.7% | PASS |
| mem_reads | `oltp_read_only` | 129.24ms | 141.83ms | 1.1× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 202.45ms | 302.05ms | 1.5× | 1.3% | PASS |
| mem_writes | `oltp_insert` | 16.44ms | 33.27ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 62.07ms | 132.43ms | 2.1× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 44.61ms | 70.60ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 48.70ms | 94.40ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 26.28ms | 49.38ms | 1.9× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 34.60ms | 51.82ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 92.06ms | 126.27ms | 1.4× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 63.20ms | 45.16ms | 0.7× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 17.11ms | 15.91ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 16.67ms | 15.44ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 3.28ms | 3.33ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.08ms | 4.34ms | 1.1× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 6.85ms | 7.18ms | 1.0× | 1.4% | PASS |
| file_reads | `select_random_points` | 25.44ms | 23.90ms | 0.9× | 2.1% | PASS |
| file_reads | `select_random_ranges` | 9.05ms | 7.40ms | 0.8× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 10.18ms | 10.94ms | 1.1× | 1.4% | PASS |
| file_reads | `groupby_scan` | 32.06ms | 34.97ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 12.00ms | 11.15ms | 0.9× | 1.7% | PASS |
| file_reads | `index_join_scan` | 3.56ms | 6.54ms | 1.8× | 1.9% | PASS |
| file_reads | `types_table_scan` | 1.02s | 1.33s | 1.3× | 0.6% | PASS |
| file_reads | `table_scan` | 1.19s | 1.43s | 1.2× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 170.96ms | 153.00ms | 0.9× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 219.88ms | 316.36ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_insert` | 21.51ms | 37.67ms | 1.8× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 83.26ms | 150.23ms | 1.8× | 1.0% | PASS |
| file_writes | `oltp_update_non_index` | 79.91ms | 81.14ms | 1.0× | 18.5% | PASS |
| file_writes | `oltp_delete_insert` | 69.01ms | 106.82ms | 1.5× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 42.65ms | 58.68ms | 1.4× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 50.34ms | 57.44ms | 1.1× | 1.6% | PASS |
| file_writes | `oltp_read_write` | 111.65ms | 137.25ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_point_select` | 43.02ms | 45.36ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 15.15ms | 15.94ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_sum_range` | 14.85ms | 15.59ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.09ms | 3.33ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_distinct_range` | 3.85ms | 4.34ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 4.84ms | 7.15ms | 1.5× | 1.5% | PASS |
| ac_reads | `select_random_points` | 22.91ms | 23.82ms | 1.0× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 6.97ms | 7.42ms | 1.1× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 8.03ms | 10.91ms | 1.4× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 31.66ms | 34.86ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 10.81ms | 10.87ms | 1.0× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 3.36ms | 6.53ms | 1.9× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.02s | 1.33s | 1.3× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.42s | 1.2× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 142.13ms | 153.58ms | 1.1× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.81ms | 49.95ms | 2.8× | 7.1% | PASS |
| ac_writes | `oltp_insert_ac` | 20.30ms | 66.31ms | 3.3× | 6.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.44ms | 77.94ms | 3.8× | 6.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.89ms | 57.97ms | 3.4× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.73ms | 67.50ms | 3.4× | 6.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 18.45ms | 66.99ms | 3.6× | 6.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.43ms | 60.70ms | 3.5× | 10.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 23.42ms | 72.46ms | 3.1× | 4.5% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 32.92ms | 37.68ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 19.42ms | 21.82ms | 1.1× | 0.7% | PASS |
| mem_reads | `oltp_sum_range` | 16.85ms | 20.58ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_order_range` | 3.66ms | 4.06ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_distinct_range` | 4.64ms | 5.11ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.51ms | 6.19ms | 1.4× | 1.3% | PASS |
| mem_reads | `select_random_points` | 25.37ms | 29.89ms | 1.2× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 7.16ms | 8.44ms | 1.2× | 0.9% | PASS |
| mem_reads | `covering_index_scan` | 7.62ms | 10.26ms | 1.3× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 38.27ms | 42.34ms | 1.1× | 0.5% | PASS |
| mem_reads | `index_join` | 7.68ms | 11.10ms | 1.4× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.87ms | 6.35ms | 1.6× | 1.4% | PASS |
| mem_reads | `types_table_scan` | 1.14s | 1.32s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.29s | 1.44s | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 144.04ms | 168.54ms | 1.2× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 235.07ms | 334.74ms | 1.4× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.40ms | 33.83ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 65.11ms | 125.31ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 48.73ms | 86.14ms | 1.8× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 47.85ms | 95.01ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 26.10ms | 58.51ms | 2.2× | 0.6% | PASS |
| mem_writes | `types_delete_insert` | 30.90ms | 53.09ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_read_write` | 93.25ms | 148.58ms | 1.6× | 0.9% | PASS |
| file_reads | `oltp_point_select` | 119.45ms | 58.65ms | 0.5× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 28.68ms | 24.19ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 25.95ms | 23.02ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 4.62ms | 4.36ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.68ms | 5.42ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 13.63ms | 8.54ms | 0.6× | 1.2% | PASS |
| file_reads | `select_random_points` | 32.93ms | 31.72ms | 1.0× | 1.4% | PASS |
| file_reads | `select_random_ranges` | 15.58ms | 10.67ms | 0.7× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 16.52ms | 12.44ms | 0.8× | 1.2% | PASS |
| file_reads | `groupby_scan` | 38.94ms | 42.65ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 12.39ms | 12.41ms | 1.0× | 1.1% | PASS |
| file_reads | `index_join_scan` | 4.89ms | 6.66ms | 1.4× | 1.2% | PASS |
| file_reads | `types_table_scan` | 1.18s | 1.33s | 1.1× | 1.8% | PASS |
| file_reads | `table_scan` | 1.46s | 1.46s | 1.0× | 1.6% | PASS |
| file_reads | `oltp_read_only` | 277.02ms | 202.51ms | 0.7× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 251.11ms | 347.13ms | 1.4× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.15ms | 37.95ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_update_index` | 96.19ms | 138.64ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 76.64ms | 93.01ms | 1.2× | 1.3% | PASS |
| file_writes | `oltp_delete_insert` | 74.87ms | 107.11ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 48.65ms | 64.50ms | 1.3× | 1.0% | PASS |
| file_writes | `types_delete_insert` | 47.34ms | 57.76ms | 1.2× | 1.5% | PASS |
| file_writes | `oltp_read_write` | 115.68ms | 154.47ms | 1.3× | 1.0% | PASS |
| ac_reads | `oltp_point_select` | 59.18ms | 58.77ms | 1.0× | 0.6% | PASS |
| ac_reads | `oltp_range_select` | 22.04ms | 24.12ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_sum_range` | 19.76ms | 22.88ms | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 4.29ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.96ms | 5.36ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 7.29ms | 8.29ms | 1.1× | 1.1% | PASS |
| ac_reads | `select_random_points` | 27.53ms | 31.65ms | 1.1× | 0.7% | PASS |
| ac_reads | `select_random_ranges` | 9.91ms | 10.72ms | 1.1× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 10.54ms | 12.36ms | 1.2× | 0.5% | PASS |
| ac_reads | `groupby_scan` | 38.29ms | 42.51ms | 1.1× | 0.5% | PASS |
| ac_reads | `index_join` | 9.41ms | 12.37ms | 1.3× | 0.9% | PASS |
| ac_reads | `index_join_scan` | 4.28ms | 6.59ms | 1.5× | 1.1% | PASS |
| ac_reads | `types_table_scan` | 1.13s | 1.31s | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.28s | 1.43s | 1.1× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 183.15ms | 199.94ms | 1.1× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 14.68ms | 48.59ms | 3.3× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 16.71ms | 63.56ms | 3.8× | 4.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 18.06ms | 74.50ms | 4.1× | 5.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 14.85ms | 57.26ms | 3.9× | 2.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 16.68ms | 65.59ms | 3.9× | 3.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 16.71ms | 64.74ms | 3.9× | 3.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 14.45ms | 57.28ms | 4.0× | 4.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 23.08ms | 73.80ms | 3.2× | 3.1% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 33s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.71ms | 38.00ms | 54.5% | 1.5% | PASS |
| `status_dirty_many_tables` | 23.04ms | 42.00ms | 54.9% | 1.5% | PASS |
| `diff_regular_working_one_table` | 18.13ms | 33.00ms | 54.9% | 1.4% | PASS |
| `diff_regular_working_many_tables` | 26.08ms | 50.00ms | 52.2% | 2.5% | PASS |
| `diff_stat_working_many_tables` | 25.32ms | 48.00ms | 52.7% | 1.6% | PASS |
| `diff_schema_working_many_tables` | 25.53ms | 48.00ms | 53.2% | 1.9% | PASS |
| `branch_list_many_branches` | 13.38ms | 25.00ms | 53.5% | 1.0% | PASS |
| `branch_create_delete` | 14.71ms | 27.00ms | 54.5% | 1.9% | PASS |
| `at_literal_deep_history` | 15.04ms | 28.00ms | 53.7% | 1.5% | PASS |
| `diff_literal_deep_history` | 14.88ms | 28.00ms | 53.1% | 2.6% | PASS |
| `history_literal_deep_history` | 15.60ms | 30.00ms | 52.0% | 1.4% | PASS |
| `checkout_branch_clean` | 20.37ms | 43.00ms | 47.4% | 2.1% | PASS |
| `merge_data_no_conflicts` | 17.19ms | 33.00ms | 52.1% | 1.6% | PASS |
| `merge_data_secondary_index` | 643.34ms | 944.00ms | 68.2% | 1.5% | PASS |
| `merge_schema_no_conflicts` | 14.47ms | 24.00ms | 60.3% | 2.9% | PASS |
| `merge_data_conflicts` | 20.00ms | 33.00ms | 60.6% | 4.2% | PASS |
| `merge_data_conflicts_with_resolve` | 20.72ms | 34.00ms | 61.0% | 2.0% | PASS |

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
| copy_fsync | candidate | 405.155 | 399.820–541.806 | 33.366 | 246.82 | 107968266 |
| push_initial | candidate | 756.447 | 739.254–761.345 | 386.642 | 132.20 | 107956772 |
| clone_initial | candidate | 858.598 | 850.558–865.384 | 505.131 | 116.47 | 108475035 |
| push_noop | candidate | 0.609 | 0.588–0.654 | 0.326 | — | 0 |
| fetch_noop | candidate | 0.156 | 0.153–0.171 | 0.157 | — | 0 |
| push_incremental | candidate | 178.579 | 174.247–188.454 | 157.863 | 5.60 | 7909775 |
| fetch_incremental | candidate | 84.650 | 83.377–87.797 | 68.273 | 11.81 | 7910084 |
| pull_fast_forward | candidate | 79.890 | 73.293–106.652 | 59.377 | 12.52 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.51 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.85 | 295.169 | 109.784 | 47259 | 2337 |
| push_noop | candidate | 45.99 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.99 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.99 | 97.014 | 7.910 | 22447 | 125 |
| fetch_incremental | candidate | 45.99 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.99 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5638.886 | 5550.507–6468.540 | 306.332 | 177.34 | 1087718031 |
| push_initial | candidate | 8191.297 | 8037.390–8722.803 | 4247.391 | 122.08 | 1079566275 |
| clone_initial | candidate | 10374.675 | 10059.716–12056.967 | 6153.036 | 96.39 | 1102407326 |
| push_noop | candidate | 0.671 | 0.640–0.706 | 0.343 | — | 0 |
| fetch_noop | candidate | 0.199 | 0.172–0.207 | 0.200 | — | 0 |
| push_incremental | candidate | 1038.497 | 1011.706–1110.833 | 936.023 | 0.96 | 15806003 |
| fetch_incremental | candidate | 318.249 | 306.090–417.847 | 237.447 | 3.14 | 15806513 |
| pull_fast_forward | candidate | 396.808 | 308.641–400.884 | 232.673 | 2.52 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.03 | 2091.253 | 1087.622 | 263345 | 20541 |
| clone_initial | candidate | 124.08 | 3518.735 | 1132.819 | 612474 | 32243 |
| push_noop | candidate | 47.16 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.16 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.33 | 616.896 | 15.928 | 149813 | 313 |
| fetch_incremental | candidate | 50.38 | 62.259 | 15.928 | 13902 | 313 |
| pull_fast_forward | candidate | 50.38 | 62.191 | 15.929 | 13898 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
