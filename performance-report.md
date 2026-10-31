# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-10-31 17:27 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41215035442)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.47s | 12.84s | 1.2× | 1.6% | **PASS** |
| Writes | 2.19s | 3.72s | 1.7× | 1.5% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 11.60s | 13.12s | 1.1× | 1.6% | **PASS** |
| Writes | 3.11s | 4.08s | 1.3× | 1.8% | **PASS** |
| Autocommit writes | 781.91ms | 2.54s | 3.2× | 6.3% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.44s | 2.89s | 1.2× | 1.4% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.76s | 3.31s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.61s | 3.31s | 1.3× | 1.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.66s | 3.34s | 1.3× | 1.6% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 441.50ms | 780.33ms | 1.8× | 1.8% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 574.14ms | 977.08ms | 1.7× | 1.4% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 577.57ms | 971.33ms | 1.7× | 1.4% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 595.23ms | 988.37ms | 1.7× | 1.5% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.80s | 2.98s | 1.1× | 1.5% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.97s | 3.36s | 1.1× | 1.5% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.78s | 3.35s | 1.2× | 1.7% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.05s | 3.43s | 1.1× | 1.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 617.79ms | 855.21ms | 1.4× | 1.9% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 904.98ms | 1.08s | 1.2× | 4.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 805.68ms | 1.08s | 1.3× | 1.5% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 776.74ms | 1.06s | 1.4× | 2.0% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.74s | 3.02s | 1.1× | 1.8% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.96s | 3.39s | 1.1× | 1.8% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.62s | 3.34s | 1.3× | 1.6% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.90s | 3.43s | 1.2× | 1.5% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 197.99ms | 657.96ms | 3.3× | 7.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 199.57ms | 637.80ms | 3.2× | 5.3% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 185.59ms | 603.03ms | 3.2× | 5.3% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 198.76ms | 638.29ms | 3.2× | 7.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.06ms | 32.47ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 11.27ms | 13.30ms | 1.2× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 10.05ms | 12.77ms | 1.3× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 2.74ms | 3.21ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.68ms | 4.40ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.02ms | 6.04ms | 1.5× | 2.5% | PASS |
| mem_reads | `select_random_points` | 11.12ms | 12.72ms | 1.1× | 2.9% | PASS |
| mem_reads | `select_random_ranges` | 4.81ms | 5.61ms | 1.2× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 8.08ms | 11.26ms | 1.4× | 1.4% | PASS |
| mem_reads | `groupby_scan` | 30.99ms | 35.54ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 5.87ms | 9.64ms | 1.6× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.27ms | 5.92ms | 1.8× | 3.0% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.35s | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_read_only` | 101.22ms | 129.25ms | 1.3× | 0.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 174.63ms | 300.13ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 15.01ms | 27.11ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 50.58ms | 100.26ms | 2.0× | 2.0% | PASS |
| mem_writes | `oltp_update_non_index` | 35.05ms | 65.16ms | 1.9× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 44.45ms | 78.94ms | 1.8× | 1.8% | PASS |
| mem_writes | `oltp_write_only` | 22.78ms | 51.17ms | 2.2× | 2.5% | PASS |
| mem_writes | `types_delete_insert` | 24.74ms | 38.96ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 74.26ms | 118.60ms | 1.6× | 2.7% | PASS |
| file_reads | `oltp_point_select` | 93.05ms | 49.92ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 18.70ms | 15.05ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_sum_range` | 17.35ms | 14.51ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 3.60ms | 3.46ms | 1.0× | 3.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.71ms | 4.69ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 11.24ms | 7.82ms | 0.7× | 1.8% | PASS |
| file_reads | `select_random_points` | 17.89ms | 14.22ms | 0.8× | 2.4% | PASS |
| file_reads | `select_random_ranges` | 12.04ms | 7.44ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 15.84ms | 13.21ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 32.61ms | 36.20ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 10.17ms | 10.73ms | 1.1× | 1.8% | PASS |
| file_reads | `index_join_scan` | 4.34ms | 6.46ms | 1.5× | 3.4% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.28s | 1.1× | 1.1% | PASS |
| file_reads | `table_scan` | 1.23s | 1.36s | 1.1× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 207.98ms | 157.78ms | 0.8× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 189.95ms | 314.62ms | 1.7× | 1.3% | PASS |
| file_writes | `oltp_insert` | 22.34ms | 30.64ms | 1.4× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 81.85ms | 114.61ms | 1.4× | 1.8% | PASS |
| file_writes | `oltp_update_non_index` | 62.05ms | 74.15ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 72.28ms | 93.61ms | 1.3× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 48.12ms | 57.09ms | 1.2× | 2.6% | PASS |
| file_writes | `types_delete_insert` | 41.70ms | 46.25ms | 1.1× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 99.52ms | 124.24ms | 1.2× | 2.1% | PASS |
| ac_reads | `oltp_point_select` | 47.01ms | 49.93ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 14.28ms | 15.23ms | 1.1× | 2.9% | PASS |
| ac_reads | `oltp_sum_range` | 12.82ms | 14.54ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_order_range` | 3.22ms | 3.47ms | 1.1× | 2.3% | PASS |
| ac_reads | `oltp_distinct_range` | 4.20ms | 4.68ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.71ms | 7.85ms | 1.2× | 2.0% | PASS |
| ac_reads | `select_random_points` | 13.58ms | 14.48ms | 1.1× | 1.3% | PASS |
| ac_reads | `select_random_ranges` | 7.34ms | 7.49ms | 1.0× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 11.01ms | 13.21ms | 1.2× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 31.60ms | 35.89ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.70ms | 10.80ms | 1.4× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 3.82ms | 6.42ms | 1.7× | 2.2% | PASS |
| ac_reads | `types_table_scan` | 1.14s | 1.30s | 1.1× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.29s | 1.38s | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_read_only` | 145.99ms | 160.17ms | 1.1× | 2.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.06ms | 67.76ms | 2.9× | 10.6% | PASS |
| ac_writes | `oltp_insert_ac` | 25.13ms | 81.13ms | 3.2× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.65ms | 93.18ms | 3.5× | 7.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.00ms | 76.45ms | 3.3× | 10.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.25ms | 85.69ms | 3.5× | 6.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.91ms | 82.59ms | 3.5× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.65ms | 77.48ms | 3.6× | 7.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.35ms | 93.67ms | 3.1× | 6.3% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.09ms | 40.82ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 16.36ms | 16.71ms | 1.0× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 15.23ms | 16.05ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 3.33ms | 3.60ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.33ms | 4.80ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.92ms | 6.79ms | 1.7× | 1.3% | PASS |
| mem_reads | `select_random_points` | 21.37ms | 22.50ms | 1.1× | 2.3% | PASS |
| mem_reads | `select_random_ranges` | 6.62ms | 6.91ms | 1.0× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 11.19ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 35.05ms | 38.52ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 10.54ms | 10.63ms | 1.0× | 2.4% | PASS |
| mem_reads | `index_join_scan` | 3.79ms | 6.69ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.14s | 1.43s | 1.3× | 1.0% | PASS |
| mem_reads | `table_scan` | 1.31s | 1.54s | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 140.92ms | 156.25ms | 1.1× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 227.24ms | 355.23ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 17.32ms | 36.65ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 65.73ms | 140.66ms | 2.1× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 47.26ms | 82.44ms | 1.7× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 52.96ms | 104.29ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 27.77ms | 55.73ms | 2.0× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 37.38ms | 60.02ms | 1.6× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 98.50ms | 142.05ms | 1.4× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 103.52ms | 58.47ms | 0.6× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 24.44ms | 18.73ms | 0.8× | 1.8% | PASS |
| file_reads | `oltp_sum_range` | 22.83ms | 18.16ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 4.28ms | 3.88ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 5.27ms | 5.09ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 11.06ms | 8.62ms | 0.8× | 1.6% | PASS |
| file_reads | `select_random_points` | 30.80ms | 25.76ms | 0.8× | 3.2% | PASS |
| file_reads | `select_random_ranges` | 13.97ms | 8.82ms | 0.6× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 15.42ms | 13.10ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 36.27ms | 38.76ms | 1.1× | 1.2% | PASS |
| file_reads | `index_join` | 14.99ms | 11.88ms | 0.8× | 2.6% | PASS |
| file_reads | `index_join_scan` | 4.78ms | 6.96ms | 1.5× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.43s | 1.3× | 1.5% | PASS |
| file_reads | `table_scan` | 1.32s | 1.53s | 1.2× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 243.53ms | 183.75ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 252.53ms | 370.63ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.44ms | 42.35ms | 1.7× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 115.41ms | 160.67ms | 1.4× | 9.0% | PASS |
| file_writes | `oltp_update_non_index` | 101.71ms | 96.67ms | 1.0× | 10.3% | PASS |
| file_writes | `oltp_delete_insert` | 96.42ms | 120.79ms | 1.3× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 88.68ms | 68.24ms | 0.8× | 14.7% | PASS |
| file_writes | `types_delete_insert` | 72.72ms | 69.58ms | 1.0× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 152.06ms | 154.38ms | 1.0× | 6.5% | PASS |
| ac_reads | `oltp_point_select` | 57.69ms | 58.23ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 19.97ms | 18.83ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 18.26ms | 18.32ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_order_range` | 3.77ms | 3.88ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 4.78ms | 5.08ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.59ms | 8.66ms | 1.3× | 1.7% | PASS |
| ac_reads | `select_random_points` | 25.99ms | 26.03ms | 1.0× | 3.9% | PASS |
| ac_reads | `select_random_ranges` | 9.30ms | 8.89ms | 1.0× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.81ms | 13.21ms | 1.2× | 1.2% | PASS |
| ac_reads | `groupby_scan` | 35.90ms | 39.06ms | 1.1× | 1.0% | PASS |
| ac_reads | `index_join` | 12.69ms | 12.05ms | 0.9× | 2.6% | PASS |
| ac_reads | `index_join_scan` | 4.31ms | 7.01ms | 1.6× | 2.6% | PASS |
| ac_reads | `types_table_scan` | 1.17s | 1.44s | 1.2× | 1.8% | PASS |
| ac_reads | `table_scan` | 1.39s | 1.55s | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 177.57ms | 184.53ms | 1.0× | 1.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.15ms | 63.59ms | 2.7× | 6.0% | PASS |
| ac_writes | `oltp_insert_ac` | 24.77ms | 77.70ms | 3.1× | 8.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.02ms | 93.41ms | 3.6× | 4.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.40ms | 71.84ms | 3.4× | 4.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 26.25ms | 86.45ms | 3.3× | 4.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.19ms | 82.77ms | 3.4× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.02ms | 72.72ms | 3.2× | 6.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.76ms | 89.31ms | 2.9× | 4.5% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.13ms | 39.71ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 15.26ms | 16.44ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 14.03ms | 15.62ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_order_range` | 3.26ms | 3.64ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.22ms | 4.85ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.88ms | 6.72ms | 1.7× | 1.8% | PASS |
| mem_reads | `select_random_points` | 20.43ms | 22.09ms | 1.1× | 2.1% | PASS |
| mem_reads | `select_random_ranges` | 6.42ms | 6.92ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 7.99ms | 11.16ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 34.41ms | 37.47ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 10.00ms | 10.78ms | 1.1× | 2.4% | PASS |
| mem_reads | `index_join_scan` | 3.62ms | 6.39ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.43s | 1.3× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.54s | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 134.87ms | 154.78ms | 1.1× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.99ms | 362.79ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.98ms | 37.09ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 63.14ms | 134.97ms | 2.1× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 46.87ms | 80.18ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 52.01ms | 103.11ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 27.33ms | 55.32ms | 2.0× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 37.20ms | 58.70ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 96.06ms | 139.17ms | 1.4× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 103.19ms | 57.77ms | 0.6× | 1.5% | PASS |
| file_reads | `oltp_range_select` | 23.43ms | 18.60ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 22.35ms | 18.00ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 4.11ms | 3.92ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.12ms | 5.13ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_index_scan` | 11.20ms | 8.71ms | 0.8× | 1.7% | PASS |
| file_reads | `select_random_points` | 29.14ms | 24.94ms | 0.9× | 3.0% | PASS |
| file_reads | `select_random_ranges` | 13.80ms | 8.95ms | 0.6× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 15.48ms | 13.24ms | 0.9× | 1.0% | PASS |
| file_reads | `groupby_scan` | 35.95ms | 38.15ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.03ms | 12.03ms | 0.9× | 2.5% | PASS |
| file_reads | `index_join_scan` | 4.53ms | 6.70ms | 1.5× | 1.7% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.42s | 1.3× | 0.7% | PASS |
| file_reads | `table_scan` | 1.20s | 1.54s | 1.3× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 235.84ms | 182.23ms | 0.8× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 256.70ms | 378.73ms | 1.5× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.15ms | 42.53ms | 1.7× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 98.01ms | 155.88ms | 1.6× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 91.12ms | 93.20ms | 1.0× | 11.5% | PASS |
| file_writes | `oltp_delete_insert` | 86.13ms | 117.84ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 57.12ms | 67.34ms | 1.2× | 2.0% | PASS |
| file_writes | `types_delete_insert` | 63.40ms | 68.82ms | 1.1× | 1.6% | PASS |
| file_writes | `oltp_read_write` | 128.06ms | 151.80ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_point_select` | 57.17ms | 57.83ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 19.15ms | 18.56ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 17.99ms | 17.91ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_order_range` | 3.71ms | 3.92ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 4.68ms | 5.14ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_index_scan` | 6.52ms | 8.63ms | 1.3× | 1.7% | PASS |
| ac_reads | `select_random_points` | 24.66ms | 24.78ms | 1.0× | 2.6% | PASS |
| ac_reads | `select_random_ranges` | 9.10ms | 8.95ms | 1.0× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 10.78ms | 13.20ms | 1.2× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 35.08ms | 37.85ms | 1.1× | 0.5% | PASS |
| ac_reads | `index_join` | 12.12ms | 12.04ms | 1.0× | 1.8% | PASS |
| ac_reads | `index_join_scan` | 4.17ms | 6.76ms | 1.6× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.7% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.53s | 1.3× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 168.33ms | 182.09ms | 1.1× | 0.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.34ms | 60.22ms | 3.0× | 5.4% | PASS |
| ac_writes | `oltp_insert_ac` | 24.37ms | 76.38ms | 3.1× | 6.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.93ms | 87.08ms | 3.6× | 4.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.44ms | 68.56ms | 3.4× | 5.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.60ms | 77.31ms | 3.4× | 4.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.50ms | 77.22ms | 3.4× | 4.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.27ms | 70.34ms | 3.3× | 6.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.15ms | 85.91ms | 2.8× | 6.4% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.97ms | 42.83ms | 1.3× | 2.0% | PASS |
| mem_reads | `oltp_range_select` | 20.41ms | 23.91ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_sum_range` | 17.66ms | 22.81ms | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 3.65ms | 4.26ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.67ms | 5.46ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.50ms | 6.66ms | 1.5× | 1.5% | PASS |
| mem_reads | `select_random_points` | 26.06ms | 31.99ms | 1.2× | 2.0% | PASS |
| mem_reads | `select_random_ranges` | 7.63ms | 9.54ms | 1.3× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 8.09ms | 11.45ms | 1.4× | 1.8% | PASS |
| mem_reads | `groupby_scan` | 37.69ms | 43.03ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 7.87ms | 11.65ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.92ms | 6.44ms | 1.6× | 2.7% | PASS |
| mem_reads | `types_table_scan` | 1.09s | 1.42s | 1.3× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.25s | 1.51s | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_read_only` | 150.59ms | 186.46ms | 1.2× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 241.96ms | 351.79ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.48ms | 34.10ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 66.31ms | 128.90ms | 1.9× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 51.17ms | 89.84ms | 1.8× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 49.70ms | 99.15ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 27.56ms | 60.47ms | 2.2× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 33.01ms | 58.00ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 107.04ms | 166.11ms | 1.6× | 1.7% | PASS |
| file_reads | `oltp_point_select` | 103.00ms | 61.20ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 27.54ms | 25.89ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 25.22ms | 24.96ms | 1.0× | 2.4% | PASS |
| file_reads | `oltp_order_range` | 4.55ms | 4.55ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_distinct_range` | 5.61ms | 5.79ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 11.82ms | 8.74ms | 0.7× | 1.8% | PASS |
| file_reads | `select_random_points` | 35.40ms | 35.42ms | 1.0× | 2.7% | PASS |
| file_reads | `select_random_ranges` | 15.02ms | 11.64ms | 0.8× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.47ms | 13.21ms | 0.9× | 1.8% | PASS |
| file_reads | `groupby_scan` | 38.63ms | 43.40ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 12.07ms | 13.40ms | 1.1× | 2.0% | PASS |
| file_reads | `index_join_scan` | 5.03ms | 7.02ms | 1.4× | 3.3% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.42s | 1.3× | 1.6% | PASS |
| file_reads | `table_scan` | 1.37s | 1.53s | 1.1× | 1.8% | PASS |
| file_reads | `oltp_read_only` | 262.52ms | 218.43ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 256.08ms | 365.27ms | 1.4× | 0.6% | PASS |
| file_writes | `oltp_insert` | 26.18ms | 38.64ms | 1.5× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 99.20ms | 145.43ms | 1.5× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 78.18ms | 98.32ms | 1.3× | 2.5% | PASS |
| file_writes | `oltp_delete_insert` | 78.41ms | 112.02ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 52.19ms | 66.72ms | 1.3× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 51.23ms | 63.49ms | 1.2× | 2.5% | PASS |
| file_writes | `oltp_read_write` | 135.27ms | 172.96ms | 1.3× | 1.7% | PASS |
| ac_reads | `oltp_point_select` | 57.17ms | 61.20ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 23.56ms | 26.10ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 20.87ms | 25.18ms | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 4.12ms | 4.58ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_distinct_range` | 5.14ms | 5.80ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 7.27ms | 8.81ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 30.22ms | 36.18ms | 1.2× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 10.29ms | 11.75ms | 1.1× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 11.02ms | 13.34ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 38.02ms | 43.51ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 9.82ms | 13.46ms | 1.4× | 2.2% | PASS |
| ac_reads | `index_join_scan` | 4.43ms | 7.01ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.12s | 1.43s | 1.3× | 2.1% | PASS |
| ac_reads | `table_scan` | 1.37s | 1.53s | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_read_only` | 192.31ms | 219.12ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.19ms | 64.29ms | 3.0× | 6.3% | PASS |
| ac_writes | `oltp_insert_ac` | 25.18ms | 79.22ms | 3.1× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.43ms | 91.60ms | 3.3× | 7.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.82ms | 73.54ms | 3.2× | 8.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.83ms | 81.30ms | 3.4× | 5.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.33ms | 81.68ms | 3.2× | 5.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.73ms | 76.52ms | 3.7× | 7.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.25ms | 90.14ms | 2.8× | 8.6% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 15s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 30.61ms | 38.00ms | 80.5% | 1.1% | PASS |
| `status_dirty_many_tables` | 34.06ms | 42.00ms | 81.1% | 0.9% | PASS |
| `diff_regular_working_one_table` | 26.28ms | 33.00ms | 79.6% | 1.2% | PASS |
| `diff_regular_working_many_tables` | 39.39ms | 50.00ms | 78.8% | 1.4% | PASS |
| `diff_stat_working_many_tables` | 38.75ms | 48.00ms | 80.7% | 1.0% | PASS |
| `diff_schema_working_many_tables` | 39.82ms | 48.00ms | 83.0% | 1.4% | PASS |
| `branch_list_many_branches` | 18.63ms | 25.00ms | 74.5% | 1.3% | PASS |
| `branch_create_delete` | 20.32ms | 27.00ms | 75.3% | 1.2% | PASS |
| `at_literal_deep_history` | 20.57ms | 28.00ms | 73.4% | 1.6% | PASS |
| `diff_literal_deep_history` | 20.40ms | 28.00ms | 72.9% | 1.4% | PASS |
| `history_literal_deep_history` | 21.78ms | 30.00ms | 72.6% | 1.4% | PASS |
| `checkout_branch_clean` | 29.77ms | 43.00ms | 69.2% | 1.4% | PASS |
| `merge_data_no_conflicts` | 23.46ms | 33.00ms | 71.1% | 1.4% | PASS |
| `merge_data_secondary_index` | 872.05ms | 944.00ms | 92.4% | 1.6% | PASS |
| `merge_schema_no_conflicts` | 17.86ms | 24.00ms | 74.4% | 1.7% | PASS |
| `merge_data_conflicts` | 26.89ms | 33.00ms | 81.5% | 1.8% | PASS |
| `merge_data_conflicts_with_resolve` | 27.74ms | 34.00ms | 81.6% | 1.2% | PASS |

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
| copy_fsync | candidate | 57.598 | 55.508–60.828 | 39.124 | 1736.17 | 107968266 |
| push_initial | candidate | 591.683 | 583.263–601.088 | 572.692 | 169.01 | 107956772 |
| clone_initial | candidate | 767.139 | 762.991–769.435 | 743.603 | 130.35 | 108475035 |
| push_noop | candidate | 0.679 | 0.635–0.692 | 0.379 | — | 0 |
| fetch_noop | candidate | 0.204 | 0.200–0.235 | 0.206 | — | 0 |
| push_incremental | candidate | 232.704 | 231.869–237.798 | 230.105 | 4.30 | 7909775 |
| fetch_incremental | candidate | 97.109 | 96.670–102.195 | 94.875 | 10.30 | 7910084 |
| pull_fast_forward | candidate | 86.691 | 85.592–87.059 | 84.295 | 11.54 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.74 | 295.200 | 109.784 | 47268 | 2337 |
| push_noop | candidate | 46.09 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 46.09 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.09 | 96.853 | 7.910 | 22408 | 125 |
| fetch_incremental | candidate | 46.09 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.09 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2662.265 | 2655.538–2669.907 | 386.667 | 375.62 | 1087718031 |
| push_initial | candidate | 8139.863 | 8116.408–8154.438 | 5932.587 | 122.85 | 1079566275 |
| clone_initial | candidate | 8887.396 | 8852.916–8901.748 | 8631.502 | 112.52 | 1102407326 |
| push_noop | candidate | 0.914 | 0.787–1.100 | 0.414 | — | 0 |
| fetch_noop | candidate | 0.245 | 0.196–0.253 | 0.253 | — | 0 |
| push_incremental | candidate | 1303.122 | 1297.224–1316.878 | 1297.731 | 0.77 | 15806003 |
| fetch_incremental | candidate | 279.825 | 270.302–280.881 | 273.708 | 3.57 | 15806513 |
| pull_fast_forward | candidate | 279.205 | 279.118–283.076 | 273.228 | 3.58 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.78 | 2091.359 | 1087.622 | 263371 | 20541 |
| clone_initial | candidate | 124.00 | 3515.261 | 1132.819 | 611733 | 32243 |
| push_noop | candidate | 47.10 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.10 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.25 | 615.734 | 15.928 | 149579 | 313 |
| fetch_incremental | candidate | 50.41 | 61.966 | 15.928 | 13830 | 313 |
| pull_fast_forward | candidate | 50.39 | 61.899 | 15.929 | 13826 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
