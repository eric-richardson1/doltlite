# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-27 21:07 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261122.9.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/46054549870)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.73s | 10.15s | 1.2× | 1.4% | **PASS** |
| Writes | 1.70s | 2.79s | 1.6× | 1.2% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.38s | 10.28s | 1.1× | 1.0% | **PASS** |
| Writes | 3.74s | 3.95s | 1.1× | 4.4% | **PASS** |
| Autocommit writes | 879.18ms | 2.64s | 3.0× | 9.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.99s | 2.28s | 1.1× | 1.4% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.90s | 3.34s | 1.2× | 1.8% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 1.72s | 2.08s | 1.2× | 2.3% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.12s | 2.45s | 1.2× | 1.0% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 335.02ms | 556.56ms | 1.7× | 1.4% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 603.37ms | 993.10ms | 1.6× | 1.6% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 315.08ms | 520.95ms | 1.7× | 1.2% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 446.17ms | 716.55ms | 1.6× | 0.7% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.21s | 2.33s | 1.1× | 0.9% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 3.01s | 3.38s | 1.1× | 1.2% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 1.80s | 2.08s | 1.2× | 2.6% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.36s | 2.50s | 1.1× | 0.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 902.68ms | 897.72ms | 1.0× | 6.8% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 927.95ms | 1.09s | 1.2× | 3.2% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 894.55ms | 901.57ms | 1.0× | 4.4% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.01s | 1.06s | 1.0× | 3.7% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.09s | 2.34s | 1.1× | 0.9% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.81s | 3.37s | 1.2× | 1.9% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 1.76s | 2.08s | 1.2× | 3.3% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.24s | 2.51s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 199.30ms | 688.86ms | 3.5× | 41.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 204.81ms | 659.68ms | 3.2× | 7.3% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 291.76ms | 770.14ms | 2.6× | 4.6% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 183.32ms | 518.21ms | 2.8× | 15.2% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 18.68ms | 22.40ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 8.44ms | 9.52ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_sum_range` | 7.26ms | 8.89ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 2.11ms | 2.39ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 2.94ms | 3.23ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.03ms | 4.03ms | 1.3× | 1.5% | PASS |
| mem_reads | `select_random_points` | 7.98ms | 9.26ms | 1.2× | 1.2% | PASS |
| mem_reads | `select_random_ranges` | 3.54ms | 3.81ms | 1.1× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 5.84ms | 7.59ms | 1.3× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 24.98ms | 27.41ms | 1.1× | 0.7% | PASS |
| mem_reads | `index_join` | 4.49ms | 6.75ms | 1.5× | 2.9% | PASS |
| mem_reads | `index_join_scan` | 2.60ms | 4.56ms | 1.8× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 851.70ms | 996.18ms | 1.2× | 0.6% | PASS |
| mem_reads | `table_scan` | 962.18ms | 1.08s | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_read_only` | 81.13ms | 93.42ms | 1.2× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.57ms | 218.99ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 11.68ms | 19.36ms | 1.7× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 39.10ms | 72.61ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 28.07ms | 46.76ms | 1.7× | 2.4% | PASS |
| mem_writes | `oltp_delete_insert` | 34.57ms | 56.87ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_write_only` | 17.47ms | 36.07ms | 2.1× | 2.6% | PASS |
| mem_writes | `types_delete_insert` | 19.18ms | 26.22ms | 1.4× | 1.4% | PASS |
| mem_writes | `oltp_read_write` | 50.40ms | 79.69ms | 1.6× | 1.5% | PASS |
| file_reads | `oltp_point_select` | 86.60ms | 38.64ms | 0.4× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 15.95ms | 11.39ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_sum_range` | 14.64ms | 10.75ms | 0.7× | 0.9% | PASS |
| file_reads | `oltp_order_range` | 2.97ms | 2.63ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.75ms | 3.46ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 10.18ms | 6.01ms | 0.6× | 0.9% | PASS |
| file_reads | `select_random_points` | 15.62ms | 11.19ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_ranges` | 10.57ms | 5.60ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.13ms | 9.53ms | 0.7× | 0.8% | PASS |
| file_reads | `groupby_scan` | 25.91ms | 27.74ms | 1.1× | 0.7% | PASS |
| file_reads | `index_join` | 8.40ms | 7.83ms | 0.9× | 1.2% | PASS |
| file_reads | `index_join_scan` | 3.49ms | 4.83ms | 1.4× | 0.9% | PASS |
| file_reads | `types_table_scan` | 859.12ms | 991.04ms | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 964.01ms | 1.08s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 177.31ms | 116.60ms | 0.7× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 188.79ms | 284.28ms | 1.5× | 16.3% | PASS |
| file_writes | `oltp_insert` | 26.92ms | 33.05ms | 1.2× | 6.8% | PASS |
| file_writes | `oltp_update_index` | 141.39ms | 129.46ms | 0.9× | 6.9% | PASS |
| file_writes | `oltp_update_non_index` | 115.30ms | 89.87ms | 0.8× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 121.91ms | 107.12ms | 0.9× | 3.1% | PASS |
| file_writes | `oltp_write_only` | 94.77ms | 75.43ms | 0.8× | 11.1% | PASS |
| file_writes | `types_delete_insert` | 80.83ms | 57.46ms | 0.7× | 5.7% | PASS |
| file_writes | `oltp_read_write` | 132.77ms | 121.05ms | 0.9× | 11.0% | PASS |
| ac_reads | `oltp_point_select` | 39.00ms | 38.76ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 11.24ms | 11.37ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_sum_range` | 10.08ms | 10.77ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_order_range` | 2.56ms | 2.64ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_distinct_range` | 3.30ms | 3.47ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.61ms | 6.05ms | 1.1× | 0.8% | PASS |
| ac_reads | `select_random_points` | 10.95ms | 11.22ms | 1.0× | 1.0% | PASS |
| ac_reads | `select_random_ranges` | 5.97ms | 5.64ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.46ms | 9.62ms | 1.1× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 25.58ms | 27.70ms | 1.1× | 1.1% | PASS |
| ac_reads | `index_join` | 6.09ms | 7.90ms | 1.3× | 1.0% | PASS |
| ac_reads | `index_join_scan` | 3.05ms | 4.83ms | 1.6× | 1.0% | PASS |
| ac_reads | `types_table_scan` | 862.24ms | 992.30ms | 1.2× | 0.7% | PASS |
| ac_reads | `table_scan` | 990.06ms | 1.09s | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_read_only` | 109.51ms | 116.44ms | 1.1× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 26.43ms | 74.33ms | 2.8× | 55.2% | PASS |
| ac_writes | `oltp_insert_ac` | 26.86ms | 101.02ms | 3.8× | 46.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.07ms | 100.52ms | 3.7× | 48.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.89ms | 72.08ms | 3.3× | 52.1% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.55ms | 77.21ms | 3.4× | 23.0% | PASS |
| ac_writes | `oltp_write_only_ac` | 22.70ms | 77.74ms | 3.4× | 28.8% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.41ms | 81.16ms | 3.8× | 33.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.39ms | 104.80ms | 3.4× | 36.0% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 37.15ms | 41.02ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_range_select` | 17.54ms | 16.90ms | 1.0× | 1.4% | PASS |
| mem_reads | `oltp_sum_range` | 16.11ms | 16.29ms | 1.0× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 3.39ms | 3.63ms | 1.1× | 1.4% | PASS |
| mem_reads | `oltp_distinct_range` | 4.38ms | 4.80ms | 1.1× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 4.09ms | 6.91ms | 1.7× | 1.9% | PASS |
| mem_reads | `select_random_points` | 24.21ms | 23.19ms | 1.0× | 2.3% | PASS |
| mem_reads | `select_random_ranges` | 6.97ms | 7.07ms | 1.0× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 8.09ms | 11.26ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 35.32ms | 38.67ms | 1.1× | 0.9% | PASS |
| mem_reads | `index_join` | 10.81ms | 10.67ms | 1.0× | 1.8% | PASS |
| mem_reads | `index_join_scan` | 3.83ms | 6.46ms | 1.7× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 1.22s | 1.45s | 1.2× | 2.2% | PASS |
| mem_reads | `table_scan` | 1.37s | 1.55s | 1.1× | 1.9% | PASS |
| mem_reads | `oltp_read_only` | 145.74ms | 155.37ms | 1.1× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 235.13ms | 360.93ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 17.60ms | 36.90ms | 2.1× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 67.97ms | 141.67ms | 2.1× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 51.44ms | 84.27ms | 1.6× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 57.01ms | 107.58ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_write_only` | 28.84ms | 56.37ms | 2.0× | 1.9% | PASS |
| mem_writes | `types_delete_insert` | 40.94ms | 61.74ms | 1.5× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 104.44ms | 143.63ms | 1.4× | 2.9% | PASS |
| file_reads | `oltp_point_select` | 107.06ms | 59.39ms | 0.6× | 1.0% | PASS |
| file_reads | `oltp_range_select` | 25.50ms | 18.99ms | 0.7× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 23.57ms | 18.18ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 4.38ms | 3.89ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 5.37ms | 5.09ms | 0.9× | 1.5% | PASS |
| file_reads | `oltp_index_scan` | 11.47ms | 8.78ms | 0.8× | 1.0% | PASS |
| file_reads | `select_random_points` | 34.00ms | 26.31ms | 0.8× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 14.56ms | 9.14ms | 0.6× | 1.2% | PASS |
| file_reads | `covering_index_scan` | 15.96ms | 13.34ms | 0.8× | 1.3% | PASS |
| file_reads | `groupby_scan` | 36.58ms | 39.08ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 15.59ms | 12.09ms | 0.8× | 2.5% | PASS |
| file_reads | `index_join_scan` | 4.89ms | 6.88ms | 1.4× | 1.2% | PASS |
| file_reads | `types_table_scan` | 1.10s | 1.42s | 1.3× | 1.7% | PASS |
| file_reads | `table_scan` | 1.36s | 1.55s | 1.1× | 3.1% | PASS |
| file_reads | `oltp_read_only` | 258.12ms | 188.20ms | 0.7× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 260.00ms | 379.00ms | 1.5× | 1.1% | PASS |
| file_writes | `oltp_insert` | 25.86ms | 43.04ms | 1.7× | 1.5% | PASS |
| file_writes | `oltp_update_index` | 129.56ms | 158.73ms | 1.2× | 12.6% | PASS |
| file_writes | `oltp_update_non_index` | 106.68ms | 96.54ms | 0.9× | 11.9% | PASS |
| file_writes | `oltp_delete_insert` | 96.42ms | 120.32ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 87.96ms | 68.04ms | 0.8× | 13.8% | PASS |
| file_writes | `types_delete_insert` | 72.35ms | 69.69ms | 1.0× | 1.3% | PASS |
| file_writes | `oltp_read_write` | 149.12ms | 155.55ms | 1.0× | 4.6% | PASS |
| ac_reads | `oltp_point_select` | 59.55ms | 59.30ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 20.17ms | 18.90ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_sum_range` | 18.34ms | 18.08ms | 1.0× | 2.5% | PASS |
| ac_reads | `oltp_order_range` | 3.79ms | 3.87ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_distinct_range` | 4.75ms | 5.09ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 6.51ms | 8.71ms | 1.3× | 1.6% | PASS |
| ac_reads | `select_random_points` | 25.55ms | 25.33ms | 1.0× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 9.24ms | 9.07ms | 1.0× | 1.9% | PASS |
| ac_reads | `covering_index_scan` | 10.70ms | 13.26ms | 1.2× | 1.5% | PASS |
| ac_reads | `groupby_scan` | 35.51ms | 38.82ms | 1.1× | 0.6% | PASS |
| ac_reads | `index_join` | 12.52ms | 11.94ms | 1.0× | 2.5% | PASS |
| ac_reads | `index_join_scan` | 4.25ms | 6.89ms | 1.6× | 1.9% | PASS |
| ac_reads | `types_table_scan` | 1.17s | 1.44s | 1.2× | 3.6% | PASS |
| ac_reads | `table_scan` | 1.26s | 1.53s | 1.2× | 2.6% | PASS |
| ac_reads | `oltp_read_only` | 174.13ms | 184.18ms | 1.1× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.27ms | 66.25ms | 3.0× | 6.4% | PASS |
| ac_writes | `oltp_insert_ac` | 25.98ms | 77.80ms | 3.0× | 4.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 27.69ms | 98.83ms | 3.6× | 6.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.67ms | 73.34ms | 3.2× | 9.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 25.11ms | 85.80ms | 3.4× | 7.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.84ms | 83.11ms | 3.3× | 7.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.39ms | 80.79ms | 3.5× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 32.86ms | 93.75ms | 2.9× | 7.7% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 19.50ms | 21.18ms | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_range_select` | 9.40ms | 10.09ms | 1.1× | 8.9% | PASS |
| mem_reads | `oltp_sum_range` | 7.86ms | 9.22ms | 1.2× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 1.92ms | 2.17ms | 1.1× | 2.9% | PASS |
| mem_reads | `oltp_distinct_range` | 2.44ms | 2.80ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 2.19ms | 3.53ms | 1.6× | 2.2% | PASS |
| mem_reads | `select_random_points` | 13.62ms | 13.80ms | 1.0× | 3.7% | PASS |
| mem_reads | `select_random_ranges` | 3.43ms | 3.77ms | 1.1× | 3.3% | PASS |
| mem_reads | `covering_index_scan` | 4.33ms | 6.16ms | 1.4× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 21.69ms | 23.98ms | 1.1× | 0.6% | PASS |
| mem_reads | `index_join` | 7.09ms | 7.09ms | 1.0× | 11.0% | PASS |
| mem_reads | `index_join_scan` | 2.08ms | 4.04ms | 1.9× | 3.0% | PASS |
| mem_reads | `types_table_scan` | 726.83ms | 899.09ms | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 821.26ms | 982.43ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_read_only` | 80.13ms | 88.26ms | 1.1× | 1.5% | PASS |
| mem_writes | `oltp_bulk_insert` | 124.25ms | 185.50ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 10.29ms | 20.43ms | 2.0× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 36.92ms | 76.81ms | 2.1× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 25.44ms | 43.58ms | 1.7× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 30.14ms | 57.08ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 14.79ms | 30.21ms | 2.0× | 3.6% | PASS |
| mem_writes | `types_delete_insert` | 21.00ms | 31.45ms | 1.5× | 3.3% | PASS |
| mem_writes | `oltp_read_write` | 52.26ms | 75.89ms | 1.5× | 1.3% | PASS |
| file_reads | `oltp_point_select` | 41.54ms | 26.73ms | 0.6× | 2.2% | PASS |
| file_reads | `oltp_range_select` | 10.58ms | 10.71ms | 1.0× | 4.0% | PASS |
| file_reads | `oltp_sum_range` | 10.18ms | 10.13ms | 1.0× | 2.6% | PASS |
| file_reads | `oltp_order_range` | 2.15ms | 2.26ms | 1.1× | 3.7% | PASS |
| file_reads | `oltp_distinct_range` | 2.83ms | 2.96ms | 1.0× | 3.3% | PASS |
| file_reads | `oltp_index_scan` | 4.56ms | 4.33ms | 1.0× | 2.5% | PASS |
| file_reads | `select_random_points` | 16.48ms | 15.48ms | 0.9× | 4.5% | PASS |
| file_reads | `select_random_ranges` | 5.75ms | 4.37ms | 0.8× | 3.6% | PASS |
| file_reads | `covering_index_scan` | 6.44ms | 6.65ms | 1.0× | 0.6% | PASS |
| file_reads | `groupby_scan` | 21.89ms | 24.10ms | 1.1× | 0.5% | PASS |
| file_reads | `index_join` | 8.19ms | 7.07ms | 0.9× | 4.7% | PASS |
| file_reads | `index_join_scan` | 2.41ms | 4.41ms | 1.8× | 3.7% | PASS |
| file_reads | `types_table_scan` | 729.11ms | 890.80ms | 1.2× | 0.3% | PASS |
| file_reads | `table_scan` | 832.10ms | 975.83ms | 1.2× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 107.04ms | 94.94ms | 0.9× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 185.52ms | 240.82ms | 1.3× | 4.4% | PASS |
| file_writes | `oltp_insert` | 19.47ms | 37.84ms | 1.9× | 2.5% | PASS |
| file_writes | `oltp_update_index` | 131.00ms | 157.25ms | 1.2× | 3.7% | PASS |
| file_writes | `oltp_update_non_index` | 110.44ms | 99.27ms | 0.9× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 134.80ms | 113.57ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_write_only` | 90.21ms | 73.32ms | 0.8× | 5.6% | PASS |
| file_writes | `types_delete_insert` | 95.05ms | 59.79ms | 0.6× | 4.6% | PASS |
| file_writes | `oltp_read_write` | 128.07ms | 119.72ms | 0.9× | 4.6% | PASS |
| ac_reads | `oltp_point_select` | 27.20ms | 26.59ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_range_select` | 9.57ms | 10.63ms | 1.1× | 5.3% | PASS |
| ac_reads | `oltp_sum_range` | 8.94ms | 10.15ms | 1.1× | 4.7% | PASS |
| ac_reads | `oltp_order_range` | 2.01ms | 2.28ms | 1.1× | 4.1% | PASS |
| ac_reads | `oltp_distinct_range` | 2.62ms | 2.94ms | 1.1× | 3.3% | PASS |
| ac_reads | `oltp_index_scan` | 3.02ms | 4.34ms | 1.4× | 4.1% | PASS |
| ac_reads | `select_random_points` | 15.01ms | 15.40ms | 1.0× | 6.2% | PASS |
| ac_reads | `select_random_ranges` | 4.31ms | 4.41ms | 1.0× | 5.7% | PASS |
| ac_reads | `covering_index_scan` | 5.02ms | 6.68ms | 1.3× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 21.76ms | 24.13ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.37ms | 7.15ms | 1.0× | 3.6% | PASS |
| ac_reads | `index_join_scan` | 2.20ms | 4.50ms | 2.0× | 3.1% | PASS |
| ac_reads | `types_table_scan` | 727.96ms | 891.09ms | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 832.49ms | 974.54ms | 1.2× | 0.4% | PASS |
| ac_reads | `oltp_read_only` | 89.58ms | 95.01ms | 1.1× | 2.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 34.89ms | 86.28ms | 2.5× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 39.13ms | 99.09ms | 2.5× | 4.9% | PASS |
| ac_writes | `oltp_update_index_ac` | 37.91ms | 105.87ms | 2.8× | 5.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 35.31ms | 94.37ms | 2.7× | 6.2% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 36.09ms | 95.30ms | 2.6× | 4.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 35.64ms | 96.65ms | 2.7× | 2.6% | PASS |
| ac_writes | `types_delete_insert_ac` | 35.10ms | 92.59ms | 2.6× | 7.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 37.68ms | 99.99ms | 2.7× | 4.2% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.39ms | 30.27ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 15.13ms | 17.08ms | 1.1× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 13.45ms | 16.36ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_order_range` | 2.89ms | 3.17ms | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 3.68ms | 3.98ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.55ms | 4.93ms | 1.4× | 1.6% | PASS |
| mem_reads | `select_random_points` | 19.61ms | 23.83ms | 1.2× | 0.8% | PASS |
| mem_reads | `select_random_ranges` | 5.70ms | 6.70ms | 1.2× | 0.8% | PASS |
| mem_reads | `covering_index_scan` | 5.88ms | 7.72ms | 1.3× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 29.45ms | 32.73ms | 1.1× | 0.5% | PASS |
| mem_reads | `index_join` | 6.16ms | 8.53ms | 1.4× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 3.24ms | 5.25ms | 1.6× | 2.6% | PASS |
| mem_reads | `types_table_scan` | 876.20ms | 1.03s | 1.2× | 0.7% | PASS |
| mem_reads | `table_scan` | 994.19ms | 1.12s | 1.1× | 0.6% | PASS |
| mem_reads | `oltp_read_only` | 113.11ms | 132.37ms | 1.2× | 0.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 183.40ms | 260.03ms | 1.4× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 14.49ms | 25.28ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 51.36ms | 95.76ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_update_non_index` | 39.19ms | 65.36ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_delete_insert` | 38.10ms | 71.33ms | 1.9× | 0.5% | PASS |
| mem_writes | `oltp_write_only` | 21.07ms | 43.55ms | 2.1× | 0.6% | PASS |
| mem_writes | `types_delete_insert` | 24.61ms | 39.94ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 73.95ms | 115.29ms | 1.6× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 93.86ms | 46.88ms | 0.5× | 0.5% | PASS |
| file_reads | `oltp_range_select` | 22.98ms | 19.03ms | 0.8× | 1.0% | PASS |
| file_reads | `oltp_sum_range` | 20.75ms | 18.23ms | 0.9× | 0.6% | PASS |
| file_reads | `oltp_order_range` | 3.72ms | 3.42ms | 0.9× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 4.56ms | 4.25ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 10.77ms | 6.93ms | 0.6× | 0.8% | PASS |
| file_reads | `select_random_points` | 27.57ms | 26.01ms | 0.9× | 0.9% | PASS |
| file_reads | `select_random_ranges` | 12.91ms | 8.66ms | 0.7× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 13.22ms | 9.86ms | 0.7× | 0.8% | PASS |
| file_reads | `groupby_scan` | 30.65ms | 33.24ms | 1.1× | 1.0% | PASS |
| file_reads | `index_join` | 10.23ms | 10.21ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join_scan` | 4.05ms | 5.50ms | 1.4× | 1.3% | PASS |
| file_reads | `types_table_scan` | 875.66ms | 1.03s | 1.2× | 0.3% | PASS |
| file_reads | `table_scan` | 1.02s | 1.12s | 1.1× | 1.4% | PASS |
| file_reads | `oltp_read_only` | 214.58ms | 157.03ms | 0.7× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 233.82ms | 309.56ms | 1.3× | 3.5% | PASS |
| file_writes | `oltp_insert` | 28.54ms | 30.28ms | 1.1× | 3.1% | PASS |
| file_writes | `oltp_update_index` | 155.31ms | 158.00ms | 1.0× | 3.6% | PASS |
| file_writes | `oltp_update_non_index` | 133.98ms | 108.67ms | 0.8× | 3.9% | PASS |
| file_writes | `oltp_delete_insert` | 134.84ms | 128.20ms | 1.0× | 5.2% | PASS |
| file_writes | `oltp_write_only` | 96.64ms | 87.47ms | 0.9× | 1.6% | PASS |
| file_writes | `types_delete_insert` | 80.73ms | 72.79ms | 0.9× | 9.4% | PASS |
| file_writes | `oltp_read_write` | 150.55ms | 161.71ms | 1.1× | 4.0% | PASS |
| ac_reads | `oltp_point_select` | 46.97ms | 46.95ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 18.30ms | 18.95ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_sum_range` | 16.16ms | 18.34ms | 1.1× | 0.7% | PASS |
| ac_reads | `oltp_order_range` | 3.32ms | 3.43ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 4.10ms | 4.24ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 6.19ms | 7.00ms | 1.1× | 0.9% | PASS |
| ac_reads | `select_random_points` | 23.53ms | 26.93ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 8.26ms | 8.74ms | 1.1× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 8.59ms | 9.91ms | 1.2× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 30.46ms | 33.45ms | 1.1× | 0.7% | PASS |
| ac_reads | `index_join` | 7.94ms | 10.49ms | 1.3× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.68ms | 5.78ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 895.70ms | 1.04s | 1.2× | 1.6% | PASS |
| ac_reads | `table_scan` | 1.02s | 1.12s | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 144.87ms | 156.62ms | 1.1× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 19.32ms | 51.20ms | 2.6× | 8.8% | PASS |
| ac_writes | `oltp_insert_ac` | 23.28ms | 63.31ms | 2.7× | 9.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.19ms | 75.69ms | 3.0× | 13.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.75ms | 60.17ms | 3.0× | 19.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.23ms | 65.92ms | 3.0× | 14.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.12ms | 63.62ms | 2.8× | 15.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 23.42ms | 62.38ms | 2.7× | 26.7% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.99ms | 75.93ms | 2.8× | 15.7% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 32s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 25.75ms | 38.00ms | 67.8% | 1.7% | PASS |
| `status_dirty_many_tables` | 28.02ms | 42.00ms | 66.7% | 1.2% | PASS |
| `diff_regular_working_one_table` | 21.68ms | 33.00ms | 65.7% | 1.4% | PASS |
| `diff_regular_working_many_tables` | 31.80ms | 50.00ms | 63.6% | 1.5% | PASS |
| `diff_stat_working_many_tables` | 32.02ms | 48.00ms | 66.7% | 0.9% | PASS |
| `diff_schema_working_many_tables` | 32.55ms | 48.00ms | 67.8% | 1.4% | PASS |
| `branch_list_many_branches` | 16.76ms | 25.00ms | 67.0% | 2.3% | PASS |
| `branch_create_delete` | 18.43ms | 27.00ms | 68.2% | 3.0% | PASS |
| `at_literal_deep_history` | 18.89ms | 28.00ms | 67.5% | 2.2% | PASS |
| `diff_literal_deep_history` | 19.09ms | 28.00ms | 68.2% | 1.9% | PASS |
| `history_literal_deep_history` | 20.19ms | 30.00ms | 67.3% | 1.9% | PASS |
| `checkout_branch_clean` | 26.11ms | 43.00ms | 60.7% | 2.8% | PASS |
| `merge_data_no_conflicts` | 20.99ms | 33.00ms | 63.6% | 4.3% | PASS |
| `merge_data_secondary_index` | 778.30ms | 944.00ms | 82.4% | 1.3% | PASS |
| `merge_schema_no_conflicts` | 16.54ms | 24.00ms | 68.9% | 2.6% | PASS |
| `merge_data_conflicts` | 23.44ms | 33.00ms | 71.0% | 1.1% | PASS |
| `merge_data_conflicts_with_resolve` | 23.82ms | 34.00ms | 70.1% | 1.2% | PASS |

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
| copy_fsync | candidate | 407.345 | 398.742–525.080 | 31.934 | 245.49 | 107968266 |
| push_initial | candidate | 773.537 | 765.484–777.457 | 402.517 | 129.28 | 107956772 |
| clone_initial | candidate | 886.751 | 875.391–914.259 | 524.123 | 112.77 | 108475035 |
| push_noop | candidate | 0.634 | 0.584–27.766 | 0.325 | — | 0 |
| fetch_noop | candidate | 0.181 | 0.177–0.189 | 0.184 | — | 0 |
| push_incremental | candidate | 198.818 | 187.309–205.719 | 166.014 | 5.03 | 7909775 |
| fetch_incremental | candidate | 92.951 | 88.050–93.615 | 71.935 | 10.76 | 7910084 |
| pull_fast_forward | candidate | 81.195 | 79.304–262.780 | 64.721 | 12.32 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.56 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.75 | 295.134 | 109.784 | 47251 | 2337 |
| push_noop | candidate | 45.95 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 45.95 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.95 | 96.873 | 7.910 | 22412 | 125 |
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
| copy_fsync | candidate | 2657.666 | 2640.838–2677.965 | 390.801 | 376.27 | 1087718031 |
| push_initial | candidate | 8184.535 | 8036.446–8188.456 | 6002.829 | 122.18 | 1079566275 |
| clone_initial | candidate | 9005.026 | 8996.353–9040.086 | 8677.307 | 111.05 | 1102407326 |
| push_noop | candidate | 0.809 | 0.745–0.817 | 0.384 | — | 0 |
| fetch_noop | candidate | 0.196 | 0.195–0.203 | 0.198 | — | 0 |
| push_incremental | candidate | 1289.406 | 1283.975–1298.992 | 1282.845 | 0.78 | 15806003 |
| fetch_incremental | candidate | 269.726 | 268.395–273.751 | 263.983 | 3.71 | 15806513 |
| pull_fast_forward | candidate | 273.359 | 272.730–276.452 | 266.802 | 3.66 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.73 | 2091.844 | 1087.622 | 263490 | 20541 |
| clone_initial | candidate | 124.01 | 3523.400 | 1132.819 | 613696 | 32243 |
| push_noop | candidate | 47.21 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.21 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 47.21 | 618.701 | 15.928 | 150281 | 313 |
| fetch_incremental | candidate | 50.34 | 62.385 | 15.928 | 13932 | 313 |
| pull_fast_forward | candidate | 50.46 | 62.318 | 15.929 | 13928 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
