# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-23 23:34 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/45271630707)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.01s | 11.98s | 1.2× | 1.4% | **PASS** |
| Writes | 2.05s | 3.44s | 1.7× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.96s | 12.21s | 1.1× | 1.2% | **PASS** |
| Writes | 3.44s | 4.16s | 1.2× | 2.1% | **PASS** |
| Autocommit writes | 745.40ms | 2.42s | 3.2× | 7.6% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.66s | 2.94s | 1.1× | 1.7% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.11s | 2.42s | 1.1× | 1.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.63s | 3.30s | 1.3× | 1.6% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.61s | 3.33s | 1.3× | 1.3% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 440.69ms | 790.18ms | 1.8× | 1.8% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 447.68ms | 708.35ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 575.47ms | 972.18ms | 1.7× | 1.3% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 582.15ms | 968.08ms | 1.7× | 1.2% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.84s | 2.99s | 1.1× | 1.5% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.35s | 2.47s | 1.1× | 0.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.88s | 3.36s | 1.2× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.88s | 3.40s | 1.2× | 1.5% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 601.35ms | 844.41ms | 1.4× | 2.1% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.28s | 1.19s | 0.9× | 4.3% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 809.33ms | 1.08s | 1.3× | 1.8% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 750.12ms | 1.04s | 1.4× | 1.7% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.59s | 2.96s | 1.1× | 1.9% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.20s | 2.47s | 1.1× | 0.8% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.77s | 3.37s | 1.2× | 1.6% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.66s | 3.38s | 1.3× | 1.3% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 194.54ms | 631.56ms | 3.2× | 7.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 158.07ms | 525.32ms | 3.3× | 8.7% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 206.00ms | 662.11ms | 3.2× | 7.8% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 186.79ms | 602.25ms | 3.2× | 6.7% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.19ms | 32.05ms | 1.3× | 2.2% | PASS |
| mem_reads | `oltp_range_select` | 11.67ms | 13.06ms | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 9.99ms | 12.40ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 2.72ms | 3.16ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 3.65ms | 4.37ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.96ms | 5.91ms | 1.5× | 1.4% | PASS |
| mem_reads | `select_random_points` | 10.89ms | 12.17ms | 1.1× | 3.8% | PASS |
| mem_reads | `select_random_ranges` | 4.76ms | 5.52ms | 1.2× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 8.01ms | 11.14ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 31.03ms | 36.20ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 5.87ms | 9.40ms | 1.6× | 2.2% | PASS |
| mem_reads | `index_join_scan` | 3.38ms | 5.96ms | 1.8× | 3.5% | PASS |
| mem_reads | `types_table_scan` | 1.12s | 1.28s | 1.1× | 1.8% | PASS |
| mem_reads | `table_scan` | 1.30s | 1.37s | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 111.55ms | 133.00ms | 1.2× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.67ms | 305.97ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 15.09ms | 27.57ms | 1.8× | 1.4% | PASS |
| mem_writes | `oltp_update_index` | 51.87ms | 103.81ms | 2.0× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 36.05ms | 65.88ms | 1.8× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 45.97ms | 81.96ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 22.51ms | 50.68ms | 2.3× | 2.3% | PASS |
| mem_writes | `types_delete_insert` | 24.98ms | 39.58ms | 1.6× | 2.2% | PASS |
| mem_writes | `oltp_read_write` | 68.55ms | 114.73ms | 1.7× | 2.6% | PASS |
| file_reads | `oltp_point_select` | 92.47ms | 49.88ms | 0.5× | 1.2% | PASS |
| file_reads | `oltp_range_select` | 18.14ms | 14.93ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 16.77ms | 14.35ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.56ms | 3.42ms | 1.0× | 2.3% | PASS |
| file_reads | `oltp_distinct_range` | 4.49ms | 4.67ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.07ms | 7.81ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 18.07ms | 14.25ms | 0.8× | 4.0% | PASS |
| file_reads | `select_random_ranges` | 11.69ms | 7.46ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.36ms | 13.23ms | 0.9× | 1.5% | PASS |
| file_reads | `groupby_scan` | 31.96ms | 36.34ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 9.72ms | 10.64ms | 1.1× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.37ms | 6.29ms | 1.4× | 2.7% | PASS |
| file_reads | `types_table_scan` | 1.10s | 1.28s | 1.2× | 1.8% | PASS |
| file_reads | `table_scan` | 1.29s | 1.37s | 1.1× | 1.5% | PASS |
| file_reads | `oltp_read_only` | 212.96ms | 159.71ms | 0.7× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 189.22ms | 318.45ms | 1.7× | 1.0% | PASS |
| file_writes | `oltp_insert` | 21.94ms | 30.65ms | 1.4× | 2.3% | PASS |
| file_writes | `oltp_update_index` | 79.34ms | 110.50ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_update_non_index` | 60.00ms | 71.76ms | 1.2× | 2.8% | PASS |
| file_writes | `oltp_delete_insert` | 69.07ms | 92.34ms | 1.3× | 2.0% | PASS |
| file_writes | `oltp_write_only` | 45.10ms | 54.96ms | 1.2× | 2.4% | PASS |
| file_writes | `types_delete_insert` | 40.10ms | 44.95ms | 1.1× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 96.57ms | 120.80ms | 1.3× | 2.1% | PASS |
| ac_reads | `oltp_point_select` | 47.51ms | 50.46ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 14.43ms | 14.99ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 12.78ms | 14.46ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.13ms | 3.45ms | 1.1× | 2.3% | PASS |
| ac_reads | `oltp_distinct_range` | 3.94ms | 4.65ms | 1.2× | 2.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.44ms | 7.84ms | 1.2× | 2.7% | PASS |
| ac_reads | `select_random_points` | 12.73ms | 14.24ms | 1.1× | 3.4% | PASS |
| ac_reads | `select_random_ranges` | 6.93ms | 7.46ms | 1.1× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 10.49ms | 13.13ms | 1.3× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 31.23ms | 36.22ms | 1.2× | 1.0% | PASS |
| ac_reads | `index_join` | 7.28ms | 10.62ms | 1.5× | 2.2% | PASS |
| ac_reads | `index_join_scan` | 3.80ms | 6.28ms | 1.7× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.26s | 1.2× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.22s | 1.36s | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_read_only` | 135.95ms | 157.49ms | 1.2× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.84ms | 65.21ms | 3.1× | 7.8% | PASS |
| ac_writes | `oltp_insert_ac` | 24.20ms | 79.49ms | 3.3× | 6.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.70ms | 92.23ms | 3.3× | 7.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.14ms | 72.34ms | 3.1× | 7.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.86ms | 82.01ms | 3.4× | 8.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.98ms | 81.74ms | 3.4× | 8.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.59ms | 72.37ms | 3.4× | 7.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.22ms | 86.16ms | 2.9× | 4.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.07ms | 28.90ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_range_select` | 13.88ms | 12.64ms | 0.9× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 12.90ms | 12.14ms | 0.9× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 2.80ms | 2.81ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 3.51ms | 3.59ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.09ms | 5.08ms | 1.6× | 0.8% | PASS |
| mem_reads | `select_random_points` | 17.05ms | 17.12ms | 1.0× | 1.4% | PASS |
| mem_reads | `select_random_ranges` | 5.27ms | 5.07ms | 1.0× | 1.5% | PASS |
| mem_reads | `covering_index_scan` | 5.89ms | 8.14ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 28.79ms | 29.81ms | 1.0× | 0.5% | PASS |
| mem_reads | `index_join` | 8.76ms | 8.29ms | 0.9× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.11ms | 5.45ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 881.69ms | 1.04s | 1.2× | 0.7% | PASS |
| mem_reads | `table_scan` | 994.58ms | 1.13s | 1.1× | 0.3% | PASS |
| mem_reads | `oltp_read_only` | 106.20ms | 110.03ms | 1.0× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.19ms | 259.65ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 13.60ms | 26.48ms | 1.9× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 50.88ms | 104.19ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 37.65ms | 59.28ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 42.46ms | 76.53ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 21.96ms | 39.86ms | 1.8× | 0.7% | PASS |
| mem_writes | `types_delete_insert` | 30.14ms | 43.30ms | 1.4× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 72.81ms | 99.04ms | 1.4× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 96.42ms | 45.67ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 21.26ms | 14.42ms | 0.7× | 0.9% | PASS |
| file_reads | `oltp_sum_range` | 19.73ms | 13.76ms | 0.7× | 0.5% | PASS |
| file_reads | `oltp_order_range` | 3.65ms | 3.03ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_distinct_range` | 4.42ms | 3.82ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 10.29ms | 6.92ms | 0.7× | 0.8% | PASS |
| file_reads | `select_random_points` | 24.95ms | 19.01ms | 0.8× | 0.9% | PASS |
| file_reads | `select_random_ranges` | 12.49ms | 6.88ms | 0.6× | 0.8% | PASS |
| file_reads | `covering_index_scan` | 13.23ms | 9.93ms | 0.8× | 0.9% | PASS |
| file_reads | `groupby_scan` | 29.75ms | 30.06ms | 1.0× | 0.5% | PASS |
| file_reads | `index_join` | 13.11ms | 9.29ms | 0.7× | 0.5% | PASS |
| file_reads | `index_join_scan` | 4.04ms | 5.68ms | 1.4× | 0.9% | PASS |
| file_reads | `types_table_scan` | 885.08ms | 1.04s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.00s | 1.13s | 1.1× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 207.24ms | 135.29ms | 0.7× | 0.5% | PASS |
| file_writes | `oltp_bulk_insert` | 262.16ms | 335.71ms | 1.3× | 2.7% | PASS |
| file_writes | `oltp_insert` | 33.77ms | 48.38ms | 1.4× | 4.8% | PASS |
| file_writes | `oltp_update_index` | 179.48ms | 193.84ms | 1.1× | 5.1% | PASS |
| file_writes | `oltp_update_non_index` | 156.18ms | 124.37ms | 0.8× | 11.3% | PASS |
| file_writes | `oltp_delete_insert` | 190.22ms | 150.19ms | 0.8× | 2.7% | PASS |
| file_writes | `oltp_write_only` | 125.43ms | 94.53ms | 0.8× | 3.8% | PASS |
| file_writes | `types_delete_insert` | 150.01ms | 90.83ms | 0.6× | 9.7% | PASS |
| file_writes | `oltp_read_write` | 179.05ms | 153.67ms | 0.9× | 2.4% | PASS |
| ac_reads | `oltp_point_select` | 48.53ms | 45.76ms | 0.9× | 0.6% | PASS |
| ac_reads | `oltp_range_select` | 16.62ms | 14.45ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_sum_range` | 15.13ms | 13.82ms | 0.9× | 0.6% | PASS |
| ac_reads | `oltp_order_range` | 3.20ms | 3.04ms | 0.9× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.95ms | 3.83ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 5.67ms | 6.96ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 20.44ms | 19.28ms | 0.9× | 1.0% | PASS |
| ac_reads | `select_random_ranges` | 7.86ms | 6.95ms | 0.9× | 0.6% | PASS |
| ac_reads | `covering_index_scan` | 8.51ms | 9.93ms | 1.2× | 0.9% | PASS |
| ac_reads | `groupby_scan` | 29.29ms | 30.06ms | 1.0× | 0.8% | PASS |
| ac_reads | `index_join` | 10.85ms | 9.38ms | 0.9× | 0.8% | PASS |
| ac_reads | `index_join_scan` | 3.60ms | 5.76ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 885.78ms | 1.04s | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.01s | 1.13s | 1.1× | 0.3% | PASS |
| ac_reads | `oltp_read_only` | 138.73ms | 134.76ms | 1.0× | 0.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.00ms | 52.81ms | 2.9× | 7.8% | PASS |
| ac_writes | `oltp_insert_ac` | 20.16ms | 66.72ms | 3.3× | 11.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.86ms | 75.59ms | 3.6× | 8.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.00ms | 62.16ms | 3.7× | 13.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.97ms | 69.51ms | 3.5× | 7.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.38ms | 66.79ms | 3.4× | 8.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.20ms | 59.06ms | 3.2× | 9.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.51ms | 72.68ms | 3.0× | 5.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.51ms | 40.33ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 15.85ms | 16.53ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 14.67ms | 15.82ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_order_range` | 3.25ms | 3.85ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.20ms | 5.00ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.94ms | 6.78ms | 1.7× | 2.1% | PASS |
| mem_reads | `select_random_points` | 20.97ms | 22.96ms | 1.1× | 1.8% | PASS |
| mem_reads | `select_random_ranges` | 6.47ms | 6.97ms | 1.1× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 7.95ms | 11.20ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 34.35ms | 38.37ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 10.18ms | 10.99ms | 1.1× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.78ms | 6.60ms | 1.7× | 2.2% | PASS |
| mem_reads | `types_table_scan` | 1.12s | 1.44s | 1.3× | 1.6% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.52s | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_read_only` | 137.78ms | 158.97ms | 1.2× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 236.19ms | 361.97ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 17.95ms | 37.14ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 62.73ms | 136.59ms | 2.2× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 46.83ms | 79.94ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 51.21ms | 101.88ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 27.50ms | 55.68ms | 2.0× | 2.0% | PASS |
| mem_writes | `types_delete_insert` | 37.18ms | 59.06ms | 1.6× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 95.87ms | 139.93ms | 1.5× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 105.85ms | 58.71ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 23.84ms | 18.48ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 22.39ms | 17.85ms | 0.8× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 4.17ms | 4.09ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 5.16ms | 5.29ms | 1.0× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 11.28ms | 8.62ms | 0.8× | 0.9% | PASS |
| file_reads | `select_random_points` | 29.92ms | 25.63ms | 0.9× | 1.7% | PASS |
| file_reads | `select_random_ranges` | 14.12ms | 8.95ms | 0.6× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 15.73ms | 13.24ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 35.22ms | 38.65ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 14.63ms | 12.13ms | 0.8× | 1.8% | PASS |
| file_reads | `index_join_scan` | 4.74ms | 6.93ms | 1.5× | 2.3% | PASS |
| file_reads | `types_table_scan` | 1.11s | 1.43s | 1.3× | 1.7% | PASS |
| file_reads | `table_scan` | 1.24s | 1.52s | 1.2× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 248.26ms | 188.41ms | 0.8× | 1.0% | PASS |
| file_writes | `oltp_bulk_insert` | 256.22ms | 379.04ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.40ms | 42.81ms | 1.7× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 98.99ms | 158.05ms | 1.6× | 1.1% | PASS |
| file_writes | `oltp_update_non_index` | 87.91ms | 93.94ms | 1.1× | 10.3% | PASS |
| file_writes | `oltp_delete_insert` | 87.76ms | 119.90ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 59.02ms | 68.51ms | 1.2× | 2.9% | PASS |
| file_writes | `types_delete_insert` | 64.43ms | 69.59ms | 1.1× | 1.9% | PASS |
| file_writes | `oltp_read_write` | 129.59ms | 152.35ms | 1.2× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 57.84ms | 58.77ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 19.02ms | 18.52ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 17.58ms | 17.95ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 3.77ms | 4.10ms | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.67ms | 5.30ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_index_scan` | 6.53ms | 8.67ms | 1.3× | 1.4% | PASS |
| ac_reads | `select_random_points` | 24.35ms | 25.73ms | 1.1× | 1.8% | PASS |
| ac_reads | `select_random_ranges` | 9.19ms | 8.94ms | 1.0× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 10.84ms | 13.30ms | 1.2× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 34.78ms | 38.67ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 12.09ms | 12.16ms | 1.0× | 1.8% | PASS |
| ac_reads | `index_join_scan` | 4.21ms | 6.86ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.14s | 1.44s | 1.3× | 2.0% | PASS |
| ac_reads | `table_scan` | 1.25s | 1.52s | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 175.89ms | 188.55ms | 1.1× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.16ms | 66.30ms | 2.7× | 7.9% | PASS |
| ac_writes | `oltp_insert_ac` | 26.99ms | 86.42ms | 3.2× | 7.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.68ms | 94.54ms | 3.5× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.34ms | 75.50ms | 3.4× | 9.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.43ms | 86.30ms | 3.4× | 7.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.57ms | 83.11ms | 3.4× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.37ms | 75.95ms | 3.2× | 7.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.45ms | 93.99ms | 2.9× | 8.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.14ms | 41.90ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 19.79ms | 23.33ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_sum_range` | 17.32ms | 22.24ms | 1.3× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 3.54ms | 4.16ms | 1.2× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.52ms | 5.35ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.37ms | 6.40ms | 1.5× | 1.2% | PASS |
| mem_reads | `select_random_points` | 25.73ms | 31.58ms | 1.2× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 7.59ms | 9.28ms | 1.2× | 1.6% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 11.06ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 36.95ms | 43.36ms | 1.2× | 0.8% | PASS |
| mem_reads | `index_join` | 7.86ms | 11.34ms | 1.4× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.91ms | 6.34ms | 1.6× | 2.1% | PASS |
| mem_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.8% | PASS |
| mem_reads | `table_scan` | 1.21s | 1.52s | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_read_only` | 147.48ms | 183.01ms | 1.2× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 240.88ms | 351.54ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.43ms | 33.95ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 64.84ms | 124.60ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 49.45ms | 87.29ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 48.06ms | 95.09ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_write_only` | 26.21ms | 58.05ms | 2.2× | 1.3% | PASS |
| mem_writes | `types_delete_insert` | 32.17ms | 55.93ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 102.11ms | 161.63ms | 1.6× | 1.2% | PASS |
| file_reads | `oltp_point_select` | 102.99ms | 60.12ms | 0.6× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 27.01ms | 25.40ms | 0.9× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 24.44ms | 24.49ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 4.44ms | 4.49ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_distinct_range` | 5.42ms | 5.71ms | 1.1× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 11.49ms | 8.55ms | 0.7× | 1.5% | PASS |
| file_reads | `select_random_points` | 34.28ms | 34.80ms | 1.0× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 15.00ms | 11.33ms | 0.8× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 15.33ms | 13.03ms | 0.9× | 1.6% | PASS |
| file_reads | `groupby_scan` | 38.40ms | 43.98ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 12.01ms | 13.17ms | 1.1× | 1.5% | PASS |
| file_reads | `index_join_scan` | 4.92ms | 6.75ms | 1.4× | 1.8% | PASS |
| file_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.7% | PASS |
| file_reads | `table_scan` | 1.25s | 1.52s | 1.2× | 2.8% | PASS |
| file_reads | `oltp_read_only` | 259.53ms | 214.39ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 254.94ms | 364.98ms | 1.4× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.70ms | 38.30ms | 1.5× | 1.8% | PASS |
| file_writes | `oltp_update_index` | 95.23ms | 140.23ms | 1.5× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 75.23ms | 95.13ms | 1.3× | 2.0% | PASS |
| file_writes | `oltp_delete_insert` | 74.75ms | 108.09ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 51.01ms | 64.62ms | 1.3× | 3.0% | PASS |
| file_writes | `types_delete_insert` | 48.49ms | 61.46ms | 1.3× | 2.3% | PASS |
| file_writes | `oltp_read_write` | 124.76ms | 166.71ms | 1.3× | 1.2% | PASS |
| ac_reads | `oltp_point_select` | 55.15ms | 60.31ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 22.72ms | 25.53ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 19.94ms | 24.44ms | 1.2× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 4.49ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_distinct_range` | 4.92ms | 5.72ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.87ms | 8.56ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 28.55ms | 34.95ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 9.97ms | 11.36ms | 1.1× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 10.48ms | 13.03ms | 1.2× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 37.31ms | 43.80ms | 1.2× | 0.6% | PASS |
| ac_reads | `index_join` | 9.39ms | 13.13ms | 1.4× | 1.4% | PASS |
| ac_reads | `index_join_scan` | 4.34ms | 6.79ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.40s | 1.3× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.20s | 1.51s | 1.3× | 1.3% | PASS |
| ac_reads | `oltp_read_only` | 181.27ms | 212.23ms | 1.2× | 0.8% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.16ms | 61.16ms | 3.0× | 6.5% | PASS |
| ac_writes | `oltp_insert_ac` | 23.09ms | 75.84ms | 3.3× | 6.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.32ms | 85.76ms | 3.4× | 9.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.12ms | 67.85ms | 3.2× | 5.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.30ms | 76.99ms | 3.3× | 6.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.67ms | 77.25ms | 3.3× | 7.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.38ms | 71.76ms | 3.7× | 8.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.75ms | 85.64ms | 2.8× | 6.9% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 41s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 30.14ms | 38.00ms | 79.3% | 1.0% | PASS |
| `status_dirty_many_tables` | 33.26ms | 42.00ms | 79.2% | 1.0% | PASS |
| `diff_regular_working_one_table` | 25.16ms | 33.00ms | 76.2% | 0.9% | PASS |
| `diff_regular_working_many_tables` | 35.15ms | 50.00ms | 70.3% | 1.5% | PASS |
| `diff_stat_working_many_tables` | 35.21ms | 48.00ms | 73.3% | 1.4% | PASS |
| `diff_schema_working_many_tables` | 35.58ms | 48.00ms | 74.1% | 1.2% | PASS |
| `branch_list_many_branches` | 16.42ms | 25.00ms | 65.7% | 1.2% | PASS |
| `branch_create_delete` | 18.25ms | 27.00ms | 67.6% | 1.5% | PASS |
| `at_literal_deep_history` | 17.78ms | 28.00ms | 63.5% | 1.3% | PASS |
| `diff_literal_deep_history` | 18.00ms | 28.00ms | 64.3% | 1.2% | PASS |
| `history_literal_deep_history` | 19.19ms | 30.00ms | 64.0% | 1.5% | PASS |
| `checkout_branch_clean` | 27.52ms | 43.00ms | 64.0% | 1.2% | PASS |
| `merge_data_no_conflicts` | 20.46ms | 33.00ms | 62.0% | 1.9% | PASS |
| `merge_data_secondary_index` | 843.65ms | 944.00ms | 89.4% | 1.0% | PASS |
| `merge_schema_no_conflicts` | 16.65ms | 24.00ms | 69.4% | 1.8% | PASS |
| `merge_data_conflicts` | 23.44ms | 33.00ms | 71.0% | 1.8% | PASS |
| `merge_data_conflicts_with_resolve` | 24.38ms | 34.00ms | 71.7% | 1.2% | PASS |

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
| copy_fsync | candidate | 462.487 | 454.034–611.957 | 37.108 | 216.22 | 107968266 |
| push_initial | candidate | 840.378 | 836.933–847.429 | 426.183 | 118.99 | 107956772 |
| clone_initial | candidate | 966.684 | 959.374–969.536 | 550.618 | 103.45 | 108475035 |
| push_noop | candidate | 0.796 | 0.770–0.936 | 0.374 | — | 0 |
| fetch_noop | candidate | 0.123 | 0.121–0.161 | 0.124 | — | 0 |
| push_incremental | candidate | 195.400 | 191.696–206.962 | 169.317 | 5.12 | 7909775 |
| fetch_incremental | candidate | 99.062 | 95.559–103.215 | 73.548 | 10.09 | 7910084 |
| pull_fast_forward | candidate | 96.252 | 89.285–98.027 | 66.382 | 10.39 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.51 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.80 | 294.986 | 109.784 | 47215 | 2337 |
| push_noop | candidate | 46.07 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.07 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.07 | 96.928 | 7.910 | 22426 | 125 |
| fetch_incremental | candidate | 46.07 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.07 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 6107.904 | 6095.650–6136.107 | 357.641 | 163.72 | 1087718031 |
| push_initial | candidate | 8671.777 | 8545.126–8676.459 | 4422.877 | 115.32 | 1079566275 |
| clone_initial | candidate | 11503.853 | 10520.595–12065.473 | 6366.356 | 86.93 | 1102407326 |
| push_noop | candidate | 0.956 | 0.861–0.995 | 0.401 | — | 0 |
| fetch_noop | candidate | 0.128 | 0.122–0.134 | 0.130 | — | 0 |
| push_incremental | candidate | 1034.589 | 1032.162–1047.582 | 961.338 | 0.97 | 15806003 |
| fetch_incremental | candidate | 292.213 | 288.876–292.265 | 231.804 | 3.42 | 15806513 |
| pull_fast_forward | candidate | 294.562 | 291.438–294.944 | 234.314 | 3.39 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.10 | 2091.236 | 1087.622 | 263341 | 20541 |
| clone_initial | candidate | 124.00 | 3521.783 | 1132.819 | 613318 | 32243 |
| push_noop | candidate | 47.23 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.23 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.30 | 618.422 | 15.928 | 150226 | 313 |
| fetch_incremental | candidate | 50.41 | 62.406 | 15.928 | 13937 | 313 |
| pull_fast_forward | candidate | 50.38 | 62.338 | 15.929 | 13933 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
