# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-20 19:48 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/44788133524)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.10s | 10.58s | 1.2× | 1.5% | **PASS** |
| Writes | 1.80s | 3.04s | 1.7× | 1.3% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.13s | 10.87s | 1.1× | 1.6% | **PASS** |
| Writes | 3.57s | 4.02s | 1.1× | 4.0% | **PASS** |
| Autocommit writes | 812.65ms | 2.39s | 2.9× | 8.6% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.46s | 2.90s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.59s | 3.27s | 1.3× | 1.5% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.11s | 2.42s | 1.1× | 1.4% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.95s | 2.00s | 1.0× | 2.9% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 428.73ms | 762.53ms | 1.8× | 1.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 562.63ms | 974.08ms | 1.7× | 0.9% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 444.64ms | 704.80ms | 1.6× | 1.2% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 368.04ms | 597.30ms | 1.6× | 2.6% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.69s | 2.95s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.79s | 3.32s | 1.2× | 1.4% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.48s | 2.55s | 1.0× | 1.6% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.18s | 2.04s | 0.9× | 2.0% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 592.48ms | 832.79ms | 1.4× | 1.7% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 911.14ms | 1.09s | 1.2× | 3.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.15s | 1.16s | 1.0× | 6.8% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 911.89ms | 934.03ms | 1.0× | 4.9% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.54s | 2.96s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.75s | 3.35s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.36s | 2.52s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.08s | 2.04s | 1.0× | 2.7% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 190.45ms | 630.77ms | 3.3× | 6.8% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 215.95ms | 684.03ms | 3.2× | 8.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 201.55ms | 543.13ms | 2.7× | 17.7% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 204.71ms | 530.07ms | 2.6× | 5.9% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.84ms | 31.66ms | 1.3× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 10.88ms | 12.89ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_sum_range` | 9.66ms | 12.24ms | 1.3× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 2.70ms | 3.16ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.65ms | 4.36ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.83ms | 5.70ms | 1.5× | 1.9% | PASS |
| mem_reads | `select_random_points` | 10.05ms | 11.88ms | 1.2× | 2.1% | PASS |
| mem_reads | `select_random_ranges` | 4.54ms | 5.41ms | 1.2× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.92ms | 10.82ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 30.46ms | 35.60ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 5.73ms | 8.80ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.25ms | 5.73ms | 1.8× | 1.5% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.18s | 1.36s | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_read_only` | 104.42ms | 130.35ms | 1.2× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 174.17ms | 299.89ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 14.84ms | 26.81ms | 1.8× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 49.26ms | 97.28ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 34.40ms | 63.49ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 43.19ms | 77.16ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 21.28ms | 47.84ms | 2.2× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 24.31ms | 37.80ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 67.28ms | 112.27ms | 1.7× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 93.19ms | 49.53ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 18.44ms | 14.86ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 17.22ms | 14.29ms | 0.8× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 3.54ms | 3.42ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.54ms | 4.65ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.23ms | 7.83ms | 0.7× | 1.1% | PASS |
| file_reads | `select_random_points` | 17.72ms | 13.98ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 11.81ms | 7.37ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.55ms | 13.05ms | 0.8× | 1.2% | PASS |
| file_reads | `groupby_scan` | 31.56ms | 36.05ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 9.95ms | 10.38ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.21ms | 6.15ms | 1.5× | 1.5% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.18s | 1.35s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 205.00ms | 157.30ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 188.08ms | 312.87ms | 1.7× | 1.1% | PASS |
| file_writes | `oltp_insert` | 21.76ms | 30.30ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 77.50ms | 109.68ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 58.22ms | 70.99ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 68.25ms | 90.03ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 44.94ms | 55.09ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 40.30ms | 44.42ms | 1.1× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 93.43ms | 119.42ms | 1.3× | 1.7% | PASS |
| ac_reads | `oltp_point_select` | 45.86ms | 49.70ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_range_select` | 13.59ms | 15.01ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 12.30ms | 14.34ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 3.03ms | 3.44ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.97ms | 4.64ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_index_scan` | 6.28ms | 7.81ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 12.68ms | 14.01ms | 1.1× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 6.93ms | 7.42ms | 1.1× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.44ms | 13.05ms | 1.3× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 30.94ms | 35.99ms | 1.2× | 0.5% | PASS |
| ac_reads | `index_join` | 7.33ms | 10.44ms | 1.4× | 2.5% | PASS |
| ac_reads | `index_join_scan` | 3.70ms | 6.13ms | 1.7× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.18s | 1.35s | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 138.18ms | 158.83ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.94ms | 65.67ms | 3.1× | 6.2% | PASS |
| ac_writes | `oltp_insert_ac` | 24.06ms | 76.76ms | 3.2× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.04ms | 91.53ms | 3.5× | 8.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.47ms | 72.44ms | 3.4× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.40ms | 83.12ms | 3.4× | 7.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.75ms | 80.49ms | 3.4× | 6.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.17ms | 73.69ms | 3.5× | 10.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.62ms | 87.06ms | 3.0× | 5.0% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.81ms | 40.85ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 16.35ms | 16.92ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 14.73ms | 16.24ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 3.30ms | 3.64ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 4.27ms | 4.78ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 3.94ms | 6.88ms | 1.7× | 1.0% | PASS |
| mem_reads | `select_random_points` | 20.82ms | 22.84ms | 1.1× | 2.8% | PASS |
| mem_reads | `select_random_ranges` | 6.20ms | 7.07ms | 1.1× | 2.5% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 11.30ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 33.95ms | 37.77ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 9.94ms | 10.71ms | 1.1× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.61ms | 6.60ms | 1.8× | 1.5% | PASS |
| mem_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.52s | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 133.14ms | 153.45ms | 1.2× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 232.20ms | 359.76ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.31ms | 36.61ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 62.04ms | 138.95ms | 2.2× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 45.19ms | 82.26ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 51.36ms | 102.87ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 26.24ms | 54.97ms | 2.1× | 0.9% | PASS |
| mem_writes | `types_delete_insert` | 36.34ms | 59.05ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 91.95ms | 139.61ms | 1.5× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 103.04ms | 59.36ms | 0.6× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 23.08ms | 19.00ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 21.82ms | 18.45ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.05ms | 3.91ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 5.09ms | 5.09ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 10.91ms | 8.98ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_points` | 29.29ms | 25.72ms | 0.9× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 13.48ms | 9.28ms | 0.7× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.29ms | 13.49ms | 0.9× | 0.9% | PASS |
| file_reads | `groupby_scan` | 35.21ms | 38.34ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.23ms | 12.13ms | 0.9× | 2.1% | PASS |
| file_reads | `index_join_scan` | 4.61ms | 7.02ms | 1.5× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.6% | PASS |
| file_reads | `table_scan` | 1.20s | 1.51s | 1.3× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 237.89ms | 183.12ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 257.41ms | 377.09ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.12ms | 42.30ms | 1.7× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 114.37ms | 160.00ms | 1.4× | 11.9% | PASS |
| file_writes | `oltp_update_non_index` | 105.00ms | 96.95ms | 0.9× | 9.1% | PASS |
| file_writes | `oltp_delete_insert` | 95.48ms | 120.74ms | 1.3× | 0.9% | PASS |
| file_writes | `oltp_write_only` | 89.43ms | 68.56ms | 0.8× | 9.4% | PASS |
| file_writes | `types_delete_insert` | 72.05ms | 69.71ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 152.28ms | 154.66ms | 1.0× | 4.6% | PASS |
| ac_reads | `oltp_point_select` | 57.77ms | 60.05ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 19.29ms | 19.05ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 17.79ms | 18.48ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.82ms | 3.93ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.76ms | 5.13ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.59ms | 9.01ms | 1.4× | 1.6% | PASS |
| ac_reads | `select_random_points` | 25.31ms | 25.95ms | 1.0× | 3.4% | PASS |
| ac_reads | `select_random_ranges` | 9.26ms | 9.33ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 10.84ms | 13.52ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 34.95ms | 38.40ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 12.22ms | 12.23ms | 1.0× | 3.4% | PASS |
| ac_reads | `index_join_scan` | 4.16ms | 7.01ms | 1.7× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 1.1% | PASS |
| ac_reads | `table_scan` | 1.28s | 1.53s | 1.2× | 2.5% | PASS |
| ac_reads | `oltp_read_only` | 181.55ms | 188.50ms | 1.0× | 2.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.57ms | 64.91ms | 2.8× | 8.5% | PASS |
| ac_writes | `oltp_insert_ac` | 27.60ms | 83.97ms | 3.0× | 7.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.95ms | 112.79ms | 3.5× | 8.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 24.73ms | 84.41ms | 3.4× | 8.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.66ms | 88.16ms | 3.3× | 12.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.03ms | 82.10ms | 3.3× | 7.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 24.59ms | 77.36ms | 3.1× | 9.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.83ms | 90.32ms | 2.8× | 5.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.41ms | 29.02ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 13.30ms | 12.58ms | 0.9× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 12.22ms | 11.72ms | 1.0× | 2.9% | PASS |
| mem_reads | `oltp_order_range` | 2.70ms | 2.78ms | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.59ms | 3.60ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 3.16ms | 5.17ms | 1.6× | 1.3% | PASS |
| mem_reads | `select_random_points` | 17.36ms | 16.96ms | 1.0× | 3.7% | PASS |
| mem_reads | `select_random_ranges` | 5.11ms | 5.03ms | 1.0× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 5.88ms | 8.07ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 28.39ms | 29.64ms | 1.0× | 0.5% | PASS |
| mem_reads | `index_join` | 8.43ms | 8.62ms | 1.0× | 1.6% | PASS |
| mem_reads | `index_join_scan` | 3.06ms | 5.54ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 875.15ms | 1.04s | 1.2× | 0.7% | PASS |
| mem_reads | `table_scan` | 993.21ms | 1.12s | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 107.68ms | 110.25ms | 1.0× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.58ms | 260.46ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.01ms | 27.27ms | 1.9× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 51.04ms | 102.67ms | 2.0× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 37.96ms | 57.96ms | 1.5× | 2.5% | PASS |
| mem_writes | `oltp_delete_insert` | 41.03ms | 75.90ms | 1.9× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 22.27ms | 40.56ms | 1.8× | 1.7% | PASS |
| mem_writes | `types_delete_insert` | 29.26ms | 41.76ms | 1.4× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 71.49ms | 98.21ms | 1.4× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 95.07ms | 45.03ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 21.16ms | 14.38ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 20.54ms | 13.76ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.46ms | 3.04ms | 0.9× | 2.6% | PASS |
| file_reads | `oltp_distinct_range` | 4.36ms | 3.80ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 10.08ms | 6.88ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 23.85ms | 18.50ms | 0.8× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 12.16ms | 6.79ms | 0.6× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 13.04ms | 9.81ms | 0.8× | 0.9% | PASS |
| file_reads | `groupby_scan` | 29.36ms | 29.88ms | 1.0× | 1.1% | PASS |
| file_reads | `index_join` | 12.74ms | 9.58ms | 0.8× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.05ms | 5.81ms | 1.4× | 1.0% | PASS |
| file_reads | `types_table_scan` | 949.82ms | 1.08s | 1.1× | 1.8% | PASS |
| file_reads | `table_scan` | 1.08s | 1.17s | 1.1× | 5.8% | PASS |
| file_reads | `oltp_read_only` | 205.82ms | 133.82ms | 0.7× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 244.25ms | 336.79ms | 1.4× | 4.6% | PASS |
| file_writes | `oltp_insert` | 26.58ms | 49.50ms | 1.9× | 14.3% | PASS |
| file_writes | `oltp_update_index` | 159.44ms | 192.65ms | 1.2× | 6.7% | PASS |
| file_writes | `oltp_update_non_index` | 135.19ms | 117.99ms | 0.9× | 3.7% | PASS |
| file_writes | `oltp_delete_insert` | 177.94ms | 150.66ms | 0.8× | 11.5% | PASS |
| file_writes | `oltp_write_only` | 119.98ms | 88.86ms | 0.7× | 6.9% | PASS |
| file_writes | `types_delete_insert` | 119.65ms | 79.25ms | 0.7× | 8.8% | PASS |
| file_writes | `oltp_read_write` | 170.41ms | 148.68ms | 0.9× | 4.4% | PASS |
| ac_reads | `oltp_point_select` | 48.85ms | 45.54ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 16.61ms | 14.31ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 14.88ms | 13.41ms | 0.9× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 3.18ms | 3.02ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.96ms | 3.78ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.65ms | 6.86ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 19.75ms | 18.71ms | 0.9× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 7.85ms | 6.83ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.54ms | 9.86ms | 1.2× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 29.49ms | 30.14ms | 1.0× | 0.6% | PASS |
| ac_reads | `index_join` | 10.97ms | 9.81ms | 0.9× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.59ms | 5.70ms | 1.6× | 1.2% | PASS |
| ac_reads | `types_table_scan` | 875.62ms | 1.04s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.18s | 1.18s | 1.0× | 4.6% | PASS |
| ac_reads | `oltp_read_only` | 137.08ms | 133.43ms | 1.0× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.54ms | 51.79ms | 2.2× | 23.9% | PASS |
| ac_writes | `oltp_insert_ac` | 28.04ms | 67.58ms | 2.4× | 17.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.04ms | 78.74ms | 2.9× | 17.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.12ms | 58.04ms | 2.6× | 19.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.97ms | 72.22ms | 2.8× | 13.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.26ms | 67.45ms | 2.7× | 15.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.15ms | 70.57ms | 3.7× | 28.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.44ms | 76.74ms | 2.5× | 16.7% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.57ms | 26.05ms | 1.2× | 2.9% | PASS |
| mem_reads | `oltp_range_select` | 12.41ms | 12.98ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 10.94ms | 12.30ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 2.37ms | 2.44ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_distinct_range` | 2.86ms | 2.88ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.06ms | 4.57ms | 1.5× | 3.1% | PASS |
| mem_reads | `select_random_points` | 18.24ms | 21.66ms | 1.2× | 3.4% | PASS |
| mem_reads | `select_random_ranges` | 4.88ms | 5.59ms | 1.1× | 2.4% | PASS |
| mem_reads | `covering_index_scan` | 4.31ms | 7.10ms | 1.6× | 2.8% | PASS |
| mem_reads | `groupby_scan` | 23.55ms | 25.16ms | 1.1× | 1.3% | PASS |
| mem_reads | `index_join` | 5.37ms | 9.62ms | 1.8× | 3.2% | PASS |
| mem_reads | `index_join_scan` | 3.17ms | 5.74ms | 1.8× | 4.8% | PASS |
| mem_reads | `types_table_scan` | 732.71ms | 820.00ms | 1.1× | 2.9% | PASS |
| mem_reads | `table_scan` | 1.01s | 948.26ms | 0.9× | 3.2% | PASS |
| mem_reads | `oltp_read_only` | 89.25ms | 95.70ms | 1.1× | 3.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 146.45ms | 209.59ms | 1.4× | 1.4% | PASS |
| mem_writes | `oltp_insert` | 11.32ms | 20.90ms | 1.8× | 2.3% | PASS |
| mem_writes | `oltp_update_index` | 44.56ms | 84.58ms | 1.9× | 2.4% | PASS |
| mem_writes | `oltp_update_non_index` | 34.27ms | 57.08ms | 1.7× | 2.3% | PASS |
| mem_writes | `oltp_delete_insert` | 31.40ms | 61.13ms | 1.9× | 2.9% | PASS |
| mem_writes | `oltp_write_only` | 17.83ms | 38.03ms | 2.1× | 3.2% | PASS |
| mem_writes | `types_delete_insert` | 20.91ms | 33.72ms | 1.6× | 3.5% | PASS |
| mem_writes | `oltp_read_write` | 61.32ms | 92.26ms | 1.5× | 4.2% | PASS |
| file_reads | `oltp_point_select` | 74.92ms | 39.01ms | 0.5× | 2.0% | PASS |
| file_reads | `oltp_range_select` | 17.59ms | 14.27ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 16.26ms | 13.39ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.00ms | 2.63ms | 0.9× | 1.7% | PASS |
| file_reads | `oltp_distinct_range` | 3.58ms | 3.18ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 9.03ms | 6.07ms | 0.7× | 1.9% | PASS |
| file_reads | `select_random_points` | 22.59ms | 20.79ms | 0.9× | 3.6% | PASS |
| file_reads | `select_random_ranges` | 10.24ms | 6.90ms | 0.7× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 10.19ms | 7.92ms | 0.8× | 2.2% | PASS |
| file_reads | `groupby_scan` | 23.35ms | 24.31ms | 1.0× | 2.5% | PASS |
| file_reads | `index_join` | 8.30ms | 8.50ms | 1.0× | 3.2% | PASS |
| file_reads | `index_join_scan` | 3.67ms | 5.45ms | 1.5× | 6.4% | PASS |
| file_reads | `types_table_scan` | 797.13ms | 841.16ms | 1.1× | 2.5% | PASS |
| file_reads | `table_scan` | 1.01s | 929.90ms | 0.9× | 3.5% | PASS |
| file_reads | `oltp_read_only` | 170.54ms | 117.49ms | 0.7× | 2.0% | PASS |
| file_writes | `oltp_bulk_insert` | 196.02ms | 259.12ms | 1.3× | 4.1% | PASS |
| file_writes | `oltp_insert` | 23.50ms | 30.33ms | 1.3× | 7.5% | PASS |
| file_writes | `oltp_update_index` | 150.59ms | 144.78ms | 1.0× | 3.2% | PASS |
| file_writes | `oltp_update_non_index` | 126.27ms | 101.10ms | 0.8× | 3.7% | PASS |
| file_writes | `oltp_delete_insert` | 123.28ms | 115.48ms | 0.9× | 3.9% | PASS |
| file_writes | `oltp_write_only` | 81.32ms | 81.75ms | 1.0× | 8.5% | PASS |
| file_writes | `types_delete_insert` | 77.56ms | 67.02ms | 0.9× | 8.5% | PASS |
| file_writes | `oltp_read_write` | 133.35ms | 134.45ms | 1.0× | 5.7% | PASS |
| ac_reads | `oltp_point_select` | 39.96ms | 39.48ms | 1.0× | 2.9% | PASS |
| ac_reads | `oltp_range_select` | 14.06ms | 14.20ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 12.89ms | 13.62ms | 1.1× | 2.5% | PASS |
| ac_reads | `oltp_order_range` | 2.65ms | 2.59ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.36ms | 3.20ms | 1.0× | 2.7% | PASS |
| ac_reads | `oltp_index_scan` | 5.56ms | 6.16ms | 1.1× | 3.2% | PASS |
| ac_reads | `select_random_points` | 20.99ms | 23.49ms | 1.1× | 4.8% | PASS |
| ac_reads | `select_random_ranges` | 7.09ms | 7.38ms | 1.0× | 2.6% | PASS |
| ac_reads | `covering_index_scan` | 6.84ms | 8.13ms | 1.2× | 2.8% | PASS |
| ac_reads | `groupby_scan` | 24.03ms | 25.26ms | 1.1× | 2.1% | PASS |
| ac_reads | `index_join` | 7.05ms | 10.03ms | 1.4× | 6.3% | PASS |
| ac_reads | `index_join_scan` | 3.30ms | 5.41ms | 1.6× | 7.2% | PASS |
| ac_reads | `types_table_scan` | 757.86ms | 817.17ms | 1.1× | 3.0% | PASS |
| ac_reads | `table_scan` | 1.05s | 942.01ms | 0.9× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 121.83ms | 117.86ms | 1.0× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.21ms | 56.50ms | 2.5× | 5.3% | PASS |
| ac_writes | `oltp_insert_ac` | 26.36ms | 64.30ms | 2.4× | 3.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 29.07ms | 75.49ms | 2.6× | 10.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.15ms | 62.47ms | 2.8× | 10.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.37ms | 66.84ms | 2.6× | 4.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.38ms | 69.28ms | 2.7× | 6.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 25.66ms | 61.18ms | 2.4× | 10.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.49ms | 74.03ms | 2.6× | 5.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 34s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.91ms | 38.00ms | 55.0% | 2.1% | PASS |
| `status_dirty_many_tables` | 22.88ms | 42.00ms | 54.5% | 1.0% | PASS |
| `diff_regular_working_one_table` | 18.15ms | 33.00ms | 55.0% | 1.9% | PASS |
| `diff_regular_working_many_tables` | 25.67ms | 50.00ms | 51.3% | 1.9% | PASS |
| `diff_stat_working_many_tables` | 26.43ms | 48.00ms | 55.1% | 1.7% | PASS |
| `diff_schema_working_many_tables` | 26.79ms | 48.00ms | 55.8% | 1.7% | PASS |
| `branch_list_many_branches` | 14.44ms | 25.00ms | 57.8% | 2.8% | PASS |
| `branch_create_delete` | 15.10ms | 27.00ms | 55.9% | 2.0% | PASS |
| `at_literal_deep_history` | 15.15ms | 28.00ms | 54.1% | 2.2% | PASS |
| `diff_literal_deep_history` | 15.96ms | 28.00ms | 57.0% | 3.1% | PASS |
| `history_literal_deep_history` | 16.48ms | 30.00ms | 54.9% | 3.1% | PASS |
| `checkout_branch_clean` | 21.27ms | 43.00ms | 49.5% | 2.6% | PASS |
| `merge_data_no_conflicts` | 18.20ms | 33.00ms | 55.1% | 2.4% | PASS |
| `merge_data_secondary_index` | 655.79ms | 944.00ms | 69.5% | 1.7% | PASS |
| `merge_schema_no_conflicts` | 12.74ms | 24.00ms | 53.1% | 1.6% | PASS |
| `merge_data_conflicts` | 19.66ms | 33.00ms | 59.6% | 2.3% | PASS |
| `merge_data_conflicts_with_resolve` | 20.20ms | 34.00ms | 59.4% | 2.6% | PASS |

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
| copy_fsync | candidate | 400.665 | 395.327–527.475 | 32.797 | 249.59 | 107968266 |
| push_initial | candidate | 753.056 | 740.842–763.363 | 395.017 | 132.79 | 107956772 |
| clone_initial | candidate | 879.382 | 841.224–888.184 | 523.540 | 113.72 | 108475035 |
| push_noop | candidate | 0.599 | 0.570–0.609 | 0.302 | — | 0 |
| fetch_noop | candidate | 0.160 | 0.138–0.186 | 0.162 | — | 0 |
| push_incremental | candidate | 175.295 | 168.083–182.870 | 154.733 | 5.70 | 7909775 |
| fetch_incremental | candidate | 85.800 | 80.788–90.918 | 65.677 | 11.66 | 7910084 |
| pull_fast_forward | candidate | 76.445 | 70.089–78.150 | 57.653 | 13.08 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.55 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.74 | 295.214 | 109.784 | 47272 | 2337 |
| push_noop | candidate | 45.83 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.83 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.83 | 96.933 | 7.910 | 22428 | 125 |
| fetch_incremental | candidate | 45.83 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.83 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5536.912 | 5476.311–5551.963 | 299.877 | 180.61 | 1087718031 |
| push_initial | candidate | 7525.840 | 7446.734–7564.869 | 3749.625 | 132.88 | 1079566275 |
| clone_initial | candidate | 9175.914 | 9034.530–9227.704 | 5482.541 | 108.98 | 1102407326 |
| push_noop | candidate | 0.640 | 0.635–0.735 | 0.294 | — | 0 |
| fetch_noop | candidate | 0.141 | 0.138–0.143 | 0.143 | — | 0 |
| push_incremental | candidate | 904.165 | 897.428–905.241 | 853.125 | 1.11 | 15806003 |
| fetch_incremental | candidate | 265.352 | 252.035–270.708 | 194.288 | 3.77 | 15806513 |
| pull_fast_forward | candidate | 237.599 | 232.402–242.596 | 190.204 | 4.21 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.00 | 2091.404 | 1087.622 | 263382 | 20541 |
| clone_initial | candidate | 124.05 | 3520.581 | 1132.819 | 613030 | 32243 |
| push_noop | candidate | 47.15 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.15 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 47.15 | 617.601 | 15.928 | 150029 | 313 |
| fetch_incremental | candidate | 50.40 | 61.581 | 15.928 | 13736 | 313 |
| pull_fast_forward | candidate | 50.52 | 61.514 | 15.929 | 13732 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
