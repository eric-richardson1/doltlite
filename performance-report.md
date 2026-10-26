# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-10-26 18:15 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu24 20261023.334.3
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/40357561962)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.52s | 11.47s | 1.2× | 1.3% | **PASS** |
| Writes | 1.95s | 3.18s | 1.6× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.46s | 11.61s | 1.1× | 1.3% | **PASS** |
| Writes | 3.30s | 3.88s | 1.2× | 1.7% | **FAIL** |
| Autocommit writes | 802.81ms | 2.43s | 3.0× | 5.4% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.38s | 2.92s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.75s | 3.20s | 1.2× | 0.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 1.85s | 2.06s | 1.1× | 2.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.54s | 3.27s | 1.3× | 1.3% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 416.66ms | 726.82ms | 1.7× | 1.1% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 578.59ms | 939.95ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 365.71ms | 566.85ms | 1.6× | 2.4% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 589.44ms | 946.09ms | 1.6× | 1.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.62s | 2.98s | 1.1× | 1.4% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.08s | 3.28s | 1.1× | 0.9% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 1.90s | 2.00s | 1.1× | 1.8% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.86s | 3.35s | 1.2× | 1.2% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 574.89ms | 797.35ms | 1.4× | 1.4% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 914.57ms | 1.04s | 1.1× | 3.5% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.02s | 1.00s | 1.0× | 4.9% | **FAIL** |
| File-backed | Writes | compositepk | 8 | 55 | 781.62ms | 1.04s | 1.3× | 1.6% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.46s | 2.99s | 1.2× | 1.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.88s | 3.28s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.00s | 2.16s | 1.1× | 2.3% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.70s | 3.36s | 1.2× | 1.4% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 198.59ms | 645.90ms | 3.3× | 5.9% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 153.44ms | 549.04ms | 3.6× | 3.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 232.52ms | 549.81ms | 2.4× | 7.0% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 218.25ms | 689.32ms | 3.2× | 5.5% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 22.18ms | 31.35ms | 1.4× | 1.5% | PASS |
| mem_reads | `oltp_range_select` | 9.63ms | 12.85ms | 1.3× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 8.89ms | 12.12ms | 1.4× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 2.45ms | 2.98ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 3.56ms | 4.15ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.68ms | 5.45ms | 1.5× | 1.7% | PASS |
| mem_reads | `select_random_points` | 9.04ms | 11.87ms | 1.3× | 2.3% | PASS |
| mem_reads | `select_random_ranges` | 4.27ms | 5.32ms | 1.2× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 7.50ms | 10.83ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 29.26ms | 34.15ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 5.69ms | 8.53ms | 1.5× | 1.2% | PASS |
| mem_reads | `index_join_scan` | 3.04ms | 5.60ms | 1.8× | 2.1% | PASS |
| mem_reads | `types_table_scan` | 1.03s | 1.29s | 1.3× | 0.6% | PASS |
| mem_reads | `table_scan` | 1.15s | 1.36s | 1.2× | 0.4% | PASS |
| mem_reads | `oltp_read_only` | 98.66ms | 126.24ms | 1.3× | 0.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 172.02ms | 291.99ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 14.72ms | 27.61ms | 1.9× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 47.96ms | 89.95ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 32.45ms | 57.40ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 42.75ms | 72.54ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 20.68ms | 42.82ms | 2.1× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 23.07ms | 37.44ms | 1.6× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 63.00ms | 107.07ms | 1.7× | 0.7% | PASS |
| file_reads | `oltp_point_select` | 95.34ms | 50.62ms | 0.5× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 17.21ms | 14.91ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 16.54ms | 14.28ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.36ms | 3.25ms | 1.0× | 2.8% | PASS |
| file_reads | `oltp_distinct_range` | 4.50ms | 4.44ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 11.32ms | 7.66ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_points` | 17.35ms | 14.04ms | 0.8× | 3.3% | PASS |
| file_reads | `select_random_ranges` | 12.08ms | 7.44ms | 0.6× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 15.35ms | 13.14ms | 0.9× | 0.8% | PASS |
| file_reads | `groupby_scan` | 30.14ms | 34.56ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 9.93ms | 10.18ms | 1.0× | 1.4% | PASS |
| file_reads | `index_join_scan` | 4.16ms | 5.96ms | 1.4× | 1.5% | PASS |
| file_reads | `types_table_scan` | 1.03s | 1.29s | 1.3× | 0.4% | PASS |
| file_reads | `table_scan` | 1.15s | 1.36s | 1.2× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 205.88ms | 155.50ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 186.91ms | 301.46ms | 1.6× | 1.3% | PASS |
| file_writes | `oltp_insert` | 21.21ms | 30.88ms | 1.5× | 1.6% | PASS |
| file_writes | `oltp_update_index` | 74.96ms | 102.28ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 56.31ms | 67.43ms | 1.2× | 2.2% | PASS |
| file_writes | `oltp_delete_insert` | 66.20ms | 83.76ms | 1.3× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 43.18ms | 51.87ms | 1.2× | 1.5% | PASS |
| file_writes | `types_delete_insert` | 38.52ms | 43.69ms | 1.1× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 87.60ms | 115.96ms | 1.3× | 1.3% | PASS |
| ac_reads | `oltp_point_select` | 46.31ms | 50.67ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 12.55ms | 15.06ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_sum_range` | 11.80ms | 14.31ms | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 2.86ms | 3.27ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_distinct_range` | 3.97ms | 4.46ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_index_scan` | 6.29ms | 7.68ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_points` | 12.12ms | 14.12ms | 1.2× | 1.5% | PASS |
| ac_reads | `select_random_ranges` | 6.93ms | 7.40ms | 1.1× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.13ms | 13.07ms | 1.3× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 29.54ms | 34.47ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 7.28ms | 10.20ms | 1.4× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.60ms | 6.02ms | 1.7× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 1.03s | 1.29s | 1.3× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.15s | 1.36s | 1.2× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 134.08ms | 155.70ms | 1.2× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.36ms | 67.03ms | 3.0× | 4.0% | PASS |
| ac_writes | `oltp_insert_ac` | 24.23ms | 80.10ms | 3.3× | 5.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.86ms | 91.43ms | 3.4× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.30ms | 73.94ms | 3.3× | 4.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.64ms | 84.19ms | 3.4× | 6.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.74ms | 82.65ms | 3.3× | 6.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.64ms | 78.02ms | 3.4× | 6.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.83ms | 88.54ms | 2.9× | 6.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.62ms | 37.17ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 16.82ms | 15.53ms | 0.9× | 0.9% | PASS |
| mem_reads | `oltp_sum_range` | 15.02ms | 15.02ms | 1.0× | 0.7% | PASS |
| mem_reads | `oltp_order_range` | 3.48ms | 3.49ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 4.54ms | 4.59ms | 1.0× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.96ms | 6.41ms | 1.6× | 0.7% | PASS |
| mem_reads | `select_random_points` | 21.43ms | 21.69ms | 1.0× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 6.49ms | 6.40ms | 1.0× | 1.0% | PASS |
| mem_reads | `covering_index_scan` | 7.59ms | 10.55ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 36.87ms | 38.12ms | 1.0× | 0.4% | PASS |
| mem_reads | `index_join` | 10.61ms | 10.29ms | 1.0× | 1.1% | PASS |
| mem_reads | `index_join_scan` | 3.76ms | 6.59ms | 1.8× | 1.3% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.39s | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 1.30s | 1.50s | 1.2× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 136.93ms | 141.49ms | 1.0× | 0.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 235.36ms | 341.05ms | 1.4× | 1.4% | PASS |
| mem_writes | `oltp_insert` | 17.89ms | 38.04ms | 2.1× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 64.89ms | 133.81ms | 2.1× | 0.5% | PASS |
| mem_writes | `oltp_update_non_index` | 48.16ms | 82.40ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 54.26ms | 99.70ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_write_only` | 28.16ms | 57.41ms | 2.0× | 0.8% | PASS |
| mem_writes | `types_delete_insert` | 37.65ms | 55.26ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_read_write` | 92.23ms | 132.27ms | 1.4× | 0.6% | PASS |
| file_reads | `oltp_point_select` | 132.07ms | 60.73ms | 0.5× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 27.05ms | 17.92ms | 0.7× | 0.8% | PASS |
| file_reads | `oltp_sum_range` | 25.38ms | 17.59ms | 0.7× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 4.59ms | 3.79ms | 0.8× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 5.64ms | 4.91ms | 0.9× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 13.85ms | 8.92ms | 0.6× | 1.0% | PASS |
| file_reads | `select_random_points` | 32.53ms | 24.36ms | 0.7× | 1.3% | PASS |
| file_reads | `select_random_ranges` | 16.50ms | 8.87ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 17.64ms | 13.01ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 38.11ms | 38.56ms | 1.0× | 0.6% | PASS |
| file_reads | `index_join` | 16.39ms | 11.79ms | 0.7× | 1.7% | PASS |
| file_reads | `index_join_scan` | 4.94ms | 6.85ms | 1.4× | 1.6% | PASS |
| file_reads | `types_table_scan` | 1.15s | 1.39s | 1.2× | 0.4% | PASS |
| file_reads | `table_scan` | 1.31s | 1.50s | 1.1× | 0.6% | PASS |
| file_reads | `oltp_read_only` | 278.02ms | 175.83ms | 0.6× | 0.5% | PASS |
| file_writes | `oltp_bulk_insert` | 263.26ms | 356.66ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 25.29ms | 43.08ms | 1.7× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 114.06ms | 150.09ms | 1.3× | 7.6% | PASS |
| file_writes | `oltp_update_non_index` | 104.57ms | 95.30ms | 0.9× | 12.3% | PASS |
| file_writes | `oltp_delete_insert` | 96.52ms | 113.59ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 88.52ms | 68.96ms | 0.8× | 10.2% | PASS |
| file_writes | `types_delete_insert` | 72.39ms | 65.93ms | 0.9× | 1.0% | PASS |
| file_writes | `oltp_read_write` | 149.97ms | 144.80ms | 1.0× | 5.6% | PASS |
| ac_reads | `oltp_point_select` | 66.92ms | 60.96ms | 0.9× | 0.7% | PASS |
| ac_reads | `oltp_range_select` | 21.25ms | 18.07ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_sum_range` | 18.96ms | 17.61ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.96ms | 3.78ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.93ms | 4.88ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 7.41ms | 8.89ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 25.64ms | 24.26ms | 0.9× | 0.9% | PASS |
| ac_reads | `select_random_ranges` | 9.97ms | 8.89ms | 0.9× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 11.15ms | 13.04ms | 1.2× | 0.6% | PASS |
| ac_reads | `groupby_scan` | 37.20ms | 38.50ms | 1.0× | 0.5% | PASS |
| ac_reads | `index_join` | 13.41ms | 11.78ms | 0.9× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 4.40ms | 6.99ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.15s | 1.39s | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.31s | 1.50s | 1.1× | 0.4% | PASS |
| ac_reads | `oltp_read_only` | 185.05ms | 176.09ms | 1.0× | 0.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.06ms | 53.69ms | 3.1× | 2.7% | PASS |
| ac_writes | `oltp_insert_ac` | 19.15ms | 66.03ms | 3.4× | 4.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.92ms | 82.01ms | 3.9× | 5.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.07ms | 61.87ms | 3.9× | 3.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.11ms | 73.98ms | 3.9× | 4.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 18.55ms | 70.18ms | 3.8× | 3.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.14ms | 63.42ms | 3.7× | 4.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.46ms | 77.86ms | 3.1× | 3.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.75ms | 26.25ms | 0.9× | 3.0% | PASS |
| mem_reads | `oltp_range_select` | 12.07ms | 10.89ms | 0.9× | 2.7% | PASS |
| mem_reads | `oltp_sum_range` | 11.61ms | 10.74ms | 0.9× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 2.36ms | 2.33ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_distinct_range` | 2.86ms | 2.83ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_index_scan` | 2.77ms | 4.98ms | 1.8× | 2.2% | PASS |
| mem_reads | `select_random_points` | 19.93ms | 17.18ms | 0.9× | 3.7% | PASS |
| mem_reads | `select_random_ranges` | 4.86ms | 4.37ms | 0.9× | 2.4% | PASS |
| mem_reads | `covering_index_scan` | 4.25ms | 7.02ms | 1.7× | 3.1% | PASS |
| mem_reads | `groupby_scan` | 21.69ms | 22.03ms | 1.0× | 1.6% | PASS |
| mem_reads | `index_join` | 9.07ms | 9.25ms | 1.0× | 3.1% | PASS |
| mem_reads | `index_join_scan` | 3.16ms | 6.79ms | 2.2× | 5.5% | PASS |
| mem_reads | `types_table_scan` | 794.43ms | 916.63ms | 1.2× | 1.9% | PASS |
| mem_reads | `table_scan` | 843.88ms | 939.41ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_read_only` | 86.02ms | 82.70ms | 1.0× | 4.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 145.33ms | 202.97ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.21ms | 23.11ms | 2.1× | 1.8% | PASS |
| mem_writes | `oltp_update_index` | 42.93ms | 84.15ms | 2.0× | 3.1% | PASS |
| mem_writes | `oltp_update_non_index` | 33.03ms | 50.51ms | 1.5× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 33.65ms | 60.01ms | 1.8× | 2.0% | PASS |
| mem_writes | `oltp_write_only` | 17.46ms | 34.58ms | 2.0× | 2.8% | PASS |
| mem_writes | `types_delete_insert` | 24.43ms | 33.18ms | 1.4× | 3.3% | PASS |
| mem_writes | `oltp_read_write` | 57.66ms | 78.35ms | 1.4× | 3.7% | PASS |
| file_reads | `oltp_point_select` | 80.80ms | 39.09ms | 0.5× | 1.8% | PASS |
| file_reads | `oltp_range_select` | 16.84ms | 11.29ms | 0.7× | 2.2% | PASS |
| file_reads | `oltp_sum_range` | 17.50ms | 11.80ms | 0.7× | 2.7% | PASS |
| file_reads | `oltp_order_range` | 3.03ms | 2.46ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.53ms | 2.97ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 8.95ms | 6.20ms | 0.7× | 1.2% | PASS |
| file_reads | `select_random_points` | 21.79ms | 15.76ms | 0.7× | 3.0% | PASS |
| file_reads | `select_random_ranges` | 10.96ms | 5.96ms | 0.5× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 10.92ms | 8.24ms | 0.8× | 1.7% | PASS |
| file_reads | `groupby_scan` | 22.67ms | 22.45ms | 1.0× | 1.3% | PASS |
| file_reads | `index_join` | 12.72ms | 8.87ms | 0.7× | 3.0% | PASS |
| file_reads | `index_join_scan` | 3.48ms | 5.16ms | 1.5× | 2.8% | PASS |
| file_reads | `types_table_scan` | 709.47ms | 831.52ms | 1.2× | 2.7% | PASS |
| file_reads | `table_scan` | 814.57ms | 922.00ms | 1.1× | 1.2% | PASS |
| file_reads | `oltp_read_only` | 164.24ms | 104.63ms | 0.6× | 2.8% | PASS |
| file_writes | `oltp_bulk_insert` | 211.67ms | 267.86ms | 1.3× | 3.8% | PASS |
| file_writes | `oltp_insert` | 19.05ms | 46.45ms | 2.4× | 8.2% | FAIL |
| file_writes | `oltp_update_index` | 146.49ms | 165.60ms | 1.1× | 6.0% | PASS |
| file_writes | `oltp_update_non_index` | 121.28ms | 109.40ms | 0.9× | 3.8% | PASS |
| file_writes | `oltp_delete_insert` | 151.02ms | 127.81ms | 0.8× | 4.7% | PASS |
| file_writes | `oltp_write_only` | 110.57ms | 79.98ms | 0.7× | 5.1% | PASS |
| file_writes | `types_delete_insert` | 104.33ms | 70.10ms | 0.7× | 4.4% | PASS |
| file_writes | `oltp_read_write` | 159.98ms | 134.62ms | 0.8× | 5.7% | PASS |
| ac_reads | `oltp_point_select` | 44.60ms | 40.92ms | 0.9× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 13.21ms | 11.60ms | 0.9× | 2.9% | PASS |
| ac_reads | `oltp_sum_range` | 12.87ms | 11.43ms | 0.9× | 2.5% | PASS |
| ac_reads | `oltp_order_range` | 2.67ms | 2.46ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_distinct_range` | 3.15ms | 2.94ms | 0.9× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 4.97ms | 6.16ms | 1.2× | 2.3% | PASS |
| ac_reads | `select_random_points` | 17.51ms | 15.56ms | 0.9× | 3.0% | PASS |
| ac_reads | `select_random_ranges` | 6.53ms | 5.83ms | 0.9× | 2.7% | PASS |
| ac_reads | `covering_index_scan` | 6.38ms | 7.82ms | 1.2× | 2.9% | PASS |
| ac_reads | `groupby_scan` | 20.75ms | 21.20ms | 1.0× | 1.6% | PASS |
| ac_reads | `index_join` | 9.90ms | 8.28ms | 0.8× | 3.4% | PASS |
| ac_reads | `index_join_scan` | 3.18ms | 5.12ms | 1.6× | 2.3% | PASS |
| ac_reads | `types_table_scan` | 725.83ms | 849.44ms | 1.2× | 2.4% | PASS |
| ac_reads | `table_scan` | 1.01s | 1.06s | 1.0× | 2.0% | PASS |
| ac_reads | `oltp_read_only` | 121.70ms | 108.17ms | 0.9× | 2.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 28.28ms | 57.27ms | 2.0× | 5.0% | PASS |
| ac_writes | `oltp_insert_ac` | 31.35ms | 72.50ms | 2.3× | 8.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 31.34ms | 77.53ms | 2.5× | 7.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 26.00ms | 63.74ms | 2.5× | 7.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 30.13ms | 69.17ms | 2.3× | 3.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.39ms | 70.71ms | 2.4× | 13.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.09ms | 64.33ms | 2.8× | 7.0% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.92ms | 74.57ms | 2.3× | 5.7% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.87ms | 42.83ms | 1.3× | 1.9% | PASS |
| mem_reads | `oltp_range_select` | 19.66ms | 25.24ms | 1.3× | 1.1% | PASS |
| mem_reads | `oltp_sum_range` | 18.49ms | 22.58ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 3.56ms | 4.19ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 4.47ms | 5.32ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.27ms | 6.30ms | 1.5× | 1.7% | PASS |
| mem_reads | `select_random_points` | 27.39ms | 33.01ms | 1.2× | 1.7% | PASS |
| mem_reads | `select_random_ranges` | 7.28ms | 9.42ms | 1.3× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 7.60ms | 10.98ms | 1.4× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 35.41ms | 42.00ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 7.85ms | 11.56ms | 1.5× | 1.4% | PASS |
| mem_reads | `index_join_scan` | 3.88ms | 6.43ms | 1.7× | 2.4% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.40s | 1.3× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.17s | 1.47s | 1.3× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 146.14ms | 184.01ms | 1.3× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 243.19ms | 351.05ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 18.66ms | 34.27ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 65.94ms | 119.07ms | 1.8× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 50.84ms | 82.82ms | 1.6× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 48.32ms | 91.02ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 26.63ms | 53.40ms | 2.0× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 32.63ms | 54.29ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 103.22ms | 160.18ms | 1.6× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 109.08ms | 62.75ms | 0.6× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 27.38ms | 27.71ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 26.11ms | 25.21ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 4.52ms | 4.54ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 5.68ms | 5.74ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 12.43ms | 8.96ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 38.97ms | 37.77ms | 1.0× | 1.2% | PASS |
| file_reads | `select_random_ranges` | 15.88ms | 11.98ms | 0.8× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.64ms | 13.74ms | 0.9× | 1.1% | PASS |
| file_reads | `groupby_scan` | 36.90ms | 42.77ms | 1.2× | 1.0% | PASS |
| file_reads | `index_join` | 12.36ms | 13.73ms | 1.1× | 1.3% | PASS |
| file_reads | `index_join_scan` | 4.93ms | 7.05ms | 1.4× | 2.2% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.40s | 1.3× | 0.6% | PASS |
| file_reads | `table_scan` | 1.24s | 1.47s | 1.2× | 3.2% | PASS |
| file_reads | `oltp_read_only` | 261.49ms | 218.18ms | 0.8× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 260.93ms | 364.37ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 26.36ms | 38.24ms | 1.5× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 96.77ms | 137.09ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_update_non_index` | 79.36ms | 95.72ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_delete_insert` | 79.23ms | 107.27ms | 1.4× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 52.83ms | 64.32ms | 1.2× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 50.69ms | 63.16ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_read_write` | 135.45ms | 173.79ms | 1.3× | 1.6% | PASS |
| ac_reads | `oltp_point_select` | 59.62ms | 63.81ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 21.63ms | 27.67ms | 1.3× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 20.39ms | 25.17ms | 1.2× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.91ms | 4.54ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.98ms | 5.71ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 7.19ms | 8.85ms | 1.2× | 1.1% | PASS |
| ac_reads | `select_random_points` | 31.44ms | 37.31ms | 1.2× | 1.2% | PASS |
| ac_reads | `select_random_ranges` | 10.12ms | 11.97ms | 1.2× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 10.35ms | 13.62ms | 1.3× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 35.93ms | 42.71ms | 1.2× | 0.8% | PASS |
| ac_reads | `index_join` | 9.52ms | 13.58ms | 1.4× | 1.8% | PASS |
| ac_reads | `index_join_scan` | 4.46ms | 7.18ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.04s | 1.40s | 1.3× | 0.8% | PASS |
| ac_reads | `table_scan` | 1.25s | 1.48s | 1.2× | 3.0% | PASS |
| ac_reads | `oltp_read_only` | 189.16ms | 219.69ms | 1.2× | 1.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.26ms | 70.64ms | 2.9× | 4.9% | PASS |
| ac_writes | `oltp_insert_ac` | 26.35ms | 85.96ms | 3.3× | 5.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 29.07ms | 97.43ms | 3.4× | 5.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 25.66ms | 80.13ms | 3.1× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.42ms | 86.32ms | 3.1× | 8.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 26.53ms | 86.00ms | 3.2× | 5.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 24.65ms | 84.41ms | 3.4× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 34.32ms | 98.43ms | 2.9× | 5.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 5m 55s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 25.22ms | 38.00ms | 66.4% | 2.0% | PASS |
| `status_dirty_many_tables` | 28.27ms | 42.00ms | 67.3% | 3.4% | PASS |
| `diff_regular_working_one_table` | 22.52ms | 33.00ms | 68.2% | 2.6% | PASS |
| `diff_regular_working_many_tables` | 31.11ms | 50.00ms | 62.2% | 3.3% | PASS |
| `diff_stat_working_many_tables` | 31.46ms | 48.00ms | 65.5% | 3.5% | PASS |
| `diff_schema_working_many_tables` | 30.47ms | 48.00ms | 63.5% | 1.8% | PASS |
| `branch_list_many_branches` | 16.16ms | 25.00ms | 64.6% | 1.8% | PASS |
| `branch_create_delete` | 17.77ms | 27.00ms | 65.8% | 2.8% | PASS |
| `at_literal_deep_history` | 17.72ms | 28.00ms | 63.3% | 2.0% | PASS |
| `diff_literal_deep_history` | 17.26ms | 28.00ms | 61.7% | 1.9% | PASS |
| `history_literal_deep_history` | 18.07ms | 30.00ms | 60.2% | 2.7% | PASS |
| `checkout_branch_clean` | 25.13ms | 43.00ms | 58.4% | 3.1% | PASS |
| `merge_data_no_conflicts` | 19.34ms | 33.00ms | 58.6% | 1.9% | PASS |
| `merge_data_secondary_index` | 677.73ms | 944.00ms | 71.8% | 1.5% | PASS |
| `merge_schema_no_conflicts` | 15.91ms | 24.00ms | 66.3% | 2.6% | PASS |
| `merge_data_conflicts` | 21.20ms | 33.00ms | 64.2% | 2.2% | PASS |
| `merge_data_conflicts_with_resolve` | 22.51ms | 34.00ms | 66.2% | 2.4% | PASS |

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
| copy_fsync | candidate | 399.947 | 393.971–451.015 | 33.442 | 250.03 | 107968266 |
| push_initial | candidate | 703.512 | 683.310–787.269 | 326.701 | 142.14 | 107956772 |
| clone_initial | candidate | 778.931 | 775.354–819.377 | 415.329 | 128.38 | 108475035 |
| push_noop | candidate | 0.685 | 0.663–1.000 | 0.252 | — | 0 |
| fetch_noop | candidate | 0.127 | 0.103–0.141 | 0.129 | — | 0 |
| push_incremental | candidate | 147.217 | 142.950–158.464 | 129.806 | 6.79 | 7909775 |
| fetch_incremental | candidate | 76.950 | 70.466–78.637 | 57.141 | 13.00 | 7910084 |
| pull_fast_forward | candidate | 70.460 | 68.639–74.762 | 51.543 | 14.19 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.61 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.85 | 295.164 | 109.784 | 47259 | 2337 |
| push_noop | candidate | 42.04 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 42.04 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 42.04 | 96.946 | 7.910 | 22431 | 125 |
| fetch_incremental | candidate | 42.04 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 42.04 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 2640.238 | 2639.483–2663.426 | 373.372 | 378.75 | 1087718031 |
| push_initial | candidate | 7613.125 | 7578.779–7642.301 | 5341.034 | 131.35 | 1079566275 |
| clone_initial | candidate | 8298.573 | 8252.358–8305.461 | 8021.070 | 120.50 | 1102407326 |
| push_noop | candidate | 0.908 | 0.781–1.392 | 0.394 | — | 0 |
| fetch_noop | candidate | 0.213 | 0.192–0.233 | 0.215 | — | 0 |
| push_incremental | candidate | 1290.205 | 1287.984–1295.210 | 1284.138 | 0.78 | 15806003 |
| fetch_incremental | candidate | 253.939 | 253.293–255.526 | 246.850 | 3.94 | 15806513 |
| pull_fast_forward | candidate | 256.287 | 251.734–267.678 | 249.717 | 3.90 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 135.04 | 2091.884 | 1087.622 | 263499 | 20541 |
| clone_initial | candidate | 125.09 | 3513.307 | 1132.819 | 611175 | 32243 |
| push_noop | candidate | 44.75 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 44.75 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 49.07 | 614.756 | 15.928 | 149304 | 313 |
| fetch_incremental | candidate | 50.94 | 62.135 | 15.928 | 13871 | 313 |
| pull_fast_forward | candidate | 51.23 | 62.068 | 15.929 | 13867 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
