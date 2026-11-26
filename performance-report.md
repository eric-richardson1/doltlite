# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-26 21:12 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261116.202.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/45882151764)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.03s | 11.40s | 1.1× | 1.3% | **PASS** |
| Writes | 1.92s | 3.16s | 1.6× | 1.4% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.61s | 11.32s | 1.1× | 1.3% | **PASS** |
| Writes | 3.61s | 4.09s | 1.1× | 2.2% | **PASS** |
| Autocommit writes | 727.68ms | 2.27s | 3.1× | 6.4% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.57s | 2.92s | 1.1× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.21s | 2.46s | 1.1× | 1.4% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.92s | 3.20s | 1.1× | 1.7% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.32s | 2.81s | 1.2× | 1.2% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 429.75ms | 773.20ms | 1.8× | 1.5% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 460.20ms | 720.84ms | 1.6× | 1.6% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 589.16ms | 949.66ms | 1.6× | 1.6% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 436.41ms | 711.38ms | 1.6× | 1.2% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.84s | 2.98s | 1.0× | 1.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.45s | 2.51s | 1.0× | 1.1% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 3.04s | 3.20s | 1.0× | 1.6% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.28s | 2.64s | 1.2× | 1.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 590.11ms | 830.89ms | 1.4× | 1.8% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.28s | 1.19s | 0.9× | 3.4% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 809.86ms | 1.04s | 1.3× | 1.5% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 928.21ms | 1.03s | 1.1× | 3.3% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.75s | 3.01s | 1.1× | 1.3% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.30s | 2.52s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.93s | 3.24s | 1.1× | 1.5% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.23s | 2.64s | 1.2× | 1.9% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 194.96ms | 630.42ms | 3.2× | 7.2% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 159.19ms | 519.60ms | 3.3× | 9.3% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 147.14ms | 527.47ms | 3.6× | 4.4% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 226.39ms | 596.90ms | 2.6× | 3.2% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.54ms | 31.63ms | 1.3× | 1.1% | PASS |
| mem_reads | `oltp_range_select` | 11.02ms | 12.95ms | 1.2× | 1.8% | PASS |
| mem_reads | `oltp_sum_range` | 9.71ms | 12.31ms | 1.3× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 2.68ms | 3.16ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.65ms | 4.39ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 3.90ms | 5.78ms | 1.5× | 1.9% | PASS |
| mem_reads | `select_random_points` | 10.15ms | 12.12ms | 1.2× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 4.64ms | 5.45ms | 1.2× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 7.89ms | 10.85ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 30.69ms | 36.25ms | 1.2× | 0.9% | PASS |
| mem_reads | `index_join` | 5.72ms | 9.09ms | 1.6× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.18ms | 5.77ms | 1.8× | 0.8% | PASS |
| mem_reads | `types_table_scan` | 1.10s | 1.28s | 1.2× | 1.6% | PASS |
| mem_reads | `table_scan` | 1.25s | 1.36s | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_read_only` | 108.00ms | 132.37ms | 1.2× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 169.77ms | 296.55ms | 1.7× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.87ms | 27.02ms | 1.8× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 50.24ms | 102.34ms | 2.0× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 34.71ms | 64.92ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 44.47ms | 80.29ms | 1.8× | 1.9% | PASS |
| mem_writes | `oltp_write_only` | 21.73ms | 49.23ms | 2.3× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 23.96ms | 38.18ms | 1.6× | 1.8% | PASS |
| mem_writes | `oltp_read_write` | 70.01ms | 114.67ms | 1.6× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 92.54ms | 49.14ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 18.38ms | 14.80ms | 0.8× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 17.20ms | 14.19ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.54ms | 3.41ms | 1.0× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 4.52ms | 4.66ms | 1.0× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 11.21ms | 7.68ms | 0.7× | 1.6% | PASS |
| file_reads | `select_random_points` | 17.99ms | 14.23ms | 0.8× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 11.87ms | 7.31ms | 0.6× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 15.70ms | 12.94ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 31.91ms | 36.80ms | 1.2× | 0.9% | PASS |
| file_reads | `index_join` | 9.98ms | 10.55ms | 1.1× | 1.6% | PASS |
| file_reads | `index_join_scan` | 4.21ms | 6.33ms | 1.5× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.12s | 1.28s | 1.1× | 1.1% | PASS |
| file_reads | `table_scan` | 1.27s | 1.36s | 1.1× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 209.58ms | 159.27ms | 0.8× | 0.8% | PASS |
| file_writes | `oltp_bulk_insert` | 183.26ms | 308.59ms | 1.7× | 1.0% | PASS |
| file_writes | `oltp_insert` | 22.32ms | 30.35ms | 1.4× | 2.0% | PASS |
| file_writes | `oltp_update_index` | 78.99ms | 111.60ms | 1.4× | 2.0% | PASS |
| file_writes | `oltp_update_non_index` | 58.64ms | 71.71ms | 1.2× | 1.4% | PASS |
| file_writes | `oltp_delete_insert` | 68.31ms | 90.33ms | 1.3× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 45.24ms | 54.56ms | 1.2× | 2.2% | PASS |
| file_writes | `types_delete_insert` | 40.18ms | 44.63ms | 1.1× | 2.2% | PASS |
| file_writes | `oltp_read_write` | 93.17ms | 119.12ms | 1.3× | 1.5% | PASS |
| ac_reads | `oltp_point_select` | 45.44ms | 49.15ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 13.60ms | 14.74ms | 1.1× | 1.7% | PASS |
| ac_reads | `oltp_sum_range` | 12.52ms | 14.22ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.15ms | 3.45ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 4.13ms | 4.68ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_index_scan` | 6.57ms | 7.67ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 13.04ms | 14.24ms | 1.1× | 2.1% | PASS |
| ac_reads | `select_random_ranges` | 7.08ms | 7.29ms | 1.0× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 10.82ms | 12.93ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 31.28ms | 36.88ms | 1.2× | 0.9% | PASS |
| ac_reads | `index_join` | 7.53ms | 10.51ms | 1.4× | 1.7% | PASS |
| ac_reads | `index_join_scan` | 3.74ms | 6.30ms | 1.7× | 3.1% | PASS |
| ac_reads | `types_table_scan` | 1.14s | 1.29s | 1.1× | 0.6% | PASS |
| ac_reads | `table_scan` | 1.30s | 1.38s | 1.1× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 143.34ms | 160.88ms | 1.1× | 0.9% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.19ms | 65.92ms | 3.0× | 7.2% | PASS |
| ac_writes | `oltp_insert_ac` | 24.98ms | 78.07ms | 3.1× | 7.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.69ms | 90.76ms | 3.5× | 7.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 22.45ms | 71.89ms | 3.2× | 7.0% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.71ms | 80.25ms | 3.4× | 8.7% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.25ms | 79.91ms | 3.3× | 7.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.63ms | 74.12ms | 3.4× | 7.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.05ms | 89.50ms | 3.0× | 7.8% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.80ms | 28.93ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_range_select` | 14.19ms | 13.78ms | 1.0× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 12.63ms | 11.95ms | 0.9× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 2.80ms | 2.97ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.54ms | 3.84ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.16ms | 5.12ms | 1.6× | 1.3% | PASS |
| mem_reads | `select_random_points` | 17.69ms | 16.99ms | 1.0× | 2.2% | PASS |
| mem_reads | `select_random_ranges` | 5.39ms | 5.05ms | 0.9× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 5.89ms | 8.10ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 28.96ms | 29.78ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 8.98ms | 8.24ms | 0.9× | 2.1% | PASS |
| mem_reads | `index_join_scan` | 3.12ms | 5.44ms | 1.7× | 1.4% | PASS |
| mem_reads | `types_table_scan` | 911.11ms | 1.06s | 1.2× | 1.2% | PASS |
| mem_reads | `table_scan` | 1.05s | 1.15s | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 111.11ms | 116.47ms | 1.0× | 2.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.76ms | 261.99ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 13.73ms | 26.89ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 53.25ms | 106.57ms | 2.0× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 39.33ms | 60.22ms | 1.5× | 1.7% | PASS |
| mem_writes | `oltp_delete_insert` | 43.95ms | 78.42ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_write_only` | 23.05ms | 40.54ms | 1.8× | 1.1% | PASS |
| mem_writes | `types_delete_insert` | 31.21ms | 44.17ms | 1.4× | 1.7% | PASS |
| mem_writes | `oltp_read_write` | 76.92ms | 102.04ms | 1.3× | 2.1% | PASS |
| file_reads | `oltp_point_select` | 97.13ms | 45.80ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 21.65ms | 15.68ms | 0.7× | 0.9% | PASS |
| file_reads | `oltp_sum_range` | 20.16ms | 13.81ms | 0.7× | 1.4% | PASS |
| file_reads | `oltp_order_range` | 3.65ms | 3.20ms | 0.9× | 1.1% | PASS |
| file_reads | `oltp_distinct_range` | 4.43ms | 4.07ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 10.31ms | 6.92ms | 0.7× | 0.8% | PASS |
| file_reads | `select_random_points` | 25.27ms | 19.05ms | 0.8× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 12.53ms | 6.83ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 13.20ms | 9.84ms | 0.7× | 0.6% | PASS |
| file_reads | `groupby_scan` | 29.96ms | 30.01ms | 1.0× | 1.1% | PASS |
| file_reads | `index_join` | 13.16ms | 9.30ms | 0.7× | 1.0% | PASS |
| file_reads | `index_join_scan` | 4.02ms | 5.71ms | 1.4× | 1.1% | PASS |
| file_reads | `types_table_scan` | 915.27ms | 1.05s | 1.2× | 1.2% | PASS |
| file_reads | `table_scan` | 1.06s | 1.15s | 1.1× | 1.8% | PASS |
| file_reads | `oltp_read_only` | 211.79ms | 141.63ms | 0.7× | 1.1% | PASS |
| file_writes | `oltp_bulk_insert` | 264.73ms | 339.59ms | 1.3× | 5.0% | PASS |
| file_writes | `oltp_insert` | 33.77ms | 48.62ms | 1.4× | 6.8% | PASS |
| file_writes | `oltp_update_index` | 179.50ms | 190.72ms | 1.1× | 3.2% | PASS |
| file_writes | `oltp_update_non_index` | 155.05ms | 121.77ms | 0.8× | 2.7% | PASS |
| file_writes | `oltp_delete_insert` | 189.84ms | 147.83ms | 0.8× | 2.4% | PASS |
| file_writes | `oltp_write_only` | 127.14ms | 96.08ms | 0.8× | 3.7% | PASS |
| file_writes | `types_delete_insert` | 149.84ms | 87.41ms | 0.6× | 6.9% | PASS |
| file_writes | `oltp_read_write` | 181.25ms | 157.66ms | 0.9× | 2.6% | PASS |
| ac_reads | `oltp_point_select` | 49.14ms | 45.87ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_range_select` | 16.83ms | 15.68ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_sum_range` | 15.39ms | 13.73ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 3.23ms | 3.20ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_distinct_range` | 3.95ms | 4.04ms | 1.0× | 0.7% | PASS |
| ac_reads | `oltp_index_scan` | 5.71ms | 6.91ms | 1.2× | 0.8% | PASS |
| ac_reads | `select_random_points` | 20.69ms | 19.00ms | 0.9× | 1.6% | PASS |
| ac_reads | `select_random_ranges` | 7.90ms | 6.82ms | 0.9× | 0.7% | PASS |
| ac_reads | `covering_index_scan` | 8.53ms | 9.83ms | 1.2× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 29.43ms | 29.97ms | 1.0× | 0.8% | PASS |
| ac_reads | `index_join` | 10.91ms | 9.31ms | 0.9× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 3.58ms | 5.69ms | 1.6× | 1.1% | PASS |
| ac_reads | `types_table_scan` | 916.64ms | 1.05s | 1.1× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.07s | 1.15s | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_read_only` | 143.10ms | 141.70ms | 1.0× | 1.2% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.32ms | 50.67ms | 2.8× | 9.3% | PASS |
| ac_writes | `oltp_insert_ac` | 20.11ms | 64.05ms | 3.2× | 9.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.33ms | 78.57ms | 3.9× | 10.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.86ms | 58.67ms | 3.5× | 8.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.35ms | 69.09ms | 3.4× | 10.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.21ms | 67.70ms | 3.3× | 10.0% | PASS |
| ac_writes | `types_delete_insert_ac` | 18.00ms | 57.97ms | 3.2× | 5.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.01ms | 72.88ms | 2.9× | 8.0% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.54ms | 36.66ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 17.72ms | 15.65ms | 0.9× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 15.73ms | 14.71ms | 0.9× | 2.5% | PASS |
| mem_reads | `oltp_order_range` | 3.46ms | 3.47ms | 1.0× | 1.0% | PASS |
| mem_reads | `oltp_distinct_range` | 4.42ms | 4.52ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.91ms | 6.19ms | 1.6× | 0.9% | PASS |
| mem_reads | `select_random_points` | 21.27ms | 20.55ms | 1.0× | 1.9% | PASS |
| mem_reads | `select_random_ranges` | 6.46ms | 6.25ms | 1.0× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 7.64ms | 10.36ms | 1.4× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 36.87ms | 38.04ms | 1.0× | 0.7% | PASS |
| mem_reads | `index_join` | 11.12ms | 10.57ms | 1.0× | 2.7% | PASS |
| mem_reads | `index_join_scan` | 3.99ms | 6.61ms | 1.7× | 2.1% | PASS |
| mem_reads | `types_table_scan` | 1.22s | 1.39s | 1.1× | 2.5% | PASS |
| mem_reads | `table_scan` | 1.39s | 1.49s | 1.1× | 1.0% | PASS |
| mem_reads | `oltp_read_only` | 143.54ms | 142.56ms | 1.0× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 234.10ms | 343.31ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 18.34ms | 37.41ms | 2.0× | 0.8% | PASS |
| mem_writes | `oltp_update_index` | 65.31ms | 136.18ms | 2.1× | 1.6% | PASS |
| mem_writes | `oltp_update_non_index` | 48.05ms | 78.34ms | 1.6× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 54.29ms | 104.59ms | 1.9× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 29.19ms | 57.51ms | 2.0× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 38.54ms | 57.66ms | 1.5× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 101.34ms | 134.66ms | 1.3× | 2.2% | PASS |
| file_reads | `oltp_point_select` | 125.37ms | 58.46ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 26.54ms | 17.97ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_sum_range` | 24.53ms | 17.02ms | 0.7× | 1.7% | PASS |
| file_reads | `oltp_order_range` | 4.34ms | 3.76ms | 0.9× | 2.3% | PASS |
| file_reads | `oltp_distinct_range` | 5.44ms | 4.79ms | 0.9× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 13.05ms | 8.57ms | 0.7× | 1.3% | PASS |
| file_reads | `select_random_points` | 33.20ms | 24.10ms | 0.7× | 3.0% | PASS |
| file_reads | `select_random_ranges` | 15.41ms | 8.52ms | 0.6× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 16.74ms | 12.65ms | 0.8× | 1.2% | PASS |
| file_reads | `groupby_scan` | 37.19ms | 38.16ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 15.10ms | 11.75ms | 0.8× | 2.0% | PASS |
| file_reads | `index_join_scan` | 4.87ms | 6.81ms | 1.4× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.18s | 1.36s | 1.2× | 2.1% | PASS |
| file_reads | `table_scan` | 1.28s | 1.45s | 1.1× | 1.3% | PASS |
| file_reads | `oltp_read_only` | 270.05ms | 172.50ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 257.15ms | 357.80ms | 1.4× | 0.8% | PASS |
| file_writes | `oltp_insert` | 24.79ms | 41.81ms | 1.7× | 0.9% | PASS |
| file_writes | `oltp_update_index` | 100.84ms | 156.63ms | 1.6× | 2.0% | PASS |
| file_writes | `oltp_update_non_index` | 92.31ms | 92.25ms | 1.0× | 9.6% | PASS |
| file_writes | `oltp_delete_insert` | 89.81ms | 117.92ms | 1.3× | 1.6% | PASS |
| file_writes | `oltp_write_only` | 56.72ms | 67.89ms | 1.2× | 1.5% | PASS |
| file_writes | `types_delete_insert` | 64.42ms | 67.40ms | 1.0× | 1.4% | PASS |
| file_writes | `oltp_read_write` | 123.81ms | 141.70ms | 1.1× | 1.3% | PASS |
| ac_reads | `oltp_point_select` | 61.16ms | 57.31ms | 0.9× | 0.5% | PASS |
| ac_reads | `oltp_range_select` | 20.50ms | 17.72ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_sum_range` | 18.44ms | 16.95ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 3.81ms | 3.75ms | 1.0× | 1.5% | PASS |
| ac_reads | `oltp_distinct_range` | 4.82ms | 4.79ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 7.00ms | 8.49ms | 1.2× | 1.1% | PASS |
| ac_reads | `select_random_points` | 25.02ms | 23.36ms | 0.9× | 2.6% | PASS |
| ac_reads | `select_random_ranges` | 9.71ms | 8.66ms | 0.9× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 11.00ms | 12.80ms | 1.2× | 1.1% | PASS |
| ac_reads | `groupby_scan` | 37.63ms | 38.32ms | 1.0× | 0.8% | PASS |
| ac_reads | `index_join` | 13.05ms | 11.89ms | 0.9× | 3.1% | PASS |
| ac_reads | `index_join_scan` | 4.38ms | 6.81ms | 1.6× | 1.7% | PASS |
| ac_reads | `types_table_scan` | 1.18s | 1.37s | 1.2× | 2.6% | PASS |
| ac_reads | `table_scan` | 1.35s | 1.48s | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_read_only` | 183.23ms | 174.71ms | 1.0× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 16.40ms | 49.93ms | 3.0× | 4.3% | PASS |
| ac_writes | `oltp_insert_ac` | 18.24ms | 67.75ms | 3.7× | 5.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 18.92ms | 78.48ms | 4.1× | 3.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 16.22ms | 59.48ms | 3.7× | 5.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 18.89ms | 68.65ms | 3.6× | 4.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 17.86ms | 68.73ms | 3.8× | 4.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 16.12ms | 59.28ms | 3.7× | 3.6% | PASS |
| ac_writes | `oltp_read_write_ac` | 24.49ms | 75.18ms | 3.1× | 3.4% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.89ms | 30.56ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_range_select` | 15.10ms | 19.84ms | 1.3× | 1.6% | PASS |
| mem_reads | `oltp_sum_range` | 14.25ms | 18.30ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_order_range` | 2.96ms | 3.69ms | 1.2× | 2.6% | PASS |
| mem_reads | `oltp_distinct_range` | 3.86ms | 4.66ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_index_scan` | 3.69ms | 4.91ms | 1.3× | 2.6% | PASS |
| mem_reads | `select_random_points` | 22.16ms | 26.54ms | 1.2× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 5.91ms | 7.06ms | 1.2× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 5.82ms | 8.57ms | 1.5× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 32.20ms | 37.50ms | 1.2× | 1.1% | PASS |
| mem_reads | `index_join` | 6.74ms | 9.74ms | 1.4× | 1.5% | PASS |
| mem_reads | `index_join_scan` | 3.22ms | 5.48ms | 1.7× | 1.3% | PASS |
| mem_reads | `types_table_scan` | 960.50ms | 1.20s | 1.2× | 0.4% | PASS |
| mem_reads | `table_scan` | 1.11s | 1.30s | 1.2× | 0.3% | PASS |
| mem_reads | `oltp_read_only` | 112.02ms | 140.86ms | 1.3× | 1.3% | PASS |
| mem_writes | `oltp_bulk_insert` | 171.40ms | 242.74ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 14.48ms | 25.10ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 52.77ms | 99.42ms | 1.9× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 38.52ms | 66.37ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_delete_insert` | 39.03ms | 73.90ms | 1.9× | 0.9% | PASS |
| mem_writes | `oltp_write_only` | 21.01ms | 44.18ms | 2.1× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 24.31ms | 41.24ms | 1.7× | 1.5% | PASS |
| mem_writes | `oltp_read_write` | 74.88ms | 118.44ms | 1.6× | 1.1% | PASS |
| file_reads | `oltp_point_select` | 52.66ms | 36.25ms | 0.7× | 1.5% | PASS |
| file_reads | `oltp_range_select` | 18.18ms | 20.43ms | 1.1× | 2.1% | PASS |
| file_reads | `oltp_sum_range` | 17.63ms | 19.29ms | 1.1× | 2.0% | PASS |
| file_reads | `oltp_order_range` | 3.42ms | 3.83ms | 1.1× | 2.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.11ms | 4.61ms | 1.1× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 6.28ms | 5.62ms | 0.9× | 2.9% | PASS |
| file_reads | `select_random_points` | 24.31ms | 26.40ms | 1.1× | 1.4% | PASS |
| file_reads | `select_random_ranges` | 8.29ms | 7.40ms | 0.9× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 8.11ms | 8.77ms | 1.1× | 2.3% | PASS |
| file_reads | `groupby_scan` | 30.46ms | 35.16ms | 1.2× | 1.1% | PASS |
| file_reads | `index_join` | 7.83ms | 9.59ms | 1.2× | 2.8% | PASS |
| file_reads | `index_join_scan` | 3.40ms | 5.41ms | 1.6× | 1.8% | PASS |
| file_reads | `types_table_scan` | 901.14ms | 1.10s | 1.2× | 0.5% | PASS |
| file_reads | `table_scan` | 1.04s | 1.20s | 1.2× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 151.53ms | 151.19ms | 1.0× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 226.00ms | 302.50ms | 1.3× | 3.3% | PASS |
| file_writes | `oltp_insert` | 25.31ms | 35.96ms | 1.4× | 5.1% | PASS |
| file_writes | `oltp_update_index` | 145.91ms | 152.28ms | 1.0× | 3.3% | PASS |
| file_writes | `oltp_update_non_index` | 120.55ms | 101.84ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_delete_insert` | 120.84ms | 128.25ms | 1.1× | 2.6% | PASS |
| file_writes | `oltp_write_only` | 80.85ms | 81.49ms | 1.0× | 0.9% | PASS |
| file_writes | `types_delete_insert` | 73.60ms | 70.28ms | 1.0× | 7.2% | PASS |
| file_writes | `oltp_read_write` | 135.16ms | 156.82ms | 1.2× | 3.9% | PASS |
| ac_reads | `oltp_point_select` | 33.29ms | 34.99ms | 1.1× | 1.8% | PASS |
| ac_reads | `oltp_range_select` | 16.12ms | 19.60ms | 1.2× | 1.9% | PASS |
| ac_reads | `oltp_sum_range` | 15.03ms | 18.09ms | 1.2× | 1.7% | PASS |
| ac_reads | `oltp_order_range` | 3.03ms | 3.56ms | 1.2× | 2.6% | PASS |
| ac_reads | `oltp_distinct_range` | 3.78ms | 4.44ms | 1.2× | 2.5% | PASS |
| ac_reads | `oltp_index_scan` | 4.61ms | 5.48ms | 1.2× | 2.5% | PASS |
| ac_reads | `select_random_points` | 22.34ms | 26.18ms | 1.2× | 0.9% | PASS |
| ac_reads | `select_random_ranges` | 6.61ms | 7.52ms | 1.1× | 2.4% | PASS |
| ac_reads | `covering_index_scan` | 6.35ms | 8.71ms | 1.4× | 3.5% | PASS |
| ac_reads | `groupby_scan` | 30.14ms | 35.13ms | 1.2× | 1.6% | PASS |
| ac_reads | `index_join` | 6.96ms | 9.49ms | 1.4× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 3.28ms | 5.40ms | 1.6× | 2.4% | PASS |
| ac_reads | `types_table_scan` | 910.26ms | 1.11s | 1.2× | 0.7% | PASS |
| ac_reads | `table_scan` | 1.04s | 1.21s | 1.2× | 0.4% | PASS |
| ac_reads | `oltp_read_only` | 123.44ms | 147.83ms | 1.2× | 0.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 24.62ms | 63.41ms | 2.6× | 3.2% | PASS |
| ac_writes | `oltp_insert_ac` | 28.86ms | 73.28ms | 2.5× | 2.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 30.76ms | 81.06ms | 2.6× | 4.3% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 24.91ms | 70.44ms | 2.8× | 2.9% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 28.05ms | 76.79ms | 2.7× | 3.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 28.28ms | 76.85ms | 2.7× | 3.5% | PASS |
| ac_writes | `types_delete_insert_ac` | 29.53ms | 71.79ms | 2.4× | 8.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.37ms | 83.29ms | 2.7× | 2.5% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 30s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 26.02ms | 38.00ms | 68.5% | 0.9% | PASS |
| `status_dirty_many_tables` | 28.50ms | 42.00ms | 67.9% | 0.7% | PASS |
| `diff_regular_working_one_table` | 21.59ms | 33.00ms | 65.4% | 1.3% | PASS |
| `diff_regular_working_many_tables` | 32.20ms | 50.00ms | 64.4% | 0.9% | PASS |
| `diff_stat_working_many_tables` | 32.44ms | 48.00ms | 67.6% | 1.0% | PASS |
| `diff_schema_working_many_tables` | 33.01ms | 48.00ms | 68.8% | 0.8% | PASS |
| `branch_list_many_branches` | 16.80ms | 25.00ms | 67.2% | 0.9% | PASS |
| `branch_create_delete` | 18.14ms | 27.00ms | 67.2% | 0.9% | PASS |
| `at_literal_deep_history` | 18.18ms | 28.00ms | 64.9% | 0.9% | PASS |
| `diff_literal_deep_history` | 17.80ms | 28.00ms | 63.6% | 1.0% | PASS |
| `history_literal_deep_history` | 18.88ms | 30.00ms | 62.9% | 0.7% | PASS |
| `checkout_branch_clean` | 25.36ms | 43.00ms | 59.0% | 1.5% | PASS |
| `merge_data_no_conflicts` | 20.89ms | 33.00ms | 63.3% | 0.9% | PASS |
| `merge_data_secondary_index` | 774.76ms | 944.00ms | 82.1% | 1.7% | PASS |
| `merge_schema_no_conflicts` | 14.90ms | 24.00ms | 62.1% | 0.9% | PASS |
| `merge_data_conflicts` | 21.64ms | 33.00ms | 65.6% | 0.7% | PASS |
| `merge_data_conflicts_with_resolve` | 22.22ms | 34.00ms | 65.3% | 0.7% | PASS |

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
| copy_fsync | candidate | 444.638 | 412.877–541.574 | 31.673 | 224.90 | 107968266 |
| push_initial | candidate | 781.745 | 777.251–792.476 | 403.918 | 127.92 | 107956772 |
| clone_initial | candidate | 899.260 | 895.819–916.295 | 518.874 | 111.20 | 108475035 |
| push_noop | candidate | 5.440 | 0.585–177.001 | 0.352 | — | 0 |
| fetch_noop | candidate | 0.183 | 0.178–0.209 | 0.186 | — | 0 |
| push_incremental | candidate | 194.803 | 192.626–248.394 | 165.709 | 5.13 | 7909775 |
| fetch_incremental | candidate | 99.983 | 98.182–296.966 | 71.401 | 10.00 | 7910084 |
| pull_fast_forward | candidate | 91.033 | 89.779–116.758 | 62.590 | 10.99 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.54 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.79 | 295.099 | 109.784 | 47243 | 2337 |
| push_noop | candidate | 46.09 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.09 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.09 | 96.972 | 7.910 | 22437 | 125 |
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
| copy_fsync | candidate | 2672.992 | 2661.892–2677.417 | 370.502 | 374.11 | 1087718031 |
| push_initial | candidate | 6634.863 | 6590.123–6667.776 | 4369.043 | 150.72 | 1079566275 |
| clone_initial | candidate | 6552.083 | 6529.432–6564.154 | 6339.304 | 152.62 | 1102407326 |
| push_noop | candidate | 0.843 | 0.830–1.017 | 0.301 | — | 0 |
| fetch_noop | candidate | 0.152 | 0.122–0.154 | 0.154 | — | 0 |
| push_incremental | candidate | 944.020 | 939.913–947.174 | 939.636 | 1.06 | 15806003 |
| fetch_incremental | candidate | 258.990 | 257.982–276.239 | 252.472 | 3.86 | 15806513 |
| pull_fast_forward | candidate | 260.726 | 247.760–262.464 | 254.175 | 3.84 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.70 | 2092.453 | 1087.622 | 263638 | 20541 |
| clone_initial | candidate | 124.03 | 3515.356 | 1132.819 | 611690 | 32243 |
| push_noop | candidate | 47.16 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.16 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 616.018 | 15.928 | 149609 | 313 |
| fetch_incremental | candidate | 50.45 | 62.611 | 15.928 | 13987 | 313 |
| pull_fast_forward | candidate | 50.34 | 62.543 | 15.929 | 13983 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
