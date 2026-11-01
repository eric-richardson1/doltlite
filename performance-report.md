# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-01 18:09 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41325404104)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.73s | 11.78s | 1.2× | 1.8% | **PASS** |
| Writes | 2.03s | 3.41s | 1.7× | 1.5% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.87s | 12.03s | 1.1× | 1.8% | **PASS** |
| Writes | 3.24s | 3.97s | 1.2× | 2.1% | **PASS** |
| Autocommit writes | 781.28ms | 2.46s | 3.2× | 5.6% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.74s | 1.81s | 1.0× | 2.0% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.76s | 3.34s | 1.2× | 1.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.63s | 3.30s | 1.3× | 1.9% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.61s | 3.34s | 1.3× | 1.5% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 265.41ms | 451.04ms | 1.7× | 2.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 587.51ms | 986.74ms | 1.7× | 1.3% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 595.81ms | 995.17ms | 1.7× | 1.6% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 585.26ms | 981.59ms | 1.7× | 1.4% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.90s | 1.83s | 1.0× | 2.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.89s | 3.36s | 1.2× | 1.5% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.89s | 3.37s | 1.2× | 1.9% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.19s | 3.46s | 1.1× | 1.3% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 725.22ms | 725.83ms | 1.0× | 4.0% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 925.07ms | 1.09s | 1.2× | 3.6% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 830.99ms | 1.09s | 1.3× | 2.8% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 758.57ms | 1.06s | 1.4× | 1.3% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.71s | 1.80s | 1.1× | 1.9% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.76s | 3.36s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.67s | 3.35s | 1.3× | 1.8% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.71s | 3.39s | 1.3× | 1.2% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 173.09ms | 495.70ms | 2.9× | 4.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 196.43ms | 624.64ms | 3.2× | 5.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 221.16ms | 738.64ms | 3.3× | 10.5% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 190.61ms | 605.13ms | 3.2× | 5.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 17.01ms | 19.62ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 6.86ms | 7.55ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 6.43ms | 7.60ms | 1.2× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 1.77ms | 1.95ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 2.31ms | 2.47ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 2.64ms | 3.93ms | 1.5× | 1.3% | PASS |
| mem_reads | `select_random_points` | 9.01ms | 9.80ms | 1.1× | 2.2% | PASS |
| mem_reads | `select_random_ranges` | 2.97ms | 3.21ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 4.16ms | 6.03ms | 1.4× | 3.6% | PASS |
| mem_reads | `groupby_scan` | 19.26ms | 20.43ms | 1.1× | 1.6% | PASS |
| mem_reads | `index_join` | 3.59ms | 6.33ms | 1.8× | 6.5% | PASS |
| mem_reads | `index_join_scan` | 2.41ms | 4.15ms | 1.7× | 8.8% | PASS |
| mem_reads | `types_table_scan` | 714.43ms | 773.47ms | 1.1× | 1.3% | PASS |
| mem_reads | `table_scan` | 881.56ms | 875.05ms | 1.0× | 3.6% | PASS |
| mem_reads | `oltp_read_only` | 61.36ms | 67.52ms | 1.1× | 4.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 107.00ms | 173.71ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 9.12ms | 15.95ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 31.65ms | 60.69ms | 1.9× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 22.48ms | 38.35ms | 1.7× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 27.22ms | 47.37ms | 1.7× | 2.2% | PASS |
| mem_writes | `oltp_write_only` | 13.83ms | 30.62ms | 2.2× | 2.1% | PASS |
| mem_writes | `types_delete_insert` | 15.87ms | 21.61ms | 1.4× | 3.9% | PASS |
| mem_writes | `oltp_read_write` | 38.24ms | 62.74ms | 1.6× | 3.6% | PASS |
| file_reads | `oltp_point_select` | 68.07ms | 32.04ms | 0.5× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 11.79ms | 8.43ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 11.92ms | 8.73ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 2.39ms | 2.10ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 2.90ms | 2.61ms | 0.9× | 1.8% | PASS |
| file_reads | `oltp_index_scan` | 8.40ms | 5.20ms | 0.6× | 2.5% | PASS |
| file_reads | `select_random_points` | 13.41ms | 10.21ms | 0.8× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 8.21ms | 4.47ms | 0.5× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 10.26ms | 7.66ms | 0.7× | 2.0% | PASS |
| file_reads | `groupby_scan` | 19.62ms | 20.29ms | 1.0× | 1.3% | PASS |
| file_reads | `index_join` | 7.01ms | 6.90ms | 1.0× | 4.6% | PASS |
| file_reads | `index_join_scan` | 3.10ms | 4.54ms | 1.5× | 4.8% | PASS |
| file_reads | `types_table_scan` | 719.41ms | 761.75ms | 1.1× | 1.8% | PASS |
| file_reads | `table_scan` | 875.41ms | 868.82ms | 1.0× | 3.3% | PASS |
| file_reads | `oltp_read_only` | 140.24ms | 89.33ms | 0.6× | 1.6% | PASS |
| file_writes | `oltp_bulk_insert` | 148.01ms | 220.09ms | 1.5× | 2.9% | PASS |
| file_writes | `oltp_insert` | 19.85ms | 27.45ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 121.27ms | 107.29ms | 0.9× | 5.2% | PASS |
| file_writes | `oltp_update_non_index` | 100.80ms | 77.80ms | 0.8× | 1.8% | PASS |
| file_writes | `oltp_delete_insert` | 101.22ms | 89.11ms | 0.9× | 2.6% | PASS |
| file_writes | `oltp_write_only` | 71.89ms | 59.78ms | 0.8× | 5.0% | PASS |
| file_writes | `types_delete_insert` | 60.79ms | 46.75ms | 0.8× | 10.6% | PASS |
| file_writes | `oltp_read_write` | 101.38ms | 97.56ms | 1.0× | 6.1% | PASS |
| ac_reads | `oltp_point_select` | 32.07ms | 32.04ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 8.05ms | 8.45ms | 1.1× | 3.3% | PASS |
| ac_reads | `oltp_sum_range` | 8.21ms | 8.70ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_order_range` | 2.01ms | 2.07ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 2.55ms | 2.63ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 4.91ms | 5.27ms | 1.1× | 1.7% | PASS |
| ac_reads | `select_random_points` | 11.06ms | 10.93ms | 1.0× | 2.5% | PASS |
| ac_reads | `select_random_ranges` | 4.83ms | 4.56ms | 0.9× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 6.38ms | 7.47ms | 1.2× | 1.9% | PASS |
| ac_reads | `groupby_scan` | 18.84ms | 20.04ms | 1.1× | 1.9% | PASS |
| ac_reads | `index_join` | 4.83ms | 6.53ms | 1.4× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 2.54ms | 4.28ms | 1.7× | 2.3% | PASS |
| ac_reads | `types_table_scan` | 707.11ms | 753.52ms | 1.1× | 1.4% | PASS |
| ac_reads | `table_scan` | 809.16ms | 843.84ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 86.22ms | 87.52ms | 1.0× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.94ms | 52.55ms | 2.6× | 3.5% | PASS |
| ac_writes | `oltp_insert_ac` | 22.13ms | 62.04ms | 2.8× | 6.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.30ms | 69.06ms | 3.0× | 4.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.19ms | 58.23ms | 2.9× | 5.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.68ms | 64.07ms | 3.0× | 4.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 21.70ms | 63.82ms | 2.9× | 2.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.45ms | 57.65ms | 3.0× | 4.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.70ms | 68.28ms | 2.8× | 3.9% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.73ms | 40.74ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 16.85ms | 16.98ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_sum_range` | 14.96ms | 16.31ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 3.33ms | 3.65ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 4.30ms | 4.80ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.98ms | 6.92ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 22.56ms | 22.95ms | 1.0× | 3.2% | PASS |
| mem_reads | `select_random_ranges` | 6.72ms | 7.11ms | 1.1× | 1.0% | PASS |
| mem_reads | `covering_index_scan` | 8.03ms | 11.31ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 34.84ms | 38.29ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 10.82ms | 10.67ms | 1.0× | 2.1% | PASS |
| mem_reads | `index_join_scan` | 3.85ms | 6.81ms | 1.8× | 3.3% | PASS |
| mem_reads | `types_table_scan` | 1.18s | 1.46s | 1.2× | 4.4% | PASS |
| mem_reads | `table_scan` | 1.27s | 1.54s | 1.2× | 2.0% | PASS |
| mem_reads | `oltp_read_only` | 139.89ms | 155.43ms | 1.1× | 1.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 234.38ms | 361.29ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.54ms | 36.92ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 66.68ms | 141.19ms | 2.1× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 48.49ms | 83.55ms | 1.7× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 54.39ms | 104.78ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 28.16ms | 56.01ms | 2.0× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 37.96ms | 60.56ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 99.90ms | 142.43ms | 1.4× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 103.92ms | 58.80ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 24.23ms | 19.09ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 22.56ms | 18.46ms | 0.8× | 1.8% | PASS |
| file_reads | `oltp_order_range` | 4.25ms | 3.91ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 5.26ms | 5.12ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.13ms | 8.79ms | 0.8× | 1.0% | PASS |
| file_reads | `select_random_points` | 30.68ms | 25.90ms | 0.8× | 2.3% | PASS |
| file_reads | `select_random_ranges` | 14.12ms | 9.17ms | 0.6× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.65ms | 13.36ms | 0.9× | 1.2% | PASS |
| file_reads | `groupby_scan` | 36.12ms | 38.61ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 14.71ms | 12.01ms | 0.8× | 2.5% | PASS |
| file_reads | `index_join_scan` | 4.71ms | 7.08ms | 1.5× | 2.4% | PASS |
| file_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.3% | PASS |
| file_reads | `table_scan` | 1.26s | 1.53s | 1.2× | 1.5% | PASS |
| file_reads | `oltp_read_only` | 246.11ms | 184.67ms | 0.8× | 1.7% | PASS |
| file_writes | `oltp_bulk_insert` | 259.44ms | 376.77ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.30ms | 42.45ms | 1.7× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 133.10ms | 160.82ms | 1.2× | 10.5% | PASS |
| file_writes | `oltp_update_non_index` | 99.96ms | 97.68ms | 1.0× | 6.4% | PASS |
| file_writes | `oltp_delete_insert` | 98.08ms | 121.46ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 85.32ms | 68.72ms | 0.8× | 10.5% | PASS |
| file_writes | `types_delete_insert` | 73.28ms | 70.08ms | 1.0× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 150.59ms | 156.01ms | 1.0× | 5.3% | PASS |
| ac_reads | `oltp_point_select` | 59.52ms | 59.09ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_range_select` | 20.09ms | 19.08ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 18.11ms | 18.48ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_order_range` | 3.88ms | 3.92ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_distinct_range` | 4.80ms | 5.12ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 6.79ms | 8.81ms | 1.3× | 1.4% | PASS |
| ac_reads | `select_random_points` | 26.77ms | 25.93ms | 1.0× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 9.57ms | 9.18ms | 1.0× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 11.05ms | 13.32ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 35.77ms | 38.69ms | 1.1× | 0.8% | PASS |
| ac_reads | `index_join` | 12.74ms | 12.10ms | 1.0× | 1.9% | PASS |
| ac_reads | `index_join_scan` | 4.29ms | 6.98ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.26s | 1.53s | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 179.81ms | 184.41ms | 1.0× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.88ms | 63.32ms | 2.9× | 5.4% | PASS |
| ac_writes | `oltp_insert_ac` | 25.30ms | 74.50ms | 2.9× | 5.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.81ms | 89.79ms | 3.5× | 5.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.83ms | 70.13ms | 3.2× | 6.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.70ms | 84.68ms | 3.4× | 8.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.64ms | 82.04ms | 3.3× | 6.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.89ms | 74.16ms | 3.4× | 7.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.39ms | 86.01ms | 2.8× | 4.2% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.68ms | 40.91ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_range_select` | 16.98ms | 16.70ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 15.49ms | 16.17ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_order_range` | 3.35ms | 3.63ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.33ms | 4.82ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.06ms | 6.93ms | 1.7× | 2.1% | PASS |
| mem_reads | `select_random_points` | 22.06ms | 23.18ms | 1.1× | 3.3% | PASS |
| mem_reads | `select_random_ranges` | 6.72ms | 7.06ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 8.06ms | 11.23ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 34.54ms | 37.69ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 10.68ms | 11.03ms | 1.0× | 2.8% | PASS |
| mem_reads | `index_join_scan` | 3.72ms | 6.66ms | 1.8× | 2.5% | PASS |
| mem_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 1.9% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.52s | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_read_only` | 143.83ms | 156.45ms | 1.1× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 237.23ms | 363.33ms | 1.5× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 18.19ms | 37.74ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 66.28ms | 143.31ms | 2.2× | 2.3% | PASS |
| mem_writes | `oltp_update_non_index` | 48.81ms | 82.31ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 53.97ms | 106.45ms | 2.0× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 29.25ms | 57.43ms | 2.0× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 38.38ms | 60.42ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 103.69ms | 144.19ms | 1.4× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 106.86ms | 59.34ms | 0.6× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 24.97ms | 18.84ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 22.54ms | 18.03ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_order_range` | 4.36ms | 3.92ms | 0.9× | 1.8% | PASS |
| file_reads | `oltp_distinct_range` | 5.34ms | 5.10ms | 1.0× | 1.9% | PASS |
| file_reads | `oltp_index_scan` | 11.10ms | 8.77ms | 0.8× | 2.0% | PASS |
| file_reads | `select_random_points` | 30.30ms | 25.99ms | 0.9× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 13.87ms | 8.96ms | 0.6× | 1.7% | PASS |
| file_reads | `covering_index_scan` | 15.39ms | 13.24ms | 0.9× | 0.7% | PASS |
| file_reads | `groupby_scan` | 35.93ms | 38.15ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.52ms | 12.26ms | 0.8× | 2.6% | PASS |
| file_reads | `index_join_scan` | 4.88ms | 7.11ms | 1.5× | 2.4% | PASS |
| file_reads | `types_table_scan` | 1.14s | 1.45s | 1.3× | 2.4% | PASS |
| file_reads | `table_scan` | 1.21s | 1.52s | 1.3× | 2.4% | PASS |
| file_reads | `oltp_read_only` | 245.50ms | 183.64ms | 0.7× | 1.8% | PASS |
| file_writes | `oltp_bulk_insert` | 259.55ms | 379.81ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_insert` | 25.86ms | 42.93ms | 1.7× | 2.0% | PASS |
| file_writes | `oltp_update_index` | 99.55ms | 159.89ms | 1.6× | 3.0% | PASS |
| file_writes | `oltp_update_non_index` | 95.17ms | 96.12ms | 1.0× | 8.6% | PASS |
| file_writes | `oltp_delete_insert` | 90.44ms | 120.36ms | 1.3× | 3.2% | PASS |
| file_writes | `oltp_write_only` | 60.68ms | 70.41ms | 1.2× | 3.4% | PASS |
| file_writes | `types_delete_insert` | 64.93ms | 70.77ms | 1.1× | 2.6% | PASS |
| file_writes | `oltp_read_write` | 134.80ms | 154.43ms | 1.1× | 2.2% | PASS |
| ac_reads | `oltp_point_select` | 58.37ms | 58.55ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 19.56ms | 18.63ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_sum_range` | 17.72ms | 18.00ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_order_range` | 3.86ms | 3.91ms | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.87ms | 5.10ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.80ms | 8.87ms | 1.3× | 1.6% | PASS |
| ac_reads | `select_random_points` | 27.12ms | 27.57ms | 1.0× | 3.5% | PASS |
| ac_reads | `select_random_ranges` | 9.47ms | 9.06ms | 1.0× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 11.21ms | 13.37ms | 1.2× | 1.8% | PASS |
| ac_reads | `groupby_scan` | 35.49ms | 38.25ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 12.70ms | 12.27ms | 1.0× | 2.1% | PASS |
| ac_reads | `index_join_scan` | 4.34ms | 7.15ms | 1.6× | 2.9% | PASS |
| ac_reads | `types_table_scan` | 1.09s | 1.43s | 1.3× | 1.7% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.51s | 1.3× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 175.53ms | 182.90ms | 1.0× | 1.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 25.63ms | 76.17ms | 3.0× | 14.4% | PASS |
| ac_writes | `oltp_insert_ac` | 27.09ms | 93.86ms | 3.5× | 10.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 28.54ms | 105.53ms | 3.7× | 6.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 24.73ms | 85.50ms | 3.5× | 13.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.51ms | 95.35ms | 3.5× | 10.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 27.98ms | 93.46ms | 3.3× | 13.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 25.31ms | 87.48ms | 3.5× | 9.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 34.37ms | 101.29ms | 2.9× | 7.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.55ms | 42.52ms | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 18.99ms | 23.45ms | 1.2× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 17.20ms | 22.46ms | 1.3× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 3.58ms | 4.22ms | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.50ms | 5.38ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.37ms | 6.47ms | 1.5× | 1.3% | PASS |
| mem_reads | `select_random_points` | 24.66ms | 31.41ms | 1.3× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 7.20ms | 9.31ms | 1.3× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 7.97ms | 10.96ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 36.59ms | 42.88ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 7.86ms | 11.48ms | 1.5× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.95ms | 6.68ms | 1.7× | 2.8% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.43s | 1.3× | 1.4% | PASS |
| mem_reads | `table_scan` | 1.19s | 1.51s | 1.3× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 149.81ms | 186.11ms | 1.2× | 2.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 239.74ms | 353.66ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.45ms | 34.26ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 64.85ms | 126.60ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 49.19ms | 88.46ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 48.00ms | 96.22ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 26.71ms | 59.57ms | 2.2× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 32.75ms | 57.49ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 105.55ms | 165.32ms | 1.6× | 1.4% | PASS |
| file_reads | `oltp_point_select` | 103.09ms | 60.91ms | 0.6× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 27.48ms | 25.70ms | 0.9× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 24.90ms | 24.66ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 4.47ms | 4.53ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.65ms | 5.77ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 12.13ms | 8.75ms | 0.7× | 1.3% | PASS |
| file_reads | `select_random_points` | 36.82ms | 35.83ms | 1.0× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 15.39ms | 11.59ms | 0.8× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.86ms | 13.23ms | 0.8× | 1.2% | PASS |
| file_reads | `groupby_scan` | 38.46ms | 43.67ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 12.65ms | 13.66ms | 1.1× | 1.3% | PASS |
| file_reads | `index_join_scan` | 5.23ms | 7.14ms | 1.4× | 3.1% | PASS |
| file_reads | `types_table_scan` | 1.20s | 1.44s | 1.2× | 0.7% | PASS |
| file_reads | `table_scan` | 1.43s | 1.55s | 1.1× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 261.24ms | 216.41ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 253.81ms | 366.08ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.76ms | 38.61ms | 1.5× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 96.88ms | 143.35ms | 1.5× | 1.0% | PASS |
| file_writes | `oltp_update_non_index` | 75.93ms | 96.88ms | 1.3× | 1.3% | PASS |
| file_writes | `oltp_delete_insert` | 74.43ms | 109.45ms | 1.5× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 50.43ms | 65.69ms | 1.3× | 1.3% | PASS |
| file_writes | `types_delete_insert` | 49.34ms | 63.20ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 131.98ms | 172.79ms | 1.3× | 1.4% | PASS |
| ac_reads | `oltp_point_select` | 56.84ms | 60.44ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 23.01ms | 25.77ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 20.61ms | 24.85ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 4.04ms | 4.54ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 5.03ms | 5.75ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 7.14ms | 8.65ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 29.93ms | 35.68ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 10.41ms | 11.63ms | 1.1× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.81ms | 13.21ms | 1.2× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 37.64ms | 43.53ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 9.62ms | 13.40ms | 1.4× | 1.5% | PASS |
| ac_reads | `index_join_scan` | 4.43ms | 7.08ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 1.09s | 1.42s | 1.3× | 1.1% | PASS |
| ac_reads | `table_scan` | 1.22s | 1.51s | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_read_only` | 182.06ms | 212.60ms | 1.2× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.87ms | 61.86ms | 3.0× | 5.2% | PASS |
| ac_writes | `oltp_insert_ac` | 24.25ms | 75.33ms | 3.1× | 5.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.98ms | 85.73ms | 3.4× | 4.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.79ms | 68.96ms | 3.2× | 5.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.17ms | 77.66ms | 3.4× | 4.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.88ms | 77.47ms | 3.2× | 5.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.61ms | 71.89ms | 3.3× | 8.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.05ms | 86.23ms | 2.9× | 4.8% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 26s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 25.00ms | 38.00ms | 65.8% | 0.9% | PASS |
| `status_dirty_many_tables` | 27.69ms | 42.00ms | 65.9% | 0.6% | PASS |
| `diff_regular_working_one_table` | 21.21ms | 33.00ms | 64.3% | 0.8% | PASS |
| `diff_regular_working_many_tables` | 31.45ms | 50.00ms | 62.9% | 0.7% | PASS |
| `diff_stat_working_many_tables` | 31.57ms | 48.00ms | 65.8% | 0.6% | PASS |
| `diff_schema_working_many_tables` | 31.87ms | 48.00ms | 66.4% | 0.7% | PASS |
| `branch_list_many_branches` | 16.24ms | 25.00ms | 65.0% | 1.1% | PASS |
| `branch_create_delete` | 17.65ms | 27.00ms | 65.4% | 1.4% | PASS |
| `at_literal_deep_history` | 17.66ms | 28.00ms | 63.1% | 1.3% | PASS |
| `diff_literal_deep_history` | 17.94ms | 28.00ms | 64.1% | 1.2% | PASS |
| `history_literal_deep_history` | 19.12ms | 30.00ms | 63.7% | 1.9% | PASS |
| `checkout_branch_clean` | 24.43ms | 43.00ms | 56.8% | 1.4% | PASS |
| `merge_data_no_conflicts` | 20.15ms | 33.00ms | 61.1% | 1.6% | PASS |
| `merge_data_secondary_index` | 772.63ms | 944.00ms | 81.8% | 2.1% | PASS |
| `merge_schema_no_conflicts` | 15.01ms | 24.00ms | 62.5% | 2.0% | PASS |
| `merge_data_conflicts` | 21.85ms | 33.00ms | 66.2% | 0.9% | PASS |
| `merge_data_conflicts_with_resolve` | 22.75ms | 34.00ms | 66.9% | 1.0% | PASS |

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
| copy_fsync | candidate | 439.314 | 405.646–507.437 | 31.450 | 227.63 | 107968266 |
| push_initial | candidate | 780.568 | 770.518–795.547 | 402.839 | 128.11 | 107956772 |
| clone_initial | candidate | 883.708 | 881.873–893.445 | 521.231 | 113.16 | 108475035 |
| push_noop | candidate | 0.569 | 0.555–0.609 | 0.330 | — | 0 |
| fetch_noop | candidate | 0.201 | 0.174–0.212 | 0.204 | — | 0 |
| push_incremental | candidate | 189.174 | 180.641–204.367 | 164.952 | 5.29 | 7909775 |
| fetch_incremental | candidate | 89.301 | 85.628–123.360 | 71.167 | 11.20 | 7910084 |
| pull_fast_forward | candidate | 82.309 | 77.367–155.560 | 62.781 | 12.15 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.46 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.84 | 295.144 | 109.784 | 47253 | 2337 |
| push_noop | candidate | 45.97 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.97 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.97 | 96.613 | 7.910 | 22349 | 125 |
| fetch_incremental | candidate | 45.97 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.97 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5573.422 | 5421.381–5581.293 | 323.756 | 179.42 | 1087718031 |
| push_initial | candidate | 7354.907 | 7338.765–7460.360 | 3560.043 | 135.96 | 1079566275 |
| clone_initial | candidate | 9277.915 | 9259.273–9287.335 | 5455.934 | 107.78 | 1102407326 |
| push_noop | candidate | 0.800 | 0.767–0.819 | 0.236 | — | 0 |
| fetch_noop | candidate | 0.130 | 0.121–0.130 | 0.131 | — | 0 |
| push_incremental | candidate | 871.845 | 867.123–873.113 | 821.516 | 1.15 | 15806003 |
| fetch_incremental | candidate | 269.198 | 269.184–269.761 | 191.285 | 3.71 | 15806513 |
| pull_fast_forward | candidate | 269.218 | 247.902–274.930 | 189.619 | 3.71 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.80 | 2091.462 | 1087.622 | 263396 | 20541 |
| clone_initial | candidate | 123.93 | 3521.294 | 1132.819 | 613148 | 32243 |
| push_noop | candidate | 47.07 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.07 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 617.944 | 15.928 | 150089 | 313 |
| fetch_incremental | candidate | 50.39 | 61.885 | 15.928 | 13810 | 313 |
| pull_fast_forward | candidate | 50.39 | 61.818 | 15.929 | 13806 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
