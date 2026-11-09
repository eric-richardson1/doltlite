# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-09 21:52 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261101.186.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/42688411951)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.08s | 10.78s | 1.2× | 1.9% | **PASS** |
| Writes | 1.87s | 3.12s | 1.7× | 1.5% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.23s | 11.05s | 1.1× | 1.7% | **PASS** |
| Writes | 3.55s | 4.01s | 1.1× | 3.0% | **PASS** |
| Autocommit writes | 745.39ms | 2.33s | 3.1× | 6.3% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.64s | 1.76s | 1.1× | 2.6% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.74s | 3.30s | 1.2× | 2.0% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.52s | 3.27s | 1.3× | 1.4% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.18s | 2.45s | 1.1× | 1.6% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 263.15ms | 455.29ms | 1.7× | 2.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 582.56ms | 986.44ms | 1.7× | 1.3% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 574.17ms | 963.29ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 449.78ms | 714.39ms | 1.6× | 1.4% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.80s | 1.77s | 1.0× | 2.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.10s | 3.40s | 1.1× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.75s | 3.33s | 1.2× | 1.8% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.58s | 2.55s | 1.0× | 1.2% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 736.62ms | 726.62ms | 1.0× | 3.5% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 953.11ms | 1.12s | 1.2× | 3.8% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 808.10ms | 1.08s | 1.3× | 1.5% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.06s | 1.09s | 1.0× | 5.0% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.68s | 1.77s | 1.1× | 2.7% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.86s | 3.39s | 1.2× | 1.8% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.59s | 3.33s | 1.3× | 2.0% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.64s | 2.60s | 1.0× | 1.3% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 176.70ms | 501.42ms | 2.8× | 5.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 215.56ms | 682.66ms | 3.2× | 6.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 192.52ms | 609.86ms | 3.2× | 4.3% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 160.61ms | 537.97ms | 3.3× | 10.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 14.76ms | 17.95ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 5.76ms | 6.91ms | 1.2× | 2.9% | PASS |
| mem_reads | `oltp_sum_range` | 5.42ms | 6.93ms | 1.3× | 4.4% | PASS |
| mem_reads | `oltp_order_range` | 1.57ms | 1.78ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_distinct_range` | 2.12ms | 2.27ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_index_scan` | 2.35ms | 3.25ms | 1.4× | 4.0% | PASS |
| mem_reads | `select_random_points` | 7.63ms | 8.28ms | 1.1× | 4.4% | PASS |
| mem_reads | `select_random_ranges` | 2.65ms | 2.97ms | 1.1× | 2.9% | PASS |
| mem_reads | `covering_index_scan` | 3.90ms | 5.53ms | 1.4× | 2.5% | PASS |
| mem_reads | `groupby_scan` | 18.08ms | 19.34ms | 1.1× | 1.5% | PASS |
| mem_reads | `index_join` | 3.51ms | 5.52ms | 1.6× | 4.2% | PASS |
| mem_reads | `index_join_scan` | 2.27ms | 4.08ms | 1.8× | 6.8% | PASS |
| mem_reads | `types_table_scan` | 729.68ms | 773.55ms | 1.1× | 1.4% | PASS |
| mem_reads | `table_scan` | 786.46ms | 836.01ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 56.61ms | 65.03ms | 1.1× | 2.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 104.47ms | 172.15ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_insert` | 9.00ms | 15.91ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_index` | 32.19ms | 62.70ms | 1.9× | 1.9% | PASS |
| mem_writes | `oltp_update_non_index` | 23.64ms | 40.28ms | 1.7× | 2.1% | PASS |
| mem_writes | `oltp_delete_insert` | 27.65ms | 48.66ms | 1.8× | 2.4% | PASS |
| mem_writes | `oltp_write_only` | 14.31ms | 31.58ms | 2.2× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 15.89ms | 22.50ms | 1.4× | 3.0% | PASS |
| mem_writes | `oltp_read_write` | 36.00ms | 61.51ms | 1.7× | 3.3% | PASS |
| file_reads | `oltp_point_select` | 66.37ms | 31.30ms | 0.5× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 11.71ms | 8.50ms | 0.7× | 2.8% | PASS |
| file_reads | `oltp_sum_range` | 11.36ms | 8.56ms | 0.8× | 2.2% | PASS |
| file_reads | `oltp_order_range` | 2.27ms | 2.01ms | 0.9× | 2.6% | PASS |
| file_reads | `oltp_distinct_range` | 2.82ms | 2.51ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_index_scan` | 8.04ms | 5.03ms | 0.6× | 2.0% | PASS |
| file_reads | `select_random_points` | 13.38ms | 10.15ms | 0.8× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 8.35ms | 4.58ms | 0.5× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 10.11ms | 7.62ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 19.83ms | 20.62ms | 1.0× | 0.9% | PASS |
| file_reads | `index_join` | 6.86ms | 6.89ms | 1.0× | 4.4% | PASS |
| file_reads | `index_join_scan` | 3.05ms | 4.48ms | 1.5× | 2.7% | PASS |
| file_reads | `types_table_scan` | 698.37ms | 739.75ms | 1.1× | 1.7% | PASS |
| file_reads | `table_scan` | 805.96ms | 829.89ms | 1.0× | 2.5% | PASS |
| file_reads | `oltp_read_only` | 134.84ms | 87.60ms | 0.6× | 2.9% | PASS |
| file_writes | `oltp_bulk_insert` | 141.25ms | 219.35ms | 1.6× | 3.2% | PASS |
| file_writes | `oltp_insert` | 19.78ms | 27.11ms | 1.4× | 3.0% | PASS |
| file_writes | `oltp_update_index` | 121.40ms | 109.05ms | 0.9× | 1.7% | PASS |
| file_writes | `oltp_update_non_index` | 100.93ms | 78.79ms | 0.8× | 3.9% | PASS |
| file_writes | `oltp_delete_insert` | 105.28ms | 92.94ms | 0.9× | 3.8% | PASS |
| file_writes | `oltp_write_only` | 81.11ms | 59.58ms | 0.7× | 2.2% | PASS |
| file_writes | `types_delete_insert` | 60.98ms | 45.26ms | 0.7× | 10.6% | PASS |
| file_writes | `oltp_read_write` | 105.89ms | 94.54ms | 0.9× | 5.0% | PASS |
| ac_reads | `oltp_point_select` | 31.89ms | 31.85ms | 1.0× | 2.7% | PASS |
| ac_reads | `oltp_range_select` | 8.48ms | 8.58ms | 1.0× | 2.8% | PASS |
| ac_reads | `oltp_sum_range` | 7.75ms | 8.68ms | 1.1× | 3.2% | PASS |
| ac_reads | `oltp_order_range` | 1.87ms | 2.00ms | 1.1× | 3.6% | PASS |
| ac_reads | `oltp_distinct_range` | 2.37ms | 2.49ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_index_scan` | 4.72ms | 5.09ms | 1.1× | 2.2% | PASS |
| ac_reads | `select_random_points` | 10.00ms | 10.41ms | 1.0× | 4.1% | PASS |
| ac_reads | `select_random_ranges` | 4.69ms | 4.46ms | 1.0× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 5.90ms | 7.21ms | 1.2× | 3.3% | PASS |
| ac_reads | `groupby_scan` | 18.93ms | 20.27ms | 1.1× | 1.7% | PASS |
| ac_reads | `index_join` | 4.81ms | 6.57ms | 1.4× | 2.7% | PASS |
| ac_reads | `index_join_scan` | 2.66ms | 4.46ms | 1.7× | 4.1% | PASS |
| ac_reads | `types_table_scan` | 700.29ms | 747.95ms | 1.1× | 1.9% | PASS |
| ac_reads | `table_scan` | 793.25ms | 821.53ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_read_only` | 84.32ms | 86.24ms | 1.0× | 2.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.06ms | 53.25ms | 2.7× | 5.4% | PASS |
| ac_writes | `oltp_insert_ac` | 22.43ms | 62.62ms | 2.8× | 4.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.83ms | 73.10ms | 2.9× | 7.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.76ms | 58.93ms | 2.8× | 4.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.13ms | 63.56ms | 2.9× | 6.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.16ms | 63.51ms | 2.9× | 4.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.02ms | 58.15ms | 2.9× | 5.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.32ms | 68.30ms | 2.8× | 5.1% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.80ms | 40.94ms | 1.1× | 2.5% | PASS |
| mem_reads | `oltp_range_select` | 16.96ms | 16.95ms | 1.0× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 15.11ms | 16.10ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_order_range` | 3.36ms | 3.61ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.33ms | 4.78ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.04ms | 6.89ms | 1.7× | 1.5% | PASS |
| mem_reads | `select_random_points` | 23.01ms | 23.65ms | 1.0× | 3.9% | PASS |
| mem_reads | `select_random_ranges` | 6.89ms | 7.10ms | 1.0× | 2.1% | PASS |
| mem_reads | `covering_index_scan` | 8.06ms | 11.28ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 35.24ms | 38.18ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 10.47ms | 10.78ms | 1.0× | 2.4% | PASS |
| mem_reads | `index_join_scan` | 3.87ms | 6.80ms | 1.8× | 2.3% | PASS |
| mem_reads | `types_table_scan` | 1.13s | 1.43s | 1.3× | 1.5% | PASS |
| mem_reads | `table_scan` | 1.30s | 1.53s | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_read_only` | 140.53ms | 154.97ms | 1.1× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 232.88ms | 361.51ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.42ms | 37.01ms | 2.1× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 65.54ms | 141.62ms | 2.2× | 1.7% | PASS |
| mem_writes | `oltp_update_non_index` | 48.18ms | 82.88ms | 1.7× | 2.1% | PASS |
| mem_writes | `oltp_delete_insert` | 53.69ms | 104.79ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 27.90ms | 55.88ms | 2.0× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 38.98ms | 60.62ms | 1.6× | 3.0% | PASS |
| mem_writes | `oltp_read_write` | 97.96ms | 142.13ms | 1.5× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 105.41ms | 59.75ms | 0.6× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 24.85ms | 19.23ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 23.05ms | 18.50ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.37ms | 3.91ms | 0.9× | 2.7% | PASS |
| file_reads | `oltp_distinct_range` | 5.46ms | 5.14ms | 0.9× | 2.3% | PASS |
| file_reads | `oltp_index_scan` | 11.13ms | 8.79ms | 0.8× | 1.2% | PASS |
| file_reads | `select_random_points` | 31.29ms | 25.84ms | 0.8× | 2.6% | PASS |
| file_reads | `select_random_ranges` | 14.13ms | 9.14ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.57ms | 13.41ms | 0.9× | 1.8% | PASS |
| file_reads | `groupby_scan` | 36.36ms | 38.51ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 14.96ms | 12.13ms | 0.8× | 2.0% | PASS |
| file_reads | `index_join_scan` | 4.84ms | 7.19ms | 1.5× | 2.8% | PASS |
| file_reads | `types_table_scan` | 1.15s | 1.44s | 1.2× | 2.8% | PASS |
| file_reads | `table_scan` | 1.40s | 1.55s | 1.1× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 254.98ms | 186.96ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 259.64ms | 380.15ms | 1.5× | 0.9% | PASS |
| file_writes | `oltp_insert` | 26.09ms | 43.53ms | 1.7× | 2.2% | PASS |
| file_writes | `oltp_update_index` | 142.88ms | 167.18ms | 1.2× | 5.3% | PASS |
| file_writes | `oltp_update_non_index` | 103.34ms | 99.82ms | 1.0× | 14.8% | PASS |
| file_writes | `oltp_delete_insert` | 100.11ms | 125.31ms | 1.3× | 2.0% | PASS |
| file_writes | `oltp_write_only` | 89.95ms | 71.41ms | 0.8× | 11.0% | PASS |
| file_writes | `types_delete_insert` | 75.48ms | 71.92ms | 1.0× | 2.2% | PASS |
| file_writes | `oltp_read_write` | 155.62ms | 159.84ms | 1.0× | 6.6% | PASS |
| ac_reads | `oltp_point_select` | 60.02ms | 60.04ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 20.53ms | 19.33ms | 0.9× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 18.65ms | 18.45ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_order_range` | 3.95ms | 3.96ms | 1.0× | 2.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.94ms | 5.12ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.67ms | 8.84ms | 1.3× | 1.6% | PASS |
| ac_reads | `select_random_points` | 26.54ms | 26.35ms | 1.0× | 2.4% | PASS |
| ac_reads | `select_random_ranges` | 9.51ms | 9.11ms | 1.0× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 11.12ms | 13.48ms | 1.2× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 36.25ms | 38.93ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 13.48ms | 12.33ms | 0.9× | 2.9% | PASS |
| ac_reads | `index_join_scan` | 4.43ms | 7.32ms | 1.7× | 2.5% | PASS |
| ac_reads | `types_table_scan` | 1.17s | 1.44s | 1.2× | 3.2% | PASS |
| ac_reads | `table_scan` | 1.30s | 1.54s | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 179.06ms | 184.48ms | 1.0× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.78ms | 70.16ms | 3.0× | 9.7% | PASS |
| ac_writes | `oltp_insert_ac` | 27.99ms | 81.61ms | 2.9× | 6.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 28.70ms | 98.89ms | 3.4× | 4.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.57ms | 77.50ms | 3.4× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.55ms | 92.14ms | 3.3× | 7.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 27.28ms | 85.83ms | 3.1× | 8.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 24.21ms | 81.87ms | 3.4× | 11.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 33.47ms | 94.65ms | 2.8× | 6.6% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.33ms | 40.17ms | 1.2× | 2.2% | PASS |
| mem_reads | `oltp_range_select` | 16.40ms | 17.61ms | 1.1× | 2.1% | PASS |
| mem_reads | `oltp_sum_range` | 13.91ms | 16.62ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 3.15ms | 3.62ms | 1.1× | 2.7% | PASS |
| mem_reads | `oltp_distinct_range` | 4.06ms | 4.80ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.75ms | 6.69ms | 1.8× | 1.5% | PASS |
| mem_reads | `select_random_points` | 19.06ms | 22.22ms | 1.2× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 6.04ms | 6.91ms | 1.1× | 4.4% | PASS |
| mem_reads | `covering_index_scan` | 8.02ms | 11.21ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 34.16ms | 38.12ms | 1.1× | 1.0% | PASS |
| mem_reads | `index_join` | 10.23ms | 10.90ms | 1.1× | 2.7% | PASS |
| mem_reads | `index_join_scan` | 3.67ms | 6.57ms | 1.8× | 2.7% | PASS |
| mem_reads | `types_table_scan` | 1.07s | 1.41s | 1.3× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.16s | 1.52s | 1.3× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 130.10ms | 154.11ms | 1.2× | 0.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.65ms | 359.25ms | 1.5× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 17.89ms | 36.73ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 60.89ms | 133.32ms | 2.2× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 44.57ms | 78.69ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_delete_insert` | 49.86ms | 100.01ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 27.41ms | 54.97ms | 2.0× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 36.78ms | 58.45ms | 1.6× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 100.12ms | 141.86ms | 1.4× | 3.1% | PASS |
| file_reads | `oltp_point_select` | 104.35ms | 59.07ms | 0.6× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 23.97ms | 19.66ms | 0.8× | 2.0% | PASS |
| file_reads | `oltp_sum_range` | 22.62ms | 19.33ms | 0.9× | 2.3% | PASS |
| file_reads | `oltp_order_range` | 4.36ms | 3.99ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.35ms | 5.19ms | 1.0× | 2.5% | PASS |
| file_reads | `oltp_index_scan` | 11.39ms | 8.89ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_points` | 31.23ms | 25.84ms | 0.8× | 2.2% | PASS |
| file_reads | `select_random_ranges` | 14.10ms | 9.08ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.74ms | 13.45ms | 0.9× | 1.1% | PASS |
| file_reads | `groupby_scan` | 35.39ms | 38.61ms | 1.1× | 1.2% | PASS |
| file_reads | `index_join` | 14.65ms | 12.36ms | 0.8× | 2.0% | PASS |
| file_reads | `index_join_scan` | 4.70ms | 6.89ms | 1.5× | 2.6% | PASS |
| file_reads | `types_table_scan` | 1.06s | 1.41s | 1.3× | 0.8% | PASS |
| file_reads | `table_scan` | 1.17s | 1.52s | 1.3× | 0.7% | PASS |
| file_reads | `oltp_read_only` | 235.47ms | 184.65ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 254.85ms | 376.56ms | 1.5× | 0.6% | PASS |
| file_writes | `oltp_insert` | 25.07ms | 41.98ms | 1.7× | 1.0% | PASS |
| file_writes | `oltp_update_index` | 94.94ms | 153.03ms | 1.6× | 1.2% | PASS |
| file_writes | `oltp_update_non_index` | 94.28ms | 93.29ms | 1.0× | 9.8% | PASS |
| file_writes | `oltp_delete_insert` | 88.41ms | 120.81ms | 1.4× | 1.9% | PASS |
| file_writes | `oltp_write_only` | 61.86ms | 70.51ms | 1.1× | 2.8% | PASS |
| file_writes | `types_delete_insert` | 62.87ms | 68.62ms | 1.1× | 1.1% | PASS |
| file_writes | `oltp_read_write` | 125.83ms | 151.05ms | 1.2× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 58.29ms | 59.78ms | 1.0× | 2.3% | PASS |
| ac_reads | `oltp_range_select` | 20.15ms | 19.95ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_sum_range` | 17.57ms | 19.07ms | 1.1× | 2.3% | PASS |
| ac_reads | `oltp_order_range` | 3.90ms | 4.01ms | 1.0× | 3.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.87ms | 5.21ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 6.64ms | 8.97ms | 1.4× | 2.1% | PASS |
| ac_reads | `select_random_points` | 24.25ms | 25.69ms | 1.1× | 3.4% | PASS |
| ac_reads | `select_random_ranges` | 8.68ms | 9.08ms | 1.0× | 1.8% | PASS |
| ac_reads | `covering_index_scan` | 10.84ms | 13.49ms | 1.2× | 1.6% | PASS |
| ac_reads | `groupby_scan` | 34.79ms | 38.82ms | 1.1× | 1.2% | PASS |
| ac_reads | `index_join` | 11.89ms | 12.43ms | 1.0× | 2.2% | PASS |
| ac_reads | `index_join_scan` | 4.17ms | 7.03ms | 1.7× | 2.0% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.40s | 1.3× | 0.5% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.52s | 1.3× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 166.89ms | 185.21ms | 1.1× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.55ms | 59.72ms | 2.8× | 3.3% | PASS |
| ac_writes | `oltp_insert_ac` | 24.82ms | 76.68ms | 3.1× | 6.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.15ms | 88.75ms | 3.5× | 4.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.64ms | 68.91ms | 3.3× | 3.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.37ms | 79.25ms | 3.3× | 4.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.32ms | 79.03ms | 3.2× | 4.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.80ms | 72.54ms | 3.3× | 6.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.89ms | 84.99ms | 2.8× | 4.1% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.17ms | 29.75ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 15.45ms | 17.02ms | 1.1× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 13.78ms | 16.20ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_order_range` | 2.88ms | 3.17ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.69ms | 4.00ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.64ms | 4.91ms | 1.3× | 2.5% | PASS |
| mem_reads | `select_random_points` | 22.02ms | 24.54ms | 1.1× | 3.2% | PASS |
| mem_reads | `select_random_ranges` | 6.04ms | 6.83ms | 1.1× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 5.92ms | 8.15ms | 1.4× | 1.6% | PASS |
| mem_reads | `groupby_scan` | 29.72ms | 32.95ms | 1.1× | 1.1% | PASS |
| mem_reads | `index_join` | 6.14ms | 8.84ms | 1.4× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 3.25ms | 5.39ms | 1.7× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 892.49ms | 1.03s | 1.2× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.03s | 1.13s | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_read_only` | 114.91ms | 131.15ms | 1.1× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 182.37ms | 257.43ms | 1.4× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 14.44ms | 25.29ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 52.83ms | 96.10ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 40.98ms | 65.87ms | 1.6× | 2.0% | PASS |
| mem_writes | `oltp_delete_insert` | 38.77ms | 71.61ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 22.12ms | 44.87ms | 2.0× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 24.75ms | 39.91ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 73.53ms | 113.30ms | 1.5× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 93.75ms | 46.27ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 23.11ms | 18.87ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 21.14ms | 18.03ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 3.77ms | 3.43ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_distinct_range` | 4.58ms | 4.25ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 10.89ms | 6.92ms | 0.6× | 0.9% | PASS |
| file_reads | `select_random_points` | 28.63ms | 25.85ms | 0.9× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 13.02ms | 8.57ms | 0.7× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 13.29ms | 9.92ms | 0.7× | 1.1% | PASS |
| file_reads | `groupby_scan` | 31.12ms | 33.37ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 10.34ms | 10.39ms | 1.0× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.08ms | 5.60ms | 1.4× | 1.9% | PASS |
| file_reads | `types_table_scan` | 974.99ms | 1.06s | 1.1× | 3.8% | PASS |
| file_reads | `table_scan` | 1.13s | 1.14s | 1.0× | 4.2% | PASS |
| file_reads | `oltp_read_only` | 214.62ms | 155.21ms | 0.7× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 234.40ms | 314.86ms | 1.3× | 4.6% | PASS |
| file_writes | `oltp_insert` | 33.60ms | 41.02ms | 1.2× | 7.9% | PASS |
| file_writes | `oltp_update_index` | 166.90ms | 164.40ms | 1.0× | 2.8% | PASS |
| file_writes | `oltp_update_non_index` | 137.16ms | 112.56ms | 0.8× | 2.5% | PASS |
| file_writes | `oltp_delete_insert` | 135.12ms | 127.15ms | 0.9× | 3.1% | PASS |
| file_writes | `oltp_write_only` | 99.03ms | 87.17ms | 0.9× | 6.0% | PASS |
| file_writes | `types_delete_insert` | 88.22ms | 80.52ms | 0.9× | 14.2% | PASS |
| file_writes | `oltp_read_write` | 162.62ms | 162.65ms | 1.0× | 5.4% | PASS |
| ac_reads | `oltp_point_select` | 48.08ms | 47.39ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 18.93ms | 19.13ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_sum_range` | 16.67ms | 18.28ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.37ms | 3.43ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.14ms | 4.26ms | 1.0× | 1.4% | PASS |
| ac_reads | `oltp_index_scan` | 6.28ms | 6.91ms | 1.1× | 0.9% | PASS |
| ac_reads | `select_random_points` | 23.30ms | 25.65ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 8.38ms | 8.63ms | 1.0× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 8.68ms | 10.04ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 30.80ms | 33.60ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 7.94ms | 10.55ms | 1.3× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 3.72ms | 5.94ms | 1.6× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.02s | 1.07s | 1.0× | 1.5% | PASS |
| ac_reads | `table_scan` | 1.28s | 1.18s | 0.9× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 153.00ms | 158.13ms | 1.0× | 2.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.66ms | 53.75ms | 2.9× | 10.8% | PASS |
| ac_writes | `oltp_insert_ac` | 20.08ms | 66.33ms | 3.3× | 8.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.46ms | 80.51ms | 3.8× | 9.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.49ms | 62.02ms | 3.4× | 12.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 18.99ms | 68.82ms | 3.6× | 8.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.84ms | 71.39ms | 3.6× | 11.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.28ms | 60.82ms | 3.5× | 12.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.81ms | 74.32ms | 2.9× | 8.0% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 16s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.17ms | 38.00ms | 82.0% | 1.1% | PASS |
| `status_dirty_many_tables` | 34.88ms | 42.00ms | 83.0% | 1.3% | PASS |
| `diff_regular_working_one_table` | 26.71ms | 33.00ms | 80.9% | 1.2% | PASS |
| `diff_regular_working_many_tables` | 39.28ms | 50.00ms | 78.6% | 0.9% | PASS |
| `diff_stat_working_many_tables` | 39.14ms | 48.00ms | 81.5% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 39.80ms | 48.00ms | 82.9% | 1.1% | PASS |
| `branch_list_many_branches` | 18.95ms | 25.00ms | 75.8% | 1.6% | PASS |
| `branch_create_delete` | 20.34ms | 27.00ms | 75.3% | 1.3% | PASS |
| `at_literal_deep_history` | 20.59ms | 28.00ms | 73.5% | 1.4% | PASS |
| `diff_literal_deep_history` | 20.71ms | 28.00ms | 74.0% | 1.5% | PASS |
| `history_literal_deep_history` | 21.93ms | 30.00ms | 73.1% | 0.9% | PASS |
| `checkout_branch_clean` | 29.10ms | 43.00ms | 67.7% | 1.2% | PASS |
| `merge_data_no_conflicts` | 23.64ms | 33.00ms | 71.7% | 1.0% | PASS |
| `merge_data_secondary_index` | 876.09ms | 944.00ms | 92.8% | 0.7% | PASS |
| `merge_schema_no_conflicts` | 17.62ms | 24.00ms | 73.4% | 1.6% | PASS |
| `merge_data_conflicts` | 26.54ms | 33.00ms | 80.4% | 0.8% | PASS |
| `merge_data_conflicts_with_resolve` | 27.28ms | 34.00ms | 80.2% | 1.2% | PASS |

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
| copy_fsync | candidate | 61.235 | 56.902–65.674 | 40.766 | 1633.05 | 107968266 |
| push_initial | candidate | 590.738 | 585.187–596.148 | 575.202 | 169.28 | 107956772 |
| clone_initial | candidate | 767.601 | 765.569–771.836 | 742.822 | 130.28 | 108475035 |
| push_noop | candidate | 0.706 | 0.594–0.774 | 0.390 | — | 0 |
| fetch_noop | candidate | 0.224 | 0.197–0.250 | 0.226 | — | 0 |
| push_incremental | candidate | 230.398 | 229.578–231.246 | 227.094 | 4.34 | 7909775 |
| fetch_incremental | candidate | 95.481 | 95.188–100.975 | 93.646 | 10.47 | 7910084 |
| pull_fast_forward | candidate | 84.424 | 83.840–85.815 | 81.891 | 11.84 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.56 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.88 | 295.007 | 109.784 | 47221 | 2337 |
| push_noop | candidate | 46.12 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.12 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.12 | 96.783 | 7.910 | 22391 | 125 |
| fetch_incremental | candidate | 46.12 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.12 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5768.267 | 5478.799–6331.451 | 312.554 | 173.36 | 1087718031 |
| push_initial | candidate | 7696.819 | 7663.026–7786.284 | 3969.530 | 129.92 | 1079566275 |
| clone_initial | candidate | 9518.895 | 9483.773–9522.683 | 5879.168 | 105.05 | 1102407326 |
| push_noop | candidate | 0.718 | 0.676–1.804 | 0.338 | — | 0 |
| fetch_noop | candidate | 0.147 | 0.142–0.163 | 0.149 | — | 0 |
| push_incremental | candidate | 914.651 | 912.793–934.259 | 869.496 | 1.09 | 15806003 |
| fetch_incremental | candidate | 264.968 | 264.287–292.506 | 200.068 | 3.77 | 15806513 |
| pull_fast_forward | candidate | 253.306 | 243.843–274.362 | 199.021 | 3.95 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.78 | 2091.981 | 1087.622 | 263523 | 20541 |
| clone_initial | candidate | 124.05 | 3534.044 | 1132.819 | 616289 | 32243 |
| push_noop | candidate | 47.19 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.19 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.29 | 623.314 | 15.928 | 151403 | 313 |
| fetch_incremental | candidate | 50.34 | 62.102 | 15.928 | 13863 | 313 |
| pull_fast_forward | candidate | 50.40 | 62.035 | 15.929 | 13859 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
