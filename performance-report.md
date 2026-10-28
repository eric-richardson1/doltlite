# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-10-28 18:13 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu24 20261026.354.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/40723832895)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.57s | 12.61s | 1.2× | 1.5% | **PASS** |
| Writes | 2.19s | 3.74s | 1.7× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 11.38s | 12.82s | 1.1× | 1.4% | **PASS** |
| Writes | 3.46s | 4.30s | 1.2× | 1.5% | **PASS** |
| Autocommit writes | 833.07ms | 2.61s | 3.1× | 5.3% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.37s | 2.74s | 1.2× | 1.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 3.00s | 3.36s | 1.1× | 1.5% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.52s | 3.21s | 1.3× | 1.8% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.68s | 3.31s | 1.2× | 1.5% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 362.97ms | 635.17ms | 1.7× | 1.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 636.16ms | 1.07s | 1.7× | 2.1% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 596.48ms | 1.01s | 1.7× | 1.5% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 589.40ms | 1.02s | 1.7× | 1.1% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.52s | 2.78s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.27s | 3.40s | 1.0× | 1.4% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.81s | 3.30s | 1.2× | 2.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.78s | 3.33s | 1.2× | 1.3% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 937.74ms | 998.04ms | 1.1× | 1.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 960.89ms | 1.14s | 1.2× | 3.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 803.79ms | 1.09s | 1.4× | 1.6% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 753.70ms | 1.07s | 1.4× | 1.1% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.40s | 2.75s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.93s | 3.35s | 1.1× | 2.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.57s | 3.24s | 1.3× | 1.7% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.61s | 3.33s | 1.3× | 1.0% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 237.90ms | 692.02ms | 2.9× | 3.4% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 214.68ms | 684.22ms | 3.2× | 8.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 198.99ms | 641.62ms | 3.2× | 6.1% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 181.51ms | 588.32ms | 3.2× | 4.1% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 21.10ms | 25.89ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_range_select` | 9.57ms | 12.18ms | 1.3× | 1.1% | PASS |
| mem_reads | `oltp_sum_range` | 8.63ms | 11.11ms | 1.3× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 2.46ms | 2.95ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_distinct_range` | 3.33ms | 4.03ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 3.46ms | 4.59ms | 1.3× | 1.6% | PASS |
| mem_reads | `select_random_points` | 9.75ms | 11.54ms | 1.2× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 3.98ms | 4.37ms | 1.1× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 6.45ms | 9.27ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 29.32ms | 33.23ms | 1.1× | 0.4% | PASS |
| mem_reads | `index_join` | 5.17ms | 8.07ms | 1.6× | 1.6% | PASS |
| mem_reads | `index_join_scan` | 2.80ms | 5.33ms | 1.9× | 2.3% | PASS |
| mem_reads | `types_table_scan` | 1.01s | 1.19s | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.16s | 1.30s | 1.1× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 94.17ms | 115.94ms | 1.2× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 141.30ms | 238.39ms | 1.7× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 12.72ms | 22.12ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 44.34ms | 88.05ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 28.95ms | 53.37ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 38.88ms | 65.24ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 18.72ms | 41.06ms | 2.2× | 0.9% | PASS |
| mem_writes | `types_delete_insert` | 20.78ms | 30.50ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 57.27ms | 96.44ms | 1.7× | 1.1% | PASS |
| file_reads | `oltp_point_select` | 50.67ms | 32.41ms | 0.6× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 13.18ms | 13.28ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 12.51ms | 12.21ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 2.92ms | 3.15ms | 1.1× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 3.80ms | 4.23ms | 1.1× | 1.7% | PASS |
| file_reads | `oltp_index_scan` | 6.82ms | 5.62ms | 0.8× | 1.2% | PASS |
| file_reads | `select_random_points` | 13.59ms | 12.65ms | 0.9× | 1.3% | PASS |
| file_reads | `select_random_ranges` | 7.09ms | 5.13ms | 0.7× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 9.74ms | 10.11ms | 1.0× | 1.2% | PASS |
| file_reads | `groupby_scan` | 29.75ms | 33.52ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 7.16ms | 8.68ms | 1.2× | 1.2% | PASS |
| file_reads | `index_join_scan` | 3.27ms | 5.64ms | 1.7× | 1.4% | PASS |
| file_reads | `types_table_scan` | 1.02s | 1.20s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.20s | 1.32s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 137.61ms | 126.32ms | 0.9× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 195.10ms | 298.30ms | 1.5× | 1.8% | PASS |
| file_writes | `oltp_insert` | 28.21ms | 37.59ms | 1.3× | 3.2% | PASS |
| file_writes | `oltp_update_index` | 150.12ms | 148.53ms | 1.0× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 121.58ms | 101.45ms | 0.8× | 1.3% | PASS |
| file_writes | `oltp_delete_insert` | 129.87ms | 123.44ms | 1.0× | 0.8% | PASS |
| file_writes | `oltp_write_only` | 96.54ms | 85.16ms | 0.9× | 1.3% | PASS |
| file_writes | `types_delete_insert` | 82.51ms | 65.23ms | 0.8× | 4.4% | PASS |
| file_writes | `oltp_read_write` | 133.81ms | 138.35ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_point_select` | 30.67ms | 32.24ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 11.02ms | 13.16ms | 1.2× | 1.0% | PASS |
| ac_reads | `oltp_sum_range` | 10.39ms | 12.05ms | 1.2× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 2.69ms | 3.14ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 3.62ms | 4.25ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 4.87ms | 5.59ms | 1.1× | 1.5% | PASS |
| ac_reads | `select_random_points` | 11.57ms | 12.57ms | 1.1× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 5.19ms | 5.12ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 7.68ms | 10.19ms | 1.3× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 29.23ms | 33.30ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 6.16ms | 8.63ms | 1.4× | 1.1% | PASS |
| ac_reads | `index_join_scan` | 3.08ms | 5.59ms | 1.8× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.00s | 1.18s | 1.2× | 0.3% | PASS |
| ac_reads | `table_scan` | 1.17s | 1.30s | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_read_only` | 108.33ms | 126.39ms | 1.2× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 27.96ms | 74.92ms | 2.7× | 3.2% | PASS |
| ac_writes | `oltp_insert_ac` | 30.14ms | 85.71ms | 2.8× | 3.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.02ms | 96.49ms | 3.1× | 3.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 28.21ms | 80.13ms | 2.8× | 3.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 29.73ms | 88.88ms | 3.0× | 3.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.83ms | 89.23ms | 3.0× | 3.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 27.81ms | 81.39ms | 2.9× | 5.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.18ms | 95.25ms | 2.9× | 4.0% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 36.70ms | 42.20ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 17.44ms | 16.92ms | 1.0× | 3.3% | PASS |
| mem_reads | `oltp_sum_range` | 16.15ms | 15.77ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 3.41ms | 3.49ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.49ms | 4.66ms | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 4.02ms | 6.91ms | 1.7× | 1.4% | PASS |
| mem_reads | `select_random_points` | 25.09ms | 24.22ms | 1.0× | 3.7% | PASS |
| mem_reads | `select_random_ranges` | 7.01ms | 7.19ms | 1.0× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 7.69ms | 11.59ms | 1.5× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 34.89ms | 36.86ms | 1.1× | 1.0% | PASS |
| mem_reads | `index_join` | 10.86ms | 11.00ms | 1.0× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 3.98ms | 6.80ms | 1.7× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 1.24s | 1.46s | 1.2× | 1.5% | PASS |
| mem_reads | `table_scan` | 1.43s | 1.55s | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 160.98ms | 161.91ms | 1.0× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 239.33ms | 381.43ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.64ms | 40.38ms | 2.2× | 1.6% | PASS |
| mem_writes | `oltp_update_index` | 76.34ms | 163.09ms | 2.1× | 2.4% | PASS |
| mem_writes | `oltp_update_non_index` | 55.77ms | 91.25ms | 1.6× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 62.27ms | 118.81ms | 1.9× | 2.1% | PASS |
| mem_writes | `oltp_write_only` | 30.31ms | 59.58ms | 2.0× | 2.5% | PASS |
| mem_writes | `types_delete_insert` | 41.91ms | 64.60ms | 1.5× | 2.1% | PASS |
| mem_writes | `oltp_read_write` | 111.57ms | 151.94ms | 1.4× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 112.36ms | 62.25ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 26.45ms | 19.41ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 25.15ms | 18.40ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 4.46ms | 3.79ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_distinct_range` | 5.50ms | 4.96ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.89ms | 9.07ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_points` | 34.89ms | 27.66ms | 0.8× | 2.1% | PASS |
| file_reads | `select_random_ranges` | 14.86ms | 9.20ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.71ms | 13.58ms | 0.9× | 1.3% | PASS |
| file_reads | `groupby_scan` | 36.10ms | 37.39ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 16.47ms | 13.09ms | 0.8× | 3.2% | PASS |
| file_reads | `index_join_scan` | 5.07ms | 7.42ms | 1.5× | 3.1% | PASS |
| file_reads | `types_table_scan` | 1.28s | 1.47s | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 1.43s | 1.52s | 1.1× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 262.29ms | 185.16ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 265.48ms | 396.31ms | 1.5× | 1.2% | PASS |
| file_writes | `oltp_insert` | 25.95ms | 44.42ms | 1.7× | 2.7% | PASS |
| file_writes | `oltp_update_index` | 138.45ms | 169.43ms | 1.2× | 3.8% | PASS |
| file_writes | `oltp_update_non_index` | 106.76ms | 100.35ms | 0.9× | 13.7% | PASS |
| file_writes | `oltp_delete_insert` | 102.39ms | 128.96ms | 1.3× | 2.4% | PASS |
| file_writes | `oltp_write_only` | 87.25ms | 73.82ms | 0.8× | 10.8% | PASS |
| file_writes | `types_delete_insert` | 75.27ms | 72.59ms | 1.0× | 2.5% | PASS |
| file_writes | `oltp_read_write` | 159.34ms | 158.82ms | 1.0× | 10.9% | PASS |
| ac_reads | `oltp_point_select` | 60.30ms | 59.93ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 20.86ms | 18.90ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 19.51ms | 18.04ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_order_range` | 3.99ms | 3.79ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_distinct_range` | 5.00ms | 4.95ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.81ms | 8.86ms | 1.3× | 1.5% | PASS |
| ac_reads | `select_random_points` | 27.14ms | 26.57ms | 1.0× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 9.77ms | 9.14ms | 0.9× | 1.8% | PASS |
| ac_reads | `covering_index_scan` | 10.84ms | 13.49ms | 1.2× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 35.36ms | 37.20ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 13.56ms | 12.46ms | 0.9× | 2.1% | PASS |
| ac_reads | `index_join_scan` | 4.49ms | 7.22ms | 1.6× | 3.0% | PASS |
| ac_reads | `types_table_scan` | 1.26s | 1.46s | 1.2× | 1.6% | PASS |
| ac_reads | `table_scan` | 1.27s | 1.48s | 1.2× | 2.1% | PASS |
| ac_reads | `oltp_read_only` | 181.47ms | 179.96ms | 1.0× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.07ms | 66.49ms | 2.9× | 8.0% | PASS |
| ac_writes | `oltp_insert_ac` | 26.97ms | 80.69ms | 3.0× | 10.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.17ms | 99.25ms | 3.7× | 7.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.12ms | 76.18ms | 3.3× | 6.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.54ms | 93.41ms | 3.4× | 10.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 27.83ms | 90.49ms | 3.3× | 9.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 25.21ms | 80.98ms | 3.2× | 9.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.77ms | 96.72ms | 2.9× | 7.8% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.86ms | 40.09ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 16.56ms | 16.65ms | 1.0× | 2.7% | PASS |
| mem_reads | `oltp_sum_range` | 15.23ms | 15.48ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 3.31ms | 3.50ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.35ms | 4.63ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.00ms | 6.89ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 21.78ms | 22.83ms | 1.0× | 3.5% | PASS |
| mem_reads | `select_random_ranges` | 6.55ms | 7.01ms | 1.1× | 2.7% | PASS |
| mem_reads | `covering_index_scan` | 7.61ms | 11.41ms | 1.5× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 33.23ms | 36.20ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 9.66ms | 10.97ms | 1.1× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.48ms | 6.53ms | 1.9× | 2.1% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.42s | 1.3× | 1.4% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.46s | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 129.98ms | 148.01ms | 1.1× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.43ms | 369.80ms | 1.6× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.05ms | 38.24ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 68.44ms | 147.45ms | 2.2× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 49.97ms | 83.77ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 54.61ms | 108.37ms | 2.0× | 1.8% | PASS |
| mem_writes | `oltp_write_only` | 29.18ms | 58.06ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 39.35ms | 61.51ms | 1.6× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 103.43ms | 146.02ms | 1.4× | 1.5% | PASS |
| file_reads | `oltp_point_select` | 108.63ms | 59.85ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 23.98ms | 18.62ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 22.01ms | 17.23ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 4.34ms | 3.75ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.37ms | 4.90ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 11.36ms | 8.79ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_points` | 31.50ms | 25.81ms | 0.8× | 2.6% | PASS |
| file_reads | `select_random_ranges` | 13.93ms | 8.89ms | 0.6× | 2.3% | PASS |
| file_reads | `covering_index_scan` | 15.22ms | 13.39ms | 0.9× | 1.5% | PASS |
| file_reads | `groupby_scan` | 35.57ms | 36.99ms | 1.0× | 1.2% | PASS |
| file_reads | `index_join` | 15.51ms | 12.77ms | 0.8× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.87ms | 7.21ms | 1.5× | 3.0% | PASS |
| file_reads | `types_table_scan` | 1.10s | 1.45s | 1.3× | 3.1% | PASS |
| file_reads | `table_scan` | 1.18s | 1.46s | 1.2× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 241.38ms | 176.69ms | 0.7× | 2.3% | PASS |
| file_writes | `oltp_bulk_insert` | 256.02ms | 386.31ms | 1.5× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.13ms | 43.23ms | 1.7× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 97.03ms | 157.15ms | 1.6× | 1.6% | PASS |
| file_writes | `oltp_update_non_index` | 92.77ms | 94.30ms | 1.0× | 11.5% | PASS |
| file_writes | `oltp_delete_insert` | 85.86ms | 120.08ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 56.99ms | 68.79ms | 1.2× | 1.4% | PASS |
| file_writes | `types_delete_insert` | 64.51ms | 67.56ms | 1.0× | 2.2% | PASS |
| file_writes | `oltp_read_write` | 125.49ms | 151.56ms | 1.2× | 2.6% | PASS |
| ac_reads | `oltp_point_select` | 56.77ms | 57.95ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 18.42ms | 18.45ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 17.22ms | 17.36ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_order_range` | 3.92ms | 3.76ms | 1.0× | 2.6% | PASS |
| ac_reads | `oltp_distinct_range` | 4.94ms | 4.95ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.46ms | 8.71ms | 1.3× | 2.0% | PASS |
| ac_reads | `select_random_points` | 24.19ms | 25.26ms | 1.0× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 9.06ms | 8.91ms | 1.0× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 10.45ms | 13.40ms | 1.3× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 34.45ms | 36.85ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 12.23ms | 12.42ms | 1.0× | 2.2% | PASS |
| ac_reads | `index_join_scan` | 4.11ms | 6.90ms | 1.7× | 1.4% | PASS |
| ac_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.45s | 1.3× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 167.68ms | 175.86ms | 1.0× | 0.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.52ms | 64.38ms | 2.9× | 5.8% | PASS |
| ac_writes | `oltp_insert_ac` | 25.68ms | 83.32ms | 3.2× | 7.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.44ms | 93.48ms | 3.5× | 6.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.08ms | 73.25ms | 3.3× | 5.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.68ms | 82.58ms | 3.3× | 5.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.59ms | 83.17ms | 3.4× | 7.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.08ms | 72.86ms | 3.3× | 9.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.91ms | 88.59ms | 2.9× | 4.8% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.96ms | 42.78ms | 1.3× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 19.24ms | 25.11ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 18.02ms | 22.90ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 3.65ms | 4.23ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.73ms | 5.44ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 4.58ms | 6.66ms | 1.5× | 1.7% | PASS |
| mem_reads | `select_random_points` | 27.70ms | 33.67ms | 1.2× | 1.6% | PASS |
| mem_reads | `select_random_ranges` | 7.60ms | 9.68ms | 1.3× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.60ms | 11.23ms | 1.5× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 35.59ms | 42.02ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 7.81ms | 12.04ms | 1.5× | 2.2% | PASS |
| mem_reads | `index_join_scan` | 3.85ms | 6.59ms | 1.7× | 1.9% | PASS |
| mem_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 3.1% | PASS |
| mem_reads | `table_scan` | 1.27s | 1.48s | 1.2× | 4.8% | PASS |
| mem_reads | `oltp_read_only` | 158.96ms | 190.26ms | 1.2× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 244.17ms | 369.40ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 18.70ms | 35.84ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 66.31ms | 131.89ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 50.44ms | 91.73ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_delete_insert` | 49.34ms | 101.86ms | 2.1× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 27.18ms | 61.96ms | 2.3× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 32.05ms | 58.04ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 101.22ms | 167.15ms | 1.7× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 104.32ms | 61.15ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 26.94ms | 27.45ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 25.23ms | 25.00ms | 1.0× | 1.9% | PASS |
| file_reads | `oltp_order_range` | 4.55ms | 4.49ms | 1.0× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 5.70ms | 5.73ms | 1.0× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 12.00ms | 8.70ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_points` | 37.26ms | 37.14ms | 1.0× | 1.4% | PASS |
| file_reads | `select_random_ranges` | 15.23ms | 11.75ms | 0.8× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.27ms | 13.47ms | 0.9× | 1.1% | PASS |
| file_reads | `groupby_scan` | 36.76ms | 42.72ms | 1.2× | 0.6% | PASS |
| file_reads | `index_join` | 12.34ms | 13.64ms | 1.1× | 1.4% | PASS |
| file_reads | `index_join_scan` | 4.85ms | 6.95ms | 1.4× | 1.8% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.40s | 1.3× | 0.5% | PASS |
| file_reads | `table_scan` | 1.18s | 1.46s | 1.2× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 252.45ms | 214.40ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 259.15ms | 379.77ms | 1.5× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.72ms | 39.17ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_update_index` | 94.48ms | 142.87ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_update_non_index` | 75.98ms | 97.34ms | 1.3× | 1.2% | PASS |
| file_writes | `oltp_delete_insert` | 74.76ms | 111.86ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_write_only` | 50.12ms | 66.64ms | 1.3× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 49.00ms | 62.58ms | 1.3× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 124.49ms | 171.30ms | 1.4× | 0.9% | PASS |
| ac_reads | `oltp_point_select` | 55.90ms | 60.05ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 21.08ms | 27.34ms | 1.3× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 19.63ms | 24.96ms | 1.3× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 3.82ms | 4.45ms | 1.2× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.95ms | 5.69ms | 1.2× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.80ms | 8.52ms | 1.3× | 1.3% | PASS |
| ac_reads | `select_random_points` | 30.14ms | 36.33ms | 1.2× | 1.1% | PASS |
| ac_reads | `select_random_ranges` | 9.95ms | 11.66ms | 1.2× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 10.06ms | 13.41ms | 1.3× | 1.2% | PASS |
| ac_reads | `groupby_scan` | 35.49ms | 42.58ms | 1.2× | 0.6% | PASS |
| ac_reads | `index_join` | 9.27ms | 13.22ms | 1.4× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 4.18ms | 6.91ms | 1.7× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.3% | PASS |
| ac_reads | `table_scan` | 1.17s | 1.46s | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 180.89ms | 214.29ms | 1.2× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.74ms | 60.54ms | 2.9× | 5.2% | PASS |
| ac_writes | `oltp_insert_ac` | 22.19ms | 73.81ms | 3.3× | 4.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.04ms | 84.54ms | 3.5× | 3.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.52ms | 67.85ms | 3.3× | 4.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.64ms | 75.23ms | 3.5× | 3.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.99ms | 75.44ms | 3.4× | 3.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.66ms | 67.72ms | 3.3× | 5.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.72ms | 83.18ms | 2.8× | 4.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 26s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 35.98ms | 38.00ms | 94.7% | 0.5% | PASS |
| `status_dirty_many_tables` | 40.02ms | 42.00ms | 95.3% | 0.4% | PASS |
| `diff_regular_working_one_table` | 31.67ms | 33.00ms | 96.0% | 0.6% | PASS |
| `diff_regular_working_many_tables` | 45.08ms | 50.00ms | 90.1% | 0.3% | PASS |
| `diff_stat_working_many_tables` | 45.12ms | 48.00ms | 94.0% | 0.4% | PASS |
| `diff_schema_working_many_tables` | 45.61ms | 48.00ms | 95.0% | 0.5% | PASS |
| `branch_list_many_branches` | 23.68ms | 25.00ms | 94.7% | 0.7% | PASS |
| `branch_create_delete` | 25.36ms | 27.00ms | 93.9% | 0.7% | PASS |
| `at_literal_deep_history` | 25.77ms | 28.00ms | 92.0% | 0.6% | PASS |
| `diff_literal_deep_history` | 25.88ms | 28.00ms | 92.4% | 0.6% | PASS |
| `history_literal_deep_history` | 27.46ms | 30.00ms | 91.5% | 0.7% | PASS |
| `checkout_branch_clean` | 35.15ms | 43.00ms | 81.7% | 1.1% | PASS |
| `merge_data_no_conflicts` | 29.74ms | 33.00ms | 90.1% | 0.9% | PASS |
| `merge_data_secondary_index` | 846.74ms | 944.00ms | 89.7% | 0.6% | PASS |
| `merge_schema_no_conflicts` | 21.97ms | 24.00ms | 91.5% | 0.9% | PASS |
| `merge_data_conflicts` | 32.49ms | 33.00ms | 98.4% | 0.6% | PASS |
| `merge_data_conflicts_with_resolve` | 33.34ms | 34.00ms | 98.1% | 0.5% | PASS |

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
| copy_fsync | candidate | 49.390 | 47.850–51.426 | 35.941 | 2024.70 | 107968266 |
| push_initial | candidate | 610.434 | 604.243–618.212 | 597.252 | 163.82 | 107956772 |
| clone_initial | candidate | 806.018 | 800.011–809.163 | 786.162 | 124.07 | 108475035 |
| push_noop | candidate | 0.640 | 0.620–1.678 | 0.423 | — | 0 |
| fetch_noop | candidate | 0.242 | 0.226–0.261 | 0.245 | — | 0 |
| push_incremental | candidate | 260.628 | 260.087–261.464 | 258.161 | 3.84 | 7909775 |
| fetch_incremental | candidate | 106.440 | 105.422–107.342 | 104.641 | 9.39 | 7910084 |
| pull_fast_forward | candidate | 92.938 | 92.515–94.839 | 90.887 | 10.76 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.34 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.61 | 295.016 | 109.784 | 47221 | 2337 |
| push_noop | candidate | 41.99 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 41.99 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 41.99 | 96.854 | 7.910 | 22408 | 125 |
| fetch_incremental | candidate | 41.99 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 41.99 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5395.082 | 5393.557–5396.167 | 308.878 | 185.35 | 1087718031 |
| push_initial | candidate | 9158.099 | 9104.814–9213.392 | 4130.844 | 109.19 | 1079566275 |
| clone_initial | candidate | 9806.500 | 9723.996–10110.510 | 6054.455 | 101.97 | 1102407326 |
| push_noop | candidate | 0.732 | 0.719–0.805 | 0.332 | — | 0 |
| fetch_noop | candidate | 0.185 | 0.185–0.194 | 0.188 | — | 0 |
| push_incremental | candidate | 1024.430 | 1015.549–1041.004 | 948.029 | 0.98 | 15806003 |
| fetch_incremental | candidate | 261.109 | 255.185–277.701 | 209.695 | 3.83 | 15806513 |
| pull_fast_forward | candidate | 281.927 | 276.758–282.242 | 210.872 | 3.55 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.03 | 2090.827 | 1087.622 | 263241 | 20541 |
| clone_initial | candidate | 123.96 | 3518.310 | 1132.819 | 612466 | 32243 |
| push_noop | candidate | 44.72 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 44.72 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.30 | 616.878 | 15.928 | 149847 | 313 |
| fetch_incremental | candidate | 50.44 | 61.520 | 15.928 | 13721 | 313 |
| pull_fast_forward | candidate | 50.46 | 61.452 | 15.929 | 13717 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
