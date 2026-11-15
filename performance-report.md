# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-15 18:19 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.196.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43735927547)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.77s | 9.92s | 1.1× | 1.2% | **PASS** |
| Writes | 1.61s | 2.61s | 1.6× | 0.8% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.27s | 9.98s | 1.1× | 1.2% | **PASS** |
| Writes | 3.14s | 3.57s | 1.1× | 2.1% | **PASS** |
| Autocommit writes | 594.04ms | 1.95s | 3.3× | 5.9% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.83s | 2.09s | 1.1× | 1.1% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.94s | 2.28s | 1.2× | 1.2% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.15s | 2.44s | 1.1× | 1.8% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.85s | 3.10s | 1.1× | 1.0% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 277.04ms | 476.14ms | 1.7× | 0.8% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 378.97ms | 603.16ms | 1.6× | 0.8% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 461.58ms | 718.34ms | 1.6× | 2.1% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 493.50ms | 815.31ms | 1.7× | 0.7% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.91s | 2.10s | 1.1× | 1.0% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.00s | 2.27s | 1.1× | 1.7% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.37s | 2.50s | 1.1× | 1.3% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 2.99s | 3.11s | 1.0× | 0.8% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 353.12ms | 513.72ms | 1.5× | 1.3% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 487.72ms | 657.47ms | 1.3× | 1.8% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.18s | 1.20s | 1.0× | 8.5% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 1.12s | 1.20s | 1.1× | 2.2% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.86s | 2.10s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 1.93s | 2.27s | 1.2× | 2.2% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.42s | 2.58s | 1.1× | 1.1% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.90s | 3.10s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 78.50ms | 308.76ms | 3.9× | 4.7% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 83.86ms | 312.80ms | 3.7× | 6.1% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 194.83ms | 640.03ms | 3.3× | 23.3% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 236.84ms | 692.10ms | 2.9× | 3.5% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 15.33ms | 18.74ms | 1.2× | 0.8% | PASS |
| mem_reads | `oltp_range_select` | 7.61ms | 8.95ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_sum_range` | 7.19ms | 8.41ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_order_range` | 1.94ms | 2.18ms | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_distinct_range` | 2.60ms | 2.93ms | 1.1× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 2.76ms | 3.78ms | 1.4× | 1.5% | PASS |
| mem_reads | `select_random_points` | 8.26ms | 9.60ms | 1.2× | 1.7% | PASS |
| mem_reads | `select_random_ranges` | 3.10ms | 3.40ms | 1.1× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 4.66ms | 6.65ms | 1.4× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 21.55ms | 24.92ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 4.21ms | 6.46ms | 1.5× | 1.9% | PASS |
| mem_reads | `index_join_scan` | 2.40ms | 4.52ms | 1.9× | 2.9% | PASS |
| mem_reads | `types_table_scan` | 778.36ms | 902.04ms | 1.2× | 0.4% | PASS |
| mem_reads | `table_scan` | 891.89ms | 1.01s | 1.1× | 1.1% | PASS |
| mem_reads | `oltp_read_only` | 73.51ms | 85.65ms | 1.2× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 102.13ms | 172.39ms | 1.7× | 0.5% | PASS |
| mem_writes | `oltp_insert` | 9.42ms | 16.42ms | 1.7× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 35.70ms | 68.29ms | 1.9× | 1.1% | PASS |
| mem_writes | `oltp_update_non_index` | 23.04ms | 40.99ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_delete_insert` | 31.29ms | 50.89ms | 1.6× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 15.32ms | 31.86ms | 2.1× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 16.28ms | 23.20ms | 1.4× | 0.8% | PASS |
| mem_writes | `oltp_read_write` | 43.87ms | 72.11ms | 1.6× | 0.6% | PASS |
| file_reads | `oltp_point_select` | 37.51ms | 23.88ms | 0.6× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 10.04ms | 9.66ms | 1.0× | 0.9% | PASS |
| file_reads | `oltp_sum_range` | 9.50ms | 9.10ms | 1.0× | 0.9% | PASS |
| file_reads | `oltp_order_range` | 2.20ms | 2.30ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_distinct_range` | 2.86ms | 3.05ms | 1.1× | 2.3% | PASS |
| file_reads | `oltp_index_scan` | 5.09ms | 4.54ms | 0.9× | 1.2% | PASS |
| file_reads | `select_random_points` | 11.18ms | 10.78ms | 1.0× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 5.36ms | 3.96ms | 0.7× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 6.98ms | 7.33ms | 1.1× | 0.5% | PASS |
| file_reads | `groupby_scan` | 22.21ms | 25.09ms | 1.1× | 0.9% | PASS |
| file_reads | `index_join` | 5.52ms | 6.93ms | 1.3× | 1.6% | PASS |
| file_reads | `index_join_scan` | 2.69ms | 4.62ms | 1.7× | 2.3% | PASS |
| file_reads | `types_table_scan` | 787.22ms | 894.97ms | 1.1× | 0.3% | PASS |
| file_reads | `table_scan` | 903.30ms | 1.00s | 1.1× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 99.47ms | 90.14ms | 0.9× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 110.09ms | 179.76ms | 1.6× | 0.5% | PASS |
| file_writes | `oltp_insert` | 12.55ms | 18.32ms | 1.5× | 1.7% | PASS |
| file_writes | `oltp_update_index` | 48.38ms | 72.58ms | 1.5× | 1.3% | PASS |
| file_writes | `oltp_update_non_index` | 34.83ms | 44.58ms | 1.3× | 2.2% | PASS |
| file_writes | `oltp_delete_insert` | 42.09ms | 59.11ms | 1.4× | 1.1% | PASS |
| file_writes | `oltp_write_only` | 25.86ms | 35.62ms | 1.4× | 1.4% | PASS |
| file_writes | `types_delete_insert` | 23.62ms | 27.20ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_read_write` | 55.70ms | 76.55ms | 1.4× | 1.0% | PASS |
| ac_reads | `oltp_point_select` | 22.66ms | 23.78ms | 1.0× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 8.85ms | 9.67ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_sum_range` | 8.43ms | 9.24ms | 1.1× | 1.2% | PASS |
| ac_reads | `oltp_order_range` | 2.13ms | 2.33ms | 1.1× | 2.2% | PASS |
| ac_reads | `oltp_distinct_range` | 2.78ms | 3.05ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 3.67ms | 4.45ms | 1.2× | 1.7% | PASS |
| ac_reads | `select_random_points` | 9.62ms | 10.50ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_ranges` | 3.91ms | 3.89ms | 1.0× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 5.51ms | 7.26ms | 1.3× | 0.7% | PASS |
| ac_reads | `groupby_scan` | 21.96ms | 25.11ms | 1.1× | 0.6% | PASS |
| ac_reads | `index_join` | 4.86ms | 6.89ms | 1.4× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 2.61ms | 4.55ms | 1.7× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 786.66ms | 891.78ms | 1.1× | 0.3% | PASS |
| ac_reads | `table_scan` | 893.23ms | 1.00s | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_read_only` | 82.54ms | 91.75ms | 1.1× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 8.63ms | 30.58ms | 3.5× | 6.7% | PASS |
| ac_writes | `oltp_insert_ac` | 9.69ms | 37.46ms | 3.9× | 3.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 10.67ms | 45.26ms | 4.2× | 4.7% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 8.93ms | 34.44ms | 3.9× | 6.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 9.52ms | 39.80ms | 4.2× | 4.6% | PASS |
| ac_writes | `oltp_write_only_ac` | 9.79ms | 39.57ms | 4.0× | 4.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 9.30ms | 38.34ms | 4.1× | 8.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 11.96ms | 43.32ms | 3.6× | 3.5% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 23.65ms | 25.17ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_range_select` | 11.72ms | 11.59ms | 1.0× | 2.0% | PASS |
| mem_reads | `oltp_sum_range` | 12.00ms | 11.06ms | 0.9× | 2.3% | PASS |
| mem_reads | `oltp_order_range` | 2.44ms | 2.53ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.13ms | 3.29ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 2.85ms | 4.75ms | 1.7× | 1.2% | PASS |
| mem_reads | `select_random_points` | 18.35ms | 18.19ms | 1.0× | 1.0% | PASS |
| mem_reads | `select_random_ranges` | 4.85ms | 4.62ms | 1.0× | 1.4% | PASS |
| mem_reads | `covering_index_scan` | 4.72ms | 6.98ms | 1.5× | 0.7% | PASS |
| mem_reads | `groupby_scan` | 24.24ms | 26.45ms | 1.1× | 0.3% | PASS |
| mem_reads | `index_join` | 9.56ms | 7.68ms | 0.8× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 2.81ms | 5.76ms | 2.1× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 802.55ms | 981.17ms | 1.2× | 0.5% | PASS |
| mem_reads | `table_scan` | 926.63ms | 1.08s | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_read_only` | 94.91ms | 100.26ms | 1.1× | 1.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 138.54ms | 204.59ms | 1.5× | 0.4% | PASS |
| mem_writes | `oltp_insert` | 11.19ms | 23.09ms | 2.1× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 47.47ms | 95.21ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 33.77ms | 52.62ms | 1.6× | 0.8% | PASS |
| mem_writes | `oltp_delete_insert` | 38.43ms | 67.88ms | 1.8× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 20.25ms | 35.78ms | 1.8× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 26.89ms | 37.12ms | 1.4× | 0.8% | PASS |
| mem_writes | `oltp_read_write` | 62.41ms | 86.87ms | 1.4× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 46.05ms | 30.30ms | 0.7× | 0.8% | PASS |
| file_reads | `oltp_range_select` | 13.18ms | 12.00ms | 0.9× | 4.0% | PASS |
| file_reads | `oltp_sum_range` | 13.37ms | 11.45ms | 0.9× | 2.6% | PASS |
| file_reads | `oltp_order_range` | 2.59ms | 2.56ms | 1.0× | 2.3% | PASS |
| file_reads | `oltp_distinct_range` | 3.24ms | 3.27ms | 1.0× | 1.6% | PASS |
| file_reads | `oltp_index_scan` | 4.91ms | 4.85ms | 1.0× | 1.7% | PASS |
| file_reads | `select_random_points` | 19.53ms | 18.37ms | 0.9× | 1.8% | PASS |
| file_reads | `select_random_ranges` | 6.79ms | 4.95ms | 0.7× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 6.90ms | 7.27ms | 1.1× | 0.6% | PASS |
| file_reads | `groupby_scan` | 23.91ms | 26.31ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 9.65ms | 7.47ms | 0.8× | 3.3% | PASS |
| file_reads | `index_join_scan` | 2.69ms | 4.84ms | 1.8× | 3.9% | PASS |
| file_reads | `types_table_scan` | 797.31ms | 966.36ms | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 926.37ms | 1.07s | 1.2× | 1.2% | PASS |
| file_reads | `oltp_read_only` | 123.37ms | 105.96ms | 0.9× | 1.3% | PASS |
| file_writes | `oltp_bulk_insert` | 151.84ms | 212.21ms | 1.4× | 1.0% | PASS |
| file_writes | `oltp_insert` | 14.72ms | 26.12ms | 1.8× | 1.3% | PASS |
| file_writes | `oltp_update_index` | 63.14ms | 103.70ms | 1.6× | 1.9% | PASS |
| file_writes | `oltp_update_non_index` | 48.37ms | 60.25ms | 1.2× | 1.7% | PASS |
| file_writes | `oltp_delete_insert` | 56.73ms | 77.94ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_write_only` | 33.05ms | 41.79ms | 1.3× | 2.1% | PASS |
| file_writes | `types_delete_insert` | 42.22ms | 40.94ms | 1.0× | 2.1% | PASS |
| file_writes | `oltp_read_write` | 77.64ms | 94.52ms | 1.2× | 2.3% | PASS |
| ac_reads | `oltp_point_select` | 31.24ms | 30.13ms | 1.0× | 1.2% | PASS |
| ac_reads | `oltp_range_select` | 11.67ms | 11.90ms | 1.0× | 3.8% | PASS |
| ac_reads | `oltp_sum_range` | 11.47ms | 11.40ms | 1.0× | 4.2% | PASS |
| ac_reads | `oltp_order_range` | 2.47ms | 2.55ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_distinct_range` | 3.08ms | 3.25ms | 1.1× | 2.4% | PASS |
| ac_reads | `oltp_index_scan` | 3.48ms | 4.85ms | 1.4× | 2.1% | PASS |
| ac_reads | `select_random_points` | 18.85ms | 18.50ms | 1.0× | 1.7% | PASS |
| ac_reads | `select_random_ranges` | 5.57ms | 5.04ms | 0.9× | 2.8% | PASS |
| ac_reads | `covering_index_scan` | 5.44ms | 7.31ms | 1.3× | 0.6% | PASS |
| ac_reads | `groupby_scan` | 23.86ms | 26.37ms | 1.1× | 0.5% | PASS |
| ac_reads | `index_join` | 9.71ms | 7.64ms | 0.8× | 2.3% | PASS |
| ac_reads | `index_join_scan` | 2.94ms | 5.75ms | 2.0× | 4.1% | PASS |
| ac_reads | `types_table_scan` | 799.21ms | 968.61ms | 1.2× | 0.9% | PASS |
| ac_reads | `table_scan` | 899.24ms | 1.07s | 1.2× | 2.2% | PASS |
| ac_reads | `oltp_read_only` | 101.97ms | 105.83ms | 1.0× | 0.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 9.29ms | 30.38ms | 3.3× | 6.5% | PASS |
| ac_writes | `oltp_insert_ac` | 10.34ms | 37.31ms | 3.6× | 5.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 10.74ms | 46.98ms | 4.4× | 3.0% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 9.05ms | 33.39ms | 3.7× | 5.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 10.60ms | 42.97ms | 4.1× | 6.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 10.14ms | 40.14ms | 4.0× | 6.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 9.69ms | 37.11ms | 3.8× | 6.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 14.01ms | 44.50ms | 3.2× | 4.3% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.83ms | 30.04ms | 1.0× | 2.7% | PASS |
| mem_reads | `oltp_range_select` | 14.74ms | 12.82ms | 0.9× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 13.06ms | 12.05ms | 0.9× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 2.83ms | 2.83ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 3.60ms | 3.64ms | 1.0× | 1.2% | PASS |
| mem_reads | `oltp_index_scan` | 3.22ms | 5.39ms | 1.7× | 1.6% | PASS |
| mem_reads | `select_random_points` | 17.97ms | 17.60ms | 1.0× | 2.6% | PASS |
| mem_reads | `select_random_ranges` | 5.56ms | 5.24ms | 0.9× | 2.1% | PASS |
| mem_reads | `covering_index_scan` | 5.91ms | 8.22ms | 1.4× | 1.3% | PASS |
| mem_reads | `groupby_scan` | 29.01ms | 29.69ms | 1.0× | 1.0% | PASS |
| mem_reads | `index_join` | 9.45ms | 8.91ms | 0.9× | 4.2% | PASS |
| mem_reads | `index_join_scan` | 3.08ms | 5.63ms | 1.8× | 1.8% | PASS |
| mem_reads | `types_table_scan` | 879.82ms | 1.04s | 1.2× | 1.1% | PASS |
| mem_reads | `table_scan` | 1.02s | 1.15s | 1.1× | 2.8% | PASS |
| mem_reads | `oltp_read_only` | 111.44ms | 111.24ms | 1.0× | 1.6% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.25ms | 261.59ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 14.09ms | 27.52ms | 2.0× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 53.20ms | 103.74ms | 1.9× | 2.3% | PASS |
| mem_writes | `oltp_update_non_index` | 39.99ms | 59.59ms | 1.5× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 41.50ms | 76.94ms | 1.9× | 1.9% | PASS |
| mem_writes | `oltp_write_only` | 22.68ms | 40.83ms | 1.8× | 2.5% | PASS |
| mem_writes | `types_delete_insert` | 31.09ms | 44.02ms | 1.4× | 3.7% | PASS |
| mem_writes | `oltp_read_write` | 81.77ms | 104.11ms | 1.3× | 4.8% | PASS |
| file_reads | `oltp_point_select` | 97.03ms | 46.06ms | 0.5× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 21.64ms | 14.39ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 20.52ms | 13.95ms | 0.7× | 1.3% | PASS |
| file_reads | `oltp_order_range` | 3.64ms | 3.04ms | 0.8× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 4.43ms | 3.83ms | 0.9× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 10.33ms | 6.97ms | 0.7× | 1.0% | PASS |
| file_reads | `select_random_points` | 25.44ms | 19.23ms | 0.8× | 2.5% | PASS |
| file_reads | `select_random_ranges` | 12.50ms | 6.92ms | 0.6× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 13.14ms | 9.87ms | 0.8× | 0.6% | PASS |
| file_reads | `groupby_scan` | 29.35ms | 29.80ms | 1.0× | 1.0% | PASS |
| file_reads | `index_join` | 13.16ms | 9.88ms | 0.8× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.04ms | 5.92ms | 1.5× | 2.2% | PASS |
| file_reads | `types_table_scan` | 877.76ms | 1.05s | 1.2× | 0.9% | PASS |
| file_reads | `table_scan` | 1.02s | 1.15s | 1.1× | 2.3% | PASS |
| file_reads | `oltp_read_only` | 210.56ms | 135.64ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 248.67ms | 334.03ms | 1.3× | 6.3% | PASS |
| file_writes | `oltp_insert` | 31.41ms | 48.64ms | 1.5× | 9.1% | PASS |
| file_writes | `oltp_update_index` | 168.77ms | 195.60ms | 1.2× | 7.6% | PASS |
| file_writes | `oltp_update_non_index` | 143.08ms | 122.53ms | 0.9× | 9.6% | PASS |
| file_writes | `oltp_delete_insert` | 168.44ms | 149.76ms | 0.9× | 10.2% | PASS |
| file_writes | `oltp_write_only` | 118.68ms | 94.83ms | 0.8× | 7.9% | PASS |
| file_writes | `types_delete_insert` | 125.15ms | 90.27ms | 0.7× | 9.5% | PASS |
| file_writes | `oltp_read_write` | 174.60ms | 160.40ms | 0.9× | 6.0% | PASS |
| ac_reads | `oltp_point_select` | 48.25ms | 45.56ms | 0.9× | 0.6% | PASS |
| ac_reads | `oltp_range_select` | 16.57ms | 14.38ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_sum_range` | 14.83ms | 13.55ms | 0.9× | 1.6% | PASS |
| ac_reads | `oltp_order_range` | 3.15ms | 3.03ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.91ms | 3.83ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.71ms | 7.00ms | 1.2× | 1.0% | PASS |
| ac_reads | `select_random_points` | 19.53ms | 18.69ms | 1.0× | 1.1% | PASS |
| ac_reads | `select_random_ranges` | 7.74ms | 6.91ms | 0.9× | 1.1% | PASS |
| ac_reads | `covering_index_scan` | 8.53ms | 9.90ms | 1.2× | 1.3% | PASS |
| ac_reads | `groupby_scan` | 29.34ms | 29.93ms | 1.0× | 0.9% | PASS |
| ac_reads | `index_join` | 11.14ms | 10.12ms | 0.9× | 1.8% | PASS |
| ac_reads | `index_join_scan` | 3.63ms | 6.03ms | 1.7× | 2.7% | PASS |
| ac_reads | `types_table_scan` | 929.35ms | 1.07s | 1.2× | 3.9% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.20s | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_read_only` | 151.52ms | 140.22ms | 0.9× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 22.34ms | 60.12ms | 2.7× | 19.5% | PASS |
| ac_writes | `oltp_insert_ac` | 23.98ms | 76.13ms | 3.2× | 26.4% | PASS |
| ac_writes | `oltp_update_index_ac` | 23.03ms | 87.93ms | 3.8× | 20.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 19.36ms | 72.25ms | 3.7× | 12.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.17ms | 76.44ms | 3.2× | 18.8% | PASS |
| ac_writes | `oltp_write_only_ac` | 27.70ms | 102.40ms | 3.7× | 30.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.40ms | 75.23ms | 3.4× | 27.9% | PASS |
| ac_writes | `oltp_read_write_ac` | 31.85ms | 89.52ms | 2.8× | 40.8% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.56ms | 33.51ms | 1.2× | 0.9% | PASS |
| mem_reads | `oltp_range_select` | 16.72ms | 21.25ms | 1.3× | 1.2% | PASS |
| mem_reads | `oltp_sum_range` | 16.00ms | 19.86ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_order_range` | 3.27ms | 3.95ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 4.12ms | 5.00ms | 1.2× | 1.6% | PASS |
| mem_reads | `oltp_index_scan` | 4.06ms | 5.73ms | 1.4× | 1.1% | PASS |
| mem_reads | `select_random_points` | 24.89ms | 29.88ms | 1.2× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 6.45ms | 7.83ms | 1.2× | 1.1% | PASS |
| mem_reads | `covering_index_scan` | 6.21ms | 9.39ms | 1.5× | 1.0% | PASS |
| mem_reads | `groupby_scan` | 35.05ms | 40.49ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 7.18ms | 10.88ms | 1.5× | 0.9% | PASS |
| mem_reads | `index_join_scan` | 3.48ms | 6.11ms | 1.8× | 1.7% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.30s | 1.1× | 0.9% | PASS |
| mem_reads | `table_scan` | 1.42s | 1.44s | 1.0× | 0.3% | PASS |
| mem_reads | `oltp_read_only` | 135.01ms | 162.28ms | 1.2× | 0.4% | PASS |
| mem_writes | `oltp_bulk_insert` | 193.91ms | 278.33ms | 1.4× | 0.4% | PASS |
| mem_writes | `oltp_insert` | 16.04ms | 28.68ms | 1.8× | 0.9% | PASS |
| mem_writes | `oltp_update_index` | 59.65ms | 116.54ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_update_non_index` | 43.07ms | 74.97ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_delete_insert` | 42.98ms | 84.36ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 23.22ms | 51.31ms | 2.2× | 0.7% | PASS |
| mem_writes | `types_delete_insert` | 27.01ms | 46.31ms | 1.7× | 0.7% | PASS |
| mem_writes | `oltp_read_write` | 87.63ms | 134.81ms | 1.5× | 0.7% | PASS |
| file_reads | `oltp_point_select` | 59.28ms | 40.56ms | 0.7× | 0.5% | PASS |
| file_reads | `oltp_range_select` | 20.57ms | 22.32ms | 1.1× | 0.7% | PASS |
| file_reads | `oltp_sum_range` | 19.54ms | 20.95ms | 1.1× | 0.8% | PASS |
| file_reads | `oltp_order_range` | 3.71ms | 4.11ms | 1.1× | 1.4% | PASS |
| file_reads | `oltp_distinct_range` | 4.61ms | 5.17ms | 1.1× | 0.7% | PASS |
| file_reads | `oltp_index_scan` | 7.52ms | 6.59ms | 0.9× | 1.2% | PASS |
| file_reads | `select_random_points` | 29.04ms | 30.88ms | 1.1× | 0.8% | PASS |
| file_reads | `select_random_ranges` | 9.79ms | 8.64ms | 0.9× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 9.63ms | 10.29ms | 1.1× | 1.0% | PASS |
| file_reads | `groupby_scan` | 35.80ms | 41.03ms | 1.1× | 0.4% | PASS |
| file_reads | `index_join` | 9.34ms | 11.60ms | 1.2× | 1.0% | PASS |
| file_reads | `index_join_scan` | 3.99ms | 6.32ms | 1.6× | 1.4% | PASS |
| file_reads | `types_table_scan` | 1.17s | 1.30s | 1.1× | 0.6% | PASS |
| file_reads | `table_scan` | 1.43s | 1.43s | 1.0× | 0.5% | PASS |
| file_reads | `oltp_read_only` | 177.03ms | 170.12ms | 1.0× | 0.7% | PASS |
| file_writes | `oltp_bulk_insert` | 248.38ms | 338.04ms | 1.4× | 2.2% | PASS |
| file_writes | `oltp_insert` | 41.71ms | 46.01ms | 1.1× | 3.7% | PASS |
| file_writes | `oltp_update_index` | 172.98ms | 186.68ms | 1.1× | 1.7% | PASS |
| file_writes | `oltp_update_non_index` | 142.61ms | 125.01ms | 0.9× | 2.1% | PASS |
| file_writes | `oltp_delete_insert` | 142.86ms | 146.47ms | 1.0× | 2.0% | PASS |
| file_writes | `oltp_write_only` | 108.42ms | 97.21ms | 0.9× | 2.4% | PASS |
| file_writes | `types_delete_insert` | 92.04ms | 81.84ms | 0.9× | 5.3% | PASS |
| file_writes | `oltp_read_write` | 174.84ms | 180.84ms | 1.0× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 38.61ms | 40.31ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 18.21ms | 22.22ms | 1.2× | 0.7% | PASS |
| ac_reads | `oltp_sum_range` | 17.45ms | 20.85ms | 1.2× | 0.9% | PASS |
| ac_reads | `oltp_order_range` | 3.50ms | 4.10ms | 1.2× | 1.4% | PASS |
| ac_reads | `oltp_distinct_range` | 4.37ms | 5.12ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 5.49ms | 6.51ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 26.59ms | 30.53ms | 1.1× | 0.9% | PASS |
| ac_reads | `select_random_ranges` | 7.68ms | 8.58ms | 1.1× | 1.4% | PASS |
| ac_reads | `covering_index_scan` | 7.46ms | 10.22ms | 1.4× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 35.37ms | 40.80ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 8.27ms | 11.49ms | 1.4× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.80ms | 6.33ms | 1.7× | 1.1% | PASS |
| ac_reads | `types_table_scan` | 1.15s | 1.29s | 1.1× | 1.0% | PASS |
| ac_reads | `table_scan` | 1.42s | 1.43s | 1.0× | 0.6% | PASS |
| ac_reads | `oltp_read_only` | 149.14ms | 171.41ms | 1.1× | 0.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 27.88ms | 73.72ms | 2.6× | 3.8% | PASS |
| ac_writes | `oltp_insert_ac` | 29.98ms | 86.39ms | 2.9× | 3.6% | PASS |
| ac_writes | `oltp_update_index_ac` | 30.88ms | 95.85ms | 3.1× | 2.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 27.69ms | 79.99ms | 2.9× | 3.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 29.43ms | 89.27ms | 3.0× | 5.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 29.64ms | 89.94ms | 3.0× | 3.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 27.19ms | 82.24ms | 3.0× | 4.3% | PASS |
| ac_writes | `oltp_read_write_ac` | 34.15ms | 94.70ms | 2.8× | 3.1% | PASS |

</details>

</details>

## Version-control latency

Wall time: 4m 39s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 21.27ms | 38.00ms | 56.0% | 1.0% | PASS |
| `status_dirty_many_tables` | 23.81ms | 42.00ms | 56.7% | 0.9% | PASS |
| `diff_regular_working_one_table` | 18.27ms | 33.00ms | 55.4% | 0.7% | PASS |
| `diff_regular_working_many_tables` | 26.38ms | 50.00ms | 52.8% | 1.3% | PASS |
| `diff_stat_working_many_tables` | 26.41ms | 48.00ms | 55.0% | 0.8% | PASS |
| `diff_schema_working_many_tables` | 26.60ms | 48.00ms | 55.4% | 1.0% | PASS |
| `branch_list_many_branches` | 12.35ms | 25.00ms | 49.4% | 1.0% | PASS |
| `branch_create_delete` | 13.27ms | 27.00ms | 49.2% | 1.2% | PASS |
| `at_literal_deep_history` | 13.46ms | 28.00ms | 48.1% | 1.1% | PASS |
| `diff_literal_deep_history` | 13.37ms | 28.00ms | 47.7% | 1.1% | PASS |
| `history_literal_deep_history` | 14.17ms | 30.00ms | 47.2% | 0.8% | PASS |
| `checkout_branch_clean` | 19.69ms | 43.00ms | 45.8% | 0.7% | PASS |
| `merge_data_no_conflicts` | 15.01ms | 33.00ms | 45.5% | 0.8% | PASS |
| `merge_data_secondary_index` | 598.82ms | 944.00ms | 63.4% | 1.3% | PASS |
| `merge_schema_no_conflicts` | 11.72ms | 24.00ms | 48.9% | 1.3% | PASS |
| `merge_data_conflicts` | 17.21ms | 33.00ms | 52.2% | 0.7% | PASS |
| `merge_data_conflicts_with_resolve` | 18.01ms | 34.00ms | 53.0% | 0.9% | PASS |

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
| copy_fsync | candidate | 57.617 | 57.142–58.994 | 48.567 | 1735.60 | 107968266 |
| push_initial | candidate | 348.619 | 342.994–357.591 | 346.217 | 286.85 | 107956772 |
| clone_initial | candidate | 452.873 | 449.569–456.930 | 443.472 | 220.81 | 108475035 |
| push_noop | candidate | 0.369 | 0.346–0.430 | 0.220 | — | 0 |
| fetch_noop | candidate | 0.104 | 0.101–0.112 | 0.104 | — | 0 |
| push_incremental | candidate | 136.953 | 135.489–138.526 | 135.497 | 7.30 | 7909775 |
| fetch_incremental | candidate | 59.374 | 58.055–60.200 | 57.939 | 16.84 | 7910084 |
| pull_fast_forward | candidate | 52.989 | 52.082–53.855 | 51.805 | 18.87 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.51 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.75 | 295.070 | 109.784 | 47235 | 2337 |
| push_noop | candidate | 46.13 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 46.13 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.13 | 96.684 | 7.910 | 22366 | 125 |
| fetch_incremental | candidate | 46.13 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.13 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5586.960 | 5452.763–5619.381 | 307.786 | 178.99 | 1087718031 |
| push_initial | candidate | 8180.433 | 8045.502–8989.489 | 4159.843 | 122.24 | 1079566275 |
| clone_initial | candidate | 10608.015 | 10260.762–11247.198 | 6033.012 | 94.27 | 1102407326 |
| push_noop | candidate | 0.679 | 0.623–0.682 | 0.359 | — | 0 |
| fetch_noop | candidate | 0.184 | 0.177–0.185 | 0.186 | — | 0 |
| push_incremental | candidate | 1060.365 | 1036.667–1087.382 | 940.496 | 0.94 | 15806003 |
| fetch_incremental | candidate | 344.151 | 308.013–408.502 | 213.476 | 2.91 | 15806513 |
| pull_fast_forward | candidate | 345.866 | 274.495–347.904 | 217.893 | 2.89 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.75 | 2091.896 | 1087.622 | 263502 | 20541 |
| clone_initial | candidate | 123.93 | 3514.575 | 1132.819 | 611536 | 32243 |
| push_noop | candidate | 46.94 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 46.94 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.94 | 615.534 | 15.928 | 149515 | 313 |
| fetch_incremental | candidate | 50.44 | 62.479 | 15.928 | 13955 | 313 |
| pull_fast_forward | candidate | 50.46 | 62.412 | 15.929 | 13951 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
