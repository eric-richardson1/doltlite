# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-11-06 18:36 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42256506737)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 7.91s | 8.67s | 1.1× | 2.8% | **PASS** |
| Writes | 1.53s | 2.44s | 1.6× | 2.0% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.74s | 8.89s | 1.0× | 2.0% | **PASS** |
| Writes | 3.95s | 3.95s | 1.0× | 4.3% | **FAIL** |
| Autocommit writes | 759.91ms | 2.14s | 2.8× | 6.4% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.69s | 2.87s | 1.1× | 2.8% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.69s | 1.89s | 1.1× | 2.9% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 1.90s | 2.08s | 1.1× | 2.8% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.64s | 1.84s | 1.1× | 3.2% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 424.95ms | 696.29ms | 1.6× | 1.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 373.15ms | 578.82ms | 1.6× | 2.2% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 403.21ms | 628.30ms | 1.6× | 1.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 329.16ms | 538.35ms | 1.6× | 2.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.80s | 2.86s | 1.0× | 1.9% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.01s | 2.02s | 1.0× | 2.0% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.08s | 2.12s | 1.0× | 2.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.85s | 1.89s | 1.0× | 1.9% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 996.38ms | 1.04s | 1.0× | 2.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.06s | 1.01s | 0.9× | 4.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.01s | 1.01s | 1.0× | 4.7% | **FAIL** |
| File-backed | Writes | compositepk | 8 | 55 | 878.59ms | 900.83ms | 1.0× | 4.3% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.65s | 2.88s | 1.1× | 1.9% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 1.68s | 1.87s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.01s | 2.18s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.86s | 2.04s | 1.1× | 1.8% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 183.23ms | 636.10ms | 3.5× | 11.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 175.44ms | 493.79ms | 2.8× | 5.2% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 202.23ms | 515.43ms | 2.5× | 6.6% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 199.01ms | 493.60ms | 2.5× | 5.6% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 24.14ms | 28.66ms | 1.2× | 2.7% | PASS |
| mem_reads | `oltp_range_select` | 11.44ms | 12.16ms | 1.1× | 4.3% | PASS |
| mem_reads | `oltp_sum_range` | 9.82ms | 11.54ms | 1.2× | 3.8% | PASS |
| mem_reads | `oltp_order_range` | 2.72ms | 3.00ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_distinct_range` | 3.67ms | 3.99ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.94ms | 5.30ms | 1.3× | 3.2% | PASS |
| mem_reads | `select_random_points` | 11.41ms | 12.23ms | 1.1× | 5.8% | PASS |
| mem_reads | `select_random_ranges` | 4.74ms | 4.92ms | 1.0× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 7.56ms | 10.10ms | 1.3× | 2.1% | PASS |
| mem_reads | `groupby_scan` | 32.99ms | 35.85ms | 1.1× | 2.8% | PASS |
| mem_reads | `index_join` | 5.73ms | 8.83ms | 1.5× | 2.6% | PASS |
| mem_reads | `index_join_scan` | 3.70ms | 6.29ms | 1.7× | 2.3% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.26s | 1.1× | 2.0% | PASS |
| mem_reads | `table_scan` | 1.32s | 1.35s | 1.0× | 3.2% | PASS |
| mem_reads | `oltp_read_only` | 101.57ms | 116.33ms | 1.1× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 168.23ms | 273.10ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 14.65ms | 24.26ms | 1.7× | 1.4% | PASS |
| mem_writes | `oltp_update_index` | 51.02ms | 92.27ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 35.38ms | 57.82ms | 1.6× | 3.0% | PASS |
| mem_writes | `oltp_delete_insert` | 44.34ms | 71.19ms | 1.6× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 22.25ms | 44.94ms | 2.0× | 2.3% | PASS |
| mem_writes | `types_delete_insert` | 24.26ms | 32.77ms | 1.4× | 2.0% | PASS |
| mem_writes | `oltp_read_write` | 64.81ms | 99.96ms | 1.5× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 108.54ms | 48.31ms | 0.4× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 20.11ms | 14.21ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 18.54ms | 13.46ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 3.73ms | 3.27ms | 0.9× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 4.73ms | 4.34ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_index_scan` | 12.74ms | 7.47ms | 0.6× | 1.4% | PASS |
| file_reads | `select_random_points` | 19.90ms | 14.38ms | 0.7× | 2.0% | PASS |
| file_reads | `select_random_ranges` | 13.24ms | 6.97ms | 0.5× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 16.48ms | 11.99ms | 0.7× | 1.9% | PASS |
| file_reads | `groupby_scan` | 32.42ms | 34.72ms | 1.1× | 2.2% | PASS |
| file_reads | `index_join` | 10.47ms | 9.64ms | 0.9× | 2.0% | PASS |
| file_reads | `index_join_scan` | 4.42ms | 6.15ms | 1.4× | 2.5% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.21s | 1.1× | 1.1% | PASS |
| file_reads | `table_scan` | 1.23s | 1.33s | 1.1× | 1.5% | PASS |
| file_reads | `oltp_read_only` | 226.31ms | 146.83ms | 0.6× | 1.6% | PASS |
| file_writes | `oltp_bulk_insert` | 216.78ms | 328.29ms | 1.5× | 2.3% | PASS |
| file_writes | `oltp_insert` | 29.64ms | 38.30ms | 1.3× | 4.8% | PASS |
| file_writes | `oltp_update_index` | 156.45ms | 147.79ms | 0.9× | 2.0% | PASS |
| file_writes | `oltp_update_non_index` | 126.42ms | 102.38ms | 0.8× | 2.0% | PASS |
| file_writes | `oltp_delete_insert` | 135.35ms | 124.69ms | 0.9× | 2.2% | PASS |
| file_writes | `oltp_write_only` | 101.89ms | 87.04ms | 0.9× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 86.97ms | 66.94ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_read_write` | 142.88ms | 141.69ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_point_select` | 50.11ms | 48.61ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 14.55ms | 14.60ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 12.98ms | 13.79ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 3.23ms | 3.31ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 4.21ms | 4.36ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_index_scan` | 7.10ms | 7.61ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_points` | 13.76ms | 14.17ms | 1.0× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 7.42ms | 6.99ms | 0.9× | 2.1% | PASS |
| ac_reads | `covering_index_scan` | 10.54ms | 12.04ms | 1.1× | 2.0% | PASS |
| ac_reads | `groupby_scan` | 31.93ms | 35.00ms | 1.1× | 1.8% | PASS |
| ac_reads | `index_join` | 7.55ms | 9.74ms | 1.3× | 1.9% | PASS |
| ac_reads | `index_join_scan` | 3.83ms | 6.12ms | 1.6× | 2.8% | PASS |
| ac_reads | `types_table_scan` | 1.09s | 1.21s | 1.1× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.25s | 1.34s | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_read_only` | 144.20ms | 149.43ms | 1.0× | 2.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.06ms | 66.77ms | 3.3× | 13.0% | PASS |
| ac_writes | `oltp_insert_ac` | 22.70ms | 77.92ms | 3.4× | 9.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.92ms | 90.88ms | 3.6× | 10.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.52ms | 71.31ms | 3.5× | 14.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.33ms | 85.83ms | 3.7× | 13.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.25ms | 83.80ms | 3.6× | 10.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.20ms | 73.93ms | 3.7× | 11.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.25ms | 85.67ms | 3.0× | 9.6% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.89ms | 22.75ms | 1.0× | 4.9% | PASS |
| mem_reads | `oltp_range_select` | 11.08ms | 9.79ms | 0.9× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 11.34ms | 9.90ms | 0.9× | 2.6% | PASS |
| mem_reads | `oltp_order_range` | 2.29ms | 2.15ms | 0.9× | 2.1% | PASS |
| mem_reads | `oltp_distinct_range` | 2.76ms | 2.64ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_index_scan` | 2.43ms | 4.33ms | 1.8× | 2.9% | PASS |
| mem_reads | `select_random_points` | 16.13ms | 14.33ms | 0.9× | 4.3% | PASS |
| mem_reads | `select_random_ranges` | 4.09ms | 3.98ms | 1.0× | 4.3% | PASS |
| mem_reads | `covering_index_scan` | 3.89ms | 6.16ms | 1.6× | 2.2% | PASS |
| mem_reads | `groupby_scan` | 21.96ms | 21.63ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 8.03ms | 7.43ms | 0.9× | 3.2% | PASS |
| mem_reads | `index_join_scan` | 2.83ms | 5.56ms | 2.0× | 4.1% | PASS |
| mem_reads | `types_table_scan` | 698.26ms | 802.99ms | 1.1× | 1.4% | PASS |
| mem_reads | `table_scan` | 804.25ms | 900.22ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_read_only` | 79.69ms | 78.36ms | 1.0× | 4.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 132.93ms | 195.63ms | 1.5× | 1.5% | PASS |
| mem_writes | `oltp_insert` | 9.96ms | 21.09ms | 2.1× | 1.7% | PASS |
| mem_writes | `oltp_update_index` | 43.01ms | 87.05ms | 2.0× | 2.5% | PASS |
| mem_writes | `oltp_update_non_index` | 33.43ms | 49.97ms | 1.5× | 2.4% | PASS |
| mem_writes | `oltp_delete_insert` | 35.27ms | 64.43ms | 1.8× | 2.8% | PASS |
| mem_writes | `oltp_write_only` | 19.94ms | 36.61ms | 1.8× | 2.6% | PASS |
| mem_writes | `types_delete_insert` | 28.18ms | 37.82ms | 1.3× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 70.44ms | 86.24ms | 1.2× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 81.42ms | 39.03ms | 0.5× | 2.0% | PASS |
| file_reads | `oltp_range_select` | 17.19ms | 11.46ms | 0.7× | 2.4% | PASS |
| file_reads | `oltp_sum_range` | 16.37ms | 11.26ms | 0.7× | 2.7% | PASS |
| file_reads | `oltp_order_range` | 3.02ms | 2.39ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 3.57ms | 2.93ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 8.36ms | 5.89ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 23.86ms | 16.35ms | 0.7× | 3.1% | PASS |
| file_reads | `select_random_ranges` | 10.03ms | 5.50ms | 0.5× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 9.79ms | 7.52ms | 0.8× | 2.1% | PASS |
| file_reads | `groupby_scan` | 22.27ms | 21.65ms | 1.0× | 1.9% | PASS |
| file_reads | `index_join` | 10.66ms | 7.51ms | 0.7× | 2.0% | PASS |
| file_reads | `index_join_scan` | 3.40ms | 5.08ms | 1.5× | 3.5% | PASS |
| file_reads | `types_table_scan` | 697.39ms | 807.29ms | 1.2× | 2.0% | PASS |
| file_reads | `table_scan` | 949.22ms | 974.90ms | 1.0× | 4.9% | PASS |
| file_reads | `oltp_read_only` | 152.85ms | 98.42ms | 0.6× | 2.0% | PASS |
| file_writes | `oltp_bulk_insert` | 210.92ms | 269.75ms | 1.3× | 3.9% | PASS |
| file_writes | `oltp_insert` | 19.99ms | 41.01ms | 2.1× | 9.5% | PASS |
| file_writes | `oltp_update_index` | 152.36ms | 169.27ms | 1.1× | 4.6% | PASS |
| file_writes | `oltp_update_non_index` | 131.26ms | 104.83ms | 0.8× | 5.2% | PASS |
| file_writes | `oltp_delete_insert` | 161.78ms | 129.63ms | 0.8× | 5.3% | PASS |
| file_writes | `oltp_write_only` | 111.47ms | 87.39ms | 0.8× | 3.3% | PASS |
| file_writes | `types_delete_insert` | 130.52ms | 76.78ms | 0.6× | 6.6% | PASS |
| file_writes | `oltp_read_write` | 145.99ms | 129.00ms | 0.9× | 4.0% | PASS |
| ac_reads | `oltp_point_select` | 38.43ms | 35.91ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 11.91ms | 10.91ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 12.80ms | 11.14ms | 0.9× | 3.2% | PASS |
| ac_reads | `oltp_order_range` | 2.54ms | 2.37ms | 0.9× | 4.2% | PASS |
| ac_reads | `oltp_distinct_range` | 2.97ms | 2.79ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_index_scan` | 4.22ms | 5.62ms | 1.3× | 2.5% | PASS |
| ac_reads | `select_random_points` | 16.88ms | 14.98ms | 0.9× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 6.20ms | 5.40ms | 0.9× | 2.1% | PASS |
| ac_reads | `covering_index_scan` | 5.99ms | 7.70ms | 1.3× | 2.2% | PASS |
| ac_reads | `groupby_scan` | 22.47ms | 22.01ms | 1.0× | 2.0% | PASS |
| ac_reads | `index_join` | 9.13ms | 7.72ms | 0.8× | 2.9% | PASS |
| ac_reads | `index_join_scan` | 2.96ms | 4.91ms | 1.7× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 675.53ms | 779.54ms | 1.2× | 1.0% | PASS |
| ac_reads | `table_scan` | 766.84ms | 863.25ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_read_only` | 97.40ms | 94.13ms | 1.0× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.43ms | 52.60ms | 2.6× | 5.3% | PASS |
| ac_writes | `oltp_insert_ac` | 22.11ms | 58.68ms | 2.7× | 4.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.80ms | 69.51ms | 3.2× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.79ms | 56.84ms | 2.9× | 3.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.32ms | 66.11ms | 3.0× | 5.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.82ms | 63.19ms | 2.9× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.88ms | 58.06ms | 2.8× | 6.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.31ms | 68.79ms | 2.6× | 3.4% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.67ms | 25.06ms | 1.0× | 2.8% | PASS |
| mem_reads | `oltp_range_select` | 11.57ms | 10.35ms | 0.9× | 3.1% | PASS |
| mem_reads | `oltp_sum_range` | 10.94ms | 10.38ms | 0.9× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 2.28ms | 2.25ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_distinct_range` | 2.83ms | 2.77ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 2.71ms | 4.76ms | 1.8× | 2.4% | PASS |
| mem_reads | `select_random_points` | 18.15ms | 16.19ms | 0.9× | 3.1% | PASS |
| mem_reads | `select_random_ranges` | 4.81ms | 4.48ms | 0.9× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 4.26ms | 7.06ms | 1.7× | 2.9% | PASS |
| mem_reads | `groupby_scan` | 22.99ms | 23.16ms | 1.0× | 1.0% | PASS |
| mem_reads | `index_join` | 9.20ms | 9.44ms | 1.0× | 4.3% | PASS |
| mem_reads | `index_join_scan` | 3.33ms | 7.04ms | 2.1× | 4.7% | PASS |
| mem_reads | `types_table_scan` | 791.74ms | 904.05ms | 1.1× | 2.9% | PASS |
| mem_reads | `table_scan` | 892.76ms | 964.80ms | 1.1× | 4.2% | PASS |
| mem_reads | `oltp_read_only` | 93.52ms | 86.49ms | 0.9× | 2.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 140.72ms | 205.53ms | 1.5× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 11.25ms | 23.92ms | 2.1× | 1.7% | PASS |
| mem_writes | `oltp_update_index` | 51.14ms | 100.42ms | 2.0× | 3.0% | PASS |
| mem_writes | `oltp_update_non_index` | 39.07ms | 55.91ms | 1.4× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 39.72ms | 72.69ms | 1.8× | 1.9% | PASS |
| mem_writes | `oltp_write_only` | 21.67ms | 40.14ms | 1.9× | 1.9% | PASS |
| mem_writes | `types_delete_insert` | 28.62ms | 39.44ms | 1.4× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 71.01ms | 90.25ms | 1.3× | 4.3% | PASS |
| file_reads | `oltp_point_select` | 77.85ms | 38.27ms | 0.5× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 16.30ms | 11.19ms | 0.7× | 2.6% | PASS |
| file_reads | `oltp_sum_range` | 16.53ms | 11.19ms | 0.7× | 3.5% | PASS |
| file_reads | `oltp_order_range` | 2.93ms | 2.43ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 3.50ms | 3.01ms | 0.9× | 3.2% | PASS |
| file_reads | `oltp_index_scan` | 8.42ms | 5.90ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_points` | 21.43ms | 15.56ms | 0.7× | 4.2% | PASS |
| file_reads | `select_random_ranges` | 9.97ms | 5.52ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 10.27ms | 7.89ms | 0.8× | 2.0% | PASS |
| file_reads | `groupby_scan` | 22.58ms | 22.15ms | 1.0× | 1.3% | PASS |
| file_reads | `index_join` | 12.17ms | 8.54ms | 0.7× | 5.6% | PASS |
| file_reads | `index_join_scan` | 3.61ms | 5.31ms | 1.5× | 5.0% | PASS |
| file_reads | `types_table_scan` | 764.85ms | 876.46ms | 1.1× | 2.0% | PASS |
| file_reads | `table_scan` | 935.47ms | 998.66ms | 1.1× | 2.5% | PASS |
| file_reads | `oltp_read_only` | 174.78ms | 109.12ms | 0.6× | 1.9% | PASS |
| file_writes | `oltp_bulk_insert` | 203.97ms | 268.51ms | 1.3× | 3.1% | PASS |
| file_writes | `oltp_insert` | 18.89ms | 46.20ms | 2.4× | 2.8% | FAIL |
| file_writes | `oltp_update_index` | 150.88ms | 175.98ms | 1.2× | 3.7% | PASS |
| file_writes | `oltp_update_non_index` | 129.73ms | 108.38ms | 0.8× | 5.9% | PASS |
| file_writes | `oltp_delete_insert` | 146.55ms | 126.33ms | 0.9× | 6.4% | PASS |
| file_writes | `oltp_write_only` | 101.02ms | 82.84ms | 0.8× | 4.3% | PASS |
| file_writes | `types_delete_insert` | 107.04ms | 71.02ms | 0.7× | 6.3% | PASS |
| file_writes | `oltp_read_write` | 147.97ms | 128.48ms | 0.9× | 5.1% | PASS |
| ac_reads | `oltp_point_select` | 42.10ms | 38.92ms | 0.9× | 2.4% | PASS |
| ac_reads | `oltp_range_select` | 13.12ms | 11.46ms | 0.9× | 3.3% | PASS |
| ac_reads | `oltp_sum_range` | 12.81ms | 11.38ms | 0.9× | 3.7% | PASS |
| ac_reads | `oltp_order_range` | 2.58ms | 2.42ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 3.11ms | 2.95ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 4.94ms | 5.96ms | 1.2× | 2.1% | PASS |
| ac_reads | `select_random_points` | 18.17ms | 15.94ms | 0.9× | 3.2% | PASS |
| ac_reads | `select_random_ranges` | 6.61ms | 5.67ms | 0.9× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 6.68ms | 7.96ms | 1.2× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 22.95ms | 22.84ms | 1.0× | 1.4% | PASS |
| ac_reads | `index_join` | 10.19ms | 8.60ms | 0.8× | 3.2% | PASS |
| ac_reads | `index_join_scan` | 3.38ms | 5.63ms | 1.7× | 5.8% | PASS |
| ac_reads | `types_table_scan` | 814.77ms | 933.48ms | 1.1× | 1.7% | PASS |
| ac_reads | `table_scan` | 930.07ms | 1.00s | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 120.79ms | 107.25ms | 0.9× | 2.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.10ms | 53.93ms | 2.2× | 6.9% | PASS |
| ac_writes | `oltp_insert_ac` | 27.51ms | 65.66ms | 2.4× | 6.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.14ms | 72.47ms | 2.7× | 6.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.87ms | 58.88ms | 2.8× | 4.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.49ms | 66.45ms | 2.5× | 6.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.86ms | 65.55ms | 2.5× | 8.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.28ms | 60.12ms | 2.8× | 4.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.96ms | 72.37ms | 2.5× | 5.7% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 18.24ms | 21.99ms | 1.2× | 5.1% | PASS |
| mem_reads | `oltp_range_select` | 10.43ms | 11.76ms | 1.1× | 4.9% | PASS |
| mem_reads | `oltp_sum_range` | 9.45ms | 11.29ms | 1.2× | 3.7% | PASS |
| mem_reads | `oltp_order_range` | 2.06ms | 2.21ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_distinct_range` | 2.50ms | 2.68ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_index_scan` | 2.50ms | 3.69ms | 1.5× | 3.7% | PASS |
| mem_reads | `select_random_points` | 14.06ms | 17.39ms | 1.2× | 5.9% | PASS |
| mem_reads | `select_random_ranges` | 3.91ms | 4.88ms | 1.2× | 4.2% | PASS |
| mem_reads | `covering_index_scan` | 3.84ms | 5.55ms | 1.4× | 1.4% | PASS |
| mem_reads | `groupby_scan` | 20.67ms | 22.62ms | 1.1× | 1.6% | PASS |
| mem_reads | `index_join` | 4.42ms | 6.44ms | 1.5× | 2.7% | PASS |
| mem_reads | `index_join_scan` | 2.06ms | 4.38ms | 2.1× | 3.8% | PASS |
| mem_reads | `types_table_scan` | 681.63ms | 775.48ms | 1.1× | 1.2% | PASS |
| mem_reads | `table_scan` | 780.53ms | 857.88ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_read_only` | 79.00ms | 88.38ms | 1.1× | 3.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 136.48ms | 194.11ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 10.53ms | 19.23ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 37.71ms | 72.19ms | 1.9× | 2.6% | PASS |
| mem_writes | `oltp_update_non_index` | 30.00ms | 50.62ms | 1.7× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 28.56ms | 55.55ms | 1.9× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 15.74ms | 35.17ms | 2.2× | 2.7% | PASS |
| mem_writes | `types_delete_insert` | 19.34ms | 30.42ms | 1.6× | 2.7% | PASS |
| mem_writes | `oltp_read_write` | 50.80ms | 81.04ms | 1.6× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 69.79ms | 35.73ms | 0.5× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 16.11ms | 13.16ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 15.12ms | 12.76ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 2.77ms | 2.42ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.42ms | 3.01ms | 0.9× | 2.3% | PASS |
| file_reads | `oltp_index_scan` | 9.01ms | 5.98ms | 0.7× | 3.7% | PASS |
| file_reads | `select_random_points` | 21.00ms | 18.92ms | 0.9× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 9.58ms | 6.38ms | 0.7× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 9.57ms | 7.07ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 21.78ms | 22.85ms | 1.0× | 1.2% | PASS |
| file_reads | `index_join` | 7.79ms | 7.69ms | 1.0× | 2.2% | PASS |
| file_reads | `index_join_scan` | 3.29ms | 4.68ms | 1.4× | 3.2% | PASS |
| file_reads | `types_table_scan` | 696.32ms | 775.70ms | 1.1× | 1.9% | PASS |
| file_reads | `table_scan` | 807.78ms | 865.39ms | 1.1× | 3.8% | PASS |
| file_reads | `oltp_read_only` | 153.99ms | 107.98ms | 0.7× | 1.6% | PASS |
| file_writes | `oltp_bulk_insert` | 188.51ms | 240.40ms | 1.3× | 4.7% | PASS |
| file_writes | `oltp_insert` | 19.48ms | 30.01ms | 1.5× | 6.2% | PASS |
| file_writes | `oltp_update_index` | 141.24ms | 137.54ms | 1.0× | 3.7% | PASS |
| file_writes | `oltp_update_non_index` | 120.86ms | 97.19ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_delete_insert` | 120.12ms | 115.76ms | 1.0× | 3.4% | PASS |
| file_writes | `oltp_write_only` | 81.13ms | 80.92ms | 1.0× | 3.3% | PASS |
| file_writes | `types_delete_insert` | 77.48ms | 68.22ms | 0.9× | 6.3% | PASS |
| file_writes | `oltp_read_write` | 129.77ms | 130.78ms | 1.0× | 4.3% | PASS |
| ac_reads | `oltp_point_select` | 40.79ms | 39.76ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 13.78ms | 14.27ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_sum_range` | 12.27ms | 13.79ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 2.57ms | 2.64ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.08ms | 3.11ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 4.80ms | 5.61ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 19.11ms | 20.75ms | 1.1× | 2.6% | PASS |
| ac_reads | `select_random_ranges` | 6.82ms | 7.01ms | 1.0× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 6.78ms | 8.14ms | 1.2× | 2.3% | PASS |
| ac_reads | `groupby_scan` | 23.48ms | 25.09ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 6.36ms | 8.44ms | 1.3× | 2.4% | PASS |
| ac_reads | `index_join_scan` | 3.30ms | 5.22ms | 1.6× | 3.1% | PASS |
| ac_reads | `types_table_scan` | 782.45ms | 847.38ms | 1.1× | 4.3% | PASS |
| ac_reads | `table_scan` | 823.66ms | 921.24ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 107.59ms | 114.32ms | 1.1× | 1.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.13ms | 53.12ms | 2.4× | 2.1% | PASS |
| ac_writes | `oltp_insert_ac` | 25.96ms | 63.70ms | 2.5× | 7.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.35ms | 68.99ms | 2.5× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.41ms | 57.19ms | 2.7× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.63ms | 61.73ms | 2.5× | 5.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.80ms | 62.24ms | 2.5× | 5.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 25.43ms | 58.73ms | 2.3× | 9.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.29ms | 67.90ms | 2.5× | 5.6% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 18s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.86ms | 38.00ms | 83.9% | 1.4% | PASS |
| `status_dirty_many_tables` | 35.58ms | 42.00ms | 84.7% | 0.8% | PASS |
| `diff_regular_working_one_table` | 27.67ms | 33.00ms | 83.8% | 0.9% | PASS |
| `diff_regular_working_many_tables` | 40.99ms | 50.00ms | 82.0% | 1.0% | PASS |
| `diff_stat_working_many_tables` | 40.86ms | 48.00ms | 85.1% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 41.17ms | 48.00ms | 85.8% | 0.9% | PASS |
| `branch_list_many_branches` | 19.84ms | 25.00ms | 79.4% | 1.4% | PASS |
| `branch_create_delete` | 20.66ms | 27.00ms | 76.5% | 2.1% | PASS |
| `at_literal_deep_history` | 20.52ms | 28.00ms | 73.3% | 1.3% | PASS |
| `diff_literal_deep_history` | 20.31ms | 28.00ms | 72.5% | 1.0% | PASS |
| `history_literal_deep_history` | 21.96ms | 30.00ms | 73.2% | 1.1% | PASS |
| `checkout_branch_clean` | 29.66ms | 43.00ms | 69.0% | 1.2% | PASS |
| `merge_data_no_conflicts` | 24.41ms | 33.00ms | 74.0% | 1.9% | PASS |
| `merge_data_secondary_index` | 885.26ms | 944.00ms | 93.8% | 1.0% | PASS |
| `merge_schema_no_conflicts` | 18.15ms | 24.00ms | 75.6% | 2.0% | PASS |
| `merge_data_conflicts` | 26.95ms | 33.00ms | 81.7% | 1.5% | PASS |
| `merge_data_conflicts_with_resolve` | 27.84ms | 34.00ms | 81.9% | 1.0% | PASS |

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
| copy_fsync | candidate | 57.063 | 56.456–64.150 | 39.518 | 1752.45 | 107968266 |
| push_initial | candidate | 592.588 | 582.641–597.492 | 575.840 | 168.75 | 107956772 |
| clone_initial | candidate | 769.522 | 766.395–771.163 | 745.136 | 129.95 | 108475035 |
| push_noop | candidate | 0.742 | 0.661–0.790 | 0.401 | — | 0 |
| fetch_noop | candidate | 0.250 | 0.196–0.263 | 0.257 | — | 0 |
| push_incremental | candidate | 231.503 | 230.660–233.314 | 228.654 | 4.32 | 7909775 |
| fetch_incremental | candidate | 95.875 | 95.590–97.382 | 93.477 | 10.43 | 7910084 |
| pull_fast_forward | candidate | 86.743 | 85.783–88.617 | 83.143 | 11.53 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.49 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.72 | 295.257 | 109.784 | 47281 | 2337 |
| push_noop | candidate | 45.92 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.92 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.92 | 97.033 | 7.910 | 22452 | 125 |
| fetch_incremental | candidate | 45.92 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.92 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5440.750 | 5417.023–5444.440 | 335.755 | 183.80 | 1087718031 |
| push_initial | candidate | 8336.471 | 8320.602–8395.794 | 3371.206 | 119.95 | 1079566275 |
| clone_initial | candidate | 8582.082 | 8579.546–8751.016 | 4911.883 | 116.52 | 1102407326 |
| push_noop | candidate | 0.779 | 0.725–0.960 | 0.250 | — | 0 |
| fetch_noop | candidate | 0.111 | 0.093–0.120 | 0.112 | — | 0 |
| push_incremental | candidate | 772.139 | 767.557–848.575 | 719.237 | 1.30 | 15806003 |
| fetch_incremental | candidate | 247.417 | 234.435–254.593 | 183.821 | 4.04 | 15806513 |
| pull_fast_forward | candidate | 228.108 | 228.081–229.396 | 180.198 | 4.38 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.82 | 2091.161 | 1087.622 | 263323 | 20541 |
| clone_initial | candidate | 123.90 | 3516.620 | 1132.819 | 611962 | 32243 |
| push_noop | candidate | 47.23 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.23 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.25 | 616.380 | 15.928 | 149685 | 313 |
| fetch_incremental | candidate | 50.40 | 62.053 | 15.928 | 13851 | 313 |
| pull_fast_forward | candidate | 50.40 | 61.986 | 15.929 | 13847 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
