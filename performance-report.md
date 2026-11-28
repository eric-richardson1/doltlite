# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-28 19:41 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261122.9.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/46172076869)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.81s | 11.75s | 1.2× | 1.3% | **PASS** |
| Writes | 1.97s | 3.29s | 1.7× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.96s | 12.07s | 1.1× | 1.2% | **PASS** |
| Writes | 3.72s | 4.24s | 1.1× | 2.1% | **PASS** |
| Autocommit writes | 808.66ms | 2.55s | 3.1× | 6.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.09s | 2.25s | 1.1× | 3.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.61s | 3.27s | 1.3× | 1.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.38s | 2.89s | 1.2× | 0.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.73s | 3.35s | 1.2× | 1.4% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 346.07ms | 563.73ms | 1.6× | 1.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 569.31ms | 978.39ms | 1.7× | 1.1% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 461.74ms | 754.42ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 593.86ms | 994.23ms | 1.7× | 1.2% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.40s | 2.32s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.04s | 3.40s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.55s | 2.94s | 1.2× | 0.9% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.98s | 3.41s | 1.1× | 1.5% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 887.54ms | 882.93ms | 1.0× | 4.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 908.50ms | 1.08s | 1.2× | 4.4% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.16s | 1.23s | 1.1× | 1.7% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 761.19ms | 1.05s | 1.4× | 1.5% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.21s | 2.31s | 1.0× | 1.5% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.94s | 3.40s | 1.2× | 1.7% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.41s | 2.90s | 1.2× | 0.8% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.72s | 3.39s | 1.2× | 1.4% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 183.54ms | 633.56ms | 3.5× | 26.0% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 201.88ms | 627.23ms | 3.1× | 6.1% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 233.23ms | 678.13ms | 2.9× | 3.5% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 190.00ms | 608.12ms | 3.2× | 5.7% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.25ms | 22.67ms | 1.1× | 3.5% | PASS |
| mem_reads | `oltp_range_select` | 9.44ms | 9.60ms | 1.0× | 4.1% | PASS |
| mem_reads | `oltp_sum_range` | 7.95ms | 9.06ms | 1.1× | 3.6% | PASS |
| mem_reads | `oltp_order_range` | 2.16ms | 2.42ms | 1.1× | 2.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.01ms | 3.26ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_index_scan` | 3.09ms | 4.03ms | 1.3× | 2.1% | PASS |
| mem_reads | `select_random_points` | 8.70ms | 9.38ms | 1.1× | 7.1% | PASS |
| mem_reads | `select_random_ranges` | 3.56ms | 3.83ms | 1.1× | 2.3% | PASS |
| mem_reads | `covering_index_scan` | 5.87ms | 7.76ms | 1.3× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 25.10ms | 27.47ms | 1.1× | 1.1% | PASS |
| mem_reads | `index_join` | 4.53ms | 6.69ms | 1.5× | 3.6% | PASS |
| mem_reads | `index_join_scan` | 2.84ms | 4.75ms | 1.7× | 3.2% | PASS |
| mem_reads | `types_table_scan` | 875.94ms | 976.06ms | 1.1× | 3.0% | PASS |
| mem_reads | `table_scan` | 1.03s | 1.07s | 1.0× | 4.4% | PASS |
| mem_reads | `oltp_read_only` | 83.55ms | 93.60ms | 1.1× | 3.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.32ms | 220.42ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 11.76ms | 19.45ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 40.80ms | 73.72ms | 1.8× | 1.7% | PASS |
| mem_writes | `oltp_update_non_index` | 28.71ms | 46.65ms | 1.6× | 3.1% | PASS |
| mem_writes | `oltp_delete_insert` | 37.24ms | 58.64ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_write_only` | 18.52ms | 36.87ms | 2.0× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 20.54ms | 27.04ms | 1.3× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 54.17ms | 80.94ms | 1.5× | 2.4% | PASS |
| file_reads | `oltp_point_select` | 87.38ms | 38.93ms | 0.4× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 16.54ms | 11.36ms | 0.7× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 15.50ms | 10.87ms | 0.7× | 1.9% | PASS |
| file_reads | `oltp_order_range` | 3.03ms | 2.64ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 3.83ms | 3.46ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 10.34ms | 6.03ms | 0.6× | 0.7% | PASS |
| file_reads | `select_random_points` | 16.87ms | 11.37ms | 0.7× | 2.7% | PASS |
| file_reads | `select_random_ranges` | 10.78ms | 5.64ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.41ms | 9.74ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 26.53ms | 27.96ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 8.77ms | 8.06ms | 0.9× | 2.0% | PASS |
| file_reads | `index_join_scan` | 3.60ms | 4.84ms | 1.3× | 2.3% | PASS |
| file_reads | `types_table_scan` | 869.75ms | 965.17ms | 1.1× | 1.1% | PASS |
| file_reads | `table_scan` | 1.12s | 1.09s | 1.0× | 1.1% | PASS |
| file_reads | `oltp_read_only` | 187.46ms | 118.74ms | 0.6× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 180.03ms | 271.82ms | 1.5× | 3.2% | PASS |
| file_writes | `oltp_insert` | 28.35ms | 31.37ms | 1.1× | 7.6% | PASS |
| file_writes | `oltp_update_index` | 143.42ms | 130.36ms | 0.9× | 6.1% | PASS |
| file_writes | `oltp_update_non_index` | 116.83ms | 89.61ms | 0.8× | 4.0% | PASS |
| file_writes | `oltp_delete_insert` | 122.79ms | 108.64ms | 0.9× | 3.5% | PASS |
| file_writes | `oltp_write_only` | 90.71ms | 73.41ms | 0.8× | 4.3% | PASS |
| file_writes | `types_delete_insert` | 76.62ms | 56.64ms | 0.7× | 7.8% | PASS |
| file_writes | `oltp_read_write` | 128.81ms | 121.09ms | 0.9× | 4.2% | PASS |
| ac_reads | `oltp_point_select` | 40.95ms | 39.40ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 12.07ms | 11.41ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 11.03ms | 10.95ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 2.61ms | 2.65ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.37ms | 3.48ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.74ms | 6.14ms | 1.1× | 1.2% | PASS |
| ac_reads | `select_random_points` | 12.71ms | 11.77ms | 0.9× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 6.12ms | 5.68ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 8.73ms | 9.73ms | 1.1× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 26.02ms | 27.82ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 6.25ms | 8.05ms | 1.3× | 3.0% | PASS |
| ac_reads | `index_join_scan` | 3.15ms | 5.04ms | 1.6× | 4.0% | PASS |
| ac_reads | `types_table_scan` | 890.94ms | 975.15ms | 1.1× | 1.3% | PASS |
| ac_reads | `table_scan` | 1.06s | 1.07s | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_read_only` | 119.20ms | 119.54ms | 1.0× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.02ms | 66.63ms | 3.3× | 29.5% | PASS |
| ac_writes | `oltp_insert_ac` | 24.31ms | 82.15ms | 3.4× | 19.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.07ms | 97.79ms | 3.8× | 29.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.16ms | 72.80ms | 3.4× | 22.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.79ms | 81.58ms | 3.7× | 30.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.53ms | 70.86ms | 3.1× | 17.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.29ms | 70.83ms | 3.3× | 18.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.37ms | 90.94ms | 3.4× | 30.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.44ms | 41.00ms | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_range_select` | 15.61ms | 16.80ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_sum_range` | 14.04ms | 15.97ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 3.29ms | 3.65ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.26ms | 4.83ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.96ms | 6.93ms | 1.8× | 1.0% | PASS |
| mem_reads | `select_random_points` | 21.71ms | 22.93ms | 1.1× | 1.2% | PASS |
| mem_reads | `select_random_ranges` | 6.80ms | 7.15ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 7.98ms | 11.32ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 34.10ms | 38.27ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 9.81ms | 10.57ms | 1.1× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.57ms | 6.54ms | 1.8× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 1.09s | 1.41s | 1.3× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.52s | 1.2× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 135.74ms | 154.67ms | 1.1× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 232.34ms | 359.94ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.38ms | 36.60ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 62.61ms | 138.97ms | 2.2× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 45.56ms | 82.54ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 52.50ms | 103.72ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 27.68ms | 56.02ms | 2.0× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 37.88ms | 60.54ms | 1.6× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 93.37ms | 140.07ms | 1.5× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 103.89ms | 59.74ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 24.38ms | 18.94ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 22.29ms | 18.19ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 4.21ms | 3.94ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 5.18ms | 5.15ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 11.26ms | 8.87ms | 0.8× | 1.4% | PASS |
| file_reads | `select_random_points` | 30.88ms | 26.05ms | 0.8× | 2.3% | PASS |
| file_reads | `select_random_ranges` | 13.98ms | 9.20ms | 0.7× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.47ms | 13.29ms | 0.9× | 1.0% | PASS |
| file_reads | `groupby_scan` | 35.51ms | 38.64ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 14.76ms | 12.09ms | 0.8× | 1.4% | PASS |
| file_reads | `index_join_scan` | 4.69ms | 7.05ms | 1.5× | 1.6% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.42s | 1.3× | 1.3% | PASS |
| file_reads | `table_scan` | 1.44s | 1.58s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 238.81ms | 183.61ms | 0.8× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 256.59ms | 375.22ms | 1.5× | 0.6% | PASS |
| file_writes | `oltp_insert` | 25.13ms | 42.11ms | 1.7× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 123.27ms | 158.91ms | 1.3× | 12.9% | PASS |
| file_writes | `oltp_update_non_index` | 95.55ms | 96.14ms | 1.0× | 8.9% | PASS |
| file_writes | `oltp_delete_insert` | 94.44ms | 119.77ms | 1.3× | 1.1% | PASS |
| file_writes | `oltp_write_only` | 90.54ms | 67.63ms | 0.7× | 9.3% | PASS |
| file_writes | `types_delete_insert` | 69.85ms | 68.80ms | 1.0× | 1.5% | PASS |
| file_writes | `oltp_read_write` | 153.13ms | 153.18ms | 1.0× | 7.3% | PASS |
| ac_reads | `oltp_point_select` | 56.66ms | 59.71ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 19.31ms | 18.98ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 17.27ms | 18.18ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 3.66ms | 3.93ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 4.65ms | 5.15ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.35ms | 8.93ms | 1.4× | 2.0% | PASS |
| ac_reads | `select_random_points` | 24.11ms | 25.59ms | 1.1× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 9.00ms | 9.18ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.51ms | 13.37ms | 1.3× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 34.82ms | 38.76ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 11.88ms | 12.07ms | 1.0× | 1.5% | PASS |
| ac_reads | `index_join_scan` | 4.16ms | 7.12ms | 1.7× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.25s | 1.45s | 1.2× | 2.3% | PASS |
| ac_reads | `table_scan` | 1.33s | 1.54s | 1.2× | 3.5% | PASS |
| ac_reads | `oltp_read_only` | 167.95ms | 183.14ms | 1.1× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.18ms | 63.13ms | 2.8× | 7.1% | PASS |
| ac_writes | `oltp_insert_ac` | 26.00ms | 73.84ms | 2.8× | 8.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.86ms | 91.71ms | 3.5× | 4.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.72ms | 72.66ms | 3.2× | 7.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.48ms | 84.44ms | 3.3× | 6.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.80ms | 79.75ms | 3.2× | 4.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.47ms | 72.93ms | 3.1× | 6.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.37ms | 88.76ms | 2.8× | 4.0% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 29.75ms | 30.99ms | 1.0× | 0.7% | PASS |
| mem_reads | `oltp_range_select` | 12.85ms | 14.26ms | 1.1× | 0.7% | PASS |
| mem_reads | `oltp_sum_range` | 12.46ms | 13.04ms | 1.0× | 0.7% | PASS |
| mem_reads | `oltp_order_range` | 2.79ms | 3.17ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.61ms | 4.17ms | 1.2× | 0.5% | PASS |
| mem_reads | `oltp_index_scan` | 3.46ms | 5.39ms | 1.6× | 1.5% | PASS |
| mem_reads | `select_random_points` | 19.54ms | 19.86ms | 1.0× | 0.6% | PASS |
| mem_reads | `select_random_ranges` | 5.34ms | 5.45ms | 1.0× | 0.7% | PASS |
| mem_reads | `covering_index_scan` | 6.03ms | 8.95ms | 1.5× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 31.35ms | 34.44ms | 1.1× | 0.3% | PASS |
| mem_reads | `index_join` | 10.04ms | 9.26ms | 0.9× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.07ms | 6.00ms | 2.0× | 0.9% | PASS |
| mem_reads | `types_table_scan` | 991.95ms | 1.24s | 1.3× | 0.3% | PASS |
| mem_reads | `table_scan` | 1.14s | 1.36s | 1.2× | 0.4% | PASS |
| mem_reads | `oltp_read_only` | 113.79ms | 127.75ms | 1.1× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 179.93ms | 270.38ms | 1.5× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 14.79ms | 29.33ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 54.51ms | 113.40ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 38.88ms | 61.80ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 43.84ms | 82.36ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 22.73ms | 42.88ms | 1.9× | 0.7% | PASS |
| mem_writes | `types_delete_insert` | 30.66ms | 45.88ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_read_write` | 76.40ms | 108.39ms | 1.4× | 0.6% | PASS |
| file_reads | `oltp_point_select` | 58.70ms | 37.30ms | 0.6× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 16.03ms | 15.32ms | 1.0× | 1.0% | PASS |
| file_reads | `oltp_sum_range` | 15.62ms | 14.08ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_order_range` | 3.19ms | 3.35ms | 1.1× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.03ms | 4.35ms | 1.1× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 6.58ms | 6.36ms | 1.0× | 0.9% | PASS |
| file_reads | `select_random_points` | 23.59ms | 21.18ms | 0.9× | 1.0% | PASS |
| file_reads | `select_random_ranges` | 8.60ms | 6.32ms | 0.7× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 9.27ms | 9.85ms | 1.1× | 0.7% | PASS |
| file_reads | `groupby_scan` | 32.16ms | 34.95ms | 1.1× | 0.5% | PASS |
| file_reads | `index_join` | 12.24ms | 10.37ms | 0.8× | 1.1% | PASS |
| file_reads | `index_join_scan` | 3.56ms | 6.37ms | 1.8× | 1.4% | PASS |
| file_reads | `types_table_scan` | 1.00s | 1.25s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.19s | 1.38s | 1.2× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 159.31ms | 138.76ms | 0.9× | 0.5% | PASS |
| file_writes | `oltp_bulk_insert` | 250.88ms | 345.75ms | 1.4× | 3.1% | PASS |
| file_writes | `oltp_insert` | 29.61ms | 52.43ms | 1.8× | 2.8% | PASS |
| file_writes | `oltp_update_index` | 165.52ms | 205.67ms | 1.2× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 143.58ms | 118.67ms | 0.8× | 3.2% | PASS |
| file_writes | `oltp_delete_insert` | 160.06ms | 153.34ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_write_only` | 119.77ms | 98.55ms | 0.8× | 0.7% | PASS |
| file_writes | `types_delete_insert` | 120.16ms | 89.19ms | 0.7× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 174.68ms | 164.06ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 39.46ms | 37.24ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 14.18ms | 15.34ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_sum_range` | 13.84ms | 14.06ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_order_range` | 3.03ms | 3.36ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.87ms | 4.36ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 4.83ms | 6.37ms | 1.3× | 0.9% | PASS |
| ac_reads | `select_random_points` | 21.71ms | 21.13ms | 1.0× | 0.8% | PASS |
| ac_reads | `select_random_ranges` | 6.68ms | 6.29ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 7.19ms | 9.83ms | 1.4× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 31.77ms | 34.81ms | 1.1× | 0.4% | PASS |
| ac_reads | `index_join` | 11.26ms | 10.29ms | 0.9× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 3.42ms | 6.41ms | 1.9× | 0.9% | PASS |
| ac_reads | `types_table_scan` | 995.29ms | 1.24s | 1.2× | 0.3% | PASS |
| ac_reads | `table_scan` | 1.13s | 1.35s | 1.2× | 0.3% | PASS |
| ac_reads | `oltp_read_only` | 126.71ms | 136.39ms | 1.1× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 27.56ms | 70.87ms | 2.6× | 3.2% | PASS |
| ac_writes | `oltp_insert_ac` | 29.54ms | 82.86ms | 2.8× | 4.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 29.67ms | 95.04ms | 3.2× | 3.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 27.07ms | 76.79ms | 2.8× | 3.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 28.91ms | 86.03ms | 3.0× | 3.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 28.98ms | 86.54ms | 3.0× | 3.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 28.01ms | 82.56ms | 2.9× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.50ms | 97.44ms | 2.9× | 4.9% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.78ms | 42.36ms | 1.3× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 20.04ms | 23.66ms | 1.2× | 2.1% | PASS |
| mem_reads | `oltp_sum_range` | 18.12ms | 23.07ms | 1.3× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 3.68ms | 4.31ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.64ms | 5.50ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.49ms | 6.61ms | 1.5× | 1.6% | PASS |
| mem_reads | `select_random_points` | 25.66ms | 31.64ms | 1.2× | 2.2% | PASS |
| mem_reads | `select_random_ranges` | 7.51ms | 9.25ms | 1.2× | 1.0% | PASS |
| mem_reads | `covering_index_scan` | 7.95ms | 11.17ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 36.48ms | 43.52ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 7.91ms | 11.96ms | 1.5× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.98ms | 6.74ms | 1.7× | 4.1% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.43s | 1.2× | 2.0% | PASS |
| mem_reads | `table_scan` | 1.26s | 1.51s | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_read_only` | 153.77ms | 186.02ms | 1.2× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 239.30ms | 352.29ms | 1.5× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 18.72ms | 34.72ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 70.80ms | 135.56ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 53.41ms | 92.68ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 51.95ms | 101.64ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 27.68ms | 60.53ms | 2.2× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 32.28ms | 56.53ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 99.73ms | 160.28ms | 1.6× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 103.10ms | 60.16ms | 0.6× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 27.33ms | 25.58ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 24.84ms | 24.82ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.44ms | 4.55ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.54ms | 5.78ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.72ms | 8.59ms | 0.7× | 2.0% | PASS |
| file_reads | `select_random_points` | 34.59ms | 34.89ms | 1.0× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 15.07ms | 11.44ms | 0.8× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 15.35ms | 13.13ms | 0.9× | 1.5% | PASS |
| file_reads | `groupby_scan` | 37.40ms | 44.02ms | 1.2× | 0.8% | PASS |
| file_reads | `index_join` | 12.05ms | 13.19ms | 1.1× | 1.7% | PASS |
| file_reads | `index_join_scan` | 4.88ms | 6.96ms | 1.4× | 1.5% | PASS |
| file_reads | `types_table_scan` | 1.13s | 1.43s | 1.3× | 1.8% | PASS |
| file_reads | `table_scan` | 1.29s | 1.51s | 1.2× | 5.1% | PASS |
| file_reads | `oltp_read_only` | 260.71ms | 216.19ms | 0.8× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 254.38ms | 365.05ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.51ms | 38.33ms | 1.5× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 96.19ms | 141.48ms | 1.5× | 1.8% | PASS |
| file_writes | `oltp_update_non_index` | 77.09ms | 96.13ms | 1.2× | 2.3% | PASS |
| file_writes | `oltp_delete_insert` | 76.25ms | 109.46ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 50.92ms | 65.55ms | 1.3× | 1.9% | PASS |
| file_writes | `types_delete_insert` | 50.46ms | 62.77ms | 1.2× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 130.38ms | 170.13ms | 1.3× | 1.1% | PASS |
| ac_reads | `oltp_point_select` | 56.57ms | 60.47ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 22.86ms | 25.68ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 20.36ms | 25.00ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_order_range` | 4.03ms | 4.56ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 5.03ms | 5.80ms | 1.2× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 7.11ms | 8.64ms | 1.2× | 1.8% | PASS |
| ac_reads | `select_random_points` | 29.33ms | 35.06ms | 1.2× | 1.7% | PASS |
| ac_reads | `select_random_ranges` | 10.14ms | 11.51ms | 1.1× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.77ms | 13.22ms | 1.2× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 37.19ms | 43.96ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 9.63ms | 13.33ms | 1.4× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 4.41ms | 7.06ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.9% | PASS |
| ac_reads | `table_scan` | 1.24s | 1.51s | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_read_only` | 183.82ms | 214.22ms | 1.2× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.84ms | 62.70ms | 3.0× | 7.0% | PASS |
| ac_writes | `oltp_insert_ac` | 23.16ms | 76.63ms | 3.3× | 5.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.75ms | 87.38ms | 3.4× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.04ms | 69.34ms | 3.1× | 5.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.01ms | 77.29ms | 3.2× | 7.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.85ms | 78.04ms | 3.4× | 4.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.57ms | 70.94ms | 3.4× | 6.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.79ms | 85.81ms | 2.8× | 4.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 12s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 30.38ms | 38.00ms | 80.0% | 0.8% | PASS |
| `status_dirty_many_tables` | 33.81ms | 42.00ms | 80.5% | 0.9% | PASS |
| `diff_regular_working_one_table` | 26.04ms | 33.00ms | 78.9% | 0.8% | PASS |
| `diff_regular_working_many_tables` | 38.58ms | 50.00ms | 77.2% | 0.8% | PASS |
| `diff_stat_working_many_tables` | 38.47ms | 48.00ms | 80.1% | 0.6% | PASS |
| `diff_schema_working_many_tables` | 39.15ms | 48.00ms | 81.6% | 0.6% | PASS |
| `branch_list_many_branches` | 18.50ms | 25.00ms | 74.0% | 1.1% | PASS |
| `branch_create_delete` | 19.96ms | 27.00ms | 73.9% | 1.2% | PASS |
| `at_literal_deep_history` | 20.29ms | 28.00ms | 72.5% | 1.0% | PASS |
| `diff_literal_deep_history` | 20.22ms | 28.00ms | 72.2% | 0.8% | PASS |
| `history_literal_deep_history` | 21.43ms | 30.00ms | 71.4% | 0.8% | PASS |
| `checkout_branch_clean` | 28.82ms | 43.00ms | 67.0% | 0.9% | PASS |
| `merge_data_no_conflicts` | 23.30ms | 33.00ms | 70.6% | 0.9% | PASS |
| `merge_data_secondary_index` | 867.35ms | 944.00ms | 91.9% | 0.8% | PASS |
| `merge_schema_no_conflicts` | 17.22ms | 24.00ms | 71.7% | 1.2% | PASS |
| `merge_data_conflicts` | 25.97ms | 33.00ms | 78.7% | 0.7% | PASS |
| `merge_data_conflicts_with_resolve` | 26.65ms | 34.00ms | 78.4% | 0.5% | PASS |

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
| copy_fsync | candidate | 52.716 | 50.765–55.199 | 37.943 | 1896.96 | 107968266 |
| push_initial | candidate | 576.872 | 575.415–580.288 | 565.160 | 173.35 | 107956772 |
| clone_initial | candidate | 752.575 | 750.852–754.626 | 731.191 | 132.88 | 108475035 |
| push_noop | candidate | 0.718 | 0.663–0.768 | 0.369 | — | 0 |
| fetch_noop | candidate | 0.223 | 0.216–0.233 | 0.225 | — | 0 |
| push_incremental | candidate | 229.254 | 229.192–231.322 | 226.851 | 4.36 | 7909775 |
| fetch_incremental | candidate | 94.720 | 94.575–96.458 | 92.519 | 10.56 | 7910084 |
| pull_fast_forward | candidate | 83.537 | 83.239–85.842 | 81.112 | 11.97 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.54 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.83 | 295.132 | 109.784 | 47250 | 2337 |
| push_noop | candidate | 46.11 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.11 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.11 | 96.779 | 7.910 | 22389 | 125 |
| fetch_incremental | candidate | 46.11 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.11 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2674.198 | 2638.015–2675.567 | 382.438 | 373.94 | 1087718031 |
| push_initial | candidate | 7899.576 | 7890.036–8003.510 | 5706.547 | 126.59 | 1079566275 |
| clone_initial | candidate | 8704.327 | 8689.206–8761.310 | 8412.842 | 114.89 | 1102407326 |
| push_noop | candidate | 0.863 | 0.739–0.911 | 0.399 | — | 0 |
| fetch_noop | candidate | 0.272 | 0.196–0.274 | 0.274 | — | 0 |
| push_incremental | candidate | 1281.347 | 1277.467–1296.529 | 1276.407 | 0.78 | 15806003 |
| fetch_incremental | candidate | 271.658 | 268.448–273.129 | 265.402 | 3.68 | 15806513 |
| pull_fast_forward | candidate | 266.618 | 266.454–269.958 | 260.391 | 3.75 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.76 | 2091.961 | 1087.622 | 263518 | 20541 |
| clone_initial | candidate | 123.99 | 3516.737 | 1132.819 | 612040 | 32243 |
| push_noop | candidate | 47.32 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.32 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.29 | 615.998 | 15.928 | 149618 | 313 |
| fetch_incremental | candidate | 50.45 | 62.910 | 15.928 | 14060 | 313 |
| pull_fast_forward | candidate | 50.39 | 62.842 | 15.929 | 14056 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
