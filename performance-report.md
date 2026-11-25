# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-25 21:29 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/45686053836)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.73s | 10.68s | 1.1× | 1.7% | **PASS** |
| Writes | 1.91s | 3.11s | 1.6× | 1.6% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.84s | 10.93s | 1.0× | 1.6% | **PASS** |
| Writes | 3.62s | 4.02s | 1.1× | 3.4% | **PASS** |
| Autocommit writes | 669.13ms | 2.24s | 3.3× | 6.0% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.65s | 1.78s | 1.1× | 2.6% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 3.02s | 3.22s | 1.1× | 1.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.31s | 2.52s | 1.1× | 1.8% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.75s | 3.16s | 1.1× | 1.3% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 280.48ms | 472.68ms | 1.7× | 2.6% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 597.21ms | 966.97ms | 1.6× | 1.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 459.35ms | 713.46ms | 1.6× | 1.9% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 577.70ms | 952.92ms | 1.6× | 1.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.87s | 1.83s | 1.0× | 2.1% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.33s | 3.32s | 1.0× | 1.6% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.48s | 2.54s | 1.0× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.15s | 3.24s | 1.0× | 1.3% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 739.64ms | 747.38ms | 1.0× | 5.4% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 947.42ms | 1.07s | 1.1× | 3.2% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.17s | 1.18s | 1.0× | 4.8% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 760.73ms | 1.03s | 1.3× | 1.3% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.83s | 1.85s | 1.0× | 2.5% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 3.09s | 3.28s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.45s | 2.60s | 1.1× | 1.9% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 3.08s | 3.27s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 172.64ms | 493.56ms | 2.9× | 3.9% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 162.14ms | 570.42ms | 3.5× | 6.0% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 168.12ms | 595.69ms | 3.5× | 12.0% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 166.23ms | 575.55ms | 3.5× | 5.8% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 15.66ms | 18.15ms | 1.2× | 3.3% | PASS |
| mem_reads | `oltp_range_select` | 6.27ms | 7.16ms | 1.1× | 2.6% | PASS |
| mem_reads | `oltp_sum_range` | 6.21ms | 7.36ms | 1.2× | 2.6% | PASS |
| mem_reads | `oltp_order_range` | 1.75ms | 1.88ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 2.24ms | 2.37ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_index_scan` | 2.49ms | 3.52ms | 1.4× | 3.3% | PASS |
| mem_reads | `select_random_points` | 8.05ms | 8.68ms | 1.1× | 2.6% | PASS |
| mem_reads | `select_random_ranges` | 2.94ms | 3.14ms | 1.1× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 4.10ms | 6.10ms | 1.5× | 1.6% | PASS |
| mem_reads | `groupby_scan` | 19.60ms | 20.87ms | 1.1× | 1.3% | PASS |
| mem_reads | `index_join` | 3.61ms | 6.17ms | 1.7× | 3.2% | PASS |
| mem_reads | `index_join_scan` | 2.51ms | 4.36ms | 1.7× | 4.0% | PASS |
| mem_reads | `types_table_scan` | 712.15ms | 770.58ms | 1.1× | 1.6% | PASS |
| mem_reads | `table_scan` | 801.42ms | 847.16ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_read_only` | 59.91ms | 67.53ms | 1.1× | 2.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 109.03ms | 175.71ms | 1.6× | 1.5% | PASS |
| mem_writes | `oltp_insert` | 9.20ms | 15.90ms | 1.7× | 1.4% | PASS |
| mem_writes | `oltp_update_index` | 33.94ms | 66.68ms | 2.0× | 3.3% | PASS |
| mem_writes | `oltp_update_non_index` | 25.88ms | 42.91ms | 1.7× | 2.6% | PASS |
| mem_writes | `oltp_delete_insert` | 29.45ms | 51.17ms | 1.7× | 3.1% | PASS |
| mem_writes | `oltp_write_only` | 14.14ms | 31.12ms | 2.2× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 16.51ms | 22.92ms | 1.4× | 2.6% | PASS |
| mem_writes | `oltp_read_write` | 42.35ms | 66.25ms | 1.6× | 5.0% | PASS |
| file_reads | `oltp_point_select` | 69.35ms | 32.79ms | 0.5× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 12.53ms | 8.89ms | 0.7× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 12.16ms | 8.95ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_order_range` | 2.42ms | 2.09ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 2.90ms | 2.59ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 8.52ms | 5.25ms | 0.6× | 2.3% | PASS |
| file_reads | `select_random_points` | 14.21ms | 10.94ms | 0.8× | 2.7% | PASS |
| file_reads | `select_random_ranges` | 8.58ms | 4.66ms | 0.5× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 10.32ms | 7.78ms | 0.8× | 2.2% | PASS |
| file_reads | `groupby_scan` | 19.99ms | 20.61ms | 1.0× | 0.9% | PASS |
| file_reads | `index_join` | 7.35ms | 7.36ms | 1.0× | 3.7% | PASS |
| file_reads | `index_join_scan` | 3.22ms | 4.78ms | 1.5× | 5.5% | PASS |
| file_reads | `types_table_scan` | 730.05ms | 772.59ms | 1.1× | 1.6% | PASS |
| file_reads | `table_scan` | 825.75ms | 846.90ms | 1.0× | 2.9% | PASS |
| file_reads | `oltp_read_only` | 145.56ms | 92.86ms | 0.6× | 2.1% | PASS |
| file_writes | `oltp_bulk_insert` | 149.45ms | 222.24ms | 1.5× | 3.0% | PASS |
| file_writes | `oltp_insert` | 19.75ms | 27.29ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 126.07ms | 109.60ms | 0.9× | 5.7% | PASS |
| file_writes | `oltp_update_non_index` | 101.07ms | 79.81ms | 0.8× | 3.3% | PASS |
| file_writes | `oltp_delete_insert` | 107.83ms | 98.24ms | 0.9× | 5.7% | PASS |
| file_writes | `oltp_write_only` | 71.84ms | 65.36ms | 0.9× | 6.4% | PASS |
| file_writes | `types_delete_insert` | 62.70ms | 46.17ms | 0.7× | 10.6% | PASS |
| file_writes | `oltp_read_write` | 100.94ms | 98.67ms | 1.0× | 5.0% | PASS |
| ac_reads | `oltp_point_select` | 32.78ms | 32.69ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_range_select` | 8.10ms | 8.54ms | 1.1× | 3.7% | PASS |
| ac_reads | `oltp_sum_range` | 7.91ms | 8.59ms | 1.1× | 3.2% | PASS |
| ac_reads | `oltp_order_range` | 1.96ms | 2.04ms | 1.0× | 2.5% | PASS |
| ac_reads | `oltp_distinct_range` | 2.54ms | 2.59ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 4.65ms | 5.11ms | 1.1× | 3.2% | PASS |
| ac_reads | `select_random_points` | 9.56ms | 10.32ms | 1.1× | 2.9% | PASS |
| ac_reads | `select_random_ranges` | 4.85ms | 4.59ms | 0.9× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 6.49ms | 7.62ms | 1.2× | 2.2% | PASS |
| ac_reads | `groupby_scan` | 19.42ms | 20.53ms | 1.1× | 1.9% | PASS |
| ac_reads | `index_join` | 5.18ms | 7.04ms | 1.4× | 3.8% | PASS |
| ac_reads | `index_join_scan` | 2.71ms | 4.61ms | 1.7× | 4.9% | PASS |
| ac_reads | `types_table_scan` | 724.33ms | 761.70ms | 1.1× | 2.1% | PASS |
| ac_reads | `table_scan` | 912.46ms | 886.02ms | 1.0× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 86.94ms | 87.96ms | 1.0× | 2.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.19ms | 52.51ms | 2.6× | 3.9% | PASS |
| ac_writes | `oltp_insert_ac` | 21.49ms | 61.70ms | 2.9× | 3.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.79ms | 68.19ms | 3.0× | 3.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 20.01ms | 57.41ms | 2.9× | 4.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.51ms | 63.20ms | 2.9× | 3.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.16ms | 63.26ms | 2.9× | 3.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.86ms | 59.06ms | 3.0× | 6.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.62ms | 68.23ms | 2.8× | 4.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.98ms | 37.56ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 18.18ms | 16.20ms | 0.9× | 2.5% | PASS |
| mem_reads | `oltp_sum_range` | 16.24ms | 15.51ms | 1.0× | 2.5% | PASS |
| mem_reads | `oltp_order_range` | 3.56ms | 3.58ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.50ms | 4.59ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.96ms | 6.44ms | 1.6× | 1.6% | PASS |
| mem_reads | `select_random_points` | 22.60ms | 21.78ms | 1.0× | 3.4% | PASS |
| mem_reads | `select_random_ranges` | 6.67ms | 6.38ms | 1.0× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 7.62ms | 10.48ms | 1.4× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 37.49ms | 38.17ms | 1.0× | 0.8% | PASS |
| mem_reads | `index_join` | 11.18ms | 10.30ms | 0.9× | 2.3% | PASS |
| mem_reads | `index_join_scan` | 4.00ms | 6.77ms | 1.7× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.26s | 1.39s | 1.1× | 2.3% | PASS |
| mem_reads | `table_scan` | 1.45s | 1.50s | 1.0× | 1.9% | PASS |
| mem_reads | `oltp_read_only` | 144.67ms | 145.31ms | 1.0× | 1.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 229.77ms | 340.17ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.57ms | 36.78ms | 2.1× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 68.69ms | 143.96ms | 2.1× | 1.7% | PASS |
| mem_writes | `oltp_update_non_index` | 50.03ms | 82.48ms | 1.6× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 55.97ms | 106.64ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 29.06ms | 57.19ms | 2.0× | 1.9% | PASS |
| mem_writes | `types_delete_insert` | 40.18ms | 60.66ms | 1.5× | 2.3% | PASS |
| mem_writes | `oltp_read_write` | 105.95ms | 139.09ms | 1.3× | 2.4% | PASS |
| file_reads | `oltp_point_select` | 126.26ms | 59.15ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 27.43ms | 18.43ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_sum_range` | 25.54ms | 17.65ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_order_range` | 4.52ms | 3.84ms | 0.8× | 1.8% | PASS |
| file_reads | `oltp_distinct_range` | 5.55ms | 4.85ms | 0.9× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 12.97ms | 8.61ms | 0.7× | 1.0% | PASS |
| file_reads | `select_random_points` | 31.94ms | 24.08ms | 0.8× | 2.9% | PASS |
| file_reads | `select_random_ranges` | 15.67ms | 8.69ms | 0.6× | 1.6% | PASS |
| file_reads | `covering_index_scan` | 16.89ms | 12.77ms | 0.8× | 1.0% | PASS |
| file_reads | `groupby_scan` | 38.44ms | 38.33ms | 1.0× | 1.0% | PASS |
| file_reads | `index_join` | 16.40ms | 11.67ms | 0.7× | 2.8% | PASS |
| file_reads | `index_join_scan` | 5.10ms | 7.00ms | 1.4× | 2.5% | PASS |
| file_reads | `types_table_scan` | 1.29s | 1.42s | 1.1× | 3.8% | PASS |
| file_reads | `table_scan` | 1.44s | 1.51s | 1.0× | 1.7% | PASS |
| file_reads | `oltp_read_only` | 274.77ms | 177.04ms | 0.6× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 259.30ms | 356.27ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.24ms | 42.16ms | 1.7× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 146.21ms | 166.71ms | 1.1× | 4.6% | PASS |
| file_writes | `oltp_update_non_index` | 103.39ms | 96.13ms | 0.9× | 13.2% | PASS |
| file_writes | `oltp_delete_insert` | 101.12ms | 122.98ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 86.48ms | 69.91ms | 0.8× | 9.7% | PASS |
| file_writes | `types_delete_insert` | 75.23ms | 68.41ms | 0.9× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 150.45ms | 148.11ms | 1.0× | 6.5% | PASS |
| ac_reads | `oltp_point_select` | 63.68ms | 59.14ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 21.86ms | 18.56ms | 0.8× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 20.05ms | 18.11ms | 0.9× | 1.8% | PASS |
| ac_reads | `oltp_order_range` | 3.99ms | 3.83ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.94ms | 4.86ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 7.17ms | 8.76ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_points` | 27.27ms | 25.19ms | 0.9× | 4.3% | PASS |
| ac_reads | `select_random_ranges` | 9.92ms | 8.78ms | 0.9× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 10.90ms | 12.85ms | 1.2× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 37.85ms | 38.50ms | 1.0× | 0.8% | PASS |
| ac_reads | `index_join` | 13.76ms | 11.87ms | 0.9× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 4.60ms | 7.07ms | 1.5× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.24s | 1.38s | 1.1× | 1.6% | PASS |
| ac_reads | `table_scan` | 1.44s | 1.51s | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_read_only` | 187.47ms | 177.28ms | 0.9× | 1.4% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.41ms | 53.73ms | 3.1× | 5.9% | PASS |
| ac_writes | `oltp_insert_ac` | 20.27ms | 66.44ms | 3.3× | 5.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.52ms | 87.33ms | 4.1× | 5.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.78ms | 65.30ms | 3.9× | 7.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.78ms | 77.68ms | 3.7× | 6.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.04ms | 74.76ms | 3.7× | 6.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.29ms | 65.56ms | 3.6× | 6.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.05ms | 79.62ms | 2.9× | 6.0% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 30.32ms | 29.52ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_range_select` | 14.84ms | 12.57ms | 0.8× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 13.40ms | 11.81ms | 0.9× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 2.80ms | 2.83ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 3.60ms | 3.70ms | 1.0× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.31ms | 5.32ms | 1.6× | 1.7% | PASS |
| mem_reads | `select_random_points` | 20.50ms | 18.11ms | 0.9× | 4.6% | PASS |
| mem_reads | `select_random_ranges` | 5.81ms | 5.23ms | 0.9× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 6.03ms | 8.29ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 29.17ms | 29.86ms | 1.0× | 0.8% | PASS |
| mem_reads | `index_join` | 9.20ms | 8.78ms | 1.0× | 3.2% | PASS |
| mem_reads | `index_join_scan` | 3.32ms | 5.64ms | 1.7× | 3.9% | PASS |
| mem_reads | `types_table_scan` | 1.01s | 1.11s | 1.1× | 2.6% | PASS |
| mem_reads | `table_scan` | 1.04s | 1.15s | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 113.56ms | 112.28ms | 1.0× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.11ms | 259.14ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 14.13ms | 27.41ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 53.38ms | 106.54ms | 2.0× | 2.4% | PASS |
| mem_writes | `oltp_update_non_index` | 38.55ms | 58.04ms | 1.5× | 2.5% | PASS |
| mem_writes | `oltp_delete_insert` | 43.24ms | 76.80ms | 1.8× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 23.75ms | 41.13ms | 1.7× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 31.66ms | 43.33ms | 1.4× | 2.3% | PASS |
| mem_writes | `oltp_read_write` | 77.54ms | 101.06ms | 1.3× | 2.0% | PASS |
| file_reads | `oltp_point_select` | 96.31ms | 45.29ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 21.04ms | 14.16ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 19.98ms | 13.59ms | 0.7× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 3.60ms | 3.04ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 4.39ms | 3.85ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_index_scan` | 10.30ms | 6.93ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 24.84ms | 18.86ms | 0.8× | 2.7% | PASS |
| file_reads | `select_random_ranges` | 12.33ms | 6.83ms | 0.6× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 13.19ms | 9.88ms | 0.7× | 1.2% | PASS |
| file_reads | `groupby_scan` | 29.35ms | 29.85ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 12.99ms | 9.62ms | 0.7× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.10ms | 5.74ms | 1.4× | 2.4% | PASS |
| file_reads | `types_table_scan` | 890.15ms | 1.06s | 1.2× | 1.9% | PASS |
| file_reads | `table_scan` | 1.12s | 1.18s | 1.1× | 2.8% | PASS |
| file_reads | `oltp_read_only` | 222.41ms | 140.66ms | 0.6× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 245.86ms | 331.53ms | 1.3× | 3.5% | PASS |
| file_writes | `oltp_insert` | 33.14ms | 50.10ms | 1.5× | 6.1% | PASS |
| file_writes | `oltp_update_index` | 164.96ms | 186.92ms | 1.1× | 2.5% | PASS |
| file_writes | `oltp_update_non_index` | 141.28ms | 120.61ms | 0.9× | 8.7% | PASS |
| file_writes | `oltp_delete_insert` | 166.93ms | 148.27ms | 0.9× | 6.9% | PASS |
| file_writes | `oltp_write_only` | 118.53ms | 95.73ms | 0.8× | 4.3% | PASS |
| file_writes | `types_delete_insert` | 123.32ms | 86.60ms | 0.7× | 5.3% | PASS |
| file_writes | `oltp_read_write` | 180.74ms | 160.12ms | 0.9× | 4.2% | PASS |
| ac_reads | `oltp_point_select` | 51.20ms | 46.53ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_range_select` | 16.85ms | 14.28ms | 0.8× | 2.5% | PASS |
| ac_reads | `oltp_sum_range` | 15.26ms | 13.58ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_order_range` | 3.18ms | 3.04ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.93ms | 3.87ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.77ms | 7.04ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 20.55ms | 19.23ms | 0.9× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 7.87ms | 6.88ms | 0.9× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 8.60ms | 9.94ms | 1.2× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 29.27ms | 29.99ms | 1.0× | 0.9% | PASS |
| ac_reads | `index_join` | 11.22ms | 9.82ms | 0.9× | 3.9% | PASS |
| ac_reads | `index_join_scan` | 3.64ms | 5.85ms | 1.6× | 2.9% | PASS |
| ac_reads | `types_table_scan` | 973.33ms | 1.10s | 1.1× | 2.7% | PASS |
| ac_reads | `table_scan` | 1.15s | 1.19s | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_read_only` | 149.73ms | 138.53ms | 0.9× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.34ms | 51.93ms | 2.8× | 7.6% | PASS |
| ac_writes | `oltp_insert_ac` | 21.71ms | 71.01ms | 3.3× | 11.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.27ms | 122.28ms | 5.5× | 63.9% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.61ms | 65.53ms | 3.5× | 12.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 21.27ms | 73.14ms | 3.4× | 14.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.64ms | 70.14ms | 3.4× | 11.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.95ms | 63.49ms | 3.4× | 13.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.33ms | 78.15ms | 3.0× | 9.4% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.67ms | 38.33ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 20.13ms | 26.00ms | 1.3× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 17.21ms | 20.66ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 3.69ms | 4.49ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 4.70ms | 5.55ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 4.51ms | 6.21ms | 1.4× | 1.5% | PASS |
| mem_reads | `select_random_points` | 25.70ms | 30.13ms | 1.2× | 1.7% | PASS |
| mem_reads | `select_random_ranges` | 7.32ms | 8.45ms | 1.2× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.58ms | 10.21ms | 1.3× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 38.36ms | 42.40ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 7.75ms | 11.25ms | 1.5× | 1.4% | PASS |
| mem_reads | `index_join_scan` | 3.95ms | 6.49ms | 1.6× | 2.4% | PASS |
| mem_reads | `types_table_scan` | 1.14s | 1.33s | 1.2× | 1.0% | PASS |
| mem_reads | `table_scan` | 1.29s | 1.44s | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_read_only` | 145.71ms | 181.39ms | 1.2× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 234.84ms | 334.78ms | 1.4× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 18.48ms | 33.75ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 66.54ms | 128.48ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 51.50ms | 88.95ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 49.31ms | 97.19ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 27.05ms | 60.14ms | 2.2× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 32.02ms | 54.18ms | 1.7× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 97.95ms | 155.44ms | 1.6× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 120.48ms | 58.98ms | 0.5× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 28.44ms | 28.73ms | 1.0× | 2.4% | PASS |
| file_reads | `oltp_sum_range` | 26.39ms | 23.01ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 4.62ms | 4.73ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.62ms | 5.79ms | 1.0× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 13.58ms | 8.45ms | 0.6× | 1.8% | PASS |
| file_reads | `select_random_points` | 34.28ms | 31.89ms | 0.9× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 16.03ms | 10.70ms | 0.7× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 16.80ms | 12.56ms | 0.7× | 1.3% | PASS |
| file_reads | `groupby_scan` | 39.45ms | 42.59ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 12.60ms | 12.64ms | 1.0× | 1.3% | PASS |
| file_reads | `index_join_scan` | 4.99ms | 6.76ms | 1.4× | 1.8% | PASS |
| file_reads | `types_table_scan` | 1.14s | 1.32s | 1.2× | 1.2% | PASS |
| file_reads | `table_scan` | 1.41s | 1.46s | 1.0× | 4.3% | PASS |
| file_reads | `oltp_read_only` | 275.60ms | 214.49ms | 0.8× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 251.29ms | 347.17ms | 1.4× | 0.6% | PASS |
| file_writes | `oltp_insert` | 25.46ms | 38.14ms | 1.5× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 101.85ms | 146.45ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_update_non_index` | 80.13ms | 96.01ms | 1.2× | 1.2% | PASS |
| file_writes | `oltp_delete_insert` | 79.39ms | 111.35ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 51.34ms | 66.56ms | 1.3× | 1.3% | PASS |
| file_writes | `types_delete_insert` | 49.76ms | 59.27ms | 1.2× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 121.51ms | 160.90ms | 1.3× | 2.0% | PASS |
| ac_reads | `oltp_point_select` | 60.24ms | 59.63ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 22.98ms | 28.83ms | 1.3× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 20.33ms | 23.02ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 4.13ms | 4.77ms | 1.2× | 0.6% | PASS |
| ac_reads | `oltp_distinct_range` | 5.14ms | 5.80ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 7.42ms | 8.45ms | 1.1× | 1.3% | PASS |
| ac_reads | `select_random_points` | 28.10ms | 31.95ms | 1.1× | 0.8% | PASS |
| ac_reads | `select_random_ranges` | 10.09ms | 10.72ms | 1.1× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 10.75ms | 12.56ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 38.89ms | 42.74ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 9.81ms | 12.77ms | 1.3× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 4.51ms | 6.92ms | 1.5× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.19s | 1.34s | 1.1× | 2.4% | PASS |
| ac_reads | `table_scan` | 1.47s | 1.47s | 1.0× | 3.4% | PASS |
| ac_reads | `oltp_read_only` | 194.86ms | 217.56ms | 1.1× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.04ms | 56.36ms | 3.1× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 20.73ms | 72.98ms | 3.5× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 22.24ms | 85.86ms | 3.9× | 6.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 18.29ms | 64.78ms | 3.5× | 6.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.26ms | 73.81ms | 3.6× | 4.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.91ms | 75.03ms | 3.6× | 6.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.08ms | 64.16ms | 3.5× | 8.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 27.67ms | 82.58ms | 3.0× | 4.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 16s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 31.02ms | 38.00ms | 81.6% | 1.1% | PASS |
| `status_dirty_many_tables` | 34.67ms | 42.00ms | 82.5% | 1.0% | PASS |
| `diff_regular_working_one_table` | 26.64ms | 33.00ms | 80.7% | 1.1% | PASS |
| `diff_regular_working_many_tables` | 39.64ms | 50.00ms | 79.3% | 0.9% | PASS |
| `diff_stat_working_many_tables` | 39.31ms | 48.00ms | 81.9% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 40.02ms | 48.00ms | 83.4% | 1.1% | PASS |
| `branch_list_many_branches` | 19.12ms | 25.00ms | 76.5% | 1.7% | PASS |
| `branch_create_delete` | 20.73ms | 27.00ms | 76.8% | 2.0% | PASS |
| `at_literal_deep_history` | 20.51ms | 28.00ms | 73.3% | 1.1% | PASS |
| `diff_literal_deep_history` | 20.75ms | 28.00ms | 74.1% | 1.8% | PASS |
| `history_literal_deep_history` | 22.21ms | 30.00ms | 74.0% | 1.3% | PASS |
| `checkout_branch_clean` | 29.43ms | 43.00ms | 68.4% | 1.1% | PASS |
| `merge_data_no_conflicts` | 24.06ms | 33.00ms | 72.9% | 1.3% | PASS |
| `merge_data_secondary_index` | 869.38ms | 944.00ms | 92.1% | 0.7% | PASS |
| `merge_schema_no_conflicts` | 18.03ms | 24.00ms | 75.1% | 1.8% | PASS |
| `merge_data_conflicts` | 26.59ms | 33.00ms | 80.6% | 1.0% | PASS |
| `merge_data_conflicts_with_resolve` | 27.23ms | 34.00ms | 80.1% | 1.0% | PASS |

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
| copy_fsync | candidate | 58.734 | 56.757–60.614 | 38.228 | 1702.59 | 107968266 |
| push_initial | candidate | 583.055 | 579.534–587.896 | 566.875 | 171.51 | 107956772 |
| clone_initial | candidate | 763.924 | 758.541–775.237 | 738.314 | 130.90 | 108475035 |
| push_noop | candidate | 0.695 | 0.627–2.156 | 0.369 | — | 0 |
| fetch_noop | candidate | 0.218 | 0.200–0.250 | 0.220 | — | 0 |
| push_incremental | candidate | 231.431 | 229.901–233.627 | 228.240 | 4.32 | 7909775 |
| fetch_incremental | candidate | 95.677 | 94.921–96.579 | 93.085 | 10.45 | 7910084 |
| pull_fast_forward | candidate | 84.840 | 84.500–85.542 | 82.220 | 11.79 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.50 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.71 | 295.235 | 109.784 | 47278 | 2337 |
| push_noop | candidate | 46.09 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.09 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.09 | 96.857 | 7.910 | 22410 | 125 |
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
| copy_fsync | candidate | 2643.968 | 2635.377–2668.223 | 351.014 | 378.22 | 1087718031 |
| push_initial | candidate | 6452.303 | 6442.684–6512.453 | 4201.096 | 154.98 | 1079566275 |
| clone_initial | candidate | 6266.714 | 6257.463–6271.384 | 6076.207 | 159.57 | 1102407326 |
| push_noop | candidate | 0.787 | 0.754–0.885 | 0.288 | — | 0 |
| fetch_noop | candidate | 0.145 | 0.117–0.145 | 0.145 | — | 0 |
| push_incremental | candidate | 888.343 | 886.045–889.755 | 883.492 | 1.13 | 15806003 |
| fetch_incremental | candidate | 225.254 | 221.752–227.499 | 219.950 | 4.44 | 15806513 |
| pull_fast_forward | candidate | 222.377 | 221.857–224.606 | 217.467 | 4.50 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.21 | 2091.179 | 1087.622 | 263327 | 20541 |
| clone_initial | candidate | 124.03 | 3521.597 | 1132.819 | 613280 | 32243 |
| push_noop | candidate | 47.17 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.17 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.26 | 618.437 | 15.928 | 150222 | 313 |
| fetch_incremental | candidate | 50.42 | 62.422 | 15.928 | 13941 | 313 |
| pull_fast_forward | candidate | 50.46 | 62.355 | 15.929 | 13937 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
