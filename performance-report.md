# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-21 18:46 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/44927123958)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.44s | 10.12s | 1.2× | 1.8% | **PASS** |
| Writes | 1.73s | 2.83s | 1.6× | 1.4% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.02s | 10.23s | 1.1× | 1.5% | **PASS** |
| Writes | 3.28s | 3.75s | 1.1× | 1.9% | **PASS** |
| Autocommit writes | 780.74ms | 2.31s | 3.0× | 5.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.58s | 1.71s | 1.1× | 2.7% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.79s | 2.11s | 1.2× | 3.3% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.59s | 3.26s | 1.3× | 1.4% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.48s | 3.04s | 1.2× | 1.1% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 271.82ms | 463.75ms | 1.7× | 1.6% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 350.15ms | 551.35ms | 1.6× | 2.0% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 582.66ms | 972.46ms | 1.7× | 1.5% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 525.34ms | 846.15ms | 1.6× | 0.9% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.85s | 1.78s | 1.0× | 1.6% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 1.87s | 2.11s | 1.1× | 2.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.80s | 3.31s | 1.2× | 1.7% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.50s | 3.03s | 1.2× | 1.3% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 714.66ms | 708.79ms | 1.0× | 4.1% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.14s | 1.08s | 1.0× | 2.2% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 805.35ms | 1.08s | 1.3× | 1.6% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 618.46ms | 879.98ms | 1.4× | 1.2% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.69s | 1.78s | 1.1× | 1.7% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 1.80s | 2.11s | 1.2× | 3.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.64s | 3.31s | 1.3× | 1.8% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.43s | 3.03s | 1.2× | 1.0% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 164.78ms | 471.19ms | 2.9× | 3.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 287.47ms | 780.07ms | 2.7× | 4.9% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 187.88ms | 595.10ms | 3.2× | 5.6% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 140.61ms | 465.42ms | 3.3× | 6.0% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 13.99ms | 17.17ms | 1.2× | 3.9% | PASS |
| mem_reads | `oltp_range_select` | 5.97ms | 6.87ms | 1.2× | 2.6% | PASS |
| mem_reads | `oltp_sum_range` | 5.39ms | 6.80ms | 1.3× | 3.6% | PASS |
| mem_reads | `oltp_order_range` | 1.51ms | 1.74ms | 1.2× | 3.6% | PASS |
| mem_reads | `oltp_distinct_range` | 1.99ms | 2.23ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_index_scan` | 2.12ms | 3.14ms | 1.5× | 2.8% | PASS |
| mem_reads | `select_random_points` | 7.03ms | 8.31ms | 1.2× | 7.3% | PASS |
| mem_reads | `select_random_ranges` | 2.64ms | 3.00ms | 1.1× | 2.7% | PASS |
| mem_reads | `covering_index_scan` | 4.03ms | 5.58ms | 1.4× | 1.9% | PASS |
| mem_reads | `groupby_scan` | 18.39ms | 19.99ms | 1.1× | 1.5% | PASS |
| mem_reads | `index_join` | 3.49ms | 5.57ms | 1.6× | 2.7% | PASS |
| mem_reads | `index_join_scan` | 2.34ms | 4.10ms | 1.8× | 3.6% | PASS |
| mem_reads | `types_table_scan` | 682.04ms | 746.62ms | 1.1× | 1.3% | PASS |
| mem_reads | `table_scan` | 772.10ms | 811.98ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 56.78ms | 64.51ms | 1.1× | 2.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 105.42ms | 170.40ms | 1.6× | 1.0% | PASS |
| mem_writes | `oltp_insert` | 9.05ms | 15.85ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 32.83ms | 64.77ms | 2.0× | 1.8% | PASS |
| mem_writes | `oltp_update_non_index` | 24.45ms | 41.70ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_delete_insert` | 28.96ms | 50.73ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 14.34ms | 32.19ms | 2.2× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 15.92ms | 22.50ms | 1.4× | 1.9% | PASS |
| mem_writes | `oltp_read_write` | 40.86ms | 65.62ms | 1.6× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 69.30ms | 32.92ms | 0.5× | 1.5% | PASS |
| file_reads | `oltp_range_select` | 12.21ms | 8.71ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_sum_range` | 11.83ms | 8.74ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 2.33ms | 2.04ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 2.70ms | 2.45ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 7.77ms | 4.71ms | 0.6× | 1.3% | PASS |
| file_reads | `select_random_points` | 13.41ms | 10.08ms | 0.8× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 7.92ms | 4.36ms | 0.5× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 9.56ms | 7.19ms | 0.8× | 1.7% | PASS |
| file_reads | `groupby_scan` | 18.90ms | 19.55ms | 1.0× | 1.8% | PASS |
| file_reads | `index_join` | 6.72ms | 6.67ms | 1.0× | 2.6% | PASS |
| file_reads | `index_join_scan` | 3.07ms | 4.45ms | 1.4× | 3.4% | PASS |
| file_reads | `types_table_scan` | 710.64ms | 747.72ms | 1.1× | 1.2% | PASS |
| file_reads | `table_scan` | 841.32ms | 830.27ms | 1.0× | 2.4% | PASS |
| file_reads | `oltp_read_only` | 136.44ms | 86.25ms | 0.6× | 1.7% | PASS |
| file_writes | `oltp_bulk_insert` | 140.78ms | 211.03ms | 1.5× | 2.4% | PASS |
| file_writes | `oltp_insert` | 19.80ms | 26.86ms | 1.4× | 5.3% | PASS |
| file_writes | `oltp_update_index` | 123.37ms | 110.90ms | 0.9× | 6.8% | PASS |
| file_writes | `oltp_update_non_index` | 101.11ms | 77.95ms | 0.8× | 2.8% | PASS |
| file_writes | `oltp_delete_insert` | 103.94ms | 91.87ms | 0.9× | 3.2% | PASS |
| file_writes | `oltp_write_only` | 71.68ms | 59.62ms | 0.8× | 4.5% | PASS |
| file_writes | `types_delete_insert` | 61.20ms | 40.73ms | 0.7× | 12.3% | PASS |
| file_writes | `oltp_read_write` | 92.79ms | 89.83ms | 1.0× | 3.6% | PASS |
| ac_reads | `oltp_point_select` | 30.00ms | 30.47ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 8.09ms | 8.36ms | 1.0× | 3.2% | PASS |
| ac_reads | `oltp_sum_range` | 7.90ms | 8.43ms | 1.1× | 2.7% | PASS |
| ac_reads | `oltp_order_range` | 1.91ms | 1.99ms | 1.0× | 3.3% | PASS |
| ac_reads | `oltp_distinct_range` | 2.37ms | 2.46ms | 1.0× | 3.1% | PASS |
| ac_reads | `oltp_index_scan` | 3.98ms | 4.72ms | 1.2× | 1.7% | PASS |
| ac_reads | `select_random_points` | 8.41ms | 9.53ms | 1.1× | 3.1% | PASS |
| ac_reads | `select_random_ranges` | 4.48ms | 4.47ms | 1.0× | 1.2% | PASS |
| ac_reads | `covering_index_scan` | 5.93ms | 7.38ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 18.98ms | 20.29ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 4.60ms | 6.31ms | 1.4× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 2.61ms | 4.29ms | 1.6× | 3.3% | PASS |
| ac_reads | `types_table_scan` | 707.09ms | 752.06ms | 1.1× | 1.4% | PASS |
| ac_reads | `table_scan` | 793.27ms | 831.38ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 85.68ms | 87.25ms | 1.0× | 1.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.07ms | 50.18ms | 2.6× | 3.5% | PASS |
| ac_writes | `oltp_insert_ac` | 20.79ms | 58.03ms | 2.8× | 3.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.88ms | 65.11ms | 3.0× | 3.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.36ms | 55.48ms | 2.9× | 4.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.79ms | 61.23ms | 2.9× | 3.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.72ms | 61.10ms | 2.9× | 3.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.93ms | 54.82ms | 2.9× | 2.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 23.23ms | 65.24ms | 2.8× | 2.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 21.18ms | 23.17ms | 1.1× | 4.4% | PASS |
| mem_reads | `oltp_range_select` | 10.16ms | 10.84ms | 1.1× | 7.2% | PASS |
| mem_reads | `oltp_sum_range` | 9.69ms | 10.24ms | 1.1× | 4.2% | PASS |
| mem_reads | `oltp_order_range` | 2.19ms | 2.35ms | 1.1× | 4.5% | PASS |
| mem_reads | `oltp_distinct_range` | 2.81ms | 3.00ms | 1.1× | 3.7% | PASS |
| mem_reads | `oltp_index_scan` | 2.47ms | 4.14ms | 1.7× | 3.5% | PASS |
| mem_reads | `select_random_points` | 15.62ms | 16.74ms | 1.1× | 3.4% | PASS |
| mem_reads | `select_random_ranges` | 4.58ms | 4.35ms | 0.9× | 2.9% | PASS |
| mem_reads | `covering_index_scan` | 4.37ms | 6.30ms | 1.4× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 22.64ms | 24.72ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 9.20ms | 7.09ms | 0.8× | 2.5% | PASS |
| mem_reads | `index_join_scan` | 2.56ms | 5.53ms | 2.2× | 3.3% | PASS |
| mem_reads | `types_table_scan` | 742.50ms | 909.61ms | 1.2× | 1.0% | PASS |
| mem_reads | `table_scan` | 857.33ms | 992.71ms | 1.2× | 2.3% | PASS |
| mem_reads | `oltp_read_only` | 83.75ms | 91.57ms | 1.1× | 1.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 128.75ms | 186.94ms | 1.5× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 10.46ms | 20.88ms | 2.0× | 1.3% | PASS |
| mem_writes | `oltp_update_index` | 43.85ms | 87.94ms | 2.0× | 2.2% | PASS |
| mem_writes | `oltp_update_non_index` | 31.19ms | 48.41ms | 1.6× | 3.1% | PASS |
| mem_writes | `oltp_delete_insert` | 35.09ms | 61.34ms | 1.7× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 17.09ms | 31.98ms | 1.9× | 3.2% | PASS |
| mem_writes | `types_delete_insert` | 23.76ms | 33.09ms | 1.4× | 5.6% | PASS |
| mem_writes | `oltp_read_write` | 59.96ms | 80.77ms | 1.3× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 43.06ms | 28.28ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_range_select` | 13.04ms | 11.63ms | 0.9× | 5.3% | PASS |
| file_reads | `oltp_sum_range` | 12.71ms | 10.91ms | 0.9× | 5.6% | PASS |
| file_reads | `oltp_order_range` | 2.53ms | 2.47ms | 1.0× | 2.8% | PASS |
| file_reads | `oltp_distinct_range` | 3.20ms | 3.19ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 4.69ms | 4.59ms | 1.0× | 4.1% | PASS |
| file_reads | `select_random_points` | 19.37ms | 17.71ms | 0.9× | 3.2% | PASS |
| file_reads | `select_random_ranges` | 6.58ms | 4.94ms | 0.8× | 2.7% | PASS |
| file_reads | `covering_index_scan` | 6.67ms | 7.27ms | 1.1× | 1.3% | PASS |
| file_reads | `groupby_scan` | 23.15ms | 25.09ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 10.70ms | 7.90ms | 0.7× | 5.4% | PASS |
| file_reads | `index_join_scan` | 3.06ms | 5.75ms | 1.9× | 3.1% | PASS |
| file_reads | `types_table_scan` | 743.78ms | 897.97ms | 1.2× | 1.1% | PASS |
| file_reads | `table_scan` | 860.95ms | 986.60ms | 1.1× | 2.4% | PASS |
| file_reads | `oltp_read_only` | 115.70ms | 98.78ms | 0.9× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 211.49ms | 266.57ms | 1.3× | 1.9% | PASS |
| file_writes | `oltp_insert` | 27.14ms | 47.97ms | 1.8× | 2.2% | PASS |
| file_writes | `oltp_update_index` | 162.33ms | 182.73ms | 1.1× | 2.2% | PASS |
| file_writes | `oltp_update_non_index` | 138.11ms | 115.83ms | 0.8× | 2.9% | PASS |
| file_writes | `oltp_delete_insert` | 175.50ms | 142.62ms | 0.8× | 1.8% | PASS |
| file_writes | `oltp_write_only` | 119.81ms | 95.66ms | 0.8× | 2.3% | PASS |
| file_writes | `types_delete_insert` | 140.09ms | 86.27ms | 0.6× | 4.9% | PASS |
| file_writes | `oltp_read_write` | 162.70ms | 145.93ms | 0.9× | 4.2% | PASS |
| ac_reads | `oltp_point_select` | 29.32ms | 28.57ms | 1.0× | 2.6% | PASS |
| ac_reads | `oltp_range_select` | 11.50ms | 11.35ms | 1.0× | 4.4% | PASS |
| ac_reads | `oltp_sum_range` | 10.79ms | 10.74ms | 1.0× | 8.4% | PASS |
| ac_reads | `oltp_order_range` | 2.28ms | 2.39ms | 1.1× | 3.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.00ms | 3.14ms | 1.0× | 2.4% | PASS |
| ac_reads | `oltp_index_scan` | 3.48ms | 4.85ms | 1.4× | 4.7% | PASS |
| ac_reads | `select_random_points` | 17.80ms | 17.34ms | 1.0× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 5.18ms | 4.73ms | 0.9× | 4.7% | PASS |
| ac_reads | `covering_index_scan` | 5.08ms | 6.84ms | 1.3× | 1.4% | PASS |
| ac_reads | `groupby_scan` | 22.19ms | 24.58ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 9.02ms | 7.18ms | 0.8× | 3.7% | PASS |
| ac_reads | `index_join_scan` | 2.83ms | 5.72ms | 2.0× | 5.8% | PASS |
| ac_reads | `types_table_scan` | 741.39ms | 895.67ms | 1.2× | 1.2% | PASS |
| ac_reads | `table_scan` | 838.26ms | 985.92ms | 1.2× | 3.1% | PASS |
| ac_reads | `oltp_read_only` | 95.25ms | 98.63ms | 1.0× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 34.78ms | 86.49ms | 2.5× | 4.5% | PASS |
| ac_writes | `oltp_insert_ac` | 35.90ms | 95.14ms | 2.7× | 4.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 36.53ms | 107.15ms | 2.9× | 3.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 34.09ms | 94.92ms | 2.8× | 7.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 35.94ms | 101.85ms | 2.8× | 5.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 35.33ms | 96.81ms | 2.7× | 3.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 35.05ms | 93.69ms | 2.7× | 5.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 39.84ms | 104.02ms | 2.6× | 5.5% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 35.22ms | 40.50ms | 1.2× | 2.6% | PASS |
| mem_reads | `oltp_range_select` | 16.56ms | 16.50ms | 1.0× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 15.15ms | 15.69ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.30ms | 3.58ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 4.24ms | 4.80ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.95ms | 6.79ms | 1.7× | 1.2% | PASS |
| mem_reads | `select_random_points` | 21.68ms | 22.50ms | 1.0× | 3.0% | PASS |
| mem_reads | `select_random_ranges` | 6.63ms | 7.02ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 8.02ms | 11.13ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 34.37ms | 38.29ms | 1.1× | 0.8% | PASS |
| mem_reads | `index_join` | 10.34ms | 10.87ms | 1.1× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.76ms | 6.59ms | 1.8× | 2.0% | PASS |
| mem_reads | `types_table_scan` | 1.08s | 1.41s | 1.3× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.21s | 1.51s | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_read_only` | 138.78ms | 153.49ms | 1.1× | 1.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 237.13ms | 362.57ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.07ms | 37.21ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 64.73ms | 136.44ms | 2.1× | 1.7% | PASS |
| mem_writes | `oltp_update_non_index` | 47.88ms | 80.47ms | 1.7× | 2.1% | PASS |
| mem_writes | `oltp_delete_insert` | 51.81ms | 101.65ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 27.76ms | 55.23ms | 2.0× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 38.30ms | 58.83ms | 1.5× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 96.98ms | 140.07ms | 1.4× | 1.8% | PASS |
| file_reads | `oltp_point_select` | 104.72ms | 59.41ms | 0.6× | 1.7% | PASS |
| file_reads | `oltp_range_select` | 24.32ms | 18.73ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 22.64ms | 17.92ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 4.20ms | 3.88ms | 0.9× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 5.17ms | 5.10ms | 1.0× | 1.7% | PASS |
| file_reads | `oltp_index_scan` | 11.05ms | 8.85ms | 0.8× | 1.2% | PASS |
| file_reads | `select_random_points` | 29.79ms | 25.33ms | 0.9× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 14.07ms | 9.11ms | 0.6× | 1.8% | PASS |
| file_reads | `covering_index_scan` | 15.51ms | 13.37ms | 0.9× | 1.1% | PASS |
| file_reads | `groupby_scan` | 35.47ms | 38.65ms | 1.1× | 1.1% | PASS |
| file_reads | `index_join` | 14.64ms | 12.19ms | 0.8× | 2.2% | PASS |
| file_reads | `index_join_scan` | 4.81ms | 6.87ms | 1.4× | 2.5% | PASS |
| file_reads | `types_table_scan` | 1.07s | 1.40s | 1.3× | 0.8% | PASS |
| file_reads | `table_scan` | 1.20s | 1.51s | 1.3× | 1.1% | PASS |
| file_reads | `oltp_read_only` | 242.06ms | 182.28ms | 0.8× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 256.16ms | 378.15ms | 1.5× | 0.7% | PASS |
| file_writes | `oltp_insert` | 25.16ms | 42.34ms | 1.7× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 98.03ms | 155.42ms | 1.6× | 1.5% | PASS |
| file_writes | `oltp_update_non_index` | 89.10ms | 93.85ms | 1.1× | 10.0% | PASS |
| file_writes | `oltp_delete_insert` | 85.84ms | 118.07ms | 1.4× | 1.5% | PASS |
| file_writes | `oltp_write_only` | 57.83ms | 68.14ms | 1.2× | 1.7% | PASS |
| file_writes | `types_delete_insert` | 63.27ms | 69.85ms | 1.1× | 1.8% | PASS |
| file_writes | `oltp_read_write` | 129.96ms | 152.88ms | 1.2× | 2.0% | PASS |
| ac_reads | `oltp_point_select` | 58.31ms | 59.60ms | 1.0× | 1.6% | PASS |
| ac_reads | `oltp_range_select` | 19.83ms | 18.70ms | 0.9× | 2.3% | PASS |
| ac_reads | `oltp_sum_range` | 17.98ms | 17.94ms | 1.0× | 1.9% | PASS |
| ac_reads | `oltp_order_range` | 3.74ms | 3.88ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_distinct_range` | 4.66ms | 5.10ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_index_scan` | 6.51ms | 8.83ms | 1.4× | 2.4% | PASS |
| ac_reads | `select_random_points` | 25.45ms | 25.43ms | 1.0× | 2.6% | PASS |
| ac_reads | `select_random_ranges` | 9.27ms | 9.08ms | 1.0× | 1.8% | PASS |
| ac_reads | `covering_index_scan` | 10.78ms | 13.34ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 34.99ms | 38.84ms | 1.1× | 0.9% | PASS |
| ac_reads | `index_join` | 12.27ms | 12.28ms | 1.0× | 2.7% | PASS |
| ac_reads | `index_join_scan` | 4.32ms | 6.97ms | 1.6× | 2.6% | PASS |
| ac_reads | `types_table_scan` | 1.07s | 1.40s | 1.3× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.19s | 1.51s | 1.3× | 0.7% | PASS |
| ac_reads | `oltp_read_only` | 172.81ms | 182.49ms | 1.1× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.23ms | 60.30ms | 2.7× | 5.2% | PASS |
| ac_writes | `oltp_insert_ac` | 23.58ms | 74.86ms | 3.2× | 5.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.71ms | 86.62ms | 3.7× | 4.4% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.19ms | 67.90ms | 3.2× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.99ms | 77.20ms | 3.4× | 5.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.29ms | 76.75ms | 3.2× | 5.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.04ms | 69.14ms | 3.3× | 5.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.85ms | 82.30ms | 2.9× | 5.5% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 30.30ms | 37.58ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_range_select` | 16.35ms | 20.59ms | 1.3× | 0.8% | PASS |
| mem_reads | `oltp_sum_range` | 15.69ms | 19.38ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_order_range` | 3.12ms | 3.72ms | 1.2× | 0.7% | PASS |
| mem_reads | `oltp_distinct_range` | 3.89ms | 4.71ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.98ms | 6.01ms | 1.5× | 1.1% | PASS |
| mem_reads | `select_random_points` | 22.82ms | 29.13ms | 1.3× | 1.2% | PASS |
| mem_reads | `select_random_ranges` | 6.60ms | 8.45ms | 1.3× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 6.79ms | 9.81ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 33.04ms | 38.57ms | 1.2× | 0.4% | PASS |
| mem_reads | `index_join` | 6.91ms | 11.04ms | 1.6× | 0.9% | PASS |
| mem_reads | `index_join_scan` | 3.29ms | 6.05ms | 1.8× | 1.0% | PASS |
| mem_reads | `types_table_scan` | 970.00ms | 1.28s | 1.3× | 2.0% | PASS |
| mem_reads | `table_scan` | 1.22s | 1.40s | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_read_only` | 134.48ms | 162.79ms | 1.2× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 216.71ms | 293.64ms | 1.4× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 16.76ms | 29.62ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 62.38ms | 121.83ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_update_non_index` | 46.49ms | 78.84ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_delete_insert` | 44.49ms | 86.96ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 23.91ms | 51.93ms | 2.2× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 28.66ms | 48.01ms | 1.7× | 1.0% | PASS |
| mem_writes | `oltp_read_write` | 85.95ms | 135.32ms | 1.6× | 1.4% | PASS |
| file_reads | `oltp_point_select` | 58.17ms | 45.52ms | 0.8× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 19.05ms | 21.59ms | 1.1× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 18.44ms | 20.46ms | 1.1× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 3.44ms | 3.85ms | 1.1× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 4.28ms | 4.86ms | 1.1× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 6.94ms | 7.04ms | 1.0× | 1.4% | PASS |
| file_reads | `select_random_points` | 26.79ms | 30.69ms | 1.1× | 1.6% | PASS |
| file_reads | `select_random_ranges` | 9.70ms | 9.51ms | 1.0× | 1.0% | PASS |
| file_reads | `covering_index_scan` | 9.86ms | 10.78ms | 1.1× | 1.2% | PASS |
| file_reads | `groupby_scan` | 33.02ms | 38.65ms | 1.2× | 0.9% | PASS |
| file_reads | `index_join` | 8.73ms | 11.45ms | 1.3× | 1.0% | PASS |
| file_reads | `index_join_scan` | 3.75ms | 6.17ms | 1.6× | 1.5% | PASS |
| file_reads | `types_table_scan` | 986.58ms | 1.27s | 1.3× | 1.7% | PASS |
| file_reads | `table_scan` | 1.14s | 1.37s | 1.2× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 171.24ms | 172.50ms | 1.0× | 0.5% | PASS |
| file_writes | `oltp_bulk_insert` | 228.91ms | 302.43ms | 1.3× | 0.6% | PASS |
| file_writes | `oltp_insert` | 20.98ms | 32.18ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_update_index` | 76.89ms | 125.37ms | 1.6× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 59.72ms | 81.14ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_delete_insert` | 58.38ms | 93.20ms | 1.6× | 1.2% | PASS |
| file_writes | `oltp_write_only` | 36.24ms | 54.35ms | 1.5× | 1.2% | PASS |
| file_writes | `types_delete_insert` | 37.68ms | 50.89ms | 1.4× | 1.6% | PASS |
| file_writes | `oltp_read_write` | 99.66ms | 140.42ms | 1.4× | 1.1% | PASS |
| ac_reads | `oltp_point_select` | 38.90ms | 46.10ms | 1.2× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 17.15ms | 21.56ms | 1.3× | 1.0% | PASS |
| ac_reads | `oltp_sum_range` | 16.40ms | 20.42ms | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_order_range` | 3.25ms | 3.85ms | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.06ms | 4.84ms | 1.2× | 0.8% | PASS |
| ac_reads | `oltp_index_scan` | 5.16ms | 7.02ms | 1.4× | 1.4% | PASS |
| ac_reads | `select_random_points` | 24.37ms | 30.45ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 7.66ms | 9.46ms | 1.2× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 7.89ms | 10.68ms | 1.4× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 32.80ms | 38.57ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 7.68ms | 11.45ms | 1.5× | 1.1% | PASS |
| ac_reads | `index_join_scan` | 3.54ms | 6.09ms | 1.7× | 0.9% | PASS |
| ac_reads | `types_table_scan` | 962.76ms | 1.27s | 1.3× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.38s | 1.2× | 1.1% | PASS |
| ac_reads | `oltp_read_only` | 142.79ms | 172.49ms | 1.2× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 15.39ms | 44.53ms | 2.9× | 9.2% | PASS |
| ac_writes | `oltp_insert_ac` | 18.11ms | 58.14ms | 3.2× | 6.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 18.37ms | 67.35ms | 3.7× | 5.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 15.31ms | 52.55ms | 3.4× | 6.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 18.72ms | 62.39ms | 3.3× | 5.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 17.33ms | 60.06ms | 3.5× | 6.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 15.54ms | 53.90ms | 3.5× | 6.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 21.84ms | 66.50ms | 3.0× | 4.7% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 36s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.12ms | 38.00ms | 52.9% | 0.8% | PASS |
| `status_dirty_many_tables` | 22.57ms | 42.00ms | 53.7% | 0.7% | PASS |
| `diff_regular_working_one_table` | 17.47ms | 33.00ms | 52.9% | 1.5% | PASS |
| `diff_regular_working_many_tables` | 26.11ms | 50.00ms | 52.2% | 1.1% | PASS |
| `diff_stat_working_many_tables` | 26.11ms | 48.00ms | 54.4% | 1.4% | PASS |
| `diff_schema_working_many_tables` | 26.27ms | 48.00ms | 54.7% | 1.4% | PASS |
| `branch_list_many_branches` | 12.17ms | 25.00ms | 48.7% | 1.2% | PASS |
| `branch_create_delete` | 13.02ms | 27.00ms | 48.2% | 0.8% | PASS |
| `at_literal_deep_history` | 13.12ms | 28.00ms | 46.9% | 0.8% | PASS |
| `diff_literal_deep_history` | 13.09ms | 28.00ms | 46.8% | 0.7% | PASS |
| `history_literal_deep_history` | 13.72ms | 30.00ms | 45.7% | 0.9% | PASS |
| `checkout_branch_clean` | 19.52ms | 43.00ms | 45.4% | 0.8% | PASS |
| `merge_data_no_conflicts` | 14.58ms | 33.00ms | 44.2% | 0.7% | PASS |
| `merge_data_secondary_index` | 580.15ms | 944.00ms | 61.5% | 0.8% | PASS |
| `merge_schema_no_conflicts` | 11.52ms | 24.00ms | 48.0% | 1.0% | PASS |
| `merge_data_conflicts` | 17.13ms | 33.00ms | 51.9% | 0.7% | PASS |
| `merge_data_conflicts_with_resolve` | 17.84ms | 34.00ms | 52.5% | 0.5% | PASS |

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
| copy_fsync | candidate | 47.712 | 45.108–60.662 | 46.911 | 2095.91 | 107968266 |
| push_initial | candidate | 342.154 | 338.991–343.584 | 340.761 | 292.27 | 107956772 |
| clone_initial | candidate | 436.573 | 432.507–460.679 | 433.819 | 229.06 | 108475035 |
| push_noop | candidate | 0.364 | 0.334–0.387 | 0.221 | — | 0 |
| fetch_noop | candidate | 0.094 | 0.091–0.096 | 0.095 | — | 0 |
| push_incremental | candidate | 135.146 | 134.223–136.744 | 133.851 | 7.40 | 7909775 |
| fetch_incremental | candidate | 58.808 | 58.007–60.000 | 57.889 | 17.00 | 7910084 |
| pull_fast_forward | candidate | 52.425 | 52.101–52.926 | 51.250 | 19.07 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.52 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.89 | 294.960 | 109.784 | 47209 | 2337 |
| push_noop | candidate | 46.02 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.02 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.02 | 96.769 | 7.910 | 22388 | 125 |
| fetch_incremental | candidate | 46.02 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.02 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 3233.069 | 3227.360–4145.470 | 560.889 | 309.30 | 1087718031 |
| push_initial | candidate | 6455.900 | 6453.720–7398.774 | 3778.825 | 154.90 | 1079566275 |
| clone_initial | candidate | 5533.510 | 5505.101–5574.690 | 5422.090 | 180.72 | 1102407326 |
| push_noop | candidate | 0.455 | 0.412–0.546 | 0.224 | — | 0 |
| fetch_noop | candidate | 0.100 | 0.098–0.100 | 0.101 | — | 0 |
| push_incremental | candidate | 796.569 | 791.602–801.803 | 792.851 | 1.26 | 15806003 |
| fetch_incremental | candidate | 195.705 | 192.634–200.909 | 194.545 | 5.11 | 15806513 |
| pull_fast_forward | candidate | 197.212 | 193.403–197.870 | 195.729 | 5.07 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 136.12 | 2091.462 | 1087.622 | 263396 | 20541 |
| clone_initial | candidate | 124.03 | 3520.654 | 1132.819 | 613013 | 32243 |
| push_noop | candidate | 47.33 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.33 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.30 | 617.497 | 15.928 | 149981 | 313 |
| fetch_incremental | candidate | 50.42 | 62.160 | 15.928 | 13877 | 313 |
| pull_fast_forward | candidate | 50.46 | 62.093 | 15.929 | 13873 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
