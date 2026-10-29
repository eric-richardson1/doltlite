# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-10-29 18:26 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu24 20261026.354.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/40910915850)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.58s | 10.94s | 1.1× | 1.4% | **PASS** |
| Writes | 1.92s | 3.18s | 1.7× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.36s | 11.04s | 1.1× | 1.3% | **PASS** |
| Writes | 3.61s | 4.05s | 1.1× | 2.8% | **PASS** |
| Autocommit writes | 754.55ms | 2.31s | 3.1× | 5.5% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.99s | 2.29s | 1.2× | 1.0% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 3.14s | 3.35s | 1.1× | 1.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 1.78s | 2.00s | 1.1× | 2.2% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.66s | 3.30s | 1.2× | 1.6% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 340.06ms | 572.47ms | 1.7× | 0.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 614.99ms | 997.06ms | 1.6× | 1.3% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 371.23ms | 594.59ms | 1.6× | 1.9% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 590.16ms | 1.01s | 1.7× | 1.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.20s | 2.34s | 1.1× | 1.1% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.46s | 3.44s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 1.80s | 1.90s | 1.1× | 1.7% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.90s | 3.36s | 1.2× | 1.3% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 864.10ms | 888.64ms | 1.0× | 4.9% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 964.12ms | 1.11s | 1.1× | 3.4% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 995.32ms | 973.02ms | 1.0× | 3.2% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 791.24ms | 1.09s | 1.4× | 1.4% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.07s | 2.34s | 1.1× | 0.8% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 3.29s | 3.46s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 1.70s | 1.90s | 1.1× | 2.9% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.76s | 3.37s | 1.2× | 1.4% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 171.30ms | 597.59ms | 3.5× | 18.6% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 151.16ms | 549.65ms | 3.6× | 4.8% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 228.52ms | 528.52ms | 2.3× | 6.0% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 203.57ms | 634.05ms | 3.1× | 5.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 18.72ms | 22.80ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 8.38ms | 9.67ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_sum_range` | 7.49ms | 9.28ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 2.14ms | 2.42ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 2.97ms | 3.27ms | 1.1× | 0.7% | PASS |
| mem_reads | `oltp_index_scan` | 3.01ms | 4.12ms | 1.4× | 1.3% | PASS |
| mem_reads | `select_random_points` | 8.18ms | 9.56ms | 1.2× | 1.7% | PASS |
| mem_reads | `select_random_ranges` | 3.57ms | 3.89ms | 1.1× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 5.81ms | 7.77ms | 1.3× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 25.08ms | 27.68ms | 1.1× | 0.5% | PASS |
| mem_reads | `index_join` | 4.50ms | 6.53ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 2.60ms | 4.77ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 852.84ms | 996.16ms | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 963.00ms | 1.09s | 1.1× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 79.69ms | 94.19ms | 1.2× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 137.00ms | 225.66ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.98ms | 19.98ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 39.78ms | 74.90ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 28.05ms | 47.74ms | 1.7× | 0.9% | PASS |
| mem_writes | `oltp_delete_insert` | 35.58ms | 59.18ms | 1.7× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 17.80ms | 37.28ms | 2.1× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 19.44ms | 26.37ms | 1.4× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 50.43ms | 81.34ms | 1.6× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 87.27ms | 39.27ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 15.40ms | 11.43ms | 0.7× | 1.8% | PASS |
| file_reads | `oltp_sum_range` | 14.56ms | 11.17ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 2.87ms | 2.65ms | 0.9× | 1.7% | PASS |
| file_reads | `oltp_distinct_range` | 3.68ms | 3.51ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 10.02ms | 6.13ms | 0.6× | 1.3% | PASS |
| file_reads | `select_random_points` | 15.19ms | 11.51ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 10.48ms | 5.67ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 13.08ms | 9.75ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 25.80ms | 27.95ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 8.35ms | 8.02ms | 1.0× | 1.2% | PASS |
| file_reads | `index_join_scan` | 3.43ms | 4.94ms | 1.4× | 1.6% | PASS |
| file_reads | `types_table_scan` | 851.95ms | 995.80ms | 1.2× | 0.5% | PASS |
| file_reads | `table_scan` | 964.66ms | 1.08s | 1.1× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 177.42ms | 117.57ms | 0.7× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 186.11ms | 278.82ms | 1.5× | 4.0% | PASS |
| file_writes | `oltp_insert` | 27.85ms | 31.38ms | 1.1× | 6.4% | PASS |
| file_writes | `oltp_update_index` | 138.82ms | 129.97ms | 0.9× | 3.6% | PASS |
| file_writes | `oltp_update_non_index` | 112.18ms | 89.09ms | 0.8× | 3.3% | PASS |
| file_writes | `oltp_delete_insert` | 118.78ms | 108.87ms | 0.9× | 5.8% | PASS |
| file_writes | `oltp_write_only` | 86.83ms | 74.43ms | 0.9× | 7.2% | PASS |
| file_writes | `types_delete_insert` | 72.59ms | 56.70ms | 0.8× | 7.1% | PASS |
| file_writes | `oltp_read_write` | 120.93ms | 119.39ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_point_select` | 41.80ms | 39.33ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 11.45ms | 11.44ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_sum_range` | 10.43ms | 11.14ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 2.58ms | 2.66ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.35ms | 3.51ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.76ms | 6.13ms | 1.1× | 0.9% | PASS |
| ac_reads | `select_random_points` | 11.19ms | 11.45ms | 1.0× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 6.21ms | 5.68ms | 0.9× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 8.65ms | 9.75ms | 1.1× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 25.53ms | 27.95ms | 1.1× | 0.6% | PASS |
| ac_reads | `index_join` | 6.20ms | 8.05ms | 1.3× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.05ms | 5.06ms | 1.7× | 1.2% | PASS |
| ac_reads | `types_table_scan` | 850.87ms | 995.26ms | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 966.28ms | 1.08s | 1.1× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 113.59ms | 117.84ms | 1.0× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.24ms | 56.04ms | 3.1× | 11.6% | PASS |
| ac_writes | `oltp_insert_ac` | 19.95ms | 68.87ms | 3.5× | 14.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.30ms | 85.81ms | 3.8× | 18.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.36ms | 68.61ms | 3.4× | 18.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.25ms | 78.05ms | 3.9× | 14.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.82ms | 87.27ms | 3.8× | 31.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.29ms | 69.44ms | 3.6× | 25.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.08ms | 83.50ms | 3.0× | 26.6% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 38.13ms | 37.88ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 18.96ms | 15.93ms | 0.8× | 1.1% | PASS |
| mem_reads | `oltp_sum_range` | 16.50ms | 15.35ms | 0.9× | 1.2% | PASS |
| mem_reads | `oltp_order_range` | 3.56ms | 3.54ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.62ms | 4.65ms | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 4.08ms | 6.49ms | 1.6× | 1.5% | PASS |
| mem_reads | `select_random_points` | 24.49ms | 22.22ms | 0.9× | 3.0% | PASS |
| mem_reads | `select_random_ranges` | 6.85ms | 6.46ms | 0.9× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 7.62ms | 10.69ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 37.54ms | 38.30ms | 1.0× | 0.6% | PASS |
| mem_reads | `index_join` | 11.69ms | 10.81ms | 0.9× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 4.06ms | 6.90ms | 1.7× | 1.5% | PASS |
| mem_reads | `types_table_scan` | 1.32s | 1.46s | 1.1× | 1.1% | PASS |
| mem_reads | `table_scan` | 1.50s | 1.56s | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 149.84ms | 145.76ms | 1.0× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 235.49ms | 356.13ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.04ms | 38.55ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 69.07ms | 146.48ms | 2.1× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 52.14ms | 82.89ms | 1.6× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 57.70ms | 110.18ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 30.85ms | 59.76ms | 1.9× | 1.7% | PASS |
| mem_writes | `types_delete_insert` | 42.59ms | 62.49ms | 1.5× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 109.11ms | 140.59ms | 1.3× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 130.12ms | 60.03ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 28.61ms | 18.16ms | 0.6× | 2.7% | PASS |
| file_reads | `oltp_sum_range` | 26.02ms | 17.69ms | 0.7× | 1.9% | PASS |
| file_reads | `oltp_order_range` | 4.57ms | 3.79ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.66ms | 4.90ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 13.57ms | 8.97ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_points` | 35.24ms | 25.21ms | 0.7× | 3.6% | PASS |
| file_reads | `select_random_ranges` | 16.20ms | 8.79ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 17.01ms | 12.93ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 39.04ms | 38.96ms | 1.0× | 0.6% | PASS |
| file_reads | `index_join` | 17.61ms | 12.47ms | 0.7× | 3.2% | PASS |
| file_reads | `index_join_scan` | 5.21ms | 7.26ms | 1.4× | 2.6% | PASS |
| file_reads | `types_table_scan` | 1.31s | 1.46s | 1.1× | 1.9% | PASS |
| file_reads | `table_scan` | 1.53s | 1.58s | 1.0× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 276.45ms | 175.87ms | 0.6× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 266.10ms | 373.87ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.98ms | 44.23ms | 1.7× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 138.90ms | 169.60ms | 1.2× | 4.4% | PASS |
| file_writes | `oltp_update_non_index` | 102.72ms | 97.35ms | 0.9× | 13.0% | PASS |
| file_writes | `oltp_delete_insert` | 101.23ms | 127.14ms | 1.3× | 2.5% | PASS |
| file_writes | `oltp_write_only` | 89.39ms | 72.10ms | 0.8× | 8.0% | PASS |
| file_writes | `types_delete_insert` | 77.11ms | 70.29ms | 0.9× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 162.68ms | 152.04ms | 0.9× | 11.3% | PASS |
| ac_reads | `oltp_point_select` | 68.11ms | 59.72ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 22.21ms | 18.26ms | 0.8× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 19.75ms | 17.76ms | 0.9× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 4.02ms | 3.79ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_distinct_range` | 5.10ms | 4.96ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 7.66ms | 9.02ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 29.72ms | 26.11ms | 0.9× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 10.29ms | 8.86ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 11.28ms | 13.06ms | 1.2× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 38.15ms | 39.06ms | 1.0× | 0.6% | PASS |
| ac_reads | `index_join` | 14.89ms | 12.66ms | 0.8× | 3.4% | PASS |
| ac_reads | `index_join_scan` | 4.72ms | 7.72ms | 1.6× | 4.9% | PASS |
| ac_reads | `types_table_scan` | 1.33s | 1.47s | 1.1× | 3.3% | PASS |
| ac_reads | `table_scan` | 1.52s | 1.58s | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_read_only` | 203.37ms | 184.16ms | 0.9× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 16.19ms | 51.89ms | 3.2× | 5.3% | PASS |
| ac_writes | `oltp_insert_ac` | 18.61ms | 64.62ms | 3.5× | 3.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 19.45ms | 83.14ms | 4.3× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 15.86ms | 60.63ms | 3.8× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.43ms | 75.26ms | 3.9× | 4.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.14ms | 71.30ms | 3.7× | 4.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 16.68ms | 62.05ms | 3.7× | 5.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.80ms | 80.77ms | 3.1× | 4.8% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.09ms | 23.87ms | 1.1× | 3.3% | PASS |
| mem_reads | `oltp_range_select` | 10.20ms | 9.86ms | 1.0× | 3.8% | PASS |
| mem_reads | `oltp_sum_range` | 10.37ms | 9.88ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 2.22ms | 2.21ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 2.79ms | 2.79ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 2.62ms | 4.57ms | 1.7× | 1.7% | PASS |
| mem_reads | `select_random_points` | 16.06ms | 15.40ms | 1.0× | 3.0% | PASS |
| mem_reads | `select_random_ranges` | 4.51ms | 4.26ms | 0.9× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 4.09ms | 6.44ms | 1.6× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 20.96ms | 21.28ms | 1.0× | 1.1% | PASS |
| mem_reads | `index_join` | 8.74ms | 8.86ms | 1.0× | 4.3% | PASS |
| mem_reads | `index_join_scan` | 2.98ms | 6.06ms | 2.0× | 5.7% | PASS |
| mem_reads | `types_table_scan` | 724.20ms | 850.78ms | 1.2× | 1.4% | PASS |
| mem_reads | `table_scan` | 864.80ms | 949.86ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_read_only` | 87.55ms | 84.26ms | 1.0× | 2.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 144.84ms | 213.79ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.22ms | 22.98ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 40.69ms | 85.54ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 30.89ms | 49.29ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 34.95ms | 66.75ms | 1.9× | 2.7% | PASS |
| mem_writes | `oltp_write_only` | 19.18ms | 36.03ms | 1.9× | 2.0% | PASS |
| mem_writes | `types_delete_insert` | 25.90ms | 36.69ms | 1.4× | 3.7% | PASS |
| mem_writes | `oltp_read_write` | 63.55ms | 83.53ms | 1.3× | 2.7% | PASS |
| file_reads | `oltp_point_select` | 79.14ms | 38.56ms | 0.5× | 1.8% | PASS |
| file_reads | `oltp_range_select` | 16.18ms | 11.12ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 15.21ms | 10.78ms | 0.7× | 2.1% | PASS |
| file_reads | `oltp_order_range` | 2.83ms | 2.38ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 3.31ms | 2.87ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 8.24ms | 5.88ms | 0.7× | 1.1% | PASS |
| file_reads | `select_random_points` | 21.68ms | 15.44ms | 0.7× | 4.5% | PASS |
| file_reads | `select_random_ranges` | 10.22ms | 5.65ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 10.11ms | 7.80ms | 0.8× | 1.7% | PASS |
| file_reads | `groupby_scan` | 21.20ms | 21.07ms | 1.0× | 1.0% | PASS |
| file_reads | `index_join` | 11.20ms | 8.12ms | 0.7× | 2.9% | PASS |
| file_reads | `index_join_scan` | 3.40ms | 5.12ms | 1.5× | 1.9% | PASS |
| file_reads | `types_table_scan` | 693.23ms | 814.80ms | 1.2× | 1.2% | PASS |
| file_reads | `table_scan` | 759.57ms | 860.04ms | 1.1× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 145.58ms | 93.49ms | 0.6× | 1.6% | PASS |
| file_writes | `oltp_bulk_insert` | 200.44ms | 264.48ms | 1.3× | 3.5% | PASS |
| file_writes | `oltp_insert` | 19.18ms | 41.84ms | 2.2× | 2.9% | PASS |
| file_writes | `oltp_update_index` | 141.20ms | 160.51ms | 1.1× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 120.69ms | 98.56ms | 0.8× | 2.6% | PASS |
| file_writes | `oltp_delete_insert` | 141.24ms | 127.04ms | 0.9× | 2.2% | PASS |
| file_writes | `oltp_write_only` | 110.42ms | 82.57ms | 0.7× | 4.7% | PASS |
| file_writes | `types_delete_insert` | 108.89ms | 69.48ms | 0.6× | 4.6% | PASS |
| file_writes | `oltp_read_write` | 153.26ms | 128.53ms | 0.8× | 5.4% | PASS |
| ac_reads | `oltp_point_select` | 39.82ms | 37.72ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 11.84ms | 10.58ms | 0.9× | 3.6% | PASS |
| ac_reads | `oltp_sum_range` | 10.90ms | 10.47ms | 1.0× | 3.4% | PASS |
| ac_reads | `oltp_order_range` | 2.43ms | 2.29ms | 0.9× | 2.9% | PASS |
| ac_reads | `oltp_distinct_range` | 2.90ms | 2.75ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_index_scan` | 4.44ms | 5.64ms | 1.3× | 2.6% | PASS |
| ac_reads | `select_random_points` | 16.79ms | 14.70ms | 0.9× | 4.5% | PASS |
| ac_reads | `select_random_ranges` | 6.10ms | 5.36ms | 0.9× | 3.2% | PASS |
| ac_reads | `covering_index_scan` | 5.92ms | 7.51ms | 1.3× | 2.5% | PASS |
| ac_reads | `groupby_scan` | 19.48ms | 19.88ms | 1.0× | 1.6% | PASS |
| ac_reads | `index_join` | 8.44ms | 7.78ms | 0.9× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 2.98ms | 4.93ms | 1.7× | 3.0% | PASS |
| ac_reads | `types_table_scan` | 684.07ms | 795.51ms | 1.2× | 1.4% | PASS |
| ac_reads | `table_scan` | 781.75ms | 879.53ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 104.49ms | 97.27ms | 0.9× | 3.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 27.09ms | 53.50ms | 2.0× | 8.6% | PASS |
| ac_writes | `oltp_insert_ac` | 29.93ms | 64.17ms | 2.1× | 6.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 29.95ms | 74.16ms | 2.5× | 5.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 25.45ms | 60.84ms | 2.4× | 7.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 29.97ms | 69.53ms | 2.3× | 5.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.46ms | 68.54ms | 2.3× | 8.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.06ms | 62.94ms | 2.7× | 5.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.61ms | 74.84ms | 2.2× | 5.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.49ms | 42.80ms | 1.3× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 19.80ms | 25.14ms | 1.3× | 2.1% | PASS |
| mem_reads | `oltp_sum_range` | 17.88ms | 22.42ms | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 3.56ms | 4.19ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.64ms | 5.38ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.54ms | 6.55ms | 1.4× | 1.8% | PASS |
| mem_reads | `select_random_points` | 28.50ms | 33.60ms | 1.2× | 2.4% | PASS |
| mem_reads | `select_random_ranges` | 7.66ms | 9.48ms | 1.2× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 7.57ms | 11.12ms | 1.5× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 35.80ms | 42.06ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 7.84ms | 12.16ms | 1.6× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.97ms | 6.54ms | 1.6× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 1.0% | PASS |
| mem_reads | `table_scan` | 1.26s | 1.48s | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 153.12ms | 186.66ms | 1.2× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 238.69ms | 364.51ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 18.57ms | 35.53ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 67.01ms | 132.94ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 51.65ms | 91.38ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 49.49ms | 101.88ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 27.13ms | 61.10ms | 2.3× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 32.78ms | 58.26ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 104.84ms | 167.50ms | 1.6× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 104.26ms | 61.08ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 27.49ms | 27.48ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_sum_range` | 25.69ms | 24.88ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.49ms | 4.50ms | 1.0× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.68ms | 5.72ms | 1.0× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 11.98ms | 8.64ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_points` | 37.72ms | 37.00ms | 1.0× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 15.23ms | 11.59ms | 0.8× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 15.39ms | 13.41ms | 0.9× | 0.8% | PASS |
| file_reads | `groupby_scan` | 36.88ms | 42.71ms | 1.2× | 0.9% | PASS |
| file_reads | `index_join` | 12.26ms | 13.57ms | 1.1× | 1.9% | PASS |
| file_reads | `index_join_scan` | 5.03ms | 7.06ms | 1.4× | 2.7% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.8% | PASS |
| file_reads | `table_scan` | 1.27s | 1.48s | 1.2× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 261.33ms | 218.41ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 255.26ms | 376.68ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 28.74ms | 39.41ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 98.59ms | 147.61ms | 1.5× | 1.6% | PASS |
| file_writes | `oltp_update_non_index` | 80.59ms | 98.41ms | 1.2× | 1.1% | PASS |
| file_writes | `oltp_delete_insert` | 81.57ms | 115.11ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 57.99ms | 68.17ms | 1.2× | 1.6% | PASS |
| file_writes | `types_delete_insert` | 51.26ms | 63.75ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 137.24ms | 176.18ms | 1.3× | 1.3% | PASS |
| ac_reads | `oltp_point_select` | 56.99ms | 61.07ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 22.66ms | 27.50ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 20.61ms | 24.95ms | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 4.52ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_distinct_range` | 5.04ms | 5.74ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 7.24ms | 8.58ms | 1.2× | 2.2% | PASS |
| ac_reads | `select_random_points` | 32.02ms | 37.07ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_ranges` | 10.23ms | 11.52ms | 1.1× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 10.38ms | 13.45ms | 1.3× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 36.41ms | 42.92ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 9.60ms | 13.58ms | 1.4× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 4.44ms | 7.03ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 1.4% | PASS |
| ac_reads | `table_scan` | 1.28s | 1.48s | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 190.09ms | 218.59ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.71ms | 64.88ms | 2.9× | 4.1% | PASS |
| ac_writes | `oltp_insert_ac` | 25.76ms | 80.40ms | 3.1× | 4.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.35ms | 91.44ms | 3.3× | 5.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.91ms | 72.96ms | 3.1× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.52ms | 81.13ms | 3.3× | 4.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.27ms | 82.14ms | 3.3× | 5.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.12ms | 73.14ms | 3.3× | 5.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.92ms | 87.96ms | 2.8× | 3.4% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 13s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 26.84ms | 38.00ms | 70.6% | 2.7% | PASS |
| `status_dirty_many_tables` | 29.06ms | 42.00ms | 69.2% | 2.6% | PASS |
| `diff_regular_working_one_table` | 22.38ms | 33.00ms | 67.8% | 2.7% | PASS |
| `diff_regular_working_many_tables` | 29.48ms | 50.00ms | 59.0% | 1.9% | PASS |
| `diff_stat_working_many_tables` | 30.28ms | 48.00ms | 63.1% | 1.9% | PASS |
| `diff_schema_working_many_tables` | 31.00ms | 48.00ms | 64.6% | 3.0% | PASS |
| `branch_list_many_branches` | 19.22ms | 25.00ms | 76.9% | 1.8% | PASS |
| `branch_create_delete` | 20.67ms | 27.00ms | 76.6% | 2.3% | PASS |
| `at_literal_deep_history` | 20.56ms | 28.00ms | 73.4% | 1.4% | PASS |
| `diff_literal_deep_history` | 20.61ms | 28.00ms | 73.6% | 1.7% | PASS |
| `history_literal_deep_history` | 20.85ms | 30.00ms | 69.5% | 2.2% | PASS |
| `checkout_branch_clean` | 25.85ms | 43.00ms | 60.1% | 3.0% | PASS |
| `merge_data_no_conflicts` | 22.07ms | 33.00ms | 66.9% | 1.5% | PASS |
| `merge_data_secondary_index` | 734.14ms | 944.00ms | 77.8% | 1.4% | PASS |
| `merge_schema_no_conflicts` | 16.67ms | 24.00ms | 69.5% | 2.0% | PASS |
| `merge_data_conflicts` | 23.70ms | 33.00ms | 71.8% | 2.1% | PASS |
| `merge_data_conflicts_with_resolve` | 24.28ms | 34.00ms | 71.4% | 1.9% | PASS |

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
| copy_fsync | candidate | 528.049 | 466.922–548.510 | 33.264 | 189.38 | 107968266 |
| push_initial | candidate | 780.399 | 772.303–788.661 | 412.494 | 128.14 | 107956772 |
| clone_initial | candidate | 1028.881 | 928.700–1049.910 | 519.421 | 97.19 | 108475035 |
| push_noop | candidate | 0.621 | 0.603–12.061 | 0.328 | — | 0 |
| fetch_noop | candidate | 0.167 | 0.152–0.213 | 0.171 | — | 0 |
| push_incremental | candidate | 178.943 | 175.846–189.197 | 160.023 | 5.59 | 7909775 |
| fetch_incremental | candidate | 86.747 | 84.718–88.328 | 67.770 | 11.53 | 7910084 |
| pull_fast_forward | candidate | 76.295 | 70.254–80.505 | 57.126 | 13.11 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.55 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.75 | 295.122 | 109.784 | 47248 | 2337 |
| push_noop | candidate | 42.20 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 42.20 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 42.20 | 97.017 | 7.910 | 22448 | 125 |
| fetch_incremental | candidate | 42.20 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 42.20 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2683.879 | 2671.052–2685.003 | 385.009 | 372.60 | 1087718031 |
| push_initial | candidate | 8119.584 | 8050.578–8144.838 | 5902.258 | 123.16 | 1079566275 |
| clone_initial | candidate | 8832.552 | 8827.831–8847.233 | 8595.808 | 113.22 | 1102407326 |
| push_noop | candidate | 0.911 | 0.821–0.935 | 0.364 | — | 0 |
| fetch_noop | candidate | 0.205 | 0.198–0.224 | 0.206 | — | 0 |
| push_incremental | candidate | 1323.060 | 1311.345–1332.792 | 1317.456 | 0.76 | 15806003 |
| fetch_incremental | candidate | 269.749 | 269.516–273.734 | 263.926 | 3.71 | 15806513 |
| pull_fast_forward | candidate | 276.317 | 272.175–276.330 | 269.726 | 3.62 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.67 | 2091.539 | 1087.622 | 263415 | 20541 |
| clone_initial | candidate | 123.89 | 3519.749 | 1132.819 | 612831 | 32243 |
| push_noop | candidate | 44.71 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 44.71 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.23 | 618.407 | 15.928 | 150229 | 313 |
| fetch_incremental | candidate | 50.29 | 62.396 | 15.928 | 13935 | 313 |
| pull_fast_forward | candidate | 50.23 | 62.329 | 15.929 | 13931 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
