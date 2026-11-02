# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-02 21:38 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41512331055)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.49s | 12.85s | 1.2× | 1.7% | **PASS** |
| Writes | 2.20s | 3.74s | 1.7× | 1.5% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 11.47s | 13.11s | 1.1× | 1.6% | **PASS** |
| Writes | 3.12s | 4.09s | 1.3× | 2.0% | **PASS** |
| Autocommit writes | 795.48ms | 2.56s | 3.2× | 6.8% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.46s | 2.90s | 1.2× | 1.5% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.78s | 3.33s | 1.2× | 1.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.64s | 3.28s | 1.2× | 1.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.62s | 3.34s | 1.3× | 1.8% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 429.99ms | 766.40ms | 1.8× | 1.5% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 595.49ms | 996.62ms | 1.7× | 2.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 580.10ms | 975.38ms | 1.7× | 1.1% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 597.59ms | 997.33ms | 1.7× | 1.5% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.68s | 2.95s | 1.1× | 1.6% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.94s | 3.39s | 1.2× | 2.0% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.85s | 3.34s | 1.2× | 1.9% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.00s | 3.43s | 1.1× | 1.5% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 593.76ms | 829.46ms | 1.4× | 1.8% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 944.06ms | 1.11s | 1.2× | 4.7% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 811.68ms | 1.08s | 1.3× | 2.0% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 767.90ms | 1.06s | 1.4× | 2.2% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.56s | 2.96s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 3.01s | 3.45s | 1.1× | 1.8% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.68s | 3.34s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.89s | 3.43s | 1.2× | 2.2% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 200.67ms | 653.31ms | 3.3× | 6.8% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 203.17ms | 645.26ms | 3.2× | 5.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 197.37ms | 633.73ms | 3.2× | 7.9% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 194.27ms | 624.36ms | 3.2× | 8.2% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.47ms | 31.30ms | 1.3× | 1.4% | PASS |
| mem_reads | `oltp_range_select` | 10.52ms | 12.85ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 9.47ms | 12.22ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 2.66ms | 3.10ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 3.59ms | 4.28ms | 1.2× | 0.7% | PASS |
| mem_reads | `oltp_index_scan` | 3.83ms | 5.55ms | 1.4× | 1.7% | PASS |
| mem_reads | `select_random_points` | 9.81ms | 11.86ms | 1.2× | 2.6% | PASS |
| mem_reads | `select_random_ranges` | 4.57ms | 5.36ms | 1.2× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 7.93ms | 10.78ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 30.57ms | 35.25ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 5.73ms | 8.80ms | 1.5× | 2.1% | PASS |
| mem_reads | `index_join_scan` | 3.30ms | 5.68ms | 1.7× | 2.2% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.27s | 1.2× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.18s | 1.36s | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_read_only` | 104.51ms | 129.21ms | 1.2× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 174.35ms | 299.93ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 14.90ms | 26.85ms | 1.8× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 49.88ms | 98.13ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 34.19ms | 64.10ms | 1.9× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 43.57ms | 77.90ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 21.48ms | 48.54ms | 2.3× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 23.89ms | 37.82ms | 1.6× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 67.73ms | 113.12ms | 1.7× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 91.63ms | 48.80ms | 0.5× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 17.99ms | 14.70ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 16.89ms | 14.18ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.52ms | 3.38ms | 1.0× | 2.4% | PASS |
| file_reads | `oltp_distinct_range` | 4.47ms | 4.56ms | 1.0× | 1.8% | PASS |
| file_reads | `oltp_index_scan` | 11.04ms | 7.60ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_points` | 17.21ms | 13.83ms | 0.8× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 11.71ms | 7.33ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.27ms | 12.92ms | 0.8× | 1.4% | PASS |
| file_reads | `groupby_scan` | 31.79ms | 35.65ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 9.78ms | 10.24ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.22ms | 6.01ms | 1.4× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.26s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.18s | 1.35s | 1.1× | 0.7% | PASS |
| file_reads | `oltp_read_only` | 205.69ms | 155.70ms | 0.8× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 188.15ms | 312.58ms | 1.7× | 0.9% | PASS |
| file_writes | `oltp_insert` | 22.01ms | 30.14ms | 1.4× | 2.2% | PASS |
| file_writes | `oltp_update_index` | 77.33ms | 107.37ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_update_non_index` | 58.64ms | 70.86ms | 1.2× | 2.2% | PASS |
| file_writes | `oltp_delete_insert` | 67.28ms | 89.15ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 45.14ms | 54.18ms | 1.2× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 39.28ms | 44.31ms | 1.1× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 95.94ms | 120.87ms | 1.3× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 45.75ms | 48.75ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 13.46ms | 14.75ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_sum_range` | 12.38ms | 14.24ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 3.10ms | 3.40ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 4.04ms | 4.58ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.50ms | 7.62ms | 1.2× | 1.8% | PASS |
| ac_reads | `select_random_points` | 13.03ms | 13.91ms | 1.1× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 7.18ms | 7.32ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 10.85ms | 12.99ms | 1.2× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 31.23ms | 35.69ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.42ms | 10.26ms | 1.4× | 2.4% | PASS |
| ac_reads | `index_join_scan` | 3.71ms | 6.04ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.27s | 1.2× | 0.9% | PASS |
| ac_reads | `table_scan` | 1.20s | 1.36s | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_read_only` | 138.32ms | 155.97ms | 1.1× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.54ms | 68.24ms | 3.2× | 6.4% | PASS |
| ac_writes | `oltp_insert_ac` | 25.01ms | 81.55ms | 3.3× | 5.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.30ms | 92.34ms | 3.4× | 6.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.55ms | 76.20ms | 3.2× | 9.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.09ms | 87.38ms | 3.5× | 6.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.82ms | 82.64ms | 3.3× | 6.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.79ms | 75.94ms | 3.3× | 10.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.56ms | 89.02ms | 2.9× | 6.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 37.25ms | 42.20ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 17.70ms | 17.43ms | 1.0× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 15.88ms | 16.53ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.42ms | 3.67ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.37ms | 4.82ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 4.02ms | 6.92ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 23.71ms | 23.59ms | 1.0× | 3.6% | PASS |
| mem_reads | `select_random_ranges` | 6.83ms | 7.08ms | 1.0× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 8.01ms | 11.30ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 35.02ms | 38.08ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 10.87ms | 10.92ms | 1.0× | 2.9% | PASS |
| mem_reads | `index_join_scan` | 3.87ms | 6.85ms | 1.8× | 3.3% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.44s | 1.2× | 3.5% | PASS |
| mem_reads | `table_scan` | 1.31s | 1.54s | 1.2× | 3.0% | PASS |
| mem_reads | `oltp_read_only` | 138.97ms | 155.20ms | 1.1× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.27ms | 361.59ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 17.54ms | 37.45ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 65.93ms | 141.33ms | 2.1× | 2.5% | PASS |
| mem_writes | `oltp_update_non_index` | 47.02ms | 82.20ms | 1.7× | 2.2% | PASS |
| mem_writes | `oltp_delete_insert` | 54.25ms | 105.44ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 29.21ms | 56.94ms | 1.9× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 40.71ms | 62.49ms | 1.5× | 2.5% | PASS |
| mem_writes | `oltp_read_write` | 107.56ms | 149.19ms | 1.4× | 2.9% | PASS |
| file_reads | `oltp_point_select` | 106.34ms | 59.76ms | 0.6× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 24.92ms | 19.10ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 23.89ms | 18.77ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 4.53ms | 3.98ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.45ms | 5.13ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 11.19ms | 8.92ms | 0.8× | 1.2% | PASS |
| file_reads | `select_random_points` | 31.98ms | 26.37ms | 0.8× | 2.0% | PASS |
| file_reads | `select_random_ranges` | 14.36ms | 9.15ms | 0.6× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 15.76ms | 13.59ms | 0.9× | 0.9% | PASS |
| file_reads | `groupby_scan` | 37.01ms | 39.04ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 15.54ms | 12.54ms | 0.8× | 2.9% | PASS |
| file_reads | `index_join_scan` | 4.91ms | 7.40ms | 1.5× | 3.2% | PASS |
| file_reads | `types_table_scan` | 1.13s | 1.44s | 1.3× | 3.2% | PASS |
| file_reads | `table_scan` | 1.26s | 1.54s | 1.2× | 4.1% | PASS |
| file_reads | `oltp_read_only` | 252.10ms | 186.85ms | 0.7× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 259.24ms | 378.23ms | 1.5× | 1.2% | PASS |
| file_writes | `oltp_insert` | 25.64ms | 43.00ms | 1.7× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 133.13ms | 164.75ms | 1.2× | 8.9% | PASS |
| file_writes | `oltp_update_non_index` | 106.53ms | 99.17ms | 0.9× | 11.9% | PASS |
| file_writes | `oltp_delete_insert` | 102.01ms | 126.38ms | 1.2× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 90.84ms | 70.56ms | 0.8× | 11.0% | PASS |
| file_writes | `types_delete_insert` | 74.80ms | 70.80ms | 0.9× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 151.87ms | 161.31ms | 1.1× | 7.3% | PASS |
| ac_reads | `oltp_point_select` | 58.20ms | 59.27ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_range_select` | 19.86ms | 19.07ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 18.41ms | 18.46ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 3.95ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.86ms | 5.10ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.68ms | 8.84ms | 1.3× | 1.8% | PASS |
| ac_reads | `select_random_points` | 25.50ms | 26.00ms | 1.0× | 2.8% | PASS |
| ac_reads | `select_random_ranges` | 9.46ms | 9.11ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.94ms | 13.40ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 35.85ms | 38.58ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 12.67ms | 12.17ms | 1.0× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 4.29ms | 7.22ms | 1.7× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.21s | 1.46s | 1.2× | 2.1% | PASS |
| ac_reads | `table_scan` | 1.41s | 1.58s | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_read_only` | 178.01ms | 184.94ms | 1.0× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.40ms | 64.95ms | 2.8× | 5.2% | PASS |
| ac_writes | `oltp_insert_ac` | 26.53ms | 77.92ms | 2.9× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.54ms | 92.91ms | 3.5× | 5.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.47ms | 74.89ms | 3.3× | 7.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.01ms | 84.66ms | 3.4× | 5.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.50ms | 85.11ms | 3.3× | 5.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.90ms | 75.57ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.82ms | 89.25ms | 2.9× | 3.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.37ms | 40.07ms | 1.2× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 16.10ms | 16.43ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 14.70ms | 15.71ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 3.31ms | 3.58ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.28ms | 4.75ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.95ms | 6.70ms | 1.7× | 2.2% | PASS |
| mem_reads | `select_random_points` | 21.12ms | 22.25ms | 1.1× | 3.2% | PASS |
| mem_reads | `select_random_ranges` | 6.50ms | 6.96ms | 1.1× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 7.99ms | 11.27ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 34.82ms | 37.67ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 10.05ms | 10.86ms | 1.1× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.67ms | 6.50ms | 1.8× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.24s | 1.53s | 1.2× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 139.24ms | 153.83ms | 1.1× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 237.54ms | 363.40ms | 1.5× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 18.09ms | 37.26ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 64.17ms | 138.60ms | 2.2× | 2.4% | PASS |
| mem_writes | `oltp_update_non_index` | 46.76ms | 79.75ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 51.66ms | 102.21ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 27.30ms | 55.24ms | 2.0× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 36.92ms | 58.95ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 97.67ms | 139.97ms | 1.4× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 104.88ms | 58.08ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 23.82ms | 18.56ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 22.41ms | 17.98ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_order_range` | 4.31ms | 3.86ms | 0.9× | 4.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.27ms | 5.08ms | 1.0× | 2.3% | PASS |
| file_reads | `oltp_index_scan` | 11.14ms | 8.63ms | 0.8× | 2.1% | PASS |
| file_reads | `select_random_points` | 29.98ms | 25.32ms | 0.8× | 2.6% | PASS |
| file_reads | `select_random_ranges` | 13.82ms | 9.00ms | 0.7× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 15.49ms | 13.30ms | 0.9× | 1.3% | PASS |
| file_reads | `groupby_scan` | 35.96ms | 38.13ms | 1.1× | 1.4% | PASS |
| file_reads | `index_join` | 14.50ms | 12.21ms | 0.8× | 2.3% | PASS |
| file_reads | `index_join_scan` | 4.75ms | 6.89ms | 1.5× | 2.9% | PASS |
| file_reads | `types_table_scan` | 1.09s | 1.42s | 1.3× | 0.9% | PASS |
| file_reads | `table_scan` | 1.23s | 1.52s | 1.2× | 0.9% | PASS |
| file_reads | `oltp_read_only` | 243.68ms | 182.19ms | 0.7× | 1.4% | PASS |
| file_writes | `oltp_bulk_insert` | 257.69ms | 379.71ms | 1.5× | 0.6% | PASS |
| file_writes | `oltp_insert` | 25.53ms | 42.69ms | 1.7× | 2.1% | PASS |
| file_writes | `oltp_update_index` | 97.76ms | 155.62ms | 1.6× | 1.8% | PASS |
| file_writes | `oltp_update_non_index` | 91.81ms | 93.05ms | 1.0× | 10.5% | PASS |
| file_writes | `oltp_delete_insert` | 87.95ms | 118.86ms | 1.4× | 2.7% | PASS |
| file_writes | `oltp_write_only` | 58.80ms | 68.26ms | 1.2× | 2.2% | PASS |
| file_writes | `types_delete_insert` | 63.26ms | 69.64ms | 1.1× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 128.89ms | 152.11ms | 1.2× | 1.9% | PASS |
| ac_reads | `oltp_point_select` | 57.55ms | 58.07ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 19.02ms | 18.53ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_sum_range` | 17.52ms | 17.87ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.77ms | 3.84ms | 1.0× | 2.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.72ms | 5.05ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_index_scan` | 6.60ms | 8.64ms | 1.3× | 1.5% | PASS |
| ac_reads | `select_random_points` | 24.80ms | 25.11ms | 1.0× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 9.16ms | 9.02ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.88ms | 13.26ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 35.34ms | 38.13ms | 1.1× | 1.3% | PASS |
| ac_reads | `index_join` | 12.20ms | 12.18ms | 1.0× | 2.1% | PASS |
| ac_reads | `index_join_scan` | 4.26ms | 6.90ms | 1.6× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.09s | 1.42s | 1.3× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.22s | 1.52s | 1.3× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 175.44ms | 181.95ms | 1.0× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.98ms | 63.34ms | 2.9× | 8.1% | PASS |
| ac_writes | `oltp_insert_ac` | 24.75ms | 79.07ms | 3.2× | 6.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.27ms | 94.55ms | 3.6× | 9.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.68ms | 71.57ms | 3.3× | 8.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.33ms | 82.12ms | 3.2× | 7.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.34ms | 80.66ms | 3.3× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.69ms | 74.67ms | 3.3× | 9.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.32ms | 87.76ms | 2.9× | 7.0% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 32.20ms | 42.03ms | 1.3× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 19.67ms | 23.40ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 17.30ms | 22.27ms | 1.3× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 3.57ms | 4.20ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 4.69ms | 5.38ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 4.62ms | 6.69ms | 1.4× | 2.2% | PASS |
| mem_reads | `select_random_points` | 26.22ms | 31.81ms | 1.2× | 3.1% | PASS |
| mem_reads | `select_random_ranges` | 7.50ms | 9.26ms | 1.2× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 7.98ms | 11.09ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 36.94ms | 43.11ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 7.92ms | 11.67ms | 1.5× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.96ms | 6.44ms | 1.6× | 4.4% | PASS |
| mem_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.21s | 1.51s | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_read_only` | 161.48ms | 190.41ms | 1.2× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 240.23ms | 353.84ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.77ms | 34.95ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 69.76ms | 134.55ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 53.81ms | 92.21ms | 1.7× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 51.65ms | 102.12ms | 2.0× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 28.70ms | 61.28ms | 2.1× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 32.30ms | 56.57ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 102.35ms | 161.80ms | 1.6× | 2.4% | PASS |
| file_reads | `oltp_point_select` | 102.84ms | 61.45ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 27.58ms | 25.61ms | 0.9× | 1.8% | PASS |
| file_reads | `oltp_sum_range` | 25.20ms | 24.73ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 4.53ms | 4.53ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.60ms | 5.74ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.40ms | 8.58ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_points` | 34.97ms | 34.85ms | 1.0× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 14.91ms | 11.44ms | 0.8× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 15.28ms | 13.09ms | 0.9× | 1.2% | PASS |
| file_reads | `groupby_scan` | 38.12ms | 43.61ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 12.03ms | 13.25ms | 1.1× | 1.5% | PASS |
| file_reads | `index_join_scan` | 5.05ms | 7.01ms | 1.4× | 2.6% | PASS |
| file_reads | `types_table_scan` | 1.17s | 1.43s | 1.2× | 2.1% | PASS |
| file_reads | `table_scan` | 1.28s | 1.53s | 1.2× | 2.7% | PASS |
| file_reads | `oltp_read_only` | 261.88ms | 217.88ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 255.89ms | 367.31ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 26.11ms | 38.79ms | 1.5× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 97.89ms | 145.93ms | 1.5× | 2.8% | PASS |
| file_writes | `oltp_update_non_index` | 80.09ms | 98.30ms | 1.2× | 2.7% | PASS |
| file_writes | `oltp_delete_insert` | 78.53ms | 112.66ms | 1.4× | 3.6% | PASS |
| file_writes | `oltp_write_only` | 51.61ms | 66.13ms | 1.3× | 1.9% | PASS |
| file_writes | `types_delete_insert` | 49.34ms | 62.87ms | 1.3× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 128.43ms | 170.07ms | 1.3× | 1.9% | PASS |
| ac_reads | `oltp_point_select` | 56.55ms | 61.50ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 23.03ms | 25.66ms | 1.1× | 2.5% | PASS |
| ac_reads | `oltp_sum_range` | 20.39ms | 24.75ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 4.11ms | 4.55ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 5.11ms | 5.74ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 7.29ms | 8.69ms | 1.2× | 2.3% | PASS |
| ac_reads | `select_random_points` | 30.02ms | 35.33ms | 1.2× | 2.2% | PASS |
| ac_reads | `select_random_ranges` | 10.32ms | 11.44ms | 1.1× | 2.2% | PASS |
| ac_reads | `covering_index_scan` | 10.95ms | 13.16ms | 1.2× | 2.2% | PASS |
| ac_reads | `groupby_scan` | 37.72ms | 43.76ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 9.98ms | 13.40ms | 1.3× | 2.6% | PASS |
| ac_reads | `index_join_scan` | 4.59ms | 7.02ms | 1.5× | 2.5% | PASS |
| ac_reads | `types_table_scan` | 1.12s | 1.42s | 1.3× | 2.3% | PASS |
| ac_reads | `table_scan` | 1.36s | 1.54s | 1.1× | 3.1% | PASS |
| ac_reads | `oltp_read_only` | 191.92ms | 217.46ms | 1.1× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.07ms | 63.93ms | 2.9× | 8.9% | PASS |
| ac_writes | `oltp_insert_ac` | 24.26ms | 76.55ms | 3.2× | 8.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.09ms | 89.99ms | 3.4× | 7.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.91ms | 70.24ms | 3.2× | 8.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.77ms | 82.20ms | 3.5× | 8.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.87ms | 79.67ms | 3.2× | 6.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.60ms | 74.63ms | 3.6× | 12.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.70ms | 87.15ms | 2.8× | 6.7% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 16s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.28ms | 38.00ms | 82.3% | 1.5% | PASS |
| `status_dirty_many_tables` | 35.09ms | 42.00ms | 83.5% | 1.0% | PASS |
| `diff_regular_working_one_table` | 26.66ms | 33.00ms | 80.8% | 1.7% | PASS |
| `diff_regular_working_many_tables` | 39.79ms | 50.00ms | 79.6% | 1.4% | PASS |
| `diff_stat_working_many_tables` | 40.17ms | 48.00ms | 83.7% | 0.8% | PASS |
| `diff_schema_working_many_tables` | 40.46ms | 48.00ms | 84.3% | 0.7% | PASS |
| `branch_list_many_branches` | 19.44ms | 25.00ms | 77.8% | 1.6% | PASS |
| `branch_create_delete` | 20.89ms | 27.00ms | 77.4% | 1.6% | PASS |
| `at_literal_deep_history` | 21.04ms | 28.00ms | 75.1% | 1.4% | PASS |
| `diff_literal_deep_history` | 21.24ms | 28.00ms | 75.8% | 1.5% | PASS |
| `history_literal_deep_history` | 22.20ms | 30.00ms | 74.0% | 1.6% | PASS |
| `checkout_branch_clean` | 30.00ms | 43.00ms | 69.8% | 1.5% | PASS |
| `merge_data_no_conflicts` | 23.38ms | 33.00ms | 70.9% | 1.3% | PASS |
| `merge_data_secondary_index` | 875.81ms | 944.00ms | 92.8% | 0.9% | PASS |
| `merge_schema_no_conflicts` | 18.07ms | 24.00ms | 75.3% | 1.7% | PASS |
| `merge_data_conflicts` | 27.03ms | 33.00ms | 81.9% | 1.7% | PASS |
| `merge_data_conflicts_with_resolve` | 27.40ms | 34.00ms | 80.6% | 1.4% | PASS |

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
| copy_fsync | candidate | 60.274 | 54.936–65.324 | 38.134 | 1659.09 | 107968266 |
| push_initial | candidate | 585.406 | 583.954–588.409 | 568.410 | 170.82 | 107956772 |
| clone_initial | candidate | 761.469 | 760.419–765.145 | 736.621 | 131.33 | 108475035 |
| push_noop | candidate | 0.722 | 0.648–2.579 | 0.410 | — | 0 |
| fetch_noop | candidate | 0.226 | 0.203–0.232 | 0.228 | — | 0 |
| push_incremental | candidate | 231.485 | 230.601–232.221 | 228.368 | 4.32 | 7909775 |
| fetch_incremental | candidate | 95.203 | 95.012–97.682 | 92.895 | 10.50 | 7910084 |
| pull_fast_forward | candidate | 84.475 | 83.642–85.279 | 81.417 | 11.84 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.74 | 295.160 | 109.784 | 47257 | 2337 |
| push_noop | candidate | 46.05 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.05 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.05 | 97.033 | 7.910 | 22452 | 125 |
| fetch_incremental | candidate | 46.05 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.05 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 6215.770 | 5699.532–6586.732 | 315.476 | 160.88 | 1087718031 |
| push_initial | candidate | 8100.061 | 7991.667–8210.584 | 4127.419 | 123.46 | 1079566275 |
| clone_initial | candidate | 10517.317 | 10004.417–11174.289 | 6009.950 | 95.08 | 1102407326 |
| push_noop | candidate | 1.220 | 0.633–99.751 | 0.380 | — | 0 |
| fetch_noop | candidate | 0.175 | 0.171–0.197 | 0.177 | — | 0 |
| push_incremental | candidate | 1002.366 | 1001.332–1018.943 | 945.066 | 1.00 | 15806003 |
| fetch_incremental | candidate | 406.745 | 303.250–485.591 | 216.040 | 2.46 | 15806513 |
| pull_fast_forward | candidate | 318.346 | 289.358–391.644 | 210.913 | 3.14 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.79 | 2091.482 | 1087.622 | 263401 | 20541 |
| clone_initial | candidate | 124.01 | 3522.061 | 1132.819 | 613324 | 32243 |
| push_noop | candidate | 47.28 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.28 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.41 | 618.159 | 15.928 | 150134 | 313 |
| fetch_incremental | candidate | 50.38 | 61.943 | 15.928 | 13824 | 313 |
| pull_fast_forward | candidate | 50.38 | 61.875 | 15.929 | 13820 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
