# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-12 19:38 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.82.6
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43272238976)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.82s | 10.89s | 1.1× | 1.7% | **PASS** |
| Writes | 1.88s | 3.03s | 1.6× | 1.7% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.44s | 10.93s | 1.0× | 1.5% | **PASS** |
| Writes | 4.01s | 4.24s | 1.1× | 3.7% | **PASS** |
| Autocommit writes | 732.17ms | 2.29s | 3.1× | 8.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.10s | 2.24s | 1.1× | 2.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 3.11s | 3.26s | 1.0× | 2.0% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.18s | 2.46s | 1.1× | 2.4% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.43s | 2.93s | 1.2× | 1.3% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 348.24ms | 565.85ms | 1.6× | 2.2% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 610.08ms | 991.83ms | 1.6× | 1.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 464.66ms | 711.11ms | 1.5× | 3.0% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 459.82ms | 756.77ms | 1.6× | 1.4% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.23s | 2.27s | 1.0× | 1.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.34s | 3.29s | 1.0× | 1.6% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.40s | 2.51s | 1.0× | 1.5% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.47s | 2.85s | 1.2× | 1.7% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 903.67ms | 907.26ms | 1.0× | 4.0% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 996.93ms | 1.09s | 1.1× | 4.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.17s | 1.16s | 1.0× | 3.7% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 942.96ms | 1.07s | 1.1× | 2.9% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.11s | 2.28s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 3.20s | 3.32s | 1.0× | 1.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.47s | 2.61s | 1.1× | 1.6% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.20s | 2.60s | 1.2× | 2.0% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 167.92ms | 573.99ms | 3.4× | 24.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 170.64ms | 586.62ms | 3.4× | 5.8% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 160.47ms | 521.81ms | 3.3× | 9.6% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 233.14ms | 611.18ms | 2.6× | 4.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.16ms | 23.00ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 9.58ms | 9.86ms | 1.0× | 2.8% | PASS |
| mem_reads | `oltp_sum_range` | 8.09ms | 9.15ms | 1.1× | 2.5% | PASS |
| mem_reads | `oltp_order_range` | 2.24ms | 2.44ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.00ms | 3.24ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.21ms | 4.37ms | 1.4× | 2.2% | PASS |
| mem_reads | `select_random_points` | 9.67ms | 9.73ms | 1.0× | 4.0% | PASS |
| mem_reads | `select_random_ranges` | 3.76ms | 3.88ms | 1.0× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 5.88ms | 7.85ms | 1.3× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 25.67ms | 27.70ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 4.54ms | 6.89ms | 1.5× | 2.3% | PASS |
| mem_reads | `index_join_scan` | 2.79ms | 4.83ms | 1.7× | 3.1% | PASS |
| mem_reads | `types_table_scan` | 853.64ms | 963.79ms | 1.1× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.06s | 1.07s | 1.0× | 4.3% | PASS |
| mem_reads | `oltp_read_only` | 84.30ms | 94.17ms | 1.1× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.05ms | 219.88ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 11.83ms | 19.55ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 41.90ms | 74.87ms | 1.8× | 2.4% | PASS |
| mem_writes | `oltp_update_non_index` | 29.08ms | 47.37ms | 1.6× | 2.8% | PASS |
| mem_writes | `oltp_delete_insert` | 35.89ms | 57.86ms | 1.6× | 2.3% | PASS |
| mem_writes | `oltp_write_only` | 18.63ms | 36.93ms | 2.0× | 2.0% | PASS |
| mem_writes | `types_delete_insert` | 20.73ms | 27.13ms | 1.3× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 56.14ms | 82.25ms | 1.5× | 3.5% | PASS |
| file_reads | `oltp_point_select` | 87.96ms | 39.01ms | 0.4× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 16.85ms | 11.52ms | 0.7× | 2.4% | PASS |
| file_reads | `oltp_sum_range` | 15.17ms | 10.86ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 2.99ms | 2.64ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 3.77ms | 3.46ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 10.17ms | 6.03ms | 0.6× | 1.0% | PASS |
| file_reads | `select_random_points` | 15.87ms | 11.36ms | 0.7× | 1.2% | PASS |
| file_reads | `select_random_ranges` | 10.69ms | 5.62ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 13.21ms | 9.64ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 26.29ms | 27.92ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 8.59ms | 8.10ms | 0.9× | 2.2% | PASS |
| file_reads | `index_join_scan` | 3.61ms | 4.96ms | 1.4× | 2.9% | PASS |
| file_reads | `types_table_scan` | 862.16ms | 961.89ms | 1.1× | 0.6% | PASS |
| file_reads | `table_scan` | 972.83ms | 1.05s | 1.1× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 177.89ms | 116.48ms | 0.7× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 182.28ms | 271.68ms | 1.5× | 2.9% | PASS |
| file_writes | `oltp_insert` | 24.89ms | 33.18ms | 1.3× | 4.1% | PASS |
| file_writes | `oltp_update_index` | 145.32ms | 133.65ms | 0.9× | 5.7% | PASS |
| file_writes | `oltp_update_non_index` | 118.81ms | 93.20ms | 0.8× | 11.8% | PASS |
| file_writes | `oltp_delete_insert` | 126.23ms | 110.71ms | 0.9× | 3.4% | PASS |
| file_writes | `oltp_write_only` | 93.82ms | 76.24ms | 0.8× | 3.7% | PASS |
| file_writes | `types_delete_insert` | 79.47ms | 66.50ms | 0.8× | 10.4% | PASS |
| file_writes | `oltp_read_write` | 132.85ms | 122.08ms | 0.9× | 3.8% | PASS |
| ac_reads | `oltp_point_select` | 39.21ms | 38.59ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 11.76ms | 11.47ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 10.88ms | 10.90ms | 1.0× | 2.5% | PASS |
| ac_reads | `oltp_order_range` | 2.62ms | 2.66ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.33ms | 3.45ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.67ms | 6.09ms | 1.1× | 1.1% | PASS |
| ac_reads | `select_random_points` | 11.53ms | 11.57ms | 1.0× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 6.08ms | 5.63ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.59ms | 9.62ms | 1.1× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 25.72ms | 27.84ms | 1.1× | 1.0% | PASS |
| ac_reads | `index_join` | 6.18ms | 7.99ms | 1.3× | 1.5% | PASS |
| ac_reads | `index_join_scan` | 3.14ms | 4.98ms | 1.6× | 2.9% | PASS |
| ac_reads | `types_table_scan` | 862.46ms | 963.82ms | 1.1× | 0.5% | PASS |
| ac_reads | `table_scan` | 998.61ms | 1.06s | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 113.03ms | 116.86ms | 1.0× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.95ms | 57.31ms | 3.2× | 13.7% | PASS |
| ac_writes | `oltp_insert_ac` | 21.80ms | 83.51ms | 3.8× | 32.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.32ms | 76.75ms | 3.4× | 10.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.51ms | 68.73ms | 3.5× | 28.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.87ms | 70.58ms | 3.6× | 13.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.77ms | 72.51ms | 3.3× | 26.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.26ms | 65.88ms | 3.6× | 22.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.43ms | 78.72ms | 3.0× | 28.0% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 38.12ms | 38.31ms | 1.0× | 2.5% | PASS |
| mem_reads | `oltp_range_select` | 19.88ms | 17.10ms | 0.9× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 17.82ms | 16.85ms | 0.9× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.71ms | 3.65ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 4.70ms | 4.67ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 4.26ms | 7.05ms | 1.7× | 1.6% | PASS |
| mem_reads | `select_random_points` | 27.73ms | 24.84ms | 0.9× | 3.4% | PASS |
| mem_reads | `select_random_ranges` | 7.25ms | 6.73ms | 0.9× | 2.0% | PASS |
| mem_reads | `covering_index_scan` | 7.95ms | 10.98ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 38.31ms | 39.43ms | 1.0× | 0.6% | PASS |
| mem_reads | `index_join` | 13.16ms | 11.46ms | 0.9× | 4.7% | PASS |
| mem_reads | `index_join_scan` | 4.43ms | 7.47ms | 1.7× | 3.9% | PASS |
| mem_reads | `types_table_scan` | 1.29s | 1.40s | 1.1× | 3.7% | PASS |
| mem_reads | `table_scan` | 1.47s | 1.52s | 1.0× | 3.3% | PASS |
| mem_reads | `oltp_read_only` | 160.00ms | 151.12ms | 0.9× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 229.72ms | 345.09ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.89ms | 38.41ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 72.73ms | 152.36ms | 2.1× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 53.36ms | 86.19ms | 1.6× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 58.10ms | 109.55ms | 1.9× | 1.7% | PASS |
| mem_writes | `oltp_write_only` | 30.02ms | 58.89ms | 2.0× | 2.2% | PASS |
| mem_writes | `types_delete_insert` | 42.56ms | 62.24ms | 1.5× | 2.2% | PASS |
| mem_writes | `oltp_read_write` | 105.69ms | 139.10ms | 1.3× | 2.1% | PASS |
| file_reads | `oltp_point_select` | 129.25ms | 60.22ms | 0.5× | 1.6% | PASS |
| file_reads | `oltp_range_select` | 28.92ms | 18.75ms | 0.6× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 26.11ms | 17.79ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.65ms | 3.87ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 5.68ms | 4.87ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 13.21ms | 8.87ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 39.79ms | 27.66ms | 0.7× | 5.0% | PASS |
| file_reads | `select_random_ranges` | 16.33ms | 8.92ms | 0.5× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 17.12ms | 12.95ms | 0.8× | 1.4% | PASS |
| file_reads | `groupby_scan` | 38.92ms | 39.16ms | 1.0× | 1.1% | PASS |
| file_reads | `index_join` | 17.67ms | 12.18ms | 0.7× | 3.5% | PASS |
| file_reads | `index_join_scan` | 5.34ms | 7.62ms | 1.4× | 3.1% | PASS |
| file_reads | `types_table_scan` | 1.29s | 1.40s | 1.1× | 2.4% | PASS |
| file_reads | `table_scan` | 1.42s | 1.49s | 1.0× | 2.2% | PASS |
| file_reads | `oltp_read_only` | 278.07ms | 176.04ms | 0.6× | 1.7% | PASS |
| file_writes | `oltp_bulk_insert` | 260.49ms | 359.74ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.75ms | 42.78ms | 1.7× | 1.9% | PASS |
| file_writes | `oltp_update_index` | 139.58ms | 169.97ms | 1.2× | 7.5% | PASS |
| file_writes | `oltp_update_non_index` | 117.24ms | 103.31ms | 0.9× | 14.3% | PASS |
| file_writes | `oltp_delete_insert` | 102.29ms | 125.88ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 94.86ms | 71.12ms | 0.7× | 6.5% | PASS |
| file_writes | `types_delete_insert` | 78.15ms | 69.75ms | 0.9× | 2.2% | PASS |
| file_writes | `oltp_read_write` | 178.57ms | 151.29ms | 0.8× | 9.6% | PASS |
| ac_reads | `oltp_point_select` | 64.83ms | 59.76ms | 0.9× | 2.0% | PASS |
| ac_reads | `oltp_range_select` | 24.00ms | 19.64ms | 0.8× | 3.2% | PASS |
| ac_reads | `oltp_sum_range` | 21.15ms | 18.58ms | 0.9× | 3.2% | PASS |
| ac_reads | `oltp_order_range` | 4.08ms | 3.87ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_distinct_range` | 5.06ms | 4.87ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 7.25ms | 8.81ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 28.08ms | 25.26ms | 0.9× | 2.9% | PASS |
| ac_reads | `select_random_ranges` | 10.02ms | 8.80ms | 0.9× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.95ms | 12.90ms | 1.2× | 1.2% | PASS |
| ac_reads | `groupby_scan` | 37.89ms | 38.79ms | 1.0× | 1.0% | PASS |
| ac_reads | `index_join` | 13.97ms | 11.97ms | 0.9× | 2.9% | PASS |
| ac_reads | `index_join_scan` | 4.67ms | 7.46ms | 1.6× | 3.5% | PASS |
| ac_reads | `types_table_scan` | 1.29s | 1.41s | 1.1× | 4.1% | PASS |
| ac_reads | `table_scan` | 1.49s | 1.51s | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 190.85ms | 177.66ms | 0.9× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.92ms | 55.63ms | 2.9× | 6.2% | PASS |
| ac_writes | `oltp_insert_ac` | 21.94ms | 69.23ms | 3.2× | 5.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.84ms | 89.91ms | 3.9× | 5.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.18ms | 66.22ms | 3.6× | 6.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.59ms | 79.05ms | 3.7× | 4.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.05ms | 76.72ms | 3.6× | 6.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.70ms | 67.28ms | 3.6× | 9.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.41ms | 82.57ms | 3.0× | 2.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 30.19ms | 29.31ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_range_select` | 13.26ms | 12.33ms | 0.9× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 12.60ms | 11.60ms | 0.9× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 2.77ms | 2.77ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.52ms | 3.59ms | 1.0× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.12ms | 5.03ms | 1.6× | 1.1% | PASS |
| mem_reads | `select_random_points` | 17.75ms | 16.48ms | 0.9× | 4.0% | PASS |
| mem_reads | `select_random_ranges` | 5.22ms | 4.99ms | 1.0× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 5.93ms | 8.07ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 28.60ms | 29.56ms | 1.0× | 1.2% | PASS |
| mem_reads | `index_join` | 9.28ms | 8.60ms | 0.9× | 4.7% | PASS |
| mem_reads | `index_join_scan` | 3.13ms | 5.31ms | 1.7× | 3.0% | PASS |
| mem_reads | `types_table_scan` | 903.06ms | 1.07s | 1.2× | 2.5% | PASS |
| mem_reads | `table_scan` | 1.03s | 1.14s | 1.1× | 2.4% | PASS |
| mem_reads | `oltp_read_only` | 113.43ms | 110.99ms | 1.0× | 3.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.38ms | 260.88ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.17ms | 27.41ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_update_index` | 54.26ms | 103.50ms | 1.9× | 4.4% | PASS |
| mem_writes | `oltp_update_non_index` | 40.77ms | 58.52ms | 1.4× | 3.2% | PASS |
| mem_writes | `oltp_delete_insert` | 43.28ms | 76.94ms | 1.8× | 2.8% | PASS |
| mem_writes | `oltp_write_only` | 23.31ms | 40.84ms | 1.8× | 2.8% | PASS |
| mem_writes | `types_delete_insert` | 30.82ms | 42.84ms | 1.4× | 3.8% | PASS |
| mem_writes | `oltp_read_write` | 79.66ms | 100.17ms | 1.3× | 5.2% | PASS |
| file_reads | `oltp_point_select` | 97.77ms | 45.49ms | 0.5× | 1.5% | PASS |
| file_reads | `oltp_range_select` | 21.56ms | 14.25ms | 0.7× | 3.8% | PASS |
| file_reads | `oltp_sum_range` | 19.98ms | 13.51ms | 0.7× | 2.6% | PASS |
| file_reads | `oltp_order_range` | 3.63ms | 3.01ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.42ms | 3.82ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 10.31ms | 6.82ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 26.17ms | 18.47ms | 0.7× | 4.1% | PASS |
| file_reads | `select_random_ranges` | 12.44ms | 6.81ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.32ms | 9.84ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 30.04ms | 30.04ms | 1.0× | 1.5% | PASS |
| file_reads | `index_join` | 13.29ms | 9.56ms | 0.7× | 3.4% | PASS |
| file_reads | `index_join_scan` | 4.04ms | 5.62ms | 1.4× | 2.6% | PASS |
| file_reads | `types_table_scan` | 906.86ms | 1.06s | 1.2× | 1.4% | PASS |
| file_reads | `table_scan` | 1.03s | 1.15s | 1.1× | 1.6% | PASS |
| file_reads | `oltp_read_only` | 213.45ms | 135.64ms | 0.6× | 3.1% | PASS |
| file_writes | `oltp_bulk_insert` | 243.94ms | 330.32ms | 1.4× | 2.0% | PASS |
| file_writes | `oltp_insert` | 32.07ms | 50.43ms | 1.6× | 6.4% | PASS |
| file_writes | `oltp_update_index` | 164.67ms | 184.74ms | 1.1× | 3.7% | PASS |
| file_writes | `oltp_update_non_index` | 136.49ms | 115.16ms | 0.8× | 3.3% | PASS |
| file_writes | `oltp_delete_insert` | 166.42ms | 145.67ms | 0.9× | 7.9% | PASS |
| file_writes | `oltp_write_only` | 120.51ms | 94.70ms | 0.8× | 3.7% | PASS |
| file_writes | `types_delete_insert` | 125.08ms | 84.96ms | 0.7× | 4.8% | PASS |
| file_writes | `oltp_read_write` | 180.56ms | 158.25ms | 0.9× | 3.0% | PASS |
| ac_reads | `oltp_point_select` | 51.94ms | 46.19ms | 0.9× | 2.0% | PASS |
| ac_reads | `oltp_range_select` | 17.90ms | 14.45ms | 0.8× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 16.11ms | 13.69ms | 0.8× | 2.6% | PASS |
| ac_reads | `oltp_order_range` | 3.26ms | 3.04ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.01ms | 3.82ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 5.84ms | 6.92ms | 1.2× | 1.8% | PASS |
| ac_reads | `select_random_points` | 21.23ms | 19.12ms | 0.9× | 4.7% | PASS |
| ac_reads | `select_random_ranges` | 8.06ms | 6.87ms | 0.9× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 8.82ms | 9.94ms | 1.1× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 29.96ms | 30.22ms | 1.0× | 1.0% | PASS |
| ac_reads | `index_join` | 11.26ms | 9.89ms | 0.9× | 4.1% | PASS |
| ac_reads | `index_join_scan` | 3.99ms | 5.92ms | 1.5× | 6.6% | PASS |
| ac_reads | `types_table_scan` | 1.00s | 1.11s | 1.1× | 1.5% | PASS |
| ac_reads | `table_scan` | 1.14s | 1.19s | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 138.10ms | 133.42ms | 1.0× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.82ms | 51.68ms | 2.9× | 7.3% | PASS |
| ac_writes | `oltp_insert_ac` | 20.28ms | 65.26ms | 3.2× | 8.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.67ms | 77.57ms | 3.8× | 11.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.55ms | 61.07ms | 3.3× | 9.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.71ms | 65.41ms | 3.3× | 5.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.06ms | 65.13ms | 3.2× | 9.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.22ms | 61.66ms | 3.4× | 10.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.15ms | 74.04ms | 2.9× | 9.6% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.47ms | 32.61ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 16.06ms | 20.56ms | 1.3× | 1.1% | PASS |
| mem_reads | `oltp_sum_range` | 15.62ms | 19.64ms | 1.3× | 1.0% | PASS |
| mem_reads | `oltp_order_range` | 3.28ms | 3.92ms | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.17ms | 5.03ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_index_scan` | 3.98ms | 5.48ms | 1.4× | 1.8% | PASS |
| mem_reads | `select_random_points` | 23.87ms | 28.77ms | 1.2× | 1.3% | PASS |
| mem_reads | `select_random_ranges` | 6.33ms | 7.64ms | 1.2× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 6.12ms | 9.21ms | 1.5× | 2.2% | PASS |
| mem_reads | `groupby_scan` | 34.52ms | 39.64ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 7.06ms | 10.42ms | 1.5× | 1.6% | PASS |
| mem_reads | `index_join_scan` | 3.31ms | 5.74ms | 1.7× | 1.4% | PASS |
| mem_reads | `types_table_scan` | 1.00s | 1.25s | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.15s | 1.35s | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 122.63ms | 153.05ms | 1.2× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 182.88ms | 261.52ms | 1.4× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 15.01ms | 26.18ms | 1.7× | 1.7% | PASS |
| mem_writes | `oltp_update_index` | 54.16ms | 103.91ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 39.30ms | 68.10ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 40.11ms | 77.37ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 22.08ms | 47.53ms | 2.2× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 25.30ms | 43.34ms | 1.7× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 80.97ms | 128.81ms | 1.6× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 56.92ms | 39.11ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_range_select` | 19.71ms | 21.56ms | 1.1× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 18.68ms | 20.36ms | 1.1× | 1.8% | PASS |
| file_reads | `oltp_order_range` | 3.65ms | 4.01ms | 1.1× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.55ms | 5.10ms | 1.1× | 2.1% | PASS |
| file_reads | `oltp_index_scan` | 7.21ms | 6.36ms | 0.9× | 1.7% | PASS |
| file_reads | `select_random_points` | 27.01ms | 29.06ms | 1.1× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 9.15ms | 8.13ms | 0.9× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 8.90ms | 9.59ms | 1.1× | 1.8% | PASS |
| file_reads | `groupby_scan` | 32.82ms | 37.37ms | 1.1× | 1.6% | PASS |
| file_reads | `index_join` | 8.47ms | 10.54ms | 1.2× | 2.5% | PASS |
| file_reads | `index_join_scan` | 3.70ms | 5.89ms | 1.6× | 2.9% | PASS |
| file_reads | `types_table_scan` | 969.49ms | 1.18s | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 1.14s | 1.31s | 1.2× | 0.7% | PASS |
| file_reads | `oltp_read_only` | 162.62ms | 160.17ms | 1.0× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 229.59ms | 302.90ms | 1.3× | 2.7% | PASS |
| file_writes | `oltp_insert` | 25.12ms | 38.65ms | 1.5× | 9.0% | PASS |
| file_writes | `oltp_update_index` | 150.56ms | 166.17ms | 1.1× | 3.0% | PASS |
| file_writes | `oltp_update_non_index` | 119.92ms | 111.36ms | 0.9× | 0.6% | PASS |
| file_writes | `oltp_delete_insert` | 120.36ms | 129.62ms | 1.1× | 1.6% | PASS |
| file_writes | `oltp_write_only` | 80.91ms | 89.00ms | 1.1× | 5.2% | PASS |
| file_writes | `types_delete_insert` | 76.22ms | 72.67ms | 1.0× | 5.7% | PASS |
| file_writes | `oltp_read_write` | 140.28ms | 160.93ms | 1.1× | 2.8% | PASS |
| ac_reads | `oltp_point_select` | 33.91ms | 35.63ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_range_select` | 16.29ms | 19.73ms | 1.2× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 15.40ms | 18.16ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 3.12ms | 3.61ms | 1.2× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.88ms | 4.55ms | 1.2× | 2.3% | PASS |
| ac_reads | `oltp_index_scan` | 4.87ms | 5.80ms | 1.2× | 2.8% | PASS |
| ac_reads | `select_random_points` | 22.89ms | 26.51ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_ranges` | 6.75ms | 7.54ms | 1.1× | 2.0% | PASS |
| ac_reads | `covering_index_scan` | 6.54ms | 9.01ms | 1.4× | 2.6% | PASS |
| ac_reads | `groupby_scan` | 30.73ms | 34.86ms | 1.1× | 1.5% | PASS |
| ac_reads | `index_join` | 7.21ms | 10.01ms | 1.4× | 2.4% | PASS |
| ac_reads | `index_join_scan` | 3.35ms | 5.55ms | 1.7× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 889.63ms | 1.09s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.03s | 1.18s | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 122.18ms | 144.72ms | 1.2× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 25.64ms | 66.76ms | 2.6× | 4.8% | PASS |
| ac_writes | `oltp_insert_ac` | 30.27ms | 78.04ms | 2.6× | 6.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.35ms | 81.80ms | 2.6× | 3.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 25.70ms | 71.13ms | 2.8× | 3.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 28.96ms | 78.67ms | 2.7× | 4.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.02ms | 77.94ms | 2.7× | 4.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 30.37ms | 74.69ms | 2.5× | 9.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.84ms | 82.15ms | 2.6× | 3.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 17s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 19.50ms | 38.00ms | 51.3% | 1.2% | PASS |
| `status_dirty_many_tables` | 21.43ms | 42.00ms | 51.0% | 0.8% | PASS |
| `diff_regular_working_one_table` | 16.88ms | 33.00ms | 51.1% | 0.9% | PASS |
| `diff_regular_working_many_tables` | 23.57ms | 50.00ms | 47.1% | 1.2% | PASS |
| `diff_stat_working_many_tables` | 23.55ms | 48.00ms | 49.1% | 1.1% | PASS |
| `diff_schema_working_many_tables` | 24.16ms | 48.00ms | 50.3% | 2.3% | PASS |
| `branch_list_many_branches` | 12.80ms | 25.00ms | 51.2% | 1.7% | PASS |
| `branch_create_delete` | 13.71ms | 27.00ms | 50.8% | 1.0% | PASS |
| `at_literal_deep_history` | 13.93ms | 28.00ms | 49.8% | 1.2% | PASS |
| `diff_literal_deep_history` | 13.97ms | 28.00ms | 49.9% | 1.0% | PASS |
| `history_literal_deep_history` | 14.83ms | 30.00ms | 49.4% | 1.3% | PASS |
| `checkout_branch_clean` | 19.55ms | 43.00ms | 45.5% | 1.7% | PASS |
| `merge_data_no_conflicts` | 16.09ms | 33.00ms | 48.8% | 1.4% | PASS |
| `merge_data_secondary_index` | 615.23ms | 944.00ms | 65.2% | 0.9% | PASS |
| `merge_schema_no_conflicts` | 11.84ms | 24.00ms | 49.3% | 1.8% | PASS |
| `merge_data_conflicts` | 18.65ms | 33.00ms | 56.5% | 1.7% | PASS |
| `merge_data_conflicts_with_resolve` | 19.27ms | 34.00ms | 56.7% | 1.3% | PASS |

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
| copy_fsync | candidate | 405.685 | 401.696–544.849 | 31.115 | 246.50 | 107968266 |
| push_initial | candidate | 739.086 | 728.846–746.343 | 369.848 | 135.30 | 107956772 |
| clone_initial | candidate | 846.694 | 841.634–849.774 | 483.441 | 118.11 | 108475035 |
| push_noop | candidate | 0.589 | 0.564–0.625 | 0.304 | — | 0 |
| fetch_noop | candidate | 0.151 | 0.151–0.155 | 0.153 | — | 0 |
| push_incremental | candidate | 185.941 | 163.754–191.052 | 147.230 | 5.38 | 7909775 |
| fetch_incremental | candidate | 80.349 | 77.482–82.166 | 61.383 | 12.45 | 7910084 |
| pull_fast_forward | candidate | 72.653 | 70.247–74.442 | 53.834 | 13.76 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.79 | 295.007 | 109.784 | 47220 | 2337 |
| push_noop | candidate | 46.04 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.04 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.04 | 96.716 | 7.910 | 22375 | 125 |
| fetch_incremental | candidate | 46.04 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.04 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5578.536 | 5344.168–6037.571 | 296.504 | 179.26 | 1087718031 |
| push_initial | candidate | 9097.177 | 8800.678–9169.852 | 3908.762 | 109.92 | 1079566275 |
| clone_initial | candidate | 9313.264 | 9235.824–9487.952 | 5630.925 | 107.37 | 1102407326 |
| push_noop | candidate | 0.710 | 0.685–0.714 | 0.340 | — | 0 |
| fetch_noop | candidate | 0.161 | 0.148–0.169 | 0.164 | — | 0 |
| push_incremental | candidate | 995.466 | 995.079–1002.527 | 944.646 | 1.00 | 15806003 |
| fetch_incremental | candidate | 269.207 | 266.573–269.676 | 221.206 | 3.71 | 15806513 |
| pull_fast_forward | candidate | 265.736 | 247.989–267.713 | 214.059 | 3.76 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.75 | 2091.642 | 1087.622 | 263440 | 20541 |
| clone_initial | candidate | 123.98 | 3524.631 | 1132.819 | 613926 | 32243 |
| push_noop | candidate | 47.18 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.18 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 619.734 | 15.928 | 150516 | 313 |
| fetch_incremental | candidate | 50.39 | 62.463 | 15.928 | 13951 | 313 |
| pull_fast_forward | candidate | 50.38 | 62.396 | 15.929 | 13947 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
