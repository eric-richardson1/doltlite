# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-13 19:13 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.196.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43471785488)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.53s | 11.25s | 1.2× | 1.4% | **PASS** |
| Writes | 1.89s | 3.11s | 1.6× | 1.3% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.96s | 11.31s | 1.1× | 1.2% | **PASS** |
| Writes | 2.96s | 3.60s | 1.2× | 1.8% | **PASS** |
| Autocommit writes | 651.02ms | 2.15s | 3.3× | 7.8% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.02s | 2.23s | 1.1× | 1.5% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 3.02s | 3.43s | 1.1× | 1.6% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.58s | 3.30s | 1.3× | 1.6% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.91s | 2.29s | 1.2× | 0.9% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 342.52ms | 562.61ms | 1.6× | 2.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 603.66ms | 1.00s | 1.7× | 1.3% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 586.54ms | 971.89ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 355.91ms | 570.04ms | 1.6× | 1.1% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.22s | 2.27s | 1.0× | 0.8% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.93s | 3.39s | 1.2× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.82s | 3.38s | 1.2× | 1.5% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.99s | 2.28s | 1.1× | 1.1% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 807.19ms | 840.50ms | 1.0× | 0.9% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 916.65ms | 1.09s | 1.2× | 2.9% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 808.25ms | 1.07s | 1.3× | 1.7% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 423.61ms | 599.96ms | 1.4× | 1.9% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.08s | 2.28s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.72s | 3.37s | 1.2× | 2.2% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.62s | 3.35s | 1.3× | 1.5% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.93s | 2.27s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 156.10ms | 539.08ms | 3.5× | 10.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 210.91ms | 666.82ms | 3.2× | 8.2% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 206.95ms | 651.63ms | 3.1× | 7.7% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 77.07ms | 289.04ms | 3.8× | 4.5% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 19.37ms | 22.85ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 9.02ms | 9.66ms | 1.1× | 3.4% | PASS |
| mem_reads | `oltp_sum_range` | 7.51ms | 9.04ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_order_range` | 2.16ms | 2.42ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 2.97ms | 3.23ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.06ms | 4.06ms | 1.3× | 1.5% | PASS |
| mem_reads | `select_random_points` | 8.94ms | 9.64ms | 1.1× | 3.9% | PASS |
| mem_reads | `select_random_ranges` | 3.74ms | 3.91ms | 1.0× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 5.86ms | 7.68ms | 1.3× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 25.21ms | 27.56ms | 1.1× | 1.2% | PASS |
| mem_reads | `index_join` | 4.59ms | 6.96ms | 1.5× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 2.81ms | 4.86ms | 1.7× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 859.93ms | 967.23ms | 1.1× | 0.6% | PASS |
| mem_reads | `table_scan` | 980.09ms | 1.06s | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 80.36ms | 93.34ms | 1.2× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.39ms | 218.65ms | 1.6× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 11.80ms | 19.64ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 40.49ms | 74.88ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 28.90ms | 47.55ms | 1.6× | 2.5% | PASS |
| mem_writes | `oltp_delete_insert` | 36.17ms | 58.42ms | 1.6× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 17.94ms | 36.25ms | 2.0× | 2.3% | PASS |
| mem_writes | `types_delete_insert` | 19.48ms | 26.14ms | 1.3× | 2.3% | PASS |
| mem_writes | `oltp_read_write` | 53.35ms | 81.09ms | 1.5× | 2.8% | PASS |
| file_reads | `oltp_point_select` | 87.50ms | 38.84ms | 0.4× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 16.43ms | 11.42ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 15.13ms | 10.85ms | 0.7× | 0.8% | PASS |
| file_reads | `oltp_order_range` | 3.04ms | 2.65ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 3.82ms | 3.47ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 10.34ms | 6.11ms | 0.6× | 0.8% | PASS |
| file_reads | `select_random_points` | 16.09ms | 11.43ms | 0.7× | 0.8% | PASS |
| file_reads | `select_random_ranges` | 10.85ms | 5.66ms | 0.5× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 13.23ms | 9.64ms | 0.7× | 0.8% | PASS |
| file_reads | `groupby_scan` | 26.18ms | 27.79ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 8.62ms | 7.97ms | 0.9× | 1.1% | PASS |
| file_reads | `index_join_scan` | 3.61ms | 5.05ms | 1.4× | 2.5% | PASS |
| file_reads | `types_table_scan` | 862.54ms | 959.33ms | 1.1× | 0.5% | PASS |
| file_reads | `table_scan` | 967.96ms | 1.05s | 1.1× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 177.76ms | 116.01ms | 0.7× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 171.24ms | 268.04ms | 1.6× | 3.6% | PASS |
| file_writes | `oltp_insert` | 19.75ms | 27.40ms | 1.4× | 2.1% | PASS |
| file_writes | `oltp_update_index` | 131.66ms | 127.75ms | 1.0× | 0.7% | PASS |
| file_writes | `oltp_update_non_index` | 101.15ms | 88.96ms | 0.9× | 1.1% | PASS |
| file_writes | `oltp_delete_insert` | 111.32ms | 99.22ms | 0.9× | 0.8% | PASS |
| file_writes | `oltp_write_only` | 81.06ms | 69.34ms | 0.9× | 0.5% | PASS |
| file_writes | `types_delete_insert` | 70.00ms | 50.33ms | 0.7× | 8.0% | PASS |
| file_writes | `oltp_read_write` | 121.02ms | 109.47ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_point_select` | 39.52ms | 39.18ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 11.47ms | 11.43ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_sum_range` | 10.39ms | 10.80ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 2.61ms | 2.65ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.36ms | 3.48ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 5.65ms | 6.10ms | 1.1× | 1.1% | PASS |
| ac_reads | `select_random_points` | 11.32ms | 11.49ms | 1.0× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 6.11ms | 5.67ms | 0.9× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 8.43ms | 9.60ms | 1.1× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 25.58ms | 27.78ms | 1.1× | 0.6% | PASS |
| ac_reads | `index_join` | 6.13ms | 7.98ms | 1.3× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.16ms | 5.05ms | 1.6× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 859.13ms | 960.41ms | 1.1× | 0.4% | PASS |
| ac_reads | `table_scan` | 978.48ms | 1.06s | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_read_only` | 111.97ms | 117.06ms | 1.0× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.37ms | 56.10ms | 3.1× | 13.1% | PASS |
| ac_writes | `oltp_insert_ac` | 19.66ms | 65.01ms | 3.3× | 9.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.64ms | 78.04ms | 3.8× | 9.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.54ms | 61.35ms | 3.5× | 7.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.44ms | 68.70ms | 3.5× | 9.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.59ms | 72.07ms | 3.7× | 14.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 16.94ms | 64.19ms | 3.8× | 13.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 23.92ms | 73.63ms | 3.1× | 10.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 37.69ms | 41.46ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 17.68ms | 17.41ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 16.00ms | 16.42ms | 1.0× | 2.6% | PASS |
| mem_reads | `oltp_order_range` | 3.43ms | 3.66ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 4.37ms | 4.79ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 4.10ms | 6.97ms | 1.7× | 1.8% | PASS |
| mem_reads | `select_random_points` | 24.95ms | 24.09ms | 1.0× | 2.5% | PASS |
| mem_reads | `select_random_ranges` | 7.01ms | 7.12ms | 1.0× | 2.1% | PASS |
| mem_reads | `covering_index_scan` | 8.15ms | 11.37ms | 1.4× | 1.4% | PASS |
| mem_reads | `groupby_scan` | 36.06ms | 38.66ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 11.62ms | 11.25ms | 1.0× | 2.4% | PASS |
| mem_reads | `index_join_scan` | 4.28ms | 7.37ms | 1.7× | 4.0% | PASS |
| mem_reads | `types_table_scan` | 1.26s | 1.49s | 1.2× | 1.5% | PASS |
| mem_reads | `table_scan` | 1.43s | 1.58s | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 152.38ms | 161.41ms | 1.1× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 234.58ms | 363.23ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.60ms | 37.40ms | 2.1× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 69.48ms | 145.72ms | 2.1× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 50.69ms | 84.42ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 57.22ms | 109.04ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 29.33ms | 56.76ms | 1.9× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 40.94ms | 62.10ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 103.81ms | 145.23ms | 1.4× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 106.87ms | 59.06ms | 0.6× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 25.01ms | 19.13ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 23.34ms | 18.36ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 4.39ms | 3.93ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 5.43ms | 5.11ms | 0.9× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.37ms | 8.84ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_points` | 33.60ms | 26.55ms | 0.8× | 3.0% | PASS |
| file_reads | `select_random_ranges` | 14.35ms | 9.07ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.87ms | 13.45ms | 0.8× | 1.6% | PASS |
| file_reads | `groupby_scan` | 37.14ms | 38.72ms | 1.0× | 1.0% | PASS |
| file_reads | `index_join` | 16.11ms | 12.40ms | 0.8× | 3.4% | PASS |
| file_reads | `index_join_scan` | 5.05ms | 7.36ms | 1.5× | 2.8% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.43s | 1.3× | 1.1% | PASS |
| file_reads | `table_scan` | 1.31s | 1.56s | 1.2× | 3.8% | PASS |
| file_reads | `oltp_read_only` | 244.50ms | 182.72ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 258.88ms | 377.10ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.69ms | 42.52ms | 1.7× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 129.32ms | 160.32ms | 1.2× | 8.9% | PASS |
| file_writes | `oltp_update_non_index` | 104.71ms | 97.38ms | 0.9× | 6.3% | PASS |
| file_writes | `oltp_delete_insert` | 96.67ms | 121.13ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 79.65ms | 68.89ms | 0.9× | 20.1% | PASS |
| file_writes | `types_delete_insert` | 73.24ms | 69.67ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 148.49ms | 155.28ms | 1.0× | 4.0% | PASS |
| ac_reads | `oltp_point_select` | 59.98ms | 58.84ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 20.72ms | 19.21ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 18.90ms | 19.16ms | 1.0× | 2.6% | PASS |
| ac_reads | `oltp_order_range` | 3.81ms | 3.91ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_distinct_range` | 4.88ms | 5.10ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_index_scan` | 6.52ms | 8.80ms | 1.4× | 3.0% | PASS |
| ac_reads | `select_random_points` | 25.87ms | 26.05ms | 1.0× | 3.4% | PASS |
| ac_reads | `select_random_ranges` | 9.13ms | 9.10ms | 1.0× | 2.2% | PASS |
| ac_reads | `covering_index_scan` | 11.18ms | 13.41ms | 1.2× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 36.39ms | 38.51ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 13.86ms | 12.69ms | 0.9× | 3.8% | PASS |
| ac_reads | `index_join_scan` | 4.48ms | 7.32ms | 1.6× | 2.5% | PASS |
| ac_reads | `types_table_scan` | 1.10s | 1.43s | 1.3× | 1.2% | PASS |
| ac_reads | `table_scan` | 1.23s | 1.53s | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 173.59ms | 182.70ms | 1.1× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.76ms | 68.48ms | 3.0× | 9.4% | PASS |
| ac_writes | `oltp_insert_ac` | 26.70ms | 79.60ms | 3.0× | 8.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.96ms | 96.18ms | 3.4× | 7.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.14ms | 76.02ms | 3.3× | 8.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.21ms | 90.71ms | 3.3× | 9.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.67ms | 85.66ms | 3.3× | 7.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.95ms | 75.73ms | 3.2× | 10.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.54ms | 94.44ms | 2.8× | 5.4% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.65ms | 39.74ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 15.93ms | 16.52ms | 1.0× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 14.69ms | 15.69ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.22ms | 3.67ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.25ms | 4.82ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.92ms | 6.66ms | 1.7× | 1.9% | PASS |
| mem_reads | `select_random_points` | 22.05ms | 22.30ms | 1.0× | 2.7% | PASS |
| mem_reads | `select_random_ranges` | 6.64ms | 6.94ms | 1.0× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 8.06ms | 11.15ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 34.31ms | 37.98ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 10.10ms | 10.80ms | 1.1× | 2.1% | PASS |
| mem_reads | `index_join_scan` | 3.75ms | 6.56ms | 1.8× | 2.1% | PASS |
| mem_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.19s | 1.54s | 1.3× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 136.47ms | 155.15ms | 1.1× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.97ms | 360.49ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 18.02ms | 36.97ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 66.07ms | 138.91ms | 2.1× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 48.65ms | 80.01ms | 1.6× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 51.91ms | 101.03ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 27.84ms | 55.12ms | 2.0× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 38.45ms | 58.76ms | 1.5× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 98.64ms | 140.61ms | 1.4× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 106.27ms | 58.41ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 24.21ms | 18.58ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_sum_range` | 22.50ms | 17.92ms | 0.8× | 1.8% | PASS |
| file_reads | `oltp_order_range` | 4.18ms | 3.96ms | 0.9× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.23ms | 5.13ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.12ms | 8.76ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_points` | 29.39ms | 25.30ms | 0.9× | 2.1% | PASS |
| file_reads | `select_random_ranges` | 13.74ms | 9.04ms | 0.7× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 15.59ms | 13.29ms | 0.9× | 1.0% | PASS |
| file_reads | `groupby_scan` | 35.98ms | 38.65ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 15.32ms | 12.26ms | 0.8× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.95ms | 7.04ms | 1.4× | 2.1% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.44s | 1.3× | 1.0% | PASS |
| file_reads | `table_scan` | 1.18s | 1.53s | 1.3× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 237.50ms | 182.00ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 256.71ms | 376.50ms | 1.5× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.14ms | 42.04ms | 1.7× | 2.2% | PASS |
| file_writes | `oltp_update_index` | 96.66ms | 152.40ms | 1.6× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 93.74ms | 92.76ms | 1.0× | 9.2% | PASS |
| file_writes | `oltp_delete_insert` | 87.74ms | 117.81ms | 1.3× | 2.3% | PASS |
| file_writes | `oltp_write_only` | 58.28ms | 67.56ms | 1.2× | 1.6% | PASS |
| file_writes | `types_delete_insert` | 63.60ms | 68.45ms | 1.1× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 126.39ms | 151.19ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_point_select` | 57.08ms | 57.89ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 19.04ms | 18.59ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 17.61ms | 17.95ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_order_range` | 3.71ms | 3.96ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_distinct_range` | 4.81ms | 5.13ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.38ms | 8.70ms | 1.4× | 1.6% | PASS |
| ac_reads | `select_random_points` | 24.59ms | 25.10ms | 1.0× | 2.2% | PASS |
| ac_reads | `select_random_ranges` | 8.99ms | 9.03ms | 1.0× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.87ms | 13.30ms | 1.2× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 35.07ms | 38.40ms | 1.1× | 1.2% | PASS |
| ac_reads | `index_join` | 11.83ms | 12.06ms | 1.0× | 1.5% | PASS |
| ac_reads | `index_join_scan` | 4.19ms | 6.93ms | 1.7× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.18s | 1.54s | 1.3× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 170.52ms | 183.03ms | 1.1× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.89ms | 64.10ms | 2.8× | 6.9% | PASS |
| ac_writes | `oltp_insert_ac` | 26.84ms | 82.44ms | 3.1× | 6.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.48ms | 95.84ms | 3.6× | 5.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.18ms | 76.34ms | 3.3× | 10.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.19ms | 84.97ms | 3.2× | 8.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 26.17ms | 82.74ms | 3.2× | 8.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.02ms | 73.93ms | 3.2× | 10.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.18ms | 91.26ms | 2.8× | 5.0% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 21.63ms | 26.34ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_range_select` | 13.94ms | 15.45ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_sum_range` | 13.51ms | 14.55ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_order_range` | 2.65ms | 2.91ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.30ms | 3.64ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.17ms | 4.51ms | 1.4× | 1.4% | PASS |
| mem_reads | `select_random_points` | 19.19ms | 22.83ms | 1.2× | 0.6% | PASS |
| mem_reads | `select_random_ranges` | 5.16ms | 6.12ms | 1.2× | 0.9% | PASS |
| mem_reads | `covering_index_scan` | 4.67ms | 6.87ms | 1.5× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 24.93ms | 29.44ms | 1.2× | 0.4% | PASS |
| mem_reads | `index_join` | 5.79ms | 8.67ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 2.88ms | 4.99ms | 1.7× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 796.58ms | 967.77ms | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 899.40ms | 1.06s | 1.2× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 95.61ms | 114.46ms | 1.2× | 0.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 140.95ms | 199.43ms | 1.4× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 11.84ms | 20.45ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 43.86ms | 79.40ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 30.66ms | 52.75ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 30.84ms | 57.35ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 16.57ms | 34.48ms | 2.1× | 2.3% | PASS |
| mem_writes | `types_delete_insert` | 19.72ms | 32.36ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 61.48ms | 93.82ms | 1.5× | 0.7% | PASS |
| file_reads | `oltp_point_select` | 41.73ms | 29.76ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 14.87ms | 15.60ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_sum_range` | 14.36ms | 14.72ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 2.74ms | 2.87ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 3.37ms | 3.60ms | 1.1× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 5.21ms | 4.63ms | 0.9× | 1.0% | PASS |
| file_reads | `select_random_points` | 20.67ms | 22.57ms | 1.1× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 7.12ms | 6.42ms | 0.9× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 6.87ms | 7.12ms | 1.0× | 0.5% | PASS |
| file_reads | `groupby_scan` | 24.91ms | 29.59ms | 1.2× | 0.6% | PASS |
| file_reads | `index_join` | 6.75ms | 8.18ms | 1.2× | 1.3% | PASS |
| file_reads | `index_join_scan` | 2.87ms | 4.90ms | 1.7× | 1.9% | PASS |
| file_reads | `types_table_scan` | 803.83ms | 954.24ms | 1.2× | 0.4% | PASS |
| file_reads | `table_scan` | 909.69ms | 1.05s | 1.2× | 1.6% | PASS |
| file_reads | `oltp_read_only` | 121.95ms | 120.35ms | 1.0× | 0.3% | PASS |
| file_writes | `oltp_bulk_insert` | 148.85ms | 203.15ms | 1.4× | 0.7% | PASS |
| file_writes | `oltp_insert` | 14.90ms | 22.63ms | 1.5× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 53.52ms | 84.74ms | 1.6× | 2.0% | PASS |
| file_writes | `oltp_update_non_index` | 41.20ms | 55.71ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_delete_insert` | 42.08ms | 64.43ms | 1.5× | 2.0% | PASS |
| file_writes | `oltp_write_only` | 26.02ms | 37.90ms | 1.5× | 2.5% | PASS |
| file_writes | `types_delete_insert` | 27.46ms | 34.71ms | 1.3× | 2.7% | PASS |
| file_writes | `oltp_read_write` | 69.58ms | 96.70ms | 1.4× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 26.54ms | 28.96ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 12.26ms | 15.41ms | 1.3× | 3.2% | PASS |
| ac_reads | `oltp_sum_range` | 11.98ms | 14.53ms | 1.2× | 3.7% | PASS |
| ac_reads | `oltp_order_range` | 2.35ms | 2.82ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 3.00ms | 3.54ms | 1.2× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 3.53ms | 4.31ms | 1.2× | 3.0% | PASS |
| ac_reads | `select_random_points` | 18.29ms | 21.74ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 5.33ms | 6.16ms | 1.2× | 2.1% | PASS |
| ac_reads | `covering_index_scan` | 5.37ms | 7.07ms | 1.3× | 0.4% | PASS |
| ac_reads | `groupby_scan` | 24.70ms | 29.42ms | 1.2× | 0.6% | PASS |
| ac_reads | `index_join` | 5.75ms | 7.87ms | 1.4× | 1.1% | PASS |
| ac_reads | `index_join_scan` | 2.55ms | 4.11ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 799.20ms | 955.57ms | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 908.36ms | 1.05s | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 101.28ms | 120.32ms | 1.2× | 0.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 8.68ms | 27.18ms | 3.1× | 4.9% | PASS |
| ac_writes | `oltp_insert_ac` | 9.61ms | 36.95ms | 3.8× | 4.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 10.17ms | 41.71ms | 4.1× | 4.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 8.78ms | 31.74ms | 3.6× | 5.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 9.33ms | 38.61ms | 4.1× | 5.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 9.51ms | 38.16ms | 4.0× | 4.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 8.53ms | 34.41ms | 4.0× | 4.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 12.46ms | 40.28ms | 3.2× | 3.6% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 40s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 21.60ms | 38.00ms | 56.8% | 1.3% | PASS |
| `status_dirty_many_tables` | 23.89ms | 42.00ms | 56.9% | 0.9% | PASS |
| `diff_regular_working_one_table` | 18.08ms | 33.00ms | 54.8% | 0.6% | PASS |
| `diff_regular_working_many_tables` | 26.56ms | 50.00ms | 53.1% | 1.3% | PASS |
| `diff_stat_working_many_tables` | 27.09ms | 48.00ms | 56.4% | 1.1% | PASS |
| `diff_schema_working_many_tables` | 27.22ms | 48.00ms | 56.7% | 1.1% | PASS |
| `branch_list_many_branches` | 12.81ms | 25.00ms | 51.2% | 1.9% | PASS |
| `branch_create_delete` | 13.49ms | 27.00ms | 50.0% | 1.1% | PASS |
| `at_literal_deep_history` | 13.75ms | 28.00ms | 49.1% | 1.1% | PASS |
| `diff_literal_deep_history` | 13.84ms | 28.00ms | 49.4% | 1.1% | PASS |
| `history_literal_deep_history` | 14.41ms | 30.00ms | 48.0% | 1.0% | PASS |
| `checkout_branch_clean` | 20.03ms | 43.00ms | 46.6% | 0.8% | PASS |
| `merge_data_no_conflicts` | 15.23ms | 33.00ms | 46.2% | 1.0% | PASS |
| `merge_data_secondary_index` | 608.55ms | 944.00ms | 64.5% | 0.8% | PASS |
| `merge_schema_no_conflicts` | 11.73ms | 24.00ms | 48.9% | 1.3% | PASS |
| `merge_data_conflicts` | 17.21ms | 33.00ms | 52.1% | 0.6% | PASS |
| `merge_data_conflicts_with_resolve` | 18.00ms | 34.00ms | 52.9% | 0.6% | PASS |

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
| copy_fsync | candidate | 49.416 | 45.141–57.414 | 48.499 | 2023.64 | 107968266 |
| push_initial | candidate | 340.891 | 339.517–342.042 | 339.986 | 293.35 | 107956772 |
| clone_initial | candidate | 437.303 | 432.705–439.735 | 435.362 | 228.67 | 108475035 |
| push_noop | candidate | 0.409 | 0.380–0.422 | 0.231 | — | 0 |
| fetch_noop | candidate | 0.097 | 0.090–0.113 | 0.098 | — | 0 |
| push_incremental | candidate | 138.047 | 134.949–138.841 | 135.984 | 7.24 | 7909775 |
| fetch_incremental | candidate | 59.485 | 59.323–59.953 | 58.973 | 16.81 | 7910084 |
| pull_fast_forward | candidate | 54.304 | 52.819–54.692 | 52.615 | 18.41 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.57 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.76 | 295.133 | 109.784 | 47250 | 2337 |
| push_noop | candidate | 46.20 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.20 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.20 | 96.712 | 7.910 | 22374 | 125 |
| fetch_incremental | candidate | 46.20 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.20 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5796.097 | 5737.256–5822.396 | 299.189 | 172.53 | 1087718031 |
| push_initial | candidate | 7367.341 | 7322.968–7375.762 | 3676.747 | 135.73 | 1079566275 |
| clone_initial | candidate | 9187.812 | 9071.272–9226.764 | 5568.998 | 108.84 | 1102407326 |
| push_noop | candidate | 0.662 | 0.648–0.679 | 0.298 | — | 0 |
| fetch_noop | candidate | 0.154 | 0.140–0.158 | 0.155 | — | 0 |
| push_incremental | candidate | 914.026 | 911.188–920.440 | 866.299 | 1.09 | 15806003 |
| fetch_incremental | candidate | 254.462 | 249.295–263.994 | 186.847 | 3.93 | 15806513 |
| pull_fast_forward | candidate | 251.413 | 222.819–253.692 | 180.401 | 3.98 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.77 | 2091.466 | 1087.622 | 263397 | 20541 |
| clone_initial | candidate | 124.11 | 3516.389 | 1132.819 | 612000 | 32243 |
| push_noop | candidate | 47.05 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.05 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.25 | 616.127 | 15.928 | 149661 | 313 |
| fetch_incremental | candidate | 50.47 | 61.536 | 15.928 | 13725 | 313 |
| pull_fast_forward | candidate | 50.45 | 61.469 | 15.929 | 13721 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
