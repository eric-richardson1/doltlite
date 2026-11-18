# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-18 20:15 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/44368577292)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.92s | 11.58s | 1.2× | 1.2% | **PASS** |
| Writes | 1.90s | 3.17s | 1.7× | 0.9% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.72s | 11.80s | 1.1× | 1.3% | **PASS** |
| Writes | 3.19s | 3.83s | 1.2× | 1.8% | **PASS** |
| Autocommit writes | 670.23ms | 2.15s | 3.2× | 4.7% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.80s | 2.07s | 1.1× | 1.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.63s | 3.29s | 1.3× | 1.5% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.73s | 3.14s | 1.1× | 1.4% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.75s | 3.08s | 1.1× | 0.9% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 265.89ms | 449.30ms | 1.7× | 0.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 565.02ms | 968.77ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 577.02ms | 949.19ms | 1.6× | 0.9% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 487.36ms | 801.57ms | 1.6× | 0.8% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.88s | 2.07s | 1.1× | 1.6% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.86s | 3.35s | 1.2× | 1.4% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 3.18s | 3.31s | 1.0× | 2.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.80s | 3.07s | 1.1× | 0.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 337.22ms | 488.48ms | 1.4× | 1.6% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 909.91ms | 1.08s | 1.2× | 2.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 820.59ms | 1.07s | 1.3× | 1.6% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.12s | 1.19s | 1.1× | 2.2% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.84s | 2.08s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.71s | 3.35s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.95s | 3.27s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.75s | 3.07s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 73.66ms | 286.46ms | 3.9× | 4.7% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 197.25ms | 620.32ms | 3.1× | 5.6% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 157.34ms | 554.45ms | 3.5× | 5.4% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 241.99ms | 685.90ms | 2.8× | 3.4% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 15.68ms | 19.00ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 7.95ms | 9.07ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_sum_range` | 7.37ms | 8.49ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_order_range` | 1.98ms | 2.22ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 2.65ms | 2.96ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 2.77ms | 3.84ms | 1.4× | 1.7% | PASS |
| mem_reads | `select_random_points` | 8.41ms | 9.76ms | 1.2× | 1.6% | PASS |
| mem_reads | `select_random_ranges` | 3.04ms | 3.36ms | 1.1× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 4.64ms | 6.49ms | 1.4× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 21.71ms | 24.94ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 4.11ms | 6.03ms | 1.5× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 2.17ms | 4.14ms | 1.9× | 4.2% | PASS |
| mem_reads | `types_table_scan` | 772.84ms | 892.76ms | 1.2× | 0.2% | PASS |
| mem_reads | `table_scan` | 880.17ms | 998.10ms | 1.1× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 67.81ms | 81.98ms | 1.2× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 101.06ms | 168.40ms | 1.7× | 0.4% | PASS |
| mem_writes | `oltp_insert` | 9.28ms | 15.84ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 33.63ms | 62.45ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 21.26ms | 37.82ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 29.20ms | 46.24ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 14.04ms | 29.16ms | 2.1× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 15.41ms | 21.75ms | 1.4× | 0.7% | PASS |
| mem_writes | `oltp_read_write` | 42.00ms | 67.64ms | 1.6× | 1.4% | PASS |
| file_reads | `oltp_point_select` | 35.91ms | 22.51ms | 0.6× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 9.00ms | 9.26ms | 1.0× | 3.4% | PASS |
| file_reads | `oltp_sum_range` | 8.72ms | 8.69ms | 1.0× | 2.7% | PASS |
| file_reads | `oltp_order_range` | 2.08ms | 2.18ms | 1.0× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 2.66ms | 2.89ms | 1.1× | 1.9% | PASS |
| file_reads | `oltp_index_scan` | 4.78ms | 3.85ms | 0.8× | 2.1% | PASS |
| file_reads | `select_random_points` | 10.25ms | 9.86ms | 1.0× | 2.6% | PASS |
| file_reads | `select_random_ranges` | 5.13ms | 3.68ms | 0.7× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 6.87ms | 7.01ms | 1.0× | 0.5% | PASS |
| file_reads | `groupby_scan` | 22.22ms | 24.97ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 5.18ms | 6.23ms | 1.2× | 1.3% | PASS |
| file_reads | `index_join_scan` | 2.32ms | 4.06ms | 1.8× | 1.7% | PASS |
| file_reads | `types_table_scan` | 781.27ms | 884.27ms | 1.1× | 0.3% | PASS |
| file_reads | `table_scan` | 884.89ms | 994.12ms | 1.1× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 95.61ms | 88.07ms | 0.9× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 108.64ms | 175.23ms | 1.6× | 0.7% | PASS |
| file_writes | `oltp_insert` | 12.36ms | 17.54ms | 1.4× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 45.97ms | 68.25ms | 1.5× | 2.1% | PASS |
| file_writes | `oltp_update_non_index` | 31.44ms | 42.11ms | 1.3× | 2.1% | PASS |
| file_writes | `oltp_delete_insert` | 39.45ms | 54.34ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 24.29ms | 33.15ms | 1.4× | 1.0% | PASS |
| file_writes | `types_delete_insert` | 22.74ms | 25.84ms | 1.1× | 2.2% | PASS |
| file_writes | `oltp_read_write` | 52.32ms | 72.01ms | 1.4× | 1.3% | PASS |
| ac_reads | `oltp_point_select` | 21.77ms | 23.01ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 8.29ms | 9.53ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_sum_range` | 7.81ms | 8.94ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 2.07ms | 2.27ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 2.74ms | 2.99ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 3.60ms | 4.26ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_points` | 9.46ms | 10.32ms | 1.1× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 3.81ms | 3.83ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 5.45ms | 7.12ms | 1.3× | 0.5% | PASS |
| ac_reads | `groupby_scan` | 21.98ms | 24.90ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 4.80ms | 6.86ms | 1.4× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 2.62ms | 4.61ms | 1.8× | 1.3% | PASS |
| ac_reads | `types_table_scan` | 781.19ms | 887.11ms | 1.1× | 0.4% | PASS |
| ac_reads | `table_scan` | 887.70ms | 995.63ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 77.32ms | 88.81ms | 1.1× | 0.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 8.23ms | 28.91ms | 3.5× | 4.8% | PASS |
| ac_writes | `oltp_insert_ac` | 9.22ms | 35.93ms | 3.9× | 5.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 10.01ms | 42.32ms | 4.2× | 4.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 8.38ms | 31.20ms | 3.7× | 5.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 9.14ms | 37.80ms | 4.1× | 3.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 9.21ms | 36.87ms | 4.0× | 3.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 8.10ms | 32.78ms | 4.0× | 5.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 11.36ms | 40.65ms | 3.6× | 4.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.66ms | 39.92ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 16.03ms | 17.00ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 14.72ms | 16.47ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 3.27ms | 3.60ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.27ms | 4.77ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.89ms | 6.66ms | 1.7× | 1.3% | PASS |
| mem_reads | `select_random_points` | 21.16ms | 22.48ms | 1.1× | 2.0% | PASS |
| mem_reads | `select_random_ranges` | 6.56ms | 6.99ms | 1.1× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 8.00ms | 11.22ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 34.41ms | 37.83ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 10.29ms | 10.70ms | 1.0× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 3.68ms | 6.53ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.24s | 1.53s | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_read_only` | 135.58ms | 154.61ms | 1.1× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 227.70ms | 353.92ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 17.09ms | 36.36ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 63.62ms | 138.63ms | 2.2× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 46.00ms | 81.83ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 52.26ms | 103.53ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 26.91ms | 54.78ms | 2.0× | 0.9% | PASS |
| mem_writes | `types_delete_insert` | 36.76ms | 59.31ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 94.70ms | 140.40ms | 1.5× | 1.5% | PASS |
| file_reads | `oltp_point_select` | 104.74ms | 57.54ms | 0.5× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 23.92ms | 19.04ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_sum_range` | 22.52ms | 18.56ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 4.25ms | 3.86ms | 0.9× | 1.8% | PASS |
| file_reads | `oltp_distinct_range` | 5.24ms | 5.07ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.20ms | 8.63ms | 0.8× | 1.3% | PASS |
| file_reads | `select_random_points` | 29.80ms | 25.21ms | 0.8× | 2.7% | PASS |
| file_reads | `select_random_ranges` | 14.11ms | 8.95ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.60ms | 13.23ms | 0.8× | 1.3% | PASS |
| file_reads | `groupby_scan` | 35.77ms | 38.15ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.81ms | 12.07ms | 0.8× | 2.9% | PASS |
| file_reads | `index_join_scan` | 4.75ms | 6.90ms | 1.5× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.09s | 1.42s | 1.3× | 0.9% | PASS |
| file_reads | `table_scan` | 1.24s | 1.53s | 1.2× | 0.7% | PASS |
| file_reads | `oltp_read_only` | 243.68ms | 182.37ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 252.43ms | 370.76ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_insert` | 25.20ms | 42.08ms | 1.7× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 118.17ms | 159.25ms | 1.3× | 11.2% | PASS |
| file_writes | `oltp_update_non_index` | 101.80ms | 96.73ms | 1.0× | 11.1% | PASS |
| file_writes | `oltp_delete_insert` | 95.84ms | 120.27ms | 1.3× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 88.01ms | 68.11ms | 0.8× | 12.9% | PASS |
| file_writes | `types_delete_insert` | 71.46ms | 69.18ms | 1.0× | 1.5% | PASS |
| file_writes | `oltp_read_write` | 156.99ms | 154.67ms | 1.0× | 4.3% | PASS |
| ac_reads | `oltp_point_select` | 57.14ms | 57.83ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 19.98ms | 19.04ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_sum_range` | 18.22ms | 18.70ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_order_range` | 3.82ms | 3.89ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.78ms | 5.05ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.53ms | 8.64ms | 1.3× | 1.1% | PASS |
| ac_reads | `select_random_points` | 24.70ms | 25.52ms | 1.0× | 2.3% | PASS |
| ac_reads | `select_random_ranges` | 9.25ms | 8.95ms | 1.0× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 10.74ms | 13.27ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 35.41ms | 38.36ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 12.61ms | 12.07ms | 1.0× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 4.26ms | 6.97ms | 1.6× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 1.1% | PASS |
| ac_reads | `table_scan` | 1.24s | 1.53s | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_read_only` | 172.22ms | 182.91ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.74ms | 61.54ms | 2.8× | 5.4% | PASS |
| ac_writes | `oltp_insert_ac` | 25.74ms | 73.88ms | 2.9× | 6.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.89ms | 91.62ms | 3.4× | 6.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.57ms | 71.53ms | 3.3× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.37ms | 83.94ms | 3.4× | 3.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.82ms | 80.06ms | 3.2× | 5.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.06ms | 70.92ms | 3.2× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.05ms | 86.82ms | 2.9× | 3.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.91ms | 37.41ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 17.18ms | 15.94ms | 0.9× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 15.53ms | 15.01ms | 1.0× | 2.0% | PASS |
| mem_reads | `oltp_order_range` | 3.59ms | 3.57ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.56ms | 4.61ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.97ms | 6.50ms | 1.6× | 1.4% | PASS |
| mem_reads | `select_random_points` | 21.79ms | 21.98ms | 1.0× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 6.59ms | 6.40ms | 1.0× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.60ms | 10.42ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 36.36ms | 37.87ms | 1.0× | 0.6% | PASS |
| mem_reads | `index_join` | 10.55ms | 10.79ms | 1.0× | 1.4% | PASS |
| mem_reads | `index_join_scan` | 3.83ms | 6.83ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.14s | 1.36s | 1.2× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.27s | 1.46s | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 154.51ms | 149.20ms | 1.0× | 3.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.34ms | 342.20ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.08ms | 37.01ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 64.37ms | 137.73ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 47.62ms | 79.91ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 53.10ms | 104.20ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 28.19ms | 56.77ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 37.58ms | 58.17ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 94.74ms | 133.21ms | 1.4× | 2.5% | PASS |
| file_reads | `oltp_point_select` | 126.57ms | 59.91ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 28.00ms | 18.71ms | 0.7× | 4.1% | PASS |
| file_reads | `oltp_sum_range` | 24.60ms | 17.41ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 4.56ms | 3.86ms | 0.8× | 2.5% | PASS |
| file_reads | `oltp_distinct_range` | 5.73ms | 4.91ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 12.99ms | 8.85ms | 0.7× | 2.1% | PASS |
| file_reads | `select_random_points` | 31.00ms | 24.57ms | 0.8× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 15.86ms | 8.73ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 16.69ms | 12.76ms | 0.8× | 2.2% | PASS |
| file_reads | `groupby_scan` | 38.03ms | 38.44ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join` | 16.63ms | 12.71ms | 0.8× | 1.9% | PASS |
| file_reads | `index_join_scan` | 5.05ms | 7.55ms | 1.5× | 2.5% | PASS |
| file_reads | `types_table_scan` | 1.15s | 1.37s | 1.2× | 1.8% | PASS |
| file_reads | `table_scan` | 1.41s | 1.53s | 1.1× | 3.2% | PASS |
| file_reads | `oltp_read_only` | 288.71ms | 183.04ms | 0.6× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 258.71ms | 360.98ms | 1.4× | 1.1% | PASS |
| file_writes | `oltp_insert` | 26.03ms | 43.77ms | 1.7× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 103.13ms | 162.65ms | 1.6× | 1.6% | PASS |
| file_writes | `oltp_update_non_index` | 90.54ms | 94.17ms | 1.0× | 9.0% | PASS |
| file_writes | `oltp_delete_insert` | 89.94ms | 121.32ms | 1.3× | 1.6% | PASS |
| file_writes | `oltp_write_only` | 60.49ms | 70.72ms | 1.2× | 2.1% | PASS |
| file_writes | `types_delete_insert` | 65.54ms | 68.39ms | 1.0× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 126.22ms | 145.16ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_point_select` | 62.14ms | 58.84ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 20.55ms | 18.12ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_sum_range` | 18.75ms | 17.23ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 3.83ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.98ms | 4.86ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 7.25ms | 8.84ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 25.60ms | 24.68ms | 1.0× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 9.75ms | 8.67ms | 0.9× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 10.93ms | 12.81ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 37.33ms | 38.37ms | 1.0× | 0.7% | PASS |
| ac_reads | `index_join` | 13.29ms | 12.32ms | 0.9× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 4.52ms | 7.27ms | 1.6× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.21s | 1.39s | 1.2× | 3.3% | PASS |
| ac_reads | `table_scan` | 1.33s | 1.48s | 1.1× | 2.7% | PASS |
| ac_reads | `oltp_read_only` | 186.02ms | 174.65ms | 0.9× | 1.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 16.56ms | 52.13ms | 3.1× | 6.1% | PASS |
| ac_writes | `oltp_insert_ac` | 19.89ms | 70.77ms | 3.6× | 4.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.88ms | 81.58ms | 3.9× | 5.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.72ms | 61.77ms | 3.7× | 6.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.79ms | 71.78ms | 3.6× | 4.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 18.87ms | 70.85ms | 3.8× | 5.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.03ms | 65.81ms | 3.6× | 8.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.60ms | 79.75ms | 3.0× | 5.1% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.54ms | 33.59ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_range_select` | 16.63ms | 21.41ms | 1.3× | 1.3% | PASS |
| mem_reads | `oltp_sum_range` | 15.98ms | 19.94ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_order_range` | 3.29ms | 3.96ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.21ms | 5.00ms | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 4.05ms | 5.71ms | 1.4× | 0.7% | PASS |
| mem_reads | `select_random_points` | 24.48ms | 29.52ms | 1.2× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 6.45ms | 7.76ms | 1.2× | 0.9% | PASS |
| mem_reads | `covering_index_scan` | 6.21ms | 9.38ms | 1.5× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 35.14ms | 40.63ms | 1.2× | 0.3% | PASS |
| mem_reads | `index_join` | 7.19ms | 10.89ms | 1.5× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.47ms | 6.05ms | 1.7× | 1.0% | PASS |
| mem_reads | `types_table_scan` | 1.11s | 1.30s | 1.2× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.36s | 1.42s | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_read_only` | 132.30ms | 160.80ms | 1.2× | 0.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 194.15ms | 276.62ms | 1.4× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 15.93ms | 28.20ms | 1.8× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 57.86ms | 112.39ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 41.91ms | 73.27ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_delete_insert` | 42.13ms | 82.14ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 22.80ms | 50.14ms | 2.2× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 26.75ms | 45.93ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_read_write` | 85.83ms | 132.86ms | 1.5× | 1.1% | PASS |
| file_reads | `oltp_point_select` | 58.63ms | 40.18ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 20.37ms | 22.22ms | 1.1× | 0.8% | PASS |
| file_reads | `oltp_sum_range` | 19.55ms | 20.86ms | 1.1× | 0.9% | PASS |
| file_reads | `oltp_order_range` | 3.72ms | 4.09ms | 1.1× | 0.7% | PASS |
| file_reads | `oltp_distinct_range` | 4.59ms | 5.11ms | 1.1× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 7.44ms | 6.55ms | 0.9× | 0.9% | PASS |
| file_reads | `select_random_points` | 28.14ms | 30.24ms | 1.1× | 0.8% | PASS |
| file_reads | `select_random_ranges` | 9.76ms | 8.59ms | 0.9× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 9.60ms | 10.19ms | 1.1× | 0.7% | PASS |
| file_reads | `groupby_scan` | 35.28ms | 40.89ms | 1.2× | 0.4% | PASS |
| file_reads | `index_join` | 9.19ms | 11.34ms | 1.2× | 1.2% | PASS |
| file_reads | `index_join_scan` | 3.94ms | 6.23ms | 1.6× | 1.2% | PASS |
| file_reads | `types_table_scan` | 1.09s | 1.28s | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 1.32s | 1.41s | 1.1× | 1.1% | PASS |
| file_reads | `oltp_read_only` | 175.33ms | 169.92ms | 1.0× | 0.5% | PASS |
| file_writes | `oltp_bulk_insert` | 251.51ms | 339.16ms | 1.3× | 2.0% | PASS |
| file_writes | `oltp_insert` | 41.72ms | 45.89ms | 1.1× | 5.1% | PASS |
| file_writes | `oltp_update_index` | 172.62ms | 185.45ms | 1.1× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 142.66ms | 123.18ms | 0.9× | 2.4% | PASS |
| file_writes | `oltp_delete_insert` | 140.84ms | 143.34ms | 1.0× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 108.57ms | 97.12ms | 0.9× | 3.6% | PASS |
| file_writes | `types_delete_insert` | 91.87ms | 80.71ms | 0.9× | 3.7% | PASS |
| file_writes | `oltp_read_write` | 174.46ms | 178.94ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 38.47ms | 40.13ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 17.97ms | 22.21ms | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_sum_range` | 17.58ms | 20.84ms | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.50ms | 4.11ms | 1.2× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.38ms | 5.13ms | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 5.51ms | 6.54ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 26.29ms | 30.40ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_ranges` | 7.77ms | 8.60ms | 1.1× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 7.48ms | 10.26ms | 1.4× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 35.38ms | 41.02ms | 1.2× | 0.3% | PASS |
| ac_reads | `index_join` | 8.27ms | 11.49ms | 1.4× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 3.79ms | 6.25ms | 1.6× | 1.3% | PASS |
| ac_reads | `types_table_scan` | 1.12s | 1.29s | 1.1× | 1.3% | PASS |
| ac_reads | `table_scan` | 1.31s | 1.41s | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_read_only` | 144.65ms | 169.39ms | 1.2× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 28.48ms | 72.23ms | 2.5× | 2.4% | PASS |
| ac_writes | `oltp_insert_ac` | 30.42ms | 85.99ms | 2.8× | 2.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.71ms | 95.31ms | 3.0× | 3.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 28.60ms | 79.22ms | 2.8× | 1.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 29.93ms | 87.76ms | 2.9× | 3.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 30.19ms | 88.42ms | 2.9× | 4.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 27.88ms | 81.58ms | 2.9× | 4.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 34.77ms | 95.39ms | 2.7× | 3.8% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 16s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 30.49ms | 38.00ms | 80.2% | 1.3% | PASS |
| `status_dirty_many_tables` | 33.77ms | 42.00ms | 80.4% | 0.8% | PASS |
| `diff_regular_working_one_table` | 26.16ms | 33.00ms | 79.3% | 1.1% | PASS |
| `diff_regular_working_many_tables` | 39.91ms | 50.00ms | 79.8% | 2.1% | PASS |
| `diff_stat_working_many_tables` | 39.23ms | 48.00ms | 81.7% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 39.36ms | 48.00ms | 82.0% | 0.8% | PASS |
| `branch_list_many_branches` | 18.45ms | 25.00ms | 73.8% | 1.1% | PASS |
| `branch_create_delete` | 19.79ms | 27.00ms | 73.3% | 1.2% | PASS |
| `at_literal_deep_history` | 20.19ms | 28.00ms | 72.1% | 1.5% | PASS |
| `diff_literal_deep_history` | 20.12ms | 28.00ms | 71.9% | 1.0% | PASS |
| `history_literal_deep_history` | 21.53ms | 30.00ms | 71.8% | 1.1% | PASS |
| `checkout_branch_clean` | 28.90ms | 43.00ms | 67.2% | 1.0% | PASS |
| `merge_data_no_conflicts` | 23.87ms | 33.00ms | 72.3% | 1.5% | PASS |
| `merge_data_secondary_index` | 871.50ms | 944.00ms | 92.3% | 1.5% | PASS |
| `merge_schema_no_conflicts` | 18.70ms | 24.00ms | 77.9% | 1.9% | PASS |
| `merge_data_conflicts` | 27.25ms | 33.00ms | 82.6% | 1.5% | PASS |
| `merge_data_conflicts_with_resolve` | 28.43ms | 34.00ms | 83.6% | 2.0% | PASS |

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
| copy_fsync | candidate | 57.855 | 55.307–62.452 | 38.925 | 1728.46 | 107968266 |
| push_initial | candidate | 589.831 | 577.800–601.653 | 571.590 | 169.54 | 107956772 |
| clone_initial | candidate | 757.447 | 752.890–775.333 | 732.460 | 132.02 | 108475035 |
| push_noop | candidate | 0.685 | 0.626–1.373 | 0.403 | — | 0 |
| fetch_noop | candidate | 0.201 | 0.198–0.237 | 0.206 | — | 0 |
| push_incremental | candidate | 229.671 | 228.976–230.527 | 226.897 | 4.35 | 7909775 |
| fetch_incremental | candidate | 95.460 | 94.931–95.617 | 92.778 | 10.48 | 7910084 |
| pull_fast_forward | candidate | 83.597 | 82.761–84.892 | 81.001 | 11.96 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.52 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.78 | 295.271 | 109.784 | 47285 | 2337 |
| push_noop | candidate | 45.94 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.94 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.94 | 96.913 | 7.910 | 22424 | 125 |
| fetch_incremental | candidate | 45.94 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.94 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 4113.941 | 3198.960–4139.397 | 497.674 | 243.08 | 1087718031 |
| push_initial | candidate | 6043.747 | 6029.400–6096.990 | 3363.872 | 165.46 | 1079566275 |
| clone_initial | candidate | 4990.737 | 4972.952–5144.127 | 4949.186 | 200.37 | 1102407326 |
| push_noop | candidate | 0.455 | 0.399–0.497 | 0.218 | — | 0 |
| fetch_noop | candidate | 0.093 | 0.093–0.101 | 0.094 | — | 0 |
| push_incremental | candidate | 762.950 | 762.576–766.183 | 761.574 | 1.31 | 15806003 |
| fetch_incremental | candidate | 193.217 | 192.049–194.417 | 189.911 | 5.18 | 15806513 |
| pull_fast_forward | candidate | 198.066 | 196.004–198.163 | 194.653 | 5.05 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.79 | 2092.113 | 1087.622 | 263555 | 20541 |
| clone_initial | candidate | 123.95 | 3517.792 | 1132.819 | 612332 | 32243 |
| push_noop | candidate | 47.10 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.10 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.30 | 616.795 | 15.928 | 149826 | 313 |
| fetch_incremental | candidate | 50.39 | 62.818 | 15.928 | 14038 | 313 |
| pull_fast_forward | candidate | 50.45 | 62.751 | 15.929 | 14034 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
