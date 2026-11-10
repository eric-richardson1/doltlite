# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-11-10 19:02 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42862787339)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.26s | 9.24s | 1.1× | 1.8% | **PASS** |
| Writes | 1.55s | 2.51s | 1.6× | 1.7% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.05s | 9.42s | 1.0× | 1.4% | **PASS** |
| Writes | 4.04s | 4.09s | 1.0× | 3.5% | **FAIL** |
| Autocommit writes | 804.08ms | 2.32s | 2.9× | 6.0% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.16s | 2.27s | 1.1× | 1.6% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.83s | 1.99s | 1.1× | 3.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.53s | 3.02s | 1.2× | 1.1% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.74s | 1.95s | 1.1× | 2.4% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 332.75ms | 553.20ms | 1.7× | 1.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 389.97ms | 614.94ms | 1.6× | 4.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 482.24ms | 791.51ms | 1.6× | 1.0% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 344.72ms | 554.46ms | 1.6× | 2.1% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.40s | 2.32s | 1.0× | 0.9% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.08s | 2.07s | 1.0× | 2.1% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.65s | 3.05s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.91s | 1.99s | 1.0× | 1.7% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 881.69ms | 887.90ms | 1.0× | 6.5% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.11s | 1.05s | 0.9× | 4.1% | **FAIL** |
| File-backed | Writes | blobpk | 8 | 55 | 1.18s | 1.27s | 1.1× | 3.0% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 872.94ms | 885.39ms | 1.0× | 1.7% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.26s | 2.33s | 1.0× | 1.4% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.14s | 2.19s | 1.0× | 1.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.47s | 2.94s | 1.2× | 1.1% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.70s | 1.89s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 155.66ms | 549.54ms | 3.5× | 14.5% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 193.79ms | 540.27ms | 2.8× | 5.8% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 257.74ms | 742.65ms | 2.9× | 3.4% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 196.88ms | 490.40ms | 2.5× | 5.4% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 19.48ms | 22.84ms | 1.2× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 9.16ms | 9.68ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_sum_range` | 7.73ms | 9.11ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 2.21ms | 2.41ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_distinct_range` | 3.00ms | 3.23ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 3.12ms | 4.15ms | 1.3× | 1.8% | PASS |
| mem_reads | `select_random_points` | 8.84ms | 9.63ms | 1.1× | 2.6% | PASS |
| mem_reads | `select_random_ranges` | 3.76ms | 3.93ms | 1.0× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 5.90ms | 7.92ms | 1.3× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 25.47ms | 27.73ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 4.57ms | 7.30ms | 1.6× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 2.72ms | 4.90ms | 1.8× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 949.55ms | 995.28ms | 1.0× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.04s | 1.07s | 1.0× | 3.2% | PASS |
| mem_reads | `oltp_read_only` | 80.19ms | 92.88ms | 1.2× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 133.37ms | 217.28ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.64ms | 19.19ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 39.44ms | 72.61ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 27.71ms | 46.48ms | 1.7× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 34.86ms | 57.58ms | 1.7× | 1.7% | PASS |
| mem_writes | `oltp_write_only` | 17.26ms | 35.36ms | 2.0× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 18.77ms | 25.82ms | 1.4× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 49.69ms | 78.87ms | 1.6× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 86.58ms | 38.38ms | 0.4× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 16.00ms | 11.34ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_sum_range` | 14.75ms | 10.81ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_order_range` | 2.98ms | 2.62ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 3.77ms | 3.45ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 10.29ms | 6.02ms | 0.6× | 0.8% | PASS |
| file_reads | `select_random_points` | 15.95ms | 11.25ms | 0.7× | 1.1% | PASS |
| file_reads | `select_random_ranges` | 10.63ms | 5.61ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.20ms | 9.61ms | 0.7× | 0.8% | PASS |
| file_reads | `groupby_scan` | 26.16ms | 27.78ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 8.49ms | 7.96ms | 0.9× | 1.4% | PASS |
| file_reads | `index_join_scan` | 3.52ms | 4.91ms | 1.4× | 1.5% | PASS |
| file_reads | `types_table_scan` | 922.14ms | 981.53ms | 1.1× | 1.7% | PASS |
| file_reads | `table_scan` | 1.08s | 1.08s | 1.0× | 2.4% | PASS |
| file_reads | `oltp_read_only` | 186.92ms | 119.91ms | 0.6× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 178.22ms | 273.01ms | 1.5× | 3.2% | PASS |
| file_writes | `oltp_insert` | 27.84ms | 31.37ms | 1.1× | 8.0% | PASS |
| file_writes | `oltp_update_index` | 139.33ms | 129.60ms | 0.9× | 3.1% | PASS |
| file_writes | `oltp_update_non_index` | 118.80ms | 89.29ms | 0.8× | 20.5% | PASS |
| file_writes | `oltp_delete_insert` | 121.11ms | 109.95ms | 0.9× | 7.3% | PASS |
| file_writes | `oltp_write_only` | 90.92ms | 73.17ms | 0.8× | 5.3% | PASS |
| file_writes | `types_delete_insert` | 76.52ms | 58.60ms | 0.8× | 7.9% | PASS |
| file_writes | `oltp_read_write` | 128.95ms | 122.91ms | 1.0× | 5.7% | PASS |
| ac_reads | `oltp_point_select` | 40.51ms | 39.19ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 11.61ms | 11.44ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 10.41ms | 10.91ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 2.60ms | 2.63ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 3.33ms | 3.48ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.74ms | 6.06ms | 1.1× | 0.7% | PASS |
| ac_reads | `select_random_points` | 11.57ms | 11.62ms | 1.0× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 6.03ms | 5.64ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.63ms | 1.1× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 25.75ms | 27.81ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 6.21ms | 8.11ms | 1.3× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.12ms | 4.95ms | 1.6× | 2.2% | PASS |
| ac_reads | `types_table_scan` | 913.46ms | 986.45ms | 1.1× | 2.5% | PASS |
| ac_reads | `table_scan` | 1.10s | 1.08s | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 115.41ms | 118.61ms | 1.0× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 16.65ms | 51.48ms | 3.1× | 7.4% | PASS |
| ac_writes | `oltp_insert_ac` | 19.94ms | 73.49ms | 3.7× | 25.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.49ms | 81.79ms | 3.8× | 15.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.27ms | 60.38ms | 3.5× | 8.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.13ms | 71.83ms | 3.8× | 17.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.26ms | 67.62ms | 3.3× | 14.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 16.62ms | 62.06ms | 3.7× | 10.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.30ms | 80.88ms | 3.3× | 18.4% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.23ms | 24.74ms | 1.0× | 4.5% | PASS |
| mem_reads | `oltp_range_select` | 11.56ms | 10.29ms | 0.9× | 4.3% | PASS |
| mem_reads | `oltp_sum_range` | 11.09ms | 10.13ms | 0.9× | 3.5% | PASS |
| mem_reads | `oltp_order_range` | 2.45ms | 2.31ms | 0.9× | 1.9% | PASS |
| mem_reads | `oltp_distinct_range` | 3.04ms | 2.87ms | 0.9× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 2.76ms | 4.87ms | 1.8× | 2.3% | PASS |
| mem_reads | `select_random_points` | 19.56ms | 16.12ms | 0.8× | 4.2% | PASS |
| mem_reads | `select_random_ranges` | 4.61ms | 4.16ms | 0.9× | 3.2% | PASS |
| mem_reads | `covering_index_scan` | 4.15ms | 6.42ms | 1.5× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 22.44ms | 22.78ms | 1.0× | 1.8% | PASS |
| mem_reads | `index_join` | 8.38ms | 7.75ms | 0.9× | 3.2% | PASS |
| mem_reads | `index_join_scan` | 2.90ms | 5.81ms | 2.0× | 7.4% | PASS |
| mem_reads | `types_table_scan` | 727.77ms | 834.06ms | 1.1× | 2.0% | PASS |
| mem_reads | `table_scan` | 889.18ms | 954.28ms | 1.1× | 2.5% | PASS |
| mem_reads | `oltp_read_only` | 93.51ms | 85.74ms | 0.9× | 7.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 144.13ms | 212.42ms | 1.5× | 1.8% | PASS |
| mem_writes | `oltp_insert` | 10.80ms | 23.34ms | 2.2× | 2.1% | PASS |
| mem_writes | `oltp_update_index` | 48.08ms | 97.44ms | 2.0× | 4.0% | PASS |
| mem_writes | `oltp_update_non_index` | 36.28ms | 54.27ms | 1.5× | 4.2% | PASS |
| mem_writes | `oltp_delete_insert` | 37.82ms | 69.39ms | 1.8× | 3.6% | PASS |
| mem_writes | `oltp_write_only` | 19.98ms | 37.53ms | 1.9× | 4.0% | PASS |
| mem_writes | `types_delete_insert` | 27.23ms | 38.11ms | 1.4× | 4.0% | PASS |
| mem_writes | `oltp_read_write` | 65.66ms | 82.44ms | 1.3× | 9.0% | PASS |
| file_reads | `oltp_point_select` | 79.99ms | 38.48ms | 0.5× | 2.9% | PASS |
| file_reads | `oltp_range_select` | 16.62ms | 11.28ms | 0.7× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 16.62ms | 11.12ms | 0.7× | 2.6% | PASS |
| file_reads | `oltp_order_range` | 3.07ms | 2.43ms | 0.8× | 1.8% | PASS |
| file_reads | `oltp_distinct_range` | 3.56ms | 2.92ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_index_scan` | 8.39ms | 5.83ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 21.47ms | 15.53ms | 0.7× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 10.71ms | 5.78ms | 0.5× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 10.63ms | 8.17ms | 0.8× | 2.0% | PASS |
| file_reads | `groupby_scan` | 24.83ms | 23.77ms | 1.0× | 1.8% | PASS |
| file_reads | `index_join` | 12.70ms | 8.56ms | 0.7× | 4.5% | PASS |
| file_reads | `index_join_scan` | 3.60ms | 5.33ms | 1.5× | 3.5% | PASS |
| file_reads | `types_table_scan` | 741.67ms | 844.94ms | 1.1× | 3.2% | PASS |
| file_reads | `table_scan` | 961.48ms | 981.35ms | 1.0× | 4.6% | PASS |
| file_reads | `oltp_read_only` | 166.93ms | 103.70ms | 0.6× | 2.6% | PASS |
| file_writes | `oltp_bulk_insert` | 219.92ms | 279.01ms | 1.3× | 3.8% | PASS |
| file_writes | `oltp_insert` | 19.95ms | 46.11ms | 2.3× | 5.5% | FAIL |
| file_writes | `oltp_update_index` | 160.76ms | 170.34ms | 1.1× | 4.5% | PASS |
| file_writes | `oltp_update_non_index` | 131.55ms | 108.26ms | 0.8× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 171.84ms | 136.40ms | 0.8× | 2.9% | PASS |
| file_writes | `oltp_write_only` | 112.30ms | 88.35ms | 0.8× | 2.9% | PASS |
| file_writes | `types_delete_insert` | 133.35ms | 79.84ms | 0.6× | 5.4% | PASS |
| file_writes | `oltp_read_write` | 160.22ms | 137.92ms | 0.9× | 5.8% | PASS |
| ac_reads | `oltp_point_select` | 39.20ms | 36.89ms | 0.9× | 2.0% | PASS |
| ac_reads | `oltp_range_select` | 11.98ms | 10.99ms | 0.9× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 11.48ms | 10.54ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_order_range` | 2.50ms | 2.39ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 3.00ms | 2.87ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 4.42ms | 5.85ms | 1.3× | 1.3% | PASS |
| ac_reads | `select_random_points` | 16.53ms | 15.34ms | 0.9× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 6.33ms | 5.56ms | 0.9× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 6.01ms | 7.73ms | 1.3× | 2.1% | PASS |
| ac_reads | `groupby_scan` | 22.33ms | 22.35ms | 1.0× | 1.4% | PASS |
| ac_reads | `index_join` | 9.46ms | 7.84ms | 0.8× | 5.1% | PASS |
| ac_reads | `index_join_scan` | 3.20ms | 5.24ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 827.64ms | 916.37ms | 1.1× | 3.4% | PASS |
| ac_reads | `table_scan` | 1.05s | 1.04s | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_read_only` | 124.50ms | 106.59ms | 0.9× | 3.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.86ms | 57.39ms | 2.5× | 6.2% | PASS |
| ac_writes | `oltp_insert_ac` | 24.47ms | 64.12ms | 2.6× | 5.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.49ms | 78.34ms | 3.1× | 6.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.90ms | 62.24ms | 2.8× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.17ms | 70.79ms | 2.9× | 4.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.69ms | 68.74ms | 2.9× | 6.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.93ms | 63.23ms | 2.8× | 4.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.28ms | 75.42ms | 2.7× | 5.9% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 32.12ms | 33.14ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 13.57ms | 14.93ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_sum_range` | 13.15ms | 13.65ms | 1.0× | 0.6% | PASS |
| mem_reads | `oltp_order_range` | 2.90ms | 3.30ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 3.75ms | 4.33ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 3.57ms | 5.70ms | 1.6× | 1.3% | PASS |
| mem_reads | `select_random_points` | 20.51ms | 20.80ms | 1.0× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 5.57ms | 5.74ms | 1.0× | 1.0% | PASS |
| mem_reads | `covering_index_scan` | 6.24ms | 9.33ms | 1.5× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 32.62ms | 35.56ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 10.44ms | 9.94ms | 1.0× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 3.19ms | 6.28ms | 2.0× | 1.1% | PASS |
| mem_reads | `types_table_scan` | 1.04s | 1.30s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.42s | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 121.15ms | 134.36ms | 1.1× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 185.40ms | 278.75ms | 1.5× | 0.4% | PASS |
| mem_writes | `oltp_insert` | 15.28ms | 31.03ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 58.02ms | 122.28ms | 2.1× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 40.92ms | 64.81ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 46.07ms | 87.41ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 23.91ms | 45.41ms | 1.9× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 32.36ms | 48.29ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 80.28ms | 113.52ms | 1.4× | 1.1% | PASS |
| file_reads | `oltp_point_select` | 61.41ms | 38.86ms | 0.6× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 16.85ms | 15.77ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_sum_range` | 16.39ms | 14.58ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_order_range` | 3.33ms | 3.48ms | 1.0× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 4.19ms | 4.52ms | 1.1× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 6.92ms | 6.57ms | 0.9× | 1.2% | PASS |
| file_reads | `select_random_points` | 24.97ms | 22.13ms | 0.9× | 1.2% | PASS |
| file_reads | `select_random_ranges` | 8.94ms | 6.53ms | 0.7× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 9.53ms | 10.17ms | 1.1× | 0.9% | PASS |
| file_reads | `groupby_scan` | 33.19ms | 35.84ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 12.61ms | 10.56ms | 0.8× | 1.3% | PASS |
| file_reads | `index_join_scan` | 3.68ms | 6.52ms | 1.8× | 1.3% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.30s | 1.2× | 1.0% | PASS |
| file_reads | `table_scan` | 1.24s | 1.42s | 1.2× | 1.6% | PASS |
| file_reads | `oltp_read_only` | 165.79ms | 143.33ms | 0.9× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 255.21ms | 350.08ms | 1.4× | 2.8% | PASS |
| file_writes | `oltp_insert` | 29.74ms | 54.55ms | 1.8× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 164.99ms | 212.28ms | 1.3× | 3.2% | PASS |
| file_writes | `oltp_update_non_index` | 146.92ms | 124.22ms | 0.8× | 3.2% | PASS |
| file_writes | `oltp_delete_insert` | 163.66ms | 158.30ms | 1.0× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 120.75ms | 104.12ms | 0.9× | 5.2% | PASS |
| file_writes | `types_delete_insert` | 118.41ms | 93.22ms | 0.8× | 5.6% | PASS |
| file_writes | `oltp_read_write` | 177.35ms | 169.75ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_point_select` | 41.24ms | 38.78ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 14.83ms | 15.78ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_sum_range` | 14.47ms | 14.67ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_order_range` | 3.15ms | 3.47ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.02ms | 4.54ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 5.02ms | 6.63ms | 1.3× | 0.9% | PASS |
| ac_reads | `select_random_points` | 22.80ms | 22.00ms | 1.0× | 1.1% | PASS |
| ac_reads | `select_random_ranges` | 6.94ms | 6.51ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 7.43ms | 10.10ms | 1.4× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 32.59ms | 35.77ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 11.63ms | 10.60ms | 0.9× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.49ms | 6.53ms | 1.9× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.01s | 1.26s | 1.2× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.37s | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_read_only` | 129.29ms | 137.85ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 31.35ms | 79.30ms | 2.5× | 3.0% | PASS |
| ac_writes | `oltp_insert_ac` | 32.03ms | 89.91ms | 2.8× | 2.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 33.08ms | 101.98ms | 3.1× | 3.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 29.82ms | 84.18ms | 2.8× | 3.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 32.00ms | 93.19ms | 2.9× | 2.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 32.09ms | 94.18ms | 2.9× | 5.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 30.48ms | 93.97ms | 3.1× | 6.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 36.89ms | 105.95ms | 2.9× | 6.9% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 21.85ms | 24.65ms | 1.1× | 2.5% | PASS |
| mem_reads | `oltp_range_select` | 12.14ms | 12.88ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_sum_range` | 10.94ms | 12.47ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 2.29ms | 2.43ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_distinct_range` | 2.89ms | 2.97ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_index_scan` | 2.94ms | 4.10ms | 1.4× | 2.4% | PASS |
| mem_reads | `select_random_points` | 16.85ms | 19.45ms | 1.2× | 3.0% | PASS |
| mem_reads | `select_random_ranges` | 4.62ms | 5.35ms | 1.2× | 2.0% | PASS |
| mem_reads | `covering_index_scan` | 4.10ms | 6.23ms | 1.5× | 3.3% | PASS |
| mem_reads | `groupby_scan` | 22.86ms | 25.36ms | 1.1× | 1.4% | PASS |
| mem_reads | `index_join` | 4.93ms | 8.17ms | 1.7× | 3.9% | PASS |
| mem_reads | `index_join_scan` | 2.58ms | 4.65ms | 1.8× | 10.1% | PASS |
| mem_reads | `types_table_scan` | 702.82ms | 802.04ms | 1.1× | 1.3% | PASS |
| mem_reads | `table_scan` | 846.34ms | 928.02ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_read_only` | 77.81ms | 90.05ms | 1.2× | 2.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 139.88ms | 196.91ms | 1.4× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 10.71ms | 19.66ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_index` | 39.23ms | 74.17ms | 1.9× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 31.67ms | 52.64ms | 1.7× | 2.9% | PASS |
| mem_writes | `oltp_delete_insert` | 29.53ms | 56.59ms | 1.9× | 2.6% | PASS |
| mem_writes | `oltp_write_only` | 16.77ms | 36.06ms | 2.1× | 2.4% | PASS |
| mem_writes | `types_delete_insert` | 20.04ms | 32.39ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 56.89ms | 86.04ms | 1.5× | 3.5% | PASS |
| file_reads | `oltp_point_select` | 73.20ms | 37.87ms | 0.5× | 1.7% | PASS |
| file_reads | `oltp_range_select` | 17.90ms | 14.55ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 16.71ms | 14.16ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.00ms | 2.68ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.51ms | 3.16ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 8.96ms | 5.94ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 22.54ms | 20.60ms | 0.9× | 3.0% | PASS |
| file_reads | `select_random_ranges` | 9.91ms | 6.85ms | 0.7× | 2.0% | PASS |
| file_reads | `covering_index_scan` | 10.47ms | 8.13ms | 0.8× | 2.6% | PASS |
| file_reads | `groupby_scan` | 23.22ms | 25.28ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 8.36ms | 8.36ms | 1.0× | 4.4% | PASS |
| file_reads | `index_join_scan` | 3.50ms | 4.95ms | 1.4× | 6.1% | PASS |
| file_reads | `types_table_scan` | 732.66ms | 826.64ms | 1.1× | 2.2% | PASS |
| file_reads | `table_scan` | 818.37ms | 892.73ms | 1.1× | 2.6% | PASS |
| file_reads | `oltp_read_only` | 159.01ms | 115.06ms | 0.7× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 192.56ms | 252.46ms | 1.3× | 4.1% | PASS |
| file_writes | `oltp_insert` | 19.57ms | 30.34ms | 1.6× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 141.44ms | 132.30ms | 0.9× | 0.9% | PASS |
| file_writes | `oltp_update_non_index` | 120.99ms | 92.04ms | 0.8× | 1.8% | PASS |
| file_writes | `oltp_delete_insert` | 120.93ms | 110.29ms | 0.9× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 81.20ms | 79.49ms | 1.0× | 5.3% | PASS |
| file_writes | `types_delete_insert` | 75.50ms | 64.93ms | 0.9× | 7.1% | PASS |
| file_writes | `oltp_read_write` | 120.76ms | 123.55ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 35.61ms | 36.42ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 13.28ms | 13.71ms | 1.0× | 3.8% | PASS |
| ac_reads | `oltp_sum_range` | 12.37ms | 13.43ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 2.54ms | 2.55ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 3.04ms | 3.03ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.29ms | 5.82ms | 1.1× | 2.0% | PASS |
| ac_reads | `select_random_points` | 18.52ms | 20.30ms | 1.1× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 6.51ms | 6.76ms | 1.0× | 2.3% | PASS |
| ac_reads | `covering_index_scan` | 6.05ms | 7.46ms | 1.2× | 2.5% | PASS |
| ac_reads | `groupby_scan` | 21.91ms | 24.28ms | 1.1× | 2.2% | PASS |
| ac_reads | `index_join` | 6.02ms | 8.02ms | 1.3× | 3.0% | PASS |
| ac_reads | `index_join_scan` | 2.94ms | 4.73ms | 1.6× | 4.1% | PASS |
| ac_reads | `types_table_scan` | 689.24ms | 776.37ms | 1.1× | 1.1% | PASS |
| ac_reads | `table_scan` | 779.55ms | 863.09ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 99.84ms | 108.29ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.63ms | 51.80ms | 2.4× | 6.1% | PASS |
| ac_writes | `oltp_insert_ac` | 25.80ms | 61.52ms | 2.4× | 4.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.95ms | 68.78ms | 2.6× | 5.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.38ms | 56.19ms | 2.6× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.53ms | 62.25ms | 2.5× | 5.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.31ms | 61.57ms | 2.5× | 4.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 25.33ms | 60.41ms | 2.4× | 12.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.96ms | 67.88ms | 2.5× | 6.5% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 22s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 32.36ms | 38.00ms | 85.2% | 0.8% | PASS |
| `status_dirty_many_tables` | 36.53ms | 42.00ms | 87.0% | 0.7% | PASS |
| `diff_regular_working_one_table` | 28.16ms | 33.00ms | 85.3% | 0.9% | PASS |
| `diff_regular_working_many_tables` | 41.53ms | 50.00ms | 83.1% | 0.7% | PASS |
| `diff_stat_working_many_tables` | 41.80ms | 48.00ms | 87.1% | 0.7% | PASS |
| `diff_schema_working_many_tables` | 42.29ms | 48.00ms | 88.1% | 0.6% | PASS |
| `branch_list_many_branches` | 20.59ms | 25.00ms | 82.3% | 1.3% | PASS |
| `branch_create_delete` | 22.26ms | 27.00ms | 82.5% | 1.5% | PASS |
| `at_literal_deep_history` | 23.05ms | 28.00ms | 82.3% | 1.2% | PASS |
| `diff_literal_deep_history` | 22.89ms | 28.00ms | 81.8% | 1.2% | PASS |
| `history_literal_deep_history` | 24.17ms | 30.00ms | 80.6% | 0.8% | PASS |
| `checkout_branch_clean` | 31.15ms | 43.00ms | 72.4% | 1.1% | PASS |
| `merge_data_no_conflicts` | 25.73ms | 33.00ms | 78.0% | 1.3% | PASS |
| `merge_data_secondary_index` | 916.45ms | 944.00ms | 97.1% | 0.8% | PASS |
| `merge_schema_no_conflicts` | 18.23ms | 24.00ms | 76.0% | 1.0% | PASS |
| `merge_data_conflicts` | 28.44ms | 33.00ms | 86.2% | 0.5% | PASS |
| `merge_data_conflicts_with_resolve` | 29.42ms | 34.00ms | 86.5% | 0.6% | PASS |

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
| copy_fsync | candidate | 48.651 | 48.534–51.058 | 37.003 | 2055.46 | 107968266 |
| push_initial | candidate | 658.581 | 652.381–668.345 | 646.924 | 151.84 | 107956772 |
| clone_initial | candidate | 846.800 | 845.708–850.355 | 831.632 | 118.09 | 108475035 |
| push_noop | candidate | 0.708 | 0.666–0.779 | 0.456 | — | 0 |
| fetch_noop | candidate | 0.248 | 0.224–0.273 | 0.249 | — | 0 |
| push_incremental | candidate | 255.698 | 255.433–256.532 | 253.588 | 3.91 | 7909775 |
| fetch_incremental | candidate | 109.491 | 109.363–110.923 | 107.581 | 9.13 | 7910084 |
| pull_fast_forward | candidate | 95.852 | 94.980–96.812 | 93.929 | 10.43 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.43 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.78 | 294.999 | 109.784 | 47219 | 2337 |
| push_noop | candidate | 46.11 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 46.11 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.11 | 96.845 | 7.910 | 22406 | 125 |
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
| copy_fsync | candidate | 5423.682 | 5362.363–5437.978 | 320.689 | 184.38 | 1087718031 |
| push_initial | candidate | 9131.612 | 9097.909–9144.256 | 4093.981 | 109.51 | 1079566275 |
| clone_initial | candidate | 9501.481 | 9418.602–9543.882 | 5899.866 | 105.25 | 1102407326 |
| push_noop | candidate | 0.738 | 0.731–0.764 | 0.339 | — | 0 |
| fetch_noop | candidate | 0.164 | 0.148–0.189 | 0.156 | — | 0 |
| push_incremental | candidate | 948.896 | 943.475–965.702 | 902.841 | 1.05 | 15806003 |
| fetch_incremental | candidate | 257.386 | 238.932–293.102 | 194.410 | 3.89 | 15806513 |
| pull_fast_forward | candidate | 248.466 | 242.084–254.631 | 202.903 | 4.02 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.23 | 2091.276 | 1087.622 | 263351 | 20541 |
| clone_initial | candidate | 124.06 | 3520.418 | 1132.819 | 612912 | 32243 |
| push_noop | candidate | 47.21 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.21 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 618.129 | 15.928 | 150125 | 313 |
| fetch_incremental | candidate | 50.38 | 62.086 | 15.928 | 13859 | 313 |
| pull_fast_forward | candidate | 50.43 | 62.019 | 15.929 | 13855 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
