# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-11-05 19:32 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42076065808)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.96s | 10.44s | 1.2× | 2.0% | **PASS** |
| Writes | 1.80s | 3.01s | 1.7× | 1.8% | **FAIL** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.49s | 10.51s | 1.1× | 1.8% | **PASS** |
| Writes | 3.36s | 3.86s | 1.1× | 2.3% | **PASS** |
| Autocommit writes | 751.59ms | 2.27s | 3.0× | 6.0% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.76s | 1.83s | 1.0× | 3.1% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.74s | 1.93s | 1.1× | 2.3% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.71s | 3.32s | 1.2× | 1.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.75s | 3.36s | 1.2× | 1.4% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 262.39ms | 455.89ms | 1.7× | 2.1% | **FAIL** |
| In-memory | Writes | textpk | 8 | 55 | 366.88ms | 586.12ms | 1.6× | 2.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 583.51ms | 974.83ms | 1.7× | 1.7% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 588.07ms | 991.41ms | 1.7× | 1.6% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.84s | 1.80s | 1.0× | 1.3% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 1.96s | 1.97s | 1.0× | 2.4% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.77s | 3.33s | 1.2× | 1.9% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.93s | 3.41s | 1.2× | 1.4% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 707.29ms | 707.30ms | 1.0× | 2.9% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.09s | 1.02s | 0.9× | 5.4% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 803.72ms | 1.07s | 1.3× | 1.9% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 763.69ms | 1.06s | 1.4× | 1.8% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.62s | 1.74s | 1.1× | 1.5% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.03s | 2.09s | 1.0× | 2.3% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.94s | 3.50s | 1.2× | 1.7% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.80s | 3.42s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 166.71ms | 480.71ms | 2.9× | 4.7% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 181.23ms | 506.19ms | 2.8× | 5.2% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 212.62ms | 668.26ms | 3.1× | 8.1% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 191.04ms | 612.22ms | 3.2× | 6.8% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 13.17ms | 17.07ms | 1.3× | 4.9% | PASS |
| mem_reads | `oltp_range_select` | 5.39ms | 6.69ms | 1.2× | 5.1% | PASS |
| mem_reads | `oltp_sum_range` | 5.45ms | 6.81ms | 1.2× | 4.4% | PASS |
| mem_reads | `oltp_order_range` | 1.58ms | 1.74ms | 1.1× | 3.1% | PASS |
| mem_reads | `oltp_distinct_range` | 2.09ms | 2.25ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_index_scan` | 2.36ms | 3.35ms | 1.4× | 3.2% | PASS |
| mem_reads | `select_random_points` | 7.82ms | 8.47ms | 1.1× | 5.3% | PASS |
| mem_reads | `select_random_ranges` | 2.84ms | 3.06ms | 1.1× | 2.5% | PASS |
| mem_reads | `covering_index_scan` | 4.02ms | 5.92ms | 1.5× | 2.9% | PASS |
| mem_reads | `groupby_scan` | 18.84ms | 20.04ms | 1.1× | 1.7% | PASS |
| mem_reads | `index_join` | 3.54ms | 5.84ms | 1.7× | 5.0% | PASS |
| mem_reads | `index_join_scan` | 2.58ms | 4.29ms | 1.7× | 5.0% | PASS |
| mem_reads | `types_table_scan` | 726.32ms | 786.66ms | 1.1× | 1.4% | PASS |
| mem_reads | `table_scan` | 895.35ms | 883.63ms | 1.0× | 1.9% | PASS |
| mem_reads | `oltp_read_only` | 64.58ms | 70.01ms | 1.1× | 2.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 108.00ms | 177.34ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 9.26ms | 16.16ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 31.86ms | 61.03ms | 1.9× | 2.1% | PASS |
| mem_writes | `oltp_update_non_index` | 21.88ms | 39.01ms | 1.8× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 26.38ms | 46.92ms | 1.8× | 2.7% | PASS |
| mem_writes | `oltp_write_only` | 12.80ms | 30.21ms | 2.4× | 1.4% | FAIL |
| mem_writes | `types_delete_insert` | 15.57ms | 21.95ms | 1.4× | 2.8% | PASS |
| mem_writes | `oltp_read_write` | 36.65ms | 63.27ms | 1.7× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 69.20ms | 32.68ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 12.07ms | 8.65ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_sum_range` | 11.61ms | 8.68ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 2.30ms | 2.04ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_distinct_range` | 2.83ms | 2.54ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 8.13ms | 4.95ms | 0.6× | 0.8% | PASS |
| file_reads | `select_random_points` | 13.18ms | 10.09ms | 0.8× | 1.3% | PASS |
| file_reads | `select_random_ranges` | 8.26ms | 4.49ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 9.95ms | 7.29ms | 0.7× | 1.4% | PASS |
| file_reads | `groupby_scan` | 19.25ms | 20.08ms | 1.0× | 0.7% | PASS |
| file_reads | `index_join` | 6.79ms | 6.35ms | 0.9× | 2.1% | PASS |
| file_reads | `index_join_scan` | 2.99ms | 4.36ms | 1.5× | 2.6% | PASS |
| file_reads | `types_table_scan` | 724.77ms | 763.04ms | 1.1× | 2.2% | PASS |
| file_reads | `table_scan` | 811.29ms | 844.12ms | 1.0× | 2.7% | PASS |
| file_reads | `oltp_read_only` | 133.05ms | 85.47ms | 0.6× | 2.0% | PASS |
| file_writes | `oltp_bulk_insert` | 140.58ms | 218.70ms | 1.6× | 2.3% | PASS |
| file_writes | `oltp_insert` | 19.83ms | 26.36ms | 1.3× | 6.7% | PASS |
| file_writes | `oltp_update_index` | 121.22ms | 102.73ms | 0.8× | 5.3% | PASS |
| file_writes | `oltp_update_non_index` | 100.78ms | 77.69ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_delete_insert` | 101.05ms | 89.13ms | 0.9× | 3.5% | PASS |
| file_writes | `oltp_write_only` | 71.47ms | 59.43ms | 0.8× | 2.3% | PASS |
| file_writes | `types_delete_insert` | 60.78ms | 43.56ms | 0.7× | 6.6% | PASS |
| file_writes | `oltp_read_write` | 91.58ms | 89.70ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_point_select` | 29.55ms | 30.57ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 7.54ms | 8.43ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 7.28ms | 8.52ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 1.80ms | 1.99ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 2.32ms | 2.50ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 4.01ms | 4.83ms | 1.2× | 2.2% | PASS |
| ac_reads | `select_random_points` | 8.42ms | 9.76ms | 1.2× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 4.32ms | 4.37ms | 1.0× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 5.58ms | 7.01ms | 1.3× | 2.1% | PASS |
| ac_reads | `groupby_scan` | 17.78ms | 19.23ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 4.39ms | 6.18ms | 1.4× | 2.1% | PASS |
| ac_reads | `index_join_scan` | 2.31ms | 4.19ms | 1.8× | 3.2% | PASS |
| ac_reads | `types_table_scan` | 691.33ms | 738.11ms | 1.1× | 1.2% | PASS |
| ac_reads | `table_scan` | 755.66ms | 808.03ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 79.03ms | 84.50ms | 1.1× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.41ms | 51.78ms | 2.7× | 3.8% | PASS |
| ac_writes | `oltp_insert_ac` | 21.01ms | 58.86ms | 2.8× | 4.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.61ms | 70.11ms | 3.1× | 4.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.34ms | 55.39ms | 2.9× | 5.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.83ms | 60.68ms | 2.9× | 5.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.39ms | 61.16ms | 3.0× | 4.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.44ms | 57.55ms | 3.0× | 4.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 23.67ms | 65.19ms | 2.8× | 4.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.51ms | 23.34ms | 1.0× | 2.9% | PASS |
| mem_reads | `oltp_range_select` | 11.52ms | 9.96ms | 0.9× | 3.2% | PASS |
| mem_reads | `oltp_sum_range` | 10.95ms | 9.86ms | 0.9× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 2.38ms | 2.21ms | 0.9× | 1.8% | PASS |
| mem_reads | `oltp_distinct_range` | 2.90ms | 2.82ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_index_scan` | 2.62ms | 4.60ms | 1.8× | 2.1% | PASS |
| mem_reads | `select_random_points` | 17.84ms | 14.80ms | 0.8× | 3.2% | PASS |
| mem_reads | `select_random_ranges` | 4.58ms | 4.13ms | 0.9× | 2.2% | PASS |
| mem_reads | `covering_index_scan` | 3.96ms | 6.36ms | 1.6× | 2.9% | PASS |
| mem_reads | `groupby_scan` | 22.42ms | 22.27ms | 1.0× | 1.5% | PASS |
| mem_reads | `index_join` | 8.07ms | 7.52ms | 0.9× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 3.03ms | 5.91ms | 2.0× | 4.1% | PASS |
| mem_reads | `types_table_scan` | 711.02ms | 821.54ms | 1.2× | 1.3% | PASS |
| mem_reads | `table_scan` | 819.35ms | 911.57ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 97.36ms | 86.90ms | 0.9× | 3.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 139.64ms | 206.49ms | 1.5× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 10.47ms | 22.86ms | 2.2× | 2.8% | PASS |
| mem_writes | `oltp_update_index` | 45.93ms | 93.40ms | 2.0× | 2.7% | PASS |
| mem_writes | `oltp_update_non_index` | 34.14ms | 51.48ms | 1.5× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 33.59ms | 62.18ms | 1.9× | 1.7% | PASS |
| mem_writes | `oltp_write_only` | 18.61ms | 34.56ms | 1.9× | 2.5% | PASS |
| mem_writes | `types_delete_insert` | 25.71ms | 36.18ms | 1.4× | 3.8% | PASS |
| mem_writes | `oltp_read_write` | 58.80ms | 78.96ms | 1.3× | 4.8% | PASS |
| file_reads | `oltp_point_select` | 75.65ms | 37.20ms | 0.5× | 2.6% | PASS |
| file_reads | `oltp_range_select` | 17.12ms | 11.25ms | 0.7× | 2.4% | PASS |
| file_reads | `oltp_sum_range` | 16.70ms | 11.11ms | 0.7× | 2.4% | PASS |
| file_reads | `oltp_order_range` | 3.02ms | 2.36ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 3.51ms | 3.01ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 8.26ms | 5.81ms | 0.7× | 2.3% | PASS |
| file_reads | `select_random_points` | 21.91ms | 15.18ms | 0.7× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 10.26ms | 5.55ms | 0.5× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 10.26ms | 7.79ms | 0.8× | 1.9% | PASS |
| file_reads | `groupby_scan` | 23.41ms | 22.42ms | 1.0× | 1.7% | PASS |
| file_reads | `index_join` | 11.49ms | 7.74ms | 0.7× | 2.6% | PASS |
| file_reads | `index_join_scan` | 3.48ms | 5.08ms | 1.5× | 4.4% | PASS |
| file_reads | `types_table_scan` | 707.69ms | 809.91ms | 1.1× | 2.3% | PASS |
| file_reads | `table_scan` | 876.46ms | 927.07ms | 1.1× | 2.8% | PASS |
| file_reads | `oltp_read_only` | 166.35ms | 101.81ms | 0.6× | 2.6% | PASS |
| file_writes | `oltp_bulk_insert` | 214.88ms | 270.76ms | 1.3× | 3.5% | PASS |
| file_writes | `oltp_insert` | 19.77ms | 45.20ms | 2.3× | 9.3% | PASS |
| file_writes | `oltp_update_index` | 160.80ms | 170.49ms | 1.1× | 5.1% | PASS |
| file_writes | `oltp_update_non_index` | 131.47ms | 107.87ms | 0.8× | 6.6% | PASS |
| file_writes | `oltp_delete_insert` | 170.54ms | 128.86ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_write_only` | 111.16ms | 87.58ms | 0.8× | 5.7% | PASS |
| file_writes | `types_delete_insert` | 129.46ms | 77.01ms | 0.6× | 6.7% | PASS |
| file_writes | `oltp_read_write` | 150.46ms | 129.36ms | 0.9× | 3.4% | PASS |
| ac_reads | `oltp_point_select` | 40.45ms | 37.11ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 12.96ms | 10.96ms | 0.8× | 2.9% | PASS |
| ac_reads | `oltp_sum_range` | 12.69ms | 10.92ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_order_range` | 2.67ms | 2.31ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.10ms | 2.94ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_index_scan` | 4.62ms | 5.65ms | 1.2× | 2.4% | PASS |
| ac_reads | `select_random_points` | 17.80ms | 15.03ms | 0.8× | 2.8% | PASS |
| ac_reads | `select_random_ranges` | 6.57ms | 5.50ms | 0.8× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 6.49ms | 7.82ms | 1.2× | 3.1% | PASS |
| ac_reads | `groupby_scan` | 23.04ms | 22.36ms | 1.0× | 1.7% | PASS |
| ac_reads | `index_join` | 9.97ms | 7.92ms | 0.8× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 3.18ms | 5.26ms | 1.7× | 3.4% | PASS |
| ac_reads | `types_table_scan` | 808.01ms | 882.98ms | 1.1× | 2.8% | PASS |
| ac_reads | `table_scan` | 967.48ms | 971.78ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_read_only` | 112.10ms | 102.13ms | 0.9× | 3.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.41ms | 53.55ms | 2.5× | 4.6% | PASS |
| ac_writes | `oltp_insert_ac` | 23.41ms | 60.70ms | 2.6× | 4.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.95ms | 70.56ms | 3.1× | 5.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.06ms | 58.08ms | 2.9× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.03ms | 66.63ms | 2.9× | 5.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.59ms | 65.32ms | 2.9× | 5.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.70ms | 62.78ms | 2.9× | 7.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.09ms | 68.57ms | 2.6× | 4.4% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.94ms | 40.26ms | 1.2× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 15.71ms | 16.59ms | 1.1× | 7.3% | PASS |
| mem_reads | `oltp_sum_range` | 13.27ms | 15.75ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 3.09ms | 3.52ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.21ms | 4.75ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.95ms | 6.78ms | 1.7× | 1.6% | PASS |
| mem_reads | `select_random_points` | 23.91ms | 23.76ms | 1.0× | 4.8% | PASS |
| mem_reads | `select_random_ranges` | 6.72ms | 7.01ms | 1.0× | 2.8% | PASS |
| mem_reads | `covering_index_scan` | 7.94ms | 11.16ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 33.54ms | 37.38ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 9.28ms | 10.71ms | 1.2× | 1.8% | PASS |
| mem_reads | `index_join_scan` | 3.31ms | 6.44ms | 1.9× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.35s | 1.58s | 1.2× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 139.66ms | 153.49ms | 1.1× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.05ms | 362.07ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.13ms | 37.47ms | 2.1× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 66.62ms | 138.59ms | 2.1× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 49.10ms | 81.51ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 53.45ms | 103.08ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 28.23ms | 55.44ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 38.56ms | 58.61ms | 1.5× | 2.2% | PASS |
| mem_writes | `oltp_read_write` | 93.36ms | 138.06ms | 1.5× | 2.4% | PASS |
| file_reads | `oltp_point_select` | 104.37ms | 58.39ms | 0.6× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 23.99ms | 18.71ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 22.78ms | 17.89ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 4.26ms | 3.87ms | 0.9× | 3.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.31ms | 5.08ms | 1.0× | 2.2% | PASS |
| file_reads | `oltp_index_scan` | 11.45ms | 8.85ms | 0.8× | 1.9% | PASS |
| file_reads | `select_random_points` | 32.47ms | 26.47ms | 0.8× | 4.5% | PASS |
| file_reads | `select_random_ranges` | 14.33ms | 9.04ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 16.06ms | 13.48ms | 0.8× | 1.4% | PASS |
| file_reads | `groupby_scan` | 36.41ms | 38.73ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 16.27ms | 13.02ms | 0.8× | 3.2% | PASS |
| file_reads | `index_join_scan` | 5.17ms | 7.39ms | 1.4× | 4.9% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 1.5% | PASS |
| file_reads | `table_scan` | 1.18s | 1.51s | 1.3× | 1.2% | PASS |
| file_reads | `oltp_read_only` | 233.24ms | 179.11ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 254.95ms | 377.52ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.17ms | 42.17ms | 1.7× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 97.28ms | 154.76ms | 1.6× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 93.16ms | 94.21ms | 1.0× | 9.6% | PASS |
| file_writes | `oltp_delete_insert` | 86.06ms | 117.15ms | 1.4× | 2.0% | PASS |
| file_writes | `oltp_write_only` | 57.39ms | 68.06ms | 1.2× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 64.41ms | 69.12ms | 1.1× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 125.31ms | 150.31ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_point_select` | 55.55ms | 57.99ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 18.02ms | 18.70ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 16.87ms | 17.80ms | 1.1× | 2.2% | PASS |
| ac_reads | `oltp_order_range` | 3.67ms | 3.84ms | 1.0× | 3.4% | PASS |
| ac_reads | `oltp_distinct_range` | 4.78ms | 5.07ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_index_scan` | 6.73ms | 8.80ms | 1.3× | 2.3% | PASS |
| ac_reads | `select_random_points` | 26.01ms | 25.88ms | 1.0× | 2.5% | PASS |
| ac_reads | `select_random_ranges` | 8.70ms | 8.98ms | 1.0× | 3.2% | PASS |
| ac_reads | `covering_index_scan` | 10.51ms | 13.21ms | 1.3× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 34.55ms | 37.93ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 11.59ms | 12.11ms | 1.0× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 4.53ms | 7.62ms | 1.7× | 4.1% | PASS |
| ac_reads | `types_table_scan` | 1.20s | 1.50s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.35s | 1.59s | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 191.54ms | 193.72ms | 1.0× | 0.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.00ms | 67.05ms | 2.8× | 8.4% | PASS |
| ac_writes | `oltp_insert_ac` | 26.87ms | 84.31ms | 3.1× | 7.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 28.92ms | 96.32ms | 3.3× | 8.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.53ms | 74.94ms | 3.2× | 11.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.21ms | 85.66ms | 3.3× | 7.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.23ms | 86.12ms | 3.4× | 12.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 24.44ms | 80.62ms | 3.3× | 6.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.40ms | 93.24ms | 2.8× | 5.5% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.02ms | 43.03ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 19.45ms | 23.49ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_sum_range` | 17.33ms | 22.62ms | 1.3× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 3.59ms | 4.19ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.60ms | 5.37ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 4.51ms | 6.82ms | 1.5× | 2.2% | PASS |
| mem_reads | `select_random_points` | 26.66ms | 33.07ms | 1.2× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 7.67ms | 9.60ms | 1.3× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 7.98ms | 11.35ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 36.87ms | 42.89ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 7.86ms | 12.08ms | 1.5× | 1.6% | PASS |
| mem_reads | `index_join_scan` | 3.90ms | 6.67ms | 1.7× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.13s | 1.43s | 1.3× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.30s | 1.52s | 1.2× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 150.91ms | 187.69ms | 1.2× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 239.47ms | 352.34ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.45ms | 34.23ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 66.52ms | 131.66ms | 2.0× | 2.1% | PASS |
| mem_writes | `oltp_update_non_index` | 50.52ms | 89.72ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 48.69ms | 98.53ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 26.75ms | 59.45ms | 2.2× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 32.17ms | 57.13ms | 1.8× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 105.51ms | 168.36ms | 1.6× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 102.94ms | 63.88ms | 0.6× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 27.91ms | 26.39ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 25.57ms | 25.48ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.58ms | 4.55ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.68ms | 5.75ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 11.94ms | 9.11ms | 0.8× | 1.4% | PASS |
| file_reads | `select_random_points` | 35.19ms | 35.90ms | 1.0× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 15.01ms | 11.98ms | 0.8× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.54ms | 13.58ms | 0.9× | 1.4% | PASS |
| file_reads | `groupby_scan` | 37.90ms | 43.30ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 12.24ms | 13.70ms | 1.1× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.91ms | 7.04ms | 1.4× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.09s | 1.41s | 1.3× | 0.8% | PASS |
| file_reads | `table_scan` | 1.29s | 1.51s | 1.2× | 2.4% | PASS |
| file_reads | `oltp_read_only` | 257.78ms | 218.84ms | 0.8× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 253.80ms | 364.37ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.67ms | 38.16ms | 1.5× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 96.10ms | 143.98ms | 1.5× | 1.7% | PASS |
| file_writes | `oltp_update_non_index` | 77.77ms | 98.28ms | 1.3× | 2.3% | PASS |
| file_writes | `oltp_delete_insert` | 77.57ms | 111.31ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_write_only` | 52.31ms | 67.14ms | 1.3× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 50.81ms | 63.14ms | 1.2× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 129.66ms | 173.75ms | 1.3× | 2.4% | PASS |
| ac_reads | `oltp_point_select` | 55.86ms | 64.31ms | 1.2× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 22.89ms | 26.31ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 20.24ms | 25.36ms | 1.3× | 1.6% | PASS |
| ac_reads | `oltp_order_range` | 4.11ms | 4.57ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 5.11ms | 5.72ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 7.23ms | 9.05ms | 1.3× | 2.3% | PASS |
| ac_reads | `select_random_points` | 29.87ms | 35.95ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 10.28ms | 11.97ms | 1.2× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.84ms | 13.73ms | 1.3× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 37.52ms | 43.57ms | 1.2× | 1.1% | PASS |
| ac_reads | `index_join` | 9.74ms | 13.78ms | 1.4× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 4.42ms | 7.06ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.10s | 1.41s | 1.3× | 1.1% | PASS |
| ac_reads | `table_scan` | 1.30s | 1.52s | 1.2× | 3.0% | PASS |
| ac_reads | `oltp_read_only` | 190.34ms | 220.78ms | 1.2× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.92ms | 62.16ms | 3.0× | 8.4% | PASS |
| ac_writes | `oltp_insert_ac` | 23.09ms | 76.26ms | 3.3× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.00ms | 87.29ms | 3.4× | 6.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.11ms | 70.14ms | 3.3× | 4.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.49ms | 78.01ms | 3.3× | 6.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.06ms | 78.68ms | 3.3× | 7.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.25ms | 71.97ms | 3.4× | 7.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.12ms | 87.71ms | 2.8× | 6.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 18s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.76ms | 38.00ms | 83.6% | 1.6% | PASS |
| `status_dirty_many_tables` | 35.16ms | 42.00ms | 83.7% | 1.5% | PASS |
| `diff_regular_working_one_table` | 27.47ms | 33.00ms | 83.2% | 1.3% | PASS |
| `diff_regular_working_many_tables` | 39.78ms | 50.00ms | 79.6% | 1.2% | PASS |
| `diff_stat_working_many_tables` | 40.41ms | 48.00ms | 84.2% | 1.4% | PASS |
| `diff_schema_working_many_tables` | 40.78ms | 48.00ms | 85.0% | 0.8% | PASS |
| `branch_list_many_branches` | 20.25ms | 25.00ms | 81.0% | 0.9% | PASS |
| `branch_create_delete` | 21.88ms | 27.00ms | 81.0% | 1.2% | PASS |
| `at_literal_deep_history` | 22.16ms | 28.00ms | 79.1% | 1.3% | PASS |
| `diff_literal_deep_history` | 22.15ms | 28.00ms | 79.1% | 1.0% | PASS |
| `history_literal_deep_history` | 22.96ms | 30.00ms | 76.5% | 1.5% | PASS |
| `checkout_branch_clean` | 29.65ms | 43.00ms | 69.0% | 1.4% | PASS |
| `merge_data_no_conflicts` | 24.18ms | 33.00ms | 73.3% | 1.4% | PASS |
| `merge_data_secondary_index` | 874.97ms | 944.00ms | 92.7% | 1.2% | PASS |
| `merge_schema_no_conflicts` | 17.72ms | 24.00ms | 73.8% | 1.9% | PASS |
| `merge_data_conflicts` | 26.55ms | 33.00ms | 80.5% | 1.3% | PASS |
| `merge_data_conflicts_with_resolve` | 27.49ms | 34.00ms | 80.9% | 1.6% | PASS |

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
| copy_fsync | candidate | 58.247 | 55.947–58.570 | 39.107 | 1716.83 | 107968266 |
| push_initial | candidate | 586.876 | 583.226–590.092 | 569.468 | 170.39 | 107956772 |
| clone_initial | candidate | 764.647 | 756.329–771.398 | 739.194 | 130.78 | 108475035 |
| push_noop | candidate | 0.698 | 0.639–0.769 | 0.423 | — | 0 |
| fetch_noop | candidate | 0.214 | 0.203–0.259 | 0.218 | — | 0 |
| push_incremental | candidate | 232.768 | 231.241–233.103 | 229.657 | 4.30 | 7909775 |
| fetch_incremental | candidate | 96.139 | 95.378–96.822 | 93.882 | 10.40 | 7910084 |
| pull_fast_forward | candidate | 87.764 | 85.284–89.709 | 83.901 | 11.39 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.53 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.85 | 295.118 | 109.784 | 47246 | 2337 |
| push_noop | candidate | 45.92 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.92 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.92 | 96.832 | 7.910 | 22403 | 125 |
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
| copy_fsync | candidate | 2669.049 | 2656.708–2676.988 | 385.089 | 374.67 | 1087718031 |
| push_initial | candidate | 7928.574 | 7913.815–8005.863 | 5742.359 | 126.13 | 1079566275 |
| clone_initial | candidate | 8719.885 | 8715.439–8739.701 | 8432.834 | 114.68 | 1102407326 |
| push_noop | candidate | 0.867 | 0.803–0.890 | 0.366 | — | 0 |
| fetch_noop | candidate | 0.194 | 0.192–0.204 | 0.195 | — | 0 |
| push_incremental | candidate | 1276.204 | 1275.481–1278.467 | 1270.221 | 0.78 | 15806003 |
| fetch_incremental | candidate | 267.291 | 264.426–267.695 | 261.428 | 3.74 | 15806513 |
| pull_fast_forward | candidate | 263.407 | 261.408–265.585 | 257.906 | 3.80 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.16 | 2091.154 | 1087.622 | 263321 | 20541 |
| clone_initial | candidate | 124.01 | 3520.222 | 1132.819 | 612934 | 32243 |
| push_noop | candidate | 47.20 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.20 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 47.20 | 617.655 | 15.928 | 150038 | 313 |
| fetch_incremental | candidate | 50.41 | 62.115 | 15.928 | 13866 | 313 |
| pull_fast_forward | candidate | 50.44 | 62.047 | 15.929 | 13862 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
