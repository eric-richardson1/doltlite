# DoltLite Performance Report

> Nightly result: **PASS**
>
> Generated: 2026-11-14 17:44 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261111.196.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/43613087721)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.87s | 10.09s | 1.1× | 1.5% | **PASS** |
| Writes | 1.71s | 2.79s | 1.6× | 1.4% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 9.77s | 10.34s | 1.1× | 1.2% | **PASS** |
| Writes | 3.89s | 4.13s | 1.1× | 4.6% | **PASS** |
| Autocommit writes | 837.32ms | 2.59s | 3.1× | 7.2% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 2.46s | 2.89s | 1.2× | 1.3% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 2.19s | 2.46s | 1.1× | 1.6% | **PASS** |
| In-memory | Reads | blobpk | 15 | 55 | 2.34s | 2.54s | 1.1× | 2.0% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 1.87s | 2.20s | 1.2× | 1.5% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 430.34ms | 762.44ms | 1.8× | 1.2% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 460.04ms | 721.49ms | 1.6× | 1.7% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 462.24ms | 723.04ms | 1.6× | 1.7% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 356.03ms | 583.68ms | 1.6× | 1.3% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 2.65s | 2.94s | 1.1× | 1.3% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 2.52s | 2.53s | 1.0× | 1.2% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 2.61s | 2.63s | 1.0× | 1.0% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 1.99s | 2.24s | 1.1× | 1.6% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 581.37ms | 821.40ms | 1.4× | 1.5% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.30s | 1.22s | 0.9× | 5.5% | **PASS** |
| File-backed | Writes | blobpk | 8 | 55 | 1.18s | 1.17s | 1.0× | 9.3% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 839.24ms | 918.30ms | 1.1× | 3.7% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 2.50s | 2.94s | 1.2× | 1.2% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 2.47s | 2.57s | 1.0× | 1.1% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 2.31s | 2.56s | 1.1× | 1.0% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 1.94s | 2.23s | 1.2× | 1.9% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 189.23ms | 623.41ms | 3.3× | 6.3% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 164.82ms | 533.20ms | 3.2× | 7.6% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 222.13ms | 665.08ms | 3.0× | 27.6% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 261.13ms | 766.71ms | 2.9× | 5.2% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 25.01ms | 31.78ms | 1.3× | 1.8% | PASS |
| mem_reads | `oltp_range_select` | 11.39ms | 12.96ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_sum_range` | 9.85ms | 12.24ms | 1.2× | 1.7% | PASS |
| mem_reads | `oltp_order_range` | 2.69ms | 3.18ms | 1.2× | 1.2% | PASS |
| mem_reads | `oltp_distinct_range` | 3.65ms | 4.37ms | 1.2× | 1.1% | PASS |
| mem_reads | `oltp_index_scan` | 3.91ms | 5.71ms | 1.5× | 1.5% | PASS |
| mem_reads | `select_random_points` | 10.89ms | 11.94ms | 1.1× | 3.1% | PASS |
| mem_reads | `select_random_ranges` | 4.68ms | 5.43ms | 1.2× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 7.96ms | 10.95ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 30.83ms | 35.66ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 5.79ms | 9.15ms | 1.6× | 1.3% | PASS |
| mem_reads | `index_join_scan` | 3.38ms | 5.83ms | 1.7× | 1.6% | PASS |
| mem_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.4% | PASS |
| mem_reads | `table_scan` | 1.19s | 1.35s | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_read_only` | 104.07ms | 129.36ms | 1.2× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 175.24ms | 300.38ms | 1.7× | 1.2% | PASS |
| mem_writes | `oltp_insert` | 14.82ms | 26.83ms | 1.8× | 0.6% | PASS |
| mem_writes | `oltp_update_index` | 49.31ms | 96.81ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_update_non_index` | 34.27ms | 63.06ms | 1.8× | 1.5% | PASS |
| mem_writes | `oltp_delete_insert` | 43.30ms | 77.03ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_write_only` | 21.36ms | 47.45ms | 2.2× | 1.2% | PASS |
| mem_writes | `types_delete_insert` | 24.57ms | 37.59ms | 1.5× | 1.1% | PASS |
| mem_writes | `oltp_read_write` | 67.47ms | 113.30ms | 1.7× | 1.3% | PASS |
| file_reads | `oltp_point_select` | 92.38ms | 48.90ms | 0.5× | 0.6% | PASS |
| file_reads | `oltp_range_select` | 17.90ms | 14.70ms | 0.8× | 1.6% | PASS |
| file_reads | `oltp_sum_range` | 16.94ms | 14.15ms | 0.8× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 3.44ms | 3.40ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_distinct_range` | 4.42ms | 4.60ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 10.97ms | 7.65ms | 0.7× | 1.5% | PASS |
| file_reads | `select_random_points` | 17.41ms | 13.83ms | 0.8× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 11.79ms | 7.31ms | 0.6× | 1.3% | PASS |
| file_reads | `covering_index_scan` | 15.20ms | 12.86ms | 0.8× | 1.1% | PASS |
| file_reads | `groupby_scan` | 31.55ms | 35.81ms | 1.1× | 0.8% | PASS |
| file_reads | `index_join` | 9.70ms | 10.19ms | 1.1× | 1.3% | PASS |
| file_reads | `index_join_scan` | 4.17ms | 6.08ms | 1.5× | 2.0% | PASS |
| file_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.6% | PASS |
| file_reads | `table_scan` | 1.16s | 1.35s | 1.2× | 0.4% | PASS |
| file_reads | `oltp_read_only` | 202.20ms | 155.82ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 188.26ms | 312.66ms | 1.7× | 1.2% | PASS |
| file_writes | `oltp_insert` | 21.30ms | 30.00ms | 1.4× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 75.06ms | 105.36ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_update_non_index` | 57.65ms | 69.60ms | 1.2× | 1.6% | PASS |
| file_writes | `oltp_delete_insert` | 65.84ms | 87.86ms | 1.3× | 2.2% | PASS |
| file_writes | `oltp_write_only` | 43.38ms | 53.34ms | 1.2× | 1.6% | PASS |
| file_writes | `types_delete_insert` | 39.69ms | 43.66ms | 1.1× | 1.6% | PASS |
| file_writes | `oltp_read_write` | 90.19ms | 118.92ms | 1.3× | 1.1% | PASS |
| ac_reads | `oltp_point_select` | 45.39ms | 48.84ms | 1.1× | 0.9% | PASS |
| ac_reads | `oltp_range_select` | 13.20ms | 14.70ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 11.86ms | 14.08ms | 1.2× | 1.6% | PASS |
| ac_reads | `oltp_order_range` | 2.94ms | 3.39ms | 1.2× | 1.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.87ms | 4.62ms | 1.2× | 1.2% | PASS |
| ac_reads | `oltp_index_scan` | 6.15ms | 7.54ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 12.03ms | 13.72ms | 1.1× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 6.89ms | 7.28ms | 1.1× | 1.7% | PASS |
| ac_reads | `covering_index_scan` | 10.43ms | 12.87ms | 1.2× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 30.77ms | 35.77ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 7.17ms | 10.13ms | 1.4× | 1.2% | PASS |
| ac_reads | `index_join_scan` | 3.67ms | 6.10ms | 1.7× | 1.0% | PASS |
| ac_reads | `types_table_scan` | 1.05s | 1.26s | 1.2× | 0.4% | PASS |
| ac_reads | `table_scan` | 1.16s | 1.35s | 1.2× | 0.5% | PASS |
| ac_reads | `oltp_read_only` | 135.39ms | 155.09ms | 1.1× | 1.0% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 20.98ms | 65.51ms | 3.1× | 7.7% | PASS |
| ac_writes | `oltp_insert_ac` | 23.98ms | 77.39ms | 3.2× | 6.3% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.32ms | 90.20ms | 3.4× | 5.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.13ms | 72.68ms | 3.4× | 5.7% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.52ms | 78.82ms | 3.5× | 5.3% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.33ms | 79.17ms | 3.3× | 7.2% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.47ms | 71.95ms | 3.5× | 9.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 29.51ms | 87.69ms | 3.0× | 6.4% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.22ms | 29.46ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_range_select` | 14.04ms | 12.81ms | 0.9× | 1.0% | PASS |
| mem_reads | `oltp_sum_range` | 12.61ms | 12.07ms | 1.0× | 2.1% | PASS |
| mem_reads | `oltp_order_range` | 2.79ms | 2.81ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 3.62ms | 3.62ms | 1.0× | 1.6% | PASS |
| mem_reads | `oltp_index_scan` | 3.12ms | 5.20ms | 1.7× | 1.1% | PASS |
| mem_reads | `select_random_points` | 17.28ms | 17.23ms | 1.0× | 1.5% | PASS |
| mem_reads | `select_random_ranges` | 5.42ms | 5.09ms | 0.9× | 1.8% | PASS |
| mem_reads | `covering_index_scan` | 5.90ms | 8.22ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 30.15ms | 30.30ms | 1.0× | 1.1% | PASS |
| mem_reads | `index_join` | 10.22ms | 8.94ms | 0.9× | 4.3% | PASS |
| mem_reads | `index_join_scan` | 3.35ms | 5.96ms | 1.8× | 2.7% | PASS |
| mem_reads | `types_table_scan` | 927.78ms | 1.08s | 1.2× | 2.2% | PASS |
| mem_reads | `table_scan` | 1.02s | 1.14s | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 112.23ms | 111.36ms | 1.0× | 2.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 178.29ms | 262.75ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 13.74ms | 26.98ms | 2.0× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 54.24ms | 107.73ms | 2.0× | 2.8% | PASS |
| mem_writes | `oltp_update_non_index` | 39.23ms | 60.52ms | 1.5× | 1.4% | PASS |
| mem_writes | `oltp_delete_insert` | 44.32ms | 78.80ms | 1.8× | 1.8% | PASS |
| mem_writes | `oltp_write_only` | 22.89ms | 40.71ms | 1.8× | 1.7% | PASS |
| mem_writes | `types_delete_insert` | 31.13ms | 43.98ms | 1.4× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 76.21ms | 100.04ms | 1.3× | 2.5% | PASS |
| file_reads | `oltp_point_select` | 96.31ms | 45.46ms | 0.5× | 0.9% | PASS |
| file_reads | `oltp_range_select` | 21.96ms | 14.55ms | 0.7× | 1.0% | PASS |
| file_reads | `oltp_sum_range` | 20.36ms | 13.85ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 3.74ms | 3.08ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 4.59ms | 3.85ms | 0.8× | 0.9% | PASS |
| file_reads | `oltp_index_scan` | 10.36ms | 7.00ms | 0.7× | 1.3% | PASS |
| file_reads | `select_random_points` | 25.27ms | 19.19ms | 0.8× | 1.5% | PASS |
| file_reads | `select_random_ranges` | 12.73ms | 6.92ms | 0.5× | 0.9% | PASS |
| file_reads | `covering_index_scan` | 13.40ms | 10.04ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 31.18ms | 30.54ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 14.37ms | 9.91ms | 0.7× | 1.9% | PASS |
| file_reads | `index_join_scan` | 4.20ms | 6.10ms | 1.5× | 2.7% | PASS |
| file_reads | `types_table_scan` | 958.19ms | 1.07s | 1.1× | 3.5% | PASS |
| file_reads | `table_scan` | 1.09s | 1.16s | 1.1× | 2.6% | PASS |
| file_reads | `oltp_read_only` | 216.03ms | 136.34ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 264.81ms | 343.57ms | 1.3× | 6.0% | PASS |
| file_writes | `oltp_insert` | 33.87ms | 51.97ms | 1.5× | 8.4% | PASS |
| file_writes | `oltp_update_index` | 185.54ms | 201.49ms | 1.1× | 3.8% | PASS |
| file_writes | `oltp_update_non_index` | 159.20ms | 125.09ms | 0.8× | 4.3% | PASS |
| file_writes | `oltp_delete_insert` | 191.90ms | 152.02ms | 0.8× | 2.6% | PASS |
| file_writes | `oltp_write_only` | 129.08ms | 96.72ms | 0.7× | 12.0% | PASS |
| file_writes | `types_delete_insert` | 150.09ms | 90.80ms | 0.6× | 5.0% | PASS |
| file_writes | `oltp_read_write` | 183.26ms | 158.50ms | 0.9× | 6.1% | PASS |
| ac_reads | `oltp_point_select` | 49.09ms | 45.62ms | 0.9× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 17.18ms | 14.47ms | 0.8× | 1.1% | PASS |
| ac_reads | `oltp_sum_range` | 15.85ms | 13.95ms | 0.9× | 1.5% | PASS |
| ac_reads | `oltp_order_range` | 3.35ms | 3.07ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_distinct_range` | 4.07ms | 3.87ms | 0.9× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 5.78ms | 7.01ms | 1.2× | 1.4% | PASS |
| ac_reads | `select_random_points` | 21.45ms | 19.63ms | 0.9× | 2.0% | PASS |
| ac_reads | `select_random_ranges` | 8.13ms | 6.94ms | 0.9× | 1.0% | PASS |
| ac_reads | `covering_index_scan` | 8.58ms | 9.92ms | 1.2× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 29.95ms | 30.11ms | 1.0× | 1.0% | PASS |
| ac_reads | `index_join` | 11.36ms | 9.48ms | 0.8× | 2.0% | PASS |
| ac_reads | `index_join_scan` | 3.74ms | 6.21ms | 1.7× | 3.0% | PASS |
| ac_reads | `types_table_scan` | 1.13s | 1.13s | 1.0× | 0.7% | PASS |
| ac_reads | `table_scan` | 1.02s | 1.14s | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_read_only` | 141.35ms | 135.12ms | 1.0× | 1.3% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 18.91ms | 54.82ms | 2.9× | 11.9% | PASS |
| ac_writes | `oltp_insert_ac` | 20.79ms | 63.10ms | 3.0× | 7.1% | PASS |
| ac_writes | `oltp_update_index_ac` | 21.48ms | 76.05ms | 3.5× | 9.6% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.71ms | 62.15ms | 3.5× | 6.4% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 20.30ms | 70.79ms | 3.5× | 6.2% | PASS |
| ac_writes | `oltp_write_only_ac` | 20.10ms | 67.76ms | 3.4× | 7.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 19.12ms | 62.44ms | 3.3× | 11.8% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.41ms | 76.09ms | 2.9× | 8.1% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 28.63ms | 29.41ms | 1.0× | 3.1% | PASS |
| mem_reads | `oltp_range_select` | 15.15ms | 12.90ms | 0.9× | 2.8% | PASS |
| mem_reads | `oltp_sum_range` | 13.30ms | 12.15ms | 0.9× | 1.5% | PASS |
| mem_reads | `oltp_order_range` | 2.89ms | 2.85ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 3.64ms | 3.63ms | 1.0× | 0.8% | PASS |
| mem_reads | `oltp_index_scan` | 3.21ms | 5.23ms | 1.6× | 1.2% | PASS |
| mem_reads | `select_random_points` | 17.64ms | 17.11ms | 1.0× | 2.4% | PASS |
| mem_reads | `select_random_ranges` | 5.51ms | 5.11ms | 0.9× | 1.2% | PASS |
| mem_reads | `covering_index_scan` | 5.90ms | 8.19ms | 1.4× | 1.1% | PASS |
| mem_reads | `groupby_scan` | 29.02ms | 29.71ms | 1.0× | 0.9% | PASS |
| mem_reads | `index_join` | 8.96ms | 8.88ms | 1.0× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.14ms | 5.68ms | 1.8× | 2.3% | PASS |
| mem_reads | `types_table_scan` | 972.28ms | 1.10s | 1.1× | 3.7% | PASS |
| mem_reads | `table_scan` | 1.12s | 1.18s | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_read_only` | 113.34ms | 111.43ms | 1.0× | 2.0% | PASS |
| mem_writes | `oltp_bulk_insert` | 177.06ms | 260.59ms | 1.5× | 0.6% | PASS |
| mem_writes | `oltp_insert` | 14.12ms | 27.66ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_update_index` | 54.75ms | 108.03ms | 2.0× | 2.0% | PASS |
| mem_writes | `oltp_update_non_index` | 39.99ms | 59.67ms | 1.5× | 1.8% | PASS |
| mem_writes | `oltp_delete_insert` | 42.80ms | 78.59ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_write_only` | 23.79ms | 42.04ms | 1.8× | 2.0% | PASS |
| mem_writes | `types_delete_insert` | 31.46ms | 44.64ms | 1.4× | 1.6% | PASS |
| mem_writes | `oltp_read_write` | 78.27ms | 101.81ms | 1.3× | 1.9% | PASS |
| file_reads | `oltp_point_select` | 97.15ms | 45.52ms | 0.5× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 22.04ms | 14.32ms | 0.7× | 0.9% | PASS |
| file_reads | `oltp_sum_range` | 20.30ms | 13.67ms | 0.7× | 1.2% | PASS |
| file_reads | `oltp_order_range` | 3.64ms | 3.02ms | 0.8× | 0.9% | PASS |
| file_reads | `oltp_distinct_range` | 4.43ms | 3.80ms | 0.9× | 0.8% | PASS |
| file_reads | `oltp_index_scan` | 10.33ms | 6.86ms | 0.7× | 0.9% | PASS |
| file_reads | `select_random_points` | 25.24ms | 18.90ms | 0.7× | 1.1% | PASS |
| file_reads | `select_random_ranges` | 12.50ms | 6.83ms | 0.5× | 1.1% | PASS |
| file_reads | `covering_index_scan` | 13.24ms | 9.88ms | 0.7× | 0.7% | PASS |
| file_reads | `groupby_scan` | 29.83ms | 30.05ms | 1.0× | 0.7% | PASS |
| file_reads | `index_join` | 13.53ms | 9.92ms | 0.7× | 1.5% | PASS |
| file_reads | `index_join_scan` | 4.12ms | 5.82ms | 1.4× | 1.4% | PASS |
| file_reads | `types_table_scan` | 956.35ms | 1.10s | 1.2× | 2.7% | PASS |
| file_reads | `table_scan` | 1.17s | 1.22s | 1.0× | 1.0% | PASS |
| file_reads | `oltp_read_only` | 222.38ms | 139.30ms | 0.6× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 257.48ms | 333.66ms | 1.3× | 8.3% | PASS |
| file_writes | `oltp_insert` | 28.70ms | 46.30ms | 1.6× | 8.4% | PASS |
| file_writes | `oltp_update_index` | 167.46ms | 190.51ms | 1.1× | 8.5% | PASS |
| file_writes | `oltp_update_non_index` | 146.42ms | 118.42ms | 0.8× | 10.1% | PASS |
| file_writes | `oltp_delete_insert` | 165.01ms | 145.67ms | 0.9× | 6.6% | PASS |
| file_writes | `oltp_write_only` | 123.14ms | 105.78ms | 0.9× | 17.8% | PASS |
| file_writes | `types_delete_insert` | 116.85ms | 79.12ms | 0.7× | 16.9% | PASS |
| file_writes | `oltp_read_write` | 170.07ms | 154.64ms | 0.9× | 11.5% | PASS |
| ac_reads | `oltp_point_select` | 48.86ms | 45.34ms | 0.9× | 1.3% | PASS |
| ac_reads | `oltp_range_select` | 16.84ms | 14.29ms | 0.8× | 1.0% | PASS |
| ac_reads | `oltp_sum_range` | 15.44ms | 13.66ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_order_range` | 3.22ms | 3.02ms | 0.9× | 0.9% | PASS |
| ac_reads | `oltp_distinct_range` | 3.99ms | 3.80ms | 1.0× | 0.9% | PASS |
| ac_reads | `oltp_index_scan` | 5.72ms | 6.85ms | 1.2× | 1.0% | PASS |
| ac_reads | `select_random_points` | 20.08ms | 18.80ms | 0.9× | 1.3% | PASS |
| ac_reads | `select_random_ranges` | 7.83ms | 6.81ms | 0.9× | 0.9% | PASS |
| ac_reads | `covering_index_scan` | 8.54ms | 9.88ms | 1.2× | 0.8% | PASS |
| ac_reads | `groupby_scan` | 29.17ms | 29.86ms | 1.0× | 0.7% | PASS |
| ac_reads | `index_join` | 11.00ms | 9.79ms | 0.9× | 1.1% | PASS |
| ac_reads | `index_join_scan` | 3.66ms | 5.80ms | 1.6× | 1.6% | PASS |
| ac_reads | `types_table_scan` | 903.86ms | 1.07s | 1.2× | 2.0% | PASS |
| ac_reads | `table_scan` | 1.09s | 1.19s | 1.1× | 3.2% | PASS |
| ac_reads | `oltp_read_only` | 148.31ms | 137.00ms | 0.9× | 1.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 25.77ms | 61.88ms | 2.4× | 26.6% | PASS |
| ac_writes | `oltp_insert_ac` | 29.98ms | 91.43ms | 3.1× | 33.0% | PASS |
| ac_writes | `oltp_update_index_ac` | 32.00ms | 110.57ms | 3.5× | 42.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 23.70ms | 70.39ms | 3.0× | 36.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 27.81ms | 73.03ms | 2.6× | 13.1% | PASS |
| ac_writes | `oltp_write_only_ac` | 27.36ms | 81.03ms | 3.0× | 23.3% | PASS |
| ac_writes | `types_delete_insert_ac` | 21.29ms | 84.78ms | 4.0× | 28.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 34.23ms | 91.96ms | 2.7× | 20.4% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 20.57ms | 24.93ms | 1.2× | 1.5% | PASS |
| mem_reads | `oltp_range_select` | 13.60ms | 14.82ms | 1.1× | 1.5% | PASS |
| mem_reads | `oltp_sum_range` | 13.01ms | 13.90ms | 1.1× | 1.6% | PASS |
| mem_reads | `oltp_order_range` | 2.56ms | 2.77ms | 1.1× | 1.8% | PASS |
| mem_reads | `oltp_distinct_range` | 3.18ms | 3.46ms | 1.1× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 3.10ms | 4.43ms | 1.4× | 1.9% | PASS |
| mem_reads | `select_random_points` | 18.86ms | 22.52ms | 1.2× | 1.1% | PASS |
| mem_reads | `select_random_ranges` | 5.07ms | 6.00ms | 1.2× | 1.3% | PASS |
| mem_reads | `covering_index_scan` | 4.44ms | 6.53ms | 1.5× | 0.9% | PASS |
| mem_reads | `groupby_scan` | 23.83ms | 28.01ms | 1.2× | 1.2% | PASS |
| mem_reads | `index_join` | 5.62ms | 8.54ms | 1.5× | 2.2% | PASS |
| mem_reads | `index_join_scan` | 2.88ms | 5.07ms | 1.8× | 5.6% | PASS |
| mem_reads | `types_table_scan` | 770.22ms | 930.86ms | 1.2× | 1.9% | PASS |
| mem_reads | `table_scan` | 892.35ms | 1.02s | 1.1× | 3.4% | PASS |
| mem_reads | `oltp_read_only` | 95.55ms | 110.52ms | 1.2× | 1.2% | PASS |
| mem_writes | `oltp_bulk_insert` | 135.15ms | 195.75ms | 1.4× | 0.9% | PASS |
| mem_writes | `oltp_insert` | 11.48ms | 20.33ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_update_index` | 45.48ms | 86.30ms | 1.9× | 1.4% | PASS |
| mem_writes | `oltp_update_non_index` | 31.74ms | 54.23ms | 1.7× | 1.6% | PASS |
| mem_writes | `oltp_delete_insert` | 32.35ms | 61.00ms | 1.9× | 1.8% | PASS |
| mem_writes | `oltp_write_only` | 17.97ms | 36.56ms | 2.0× | 1.6% | PASS |
| mem_writes | `types_delete_insert` | 20.05ms | 33.89ms | 1.7× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 61.80ms | 95.62ms | 1.5× | 0.8% | PASS |
| file_reads | `oltp_point_select` | 42.17ms | 29.64ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_range_select` | 15.85ms | 15.41ms | 1.0× | 1.2% | PASS |
| file_reads | `oltp_sum_range` | 15.60ms | 14.58ms | 0.9× | 1.0% | PASS |
| file_reads | `oltp_order_range` | 2.79ms | 2.91ms | 1.0× | 2.1% | PASS |
| file_reads | `oltp_distinct_range` | 3.48ms | 3.58ms | 1.0× | 2.0% | PASS |
| file_reads | `oltp_index_scan` | 5.53ms | 5.21ms | 0.9× | 1.7% | PASS |
| file_reads | `select_random_points` | 21.27ms | 22.97ms | 1.1× | 1.4% | PASS |
| file_reads | `select_random_ranges` | 7.20ms | 6.53ms | 0.9× | 1.5% | PASS |
| file_reads | `covering_index_scan` | 6.85ms | 7.31ms | 1.1× | 1.3% | PASS |
| file_reads | `groupby_scan` | 24.25ms | 28.19ms | 1.2× | 0.8% | PASS |
| file_reads | `index_join` | 7.00ms | 8.83ms | 1.3× | 2.5% | PASS |
| file_reads | `index_join_scan` | 3.21ms | 5.43ms | 1.7× | 3.8% | PASS |
| file_reads | `types_table_scan` | 780.54ms | 937.87ms | 1.2× | 1.6% | PASS |
| file_reads | `table_scan` | 926.89ms | 1.04s | 1.1× | 4.3% | PASS |
| file_reads | `oltp_read_only` | 124.13ms | 118.48ms | 1.0× | 1.7% | PASS |
| file_writes | `oltp_bulk_insert` | 189.07ms | 251.29ms | 1.3× | 3.4% | PASS |
| file_writes | `oltp_insert` | 19.75ms | 32.00ms | 1.6× | 13.2% | PASS |
| file_writes | `oltp_update_index` | 140.32ms | 148.37ms | 1.1× | 2.4% | PASS |
| file_writes | `oltp_update_non_index` | 111.02ms | 98.62ms | 0.9× | 4.0% | PASS |
| file_writes | `oltp_delete_insert` | 105.90ms | 109.06ms | 1.0× | 5.8% | PASS |
| file_writes | `oltp_write_only` | 81.20ms | 78.63ms | 1.0× | 1.2% | PASS |
| file_writes | `types_delete_insert` | 70.32ms | 63.11ms | 0.9× | 6.5% | PASS |
| file_writes | `oltp_read_write` | 121.65ms | 137.22ms | 1.1× | 3.3% | PASS |
| ac_reads | `oltp_point_select` | 26.74ms | 28.73ms | 1.1× | 0.8% | PASS |
| ac_reads | `oltp_range_select` | 13.94ms | 14.99ms | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_sum_range` | 13.33ms | 14.10ms | 1.1× | 2.9% | PASS |
| ac_reads | `oltp_order_range` | 2.63ms | 2.81ms | 1.1× | 3.0% | PASS |
| ac_reads | `oltp_distinct_range` | 3.31ms | 3.54ms | 1.1× | 2.1% | PASS |
| ac_reads | `oltp_index_scan` | 4.17ms | 5.11ms | 1.2× | 2.3% | PASS |
| ac_reads | `select_random_points` | 20.01ms | 23.31ms | 1.2× | 1.9% | PASS |
| ac_reads | `select_random_ranges` | 5.88ms | 6.59ms | 1.1× | 1.6% | PASS |
| ac_reads | `covering_index_scan` | 5.53ms | 7.34ms | 1.3× | 1.9% | PASS |
| ac_reads | `groupby_scan` | 24.15ms | 28.21ms | 1.2× | 1.1% | PASS |
| ac_reads | `index_join` | 6.35ms | 8.97ms | 1.4× | 1.6% | PASS |
| ac_reads | `index_join_scan` | 3.07ms | 5.39ms | 1.8× | 5.1% | PASS |
| ac_reads | `types_table_scan` | 775.11ms | 925.96ms | 1.2× | 1.2% | PASS |
| ac_reads | `table_scan` | 919.24ms | 1.03s | 1.1× | 4.8% | PASS |
| ac_reads | `oltp_read_only` | 114.55ms | 124.44ms | 1.1× | 1.7% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 30.78ms | 83.42ms | 2.7× | 5.0% | PASS |
| ac_writes | `oltp_insert_ac` | 33.45ms | 96.69ms | 2.9× | 5.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 33.81ms | 104.23ms | 3.1× | 4.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 31.12ms | 91.30ms | 2.9× | 5.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 32.63ms | 99.05ms | 3.0× | 4.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 31.92ms | 96.65ms | 3.0× | 5.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 30.33ms | 91.78ms | 3.0× | 7.2% | PASS |
| ac_writes | `oltp_read_write_ac` | 37.08ms | 103.58ms | 2.8× | 6.3% | PASS |

</details>

</details>

## Version-control latency

Wall time: 6m 4s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 24.43ms | 38.00ms | 64.3% | 1.0% | PASS |
| `status_dirty_many_tables` | 27.23ms | 42.00ms | 64.8% | 1.3% | PASS |
| `diff_regular_working_one_table` | 21.23ms | 33.00ms | 64.3% | 2.0% | PASS |
| `diff_regular_working_many_tables` | 31.03ms | 50.00ms | 62.1% | 0.9% | PASS |
| `diff_stat_working_many_tables` | 31.33ms | 48.00ms | 65.3% | 1.7% | PASS |
| `diff_schema_working_many_tables` | 31.68ms | 48.00ms | 66.0% | 1.3% | PASS |
| `branch_list_many_branches` | 15.49ms | 25.00ms | 62.0% | 0.8% | PASS |
| `branch_create_delete` | 16.71ms | 27.00ms | 61.9% | 0.9% | PASS |
| `at_literal_deep_history` | 16.90ms | 28.00ms | 60.4% | 1.2% | PASS |
| `diff_literal_deep_history` | 16.93ms | 28.00ms | 60.5% | 1.0% | PASS |
| `history_literal_deep_history` | 18.12ms | 30.00ms | 60.4% | 0.9% | PASS |
| `checkout_branch_clean` | 23.66ms | 43.00ms | 55.0% | 0.9% | PASS |
| `merge_data_no_conflicts` | 19.52ms | 33.00ms | 59.2% | 1.3% | PASS |
| `merge_data_secondary_index` | 768.43ms | 944.00ms | 81.4% | 1.8% | PASS |
| `merge_schema_no_conflicts` | 14.89ms | 24.00ms | 62.0% | 2.2% | PASS |
| `merge_data_conflicts` | 22.21ms | 33.00ms | 67.3% | 1.5% | PASS |
| `merge_data_conflicts_with_resolve` | 22.94ms | 34.00ms | 67.5% | 1.2% | PASS |

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
| copy_fsync | candidate | 413.614 | 410.064–523.300 | 31.600 | 241.77 | 107968266 |
| push_initial | candidate | 775.613 | 767.841–780.977 | 395.543 | 128.93 | 107956772 |
| clone_initial | candidate | 897.793 | 890.045–969.572 | 518.258 | 111.38 | 108475035 |
| push_noop | candidate | 0.585 | 0.546–0.667 | 0.328 | — | 0 |
| fetch_noop | candidate | 0.200 | 0.180–0.225 | 0.206 | — | 0 |
| push_incremental | candidate | 203.434 | 192.707–206.946 | 166.103 | 4.92 | 7909775 |
| fetch_incremental | candidate | 121.776 | 112.791–179.374 | 72.050 | 8.21 | 7910084 |
| pull_fast_forward | candidate | 152.806 | 90.507–193.534 | 63.110 | 6.54 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.52 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.69 | 295.087 | 109.784 | 47240 | 2337 |
| push_noop | candidate | 45.82 | 0.075 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 45.82 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 45.82 | 96.867 | 7.910 | 22411 | 125 |
| fetch_incremental | candidate | 45.82 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 45.82 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5650.829 | 5508.328–5883.527 | 293.332 | 176.97 | 1087718031 |
| push_initial | candidate | 7736.421 | 7449.714–7736.657 | 3932.906 | 129.26 | 1079566275 |
| clone_initial | candidate | 9288.604 | 9151.301–9395.617 | 5470.566 | 107.66 | 1102407326 |
| push_noop | candidate | 0.654 | 0.602–0.665 | 0.306 | — | 0 |
| fetch_noop | candidate | 0.157 | 0.156–0.178 | 0.160 | — | 0 |
| push_incremental | candidate | 899.556 | 898.320–906.629 | 850.080 | 1.11 | 15806003 |
| fetch_incremental | candidate | 244.365 | 244.250–255.391 | 174.191 | 4.09 | 15806513 |
| pull_fast_forward | candidate | 240.948 | 223.690–251.792 | 171.434 | 4.15 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.81 | 2092.015 | 1087.622 | 263531 | 20541 |
| clone_initial | candidate | 124.05 | 3518.844 | 1132.819 | 612596 | 32243 |
| push_noop | candidate | 47.25 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.25 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 48.27 | 617.252 | 15.928 | 149933 | 313 |
| fetch_incremental | candidate | 50.41 | 61.906 | 15.928 | 13815 | 313 |
| pull_fast_forward | candidate | 50.41 | 61.839 | 15.929 | 13811 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
