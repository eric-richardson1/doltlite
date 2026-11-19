# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-19 20:30 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/44589087501)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.96s | 10.63s | 1.2× | 1.9% | **PASS** |
| Writes | 1.82s | 3.06s | 1.7× | 1.6% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.67s | 10.81s | 1.1× | 1.7% | **PASS** |
| Writes | 3.38s | 3.89s | 1.1× | 2.2% | **PASS** |
| Autocommit writes | 828.62ms | 2.48s | 3.0× | 5.2% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.83s | 1.87s | 1.0× | 2.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.66s | 3.28s | 1.2× | 1.6% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.62s | 3.31s | 1.3× | 2.1% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.85s | 2.17s | 1.2× | 1.5% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 289.25ms | 499.07ms | 1.7× | 2.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 584.07ms | 981.91ms | 1.7× | 1.5% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 588.16ms | 986.61ms | 1.7× | 1.5% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 360.21ms | 592.49ms | 1.6× | 1.7% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.03s | 1.92s | 0.9× | 2.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.91s | 3.35s | 1.2× | 1.5% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.78s | 3.35s | 1.2× | 1.6% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.95s | 2.20s | 1.1× | 2.0% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 746.78ms | 773.44ms | 1.0× | 5.6% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 917.38ms | 1.08s | 1.2× | 3.0% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 805.89ms | 1.08s | 1.3× | 1.9% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 914.30ms | 954.50ms | 1.0× | 2.4% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.76s | 1.83s | 1.0× | 2.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.75s | 3.35s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.62s | 3.34s | 1.3× | 1.5% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.87s | 2.18s | 1.2× | 1.8% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 172.83ms | 499.13ms | 2.9× | 4.8% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 197.83ms | 623.35ms | 3.2× | 5.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 194.03ms | 620.16ms | 3.2× | 5.7% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 263.94ms | 737.99ms | 2.8× | 3.8% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 16.96ms | 19.78ms | 1.2× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 6.70ms | 7.53ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_sum_range` | 6.37ms | 7.60ms | 1.2× | 2.5% | PASS |
| mem_reads | `oltp_order_range` | 1.77ms | 1.96ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_distinct_range` | 2.29ms | 2.49ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_index_scan` | 2.64ms | 3.90ms | 1.5× | 2.7% | PASS |
| mem_reads | `select_random_points` | 8.88ms | 9.66ms | 1.1× | 4.2% | PASS |
| mem_reads | `select_random_ranges` | 2.98ms | 3.23ms | 1.1× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 4.29ms | 6.58ms | 1.5× | 2.0% | PASS |
| mem_reads | `groupby_scan` | 19.65ms | 20.89ms | 1.1× | 1.2% | PASS |
| mem_reads | `index_join` | 3.85ms | 7.38ms | 1.9× | 3.7% | PASS |
| mem_reads | `index_join_scan` | 2.75ms | 5.53ms | 2.0× | 3.1% | PASS |
| mem_reads | `types_table_scan` | 767.16ms | 810.79ms | 1.1× | 1.4% | PASS |
| mem_reads | `table_scan` | 915.94ms | 892.94ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 69.33ms | 73.95ms | 1.1× | 2.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 107.09ms | 179.76ms | 1.7× | 1.4% | PASS |
| mem_writes | `oltp_insert` | 9.48ms | 17.02ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 37.53ms | 74.62ms | 2.0× | 3.0% | PASS |
| mem_writes | `oltp_update_non_index` | 25.88ms | 43.66ms | 1.7× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 30.03ms | 53.95ms | 1.8× | 3.1% | PASS |
| mem_writes | `oltp_write_only` | 15.23ms | 34.47ms | 2.3× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 17.40ms | 24.85ms | 1.4× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 46.60ms | 70.74ms | 1.5× | 2.9% | PASS |
| file_reads | `oltp_point_select` | 70.51ms | 33.62ms | 0.5× | 1.6% | PASS |
| file_reads | `oltp_range_select` | 13.06ms | 9.22ms | 0.7× | 2.4% | PASS |
| file_reads | `oltp_sum_range` | 12.49ms | 9.09ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 2.46ms | 2.18ms | 0.9× | 2.6% | PASS |
| file_reads | `oltp_distinct_range` | 2.96ms | 2.68ms | 0.9× | 2.5% | PASS |
| file_reads | `oltp_index_scan` | 8.71ms | 5.39ms | 0.6× | 1.8% | PASS |
| file_reads | `select_random_points` | 14.82ms | 10.92ms | 0.7× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 8.53ms | 4.69ms | 0.5× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 10.51ms | 7.96ms | 0.8× | 2.3% | PASS |
| file_reads | `groupby_scan` | 20.38ms | 21.11ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join` | 7.57ms | 8.07ms | 1.1× | 4.6% | PASS |
| file_reads | `index_join_scan` | 3.29ms | 4.91ms | 1.5× | 6.2% | PASS |
| file_reads | `types_table_scan` | 746.16ms | 788.71ms | 1.1× | 1.9% | PASS |
| file_reads | `table_scan` | 956.87ms | 911.09ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_read_only` | 152.68ms | 99.21ms | 0.6× | 1.4% | PASS |
| file_writes | `oltp_bulk_insert` | 150.81ms | 229.59ms | 1.5× | 1.7% | PASS |
| file_writes | `oltp_insert` | 19.83ms | 27.27ms | 1.4× | 2.0% | PASS |
| file_writes | `oltp_update_index` | 131.54ms | 119.60ms | 0.9× | 4.8% | PASS |
| file_writes | `oltp_update_non_index` | 101.21ms | 84.68ms | 0.8× | 5.5% | PASS |
| file_writes | `oltp_delete_insert` | 104.50ms | 98.91ms | 0.9× | 6.0% | PASS |
| file_writes | `oltp_write_only` | 73.89ms | 64.70ms | 0.9× | 6.4% | PASS |
| file_writes | `types_delete_insert` | 61.95ms | 49.16ms | 0.8× | 10.3% | PASS |
| file_writes | `oltp_read_write` | 103.04ms | 99.53ms | 1.0× | 5.7% | PASS |
| ac_reads | `oltp_point_select` | 34.40ms | 32.98ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_range_select` | 8.70ms | 8.79ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 8.09ms | 8.71ms | 1.1× | 2.9% | PASS |
| ac_reads | `oltp_order_range` | 1.99ms | 2.07ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_distinct_range` | 2.54ms | 2.60ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_index_scan` | 4.90ms | 5.25ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_points` | 10.14ms | 10.53ms | 1.0× | 4.2% | PASS |
| ac_reads | `select_random_ranges` | 4.88ms | 4.60ms | 0.9× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 6.66ms | 7.64ms | 1.1× | 1.8% | PASS |
| ac_reads | `groupby_scan` | 19.41ms | 20.46ms | 1.1× | 1.3% | PASS |
| ac_reads | `index_join` | 5.25ms | 7.11ms | 1.4× | 4.4% | PASS |
| ac_reads | `index_join_scan` | 2.90ms | 4.75ms | 1.6× | 5.9% | PASS |
| ac_reads | `types_table_scan` | 711.25ms | 755.36ms | 1.1× | 1.7% | PASS |
| ac_reads | `table_scan` | 843.85ms | 859.28ms | 1.0× | 2.7% | PASS |
| ac_reads | `oltp_read_only` | 94.98ms | 95.14ms | 1.0× | 2.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.77ms | 53.74ms | 2.7× | 5.6% | PASS |
| ac_writes | `oltp_insert_ac` | 21.96ms | 63.46ms | 2.9× | 4.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.26ms | 69.95ms | 3.0× | 3.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.88ms | 56.99ms | 2.9× | 5.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.47ms | 63.40ms | 3.0× | 2.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.85ms | 65.15ms | 3.0× | 4.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.66ms | 58.18ms | 3.0× | 5.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.98ms | 68.24ms | 2.7× | 6.6% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.57ms | 40.59ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 16.16ms | 16.76ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 14.79ms | 16.10ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 3.23ms | 3.59ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.21ms | 4.74ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.91ms | 6.82ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 22.40ms | 22.42ms | 1.0× | 4.3% | PASS |
| mem_reads | `select_random_ranges` | 6.72ms | 7.04ms | 1.0× | 2.3% | PASS |
| mem_reads | `covering_index_scan` | 7.99ms | 11.35ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 34.71ms | 37.74ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 10.43ms | 10.58ms | 1.0× | 2.1% | PASS |
| mem_reads | `index_join_scan` | 3.82ms | 6.58ms | 1.7× | 2.2% | PASS |
| mem_reads | `types_table_scan` | 1.11s | 1.42s | 1.3× | 1.6% | PASS |
| mem_reads | `table_scan` | 1.25s | 1.53s | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_read_only` | 139.38ms | 154.35ms | 1.1× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.16ms | 361.30ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 17.53ms | 36.76ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 65.72ms | 140.45ms | 2.1× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 48.10ms | 82.90ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 53.45ms | 103.64ms | 1.9× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 27.71ms | 55.26ms | 2.0× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 38.41ms | 59.94ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 99.98ms | 141.67ms | 1.4× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 106.52ms | 60.30ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 24.65ms | 18.93ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 23.11ms | 18.63ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.24ms | 3.88ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.29ms | 5.09ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.40ms | 8.87ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_points` | 31.43ms | 25.44ms | 0.8× | 3.3% | PASS |
| file_reads | `select_random_ranges` | 14.29ms | 9.14ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.71ms | 13.39ms | 0.9× | 1.2% | PASS |
| file_reads | `groupby_scan` | 36.05ms | 38.18ms | 1.1× | 1.2% | PASS |
| file_reads | `index_join` | 15.11ms | 11.94ms | 0.8× | 2.1% | PASS |
| file_reads | `index_join_scan` | 4.82ms | 6.99ms | 1.4× | 2.7% | PASS |
| file_reads | `types_table_scan` | 1.11s | 1.42s | 1.3× | 1.8% | PASS |
| file_reads | `table_scan` | 1.25s | 1.52s | 1.2× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 246.40ms | 184.02ms | 0.7× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 256.98ms | 375.92ms | 1.5× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.44ms | 42.20ms | 1.7× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 123.96ms | 159.07ms | 1.3× | 13.7% | PASS |
| file_writes | `oltp_update_non_index` | 108.71ms | 96.14ms | 0.9× | 9.5% | PASS |
| file_writes | `oltp_delete_insert` | 96.26ms | 119.83ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 79.74ms | 67.65ms | 0.8× | 15.0% | PASS |
| file_writes | `types_delete_insert` | 72.42ms | 69.22ms | 1.0× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 153.87ms | 152.73ms | 1.0× | 4.7% | PASS |
| ac_reads | `oltp_point_select` | 58.60ms | 59.66ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 20.00ms | 18.97ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 18.25ms | 18.48ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_order_range` | 3.77ms | 3.89ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_distinct_range` | 4.69ms | 5.07ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.53ms | 8.78ms | 1.3× | 2.1% | PASS |
| ac_reads | `select_random_points` | 25.95ms | 25.23ms | 1.0× | 2.8% | PASS |
| ac_reads | `select_random_ranges` | 9.26ms | 9.09ms | 1.0× | 2.0% | PASS |
| ac_reads | `covering_index_scan` | 10.74ms | 13.34ms | 1.2× | 1.8% | PASS |
| ac_reads | `groupby_scan` | 35.42ms | 38.21ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 12.57ms | 11.89ms | 0.9× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 4.24ms | 6.99ms | 1.6× | 2.7% | PASS |
| ac_reads | `types_table_scan` | 1.11s | 1.42s | 1.3× | 1.6% | PASS |
| ac_reads | `table_scan` | 1.25s | 1.53s | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_read_only` | 174.49ms | 184.16ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.88ms | 61.16ms | 2.8× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 24.88ms | 74.30ms | 3.0× | 4.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.99ms | 92.00ms | 3.5× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.31ms | 72.16ms | 3.4× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.88ms | 82.86ms | 3.3× | 5.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.05ms | 81.03ms | 3.4× | 4.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.24ms | 72.00ms | 3.1× | 5.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.60ms | 87.83ms | 2.8× | 5.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.45ms | 41.13ms | 1.2× | 2.4% | PASS |
| mem_reads | `oltp_range_select` | 17.02ms | 17.62ms | 1.0× | 2.8% | PASS |
| mem_reads | `oltp_sum_range` | 15.43ms | 16.77ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 3.34ms | 3.74ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.28ms | 4.90ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.97ms | 6.75ms | 1.7× | 1.7% | PASS |
| mem_reads | `select_random_points` | 21.57ms | 22.60ms | 1.0× | 2.4% | PASS |
| mem_reads | `select_random_ranges` | 6.57ms | 7.00ms | 1.1× | 2.3% | PASS |
| mem_reads | `covering_index_scan` | 8.00ms | 11.21ms | 1.4× | 0.5% | PASS |
| mem_reads | `groupby_scan` | 34.57ms | 38.69ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 10.47ms | 10.84ms | 1.0× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.80ms | 6.52ms | 1.7× | 3.1% | PASS |
| mem_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.53s | 1.3× | 2.1% | PASS |
| mem_reads | `oltp_read_only` | 142.01ms | 159.77ms | 1.1× | 2.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.25ms | 361.61ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.12ms | 37.29ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 65.51ms | 140.83ms | 2.1× | 2.2% | PASS |
| mem_writes | `oltp_update_non_index` | 48.30ms | 81.54ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 53.06ms | 103.96ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 27.84ms | 56.22ms | 2.0× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 37.84ms | 59.91ms | 1.6× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 101.24ms | 145.25ms | 1.4× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 107.17ms | 60.15ms | 0.6× | 1.7% | PASS |
| file_reads | `oltp_range_select` | 24.46ms | 19.79ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 22.73ms | 18.98ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.20ms | 4.01ms | 1.0× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 5.24ms | 5.21ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 11.29ms | 8.86ms | 0.8× | 1.4% | PASS |
| file_reads | `select_random_points` | 31.04ms | 25.72ms | 0.8× | 3.4% | PASS |
| file_reads | `select_random_ranges` | 13.85ms | 9.05ms | 0.7× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 15.35ms | 13.33ms | 0.9× | 0.9% | PASS |
| file_reads | `groupby_scan` | 35.27ms | 39.00ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 14.33ms | 12.16ms | 0.8× | 2.1% | PASS |
| file_reads | `index_join_scan` | 4.72ms | 6.82ms | 1.4× | 1.9% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.8% | PASS |
| file_reads | `table_scan` | 1.19s | 1.52s | 1.3× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 240.35ms | 186.67ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 255.71ms | 377.00ms | 1.5× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.00ms | 41.93ms | 1.7× | 1.9% | PASS |
| file_writes | `oltp_update_index` | 96.71ms | 155.61ms | 1.6× | 2.0% | PASS |
| file_writes | `oltp_update_non_index` | 93.84ms | 93.61ms | 1.0× | 11.6% | PASS |
| file_writes | `oltp_delete_insert` | 86.02ms | 118.19ms | 1.4× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 57.37ms | 68.08ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 63.22ms | 69.26ms | 1.1× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 128.04ms | 153.76ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_point_select` | 57.27ms | 59.27ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 19.32ms | 19.63ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 17.68ms | 18.90ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_order_range` | 3.65ms | 4.01ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.63ms | 5.21ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.46ms | 8.81ms | 1.4× | 1.7% | PASS |
| ac_reads | `select_random_points` | 24.72ms | 25.30ms | 1.0× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 9.07ms | 9.07ms | 1.0× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.66ms | 13.29ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 34.90ms | 38.95ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 11.99ms | 12.20ms | 1.0× | 1.5% | PASS |
| ac_reads | `index_join_scan` | 4.23ms | 6.90ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.7% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.52s | 1.3× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 170.55ms | 186.96ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.92ms | 61.73ms | 2.8× | 5.8% | PASS |
| ac_writes | `oltp_insert_ac` | 24.50ms | 78.57ms | 3.2× | 6.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.25ms | 90.05ms | 3.6× | 5.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.55ms | 70.50ms | 3.3× | 5.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.06ms | 79.99ms | 3.3× | 3.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.43ms | 79.56ms | 3.3× | 5.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.39ms | 73.62ms | 3.3× | 6.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.93ms | 86.15ms | 2.9× | 6.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.68ms | 25.18ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 13.59ms | 14.82ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_sum_range` | 12.99ms | 13.81ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 2.54ms | 2.76ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.16ms | 3.42ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_index_scan` | 3.11ms | 4.35ms | 1.4× | 2.9% | PASS |
| mem_reads | `select_random_points` | 18.50ms | 22.07ms | 1.2× | 0.9% | PASS |
| mem_reads | `select_random_ranges` | 5.04ms | 5.97ms | 1.2× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 4.44ms | 6.53ms | 1.5× | 1.5% | PASS |
| mem_reads | `groupby_scan` | 23.84ms | 27.91ms | 1.2× | 1.3% | PASS |
| mem_reads | `index_join` | 5.58ms | 8.42ms | 1.5× | 4.1% | PASS |
| mem_reads | `index_join_scan` | 2.79ms | 4.83ms | 1.7× | 3.5% | PASS |
| mem_reads | `types_table_scan` | 758.55ms | 902.26ms | 1.2× | 2.6% | PASS |
| mem_reads | `table_scan` | 884.13ms | 1.01s | 1.1× | 3.5% | PASS |
| mem_reads | `oltp_read_only` | 94.90ms | 110.56ms | 1.2× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 135.76ms | 196.15ms | 1.4× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 11.49ms | 20.29ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 44.85ms | 86.86ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 32.42ms | 55.70ms | 1.7× | 2.8% | PASS |
| mem_writes | `oltp_delete_insert` | 32.73ms | 62.41ms | 1.9× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 18.42ms | 37.67ms | 2.0× | 2.3% | PASS |
| mem_writes | `types_delete_insert` | 20.54ms | 34.84ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 63.99ms | 98.58ms | 1.5× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 42.97ms | 30.17ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 16.25ms | 15.72ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 15.51ms | 14.71ms | 0.9× | 2.1% | PASS |
| file_reads | `oltp_order_range` | 2.76ms | 2.91ms | 1.1× | 3.1% | PASS |
| file_reads | `oltp_distinct_range` | 3.43ms | 3.54ms | 1.0× | 2.5% | PASS |
| file_reads | `oltp_index_scan` | 5.46ms | 5.08ms | 0.9× | 2.3% | PASS |
| file_reads | `select_random_points` | 20.79ms | 22.76ms | 1.1× | 2.0% | PASS |
| file_reads | `select_random_ranges` | 7.21ms | 6.56ms | 0.9× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 6.73ms | 7.17ms | 1.1× | 1.8% | PASS |
| file_reads | `groupby_scan` | 24.11ms | 28.14ms | 1.2× | 1.2% | PASS |
| file_reads | `index_join` | 7.01ms | 8.77ms | 1.2× | 2.1% | PASS |
| file_reads | `index_join_scan` | 3.17ms | 5.35ms | 1.7× | 4.3% | PASS |
| file_reads | `types_table_scan` | 774.43ms | 922.93ms | 1.2× | 1.5% | PASS |
| file_reads | `table_scan` | 900.38ms | 1.01s | 1.1× | 3.2% | PASS |
| file_reads | `oltp_read_only` | 121.49ms | 116.74ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_bulk_insert` | 187.14ms | 248.93ms | 1.3× | 4.3% | PASS |
| file_writes | `oltp_insert` | 27.06ms | 38.69ms | 1.4× | 2.5% | PASS |
| file_writes | `oltp_update_index` | 149.51ms | 153.83ms | 1.0× | 2.6% | PASS |
| file_writes | `oltp_update_non_index` | 124.11ms | 104.45ms | 0.8× | 2.4% | PASS |
| file_writes | `oltp_delete_insert` | 123.24ms | 119.52ms | 1.0× | 2.1% | PASS |
| file_writes | `oltp_write_only` | 90.98ms | 83.00ms | 0.9× | 1.9% | PASS |
| file_writes | `types_delete_insert` | 80.11ms | 67.81ms | 0.8× | 2.3% | PASS |
| file_writes | `oltp_read_write` | 132.16ms | 138.26ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 27.26ms | 29.50ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_range_select` | 14.33ms | 15.43ms | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 13.87ms | 14.39ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 2.67ms | 2.90ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.31ms | 3.51ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 4.08ms | 4.97ms | 1.2× | 2.7% | PASS |
| ac_reads | `select_random_points` | 19.23ms | 22.57ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 5.70ms | 6.47ms | 1.1× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 5.34ms | 7.11ms | 1.3× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 23.53ms | 27.55ms | 1.2× | 1.3% | PASS |
| ac_reads | `index_join` | 6.30ms | 8.83ms | 1.4× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 2.98ms | 5.25ms | 1.8× | 4.8% | PASS |
| ac_reads | `types_table_scan` | 752.55ms | 898.51ms | 1.2× | 0.9% | PASS |
| ac_reads | `table_scan` | 881.67ms | 1.02s | 1.2× | 3.8% | PASS |
| ac_reads | `oltp_read_only` | 104.43ms | 115.71ms | 1.1× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 31.41ms | 80.99ms | 2.6× | 3.3% | PASS |
| ac_writes | `oltp_insert_ac` | 32.75ms | 92.07ms | 2.8× | 3.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 33.83ms | 99.06ms | 2.9× | 3.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 31.37ms | 87.57ms | 2.8× | 4.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 33.36ms | 93.81ms | 2.8× | 3.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 33.27ms | 93.81ms | 2.8× | 4.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 31.12ms | 90.18ms | 2.9× | 5.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 36.82ms | 100.49ms | 2.7× | 3.5% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 11s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 30.24ms | 38.00ms | 79.6% | 1.2% | PASS |
| `status_dirty_many_tables` | 33.72ms | 42.00ms | 80.3% | 1.0% | PASS |
| `diff_regular_working_one_table` | 25.91ms | 33.00ms | 78.5% | 1.1% | PASS |
| `diff_regular_working_many_tables` | 38.37ms | 50.00ms | 76.7% | 0.7% | PASS |
| `diff_stat_working_many_tables` | 38.48ms | 48.00ms | 80.2% | 1.0% | PASS |
| `diff_schema_working_many_tables` | 38.98ms | 48.00ms | 81.2% | 0.7% | PASS |
| `branch_list_many_branches` | 18.36ms | 25.00ms | 73.4% | 0.9% | PASS |
| `branch_create_delete` | 19.78ms | 27.00ms | 73.2% | 0.9% | PASS |
| `at_literal_deep_history` | 20.12ms | 28.00ms | 71.9% | 1.0% | PASS |
| `diff_literal_deep_history` | 20.27ms | 28.00ms | 72.4% | 1.2% | PASS |
| `history_literal_deep_history` | 21.36ms | 30.00ms | 71.2% | 0.8% | PASS |
| `checkout_branch_clean` | 28.64ms | 43.00ms | 66.6% | 1.3% | PASS |
| `merge_data_no_conflicts` | 22.96ms | 33.00ms | 69.6% | 0.7% | PASS |
| `merge_data_secondary_index` | 852.24ms | 944.00ms | 90.3% | 0.8% | PASS |
| `merge_schema_no_conflicts` | 17.17ms | 24.00ms | 71.5% | 1.1% | PASS |
| `merge_data_conflicts` | 25.88ms | 33.00ms | 78.4% | 1.1% | PASS |
| `merge_data_conflicts_with_resolve` | 26.93ms | 34.00ms | 79.2% | 1.4% | PASS |

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
| copy_fsync | candidate | 57.724 | 54.775–63.453 | 37.867 | 1732.38 | 107968266 |
| push_initial | candidate | 578.091 | 575.360–600.882 | 561.084 | 172.98 | 107956772 |
| clone_initial | candidate | 751.779 | 747.177–753.958 | 727.174 | 133.02 | 108475035 |
| push_noop | candidate | 0.691 | 0.658–0.862 | 0.415 | — | 0 |
| fetch_noop | candidate | 0.239 | 0.197–0.264 | 0.240 | — | 0 |
| push_incremental | candidate | 228.584 | 227.862–229.035 | 226.122 | 4.37 | 7909775 |
| fetch_incremental | candidate | 95.115 | 94.683–95.540 | 92.450 | 10.51 | 7910084 |
| pull_fast_forward | candidate | 84.178 | 83.298–92.070 | 81.641 | 11.88 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.52 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.72 | 294.877 | 109.784 | 47190 | 2337 |
| push_noop | candidate | 45.88 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.88 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.88 | 96.634 | 7.910 | 22355 | 125 |
| fetch_incremental | candidate | 45.88 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.88 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 6366.543 | 6268.837–6390.784 | 371.121 | 157.07 | 1087718031 |
| push_initial | candidate | 8726.191 | 8701.974–8763.125 | 4468.868 | 114.60 | 1079566275 |
| clone_initial | candidate | 10687.121 | 10623.827–10693.342 | 6517.020 | 93.57 | 1102407326 |
| push_noop | candidate | 1.080 | 0.914–1.091 | 0.386 | — | 0 |
| fetch_noop | candidate | 0.135 | 0.120–0.139 | 0.137 | — | 0 |
| push_incremental | candidate | 1046.722 | 1044.882–1049.993 | 989.136 | 0.96 | 15806003 |
| fetch_incremental | candidate | 317.944 | 309.315–322.096 | 240.383 | 3.15 | 15806513 |
| pull_fast_forward | candidate | 321.777 | 298.805–322.587 | 246.216 | 3.11 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.75 | 2091.863 | 1087.622 | 263494 | 20541 |
| clone_initial | candidate | 124.11 | 3520.955 | 1132.819 | 613093 | 32243 |
| push_noop | candidate | 47.23 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.23 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.38 | 617.945 | 15.928 | 150101 | 313 |
| fetch_incremental | candidate | 50.40 | 62.295 | 15.928 | 13910 | 313 |
| pull_fast_forward | candidate | 50.48 | 62.228 | 15.929 | 13906 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
