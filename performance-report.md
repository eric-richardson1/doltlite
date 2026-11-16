# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-16 21:38 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.196.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43942843510)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.15s | 12.22s | 1.2× | 1.9% | **PASS** |
| Writes | 2.08s | 3.49s | 1.7× | 1.5% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.74s | 12.40s | 1.2× | 1.5% | **PASS** |
| Writes | 3.39s | 4.10s | 1.2× | 2.5% | **PASS** |
| Autocommit writes | 801.25ms | 2.62s | 3.3× | 6.7% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.16s | 2.26s | 1.0× | 1.6% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.68s | 3.32s | 1.2× | 2.0% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.69s | 3.31s | 1.2× | 2.3% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.61s | 3.34s | 1.3× | 1.5% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 339.17ms | 562.86ms | 1.7× | 1.6% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 572.69ms | 974.48ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 580.16ms | 974.33ms | 1.7× | 2.3% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 588.04ms | 980.23ms | 1.7× | 1.4% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.24s | 2.28s | 1.0× | 1.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.78s | 3.34s | 1.2× | 1.5% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.87s | 3.38s | 1.2× | 2.1% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.85s | 3.40s | 1.2× | 1.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 866.55ms | 867.58ms | 1.0× | 14.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 937.85ms | 1.10s | 1.2× | 2.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 818.32ms | 1.09s | 1.3× | 2.5% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 762.98ms | 1.05s | 1.4× | 1.6% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.11s | 2.29s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.78s | 3.38s | 1.2× | 1.5% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.73s | 3.38s | 1.2× | 2.2% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.70s | 3.40s | 1.3× | 1.8% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 197.22ms | 715.92ms | 3.6× | 41.7% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 202.98ms | 636.24ms | 3.1× | 6.6% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 206.49ms | 656.60ms | 3.2× | 7.0% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 194.55ms | 615.74ms | 3.2× | 5.5% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 19.01ms | 22.70ms | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_range_select` | 9.11ms | 9.66ms | 1.1× | 3.2% | PASS |
| mem_reads | `oltp_sum_range` | 7.70ms | 9.02ms | 1.2× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 2.20ms | 2.43ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 2.99ms | 3.24ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.11ms | 4.28ms | 1.4× | 1.8% | PASS |
| mem_reads | `select_random_points` | 8.72ms | 9.59ms | 1.1× | 2.0% | PASS |
| mem_reads | `select_random_ranges` | 3.71ms | 3.85ms | 1.0× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 5.85ms | 7.84ms | 1.3× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 25.27ms | 27.80ms | 1.1× | 1.0% | PASS |
| mem_reads | `index_join` | 4.52ms | 7.20ms | 1.6× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 2.66ms | 4.74ms | 1.8× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 876.37ms | 972.73ms | 1.1× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.11s | 1.08s | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 81.08ms | 93.73ms | 1.2× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 133.86ms | 218.13ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 11.66ms | 19.29ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 40.04ms | 74.93ms | 1.9× | 1.7% | PASS |
| mem_writes | `oltp_update_non_index` | 27.70ms | 47.04ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 34.74ms | 57.43ms | 1.7× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 17.42ms | 36.19ms | 2.1× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 19.72ms | 26.90ms | 1.4× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 54.03ms | 82.94ms | 1.5× | 3.1% | PASS |
| file_reads | `oltp_point_select` | 88.71ms | 39.52ms | 0.4× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 16.70ms | 11.51ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_sum_range` | 14.96ms | 10.80ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 2.99ms | 2.64ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 3.76ms | 3.46ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 10.20ms | 6.08ms | 0.6× | 1.0% | PASS |
| file_reads | `select_random_points` | 15.87ms | 11.25ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 10.69ms | 5.60ms | 0.5× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 13.15ms | 9.65ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 26.04ms | 27.86ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 8.47ms | 7.92ms | 0.9× | 1.0% | PASS |
| file_reads | `index_join_scan` | 3.53ms | 4.96ms | 1.4× | 1.3% | PASS |
| file_reads | `types_table_scan` | 875.50ms | 968.14ms | 1.1× | 1.1% | PASS |
| file_reads | `table_scan` | 968.88ms | 1.06s | 1.1× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 177.22ms | 116.20ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 183.48ms | 268.88ms | 1.5× | 7.0% | PASS |
| file_writes | `oltp_insert` | 19.79ms | 27.34ms | 1.4× | 12.1% | PASS |
| file_writes | `oltp_update_index` | 141.51ms | 127.79ms | 0.9× | 8.0% | PASS |
| file_writes | `oltp_update_non_index` | 108.09ms | 89.43ms | 0.8× | 3.9% | PASS |
| file_writes | `oltp_delete_insert` | 121.22ms | 108.11ms | 0.9× | 26.9% | PASS |
| file_writes | `oltp_write_only` | 90.83ms | 71.44ms | 0.8× | 24.8% | PASS |
| file_writes | `types_delete_insert` | 70.47ms | 57.82ms | 0.8× | 22.2% | PASS |
| file_writes | `oltp_read_write` | 131.15ms | 116.75ms | 0.9× | 16.5% | PASS |
| ac_reads | `oltp_point_select` | 39.80ms | 38.87ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 11.54ms | 11.42ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 10.28ms | 10.79ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 2.58ms | 2.64ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.31ms | 3.44ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 5.64ms | 6.09ms | 1.1× | 0.8% | PASS |
| ac_reads | `select_random_points` | 11.23ms | 11.29ms | 1.0× | 1.1% | PASS |
| ac_reads | `select_random_ranges` | 6.04ms | 5.60ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.69ms | 1.1× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 25.65ms | 27.96ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 6.13ms | 7.96ms | 1.3× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 3.09ms | 4.89ms | 1.6× | 1.2% | PASS |
| ac_reads | `types_table_scan` | 869.02ms | 966.70ms | 1.1× | 1.0% | PASS |
| ac_reads | `table_scan` | 995.61ms | 1.07s | 1.1× | 3.7% | PASS |
| ac_reads | `oltp_read_only` | 111.32ms | 117.53ms | 1.1× | 1.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 27.38ms | 91.25ms | 3.3× | 51.6% | PASS |
| ac_writes | `oltp_insert_ac` | 24.59ms | 107.33ms | 4.4× | 39.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.02ms | 94.30ms | 3.6× | 36.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 25.15ms | 80.55ms | 3.2× | 31.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.60ms | 84.51ms | 3.4× | 43.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.04ms | 92.34ms | 4.0× | 45.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.94ms | 78.58ms | 3.9× | 44.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.51ms | 87.07ms | 3.3× | 24.7% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 36.27ms | 41.14ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_range_select` | 16.47ms | 17.00ms | 1.0× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 14.68ms | 16.17ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 3.29ms | 3.61ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.13ms | 4.79ms | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 3.84ms | 6.68ms | 1.7× | 1.4% | PASS |
| mem_reads | `select_random_points` | 21.07ms | 22.66ms | 1.1× | 2.7% | PASS |
| mem_reads | `select_random_ranges` | 6.67ms | 6.96ms | 1.0× | 2.0% | PASS |
| mem_reads | `covering_index_scan` | 7.97ms | 11.21ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 34.55ms | 37.81ms | 1.1× | 1.1% | PASS |
| mem_reads | `index_join` | 10.57ms | 10.69ms | 1.0× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.77ms | 6.63ms | 1.8× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 1.11s | 1.44s | 1.3× | 1.6% | PASS |
| mem_reads | `table_scan` | 1.26s | 1.54s | 1.2× | 3.0% | PASS |
| mem_reads | `oltp_read_only` | 144.24ms | 156.25ms | 1.1× | 1.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.26ms | 360.21ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 17.39ms | 36.51ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 64.46ms | 138.63ms | 2.2× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 46.11ms | 81.97ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 52.85ms | 103.27ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 27.23ms | 55.14ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 37.97ms | 59.60ms | 1.6× | 2.2% | PASS |
| mem_writes | `oltp_read_write` | 93.42ms | 139.15ms | 1.5× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 103.89ms | 58.62ms | 0.6× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 23.63ms | 19.03ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 22.67ms | 18.35ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 4.14ms | 3.92ms | 0.9× | 1.7% | PASS |
| file_reads | `oltp_distinct_range` | 5.19ms | 5.13ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.21ms | 8.72ms | 0.8× | 1.2% | PASS |
| file_reads | `select_random_points` | 30.40ms | 25.58ms | 0.8× | 2.5% | PASS |
| file_reads | `select_random_ranges` | 14.12ms | 9.06ms | 0.6× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 15.61ms | 13.28ms | 0.9× | 1.5% | PASS |
| file_reads | `groupby_scan` | 35.32ms | 38.06ms | 1.1× | 1.1% | PASS |
| file_reads | `index_join` | 14.29ms | 11.87ms | 0.8× | 2.2% | PASS |
| file_reads | `index_join_scan` | 4.67ms | 7.04ms | 1.5× | 1.9% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.42s | 1.3× | 0.6% | PASS |
| file_reads | `table_scan` | 1.19s | 1.52s | 1.3× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 237.09ms | 182.17ms | 0.8× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 258.67ms | 377.41ms | 1.5× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.68ms | 43.14ms | 1.7× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 145.14ms | 166.39ms | 1.1× | 4.2% | PASS |
| file_writes | `oltp_update_non_index` | 100.59ms | 98.98ms | 1.0× | 9.6% | PASS |
| file_writes | `oltp_delete_insert` | 93.90ms | 119.40ms | 1.3× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 89.25ms | 67.76ms | 0.8× | 11.5% | PASS |
| file_writes | `types_delete_insert` | 72.47ms | 69.49ms | 1.0× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 152.14ms | 153.10ms | 1.0× | 5.2% | PASS |
| ac_reads | `oltp_point_select` | 57.62ms | 58.43ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 18.95ms | 18.96ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 17.75ms | 18.32ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 3.70ms | 3.92ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.69ms | 5.10ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.66ms | 8.78ms | 1.3× | 0.8% | PASS |
| ac_reads | `select_random_points` | 25.36ms | 25.67ms | 1.0× | 2.5% | PASS |
| ac_reads | `select_random_ranges` | 9.40ms | 9.06ms | 1.0× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 10.91ms | 13.25ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 35.31ms | 38.26ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 12.65ms | 12.05ms | 1.0× | 2.6% | PASS |
| ac_reads | `index_join_scan` | 4.28ms | 7.02ms | 1.6× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.14s | 1.45s | 1.3× | 1.5% | PASS |
| ac_reads | `table_scan` | 1.26s | 1.53s | 1.2× | 3.2% | PASS |
| ac_reads | `oltp_read_only` | 171.96ms | 183.47ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.85ms | 64.09ms | 2.8× | 6.6% | PASS |
| ac_writes | `oltp_insert_ac` | 24.92ms | 75.29ms | 3.0× | 6.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.12ms | 90.85ms | 3.5× | 5.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.45ms | 72.09ms | 3.4× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.67ms | 85.16ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.22ms | 82.56ms | 3.3× | 6.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 24.37ms | 75.43ms | 3.1× | 8.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.39ms | 90.77ms | 2.8× | 6.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.80ms | 40.48ms | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_range_select` | 16.32ms | 16.57ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_sum_range` | 14.62ms | 16.31ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 3.32ms | 3.58ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 4.26ms | 4.76ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 4.03ms | 6.77ms | 1.7× | 2.3% | PASS |
| mem_reads | `select_random_points` | 21.72ms | 22.65ms | 1.0× | 3.5% | PASS |
| mem_reads | `select_random_ranges` | 6.58ms | 6.92ms | 1.1× | 2.1% | PASS |
| mem_reads | `covering_index_scan` | 8.01ms | 11.23ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 34.45ms | 37.91ms | 1.1× | 1.0% | PASS |
| mem_reads | `index_join` | 10.06ms | 10.95ms | 1.1× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 3.72ms | 6.64ms | 1.8× | 2.5% | PASS |
| mem_reads | `types_table_scan` | 1.12s | 1.43s | 1.3× | 3.0% | PASS |
| mem_reads | `table_scan` | 1.27s | 1.54s | 1.2× | 3.1% | PASS |
| mem_reads | `oltp_read_only` | 140.35ms | 153.39ms | 1.1× | 3.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 237.29ms | 363.51ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.09ms | 37.20ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_update_index` | 64.67ms | 137.52ms | 2.1× | 3.2% | PASS |
| mem_writes | `oltp_update_non_index` | 47.53ms | 80.52ms | 1.7× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 52.29ms | 102.75ms | 2.0× | 2.7% | PASS |
| mem_writes | `oltp_write_only` | 27.92ms | 55.79ms | 2.0× | 2.2% | PASS |
| mem_writes | `types_delete_insert` | 37.64ms | 59.09ms | 1.6× | 2.4% | PASS |
| mem_writes | `oltp_read_write` | 94.73ms | 137.94ms | 1.5× | 2.3% | PASS |
| file_reads | `oltp_point_select` | 104.40ms | 58.73ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 24.61ms | 18.76ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 22.91ms | 18.51ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.29ms | 3.88ms | 0.9× | 2.4% | PASS |
| file_reads | `oltp_distinct_range` | 5.22ms | 5.08ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_index_scan` | 11.17ms | 8.72ms | 0.8× | 1.3% | PASS |
| file_reads | `select_random_points` | 29.50ms | 25.36ms | 0.9× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 14.13ms | 9.03ms | 0.6× | 2.1% | PASS |
| file_reads | `covering_index_scan` | 15.78ms | 13.36ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 35.85ms | 38.37ms | 1.1× | 1.3% | PASS |
| file_reads | `index_join` | 14.66ms | 12.40ms | 0.8× | 3.4% | PASS |
| file_reads | `index_join_scan` | 4.76ms | 6.86ms | 1.4× | 2.8% | PASS |
| file_reads | `types_table_scan` | 1.11s | 1.43s | 1.3× | 2.2% | PASS |
| file_reads | `table_scan` | 1.23s | 1.54s | 1.2× | 3.0% | PASS |
| file_reads | `oltp_read_only` | 246.41ms | 182.12ms | 0.7× | 1.8% | PASS |
| file_writes | `oltp_bulk_insert` | 256.72ms | 379.23ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.59ms | 42.70ms | 1.7× | 2.7% | PASS |
| file_writes | `oltp_update_index` | 100.12ms | 157.12ms | 1.6× | 2.3% | PASS |
| file_writes | `oltp_update_non_index` | 92.96ms | 94.47ms | 1.0× | 10.5% | PASS |
| file_writes | `oltp_delete_insert` | 87.68ms | 118.56ms | 1.4× | 2.1% | PASS |
| file_writes | `oltp_write_only` | 59.40ms | 69.02ms | 1.2× | 2.7% | PASS |
| file_writes | `types_delete_insert` | 64.12ms | 70.05ms | 1.1× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 131.72ms | 154.26ms | 1.2× | 3.0% | PASS |
| ac_reads | `oltp_point_select` | 59.04ms | 59.58ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_range_select` | 19.47ms | 18.69ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 17.73ms | 18.60ms | 1.0× | 2.7% | PASS |
| ac_reads | `oltp_order_range` | 3.78ms | 3.84ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_distinct_range` | 4.71ms | 5.06ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.66ms | 8.75ms | 1.3× | 1.4% | PASS |
| ac_reads | `select_random_points` | 24.89ms | 25.60ms | 1.0× | 3.1% | PASS |
| ac_reads | `select_random_ranges` | 9.23ms | 8.99ms | 1.0× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.85ms | 13.28ms | 1.2× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 34.90ms | 38.20ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 12.38ms | 12.40ms | 1.0× | 2.8% | PASS |
| ac_reads | `index_join_scan` | 4.23ms | 6.98ms | 1.6× | 2.5% | PASS |
| ac_reads | `types_table_scan` | 1.10s | 1.43s | 1.3× | 2.0% | PASS |
| ac_reads | `table_scan` | 1.24s | 1.54s | 1.2× | 3.0% | PASS |
| ac_reads | `oltp_read_only` | 179.70ms | 184.89ms | 1.0× | 2.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.50ms | 66.47ms | 2.8× | 7.0% | PASS |
| ac_writes | `oltp_insert_ac` | 25.66ms | 83.83ms | 3.3× | 6.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.13ms | 94.34ms | 3.5× | 5.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.44ms | 73.63ms | 3.1× | 7.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.88ms | 85.49ms | 3.3× | 7.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.47ms | 83.82ms | 3.3× | 6.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.36ms | 75.57ms | 3.2× | 7.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.06ms | 93.45ms | 2.9× | 7.3% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 32.92ms | 42.38ms | 1.3× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 19.64ms | 24.60ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_sum_range` | 17.36ms | 23.13ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 3.58ms | 4.40ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.58ms | 5.62ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 4.48ms | 6.52ms | 1.5× | 2.9% | PASS |
| mem_reads | `select_random_points` | 25.91ms | 31.72ms | 1.2× | 1.4% | PASS |
| mem_reads | `select_random_ranges` | 7.56ms | 9.38ms | 1.2× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 7.98ms | 11.12ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 36.57ms | 44.48ms | 1.2× | 1.0% | PASS |
| mem_reads | `index_join` | 7.88ms | 11.60ms | 1.5× | 2.2% | PASS |
| mem_reads | `index_join_scan` | 3.93ms | 6.72ms | 1.7× | 2.5% | PASS |
| mem_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.52s | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 148.56ms | 187.27ms | 1.3× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 241.30ms | 352.45ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.45ms | 34.26ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 65.16ms | 127.04ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 50.16ms | 88.59ms | 1.8× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 48.68ms | 96.87ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 26.71ms | 58.86ms | 2.2× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 32.64ms | 56.80ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 104.94ms | 165.37ms | 1.6× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 103.28ms | 61.18ms | 0.6× | 1.6% | PASS |
| file_reads | `oltp_range_select` | 27.46ms | 27.15ms | 1.0× | 2.9% | PASS |
| file_reads | `oltp_sum_range` | 25.59ms | 25.79ms | 1.0× | 1.9% | PASS |
| file_reads | `oltp_order_range` | 4.71ms | 4.79ms | 1.0× | 2.6% | PASS |
| file_reads | `oltp_distinct_range` | 6.15ms | 6.35ms | 1.0× | 2.4% | PASS |
| file_reads | `oltp_index_scan` | 11.73ms | 8.82ms | 0.8× | 2.0% | PASS |
| file_reads | `select_random_points` | 35.50ms | 35.54ms | 1.0× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 15.06ms | 11.84ms | 0.8× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.95ms | 13.67ms | 0.9× | 1.4% | PASS |
| file_reads | `groupby_scan` | 38.10ms | 45.17ms | 1.2× | 1.3% | PASS |
| file_reads | `index_join` | 12.13ms | 13.50ms | 1.1× | 2.2% | PASS |
| file_reads | `index_join_scan` | 5.09ms | 7.20ms | 1.4× | 2.6% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.9% | PASS |
| file_reads | `table_scan` | 1.21s | 1.51s | 1.2× | 1.2% | PASS |
| file_reads | `oltp_read_only` | 255.69ms | 217.36ms | 0.9× | 1.4% | PASS |
| file_writes | `oltp_bulk_insert` | 255.46ms | 365.80ms | 1.4× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.69ms | 38.43ms | 1.5× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 97.01ms | 143.64ms | 1.5× | 1.5% | PASS |
| file_writes | `oltp_update_non_index` | 78.09ms | 96.50ms | 1.2× | 1.3% | PASS |
| file_writes | `oltp_delete_insert` | 76.59ms | 109.58ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 52.28ms | 66.77ms | 1.3× | 2.1% | PASS |
| file_writes | `types_delete_insert` | 49.59ms | 62.78ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_read_write` | 128.27ms | 170.23ms | 1.3× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 55.45ms | 60.32ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 22.86ms | 27.16ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 20.52ms | 25.65ms | 1.3× | 1.8% | PASS |
| ac_reads | `oltp_order_range` | 4.27ms | 4.78ms | 1.1× | 2.7% | PASS |
| ac_reads | `oltp_distinct_range` | 5.49ms | 6.10ms | 1.1× | 3.6% | PASS |
| ac_reads | `oltp_index_scan` | 7.16ms | 8.70ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 29.60ms | 35.38ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 10.32ms | 11.86ms | 1.1× | 1.8% | PASS |
| ac_reads | `covering_index_scan` | 11.03ms | 13.42ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 37.63ms | 45.20ms | 1.2× | 1.3% | PASS |
| ac_reads | `index_join` | 9.74ms | 13.57ms | 1.4× | 1.9% | PASS |
| ac_reads | `index_join_scan` | 4.53ms | 7.17ms | 1.6× | 2.2% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.22s | 1.52s | 1.2× | 2.1% | PASS |
| ac_reads | `oltp_read_only` | 185.15ms | 217.38ms | 1.2× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.36ms | 63.44ms | 3.0× | 5.3% | PASS |
| ac_writes | `oltp_insert_ac` | 24.00ms | 78.19ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.47ms | 88.96ms | 3.4× | 6.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.11ms | 70.65ms | 3.2× | 4.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.53ms | 78.12ms | 3.3× | 7.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.49ms | 78.66ms | 3.2× | 5.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.87ms | 70.46ms | 3.4× | 5.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.72ms | 87.26ms | 2.8× | 3.9% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 30s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 29.02ms | 38.00ms | 76.4% | 1.7% | PASS |
| `status_dirty_many_tables` | 32.36ms | 42.00ms | 77.0% | 1.3% | PASS |
| `diff_regular_working_one_table` | 24.55ms | 33.00ms | 74.4% | 1.3% | PASS |
| `diff_regular_working_many_tables` | 35.88ms | 50.00ms | 71.8% | 1.2% | PASS |
| `diff_stat_working_many_tables` | 36.01ms | 48.00ms | 75.0% | 1.0% | PASS |
| `diff_schema_working_many_tables` | 36.20ms | 48.00ms | 75.4% | 0.9% | PASS |
| `branch_list_many_branches` | 16.89ms | 25.00ms | 67.6% | 1.8% | PASS |
| `branch_create_delete` | 18.57ms | 27.00ms | 68.8% | 1.4% | PASS |
| `at_literal_deep_history` | 18.32ms | 28.00ms | 65.4% | 1.2% | PASS |
| `diff_literal_deep_history` | 18.34ms | 28.00ms | 65.5% | 1.7% | PASS |
| `history_literal_deep_history` | 19.42ms | 30.00ms | 64.7% | 1.2% | PASS |
| `checkout_branch_clean` | 28.50ms | 43.00ms | 66.3% | 0.8% | PASS |
| `merge_data_no_conflicts` | 21.01ms | 33.00ms | 63.7% | 1.6% | PASS |
| `merge_data_secondary_index` | 835.12ms | 944.00ms | 88.5% | 0.6% | PASS |
| `merge_schema_no_conflicts` | 16.60ms | 24.00ms | 69.2% | 1.3% | PASS |
| `merge_data_conflicts` | 23.69ms | 33.00ms | 71.8% | 1.5% | PASS |
| `merge_data_conflicts_with_resolve` | 24.47ms | 34.00ms | 72.0% | 1.3% | PASS |

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
| copy_fsync | candidate | 462.369 | 456.807–556.003 | 37.056 | 216.28 | 107968266 |
| push_initial | candidate | 874.709 | 844.810–966.434 | 427.493 | 114.32 | 107956772 |
| clone_initial | candidate | 967.591 | 959.901–971.149 | 550.570 | 103.35 | 108475035 |
| push_noop | candidate | 0.932 | 0.902–1.290 | 0.411 | — | 0 |
| fetch_noop | candidate | 0.137 | 0.127–0.171 | 0.138 | — | 0 |
| push_incremental | candidate | 198.334 | 197.033–201.481 | 169.606 | 5.04 | 7909775 |
| fetch_incremental | candidate | 103.737 | 97.239–111.944 | 74.761 | 9.64 | 7910084 |
| pull_fast_forward | candidate | 96.289 | 93.369–99.004 | 67.393 | 10.39 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.72 | 295.101 | 109.784 | 47243 | 2337 |
| push_noop | candidate | 46.07 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 46.07 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.07 | 96.648 | 7.910 | 22359 | 125 |
| fetch_incremental | candidate | 46.07 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.07 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5887.850 | 5629.902–6016.754 | 314.463 | 169.84 | 1087718031 |
| push_initial | candidate | 7887.747 | 7684.820–7982.443 | 3904.232 | 126.78 | 1079566275 |
| clone_initial | candidate | 9327.884 | 9190.649–9362.847 | 5697.322 | 107.21 | 1102407326 |
| push_noop | candidate | 0.715 | 0.690–0.732 | 0.330 | — | 0 |
| fetch_noop | candidate | 0.140 | 0.140–0.164 | 0.142 | — | 0 |
| push_incremental | candidate | 892.858 | 886.742–911.410 | 845.007 | 1.12 | 15806003 |
| fetch_incremental | candidate | 247.701 | 242.096–252.493 | 176.511 | 4.04 | 15806513 |
| pull_fast_forward | candidate | 257.275 | 239.473–266.518 | 190.198 | 3.89 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.02 | 2091.425 | 1087.622 | 263388 | 20541 |
| clone_initial | candidate | 124.03 | 3523.840 | 1132.819 | 613770 | 32243 |
| push_noop | candidate | 47.16 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.16 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.29 | 618.948 | 15.928 | 150333 | 313 |
| fetch_incremental | candidate | 50.39 | 62.422 | 15.928 | 13941 | 313 |
| pull_fast_forward | candidate | 50.42 | 62.355 | 15.929 | 13937 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
