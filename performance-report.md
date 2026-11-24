# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-24 22:20 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/45479429832)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.63s | 10.00s | 1.2× | 1.2% | **PASS** |
| Writes | 1.70s | 2.74s | 1.6× | 0.9% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.32s | 10.13s | 1.1× | 1.0% | **PASS** |
| Writes | 2.93s | 3.42s | 1.2× | 1.7% | **PASS** |
| Autocommit writes | 475.64ms | 1.69s | 3.5× | 5.8% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.82s | 2.10s | 1.2× | 1.2% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.20s | 2.50s | 1.1× | 1.5% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.68s | 3.09s | 1.2× | 1.1% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.93s | 2.31s | 1.2× | 1.0% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 272.46ms | 465.00ms | 1.7× | 0.9% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 482.45ms | 745.00ms | 1.5× | 1.4% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 574.98ms | 932.16ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 369.34ms | 597.93ms | 1.6× | 1.0% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.89s | 2.09s | 1.1× | 1.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.44s | 2.57s | 1.1× | 1.3% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.97s | 3.16s | 1.1× | 0.7% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.02s | 2.31s | 1.1× | 0.9% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 353.88ms | 513.72ms | 1.5× | 1.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.30s | 1.22s | 0.9× | 6.7% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 811.14ms | 1.04s | 1.3× | 1.3% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 461.74ms | 655.21ms | 1.4× | 1.6% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.84s | 2.09s | 1.1× | 1.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.28s | 2.55s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.77s | 3.16s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.98s | 2.32s | 1.2× | 1.2% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 76.71ms | 302.79ms | 3.9× | 6.0% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 160.53ms | 523.35ms | 3.3× | 10.0% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 155.59ms | 545.04ms | 3.5× | 3.8% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 82.81ms | 314.67ms | 3.8× | 5.6% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 15.46ms | 18.87ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_range_select` | 7.75ms | 9.02ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 7.31ms | 8.52ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_order_range` | 1.97ms | 2.21ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 2.63ms | 2.94ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 2.74ms | 3.77ms | 1.4× | 2.3% | PASS |
| mem_reads | `select_random_points` | 8.40ms | 9.71ms | 1.2× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 3.10ms | 3.40ms | 1.1× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 4.69ms | 6.72ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 21.72ms | 25.06ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 4.24ms | 6.60ms | 1.6× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 2.40ms | 4.49ms | 1.9× | 2.4% | PASS |
| mem_reads | `types_table_scan` | 781.48ms | 904.98ms | 1.2× | 0.3% | PASS |
| mem_reads | `table_scan` | 885.74ms | 1.01s | 1.1× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 68.66ms | 82.73ms | 1.2× | 0.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 101.85ms | 170.23ms | 1.7× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 9.41ms | 16.14ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 34.89ms | 66.41ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 22.86ms | 40.59ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_delete_insert` | 30.95ms | 50.02ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 14.86ms | 30.48ms | 2.1× | 0.9% | PASS |
| mem_writes | `types_delete_insert` | 15.73ms | 22.54ms | 1.4× | 0.6% | PASS |
| mem_writes | `oltp_read_write` | 41.92ms | 68.60ms | 1.6× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 36.47ms | 23.39ms | 0.6× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 9.86ms | 9.58ms | 1.0× | 1.0% | PASS |
| file_reads | `oltp_sum_range` | 9.33ms | 9.01ms | 1.0× | 0.9% | PASS |
| file_reads | `oltp_order_range` | 2.25ms | 2.29ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 2.86ms | 3.02ms | 1.1× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 4.94ms | 4.18ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_points` | 10.74ms | 10.32ms | 1.0× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 5.23ms | 3.84ms | 0.7× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 6.91ms | 7.08ms | 1.0× | 0.3% | PASS |
| file_reads | `groupby_scan` | 22.41ms | 24.94ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 5.47ms | 6.63ms | 1.2× | 1.1% | PASS |
| file_reads | `index_join_scan` | 2.63ms | 4.44ms | 1.7× | 2.3% | PASS |
| file_reads | `types_table_scan` | 783.83ms | 888.97ms | 1.1× | 0.2% | PASS |
| file_reads | `table_scan` | 889.63ms | 1.00s | 1.1× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 99.28ms | 89.94ms | 0.9× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 110.07ms | 178.66ms | 1.6× | 0.7% | PASS |
| file_writes | `oltp_insert` | 13.39ms | 18.36ms | 1.4× | 3.1% | PASS |
| file_writes | `oltp_update_index` | 47.94ms | 72.98ms | 1.5× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 34.13ms | 44.56ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 41.83ms | 58.59ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 26.26ms | 35.72ms | 1.4× | 1.3% | PASS |
| file_writes | `types_delete_insert` | 24.23ms | 27.86ms | 1.1× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 56.03ms | 76.99ms | 1.4× | 1.2% | PASS |
| ac_reads | `oltp_point_select` | 22.79ms | 24.04ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 8.89ms | 9.69ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 8.23ms | 9.11ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 2.11ms | 2.31ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 2.78ms | 3.04ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 3.65ms | 4.39ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 9.56ms | 10.41ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 3.93ms | 3.92ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 5.50ms | 7.21ms | 1.3× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 22.16ms | 25.07ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 4.81ms | 6.76ms | 1.4× | 1.1% | PASS |
| ac_reads | `index_join_scan` | 2.55ms | 4.45ms | 1.7× | 2.8% | PASS |
| ac_reads | `types_table_scan` | 781.18ms | 887.16ms | 1.1× | 0.3% | PASS |
| ac_reads | `table_scan` | 886.93ms | 1.00s | 1.1× | 0.4% | PASS |
| ac_reads | `oltp_read_only` | 77.02ms | 88.69ms | 1.2× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 8.84ms | 31.84ms | 3.6× | 7.4% | PASS |
| ac_writes | `oltp_insert_ac` | 9.30ms | 36.66ms | 3.9× | 6.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 10.31ms | 43.49ms | 4.2× | 4.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 8.88ms | 36.29ms | 4.1× | 7.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 10.38ms | 42.34ms | 4.1× | 10.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 9.24ms | 38.19ms | 4.1× | 3.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 8.18ms | 33.03ms | 4.0× | 5.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 11.58ms | 40.95ms | 3.5× | 4.9% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.51ms | 29.67ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_range_select` | 14.65ms | 12.88ms | 0.9× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 13.45ms | 12.33ms | 0.9× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 2.96ms | 2.86ms | 1.0× | 2.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.73ms | 3.72ms | 1.0× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.17ms | 5.29ms | 1.7× | 1.2% | PASS |
| mem_reads | `select_random_points` | 17.83ms | 17.45ms | 1.0× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 5.51ms | 5.18ms | 0.9× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 5.89ms | 8.26ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 29.25ms | 30.01ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 9.13ms | 8.67ms | 0.9× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.26ms | 5.83ms | 1.8× | 1.4% | PASS |
| mem_reads | `types_table_scan` | 901.33ms | 1.05s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.04s | 1.20s | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_read_only` | 113.33ms | 113.02ms | 1.0× | 1.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 179.28ms | 264.52ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 13.83ms | 27.22ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 56.58ms | 112.65ms | 2.0× | 2.0% | PASS |
| mem_writes | `oltp_update_non_index` | 42.55ms | 63.18ms | 1.5× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 46.35ms | 81.75ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 24.31ms | 42.35ms | 1.7× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 33.17ms | 46.04ms | 1.4× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 86.38ms | 107.29ms | 1.2× | 3.2% | PASS |
| file_reads | `oltp_point_select` | 100.56ms | 47.02ms | 0.5× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 23.53ms | 14.86ms | 0.6× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 20.50ms | 14.08ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 3.78ms | 3.09ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.60ms | 3.93ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 10.32ms | 7.06ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 25.61ms | 19.36ms | 0.8× | 1.3% | PASS |
| file_reads | `select_random_ranges` | 12.68ms | 7.00ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 13.22ms | 9.98ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 30.35ms | 30.22ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 13.57ms | 9.55ms | 0.7× | 1.8% | PASS |
| file_reads | `index_join_scan` | 4.16ms | 6.04ms | 1.5× | 1.9% | PASS |
| file_reads | `types_table_scan` | 934.21ms | 1.07s | 1.1× | 2.7% | PASS |
| file_reads | `table_scan` | 1.03s | 1.19s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 213.30ms | 137.27ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 266.08ms | 340.78ms | 1.3× | 3.5% | PASS |
| file_writes | `oltp_insert` | 33.79ms | 50.20ms | 1.5× | 5.9% | PASS |
| file_writes | `oltp_update_index` | 183.71ms | 200.63ms | 1.1× | 11.0% | PASS |
| file_writes | `oltp_update_non_index` | 157.15ms | 126.58ms | 0.8× | 20.6% | PASS |
| file_writes | `oltp_delete_insert` | 191.65ms | 149.83ms | 0.8× | 7.6% | PASS |
| file_writes | `oltp_write_only` | 127.19ms | 96.49ms | 0.8× | 3.4% | PASS |
| file_writes | `types_delete_insert` | 155.66ms | 93.11ms | 0.6× | 7.4% | PASS |
| file_writes | `oltp_read_write` | 183.76ms | 157.76ms | 0.9× | 3.4% | PASS |
| ac_reads | `oltp_point_select` | 49.33ms | 45.78ms | 0.9× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 17.49ms | 14.56ms | 0.8× | 1.1% | PASS |
| ac_reads | `oltp_sum_range` | 15.92ms | 13.98ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 3.35ms | 3.06ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.13ms | 3.91ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.79ms | 7.08ms | 1.2× | 1.0% | PASS |
| ac_reads | `select_random_points` | 20.88ms | 19.31ms | 0.9× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 8.09ms | 6.96ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 8.59ms | 9.93ms | 1.2× | 0.6% | PASS |
| ac_reads | `groupby_scan` | 30.03ms | 30.22ms | 1.0× | 0.9% | PASS |
| ac_reads | `index_join` | 11.30ms | 9.53ms | 0.8× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.71ms | 6.02ms | 1.6× | 2.3% | PASS |
| ac_reads | `types_table_scan` | 918.04ms | 1.05s | 1.1× | 1.5% | PASS |
| ac_reads | `table_scan` | 1.04s | 1.19s | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 142.97ms | 136.24ms | 1.0× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.70ms | 49.47ms | 2.8× | 5.5% | PASS |
| ac_writes | `oltp_insert_ac` | 20.54ms | 62.94ms | 3.1× | 10.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.62ms | 76.84ms | 3.7× | 7.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.14ms | 59.28ms | 3.5× | 12.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.91ms | 68.64ms | 3.4× | 9.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.63ms | 68.01ms | 3.5× | 9.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.37ms | 61.74ms | 3.2× | 21.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.61ms | 76.43ms | 3.0× | 13.0% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 40.19ms | 39.66ms | 1.0× | 3.4% | PASS |
| mem_reads | `oltp_range_select` | 17.55ms | 15.73ms | 0.9× | 2.7% | PASS |
| mem_reads | `oltp_sum_range` | 15.33ms | 14.74ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 3.48ms | 3.53ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.50ms | 4.55ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.21ms | 6.58ms | 1.6× | 3.0% | PASS |
| mem_reads | `select_random_points` | 21.18ms | 20.93ms | 1.0× | 2.0% | PASS |
| mem_reads | `select_random_ranges` | 6.52ms | 6.27ms | 1.0× | 0.7% | PASS |
| mem_reads | `covering_index_scan` | 7.62ms | 10.37ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 36.50ms | 37.92ms | 1.0× | 0.5% | PASS |
| mem_reads | `index_join` | 10.57ms | 10.48ms | 1.0× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.79ms | 6.50ms | 1.7× | 0.9% | PASS |
| mem_reads | `types_table_scan` | 1.12s | 1.34s | 1.2× | 0.4% | PASS |
| mem_reads | `table_scan` | 1.25s | 1.44s | 1.2× | 0.4% | PASS |
| mem_reads | `oltp_read_only` | 136.59ms | 139.80ms | 1.0× | 0.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 235.99ms | 339.24ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.18ms | 36.66ms | 2.0× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 63.72ms | 134.84ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 47.60ms | 78.04ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 51.97ms | 101.24ms | 1.9× | 0.5% | PASS |
| mem_writes | `oltp_write_only` | 27.81ms | 55.62ms | 2.0× | 0.8% | PASS |
| mem_writes | `types_delete_insert` | 37.25ms | 56.71ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_read_write` | 92.46ms | 129.81ms | 1.4× | 0.7% | PASS |
| file_reads | `oltp_point_select` | 122.72ms | 57.48ms | 0.5× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 26.35ms | 17.89ms | 0.7× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 24.52ms | 17.06ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 4.52ms | 3.79ms | 0.8× | 1.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.50ms | 4.78ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 13.01ms | 8.52ms | 0.7× | 0.6% | PASS |
| file_reads | `select_random_points` | 30.49ms | 23.03ms | 0.8× | 0.8% | PASS |
| file_reads | `select_random_ranges` | 15.55ms | 8.53ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 16.86ms | 12.65ms | 0.8× | 0.7% | PASS |
| file_reads | `groupby_scan` | 37.40ms | 38.22ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 15.71ms | 11.75ms | 0.7× | 1.2% | PASS |
| file_reads | `index_join_scan` | 4.96ms | 6.82ms | 1.4× | 1.3% | PASS |
| file_reads | `types_table_scan` | 1.13s | 1.33s | 1.2× | 0.4% | PASS |
| file_reads | `table_scan` | 1.26s | 1.44s | 1.1× | 0.3% | PASS |
| file_reads | `oltp_read_only` | 264.65ms | 170.87ms | 0.6× | 0.6% | PASS |
| file_writes | `oltp_bulk_insert` | 259.40ms | 356.56ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.21ms | 41.56ms | 1.6× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 98.83ms | 152.75ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 90.58ms | 90.69ms | 1.0× | 12.2% | PASS |
| file_writes | `oltp_delete_insert` | 88.80ms | 117.17ms | 1.3× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 57.74ms | 67.91ms | 1.2× | 1.4% | PASS |
| file_writes | `types_delete_insert` | 64.50ms | 67.00ms | 1.0× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 126.08ms | 142.84ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_point_select` | 61.60ms | 58.01ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 20.58ms | 18.05ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_sum_range` | 18.63ms | 17.19ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_order_range` | 3.88ms | 3.81ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.88ms | 4.83ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 6.94ms | 8.68ms | 1.2× | 1.1% | PASS |
| ac_reads | `select_random_points` | 24.34ms | 23.35ms | 1.0× | 1.0% | PASS |
| ac_reads | `select_random_ranges` | 9.49ms | 8.60ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 10.72ms | 12.70ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 36.87ms | 38.19ms | 1.0× | 0.6% | PASS |
| ac_reads | `index_join` | 12.52ms | 11.83ms | 0.9× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 4.36ms | 6.92ms | 1.6× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 1.13s | 1.33s | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.26s | 1.44s | 1.2× | 0.4% | PASS |
| ac_reads | `oltp_read_only` | 176.95ms | 171.37ms | 1.0× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.40ms | 52.84ms | 3.0× | 4.4% | PASS |
| ac_writes | `oltp_insert_ac` | 19.84ms | 69.22ms | 3.5× | 4.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.14ms | 81.44ms | 4.0× | 3.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.67ms | 61.28ms | 3.7× | 3.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.38ms | 70.98ms | 3.7× | 3.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.38ms | 70.69ms | 3.6× | 3.9% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.45ms | 62.08ms | 3.6× | 6.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.32ms | 76.52ms | 3.0× | 2.6% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.02ms | 26.51ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_range_select` | 14.13ms | 15.62ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_sum_range` | 13.84ms | 14.68ms | 1.1× | 0.7% | PASS |
| mem_reads | `oltp_order_range` | 2.68ms | 2.95ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 3.35ms | 3.66ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.28ms | 4.71ms | 1.4× | 1.3% | PASS |
| mem_reads | `select_random_points` | 19.91ms | 23.52ms | 1.2× | 0.9% | PASS |
| mem_reads | `select_random_ranges` | 5.27ms | 6.25ms | 1.2× | 1.0% | PASS |
| mem_reads | `covering_index_scan` | 4.71ms | 6.97ms | 1.5× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 25.20ms | 29.65ms | 1.2× | 0.5% | PASS |
| mem_reads | `index_join` | 5.88ms | 8.86ms | 1.5× | 1.0% | PASS |
| mem_reads | `index_join_scan` | 2.94ms | 5.16ms | 1.8× | 3.4% | PASS |
| mem_reads | `types_table_scan` | 803.50ms | 973.72ms | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 906.21ms | 1.07s | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_read_only` | 97.08ms | 115.35ms | 1.2× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 142.19ms | 202.20ms | 1.4× | 0.4% | PASS |
| mem_writes | `oltp_insert` | 12.02ms | 20.93ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 45.62ms | 84.92ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 32.68ms | 56.06ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 33.36ms | 62.10ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 18.40ms | 37.50ms | 2.0× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 21.07ms | 35.35ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 63.99ms | 98.86ms | 1.5× | 0.9% | PASS |
| file_reads | `oltp_point_select` | 42.98ms | 30.60ms | 0.7× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 15.47ms | 15.84ms | 1.0× | 0.8% | PASS |
| file_reads | `oltp_sum_range` | 15.03ms | 14.94ms | 1.0× | 0.9% | PASS |
| file_reads | `oltp_order_range` | 2.80ms | 2.93ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 3.51ms | 3.68ms | 1.0× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 5.45ms | 5.08ms | 0.9× | 1.5% | PASS |
| file_reads | `select_random_points` | 21.30ms | 23.24ms | 1.1× | 0.8% | PASS |
| file_reads | `select_random_ranges` | 7.30ms | 6.63ms | 0.9× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 6.92ms | 7.21ms | 1.0× | 0.5% | PASS |
| file_reads | `groupby_scan` | 25.02ms | 29.59ms | 1.2× | 0.7% | PASS |
| file_reads | `index_join` | 7.06ms | 8.66ms | 1.2× | 1.5% | PASS |
| file_reads | `index_join_scan` | 3.23ms | 5.33ms | 1.6× | 1.6% | PASS |
| file_reads | `types_table_scan` | 810.46ms | 964.59ms | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 920.42ms | 1.07s | 1.2× | 2.5% | PASS |
| file_reads | `oltp_read_only` | 131.81ms | 123.95ms | 0.9× | 1.9% | PASS |
| file_writes | `oltp_bulk_insert` | 152.05ms | 210.93ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 15.65ms | 24.63ms | 1.6× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 62.20ms | 98.94ms | 1.6× | 1.8% | PASS |
| file_writes | `oltp_update_non_index` | 46.26ms | 61.64ms | 1.3× | 1.6% | PASS |
| file_writes | `oltp_delete_insert` | 47.87ms | 72.79ms | 1.5× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 30.41ms | 42.72ms | 1.4× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 29.51ms | 38.19ms | 1.3× | 1.6% | PASS |
| file_writes | `oltp_read_write` | 77.79ms | 105.37ms | 1.4× | 1.4% | PASS |
| ac_reads | `oltp_point_select` | 28.78ms | 31.08ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 14.65ms | 16.03ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_sum_range` | 13.95ms | 15.07ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 2.72ms | 2.94ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_distinct_range` | 3.35ms | 3.65ms | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_index_scan` | 3.98ms | 4.96ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_points` | 20.16ms | 23.57ms | 1.2× | 0.7% | PASS |
| ac_reads | `select_random_ranges` | 5.91ms | 6.67ms | 1.1× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 5.49ms | 7.36ms | 1.3× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 24.95ms | 29.48ms | 1.2× | 0.6% | PASS |
| ac_reads | `index_join` | 6.41ms | 8.93ms | 1.4× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 3.15ms | 5.26ms | 1.7× | 2.5% | PASS |
| ac_reads | `types_table_scan` | 811.02ms | 963.13ms | 1.2× | 0.7% | PASS |
| ac_reads | `table_scan` | 922.94ms | 1.07s | 1.2× | 2.4% | PASS |
| ac_reads | `oltp_read_only` | 115.00ms | 125.07ms | 1.1× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 9.03ms | 30.68ms | 3.4× | 6.3% | PASS |
| ac_writes | `oltp_insert_ac` | 10.18ms | 39.21ms | 3.9× | 4.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 11.13ms | 46.95ms | 4.2× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 9.54ms | 35.58ms | 3.7× | 6.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 10.15ms | 40.89ms | 4.0× | 5.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 10.28ms | 40.63ms | 4.0× | 4.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 8.72ms | 34.61ms | 4.0× | 5.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 13.78ms | 46.12ms | 3.3× | 4.1% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 17s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 24.87ms | 38.00ms | 65.5% | 1.2% | PASS |
| `status_dirty_many_tables` | 27.51ms | 42.00ms | 65.5% | 1.3% | PASS |
| `diff_regular_working_one_table` | 21.03ms | 33.00ms | 63.7% | 1.5% | PASS |
| `diff_regular_working_many_tables` | 31.06ms | 50.00ms | 62.1% | 1.0% | PASS |
| `diff_stat_working_many_tables` | 31.56ms | 48.00ms | 65.8% | 1.1% | PASS |
| `diff_schema_working_many_tables` | 32.07ms | 48.00ms | 66.8% | 1.0% | PASS |
| `branch_list_many_branches` | 15.91ms | 25.00ms | 63.6% | 1.4% | PASS |
| `branch_create_delete` | 17.43ms | 27.00ms | 64.6% | 2.5% | PASS |
| `at_literal_deep_history` | 17.33ms | 28.00ms | 61.9% | 1.2% | PASS |
| `diff_literal_deep_history` | 17.38ms | 28.00ms | 62.1% | 1.4% | PASS |
| `history_literal_deep_history` | 18.67ms | 30.00ms | 62.2% | 1.5% | PASS |
| `checkout_branch_clean` | 24.44ms | 43.00ms | 56.8% | 1.4% | PASS |
| `merge_data_no_conflicts` | 19.88ms | 33.00ms | 60.3% | 1.7% | PASS |
| `merge_data_secondary_index` | 762.43ms | 944.00ms | 80.8% | 1.7% | PASS |
| `merge_schema_no_conflicts` | 15.07ms | 24.00ms | 62.8% | 2.2% | PASS |
| `merge_data_conflicts` | 21.80ms | 33.00ms | 66.1% | 1.2% | PASS |
| `merge_data_conflicts_with_resolve` | 22.47ms | 34.00ms | 66.1% | 1.2% | PASS |

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
| copy_fsync | candidate | 409.051 | 400.660–537.249 | 32.087 | 244.47 | 107968266 |
| push_initial | candidate | 787.684 | 770.758–958.315 | 405.356 | 126.95 | 107956772 |
| clone_initial | candidate | 961.306 | 889.164–1061.990 | 518.564 | 104.03 | 108475035 |
| push_noop | candidate | 0.613 | 0.566–70.767 | 0.355 | — | 0 |
| fetch_noop | candidate | 0.200 | 0.177–0.222 | 0.203 | — | 0 |
| push_incremental | candidate | 220.283 | 180.152–273.640 | 165.707 | 4.54 | 7909775 |
| fetch_incremental | candidate | 91.081 | 86.229–92.922 | 71.553 | 10.98 | 7910084 |
| pull_fast_forward | candidate | 83.255 | 80.170–97.980 | 62.813 | 12.01 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.60 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.73 | 295.075 | 109.784 | 47237 | 2337 |
| push_noop | candidate | 45.95 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 45.95 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.95 | 96.844 | 7.910 | 22405 | 125 |
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
| copy_fsync | candidate | 5609.566 | 5536.561–5620.693 | 306.509 | 178.27 | 1087718031 |
| push_initial | candidate | 8074.957 | 7867.888–8223.828 | 4110.718 | 123.84 | 1079566275 |
| clone_initial | candidate | 9828.574 | 9701.645–10591.124 | 6008.036 | 101.74 | 1102407326 |
| push_noop | candidate | 0.709 | 0.630–0.808 | 0.336 | — | 0 |
| fetch_noop | candidate | 0.189 | 0.176–0.197 | 0.190 | — | 0 |
| push_incremental | candidate | 1010.197 | 1001.985–1085.403 | 934.094 | 0.99 | 15806003 |
| fetch_incremental | candidate | 265.528 | 262.388–276.013 | 214.586 | 3.77 | 15806513 |
| pull_fast_forward | candidate | 314.208 | 264.158–356.960 | 210.181 | 3.18 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.77 | 2092.001 | 1087.622 | 263528 | 20541 |
| clone_initial | candidate | 123.95 | 3520.615 | 1132.819 | 613063 | 32243 |
| push_noop | candidate | 47.14 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.14 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.35 | 618.044 | 15.928 | 150149 | 313 |
| fetch_incremental | candidate | 50.46 | 62.123 | 15.928 | 13868 | 313 |
| pull_fast_forward | candidate | 50.41 | 62.056 | 15.929 | 13864 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
