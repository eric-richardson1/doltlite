# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-11 19:21 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43067597220)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.22s | 10.32s | 1.1× | 1.5% | **PASS** |
| Writes | 1.82s | 2.95s | 1.6× | 1.1% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.23s | 10.54s | 1.0× | 1.1% | **PASS** |
| Writes | 4.14s | 4.29s | 1.0× | 7.0% | **PASS** |
| Autocommit writes | 736.63ms | 2.56s | 3.5× | 14.3% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.00s | 2.22s | 1.1× | 1.5% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.81s | 3.14s | 1.1× | 1.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.16s | 2.47s | 1.1× | 1.6% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.25s | 2.49s | 1.1× | 2.1% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 331.16ms | 553.74ms | 1.7× | 1.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 582.19ms | 963.58ms | 1.7× | 1.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 458.48ms | 724.14ms | 1.6× | 1.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 449.96ms | 708.68ms | 1.6× | 1.1% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.35s | 2.30s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.10s | 3.21s | 1.0× | 1.2% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.43s | 2.53s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.35s | 2.50s | 1.1× | 0.9% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 940.41ms | 929.49ms | 1.0× | 10.9% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 940.25ms | 1.08s | 1.1× | 3.5% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.17s | 1.18s | 1.0× | 7.0% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.09s | 1.11s | 1.0× | 8.0% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.23s | 2.31s | 1.0× | 1.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.96s | 3.22s | 1.1× | 1.2% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.42s | 2.59s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.22s | 2.51s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 233.47ms | 873.06ms | 3.7× | 49.0% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 172.76ms | 592.95ms | 3.4× | 5.8% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 168.69ms | 551.63ms | 3.3× | 14.3% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 161.70ms | 543.08ms | 3.4× | 14.1% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 18.80ms | 22.84ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 8.92ms | 9.74ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_sum_range` | 7.66ms | 9.11ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 2.17ms | 2.44ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 2.95ms | 3.25ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.06ms | 4.18ms | 1.4× | 1.5% | PASS |
| mem_reads | `select_random_points` | 8.38ms | 9.51ms | 1.1× | 1.4% | PASS |
| mem_reads | `select_random_ranges` | 3.63ms | 3.87ms | 1.1× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 5.84ms | 7.63ms | 1.3× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 24.80ms | 27.77ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 4.48ms | 6.43ms | 1.4× | 1.6% | PASS |
| mem_reads | `index_join_scan` | 2.61ms | 4.55ms | 1.7× | 1.1% | PASS |
| mem_reads | `types_table_scan` | 852.98ms | 963.12ms | 1.1× | 0.6% | PASS |
| mem_reads | `table_scan` | 970.11ms | 1.05s | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 86.63ms | 96.22ms | 1.1× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.81ms | 219.50ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.78ms | 19.57ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 39.03ms | 72.14ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 26.96ms | 46.45ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 33.97ms | 56.08ms | 1.7× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 16.90ms | 35.05ms | 2.1× | 0.8% | PASS |
| mem_writes | `types_delete_insert` | 18.70ms | 25.83ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 49.01ms | 79.13ms | 1.6× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 86.55ms | 38.98ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 15.94ms | 11.50ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 14.65ms | 10.79ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 2.95ms | 2.63ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 3.71ms | 3.50ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 10.28ms | 6.04ms | 0.6× | 1.2% | PASS |
| file_reads | `select_random_points` | 15.73ms | 11.43ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 10.64ms | 5.63ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.18ms | 9.60ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 26.06ms | 28.12ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 8.44ms | 7.95ms | 0.9× | 1.1% | PASS |
| file_reads | `index_join_scan` | 3.54ms | 4.90ms | 1.4× | 1.5% | PASS |
| file_reads | `types_table_scan` | 881.73ms | 968.50ms | 1.1× | 1.3% | PASS |
| file_reads | `table_scan` | 1.07s | 1.08s | 1.0× | 2.3% | PASS |
| file_reads | `oltp_read_only` | 182.99ms | 119.53ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 184.66ms | 275.41ms | 1.5× | 6.1% | PASS |
| file_writes | `oltp_insert` | 29.80ms | 31.87ms | 1.1× | 13.4% | PASS |
| file_writes | `oltp_update_index` | 148.59ms | 145.88ms | 1.0× | 10.2% | PASS |
| file_writes | `oltp_update_non_index` | 116.82ms | 91.83ms | 0.8× | 6.0% | PASS |
| file_writes | `oltp_delete_insert` | 123.23ms | 110.43ms | 0.9× | 6.2% | PASS |
| file_writes | `oltp_write_only` | 96.75ms | 78.32ms | 0.8× | 18.5% | PASS |
| file_writes | `types_delete_insert` | 77.72ms | 60.70ms | 0.8× | 11.5% | PASS |
| file_writes | `oltp_read_write` | 162.84ms | 135.03ms | 0.8× | 29.8% | PASS |
| ac_reads | `oltp_point_select` | 40.26ms | 39.51ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 11.52ms | 11.56ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 10.41ms | 10.98ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 2.58ms | 2.65ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.31ms | 3.51ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 5.73ms | 6.11ms | 1.1× | 1.2% | PASS |
| ac_reads | `select_random_points` | 11.29ms | 11.55ms | 1.0× | 1.3% | PASS |
| ac_reads | `select_random_ranges` | 5.99ms | 5.64ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.63ms | 1.1× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 25.74ms | 28.20ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 6.17ms | 8.07ms | 1.3× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 3.09ms | 4.86ms | 1.6× | 1.5% | PASS |
| ac_reads | `types_table_scan` | 885.89ms | 970.51ms | 1.1× | 1.9% | PASS |
| ac_reads | `table_scan` | 1.09s | 1.08s | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 115.63ms | 119.57ms | 1.0× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.42ms | 96.60ms | 4.3× | 54.9% | PASS |
| ac_writes | `oltp_insert_ac` | 29.07ms | 91.91ms | 3.2× | 37.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.99ms | 165.14ms | 6.1× (paired 4.7×) | 75.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 46.44ms | 104.16ms | 2.2× | 74.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 29.55ms | 104.33ms | 3.5× | 48.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.14ms | 87.97ms | 3.6× | 26.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.52ms | 104.01ms | 4.4× | 45.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.35ms | 118.93ms | 3.8× | 49.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 36.24ms | 37.45ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 18.24ms | 16.24ms | 0.9× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 16.50ms | 15.51ms | 0.9× | 0.9% | PASS |
| mem_reads | `oltp_order_range` | 3.63ms | 3.62ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.58ms | 4.63ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 4.06ms | 6.57ms | 1.6× | 1.2% | PASS |
| mem_reads | `select_random_points` | 23.18ms | 22.38ms | 1.0× | 1.7% | PASS |
| mem_reads | `select_random_ranges` | 6.88ms | 6.46ms | 0.9× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 7.63ms | 10.53ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 37.40ms | 38.57ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 11.33ms | 10.69ms | 0.9× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 4.02ms | 7.20ms | 1.8× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 1.18s | 1.36s | 1.1× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.31s | 1.46s | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 139.68ms | 142.30ms | 1.0× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 230.86ms | 343.98ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 17.60ms | 36.91ms | 2.1× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 66.51ms | 142.82ms | 2.1× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 49.17ms | 82.98ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 54.96ms | 106.33ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 28.60ms | 57.17ms | 2.0× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 39.22ms | 60.03ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 95.27ms | 133.36ms | 1.4× | 1.4% | PASS |
| file_reads | `oltp_point_select` | 124.45ms | 58.34ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 27.18ms | 18.37ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_sum_range` | 25.05ms | 17.56ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 4.59ms | 3.85ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.56ms | 4.85ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 13.13ms | 8.71ms | 0.7× | 1.2% | PASS |
| file_reads | `select_random_points` | 31.92ms | 24.33ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 15.97ms | 8.74ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 17.04ms | 12.88ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 38.31ms | 38.68ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 16.77ms | 11.96ms | 0.7× | 1.8% | PASS |
| file_reads | `index_join_scan` | 5.15ms | 7.54ms | 1.5× | 2.5% | PASS |
| file_reads | `types_table_scan` | 1.16s | 1.35s | 1.2× | 1.2% | PASS |
| file_reads | `table_scan` | 1.34s | 1.47s | 1.1× | 1.8% | PASS |
| file_reads | `oltp_read_only` | 272.35ms | 175.40ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 259.16ms | 361.48ms | 1.4× | 1.1% | PASS |
| file_writes | `oltp_insert` | 25.61ms | 42.49ms | 1.7× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 141.45ms | 164.85ms | 1.2× | 5.9% | PASS |
| file_writes | `oltp_update_non_index` | 105.76ms | 96.67ms | 0.9× | 7.8% | PASS |
| file_writes | `oltp_delete_insert` | 98.99ms | 123.43ms | 1.2× | 1.1% | PASS |
| file_writes | `oltp_write_only` | 84.54ms | 70.08ms | 0.8× | 14.0% | PASS |
| file_writes | `types_delete_insert` | 74.92ms | 69.24ms | 0.9× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 149.82ms | 147.06ms | 1.0× | 5.3% | PASS |
| ac_reads | `oltp_point_select` | 63.53ms | 58.56ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 21.55ms | 18.41ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 19.36ms | 17.64ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 4.08ms | 3.87ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 5.01ms | 4.88ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 7.41ms | 8.89ms | 1.2× | 1.1% | PASS |
| ac_reads | `select_random_points` | 28.96ms | 25.70ms | 0.9× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 10.12ms | 8.80ms | 0.9× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 11.06ms | 12.91ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 37.91ms | 38.81ms | 1.0× | 0.5% | PASS |
| ac_reads | `index_join` | 14.28ms | 12.23ms | 0.9× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 4.62ms | 7.61ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.17s | 1.35s | 1.2× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.38s | 1.48s | 1.1× | 2.2% | PASS |
| ac_reads | `oltp_read_only` | 182.29ms | 174.21ms | 1.0× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.47ms | 57.60ms | 3.1× | 5.0% | PASS |
| ac_writes | `oltp_insert_ac` | 21.77ms | 71.12ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.36ms | 90.09ms | 3.9× | 5.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.25ms | 67.11ms | 3.7× | 7.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.80ms | 80.92ms | 3.7× | 6.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.36ms | 76.00ms | 3.6× | 6.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.85ms | 66.72ms | 3.4× | 6.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.91ms | 83.38ms | 3.0× | 4.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.38ms | 28.97ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 14.19ms | 12.59ms | 0.9× | 3.1% | PASS |
| mem_reads | `oltp_sum_range` | 12.83ms | 11.82ms | 0.9× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 2.80ms | 2.83ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 3.53ms | 3.61ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.14ms | 5.11ms | 1.6× | 1.0% | PASS |
| mem_reads | `select_random_points` | 16.18ms | 16.55ms | 1.0× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 5.14ms | 4.98ms | 1.0× | 0.9% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.06ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 28.64ms | 29.53ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 8.98ms | 8.88ms | 1.0× | 1.8% | PASS |
| mem_reads | `index_join_scan` | 3.16ms | 5.76ms | 1.8× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 925.05ms | 1.08s | 1.2× | 3.0% | PASS |
| mem_reads | `table_scan` | 981.28ms | 1.13s | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_read_only` | 120.09ms | 115.55ms | 1.0× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.53ms | 261.21ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.17ms | 27.96ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 54.74ms | 109.19ms | 2.0× | 2.3% | PASS |
| mem_writes | `oltp_update_non_index` | 40.60ms | 60.80ms | 1.5× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 44.08ms | 80.28ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 23.41ms | 41.83ms | 1.8× | 2.4% | PASS |
| mem_writes | `types_delete_insert` | 30.27ms | 43.14ms | 1.4× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 73.68ms | 99.73ms | 1.4× | 2.1% | PASS |
| file_reads | `oltp_point_select` | 96.94ms | 45.42ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 21.55ms | 14.27ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 19.57ms | 13.43ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 3.59ms | 3.04ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 4.44ms | 3.83ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 10.57ms | 7.12ms | 0.7× | 1.5% | PASS |
| file_reads | `select_random_points` | 29.91ms | 21.43ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 12.80ms | 7.01ms | 0.5× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.41ms | 10.02ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 30.65ms | 30.61ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 13.51ms | 9.95ms | 0.7× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.00ms | 5.83ms | 1.5× | 2.2% | PASS |
| file_reads | `types_table_scan` | 976.24ms | 1.09s | 1.1× | 3.3% | PASS |
| file_reads | `table_scan` | 978.67ms | 1.13s | 1.2× | 0.9% | PASS |
| file_reads | `oltp_read_only` | 209.16ms | 134.86ms | 0.6× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 248.55ms | 338.16ms | 1.4× | 7.0% | PASS |
| file_writes | `oltp_insert` | 34.34ms | 50.81ms | 1.5× | 38.4% | PASS |
| file_writes | `oltp_update_index` | 165.58ms | 188.48ms | 1.1× | 12.2% | PASS |
| file_writes | `oltp_update_non_index` | 138.54ms | 117.71ms | 0.8× | 5.1% | PASS |
| file_writes | `oltp_delete_insert` | 163.07ms | 144.55ms | 0.9× | 6.3% | PASS |
| file_writes | `oltp_write_only` | 118.61ms | 95.13ms | 0.8× | 7.0% | PASS |
| file_writes | `types_delete_insert` | 123.19ms | 86.24ms | 0.7× | 9.5% | PASS |
| file_writes | `oltp_read_write` | 178.52ms | 154.71ms | 0.9× | 7.0% | PASS |
| ac_reads | `oltp_point_select` | 49.11ms | 45.63ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 16.65ms | 14.26ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 15.22ms | 13.54ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 3.19ms | 3.04ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.96ms | 3.82ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.71ms | 6.84ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 20.22ms | 18.95ms | 0.9× | 1.7% | PASS |
| ac_reads | `select_random_ranges` | 7.73ms | 6.80ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.56ms | 9.83ms | 1.1× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 29.33ms | 29.91ms | 1.0× | 0.9% | PASS |
| ac_reads | `index_join` | 10.82ms | 9.79ms | 0.9× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.59ms | 5.68ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 948.85ms | 1.08s | 1.1× | 3.1% | PASS |
| ac_reads | `table_scan` | 1.15s | 1.21s | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 142.44ms | 135.19ms | 0.9× | 1.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.35ms | 55.30ms | 2.9× | 14.4% | PASS |
| ac_writes | `oltp_insert_ac` | 20.99ms | 70.71ms | 3.4× | 14.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.59ms | 84.72ms | 3.9× | 14.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.08ms | 62.01ms | 3.4× | 11.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.54ms | 68.68ms | 3.3× | 9.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.55ms | 71.25ms | 3.3× | 17.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.91ms | 62.34ms | 3.1× | 17.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.67ms | 76.62ms | 2.9× | 10.0% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.18ms | 30.36ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 15.83ms | 16.99ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 13.50ms | 16.04ms | 1.2× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 2.90ms | 3.15ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.71ms | 3.97ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.58ms | 4.76ms | 1.3× | 1.8% | PASS |
| mem_reads | `select_random_points` | 19.71ms | 23.39ms | 1.2× | 2.3% | PASS |
| mem_reads | `select_random_ranges` | 5.77ms | 6.63ms | 1.1× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 5.94ms | 8.03ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 30.16ms | 33.02ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 6.23ms | 8.77ms | 1.4× | 2.3% | PASS |
| mem_reads | `index_join_scan` | 3.42ms | 5.36ms | 1.6× | 2.8% | PASS |
| mem_reads | `types_table_scan` | 936.84ms | 1.06s | 1.1× | 2.7% | PASS |
| mem_reads | `table_scan` | 1.06s | 1.14s | 1.1× | 5.7% | PASS |
| mem_reads | `oltp_read_only` | 115.11ms | 131.38ms | 1.1× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 183.63ms | 256.64ms | 1.4× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.46ms | 25.03ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 51.76ms | 94.16ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 41.07ms | 65.11ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 38.92ms | 71.32ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 21.99ms | 44.31ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 24.55ms | 39.56ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_read_write` | 73.57ms | 112.55ms | 1.5× | 0.7% | PASS |
| file_reads | `oltp_point_select` | 94.42ms | 46.51ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 23.68ms | 18.95ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 21.18ms | 18.03ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 3.75ms | 3.43ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.55ms | 4.24ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 10.79ms | 6.84ms | 0.6× | 0.7% | PASS |
| file_reads | `select_random_points` | 27.34ms | 25.24ms | 0.9× | 1.0% | PASS |
| file_reads | `select_random_ranges` | 12.91ms | 8.53ms | 0.7× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.20ms | 9.82ms | 0.7× | 0.7% | PASS |
| file_reads | `groupby_scan` | 30.72ms | 33.21ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 10.18ms | 10.06ms | 1.0× | 0.9% | PASS |
| file_reads | `index_join_scan` | 4.01ms | 5.41ms | 1.3× | 1.1% | PASS |
| file_reads | `types_table_scan` | 876.57ms | 1.03s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.01s | 1.12s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 211.73ms | 154.81ms | 0.7× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 253.50ms | 327.00ms | 1.3× | 16.6% | PASS |
| file_writes | `oltp_insert` | 30.66ms | 42.91ms | 1.4× | 15.4% | PASS |
| file_writes | `oltp_update_index` | 165.28ms | 161.50ms | 1.0× | 4.4% | PASS |
| file_writes | `oltp_update_non_index` | 140.82ms | 114.67ms | 0.8× | 3.3% | PASS |
| file_writes | `oltp_delete_insert` | 139.02ms | 131.81ms | 0.9× | 2.9% | PASS |
| file_writes | `oltp_write_only` | 101.67ms | 92.94ms | 0.9× | 14.3% | PASS |
| file_writes | `types_delete_insert` | 91.40ms | 74.63ms | 0.8× | 6.3% | PASS |
| file_writes | `oltp_read_write` | 163.64ms | 160.47ms | 1.0× | 9.8% | PASS |
| ac_reads | `oltp_point_select` | 46.88ms | 46.50ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 18.55ms | 18.90ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 16.69ms | 18.17ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 3.35ms | 3.45ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.15ms | 4.26ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 6.32ms | 6.91ms | 1.1× | 1.1% | PASS |
| ac_reads | `select_random_points` | 23.51ms | 25.82ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 8.31ms | 8.58ms | 1.0× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 8.62ms | 9.89ms | 1.1× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 31.01ms | 33.58ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 7.95ms | 10.25ms | 1.3× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.67ms | 5.48ms | 1.5× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 878.54ms | 1.03s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.01s | 1.13s | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 151.88ms | 158.69ms | 1.0× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.63ms | 52.14ms | 3.0× | 10.7% | PASS |
| ac_writes | `oltp_insert_ac` | 20.11ms | 68.55ms | 3.4× | 12.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.26ms | 81.03ms | 3.5× | 13.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.76ms | 65.13ms | 3.5× | 23.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.38ms | 69.15ms | 3.4× | 20.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.49ms | 69.11ms | 3.5× | 11.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.22ms | 63.22ms | 3.7× | 14.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.86ms | 74.74ms | 3.0× | 14.8% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 21s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.70ms | 38.00ms | 83.4% | 1.1% | PASS |
| `status_dirty_many_tables` | 35.46ms | 42.00ms | 84.4% | 0.9% | PASS |
| `diff_regular_working_one_table` | 27.31ms | 33.00ms | 82.8% | 1.2% | PASS |
| `diff_regular_working_many_tables` | 40.43ms | 50.00ms | 80.9% | 1.0% | PASS |
| `diff_stat_working_many_tables` | 40.39ms | 48.00ms | 84.1% | 0.7% | PASS |
| `diff_schema_working_many_tables` | 41.02ms | 48.00ms | 85.5% | 0.9% | PASS |
| `branch_list_many_branches` | 19.93ms | 25.00ms | 79.7% | 1.6% | PASS |
| `branch_create_delete` | 21.40ms | 27.00ms | 79.3% | 1.3% | PASS |
| `at_literal_deep_history` | 21.52ms | 28.00ms | 76.9% | 1.3% | PASS |
| `diff_literal_deep_history` | 21.71ms | 28.00ms | 77.5% | 1.6% | PASS |
| `history_literal_deep_history` | 22.93ms | 30.00ms | 76.4% | 1.7% | PASS |
| `checkout_branch_clean` | 30.13ms | 43.00ms | 70.1% | 0.9% | PASS |
| `merge_data_no_conflicts` | 24.73ms | 33.00ms | 74.9% | 1.0% | PASS |
| `merge_data_secondary_index` | 897.65ms | 944.00ms | 95.1% | 0.9% | PASS |
| `merge_schema_no_conflicts` | 18.60ms | 24.00ms | 77.5% | 1.4% | PASS |
| `merge_data_conflicts` | 27.71ms | 33.00ms | 84.0% | 0.7% | PASS |
| `merge_data_conflicts_with_resolve` | 28.05ms | 34.00ms | 82.5% | 0.8% | PASS |

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
| copy_fsync | candidate | 59.870 | 55.714–64.718 | 39.724 | 1670.29 | 107968266 |
| push_initial | candidate | 591.201 | 584.460–599.033 | 573.000 | 169.15 | 107956772 |
| clone_initial | candidate | 765.653 | 761.909–769.217 | 740.038 | 130.61 | 108475035 |
| push_noop | candidate | 0.673 | 0.611–1.088 | 0.397 | — | 0 |
| fetch_noop | candidate | 0.212 | 0.199–0.251 | 0.215 | — | 0 |
| push_incremental | candidate | 230.752 | 230.618–231.658 | 228.324 | 4.33 | 7909775 |
| fetch_incremental | candidate | 96.451 | 95.927–97.326 | 94.126 | 10.37 | 7910084 |
| pull_fast_forward | candidate | 85.754 | 84.429–86.855 | 83.082 | 11.66 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.55 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.80 | 295.015 | 109.784 | 47222 | 2337 |
| push_noop | candidate | 46.01 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.01 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.01 | 96.705 | 7.910 | 22372 | 125 |
| fetch_incremental | candidate | 46.01 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.01 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2662.991 | 2654.942–2676.619 | 358.068 | 375.52 | 1087718031 |
| push_initial | candidate | 6570.103 | 6529.821–6585.582 | 4313.532 | 152.20 | 1079566275 |
| clone_initial | candidate | 6421.913 | 6410.804–6446.361 | 6225.556 | 155.72 | 1102407326 |
| push_noop | candidate | 0.827 | 0.745–0.853 | 0.288 | — | 0 |
| fetch_noop | candidate | 0.147 | 0.117–0.152 | 0.149 | — | 0 |
| push_incremental | candidate | 917.934 | 916.935–924.919 | 913.574 | 1.09 | 15806003 |
| fetch_incremental | candidate | 237.513 | 231.705–239.935 | 233.210 | 4.21 | 15806513 |
| pull_fast_forward | candidate | 244.987 | 243.995–245.965 | 239.963 | 4.08 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.82 | 2091.482 | 1087.622 | 263401 | 20541 |
| clone_initial | candidate | 124.03 | 3526.894 | 1132.819 | 614483 | 32243 |
| push_noop | candidate | 47.15 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.15 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.22 | 619.958 | 15.928 | 150564 | 313 |
| fetch_incremental | candidate | 50.46 | 62.152 | 15.928 | 13875 | 313 |
| pull_fast_forward | candidate | 50.43 | 62.084 | 15.929 | 13871 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
