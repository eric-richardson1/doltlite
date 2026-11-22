# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-22 19:18 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/45048783653)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.48s | 10.67s | 1.1× | 2.0% | **PASS** |
| Writes | 1.81s | 3.04s | 1.7× | 1.6% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.86s | 10.77s | 1.1× | 1.6% | **PASS** |
| Writes | 3.63s | 4.05s | 1.1× | 4.4% | **PASS** |
| Autocommit writes | 902.94ms | 2.93s | 3.2× | 10.5% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.44s | 2.88s | 1.2× | 1.5% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.82s | 3.34s | 1.2× | 1.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.26s | 2.48s | 1.1× | 2.5% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.96s | 1.97s | 1.0× | 4.7% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 420.33ms | 750.97ms | 1.8× | 1.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 578.67ms | 988.57ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 455.74ms | 719.51ms | 1.6× | 2.4% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 358.57ms | 583.35ms | 1.6× | 4.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.66s | 2.94s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.90s | 3.37s | 1.2× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.31s | 2.46s | 1.1× | 1.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.99s | 2.00s | 1.0× | 12.2% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 575.80ms | 811.62ms | 1.4× | 1.4% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 939.20ms | 1.11s | 1.2× | 3.6% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.13s | 1.14s | 1.0× | 4.4% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 987.19ms | 983.67ms | 1.0× | 9.0% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.51s | 2.94s | 1.2× | 1.4% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.88s | 3.39s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.24s | 2.50s | 1.1× | 1.2% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.84s | 2.02s | 1.1× | 12.9% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 178.26ms | 587.97ms | 3.3× | 4.9% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 205.07ms | 655.87ms | 3.2× | 6.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 209.00ms | 562.25ms | 2.7× | 14.8% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 310.61ms | 1.13s | 3.6× | 23.7% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.04ms | 30.83ms | 1.3× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 10.99ms | 12.78ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_sum_range` | 9.75ms | 12.17ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 2.63ms | 3.09ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 3.57ms | 4.31ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 3.73ms | 5.49ms | 1.5× | 1.5% | PASS |
| mem_reads | `select_random_points` | 10.21ms | 11.65ms | 1.1× | 2.7% | PASS |
| mem_reads | `select_random_ranges` | 4.52ms | 5.29ms | 1.2× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 7.89ms | 10.69ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 30.56ms | 36.01ms | 1.2× | 0.8% | PASS |
| mem_reads | `index_join` | 5.70ms | 8.68ms | 1.5× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 3.23ms | 5.55ms | 1.7× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.35s | 1.2× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 101.90ms | 127.81ms | 1.3× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 170.45ms | 294.95ms | 1.7× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 14.56ms | 26.40ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 48.61ms | 94.84ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 33.20ms | 62.45ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 42.48ms | 76.16ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 20.98ms | 47.31ms | 2.3× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 23.83ms | 37.41ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 66.22ms | 111.44ms | 1.7× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 90.87ms | 48.26ms | 0.5× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 18.14ms | 14.60ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_sum_range` | 17.04ms | 14.02ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.51ms | 3.33ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.45ms | 4.56ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 10.96ms | 7.60ms | 0.7× | 1.8% | PASS |
| file_reads | `select_random_points` | 17.45ms | 13.59ms | 0.8× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 11.69ms | 7.20ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.43ms | 12.78ms | 0.8× | 0.9% | PASS |
| file_reads | `groupby_scan` | 31.80ms | 36.35ms | 1.1× | 0.5% | PASS |
| file_reads | `index_join` | 9.87ms | 10.08ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.19ms | 5.89ms | 1.4× | 1.7% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.17s | 1.35s | 1.2× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 201.52ms | 154.96ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 182.20ms | 307.76ms | 1.7× | 1.0% | PASS |
| file_writes | `oltp_insert` | 21.50ms | 29.89ms | 1.4× | 2.1% | PASS |
| file_writes | `oltp_update_index` | 76.09ms | 104.28ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_update_non_index` | 56.80ms | 68.97ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 66.12ms | 87.32ms | 1.3× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 43.84ms | 53.09ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 39.18ms | 43.72ms | 1.1× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 90.07ms | 116.59ms | 1.3× | 1.4% | PASS |
| ac_reads | `oltp_point_select` | 44.70ms | 48.96ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 13.20ms | 14.70ms | 1.1× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 11.96ms | 14.08ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 2.99ms | 3.34ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.92ms | 4.59ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_index_scan` | 6.08ms | 7.62ms | 1.3× | 1.4% | PASS |
| ac_reads | `select_random_points` | 12.37ms | 13.63ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 6.82ms | 7.24ms | 1.1× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 10.34ms | 12.88ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 31.18ms | 36.32ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 7.05ms | 10.23ms | 1.4× | 1.7% | PASS |
| ac_reads | `index_join_scan` | 3.64ms | 5.89ms | 1.6× | 1.5% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.17s | 1.35s | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 134.24ms | 155.28ms | 1.2× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.53ms | 60.99ms | 3.0× | 5.0% | PASS |
| ac_writes | `oltp_insert_ac` | 22.67ms | 73.19ms | 3.2× | 5.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.07ms | 85.58ms | 3.6× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.75ms | 66.66ms | 3.4× | 4.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.83ms | 76.42ms | 3.5× | 3.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.17ms | 75.93ms | 3.4× | 5.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.02ms | 67.75ms | 3.4× | 7.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.23ms | 81.45ms | 3.0× | 4.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 37.81ms | 42.34ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 16.96ms | 17.26ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 15.30ms | 16.46ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.38ms | 3.64ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.35ms | 4.85ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.01ms | 6.84ms | 1.7× | 1.3% | PASS |
| mem_reads | `select_random_points` | 22.13ms | 23.30ms | 1.1× | 3.8% | PASS |
| mem_reads | `select_random_ranges` | 6.91ms | 7.12ms | 1.0× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 8.07ms | 11.29ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 34.50ms | 38.71ms | 1.1× | 1.0% | PASS |
| mem_reads | `index_join` | 10.66ms | 10.84ms | 1.0× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.69ms | 6.69ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.18s | 1.45s | 1.2× | 3.2% | PASS |
| mem_reads | `table_scan` | 1.34s | 1.55s | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_read_only` | 137.28ms | 154.77ms | 1.1× | 1.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 232.50ms | 361.23ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.52ms | 37.24ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 67.23ms | 145.40ms | 2.2× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 48.25ms | 83.43ms | 1.7× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 53.01ms | 104.72ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 27.35ms | 55.56ms | 2.0× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 37.65ms | 60.25ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 95.17ms | 140.74ms | 1.5× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 105.30ms | 59.45ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 24.52ms | 19.03ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 23.15ms | 18.55ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 4.33ms | 3.91ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 5.35ms | 5.11ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_index_scan` | 11.36ms | 8.82ms | 0.8× | 1.1% | PASS |
| file_reads | `select_random_points` | 31.30ms | 26.07ms | 0.8× | 2.1% | PASS |
| file_reads | `select_random_ranges` | 14.27ms | 9.14ms | 0.6× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.78ms | 13.42ms | 0.9× | 1.4% | PASS |
| file_reads | `groupby_scan` | 35.89ms | 39.18ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.94ms | 12.12ms | 0.8× | 2.4% | PASS |
| file_reads | `index_join_scan` | 4.79ms | 7.10ms | 1.5× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 1.7% | PASS |
| file_reads | `table_scan` | 1.27s | 1.54s | 1.2× | 3.1% | PASS |
| file_reads | `oltp_read_only` | 251.06ms | 187.12ms | 0.7× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 259.24ms | 379.42ms | 1.5× | 1.0% | PASS |
| file_writes | `oltp_insert` | 26.13ms | 43.31ms | 1.7× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 136.20ms | 171.01ms | 1.3× | 6.8% | PASS |
| file_writes | `oltp_update_non_index` | 104.38ms | 99.03ms | 0.9× | 11.8% | PASS |
| file_writes | `oltp_delete_insert` | 97.58ms | 122.48ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 91.44ms | 69.86ms | 0.8× | 12.3% | PASS |
| file_writes | `types_delete_insert` | 72.95ms | 70.41ms | 1.0× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 151.27ms | 154.99ms | 1.0× | 5.1% | PASS |
| ac_reads | `oltp_point_select` | 58.08ms | 59.63ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 19.70ms | 19.06ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 17.71ms | 18.37ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_order_range` | 3.77ms | 3.90ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.75ms | 5.12ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.61ms | 8.82ms | 1.3× | 1.5% | PASS |
| ac_reads | `select_random_points` | 26.37ms | 26.36ms | 1.0× | 3.7% | PASS |
| ac_reads | `select_random_ranges` | 9.44ms | 9.21ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.96ms | 13.45ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 35.45ms | 39.28ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 13.21ms | 12.33ms | 0.9× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 4.43ms | 7.21ms | 1.6× | 3.2% | PASS |
| ac_reads | `types_table_scan` | 1.12s | 1.43s | 1.3× | 2.9% | PASS |
| ac_reads | `table_scan` | 1.36s | 1.56s | 1.1× | 2.5% | PASS |
| ac_reads | `oltp_read_only` | 179.71ms | 187.28ms | 1.0× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.17ms | 65.28ms | 2.8× | 7.7% | PASS |
| ac_writes | `oltp_insert_ac` | 25.79ms | 78.40ms | 3.0× | 5.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.88ms | 95.05ms | 3.5× | 5.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.60ms | 76.74ms | 3.4× | 7.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.61ms | 87.59ms | 3.4× | 11.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.43ms | 83.90ms | 3.3× | 6.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.33ms | 76.47ms | 3.3× | 9.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.26ms | 92.44ms | 2.9× | 6.1% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 29.27ms | 30.31ms | 1.0× | 3.0% | PASS |
| mem_reads | `oltp_range_select` | 14.50ms | 12.59ms | 0.9× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 13.15ms | 11.92ms | 0.9× | 4.0% | PASS |
| mem_reads | `oltp_order_range` | 2.81ms | 2.82ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.60ms | 3.66ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.29ms | 5.39ms | 1.6× | 1.8% | PASS |
| mem_reads | `select_random_points` | 17.99ms | 17.25ms | 1.0× | 2.8% | PASS |
| mem_reads | `select_random_ranges` | 5.58ms | 5.22ms | 0.9× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.25ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 29.16ms | 29.85ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 9.41ms | 8.98ms | 1.0× | 3.5% | PASS |
| mem_reads | `index_join_scan` | 3.28ms | 5.72ms | 1.7× | 2.5% | PASS |
| mem_reads | `types_table_scan` | 931.87ms | 1.07s | 1.1× | 2.4% | PASS |
| mem_reads | `table_scan` | 1.08s | 1.16s | 1.1× | 3.4% | PASS |
| mem_reads | `oltp_read_only` | 115.27ms | 114.26ms | 1.0× | 3.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.16ms | 261.08ms | 1.5× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 14.05ms | 27.69ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 52.63ms | 106.13ms | 2.0× | 2.5% | PASS |
| mem_writes | `oltp_update_non_index` | 38.88ms | 58.86ms | 1.5× | 2.3% | PASS |
| mem_writes | `oltp_delete_insert` | 42.71ms | 78.44ms | 1.8× | 2.1% | PASS |
| mem_writes | `oltp_write_only` | 23.58ms | 42.94ms | 1.8× | 2.9% | PASS |
| mem_writes | `types_delete_insert` | 30.91ms | 43.55ms | 1.4× | 3.3% | PASS |
| mem_writes | `oltp_read_write` | 75.82ms | 100.81ms | 1.3× | 3.1% | PASS |
| file_reads | `oltp_point_select` | 96.09ms | 45.81ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 21.01ms | 14.36ms | 0.7× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 19.65ms | 13.55ms | 0.7× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.55ms | 3.05ms | 0.9× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.39ms | 3.83ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 10.26ms | 6.91ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 24.30ms | 18.58ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 12.33ms | 6.86ms | 0.6× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.16ms | 9.90ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 29.46ms | 29.90ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 12.64ms | 9.54ms | 0.8× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.03ms | 5.67ms | 1.4× | 1.5% | PASS |
| file_reads | `types_table_scan` | 873.69ms | 1.04s | 1.2× | 0.8% | PASS |
| file_reads | `table_scan` | 976.57ms | 1.12s | 1.2× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 207.19ms | 135.03ms | 0.7× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 244.70ms | 325.39ms | 1.3× | 3.1% | PASS |
| file_writes | `oltp_insert` | 23.23ms | 46.48ms | 2.0× | 9.8% | PASS |
| file_writes | `oltp_update_index` | 151.31ms | 182.99ms | 1.2× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 130.58ms | 115.41ms | 0.9× | 4.4% | PASS |
| file_writes | `oltp_delete_insert` | 160.33ms | 145.54ms | 0.9× | 4.4% | PASS |
| file_writes | `oltp_write_only` | 113.42ms | 88.81ms | 0.8× | 4.0% | PASS |
| file_writes | `types_delete_insert` | 124.50ms | 80.11ms | 0.6× | 12.7% | PASS |
| file_writes | `oltp_read_write` | 180.38ms | 157.57ms | 0.9× | 10.5% | PASS |
| ac_reads | `oltp_point_select` | 51.14ms | 47.18ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 17.95ms | 14.87ms | 0.8× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 16.19ms | 14.12ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_order_range` | 3.21ms | 3.08ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.98ms | 3.85ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.74ms | 6.98ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 21.46ms | 19.74ms | 0.9× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 7.83ms | 6.90ms | 0.9× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 8.55ms | 9.89ms | 1.2× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 29.14ms | 29.90ms | 1.0× | 0.8% | PASS |
| ac_reads | `index_join` | 10.82ms | 9.63ms | 0.9× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 3.65ms | 5.72ms | 1.6× | 1.4% | PASS |
| ac_reads | `types_table_scan` | 911.30ms | 1.06s | 1.2× | 2.3% | PASS |
| ac_reads | `table_scan` | 1.01s | 1.14s | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_read_only` | 137.93ms | 135.17ms | 1.0× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.68ms | 54.45ms | 2.2× | 14.8% | PASS |
| ac_writes | `oltp_insert_ac` | 27.59ms | 75.41ms | 2.7× | 34.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 29.39ms | 80.48ms | 2.7× | 12.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.62ms | 65.42ms | 2.9× | 14.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.98ms | 76.43ms | 2.7× | 30.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 26.91ms | 73.91ms | 2.7× | 23.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.12ms | 62.24ms | 3.3× | 12.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.71ms | 73.92ms | 2.4× | 6.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 21.77ms | 24.47ms | 1.1× | 5.6% | PASS |
| mem_reads | `oltp_range_select` | 11.44ms | 13.06ms | 1.1× | 5.9% | PASS |
| mem_reads | `oltp_sum_range` | 10.71ms | 12.15ms | 1.1× | 4.0% | PASS |
| mem_reads | `oltp_order_range` | 2.34ms | 2.54ms | 1.1× | 4.3% | PASS |
| mem_reads | `oltp_distinct_range` | 2.77ms | 2.86ms | 1.0× | 3.1% | PASS |
| mem_reads | `oltp_index_scan` | 2.89ms | 4.30ms | 1.5× | 3.5% | PASS |
| mem_reads | `select_random_points` | 16.87ms | 19.66ms | 1.2× | 4.7% | PASS |
| mem_reads | `select_random_ranges` | 4.45ms | 5.17ms | 1.2× | 3.1% | PASS |
| mem_reads | `covering_index_scan` | 3.90ms | 6.27ms | 1.6× | 4.8% | PASS |
| mem_reads | `groupby_scan` | 21.56ms | 22.93ms | 1.1× | 3.8% | PASS |
| mem_reads | `index_join` | 4.66ms | 7.49ms | 1.6× | 8.1% | PASS |
| mem_reads | `index_join_scan` | 2.85ms | 5.06ms | 1.8× | 6.2% | PASS |
| mem_reads | `types_table_scan` | 754.51ms | 821.67ms | 1.1× | 5.6% | PASS |
| mem_reads | `table_scan` | 1.01s | 923.96ms | 0.9× | 6.2% | PASS |
| mem_reads | `oltp_read_only` | 93.29ms | 97.86ms | 1.0× | 4.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 139.40ms | 199.16ms | 1.4× | 1.6% | PASS |
| mem_writes | `oltp_insert` | 10.60ms | 19.99ms | 1.9× | 2.8% | PASS |
| mem_writes | `oltp_update_index` | 41.98ms | 80.65ms | 1.9× | 4.3% | PASS |
| mem_writes | `oltp_update_non_index` | 33.81ms | 55.66ms | 1.6× | 4.1% | PASS |
| mem_writes | `oltp_delete_insert` | 32.23ms | 62.52ms | 1.9× | 4.4% | PASS |
| mem_writes | `oltp_write_only` | 17.93ms | 39.18ms | 2.2× | 4.8% | PASS |
| mem_writes | `types_delete_insert` | 21.26ms | 34.28ms | 1.6× | 4.2% | PASS |
| mem_writes | `oltp_read_write` | 61.36ms | 91.92ms | 1.5× | 5.4% | PASS |
| file_reads | `oltp_point_select` | 84.63ms | 46.43ms | 0.5× | 9.5% | PASS |
| file_reads | `oltp_range_select` | 21.89ms | 16.67ms | 0.8× | 12.2% | PASS |
| file_reads | `oltp_sum_range` | 22.38ms | 17.46ms | 0.8× | 18.6% | PASS |
| file_reads | `oltp_order_range` | 3.35ms | 2.99ms | 0.9× | 17.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.77ms | 3.23ms | 0.9× | 13.3% | PASS |
| file_reads | `oltp_index_scan` | 9.91ms | 6.97ms | 0.7× | 11.6% | PASS |
| file_reads | `select_random_points` | 29.29ms | 27.30ms | 0.9× | 13.5% | PASS |
| file_reads | `select_random_ranges` | 12.03ms | 8.02ms | 0.7× | 11.8% | PASS |
| file_reads | `covering_index_scan` | 11.65ms | 9.25ms | 0.8× | 13.5% | PASS |
| file_reads | `groupby_scan` | 27.02ms | 30.62ms | 1.1× | 10.7% | PASS |
| file_reads | `index_join` | 10.33ms | 11.46ms | 1.1× | 15.7% | PASS |
| file_reads | `index_join_scan` | 4.25ms | 6.30ms | 1.5× | 23.6% | PASS |
| file_reads | `types_table_scan` | 738.49ms | 811.83ms | 1.1× | 3.9% | PASS |
| file_reads | `table_scan` | 835.09ms | 876.09ms | 1.0× | 5.1% | PASS |
| file_reads | `oltp_read_only` | 172.99ms | 126.55ms | 0.7× | 9.7% | PASS |
| file_writes | `oltp_bulk_insert` | 209.05ms | 259.00ms | 1.2× | 9.0% | PASS |
| file_writes | `oltp_insert` | 28.01ms | 38.81ms | 1.4× | 16.1% | PASS |
| file_writes | `oltp_update_index` | 158.55ms | 151.48ms | 1.0× | 13.1% | PASS |
| file_writes | `oltp_update_non_index` | 134.22ms | 107.47ms | 0.8× | 6.6% | PASS |
| file_writes | `oltp_delete_insert` | 134.57ms | 124.24ms | 0.9× | 7.9% | PASS |
| file_writes | `oltp_write_only` | 100.00ms | 88.05ms | 0.9× | 8.4% | PASS |
| file_writes | `types_delete_insert` | 82.95ms | 73.01ms | 0.9× | 9.0% | PASS |
| file_writes | `oltp_read_write` | 139.84ms | 141.61ms | 1.0× | 11.9% | PASS |
| ac_reads | `oltp_point_select` | 43.18ms | 43.59ms | 1.0× | 9.3% | PASS |
| ac_reads | `oltp_range_select` | 15.75ms | 16.23ms | 1.0× | 11.1% | PASS |
| ac_reads | `oltp_sum_range` | 14.72ms | 15.50ms | 1.1× | 13.1% | PASS |
| ac_reads | `oltp_order_range` | 3.20ms | 2.85ms | 0.9× | 16.6% | PASS |
| ac_reads | `oltp_distinct_range` | 3.53ms | 3.26ms | 0.9× | 19.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.25ms | 6.60ms | 1.1× | 15.7% | PASS |
| ac_reads | `select_random_points` | 23.95ms | 26.10ms | 1.1× | 15.4% | PASS |
| ac_reads | `select_random_ranges` | 6.92ms | 7.69ms | 1.1× | 12.8% | PASS |
| ac_reads | `covering_index_scan` | 7.50ms | 9.33ms | 1.2× | 10.2% | PASS |
| ac_reads | `groupby_scan` | 26.48ms | 27.58ms | 1.0× | 8.0% | PASS |
| ac_reads | `index_join` | 7.54ms | 11.24ms | 1.5× | 17.1% | PASS |
| ac_reads | `index_join_scan` | 3.56ms | 6.44ms | 1.8× | 19.9% | PASS |
| ac_reads | `types_table_scan` | 735.81ms | 820.05ms | 1.1× | 2.9% | PASS |
| ac_reads | `table_scan` | 818.79ms | 890.07ms | 1.1× | 4.1% | PASS |
| ac_reads | `oltp_read_only` | 118.49ms | 129.61ms | 1.1× | 12.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 37.22ms | 119.34ms | 3.2× | 39.3% | PASS |
| ac_writes | `oltp_insert_ac` | 36.57ms | 130.13ms | 3.6× | 24.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 40.26ms | 158.75ms | 3.9× | 25.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 36.55ms | 121.30ms | 3.3× | 20.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 40.26ms | 156.41ms | 3.9× | 23.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 34.80ms | 137.86ms | 4.0× | 22.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 37.29ms | 152.93ms | 4.1× | 28.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 47.65ms | 149.76ms | 3.1× | 17.0% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 51s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 29.27ms | 38.00ms | 77.0% | 1.4% | PASS |
| `status_dirty_many_tables` | 32.50ms | 42.00ms | 77.4% | 1.1% | PASS |
| `diff_regular_working_one_table` | 24.61ms | 33.00ms | 74.6% | 1.8% | PASS |
| `diff_regular_working_many_tables` | 36.12ms | 50.00ms | 72.2% | 1.3% | PASS |
| `diff_stat_working_many_tables` | 36.19ms | 48.00ms | 75.4% | 1.0% | PASS |
| `diff_schema_working_many_tables` | 36.78ms | 48.00ms | 76.6% | 1.3% | PASS |
| `branch_list_many_branches` | 17.25ms | 25.00ms | 69.0% | 1.4% | PASS |
| `branch_create_delete` | 18.91ms | 27.00ms | 70.0% | 1.6% | PASS |
| `at_literal_deep_history` | 18.62ms | 28.00ms | 66.5% | 1.4% | PASS |
| `diff_literal_deep_history` | 18.67ms | 28.00ms | 66.7% | 1.5% | PASS |
| `history_literal_deep_history` | 19.41ms | 30.00ms | 64.7% | 1.4% | PASS |
| `checkout_branch_clean` | 28.29ms | 43.00ms | 65.8% | 1.3% | PASS |
| `merge_data_no_conflicts` | 21.02ms | 33.00ms | 63.7% | 1.4% | PASS |
| `merge_data_secondary_index` | 842.11ms | 944.00ms | 89.2% | 0.6% | PASS |
| `merge_schema_no_conflicts` | 16.62ms | 24.00ms | 69.2% | 1.5% | PASS |
| `merge_data_conflicts` | 23.31ms | 33.00ms | 70.6% | 1.1% | PASS |
| `merge_data_conflicts_with_resolve` | 24.62ms | 34.00ms | 72.4% | 1.2% | PASS |

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
| copy_fsync | candidate | 465.787 | 463.766–752.919 | 36.674 | 214.69 | 107968266 |
| push_initial | candidate | 846.460 | 845.513–860.045 | 423.406 | 118.14 | 107956772 |
| clone_initial | candidate | 970.624 | 967.345–975.533 | 545.268 | 103.03 | 108475035 |
| push_noop | candidate | 0.888 | 0.821–0.922 | 0.412 | — | 0 |
| fetch_noop | candidate | 0.128 | 0.124–0.141 | 0.130 | — | 0 |
| push_incremental | candidate | 201.098 | 200.576–202.393 | 169.630 | 4.97 | 7909775 |
| fetch_incremental | candidate | 106.299 | 103.848–106.869 | 73.796 | 9.41 | 7910084 |
| pull_fast_forward | candidate | 98.092 | 96.037–100.872 | 65.971 | 10.19 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.78 | 295.107 | 109.784 | 47244 | 2337 |
| push_noop | candidate | 45.95 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.95 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.95 | 96.793 | 7.910 | 22393 | 125 |
| fetch_incremental | candidate | 45.95 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.95 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2642.223 | 2632.040–2651.271 | 371.768 | 378.47 | 1087718031 |
| push_initial | candidate | 7910.453 | 7887.689–7953.046 | 5703.044 | 126.42 | 1079566275 |
| clone_initial | candidate | 8635.858 | 8595.398–8645.799 | 8405.790 | 115.80 | 1102407326 |
| push_noop | candidate | 0.718 | 0.696–0.823 | 0.372 | — | 0 |
| fetch_noop | candidate | 0.201 | 0.195–0.205 | 0.206 | — | 0 |
| push_incremental | candidate | 1278.041 | 1268.825–1280.797 | 1273.083 | 0.78 | 15806003 |
| fetch_incremental | candidate | 265.752 | 265.155–267.239 | 260.564 | 3.76 | 15806513 |
| pull_fast_forward | candidate | 263.076 | 260.535–263.581 | 258.015 | 3.80 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.76 | 2092.011 | 1087.622 | 263530 | 20541 |
| clone_initial | candidate | 123.93 | 3514.228 | 1132.819 | 611474 | 32243 |
| push_noop | candidate | 47.00 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.00 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 615.593 | 15.928 | 149542 | 313 |
| fetch_incremental | candidate | 50.37 | 62.635 | 15.928 | 13993 | 313 |
| pull_fast_forward | candidate | 50.35 | 62.568 | 15.929 | 13989 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
