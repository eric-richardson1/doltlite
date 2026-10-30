# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-10-30 18:12 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41087510057)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.18s | 11.88s | 1.2× | 1.3% | **PASS** |
| Writes | 2.03s | 3.38s | 1.7× | 1.0% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.93s | 12.08s | 1.1× | 1.3% | **PASS** |
| Writes | 3.40s | 4.12s | 1.2× | 2.1% | **PASS** |
| Autocommit writes | 689.08ms | 2.30s | 3.3× | 6.4% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.53s | 2.96s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.18s | 2.44s | 1.1× | 1.1% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.77s | 3.14s | 1.1× | 1.5% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.69s | 3.35s | 1.2× | 1.4% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 432.97ms | 768.23ms | 1.8× | 1.5% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 450.51ms | 711.95ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 573.86ms | 934.55ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 577.32ms | 968.78ms | 1.7× | 1.4% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.67s | 3.01s | 1.1× | 1.5% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.39s | 2.49s | 1.0× | 0.8% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.99s | 3.18s | 1.1× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.88s | 3.40s | 1.2× | 1.4% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 594.45ms | 827.70ms | 1.4× | 1.7% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.21s | 1.18s | 1.0× | 3.7% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 830.48ms | 1.07s | 1.3× | 1.8% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 763.59ms | 1.05s | 1.4× | 2.1% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.55s | 3.01s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.46s | 2.55s | 1.0× | 1.0% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 3.00s | 3.28s | 1.1× | 1.2% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.80s | 3.41s | 1.2× | 1.5% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 191.00ms | 630.40ms | 3.3× | 6.4% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 155.06ms | 503.87ms | 3.2× | 6.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 152.00ms | 548.86ms | 3.6× | 5.2% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 191.03ms | 612.84ms | 3.2× | 7.3% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.39ms | 31.31ms | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 10.34ms | 13.19ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 9.37ms | 12.27ms | 1.3× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 2.65ms | 3.16ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.57ms | 4.34ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.82ms | 5.52ms | 1.4× | 1.6% | PASS |
| mem_reads | `select_random_points` | 9.64ms | 11.83ms | 1.2× | 1.8% | PASS |
| mem_reads | `select_random_ranges` | 4.48ms | 5.38ms | 1.2× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 7.97ms | 10.90ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 30.56ms | 35.86ms | 1.2× | 1.0% | PASS |
| mem_reads | `index_join` | 5.77ms | 8.97ms | 1.6× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 3.31ms | 5.86ms | 1.8× | 3.2% | PASS |
| mem_reads | `types_table_scan` | 1.06s | 1.28s | 1.2× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.26s | 1.41s | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 102.99ms | 130.47ms | 1.3× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.06ms | 299.73ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 14.88ms | 26.91ms | 1.8× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 49.27ms | 97.77ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 34.32ms | 64.24ms | 1.9× | 2.8% | PASS |
| mem_writes | `oltp_delete_insert` | 43.56ms | 78.69ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 21.68ms | 48.98ms | 2.3× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 23.84ms | 37.70ms | 1.6× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 70.38ms | 114.22ms | 1.6× | 2.8% | PASS |
| file_reads | `oltp_point_select` | 91.84ms | 48.99ms | 0.5× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 18.46ms | 15.26ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 17.02ms | 14.34ms | 0.8× | 2.1% | PASS |
| file_reads | `oltp_order_range` | 3.61ms | 3.44ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.54ms | 4.65ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.21ms | 7.73ms | 0.7× | 1.8% | PASS |
| file_reads | `select_random_points` | 17.79ms | 13.95ms | 0.8× | 2.3% | PASS |
| file_reads | `select_random_ranges` | 11.92ms | 7.33ms | 0.6× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 15.74ms | 13.03ms | 0.8× | 1.3% | PASS |
| file_reads | `groupby_scan` | 31.92ms | 36.24ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 9.95ms | 10.31ms | 1.0× | 2.0% | PASS |
| file_reads | `index_join_scan` | 4.22ms | 6.03ms | 1.4× | 1.9% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.28s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.17s | 1.39s | 1.2× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 204.20ms | 157.27ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 187.82ms | 312.23ms | 1.7× | 0.8% | PASS |
| file_writes | `oltp_insert` | 21.90ms | 30.16ms | 1.4× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 78.78ms | 108.16ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 58.27ms | 70.17ms | 1.2× | 1.9% | PASS |
| file_writes | `oltp_delete_insert` | 67.77ms | 89.05ms | 1.3× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 45.47ms | 54.18ms | 1.2× | 3.1% | PASS |
| file_writes | `types_delete_insert` | 39.46ms | 44.06ms | 1.1× | 2.4% | PASS |
| file_writes | `oltp_read_write` | 94.98ms | 119.68ms | 1.3× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 46.64ms | 49.45ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 13.49ms | 15.23ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_sum_range` | 12.33ms | 14.35ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_order_range` | 3.09ms | 3.44ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.99ms | 4.63ms | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.32ms | 7.65ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 12.54ms | 13.89ms | 1.1× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 7.09ms | 7.30ms | 1.0× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.71ms | 12.99ms | 1.2× | 1.7% | PASS |
| ac_reads | `groupby_scan` | 31.15ms | 36.17ms | 1.2× | 0.9% | PASS |
| ac_reads | `index_join` | 7.28ms | 10.29ms | 1.4× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.67ms | 6.14ms | 1.7× | 2.8% | PASS |
| ac_reads | `types_table_scan` | 1.06s | 1.28s | 1.2× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.20s | 1.40s | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 137.03ms | 157.69ms | 1.2× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.87ms | 66.83ms | 3.2× | 4.1% | PASS |
| ac_writes | `oltp_insert_ac` | 23.77ms | 78.38ms | 3.3× | 6.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.48ms | 90.18ms | 3.5× | 5.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.24ms | 71.71ms | 3.4× | 8.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.59ms | 81.52ms | 3.5× | 6.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 25.14ms | 81.53ms | 3.2× | 7.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.82ms | 72.89ms | 3.3× | 7.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.09ms | 87.37ms | 3.0× | 6.2% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.27ms | 28.75ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 13.51ms | 12.44ms | 0.9× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 12.22ms | 11.85ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_order_range` | 2.74ms | 2.78ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.51ms | 3.58ms | 1.0× | 0.7% | PASS |
| mem_reads | `oltp_index_scan` | 3.10ms | 5.04ms | 1.6× | 0.7% | PASS |
| mem_reads | `select_random_points` | 17.17ms | 17.23ms | 1.0× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 5.23ms | 5.00ms | 1.0× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 5.89ms | 8.05ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 29.13ms | 29.96ms | 1.0× | 0.7% | PASS |
| mem_reads | `index_join` | 8.66ms | 8.18ms | 0.9× | 0.9% | PASS |
| mem_reads | `index_join_scan` | 3.10ms | 5.50ms | 1.8× | 1.2% | PASS |
| mem_reads | `types_table_scan` | 893.51ms | 1.05s | 1.2× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.05s | 1.14s | 1.1× | 3.2% | PASS |
| mem_reads | `oltp_read_only` | 108.34ms | 111.13ms | 1.0× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.08ms | 259.00ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 13.63ms | 26.54ms | 1.9× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 51.11ms | 105.06ms | 2.1× | 0.6% | PASS |
| mem_writes | `oltp_update_non_index` | 37.80ms | 59.69ms | 1.6× | 0.8% | PASS |
| mem_writes | `oltp_delete_insert` | 42.98ms | 77.77ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 22.76ms | 40.71ms | 1.8× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 31.51ms | 44.43ms | 1.4× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 72.64ms | 98.76ms | 1.4× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 95.02ms | 45.14ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 20.98ms | 14.17ms | 0.7× | 0.7% | PASS |
| file_reads | `oltp_sum_range` | 19.53ms | 13.64ms | 0.7× | 0.6% | PASS |
| file_reads | `oltp_order_range` | 3.61ms | 3.02ms | 0.8× | 0.6% | PASS |
| file_reads | `oltp_distinct_range` | 4.41ms | 3.81ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 10.17ms | 6.85ms | 0.7× | 0.8% | PASS |
| file_reads | `select_random_points` | 25.18ms | 19.11ms | 0.8× | 1.4% | PASS |
| file_reads | `select_random_ranges` | 12.37ms | 6.77ms | 0.5× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 13.12ms | 9.81ms | 0.7× | 0.8% | PASS |
| file_reads | `groupby_scan` | 30.26ms | 30.25ms | 1.0× | 0.6% | PASS |
| file_reads | `index_join` | 13.23ms | 9.37ms | 0.7× | 0.8% | PASS |
| file_reads | `index_join_scan` | 3.99ms | 5.71ms | 1.4× | 1.1% | PASS |
| file_reads | `types_table_scan` | 908.31ms | 1.05s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.02s | 1.13s | 1.1× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 210.90ms | 135.88ms | 0.6× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 258.69ms | 331.00ms | 1.3× | 2.6% | PASS |
| file_writes | `oltp_insert` | 27.90ms | 46.33ms | 1.7× | 3.1% | PASS |
| file_writes | `oltp_update_index` | 171.89ms | 191.42ms | 1.1× | 4.4% | PASS |
| file_writes | `oltp_update_non_index` | 142.08ms | 118.92ms | 0.8× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 179.30ms | 148.99ms | 0.8× | 4.4% | PASS |
| file_writes | `oltp_write_only` | 121.47ms | 98.02ms | 0.8× | 2.4% | PASS |
| file_writes | `types_delete_insert` | 139.09ms | 88.75ms | 0.6× | 8.4% | PASS |
| file_writes | `oltp_read_write` | 169.40ms | 156.15ms | 0.9× | 5.0% | PASS |
| ac_reads | `oltp_point_select` | 48.91ms | 45.47ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 16.58ms | 14.22ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 15.09ms | 13.74ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.25ms | 3.04ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.00ms | 3.82ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.69ms | 6.88ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 20.30ms | 19.12ms | 0.9× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 7.89ms | 6.80ms | 0.9× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.80ms | 1.2× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 29.61ms | 30.14ms | 1.0× | 0.7% | PASS |
| ac_reads | `index_join` | 10.80ms | 9.27ms | 0.9× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 3.56ms | 5.62ms | 1.6× | 1.0% | PASS |
| ac_reads | `types_table_scan` | 937.22ms | 1.06s | 1.1× | 1.9% | PASS |
| ac_reads | `table_scan` | 1.21s | 1.19s | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 144.48ms | 136.43ms | 0.9× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.56ms | 50.34ms | 2.9× | 8.1% | PASS |
| ac_writes | `oltp_insert_ac` | 19.91ms | 60.95ms | 3.1× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.97ms | 75.26ms | 3.6× | 6.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.64ms | 55.57ms | 3.3× | 5.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.19ms | 67.06ms | 3.5× | 6.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 18.80ms | 66.09ms | 3.5× | 8.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.73ms | 57.71ms | 3.3× | 12.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.25ms | 70.88ms | 2.9× | 6.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 37.80ms | 37.98ms | 1.0× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 17.85ms | 16.50ms | 0.9× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 16.01ms | 14.87ms | 0.9× | 2.0% | PASS |
| mem_reads | `oltp_order_range` | 3.51ms | 3.77ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.47ms | 4.80ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.03ms | 6.44ms | 1.6× | 1.3% | PASS |
| mem_reads | `select_random_points` | 22.08ms | 21.25ms | 1.0× | 3.0% | PASS |
| mem_reads | `select_random_ranges` | 6.57ms | 6.31ms | 1.0× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 7.62ms | 10.44ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 37.16ms | 38.25ms | 1.0× | 0.8% | PASS |
| mem_reads | `index_join` | 11.67ms | 11.07ms | 0.9× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 3.84ms | 6.62ms | 1.7× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.13s | 1.34s | 1.2× | 1.4% | PASS |
| mem_reads | `table_scan` | 1.34s | 1.48s | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 134.99ms | 144.07ms | 1.1× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.01ms | 338.12ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.09ms | 36.51ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 62.54ms | 133.67ms | 2.1× | 0.6% | PASS |
| mem_writes | `oltp_update_non_index` | 46.91ms | 77.83ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_delete_insert` | 51.66ms | 101.07ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 28.14ms | 56.18ms | 2.0× | 0.8% | PASS |
| mem_writes | `types_delete_insert` | 37.76ms | 58.09ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 95.75ms | 133.09ms | 1.4× | 1.0% | PASS |
| file_reads | `oltp_point_select` | 123.00ms | 57.60ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 26.51ms | 18.43ms | 0.7× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 24.83ms | 17.12ms | 0.7× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.45ms | 4.05ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.40ms | 5.02ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 12.78ms | 8.55ms | 0.7× | 1.2% | PASS |
| file_reads | `select_random_points` | 29.12ms | 23.10ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 14.97ms | 8.54ms | 0.6× | 2.7% | PASS |
| file_reads | `covering_index_scan` | 16.66ms | 12.65ms | 0.8× | 0.9% | PASS |
| file_reads | `groupby_scan` | 37.28ms | 38.12ms | 1.0× | 1.2% | PASS |
| file_reads | `index_join` | 14.85ms | 11.81ms | 0.8× | 3.1% | PASS |
| file_reads | `index_join_scan` | 4.85ms | 6.79ms | 1.4× | 2.7% | PASS |
| file_reads | `types_table_scan` | 1.13s | 1.33s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.27s | 1.46s | 1.1× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 271.41ms | 179.19ms | 0.7× | 1.4% | PASS |
| file_writes | `oltp_bulk_insert` | 257.54ms | 358.06ms | 1.4× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.63ms | 42.65ms | 1.7× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 102.42ms | 162.89ms | 1.6× | 1.9% | PASS |
| file_writes | `oltp_update_non_index` | 91.52ms | 93.83ms | 1.0× | 8.3% | PASS |
| file_writes | `oltp_delete_insert` | 92.28ms | 123.46ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 61.10ms | 70.58ms | 1.2× | 2.5% | PASS |
| file_writes | `types_delete_insert` | 66.92ms | 69.17ms | 1.0× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 133.06ms | 148.78ms | 1.1× | 2.8% | PASS |
| ac_reads | `oltp_point_select` | 63.58ms | 58.19ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 20.88ms | 18.57ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 19.22ms | 17.25ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_order_range` | 3.92ms | 4.03ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.89ms | 5.02ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_index_scan` | 7.09ms | 8.56ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 25.05ms | 23.43ms | 0.9× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 9.58ms | 8.56ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 10.85ms | 12.77ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 37.51ms | 38.42ms | 1.0× | 0.6% | PASS |
| ac_reads | `index_join` | 13.47ms | 12.35ms | 0.9× | 3.3% | PASS |
| ac_reads | `index_join_scan` | 4.49ms | 7.10ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.30s | 1.42s | 1.1× | 2.1% | PASS |
| ac_reads | `table_scan` | 1.30s | 1.47s | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_read_only` | 185.27ms | 178.76ms | 1.0× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 16.57ms | 53.09ms | 3.2× | 6.0% | PASS |
| ac_writes | `oltp_insert_ac` | 19.04ms | 69.67ms | 3.7× | 4.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 19.42ms | 82.46ms | 4.2× | 5.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.67ms | 61.37ms | 3.7× | 5.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 18.89ms | 71.24ms | 3.8× | 4.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 18.15ms | 69.42ms | 3.8× | 6.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 16.85ms | 62.78ms | 3.7× | 5.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.42ms | 78.83ms | 3.0× | 4.0% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.39ms | 42.74ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 19.63ms | 23.53ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_sum_range` | 17.34ms | 22.45ms | 1.3× | 1.2% | PASS |
| mem_reads | `oltp_order_range` | 3.58ms | 4.22ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.59ms | 5.37ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.35ms | 6.47ms | 1.5× | 1.6% | PASS |
| mem_reads | `select_random_points` | 25.26ms | 31.37ms | 1.2× | 1.3% | PASS |
| mem_reads | `select_random_ranges` | 7.40ms | 9.30ms | 1.3× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 11.02ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 36.97ms | 43.06ms | 1.2× | 0.7% | PASS |
| mem_reads | `index_join` | 7.84ms | 11.75ms | 1.5× | 2.2% | PASS |
| mem_reads | `index_join_scan` | 3.91ms | 6.43ms | 1.6× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.5% | PASS |
| mem_reads | `table_scan` | 1.27s | 1.52s | 1.2× | 3.9% | PASS |
| mem_reads | `oltp_read_only` | 149.37ms | 184.94ms | 1.2× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 234.82ms | 345.84ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.16ms | 33.78ms | 1.9× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 64.15ms | 126.56ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_update_non_index` | 49.91ms | 88.52ms | 1.8× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 47.55ms | 95.94ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 26.30ms | 58.72ms | 2.2× | 1.5% | PASS |
| mem_writes | `types_delete_insert` | 32.23ms | 56.90ms | 1.8× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 104.20ms | 162.52ms | 1.6× | 2.8% | PASS |
| file_reads | `oltp_point_select` | 101.54ms | 60.36ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 27.26ms | 25.64ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_sum_range` | 25.17ms | 24.76ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 4.56ms | 4.54ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 5.65ms | 5.73ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 11.53ms | 8.54ms | 0.7× | 2.0% | PASS |
| file_reads | `select_random_points` | 34.67ms | 34.65ms | 1.0× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 14.72ms | 11.49ms | 0.8× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 15.44ms | 13.14ms | 0.9× | 1.3% | PASS |
| file_reads | `groupby_scan` | 38.39ms | 43.73ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 12.24ms | 13.39ms | 1.1× | 2.6% | PASS |
| file_reads | `index_join_scan` | 4.97ms | 6.92ms | 1.4× | 2.4% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.42s | 1.3× | 1.0% | PASS |
| file_reads | `table_scan` | 1.25s | 1.52s | 1.2× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 254.19ms | 214.03ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 250.82ms | 360.03ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.70ms | 37.96ms | 1.5× | 2.6% | PASS |
| file_writes | `oltp_update_index` | 95.65ms | 142.05ms | 1.5× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 76.37ms | 96.57ms | 1.3× | 1.5% | PASS |
| file_writes | `oltp_delete_insert` | 77.08ms | 110.56ms | 1.4× | 2.2% | PASS |
| file_writes | `oltp_write_only` | 53.11ms | 66.53ms | 1.3× | 2.5% | PASS |
| file_writes | `types_delete_insert` | 50.85ms | 63.30ms | 1.2× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 134.00ms | 170.83ms | 1.3× | 1.7% | PASS |
| ac_reads | `oltp_point_select` | 55.95ms | 61.27ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_range_select` | 22.80ms | 25.75ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 20.35ms | 24.76ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 4.05ms | 4.55ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 5.02ms | 5.72ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 6.99ms | 8.59ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 28.89ms | 34.35ms | 1.2× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 10.09ms | 11.55ms | 1.1× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.72ms | 13.13ms | 1.2× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 37.44ms | 43.47ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 9.65ms | 13.32ms | 1.4× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 4.44ms | 6.92ms | 1.6× | 2.3% | PASS |
| ac_reads | `types_table_scan` | 1.11s | 1.42s | 1.3× | 1.9% | PASS |
| ac_reads | `table_scan` | 1.29s | 1.52s | 1.2× | 4.1% | PASS |
| ac_reads | `oltp_read_only` | 185.74ms | 214.46ms | 1.2× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.15ms | 62.03ms | 2.9× | 7.5% | PASS |
| ac_writes | `oltp_insert_ac` | 23.08ms | 75.99ms | 3.3× | 8.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.26ms | 88.57ms | 3.5× | 10.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.68ms | 70.67ms | 3.1× | 7.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.10ms | 78.71ms | 3.4× | 5.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.91ms | 77.41ms | 3.2× | 6.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.85ms | 73.33ms | 3.5× | 15.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.01ms | 86.13ms | 2.8× | 6.7% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 31s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.46ms | 38.00ms | 53.8% | 1.6% | PASS |
| `status_dirty_many_tables` | 23.40ms | 42.00ms | 55.7% | 2.2% | PASS |
| `diff_regular_working_one_table` | 17.84ms | 33.00ms | 54.1% | 1.8% | PASS |
| `diff_regular_working_many_tables` | 25.04ms | 50.00ms | 50.1% | 1.4% | PASS |
| `diff_stat_working_many_tables` | 26.17ms | 48.00ms | 54.5% | 1.3% | PASS |
| `diff_schema_working_many_tables` | 26.42ms | 48.00ms | 55.0% | 1.1% | PASS |
| `branch_list_many_branches` | 14.97ms | 25.00ms | 59.9% | 3.5% | PASS |
| `branch_create_delete` | 16.00ms | 27.00ms | 59.3% | 2.6% | PASS |
| `at_literal_deep_history` | 16.28ms | 28.00ms | 58.2% | 1.3% | PASS |
| `diff_literal_deep_history` | 16.40ms | 28.00ms | 58.6% | 1.8% | PASS |
| `history_literal_deep_history` | 17.26ms | 30.00ms | 57.5% | 2.4% | PASS |
| `checkout_branch_clean` | 21.82ms | 43.00ms | 50.7% | 2.0% | PASS |
| `merge_data_no_conflicts` | 18.46ms | 33.00ms | 55.9% | 1.5% | PASS |
| `merge_data_secondary_index` | 669.45ms | 944.00ms | 70.9% | 1.1% | PASS |
| `merge_schema_no_conflicts` | 12.48ms | 24.00ms | 52.0% | 1.8% | PASS |
| `merge_data_conflicts` | 19.26ms | 33.00ms | 58.4% | 0.9% | PASS |
| `merge_data_conflicts_with_resolve` | 20.28ms | 34.00ms | 59.6% | 2.6% | PASS |

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
| copy_fsync | candidate | 482.772 | 389.600–532.256 | 32.249 | 207.14 | 107968266 |
| push_initial | candidate | 765.119 | 763.897–799.201 | 407.210 | 130.70 | 107956772 |
| clone_initial | candidate | 864.923 | 860.882–867.796 | 506.036 | 115.62 | 108475035 |
| push_noop | candidate | 0.622 | 0.556–0.656 | 0.320 | — | 0 |
| fetch_noop | candidate | 0.148 | 0.141–0.652 | 0.150 | — | 0 |
| push_incremental | candidate | 165.056 | 162.385–180.474 | 149.288 | 6.06 | 7909775 |
| fetch_incremental | candidate | 85.907 | 82.328–89.642 | 66.526 | 11.64 | 7910084 |
| pull_fast_forward | candidate | 74.658 | 73.790–90.456 | 58.254 | 13.39 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.53 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.75 | 295.068 | 109.784 | 47235 | 2337 |
| push_noop | candidate | 46.03 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.03 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.03 | 96.555 | 7.910 | 22335 | 125 |
| fetch_incremental | candidate | 46.03 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.03 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2652.102 | 2630.728–2678.279 | 377.711 | 377.06 | 1087718031 |
| push_initial | candidate | 8048.396 | 8040.996–8055.218 | 5844.764 | 124.25 | 1079566275 |
| clone_initial | candidate | 8848.036 | 8839.686–8890.676 | 8559.771 | 113.02 | 1102407326 |
| push_noop | candidate | 0.765 | 0.674–0.846 | 0.352 | — | 0 |
| fetch_noop | candidate | 0.227 | 0.215–0.242 | 0.229 | — | 0 |
| push_incremental | candidate | 1298.872 | 1284.677–1300.570 | 1293.705 | 0.77 | 15806003 |
| fetch_incremental | candidate | 270.373 | 269.031–271.374 | 264.768 | 3.70 | 15806513 |
| pull_fast_forward | candidate | 267.184 | 263.679–267.669 | 261.560 | 3.74 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.84 | 2091.556 | 1087.622 | 263419 | 20541 |
| clone_initial | candidate | 124.07 | 3516.124 | 1132.819 | 611944 | 32243 |
| push_noop | candidate | 47.30 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.30 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.29 | 616.018 | 15.928 | 149641 | 313 |
| fetch_incremental | candidate | 50.43 | 62.049 | 15.928 | 13850 | 313 |
| pull_fast_forward | candidate | 50.44 | 61.982 | 15.929 | 13846 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
