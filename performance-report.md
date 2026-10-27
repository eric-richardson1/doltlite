# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-10-27 17:59 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu24 20261026.354.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/40531689263)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.32s | 10.86s | 1.2× | 1.6% | **PASS** |
| Writes | 1.80s | 2.88s | 1.6× | 1.3% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.99s | 10.88s | 1.1× | 1.5% | **PASS** |
| Writes | 4.21s | 4.29s | 1.0× | 3.9% | **PASS** |
| Autocommit writes | 971.43ms | 3.12s | 3.2× | 7.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.17s | 2.35s | 1.1× | 3.7% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.85s | 3.18s | 1.1× | 1.1% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 1.79s | 2.06s | 1.2× | 2.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.51s | 3.27s | 1.3× | 1.0% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 345.04ms | 534.82ms | 1.6× | 2.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 519.06ms | 829.64ms | 1.6× | 1.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 367.44ms | 571.32ms | 1.6× | 2.4% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 570.67ms | 939.81ms | 1.6× | 0.8% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.37s | 2.37s | 1.0× | 1.3% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.93s | 3.18s | 1.1× | 1.0% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 1.91s | 1.99s | 1.0× | 2.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.78s | 3.34s | 1.2× | 1.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 1.01s | 916.71ms | 0.9× | 21.0% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.43s | 1.35s | 0.9× | 2.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.01s | 986.51ms | 1.0× | 5.9% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 756.81ms | 1.03s | 1.4× | 1.5% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.14s | 2.36s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.84s | 3.18s | 1.1× | 1.3% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 1.80s | 2.02s | 1.1× | 1.7% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.61s | 3.34s | 1.3× | 1.3% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 274.10ms | 1.14s | 4.2× | 60.6% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 255.75ms | 732.59ms | 2.9× | 4.3% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 230.95ms | 548.01ms | 2.4× | 5.9% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 210.62ms | 695.44ms | 3.3× | 7.9% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.10ms | 23.75ms | 1.2× | 4.0% | PASS |
| mem_reads | `oltp_range_select` | 9.45ms | 10.29ms | 1.1× | 5.7% | PASS |
| mem_reads | `oltp_sum_range` | 8.12ms | 9.55ms | 1.2× | 3.7% | PASS |
| mem_reads | `oltp_order_range` | 2.24ms | 2.51ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.07ms | 3.37ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.19ms | 4.58ms | 1.4× | 4.2% | PASS |
| mem_reads | `select_random_points` | 9.13ms | 9.90ms | 1.1× | 3.7% | PASS |
| mem_reads | `select_random_ranges` | 3.82ms | 4.02ms | 1.1× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.19ms | 1.4× | 2.8% | PASS |
| mem_reads | `groupby_scan` | 25.81ms | 28.18ms | 1.1× | 1.2% | PASS |
| mem_reads | `index_join` | 4.56ms | 7.27ms | 1.6× | 4.3% | PASS |
| mem_reads | `index_join_scan` | 2.64ms | 4.79ms | 1.8× | 4.1% | PASS |
| mem_reads | `types_table_scan` | 919.68ms | 1.02s | 1.1× | 2.1% | PASS |
| mem_reads | `table_scan` | 1.06s | 1.12s | 1.1× | 2.4% | PASS |
| mem_reads | `oltp_read_only` | 87.01ms | 97.09ms | 1.1× | 4.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 136.38ms | 212.12ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 12.13ms | 20.66ms | 1.7× | 2.0% | PASS |
| mem_writes | `oltp_update_index` | 42.01ms | 71.95ms | 1.7× | 6.5% | PASS |
| mem_writes | `oltp_update_non_index` | 28.52ms | 41.58ms | 1.5× | 2.5% | PASS |
| mem_writes | `oltp_delete_insert` | 36.20ms | 53.34ms | 1.5× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 17.89ms | 31.88ms | 1.8× | 2.2% | PASS |
| mem_writes | `types_delete_insert` | 19.69ms | 26.68ms | 1.4× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 52.23ms | 76.60ms | 1.5× | 2.3% | PASS |
| file_reads | `oltp_point_select` | 94.23ms | 41.23ms | 0.4× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 16.92ms | 11.73ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 15.63ms | 11.32ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.05ms | 2.67ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 3.90ms | 3.56ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 11.01ms | 6.33ms | 0.6× | 1.2% | PASS |
| file_reads | `select_random_points` | 16.46ms | 11.57ms | 0.7× | 2.4% | PASS |
| file_reads | `select_random_ranges` | 11.34ms | 5.86ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.91ms | 10.00ms | 0.7× | 0.7% | PASS |
| file_reads | `groupby_scan` | 26.59ms | 28.22ms | 1.1× | 0.5% | PASS |
| file_reads | `index_join` | 8.91ms | 8.14ms | 0.9× | 0.9% | PASS |
| file_reads | `index_join_scan` | 3.56ms | 5.00ms | 1.4× | 1.6% | PASS |
| file_reads | `types_table_scan` | 930.05ms | 1.01s | 1.1× | 3.3% | PASS |
| file_reads | `table_scan` | 1.03s | 1.09s | 1.1× | 2.3% | PASS |
| file_reads | `oltp_read_only` | 192.06ms | 121.58ms | 0.6× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 185.85ms | 270.26ms | 1.5× | 6.7% | PASS |
| file_writes | `oltp_insert` | 30.69ms | 32.89ms | 1.1× | 22.9% | PASS |
| file_writes | `oltp_update_index` | 156.01ms | 135.63ms | 0.9× | 24.2% | PASS |
| file_writes | `oltp_update_non_index` | 140.70ms | 92.91ms | 0.7× | 21.9% | PASS |
| file_writes | `oltp_delete_insert` | 148.60ms | 112.11ms | 0.8× | 19.4% | PASS |
| file_writes | `oltp_write_only` | 99.63ms | 74.11ms | 0.7× | 15.6% | PASS |
| file_writes | `types_delete_insert` | 79.90ms | 63.36ms | 0.8× | 20.1% | PASS |
| file_writes | `oltp_read_write` | 170.88ms | 135.45ms | 0.8× | 23.7% | PASS |
| ac_reads | `oltp_point_select` | 43.95ms | 41.78ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 11.74ms | 11.68ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 10.96ms | 11.42ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 2.61ms | 2.69ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.40ms | 3.54ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 6.03ms | 6.37ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_points` | 12.05ms | 12.02ms | 1.0× | 2.9% | PASS |
| ac_reads | `select_random_ranges` | 6.39ms | 5.86ms | 0.9× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 8.92ms | 10.05ms | 1.1× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 26.19ms | 28.48ms | 1.1× | 0.6% | PASS |
| ac_reads | `index_join` | 6.36ms | 8.36ms | 1.3× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.12ms | 5.23ms | 1.7× | 2.8% | PASS |
| ac_reads | `types_table_scan` | 885.75ms | 1.00s | 1.1× | 2.0% | PASS |
| ac_reads | `table_scan` | 1.00s | 1.09s | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_read_only` | 116.97ms | 120.45ms | 1.0× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.54ms | 67.80ms | 3.1× | 50.8% | PASS |
| ac_writes | `oltp_insert_ac` | 34.72ms | 136.92ms | 3.9× | 60.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 38.64ms | 181.91ms | 4.7× | 60.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 28.69ms | 126.70ms | 4.4× | 60.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 48.75ms | 156.01ms | 3.2× | 77.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 38.16ms | 256.43ms | 6.7× (paired 5.0×) | 65.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 31.92ms | 112.17ms | 3.5× | 67.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.68ms | 105.91ms | 3.3× | 52.0% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.46ms | 35.66ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 15.44ms | 16.04ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_sum_range` | 15.40ms | 14.84ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_order_range` | 3.10ms | 3.45ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.03ms | 4.49ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.77ms | 6.05ms | 1.6× | 0.8% | PASS |
| mem_reads | `select_random_points` | 22.93ms | 22.64ms | 1.0× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 5.96ms | 6.00ms | 1.0× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 6.59ms | 9.69ms | 1.5× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 33.73ms | 35.93ms | 1.1× | 0.4% | PASS |
| mem_reads | `index_join` | 11.13ms | 10.45ms | 0.9× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 3.33ms | 6.76ms | 2.0× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.17s | 1.38s | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.38s | 1.49s | 1.1× | 0.3% | PASS |
| mem_reads | `oltp_read_only` | 135.44ms | 145.25ms | 1.1× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 193.56ms | 283.96ms | 1.5× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 15.48ms | 32.60ms | 2.1× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 62.94ms | 129.46ms | 2.1× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 45.76ms | 71.48ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 49.60ms | 89.67ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 25.44ms | 49.19ms | 1.9× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 35.77ms | 48.11ms | 1.3× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 90.50ms | 125.18ms | 1.4× | 2.8% | PASS |
| file_reads | `oltp_point_select` | 68.74ms | 43.55ms | 0.6× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 18.89ms | 16.97ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_sum_range` | 18.66ms | 15.77ms | 0.8× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 3.50ms | 3.61ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 4.45ms | 4.64ms | 1.0× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 7.31ms | 6.92ms | 0.9× | 1.0% | PASS |
| file_reads | `select_random_points` | 26.64ms | 23.23ms | 0.9× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 9.69ms | 6.92ms | 0.7× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 10.26ms | 10.72ms | 1.0× | 0.5% | PASS |
| file_reads | `groupby_scan` | 34.16ms | 36.08ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 13.42ms | 11.12ms | 0.8× | 1.7% | PASS |
| file_reads | `index_join_scan` | 3.84ms | 7.04ms | 1.8× | 1.8% | PASS |
| file_reads | `types_table_scan` | 1.15s | 1.37s | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 1.38s | 1.48s | 1.1× | 0.7% | PASS |
| file_reads | `oltp_read_only` | 181.26ms | 155.63ms | 0.9× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 281.95ms | 364.45ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_insert` | 41.81ms | 59.22ms | 1.4× | 2.4% | PASS |
| file_writes | `oltp_update_index` | 204.87ms | 220.53ms | 1.1× | 2.4% | PASS |
| file_writes | `oltp_update_non_index` | 186.60ms | 141.16ms | 0.8× | 3.0% | PASS |
| file_writes | `oltp_delete_insert` | 201.42ms | 168.26ms | 0.8× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 146.82ms | 111.81ms | 0.8× | 2.3% | PASS |
| file_writes | `types_delete_insert` | 159.41ms | 98.00ms | 0.6× | 4.5% | PASS |
| file_writes | `oltp_read_write` | 209.01ms | 186.10ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_point_select` | 43.35ms | 42.70ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 16.13ms | 16.86ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 16.14ms | 15.75ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 3.27ms | 3.61ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_distinct_range` | 4.23ms | 4.66ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.11ms | 6.99ms | 1.4× | 1.2% | PASS |
| ac_reads | `select_random_points` | 24.68ms | 23.49ms | 1.0× | 1.5% | PASS |
| ac_reads | `select_random_ranges` | 7.56ms | 6.93ms | 0.9× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 7.88ms | 10.75ms | 1.4× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 33.93ms | 36.19ms | 1.1× | 0.4% | PASS |
| ac_reads | `index_join` | 12.36ms | 11.23ms | 0.9× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.67ms | 7.06ms | 1.9× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.16s | 1.37s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.35s | 1.47s | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 144.20ms | 154.28ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 30.03ms | 77.44ms | 2.6× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 31.81ms | 86.34ms | 2.7× | 3.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 32.43ms | 103.11ms | 3.2× | 4.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 29.57ms | 87.55ms | 3.0× | 4.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 32.12ms | 96.43ms | 3.0× | 3.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 31.35ms | 92.65ms | 3.0× | 4.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 30.61ms | 86.62ms | 2.8× | 3.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 37.83ms | 102.44ms | 2.7× | 6.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.60ms | 23.52ms | 1.1× | 2.7% | PASS |
| mem_reads | `oltp_range_select` | 9.06ms | 9.53ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_sum_range` | 9.53ms | 9.47ms | 1.0× | 4.5% | PASS |
| mem_reads | `oltp_order_range` | 2.12ms | 2.19ms | 1.0× | 3.5% | PASS |
| mem_reads | `oltp_distinct_range` | 2.71ms | 2.70ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_index_scan` | 2.69ms | 4.78ms | 1.8× | 2.1% | PASS |
| mem_reads | `select_random_points` | 18.86ms | 16.64ms | 0.9× | 4.5% | PASS |
| mem_reads | `select_random_ranges` | 4.84ms | 4.44ms | 0.9× | 2.0% | PASS |
| mem_reads | `covering_index_scan` | 4.28ms | 6.96ms | 1.6× | 2.2% | PASS |
| mem_reads | `groupby_scan` | 20.85ms | 21.44ms | 1.0× | 1.3% | PASS |
| mem_reads | `index_join` | 8.67ms | 8.56ms | 1.0× | 3.5% | PASS |
| mem_reads | `index_join_scan` | 3.02ms | 6.08ms | 2.0× | 3.8% | PASS |
| mem_reads | `types_table_scan` | 777.47ms | 914.89ms | 1.2× | 1.8% | PASS |
| mem_reads | `table_scan` | 828.01ms | 950.45ms | 1.1× | 3.6% | PASS |
| mem_reads | `oltp_read_only` | 77.92ms | 79.31ms | 1.0× | 2.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 141.87ms | 197.45ms | 1.4× | 1.3% | PASS |
| mem_writes | `oltp_insert` | 10.98ms | 23.10ms | 2.1× | 2.0% | PASS |
| mem_writes | `oltp_update_index` | 45.27ms | 86.96ms | 1.9× | 2.2% | PASS |
| mem_writes | `oltp_update_non_index` | 37.08ms | 53.97ms | 1.5× | 2.7% | PASS |
| mem_writes | `oltp_delete_insert` | 37.78ms | 66.25ms | 1.8× | 2.6% | PASS |
| mem_writes | `oltp_write_only` | 18.33ms | 35.42ms | 1.9× | 2.8% | PASS |
| mem_writes | `types_delete_insert` | 24.55ms | 33.56ms | 1.4× | 3.7% | PASS |
| mem_writes | `oltp_read_write` | 51.59ms | 74.59ms | 1.4× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 78.40ms | 38.22ms | 0.5× | 1.7% | PASS |
| file_reads | `oltp_range_select` | 16.40ms | 11.06ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 15.91ms | 10.78ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 2.90ms | 2.38ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 3.42ms | 2.88ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 8.78ms | 6.05ms | 0.7× | 1.5% | PASS |
| file_reads | `select_random_points` | 22.26ms | 16.13ms | 0.7× | 5.2% | PASS |
| file_reads | `select_random_ranges` | 10.57ms | 5.76ms | 0.5× | 2.0% | PASS |
| file_reads | `covering_index_scan` | 10.50ms | 8.01ms | 0.8× | 2.0% | PASS |
| file_reads | `groupby_scan` | 21.29ms | 21.31ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join` | 11.33ms | 8.13ms | 0.7× | 3.0% | PASS |
| file_reads | `index_join_scan` | 3.39ms | 4.98ms | 1.5× | 1.7% | PASS |
| file_reads | `types_table_scan` | 698.25ms | 817.31ms | 1.2× | 1.4% | PASS |
| file_reads | `table_scan` | 835.93ms | 929.24ms | 1.1× | 1.9% | PASS |
| file_reads | `oltp_read_only` | 171.16ms | 104.78ms | 0.6× | 2.6% | PASS |
| file_writes | `oltp_bulk_insert` | 209.43ms | 269.86ms | 1.3× | 6.7% | PASS |
| file_writes | `oltp_insert` | 19.12ms | 42.89ms | 2.2× | 8.4% | PASS |
| file_writes | `oltp_update_index` | 143.33ms | 159.81ms | 1.1× | 3.3% | PASS |
| file_writes | `oltp_update_non_index` | 120.81ms | 107.01ms | 0.9× | 4.8% | PASS |
| file_writes | `oltp_delete_insert` | 150.81ms | 127.58ms | 0.8× | 5.2% | PASS |
| file_writes | `oltp_write_only` | 110.33ms | 79.76ms | 0.7× | 4.8% | PASS |
| file_writes | `types_delete_insert` | 107.89ms | 70.00ms | 0.6× | 7.2% | PASS |
| file_writes | `oltp_read_write` | 150.72ms | 129.61ms | 0.9× | 7.8% | PASS |
| ac_reads | `oltp_point_select` | 44.16ms | 40.46ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 13.27ms | 11.45ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 12.83ms | 11.26ms | 0.9× | 3.1% | PASS |
| ac_reads | `oltp_order_range` | 2.60ms | 2.41ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.11ms | 2.90ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 5.12ms | 6.12ms | 1.2× | 1.7% | PASS |
| ac_reads | `select_random_points` | 17.77ms | 15.93ms | 0.9× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 6.79ms | 5.83ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 6.60ms | 7.92ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 20.95ms | 21.36ms | 1.0× | 1.7% | PASS |
| ac_reads | `index_join` | 9.95ms | 8.26ms | 0.8× | 3.5% | PASS |
| ac_reads | `index_join_scan` | 3.13ms | 5.06ms | 1.6× | 1.4% | PASS |
| ac_reads | `types_table_scan` | 709.68ms | 833.50ms | 1.2× | 1.6% | PASS |
| ac_reads | `table_scan` | 835.03ms | 940.35ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 104.76ms | 102.38ms | 1.0× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 28.42ms | 57.46ms | 2.0× | 6.5% | PASS |
| ac_writes | `oltp_insert_ac` | 30.49ms | 70.23ms | 2.3× | 9.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.34ms | 78.74ms | 2.5× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 26.00ms | 63.82ms | 2.5× | 6.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 31.11ms | 71.77ms | 2.3× | 9.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.85ms | 71.50ms | 2.4× | 4.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.24ms | 64.87ms | 2.9× | 5.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.51ms | 69.61ms | 2.2× | 3.4% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 30.91ms | 42.54ms | 1.4× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 17.49ms | 24.98ms | 1.4× | 0.7% | PASS |
| mem_reads | `oltp_sum_range` | 16.43ms | 22.59ms | 1.4× | 0.8% | PASS |
| mem_reads | `oltp_order_range` | 3.33ms | 4.26ms | 1.3× | 2.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.40ms | 5.36ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 4.09ms | 6.29ms | 1.5× | 1.0% | PASS |
| mem_reads | `select_random_points` | 25.93ms | 33.25ms | 1.3× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 6.98ms | 9.47ms | 1.4× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 7.63ms | 11.04ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 34.81ms | 41.92ms | 1.2× | 0.8% | PASS |
| mem_reads | `index_join` | 7.63ms | 11.41ms | 1.5× | 1.0% | PASS |
| mem_reads | `index_join_scan` | 3.45ms | 6.54ms | 1.9× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.4% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.46s | 1.3× | 0.3% | PASS |
| mem_reads | `oltp_read_only` | 143.31ms | 184.72ms | 1.3× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 243.20ms | 351.67ms | 1.4× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 18.52ms | 33.73ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 62.98ms | 118.48ms | 1.9× | 0.7% | PASS |
| mem_writes | `oltp_update_non_index` | 47.70ms | 82.80ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 46.73ms | 89.73ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 25.30ms | 52.51ms | 2.1× | 0.8% | PASS |
| mem_writes | `types_delete_insert` | 30.83ms | 53.84ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_read_write` | 95.41ms | 157.06ms | 1.6× | 0.6% | PASS |
| file_reads | `oltp_point_select` | 108.12ms | 62.92ms | 0.6× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 26.79ms | 27.73ms | 1.0× | 3.2% | PASS |
| file_reads | `oltp_sum_range` | 25.28ms | 25.39ms | 1.0× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 4.77ms | 4.83ms | 1.0× | 4.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.81ms | 6.01ms | 1.0× | 2.3% | PASS |
| file_reads | `oltp_index_scan` | 12.49ms | 8.73ms | 0.7× | 2.9% | PASS |
| file_reads | `select_random_points` | 37.36ms | 37.22ms | 1.0× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 15.52ms | 11.86ms | 0.8× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 15.91ms | 13.66ms | 0.9× | 1.5% | PASS |
| file_reads | `groupby_scan` | 36.57ms | 43.32ms | 1.2× | 1.0% | PASS |
| file_reads | `index_join` | 12.35ms | 13.43ms | 1.1× | 1.8% | PASS |
| file_reads | `index_join_scan` | 4.77ms | 7.02ms | 1.5× | 1.9% | PASS |
| file_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.3% | PASS |
| file_reads | `table_scan` | 1.17s | 1.46s | 1.3× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 259.67ms | 218.44ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 259.61ms | 365.13ms | 1.4× | 1.0% | PASS |
| file_writes | `oltp_insert` | 26.42ms | 38.25ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 94.46ms | 134.57ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 75.44ms | 94.93ms | 1.3× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 76.43ms | 104.57ms | 1.4× | 1.9% | PASS |
| file_writes | `oltp_write_only` | 51.39ms | 63.75ms | 1.2× | 2.1% | PASS |
| file_writes | `types_delete_insert` | 48.30ms | 62.54ms | 1.3× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 124.75ms | 169.16ms | 1.4× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 56.87ms | 63.21ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 21.13ms | 27.86ms | 1.3× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 19.93ms | 25.37ms | 1.3× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 4.15ms | 4.73ms | 1.1× | 3.0% | PASS |
| ac_reads | `oltp_distinct_range` | 5.28ms | 5.96ms | 1.1× | 2.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.97ms | 8.73ms | 1.3× | 1.4% | PASS |
| ac_reads | `select_random_points` | 30.36ms | 37.20ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_ranges` | 10.00ms | 11.87ms | 1.2× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.31ms | 13.65ms | 1.3× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 35.79ms | 43.14ms | 1.2× | 1.0% | PASS |
| ac_reads | `index_join` | 9.54ms | 13.55ms | 1.4× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 4.22ms | 7.03ms | 1.7× | 1.4% | PASS |
| ac_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.17s | 1.46s | 1.2× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 182.61ms | 218.92ms | 1.2× | 0.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.19ms | 69.14ms | 2.9× | 7.2% | PASS |
| ac_writes | `oltp_insert_ac` | 26.95ms | 90.36ms | 3.4× | 10.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.79ms | 101.16ms | 3.6× | 8.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 24.11ms | 80.31ms | 3.3× | 6.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.52ms | 86.35ms | 3.4× | 9.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.76ms | 90.73ms | 3.5× | 8.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.07ms | 78.85ms | 3.4× | 7.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.23ms | 98.53ms | 3.0× | 5.5% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 35s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 36.65ms | 38.00ms | 96.4% | 2.3% | PASS |
| `status_dirty_many_tables` | 39.84ms | 42.00ms | 94.9% | 1.6% | PASS |
| `diff_regular_working_one_table` | 31.97ms | 33.00ms | 96.9% | 1.4% | PASS |
| `diff_regular_working_many_tables` | 45.01ms | 50.00ms | 90.0% | 1.3% | PASS |
| `diff_stat_working_many_tables` | 44.80ms | 48.00ms | 93.3% | 1.1% | PASS |
| `diff_schema_working_many_tables` | 45.61ms | 48.00ms | 95.0% | 1.3% | PASS |
| `branch_list_many_branches` | 24.04ms | 25.00ms | 96.2% | 1.4% | PASS |
| `branch_create_delete` | 25.86ms | 27.00ms | 95.8% | 1.8% | PASS |
| `at_literal_deep_history` | 25.91ms | 28.00ms | 92.5% | 1.6% | PASS |
| `diff_literal_deep_history` | 25.81ms | 28.00ms | 92.2% | 1.4% | PASS |
| `history_literal_deep_history` | 27.19ms | 30.00ms | 90.6% | 1.3% | PASS |
| `checkout_branch_clean` | 35.00ms | 43.00ms | 81.4% | 1.3% | PASS |
| `merge_data_no_conflicts` | 28.41ms | 33.00ms | 86.1% | 0.8% | PASS |
| `merge_data_secondary_index` | 918.09ms | 944.00ms | 97.3% | 0.9% | PASS |
| `merge_schema_no_conflicts` | 22.22ms | 24.00ms | 92.6% | 2.5% | PASS |
| `merge_data_conflicts` | 32.23ms | 33.00ms | 97.7% | 1.4% | PASS |
| `merge_data_conflicts_with_resolve` | 31.73ms | 34.00ms | 93.3% | 1.3% | PASS |

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
| copy_fsync | candidate | 60.664 | 57.886–62.424 | 39.889 | 1648.42 | 107968266 |
| push_initial | candidate | 597.620 | 593.008–604.742 | 583.518 | 167.33 | 107956772 |
| clone_initial | candidate | 775.539 | 768.771–779.173 | 748.674 | 128.94 | 108475035 |
| push_noop | candidate | 0.654 | 0.637–0.838 | 0.410 | — | 0 |
| fetch_noop | candidate | 0.217 | 0.203–0.254 | 0.222 | — | 0 |
| push_incremental | candidate | 239.513 | 237.970–239.878 | 236.666 | 4.18 | 7909775 |
| fetch_incremental | candidate | 97.885 | 97.702–98.672 | 95.605 | 10.22 | 7910084 |
| pull_fast_forward | candidate | 85.219 | 84.735–87.090 | 82.705 | 11.73 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.56 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.69 | 295.174 | 109.784 | 47260 | 2337 |
| push_noop | candidate | 42.00 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 42.00 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 42.00 | 96.579 | 7.910 | 22340 | 125 |
| fetch_incremental | candidate | 42.00 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 42.00 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2663.309 | 2628.892–2685.442 | 374.403 | 375.47 | 1087718031 |
| push_initial | candidate | 7558.532 | 7528.340–7574.254 | 5332.401 | 132.30 | 1079566275 |
| clone_initial | candidate | 8216.859 | 8199.846–8274.061 | 7973.060 | 121.70 | 1102407326 |
| push_noop | candidate | 0.849 | 0.767–0.934 | 0.442 | — | 0 |
| fetch_noop | candidate | 0.200 | 0.193–0.210 | 0.206 | — | 0 |
| push_incremental | candidate | 1286.146 | 1283.885–1287.319 | 1280.891 | 0.78 | 15806003 |
| fetch_incremental | candidate | 247.675 | 247.195–254.306 | 242.086 | 4.04 | 15806513 |
| pull_fast_forward | candidate | 254.780 | 253.541–260.444 | 248.248 | 3.92 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 135.04 | 2091.494 | 1087.622 | 263404 | 20541 |
| clone_initial | candidate | 125.18 | 3518.846 | 1132.819 | 612611 | 32243 |
| push_noop | candidate | 44.70 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 44.70 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.98 | 617.227 | 15.928 | 149936 | 313 |
| fetch_incremental | candidate | 51.07 | 62.000 | 15.928 | 13838 | 313 |
| pull_fast_forward | candidate | 51.03 | 61.933 | 15.929 | 13834 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
