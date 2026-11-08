# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-11-08 18:09 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42498831906)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.17s | 11.79s | 1.2× | 1.4% | **PASS** |
| Writes | 1.94s | 3.24s | 1.7× | 1.1% | **FAIL** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.75s | 11.92s | 1.1× | 1.1% | **PASS** |
| Writes | 3.73s | 4.30s | 1.2× | 1.9% | **PASS** |
| Autocommit writes | 805.61ms | 2.52s | 3.1× | 5.8% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.42s | 2.90s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.35s | 2.51s | 1.1× | 1.7% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.57s | 3.28s | 1.3× | 1.5% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.83s | 3.10s | 1.1× | 1.0% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 419.14ms | 754.48ms | 1.8× | 1.0% | **FAIL** |
| In-memory | Writes | textpk | 8 | 55 | 457.23ms | 718.88ms | 1.6× | 1.3% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 570.77ms | 956.28ms | 1.7× | 1.4% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 491.32ms | 812.88ms | 1.7× | 0.9% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.64s | 2.96s | 1.1× | 1.7% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.38s | 2.50s | 1.0× | 0.9% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.79s | 3.35s | 1.2× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.93s | 3.10s | 1.1× | 0.6% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 580.45ms | 818.52ms | 1.4× | 1.4% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.21s | 1.19s | 1.0× | 4.4% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 801.63ms | 1.06s | 1.3× | 2.1% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.14s | 1.23s | 1.1× | 1.3% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.49s | 2.94s | 1.2× | 1.3% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.41s | 2.55s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.66s | 3.35s | 1.3× | 1.5% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.84s | 3.09s | 1.1× | 0.8% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 187.58ms | 618.80ms | 3.3× | 5.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 181.72ms | 577.71ms | 3.2× | 16.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 191.18ms | 610.30ms | 3.2× | 6.1% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 245.12ms | 708.24ms | 2.9× | 4.1% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.77ms | 31.15ms | 1.4× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 9.78ms | 12.83ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 8.96ms | 12.24ms | 1.4× | 1.7% | PASS |
| mem_reads | `oltp_order_range` | 2.53ms | 3.13ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 3.49ms | 4.30ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.66ms | 5.47ms | 1.5× | 2.1% | PASS |
| mem_reads | `select_random_points` | 8.87ms | 11.90ms | 1.3× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 4.23ms | 5.37ms | 1.3× | 2.0% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 10.71ms | 1.3× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 30.06ms | 35.10ms | 1.2× | 0.8% | PASS |
| mem_reads | `index_join` | 5.69ms | 8.48ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.09ms | 5.61ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.27s | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.16s | 1.36s | 1.2× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 100.44ms | 129.15ms | 1.3× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.09ms | 298.76ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 14.84ms | 26.64ms | 1.8× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 47.95ms | 95.62ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_update_non_index` | 32.41ms | 62.54ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 41.43ms | 75.97ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 20.37ms | 47.04ms | 2.3× | 1.6% | FAIL |
| mem_writes | `types_delete_insert` | 23.05ms | 37.04ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 64.01ms | 110.87ms | 1.7× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 91.60ms | 48.93ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 17.84ms | 14.72ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 16.70ms | 14.17ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 3.50ms | 3.41ms | 1.0× | 2.7% | PASS |
| file_reads | `oltp_distinct_range` | 4.46ms | 4.57ms | 1.0× | 1.9% | PASS |
| file_reads | `oltp_index_scan` | 11.19ms | 7.55ms | 0.7× | 2.0% | PASS |
| file_reads | `select_random_points` | 17.19ms | 13.96ms | 0.8× | 2.1% | PASS |
| file_reads | `select_random_ranges` | 11.78ms | 7.32ms | 0.6× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 15.53ms | 12.86ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 31.39ms | 35.52ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 9.83ms | 10.12ms | 1.0× | 1.7% | PASS |
| file_reads | `index_join_scan` | 4.14ms | 6.06ms | 1.5× | 1.1% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.27s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.16s | 1.36s | 1.2× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 201.79ms | 155.43ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 188.16ms | 311.34ms | 1.7× | 0.8% | PASS |
| file_writes | `oltp_insert` | 21.56ms | 29.98ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 75.25ms | 105.47ms | 1.4× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 56.41ms | 69.61ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 65.94ms | 87.95ms | 1.3× | 1.0% | PASS |
| file_writes | `oltp_write_only` | 43.67ms | 53.29ms | 1.2× | 1.6% | PASS |
| file_writes | `types_delete_insert` | 39.35ms | 43.52ms | 1.1× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 90.11ms | 117.37ms | 1.3× | 1.9% | PASS |
| ac_reads | `oltp_point_select` | 44.99ms | 49.06ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 12.77ms | 14.73ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 11.79ms | 14.15ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 2.98ms | 3.41ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 3.87ms | 4.58ms | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.17ms | 7.53ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_points` | 11.84ms | 13.99ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_ranges` | 6.86ms | 7.32ms | 1.1× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 10.44ms | 12.86ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 30.71ms | 35.54ms | 1.2× | 0.9% | PASS |
| ac_reads | `index_join` | 7.14ms | 10.13ms | 1.4× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.57ms | 6.07ms | 1.7× | 1.5% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.25s | 1.2× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.35s | 1.2× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 133.79ms | 155.65ms | 1.2× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.64ms | 65.13ms | 3.2× | 6.4% | PASS |
| ac_writes | `oltp_insert_ac` | 23.98ms | 76.99ms | 3.2× | 4.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.27ms | 90.10ms | 3.4× | 5.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.23ms | 70.08ms | 3.3× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.16ms | 80.07ms | 3.5× | 4.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.77ms | 78.29ms | 3.4× | 4.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.98ms | 73.32ms | 3.5× | 6.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.55ms | 84.81ms | 3.0× | 5.4% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.70ms | 29.19ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 14.05ms | 12.58ms | 0.9× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 12.77ms | 12.06ms | 0.9× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 2.81ms | 2.81ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.60ms | 3.63ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.14ms | 5.23ms | 1.7× | 1.0% | PASS |
| mem_reads | `select_random_points` | 17.67ms | 17.12ms | 1.0× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 5.39ms | 5.12ms | 0.9× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 5.90ms | 8.14ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 29.12ms | 29.88ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 9.07ms | 8.52ms | 0.9× | 2.4% | PASS |
| mem_reads | `index_join_scan` | 3.17ms | 5.67ms | 1.8× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 950.26ms | 1.08s | 1.1× | 3.9% | PASS |
| mem_reads | `table_scan` | 1.15s | 1.18s | 1.0× | 3.3% | PASS |
| mem_reads | `oltp_read_only` | 112.83ms | 111.60ms | 1.0× | 2.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.78ms | 261.45ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 13.65ms | 26.97ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 52.77ms | 106.14ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 39.73ms | 60.59ms | 1.5× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 43.61ms | 78.03ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 23.18ms | 41.09ms | 1.8× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 31.32ms | 44.24ms | 1.4× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 75.19ms | 100.37ms | 1.3× | 2.3% | PASS |
| file_reads | `oltp_point_select` | 96.98ms | 45.53ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 21.61ms | 14.34ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 20.09ms | 13.90ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_order_range` | 3.70ms | 3.05ms | 0.8× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 4.48ms | 3.84ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 10.31ms | 6.93ms | 0.7× | 0.8% | PASS |
| file_reads | `select_random_points` | 25.71ms | 19.09ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 12.63ms | 6.91ms | 0.5× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 13.23ms | 9.86ms | 0.7× | 0.5% | PASS |
| file_reads | `groupby_scan` | 29.97ms | 30.13ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 13.29ms | 9.41ms | 0.7× | 1.0% | PASS |
| file_reads | `index_join_scan` | 4.03ms | 5.77ms | 1.4× | 0.9% | PASS |
| file_reads | `types_table_scan` | 892.97ms | 1.05s | 1.2× | 1.4% | PASS |
| file_reads | `table_scan` | 1.03s | 1.15s | 1.1× | 2.1% | PASS |
| file_reads | `oltp_read_only` | 210.19ms | 135.19ms | 0.6× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 259.35ms | 331.80ms | 1.3× | 3.6% | PASS |
| file_writes | `oltp_insert` | 28.00ms | 46.56ms | 1.7× | 4.7% | PASS |
| file_writes | `oltp_update_index` | 171.49ms | 190.78ms | 1.1× | 3.4% | PASS |
| file_writes | `oltp_update_non_index` | 142.35ms | 120.64ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_delete_insert` | 182.71ms | 149.62ms | 0.8× | 5.1% | PASS |
| file_writes | `oltp_write_only` | 112.56ms | 98.57ms | 0.9× | 4.5% | PASS |
| file_writes | `types_delete_insert` | 141.39ms | 89.39ms | 0.6× | 7.9% | PASS |
| file_writes | `oltp_read_write` | 172.56ms | 158.31ms | 0.9× | 4.1% | PASS |
| ac_reads | `oltp_point_select` | 49.25ms | 45.80ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 16.95ms | 14.38ms | 0.8× | 1.3% | PASS |
| ac_reads | `oltp_sum_range` | 15.59ms | 13.89ms | 0.9× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 3.26ms | 3.04ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_distinct_range` | 4.00ms | 3.84ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 5.74ms | 6.92ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 20.40ms | 19.07ms | 0.9× | 1.5% | PASS |
| ac_reads | `select_random_ranges` | 7.95ms | 6.91ms | 0.9× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 8.52ms | 9.88ms | 1.2× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 29.49ms | 30.04ms | 1.0× | 0.5% | PASS |
| ac_reads | `index_join` | 10.93ms | 9.35ms | 0.9× | 0.8% | PASS |
| ac_reads | `index_join_scan` | 3.63ms | 5.78ms | 1.6× | 0.8% | PASS |
| ac_reads | `types_table_scan` | 902.85ms | 1.05s | 1.2× | 1.3% | PASS |
| ac_reads | `table_scan` | 1.18s | 1.19s | 1.0× | 3.6% | PASS |
| ac_reads | `oltp_read_only` | 149.06ms | 137.68ms | 0.9× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.44ms | 57.89ms | 3.0× | 16.5% | PASS |
| ac_writes | `oltp_insert_ac` | 22.02ms | 66.80ms | 3.0× | 17.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.91ms | 83.98ms | 3.7× | 19.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.12ms | 74.67ms | 3.2× | 36.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.54ms | 73.78ms | 3.3× | 14.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.47ms | 74.22ms | 3.5× | 14.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.10ms | 68.57ms | 3.0× | 23.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.11ms | 77.79ms | 2.9× | 14.0% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.29ms | 39.75ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 16.01ms | 16.60ms | 1.0× | 2.6% | PASS |
| mem_reads | `oltp_sum_range` | 14.75ms | 15.58ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_order_range` | 3.25ms | 3.56ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.21ms | 4.76ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.87ms | 6.62ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 21.55ms | 21.93ms | 1.0× | 2.8% | PASS |
| mem_reads | `select_random_ranges` | 6.42ms | 6.83ms | 1.1× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 7.92ms | 11.06ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 34.25ms | 37.64ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 10.21ms | 10.75ms | 1.1× | 1.4% | PASS |
| mem_reads | `index_join_scan` | 3.72ms | 6.38ms | 1.7× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 1.07s | 1.42s | 1.3× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.20s | 1.52s | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 137.80ms | 152.24ms | 1.1× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 230.79ms | 355.43ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.70ms | 36.70ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 63.37ms | 133.96ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 47.60ms | 79.50ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 51.52ms | 100.51ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 27.05ms | 54.41ms | 2.0× | 1.7% | PASS |
| mem_writes | `types_delete_insert` | 37.57ms | 57.62ms | 1.5× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 95.17ms | 138.15ms | 1.5× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 102.53ms | 58.48ms | 0.6× | 1.5% | PASS |
| file_reads | `oltp_range_select` | 23.57ms | 18.63ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 22.04ms | 17.76ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 4.09ms | 3.82ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 5.10ms | 5.04ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.03ms | 8.68ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_points` | 30.19ms | 24.74ms | 0.8× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 13.60ms | 8.95ms | 0.7× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 15.22ms | 13.20ms | 0.9× | 1.3% | PASS |
| file_reads | `groupby_scan` | 35.39ms | 37.99ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.37ms | 11.95ms | 0.8× | 2.5% | PASS |
| file_reads | `index_join_scan` | 4.76ms | 6.77ms | 1.4× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.42s | 1.3× | 1.1% | PASS |
| file_reads | `table_scan` | 1.20s | 1.53s | 1.3× | 1.2% | PASS |
| file_reads | `oltp_read_only` | 239.56ms | 182.06ms | 0.8× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 249.54ms | 371.94ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 24.98ms | 41.75ms | 1.7× | 2.2% | PASS |
| file_writes | `oltp_update_index` | 96.20ms | 152.82ms | 1.6× | 1.8% | PASS |
| file_writes | `oltp_update_non_index` | 93.81ms | 92.82ms | 1.0× | 15.6% | PASS |
| file_writes | `oltp_delete_insert` | 86.58ms | 116.84ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 57.29ms | 67.02ms | 1.2× | 2.6% | PASS |
| file_writes | `types_delete_insert` | 63.90ms | 68.54ms | 1.1× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 129.32ms | 150.80ms | 1.2× | 2.3% | PASS |
| ac_reads | `oltp_point_select` | 57.52ms | 58.65ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 18.97ms | 18.69ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 17.80ms | 17.85ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_order_range` | 3.67ms | 3.83ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 4.62ms | 5.04ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.41ms | 8.71ms | 1.4× | 2.3% | PASS |
| ac_reads | `select_random_points` | 25.25ms | 24.77ms | 1.0× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 8.99ms | 8.92ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 10.62ms | 13.23ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 34.75ms | 38.08ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 12.05ms | 12.03ms | 1.0× | 2.5% | PASS |
| ac_reads | `index_join_scan` | 4.23ms | 6.79ms | 1.6× | 2.2% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.43s | 1.3× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.21s | 1.52s | 1.3× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 172.41ms | 181.28ms | 1.1× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.72ms | 60.91ms | 2.8× | 4.6% | PASS |
| ac_writes | `oltp_insert_ac` | 23.95ms | 76.94ms | 3.2× | 6.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.07ms | 89.64ms | 3.7× | 6.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.62ms | 68.97ms | 3.3× | 6.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.82ms | 79.54ms | 3.2× | 5.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.40ms | 77.59ms | 3.2× | 6.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.66ms | 72.20ms | 3.3× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.93ms | 84.50ms | 2.8× | 4.7% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 29.36ms | 34.39ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_range_select` | 16.34ms | 21.53ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 16.38ms | 20.11ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 3.35ms | 3.97ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.26ms | 5.01ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 4.08ms | 5.76ms | 1.4× | 0.9% | PASS |
| mem_reads | `select_random_points` | 24.95ms | 29.81ms | 1.2× | 0.9% | PASS |
| mem_reads | `select_random_ranges` | 6.54ms | 7.82ms | 1.2× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 6.23ms | 9.35ms | 1.5× | 0.5% | PASS |
| mem_reads | `groupby_scan` | 35.21ms | 40.58ms | 1.2× | 0.2% | PASS |
| mem_reads | `index_join` | 7.23ms | 11.05ms | 1.5× | 1.0% | PASS |
| mem_reads | `index_join_scan` | 3.52ms | 6.11ms | 1.7× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.13s | 1.30s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.41s | 1.44s | 1.0× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 133.85ms | 161.78ms | 1.2× | 0.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 194.44ms | 278.42ms | 1.4× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 16.00ms | 28.59ms | 1.8× | 0.5% | PASS |
| mem_writes | `oltp_update_index` | 59.35ms | 116.82ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 42.74ms | 74.45ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 42.72ms | 83.79ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 23.04ms | 51.00ms | 2.2× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 26.94ms | 46.36ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_read_write` | 86.09ms | 133.42ms | 1.5× | 1.4% | PASS |
| file_reads | `oltp_point_select` | 58.89ms | 40.29ms | 0.7× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 20.44ms | 22.27ms | 1.1× | 0.6% | PASS |
| file_reads | `oltp_sum_range` | 19.73ms | 20.90ms | 1.1× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 3.70ms | 4.10ms | 1.1× | 0.8% | PASS |
| file_reads | `oltp_distinct_range` | 4.61ms | 5.14ms | 1.1× | 0.5% | PASS |
| file_reads | `oltp_index_scan` | 7.49ms | 6.61ms | 0.9× | 0.8% | PASS |
| file_reads | `select_random_points` | 28.78ms | 30.73ms | 1.1× | 1.0% | PASS |
| file_reads | `select_random_ranges` | 9.80ms | 8.64ms | 0.9× | 0.5% | PASS |
| file_reads | `covering_index_scan` | 9.61ms | 10.25ms | 1.1× | 0.5% | PASS |
| file_reads | `groupby_scan` | 35.60ms | 40.95ms | 1.2× | 0.3% | PASS |
| file_reads | `index_join` | 9.31ms | 11.57ms | 1.2× | 1.1% | PASS |
| file_reads | `index_join_scan` | 3.96ms | 6.24ms | 1.6× | 1.1% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.29s | 1.2× | 1.1% | PASS |
| file_reads | `table_scan` | 1.43s | 1.43s | 1.0× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 179.17ms | 171.84ms | 1.0× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 254.52ms | 340.83ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_insert` | 32.60ms | 48.45ms | 1.5× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 177.91ms | 191.02ms | 1.1× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 148.06ms | 128.06ms | 0.9× | 0.8% | PASS |
| file_writes | `oltp_delete_insert` | 146.65ms | 149.78ms | 1.0× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 106.57ms | 100.66ms | 0.9× | 0.8% | PASS |
| file_writes | `types_delete_insert` | 96.03ms | 86.31ms | 0.9× | 7.6% | PASS |
| file_writes | `oltp_read_write` | 175.63ms | 187.25ms | 1.1× | 4.8% | PASS |
| ac_reads | `oltp_point_select` | 39.03ms | 40.64ms | 1.0× | 0.6% | PASS |
| ac_reads | `oltp_range_select` | 18.10ms | 22.39ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 17.91ms | 21.00ms | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_order_range` | 3.50ms | 4.12ms | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.45ms | 5.14ms | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 5.54ms | 6.59ms | 1.2× | 0.7% | PASS |
| ac_reads | `select_random_points` | 26.60ms | 30.62ms | 1.2× | 1.0% | PASS |
| ac_reads | `select_random_ranges` | 7.80ms | 8.65ms | 1.1× | 0.7% | PASS |
| ac_reads | `covering_index_scan` | 7.52ms | 10.29ms | 1.4× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 35.49ms | 41.05ms | 1.2× | 0.5% | PASS |
| ac_reads | `index_join` | 8.33ms | 11.69ms | 1.4× | 0.8% | PASS |
| ac_reads | `index_join_scan` | 3.83ms | 6.33ms | 1.7× | 1.4% | PASS |
| ac_reads | `types_table_scan` | 1.13s | 1.29s | 1.1× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.38s | 1.42s | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_read_only` | 147.01ms | 170.69ms | 1.2× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 28.28ms | 73.23ms | 2.6× | 2.9% | PASS |
| ac_writes | `oltp_insert_ac` | 30.68ms | 87.05ms | 2.8× | 4.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 32.13ms | 98.85ms | 3.1× | 4.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 29.33ms | 81.83ms | 2.8× | 4.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 30.30ms | 91.39ms | 3.0× | 3.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 30.54ms | 92.63ms | 3.0× | 3.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 28.50ms | 84.58ms | 3.0× | 5.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 35.36ms | 98.67ms | 2.8× | 4.0% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 27s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 19.69ms | 38.00ms | 51.8% | 1.8% | PASS |
| `status_dirty_many_tables` | 21.35ms | 42.00ms | 50.8% | 0.9% | PASS |
| `diff_regular_working_one_table` | 16.78ms | 33.00ms | 50.9% | 1.1% | PASS |
| `diff_regular_working_many_tables` | 24.26ms | 50.00ms | 48.5% | 2.0% | PASS |
| `diff_stat_working_many_tables` | 24.71ms | 48.00ms | 51.5% | 0.5% | PASS |
| `diff_schema_working_many_tables` | 25.36ms | 48.00ms | 52.8% | 1.1% | PASS |
| `branch_list_many_branches` | 13.34ms | 25.00ms | 53.4% | 0.8% | PASS |
| `branch_create_delete` | 14.41ms | 27.00ms | 53.4% | 0.5% | PASS |
| `at_literal_deep_history` | 14.69ms | 28.00ms | 52.5% | 1.0% | PASS |
| `diff_literal_deep_history` | 14.38ms | 28.00ms | 51.3% | 1.3% | PASS |
| `history_literal_deep_history` | 14.50ms | 30.00ms | 48.3% | 0.8% | PASS |
| `checkout_branch_clean` | 18.76ms | 43.00ms | 43.6% | 1.1% | PASS |
| `merge_data_no_conflicts` | 15.75ms | 33.00ms | 47.7% | 0.6% | PASS |
| `merge_data_secondary_index` | 625.22ms | 944.00ms | 66.2% | 0.6% | PASS |
| `merge_schema_no_conflicts` | 11.62ms | 24.00ms | 48.4% | 0.9% | PASS |
| `merge_data_conflicts` | 17.94ms | 33.00ms | 54.4% | 1.0% | PASS |
| `merge_data_conflicts_with_resolve` | 18.58ms | 34.00ms | 54.6% | 0.9% | PASS |

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
| copy_fsync | candidate | 400.903 | 397.906–543.617 | 30.522 | 249.44 | 107968266 |
| push_initial | candidate | 727.483 | 722.420–738.674 | 356.621 | 137.46 | 107956772 |
| clone_initial | candidate | 823.298 | 815.121–833.813 | 459.463 | 121.46 | 108475035 |
| push_noop | candidate | 0.572 | 0.542–0.605 | 0.291 | — | 0 |
| fetch_noop | candidate | 0.150 | 0.144–0.164 | 0.152 | — | 0 |
| push_incremental | candidate | 176.346 | 162.651–187.825 | 146.377 | 5.67 | 7909775 |
| fetch_incremental | candidate | 79.310 | 73.509–82.692 | 61.559 | 12.61 | 7910084 |
| pull_fast_forward | candidate | 72.277 | 69.246–73.711 | 53.430 | 13.84 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.55 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.79 | 295.031 | 109.784 | 47226 | 2337 |
| push_noop | candidate | 45.93 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.93 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.93 | 96.838 | 7.910 | 22404 | 125 |
| fetch_incremental | candidate | 45.93 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.93 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2666.981 | 2654.652–2701.659 | 411.092 | 374.96 | 1087718031 |
| push_initial | candidate | 8024.037 | 8014.854–8024.458 | 5834.745 | 124.63 | 1079566275 |
| clone_initial | candidate | 8792.127 | 8749.146–8806.222 | 8551.675 | 113.74 | 1102407326 |
| push_noop | candidate | 0.856 | 0.826–0.989 | 0.422 | — | 0 |
| fetch_noop | candidate | 0.244 | 0.196–0.269 | 0.250 | — | 0 |
| push_incremental | candidate | 1283.823 | 1283.549–1287.474 | 1278.218 | 0.78 | 15806003 |
| fetch_incremental | candidate | 278.454 | 277.030–281.097 | 272.905 | 3.59 | 15806513 |
| pull_fast_forward | candidate | 289.809 | 275.388–294.358 | 283.672 | 3.45 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.73 | 2092.543 | 1087.622 | 263660 | 20541 |
| clone_initial | candidate | 124.04 | 3518.724 | 1132.819 | 612501 | 32243 |
| push_noop | candidate | 47.30 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.30 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.32 | 617.797 | 15.928 | 150044 | 313 |
| fetch_incremental | candidate | 50.23 | 62.463 | 15.928 | 13951 | 313 |
| pull_fast_forward | candidate | 50.41 | 62.396 | 15.929 | 13947 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
