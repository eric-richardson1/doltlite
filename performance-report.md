# DoltLite Performance Report

> Nightly result: **FAIL**
>
> Generated: 2026-11-04 19:20 UTC
>
> Commit: [`3dd9504feb5c1d0b4595f4dfd923c94d30ab2534`](https://github.com/dolthub/doltlite/commit/3dd9504feb5c1d0b4595f4dfd923c94d30ab2534)
>
> Runner: ubuntu26 20261026.180.1
>
> [GitHub Actions run](https://github.com/eric-richardson1/doltlite/actions/runs/41877535051)

The SQL workloads compare optimized DoltLite against stock SQLite on the same GitHub-hosted runner, alternating execution order on each repetition. Version-control sections measure DoltLite latency. Reported timings are medians. Paired-ratio noise is the median absolute deviation of the paired DoltLite/SQLite ratios, expressed as a percentage.

## SQL workload summary

The primary view aggregates all key shapes and compares DoltLite with SQLite by storage mode and operation class.

### In-memory

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 8.89s | 10.15s | 1.1× | 1.9% | **FAIL** |
| Writes | 1.81s | 2.97s | 1.6× | 1.6% | **PASS** |

### File-backed

| Operation | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---:|---:|---:|---:|---|
| Reads | 10.06s | 10.48s | 1.0× | 1.8% | **PASS** |
| Writes | 3.46s | 3.94s | 1.1× | 2.7% | **FAIL** |
| Autocommit writes | 727.30ms | 2.24s | 3.1× | 6.1% | **PASS** |

The absolute ceiling is 2.3× per ordinary workload and 1.9× for a section average. Durable autocommit writes use 5.5× and 5.0× ceilings respectively. A breach counts only when the median of the paired ratios exceeds the same ceiling.

<details>
<summary>Key-shape and individual-workload breakdown</summary>

The integer, text, blob, and composite primary-key runs verify that performance holds across key shapes.

| Storage | Operation | Key shape | Workloads | Samples/workload | SQLite median total | DoltLite median total | Ratio | Paired-ratio noise | Result |
|---|---|---|---:|---:|---:|---:|---:|---:|---|
| In-memory | Reads | int | 15 | 55 | 1.65s | 1.77s | 1.1× | 2.1% | **PASS** |
| In-memory | Reads | textpk | 15 | 55 | 1.74s | 1.92s | 1.1× | 2.4% | **FAIL** |
| In-memory | Reads | blobpk | 15 | 55 | 2.68s | 3.09s | 1.2× | 1.5% | **PASS** |
| In-memory | Reads | compositepk | 15 | 55 | 2.82s | 3.36s | 1.2× | 1.7% | **PASS** |
| In-memory | Writes | int | 8 | 55 | 271.01ms | 460.83ms | 1.7× | 2.0% | **PASS** |
| In-memory | Writes | textpk | 8 | 55 | 371.05ms | 590.69ms | 1.6× | 2.8% | **PASS** |
| In-memory | Writes | blobpk | 8 | 55 | 579.94ms | 935.85ms | 1.6× | 1.0% | **PASS** |
| In-memory | Writes | compositepk | 8 | 55 | 584.78ms | 978.54ms | 1.7× | 1.2% | **PASS** |
| File-backed | Reads | int | 15 | 55 | 1.86s | 1.80s | 1.0× | 2.2% | **PASS** |
| File-backed | Reads | textpk | 15 | 55 | 1.93s | 1.99s | 1.0× | 1.9% | **PASS** |
| File-backed | Reads | blobpk | 15 | 55 | 3.18s | 3.26s | 1.0× | 1.2% | **PASS** |
| File-backed | Reads | compositepk | 15 | 55 | 3.09s | 3.43s | 1.1× | 1.4% | **PASS** |
| File-backed | Writes | int | 8 | 55 | 753.34ms | 757.73ms | 1.0× | 4.6% | **PASS** |
| File-backed | Writes | textpk | 8 | 55 | 1.12s | 1.08s | 1.0× | 5.4% | **FAIL** |
| File-backed | Writes | blobpk | 8 | 55 | 819.55ms | 1.04s | 1.3× | 1.4% | **PASS** |
| File-backed | Writes | compositepk | 8 | 55 | 771.60ms | 1.06s | 1.4× | 1.8% | **PASS** |
| File-backed | Autocommit reads | int | 15 | 55 | 1.88s | 1.89s | 1.0× | 2.1% | **PASS** |
| File-backed | Autocommit reads | textpk | 15 | 55 | 1.80s | 1.98s | 1.1× | 2.4% | **PASS** |
| File-backed | Autocommit reads | blobpk | 15 | 55 | 3.10s | 3.31s | 1.1× | 1.4% | **PASS** |
| File-backed | Autocommit reads | compositepk | 15 | 55 | 2.76s | 3.41s | 1.2× | 1.5% | **PASS** |
| File-backed | Autocommit writes | int | 8 | 55 | 181.07ms | 508.18ms | 2.8× | 5.1% | **PASS** |
| File-backed | Autocommit writes | textpk | 8 | 55 | 194.74ms | 545.37ms | 2.8× | 6.5% | **PASS** |
| File-backed | Autocommit writes | blobpk | 8 | 55 | 157.75ms | 554.48ms | 3.5× | 5.9% | **PASS** |
| File-backed | Autocommit writes | compositepk | 8 | 55 | 193.74ms | 630.10ms | 3.3× | 6.7% | **PASS** |

<details>
<summary>int workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 16.54ms | 19.05ms | 1.2× | 2.4% | PASS |
| mem_reads | `oltp_range_select` | 6.61ms | 7.25ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_sum_range` | 6.37ms | 7.48ms | 1.2× | 2.8% | PASS |
| mem_reads | `oltp_order_range` | 1.75ms | 1.90ms | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_distinct_range` | 2.29ms | 2.54ms | 1.1× | 2.2% | PASS |
| mem_reads | `oltp_index_scan` | 2.60ms | 3.92ms | 1.5× | 2.1% | PASS |
| mem_reads | `select_random_points` | 9.40ms | 10.22ms | 1.1× | 4.6% | PASS |
| mem_reads | `select_random_ranges` | 3.00ms | 3.24ms | 1.1× | 1.7% | PASS |
| mem_reads | `covering_index_scan` | 4.11ms | 6.40ms | 1.6× | 1.9% | PASS |
| mem_reads | `groupby_scan` | 19.51ms | 21.85ms | 1.1× | 1.9% | PASS |
| mem_reads | `index_join` | 3.59ms | 6.50ms | 1.8× | 4.6% | PASS |
| mem_reads | `index_join_scan` | 2.52ms | 4.57ms | 1.8× | 6.2% | PASS |
| mem_reads | `types_table_scan` | 714.17ms | 766.52ms | 1.1× | 1.6% | PASS |
| mem_reads | `table_scan` | 800.66ms | 841.40ms | 1.1× | 1.7% | PASS |
| mem_reads | `oltp_read_only` | 60.44ms | 68.10ms | 1.1× | 1.9% | PASS |
| mem_writes | `oltp_bulk_insert` | 106.20ms | 173.71ms | 1.6× | 1.1% | PASS |
| mem_writes | `oltp_insert` | 9.16ms | 16.12ms | 1.8× | 1.6% | PASS |
| mem_writes | `oltp_update_index` | 32.37ms | 62.77ms | 1.9× | 2.3% | PASS |
| mem_writes | `oltp_update_non_index` | 23.88ms | 40.13ms | 1.7× | 2.1% | PASS |
| mem_writes | `oltp_delete_insert` | 28.28ms | 48.07ms | 1.7× | 1.9% | PASS |
| mem_writes | `oltp_write_only` | 14.04ms | 30.86ms | 2.2× | 1.8% | PASS |
| mem_writes | `types_delete_insert` | 16.43ms | 22.73ms | 1.4× | 2.3% | PASS |
| mem_writes | `oltp_read_write` | 40.64ms | 66.46ms | 1.6× | 2.4% | PASS |
| file_reads | `oltp_point_select` | 69.39ms | 32.70ms | 0.5× | 1.9% | PASS |
| file_reads | `oltp_range_select` | 12.30ms | 8.73ms | 0.7× | 3.3% | PASS |
| file_reads | `oltp_sum_range` | 11.85ms | 8.80ms | 0.7× | 1.6% | PASS |
| file_reads | `oltp_order_range` | 2.37ms | 2.06ms | 0.9× | 2.2% | PASS |
| file_reads | `oltp_distinct_range` | 2.83ms | 2.66ms | 0.9× | 1.4% | PASS |
| file_reads | `oltp_index_scan` | 8.21ms | 5.03ms | 0.6× | 2.0% | PASS |
| file_reads | `select_random_points` | 13.24ms | 10.13ms | 0.8× | 3.2% | PASS |
| file_reads | `select_random_ranges` | 8.36ms | 4.55ms | 0.5× | 2.2% | PASS |
| file_reads | `covering_index_scan` | 10.00ms | 7.46ms | 0.7× | 1.7% | PASS |
| file_reads | `groupby_scan` | 19.42ms | 21.45ms | 1.1× | 1.8% | PASS |
| file_reads | `index_join` | 6.89ms | 6.76ms | 1.0× | 4.6% | PASS |
| file_reads | `index_join_scan` | 3.02ms | 4.29ms | 1.4× | 3.3% | PASS |
| file_reads | `types_table_scan` | 709.54ms | 749.33ms | 1.1× | 2.0% | PASS |
| file_reads | `table_scan` | 845.70ms | 848.15ms | 1.0× | 2.7% | PASS |
| file_reads | `oltp_read_only` | 137.76ms | 88.72ms | 0.6× | 2.3% | PASS |
| file_writes | `oltp_bulk_insert` | 144.43ms | 219.86ms | 1.5× | 2.7% | PASS |
| file_writes | `oltp_insert` | 19.72ms | 27.25ms | 1.4× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 126.89ms | 117.22ms | 0.9× | 3.1% | PASS |
| file_writes | `oltp_update_non_index` | 100.99ms | 85.06ms | 0.8× | 4.6% | PASS |
| file_writes | `oltp_delete_insert` | 109.42ms | 99.12ms | 0.9× | 5.2% | PASS |
| file_writes | `oltp_write_only` | 80.98ms | 65.09ms | 0.8× | 4.5% | PASS |
| file_writes | `types_delete_insert` | 60.59ms | 46.08ms | 0.8× | 9.3% | PASS |
| file_writes | `oltp_read_write` | 110.32ms | 98.04ms | 0.9× | 8.4% | PASS |
| ac_reads | `oltp_point_select` | 33.92ms | 33.08ms | 1.0× | 2.1% | PASS |
| ac_reads | `oltp_range_select` | 8.77ms | 8.79ms | 1.0× | 3.4% | PASS |
| ac_reads | `oltp_sum_range` | 8.33ms | 8.80ms | 1.1× | 1.9% | PASS |
| ac_reads | `oltp_order_range` | 2.06ms | 2.09ms | 1.0× | 1.3% | PASS |
| ac_reads | `oltp_distinct_range` | 2.59ms | 2.73ms | 1.1× | 1.6% | PASS |
| ac_reads | `oltp_index_scan` | 5.03ms | 5.41ms | 1.1× | 1.4% | PASS |
| ac_reads | `select_random_points` | 10.81ms | 11.04ms | 1.0× | 4.9% | PASS |
| ac_reads | `select_random_ranges` | 5.06ms | 4.78ms | 0.9× | 1.3% | PASS |
| ac_reads | `covering_index_scan` | 6.89ms | 8.16ms | 1.2× | 2.1% | PASS |
| ac_reads | `groupby_scan` | 20.07ms | 22.33ms | 1.1× | 1.2% | PASS |
| ac_reads | `index_join` | 5.42ms | 7.76ms | 1.4× | 4.3% | PASS |
| ac_reads | `index_join_scan` | 2.85ms | 4.84ms | 1.7× | 8.4% | PASS |
| ac_reads | `types_table_scan` | 750.44ms | 787.45ms | 1.0× | 1.6% | PASS |
| ac_reads | `table_scan` | 926.82ms | 886.44ms | 1.0× | 2.2% | PASS |
| ac_reads | `oltp_read_only` | 91.70ms | 91.96ms | 1.0× | 2.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.47ms | 55.20ms | 2.6× | 8.5% | PASS |
| ac_writes | `oltp_insert_ac` | 22.61ms | 62.70ms | 2.8× | 4.8% | PASS |
| ac_writes | `oltp_update_index_ac` | 24.07ms | 71.12ms | 3.0× | 5.5% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.09ms | 58.61ms | 2.8× | 3.8% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 22.27ms | 64.68ms | 2.9× | 4.4% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.16ms | 66.24ms | 2.9× | 5.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.57ms | 60.31ms | 2.9× | 6.1% | PASS |
| ac_writes | `oltp_read_write_ac` | 25.84ms | 69.33ms | 2.7× | 4.6% | PASS |

</details>

<details>
<summary>textpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 27.28ms | 25.44ms | 0.9× | 3.4% | PASS |
| mem_reads | `oltp_range_select` | 12.18ms | 10.39ms | 0.9× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 12.04ms | 10.57ms | 0.9× | 3.9% | PASS |
| mem_reads | `oltp_order_range` | 2.52ms | 2.35ms | 0.9× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 3.03ms | 2.91ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_index_scan` | 2.77ms | 5.02ms | 1.8× | 2.2% | PASS |
| mem_reads | `select_random_points` | 20.52ms | 16.87ms | 0.8× | 2.5% | PASS |
| mem_reads | `select_random_ranges` | 4.93ms | 4.30ms | 0.9× | 2.5% | PASS |
| mem_reads | `covering_index_scan` | 4.10ms | 6.40ms | 1.6× | 1.2% | PASS |
| mem_reads | `groupby_scan` | 22.13ms | 22.60ms | 1.0× | 1.2% | PASS |
| mem_reads | `index_join` | 8.31ms | 7.58ms | 0.9× | 5.1% | PASS |
| mem_reads | `index_join_scan` | 2.25ms | 5.47ms | 2.4× | 3.5% | FAIL |
| mem_reads | `types_table_scan` | 728.20ms | 837.83ms | 1.2× | 1.0% | PASS |
| mem_reads | `table_scan` | 809.32ms | 888.33ms | 1.1× | 2.3% | PASS |
| mem_reads | `oltp_read_only` | 77.51ms | 78.27ms | 1.0× | 2.8% | PASS |
| mem_writes | `oltp_bulk_insert` | 134.64ms | 200.41ms | 1.5× | 1.9% | PASS |
| mem_writes | `oltp_insert` | 10.31ms | 22.44ms | 2.2× | 1.7% | PASS |
| mem_writes | `oltp_update_index` | 46.58ms | 93.87ms | 2.0× | 2.6% | PASS |
| mem_writes | `oltp_update_non_index` | 36.48ms | 52.96ms | 1.5× | 2.9% | PASS |
| mem_writes | `oltp_delete_insert` | 36.16ms | 67.22ms | 1.9× | 2.4% | PASS |
| mem_writes | `oltp_write_only` | 18.51ms | 34.79ms | 1.9× | 3.0% | PASS |
| mem_writes | `types_delete_insert` | 25.93ms | 37.02ms | 1.4× | 3.1% | PASS |
| mem_writes | `oltp_read_write` | 62.43ms | 81.98ms | 1.3× | 5.3% | PASS |
| file_reads | `oltp_point_select` | 76.50ms | 37.08ms | 0.5× | 2.3% | PASS |
| file_reads | `oltp_range_select` | 16.83ms | 11.14ms | 0.7× | 2.3% | PASS |
| file_reads | `oltp_sum_range` | 16.19ms | 10.94ms | 0.7× | 2.5% | PASS |
| file_reads | `oltp_order_range` | 2.92ms | 2.38ms | 0.8× | 1.9% | PASS |
| file_reads | `oltp_distinct_range` | 3.49ms | 2.88ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_index_scan` | 8.02ms | 5.77ms | 0.7× | 1.7% | PASS |
| file_reads | `select_random_points` | 21.32ms | 15.44ms | 0.7× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 10.06ms | 5.53ms | 0.6× | 1.9% | PASS |
| file_reads | `covering_index_scan` | 9.80ms | 7.69ms | 0.8× | 1.6% | PASS |
| file_reads | `groupby_scan` | 23.24ms | 22.07ms | 0.9× | 1.6% | PASS |
| file_reads | `index_join` | 11.40ms | 7.90ms | 0.7× | 2.3% | PASS |
| file_reads | `index_join_scan` | 3.34ms | 4.99ms | 1.5× | 1.8% | PASS |
| file_reads | `types_table_scan` | 706.35ms | 805.40ms | 1.1× | 1.5% | PASS |
| file_reads | `table_scan` | 846.11ms | 942.06ms | 1.1× | 1.8% | PASS |
| file_reads | `oltp_read_only` | 171.29ms | 106.42ms | 0.6× | 2.5% | PASS |
| file_writes | `oltp_bulk_insert` | 226.30ms | 290.33ms | 1.3× | 2.9% | PASS |
| file_writes | `oltp_insert` | 19.82ms | 46.04ms | 2.3× | 6.6% | FAIL |
| file_writes | `oltp_update_index` | 164.73ms | 190.02ms | 1.2× | 4.6% | PASS |
| file_writes | `oltp_update_non_index` | 134.44ms | 108.48ms | 0.8× | 6.7% | PASS |
| file_writes | `oltp_delete_insert` | 172.00ms | 138.44ms | 0.8× | 6.0% | PASS |
| file_writes | `oltp_write_only` | 112.95ms | 88.86ms | 0.8× | 4.1% | PASS |
| file_writes | `types_delete_insert` | 138.11ms | 79.62ms | 0.6× | 5.2% | PASS |
| file_writes | `oltp_read_write` | 151.63ms | 133.59ms | 0.9× | 5.7% | PASS |
| ac_reads | `oltp_point_select` | 40.44ms | 37.17ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_range_select` | 13.68ms | 11.48ms | 0.8× | 2.1% | PASS |
| ac_reads | `oltp_sum_range` | 13.11ms | 11.28ms | 0.9× | 2.4% | PASS |
| ac_reads | `oltp_order_range` | 2.74ms | 2.41ms | 0.9× | 2.2% | PASS |
| ac_reads | `oltp_distinct_range` | 3.25ms | 2.93ms | 0.9× | 2.4% | PASS |
| ac_reads | `oltp_index_scan` | 4.98ms | 6.02ms | 1.2× | 1.6% | PASS |
| ac_reads | `select_random_points` | 18.86ms | 15.88ms | 0.8× | 4.2% | PASS |
| ac_reads | `select_random_ranges` | 6.37ms | 5.58ms | 0.9× | 2.8% | PASS |
| ac_reads | `covering_index_scan` | 5.94ms | 7.68ms | 1.3× | 2.4% | PASS |
| ac_reads | `groupby_scan` | 22.04ms | 21.99ms | 1.0× | 1.5% | PASS |
| ac_reads | `index_join` | 9.39ms | 8.01ms | 0.9× | 6.0% | PASS |
| ac_reads | `index_join_scan` | 3.17ms | 5.14ms | 1.6× | 3.0% | PASS |
| ac_reads | `types_table_scan` | 713.91ms | 823.00ms | 1.2× | 1.9% | PASS |
| ac_reads | `table_scan` | 824.36ms | 916.45ms | 1.1× | 2.0% | PASS |
| ac_reads | `oltp_read_only` | 114.93ms | 103.60ms | 0.9× | 4.1% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 23.42ms | 60.22ms | 2.6× | 9.1% | PASS |
| ac_writes | `oltp_insert_ac` | 24.39ms | 65.28ms | 2.7× | 6.5% | PASS |
| ac_writes | `oltp_update_index_ac` | 25.49ms | 75.90ms | 3.0× | 7.2% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.89ms | 62.20ms | 2.8× | 4.6% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 24.51ms | 72.20ms | 2.9× | 6.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 23.76ms | 67.99ms | 2.9× | 6.1% | PASS |
| ac_writes | `types_delete_insert_ac` | 22.81ms | 67.02ms | 2.9× | 9.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 28.48ms | 74.55ms | 2.6× | 5.2% | PASS |

</details>

<details>
<summary>blobpk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 34.62ms | 36.18ms | 1.0× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 17.33ms | 15.57ms | 0.9× | 2.4% | PASS |
| mem_reads | `oltp_sum_range` | 15.96ms | 14.77ms | 0.9× | 1.7% | PASS |
| mem_reads | `oltp_order_range` | 3.44ms | 3.51ms | 1.0× | 1.5% | PASS |
| mem_reads | `oltp_distinct_range` | 4.44ms | 4.62ms | 1.0× | 1.3% | PASS |
| mem_reads | `oltp_index_scan` | 4.02ms | 6.36ms | 1.6× | 1.5% | PASS |
| mem_reads | `select_random_points` | 24.13ms | 21.36ms | 0.9× | 2.2% | PASS |
| mem_reads | `select_random_ranges` | 6.61ms | 6.33ms | 1.0× | 2.1% | PASS |
| mem_reads | `covering_index_scan` | 7.60ms | 10.41ms | 1.4× | 0.6% | PASS |
| mem_reads | `groupby_scan` | 36.99ms | 37.97ms | 1.0× | 0.7% | PASS |
| mem_reads | `index_join` | 10.50ms | 10.46ms | 1.0× | 2.0% | PASS |
| mem_reads | `index_join_scan` | 3.81ms | 6.49ms | 1.7× | 1.5% | PASS |
| mem_reads | `types_table_scan` | 1.12s | 1.33s | 1.2× | 0.7% | PASS |
| mem_reads | `table_scan` | 1.26s | 1.44s | 1.1× | 0.5% | PASS |
| mem_reads | `oltp_read_only` | 135.65ms | 140.55ms | 1.0× | 0.7% | PASS |
| mem_writes | `oltp_bulk_insert` | 233.66ms | 338.81ms | 1.5× | 0.8% | PASS |
| mem_writes | `oltp_insert` | 18.08ms | 36.64ms | 2.0× | 0.7% | PASS |
| mem_writes | `oltp_update_index` | 65.39ms | 136.01ms | 2.1× | 1.2% | PASS |
| mem_writes | `oltp_update_non_index` | 48.86ms | 78.46ms | 1.6× | 1.3% | PASS |
| mem_writes | `oltp_delete_insert` | 52.75ms | 101.94ms | 1.9× | 0.7% | PASS |
| mem_writes | `oltp_write_only` | 28.13ms | 55.87ms | 2.0× | 1.0% | PASS |
| mem_writes | `types_delete_insert` | 37.80ms | 57.42ms | 1.5× | 1.3% | PASS |
| mem_writes | `oltp_read_write` | 95.27ms | 130.70ms | 1.4× | 0.9% | PASS |
| file_reads | `oltp_point_select` | 121.79ms | 57.04ms | 0.5× | 0.7% | PASS |
| file_reads | `oltp_range_select` | 26.46ms | 17.73ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_sum_range` | 24.76ms | 16.93ms | 0.7× | 1.1% | PASS |
| file_reads | `oltp_order_range` | 4.46ms | 3.79ms | 0.8× | 1.2% | PASS |
| file_reads | `oltp_distinct_range` | 5.48ms | 4.89ms | 0.9× | 1.3% | PASS |
| file_reads | `oltp_index_scan` | 12.98ms | 8.60ms | 0.7× | 1.4% | PASS |
| file_reads | `select_random_points` | 32.87ms | 23.73ms | 0.7× | 2.8% | PASS |
| file_reads | `select_random_ranges` | 15.70ms | 8.59ms | 0.5× | 0.7% | PASS |
| file_reads | `covering_index_scan` | 16.97ms | 12.72ms | 0.7× | 0.9% | PASS |
| file_reads | `groupby_scan` | 37.86ms | 38.23ms | 1.0× | 0.8% | PASS |
| file_reads | `index_join` | 16.46ms | 11.94ms | 0.7× | 2.5% | PASS |
| file_reads | `index_join_scan` | 5.18ms | 6.95ms | 1.3× | 2.7% | PASS |
| file_reads | `types_table_scan` | 1.18s | 1.37s | 1.2× | 1.6% | PASS |
| file_reads | `table_scan` | 1.41s | 1.51s | 1.1× | 0.8% | PASS |
| file_reads | `oltp_read_only` | 267.71ms | 172.13ms | 0.6× | 1.2% | PASS |
| file_writes | `oltp_bulk_insert` | 257.66ms | 356.07ms | 1.4× | 1.0% | PASS |
| file_writes | `oltp_insert` | 25.21ms | 41.70ms | 1.7× | 1.4% | PASS |
| file_writes | `oltp_update_index` | 99.32ms | 155.15ms | 1.6× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 90.42ms | 91.64ms | 1.0× | 11.1% | PASS |
| file_writes | `oltp_delete_insert` | 88.92ms | 117.97ms | 1.3× | 1.3% | PASS |
| file_writes | `oltp_write_only` | 59.91ms | 68.38ms | 1.1× | 1.8% | PASS |
| file_writes | `types_delete_insert` | 66.40ms | 67.85ms | 1.0× | 1.5% | PASS |
| file_writes | `oltp_read_write` | 131.71ms | 144.95ms | 1.1× | 2.7% | PASS |
| ac_reads | `oltp_point_select` | 62.31ms | 57.20ms | 0.9× | 1.0% | PASS |
| ac_reads | `oltp_range_select` | 21.07ms | 17.83ms | 0.8× | 1.8% | PASS |
| ac_reads | `oltp_sum_range` | 19.32ms | 17.04ms | 0.9× | 1.4% | PASS |
| ac_reads | `oltp_order_range` | 3.95ms | 3.80ms | 1.0× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 4.94ms | 4.91ms | 1.0× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 7.29ms | 8.62ms | 1.2× | 1.3% | PASS |
| ac_reads | `select_random_points` | 27.73ms | 23.89ms | 0.9× | 2.2% | PASS |
| ac_reads | `select_random_ranges` | 9.73ms | 8.59ms | 0.9× | 0.8% | PASS |
| ac_reads | `covering_index_scan` | 11.01ms | 12.83ms | 1.2× | 1.0% | PASS |
| ac_reads | `groupby_scan` | 37.56ms | 38.48ms | 1.0× | 0.7% | PASS |
| ac_reads | `index_join` | 13.93ms | 12.08ms | 0.9× | 2.4% | PASS |
| ac_reads | `index_join_scan` | 4.75ms | 7.17ms | 1.5× | 2.3% | PASS |
| ac_reads | `types_table_scan` | 1.27s | 1.40s | 1.1× | 2.3% | PASS |
| ac_reads | `table_scan` | 1.41s | 1.52s | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_read_only` | 197.21ms | 181.49ms | 0.9× | 1.6% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 17.40ms | 53.08ms | 3.1× | 6.0% | PASS |
| ac_writes | `oltp_insert_ac` | 19.72ms | 70.83ms | 3.6× | 5.7% | PASS |
| ac_writes | `oltp_update_index_ac` | 20.70ms | 82.26ms | 4.0× | 5.1% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 17.05ms | 62.65ms | 3.7× | 7.5% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 19.25ms | 71.84ms | 3.7× | 5.5% | PASS |
| ac_writes | `oltp_write_only_ac` | 19.79ms | 71.77ms | 3.6× | 6.4% | PASS |
| ac_writes | `types_delete_insert_ac` | 17.74ms | 63.76ms | 3.6× | 7.4% | PASS |
| ac_writes | `oltp_read_write_ac` | 26.09ms | 78.30ms | 3.0× | 4.3% | PASS |

</details>

<details>
<summary>compositepk workload details</summary>

| Section | Workload | SQLite median | DoltLite median | Ratio | Paired-ratio noise | Result |
|---|---|---:|---:|---:|---:|---|
| mem_reads | `oltp_point_select` | 33.94ms | 42.71ms | 1.3× | 1.7% | PASS |
| mem_reads | `oltp_range_select` | 19.82ms | 23.68ms | 1.2× | 1.9% | PASS |
| mem_reads | `oltp_sum_range` | 17.73ms | 22.67ms | 1.3× | 1.4% | PASS |
| mem_reads | `oltp_order_range` | 3.63ms | 4.25ms | 1.2× | 1.3% | PASS |
| mem_reads | `oltp_distinct_range` | 4.59ms | 5.46ms | 1.2× | 1.0% | PASS |
| mem_reads | `oltp_index_scan` | 4.53ms | 6.59ms | 1.5× | 1.6% | PASS |
| mem_reads | `select_random_points` | 26.64ms | 32.26ms | 1.2× | 2.5% | PASS |
| mem_reads | `select_random_ranges` | 7.61ms | 9.36ms | 1.2× | 1.9% | PASS |
| mem_reads | `covering_index_scan` | 7.95ms | 11.22ms | 1.4× | 0.8% | PASS |
| mem_reads | `groupby_scan` | 37.09ms | 43.31ms | 1.2× | 0.6% | PASS |
| mem_reads | `index_join` | 7.94ms | 12.15ms | 1.5× | 1.7% | PASS |
| mem_reads | `index_join_scan` | 3.97ms | 6.76ms | 1.7× | 2.3% | PASS |
| mem_reads | `types_table_scan` | 1.15s | 1.43s | 1.2× | 2.2% | PASS |
| mem_reads | `table_scan` | 1.34s | 1.53s | 1.1× | 2.0% | PASS |
| mem_reads | `oltp_read_only` | 157.66ms | 189.18ms | 1.2× | 1.1% | PASS |
| mem_writes | `oltp_bulk_insert` | 239.87ms | 352.05ms | 1.5× | 0.7% | PASS |
| mem_writes | `oltp_insert` | 18.64ms | 34.54ms | 1.9× | 1.0% | PASS |
| mem_writes | `oltp_update_index` | 66.64ms | 129.21ms | 1.9× | 1.5% | PASS |
| mem_writes | `oltp_update_non_index` | 50.88ms | 89.04ms | 1.8× | 1.1% | PASS |
| mem_writes | `oltp_delete_insert` | 48.61ms | 97.19ms | 2.0× | 1.2% | PASS |
| mem_writes | `oltp_write_only` | 26.66ms | 58.89ms | 2.2× | 1.4% | PASS |
| mem_writes | `types_delete_insert` | 31.96ms | 56.53ms | 1.8× | 1.2% | PASS |
| mem_writes | `oltp_read_write` | 101.52ms | 161.09ms | 1.6× | 1.6% | PASS |
| file_reads | `oltp_point_select` | 101.74ms | 60.15ms | 0.6× | 1.3% | PASS |
| file_reads | `oltp_range_select` | 27.36ms | 25.74ms | 0.9× | 1.9% | PASS |
| file_reads | `oltp_sum_range` | 25.15ms | 25.03ms | 1.0× | 1.5% | PASS |
| file_reads | `oltp_order_range` | 4.54ms | 4.56ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_distinct_range` | 5.55ms | 5.78ms | 1.0× | 1.1% | PASS |
| file_reads | `oltp_index_scan` | 11.84ms | 8.70ms | 0.7× | 2.2% | PASS |
| file_reads | `select_random_points` | 34.98ms | 35.43ms | 1.0× | 1.9% | PASS |
| file_reads | `select_random_ranges` | 14.87ms | 11.43ms | 0.8× | 1.4% | PASS |
| file_reads | `covering_index_scan` | 15.55ms | 13.20ms | 0.8× | 1.3% | PASS |
| file_reads | `groupby_scan` | 38.25ms | 43.76ms | 1.1× | 0.6% | PASS |
| file_reads | `index_join` | 12.22ms | 13.32ms | 1.1× | 1.8% | PASS |
| file_reads | `index_join_scan` | 4.87ms | 7.01ms | 1.4× | 2.2% | PASS |
| file_reads | `types_table_scan` | 1.17s | 1.43s | 1.2× | 1.0% | PASS |
| file_reads | `table_scan` | 1.37s | 1.53s | 1.1× | 2.8% | PASS |
| file_reads | `oltp_read_only` | 258.96ms | 217.27ms | 0.8× | 0.9% | PASS |
| file_writes | `oltp_bulk_insert` | 255.07ms | 365.63ms | 1.4× | 0.9% | PASS |
| file_writes | `oltp_insert` | 25.88ms | 38.47ms | 1.5× | 1.2% | PASS |
| file_writes | `oltp_update_index` | 96.49ms | 142.92ms | 1.5× | 1.4% | PASS |
| file_writes | `oltp_update_non_index` | 78.91ms | 98.29ms | 1.2× | 1.8% | PASS |
| file_writes | `oltp_delete_insert` | 79.16ms | 112.79ms | 1.4× | 1.7% | PASS |
| file_writes | `oltp_write_only` | 52.48ms | 67.01ms | 1.3× | 2.4% | PASS |
| file_writes | `types_delete_insert` | 50.43ms | 63.59ms | 1.3× | 2.0% | PASS |
| file_writes | `oltp_read_write` | 133.18ms | 172.58ms | 1.3× | 1.8% | PASS |
| ac_reads | `oltp_point_select` | 56.49ms | 60.25ms | 1.1× | 1.5% | PASS |
| ac_reads | `oltp_range_select` | 22.80ms | 25.78ms | 1.1× | 1.4% | PASS |
| ac_reads | `oltp_sum_range` | 20.29ms | 24.92ms | 1.2× | 1.3% | PASS |
| ac_reads | `oltp_order_range` | 4.05ms | 4.55ms | 1.1× | 1.0% | PASS |
| ac_reads | `oltp_distinct_range` | 5.04ms | 5.79ms | 1.1× | 1.1% | PASS |
| ac_reads | `oltp_index_scan` | 7.36ms | 8.75ms | 1.2× | 2.5% | PASS |
| ac_reads | `select_random_points` | 29.71ms | 36.04ms | 1.2× | 2.7% | PASS |
| ac_reads | `select_random_ranges` | 10.20ms | 11.48ms | 1.1× | 1.5% | PASS |
| ac_reads | `covering_index_scan` | 10.73ms | 13.14ms | 1.2× | 1.8% | PASS |
| ac_reads | `groupby_scan` | 37.20ms | 43.42ms | 1.2× | 0.7% | PASS |
| ac_reads | `index_join` | 9.47ms | 13.16ms | 1.4× | 1.3% | PASS |
| ac_reads | `index_join_scan` | 4.35ms | 6.97ms | 1.6× | 2.1% | PASS |
| ac_reads | `types_table_scan` | 1.11s | 1.42s | 1.3× | 2.6% | PASS |
| ac_reads | `table_scan` | 1.24s | 1.51s | 1.2× | 2.9% | PASS |
| ac_reads | `oltp_read_only` | 190.57ms | 217.06ms | 1.1× | 1.5% | PASS |
| ac_writes | `oltp_bulk_insert_ac` | 21.79ms | 64.00ms | 2.9× | 8.4% | PASS |
| ac_writes | `oltp_insert_ac` | 23.95ms | 78.23ms | 3.3× | 7.2% | PASS |
| ac_writes | `oltp_update_index_ac` | 26.56ms | 89.83ms | 3.4× | 5.8% | PASS |
| ac_writes | `oltp_update_non_index_ac` | 21.91ms | 72.57ms | 3.3× | 6.3% | PASS |
| ac_writes | `oltp_delete_insert_ac` | 23.80ms | 82.62ms | 3.5× | 5.9% | PASS |
| ac_writes | `oltp_write_only_ac` | 24.69ms | 81.13ms | 3.3× | 7.7% | PASS |
| ac_writes | `types_delete_insert_ac` | 20.55ms | 73.38ms | 3.6× | 7.5% | PASS |
| ac_writes | `oltp_read_write_ac` | 30.49ms | 88.34ms | 2.9× | 6.1% | PASS |

</details>

</details>

## Version-control latency

Wall time: 2m 28s. Samples per benchmark: 101.

| Benchmark | Median | Ceiling | Ceiling used | MAD | Result |
|---|---:|---:|---:|---:|---|
| `status_clean_many_tables` | 20.44ms | 38.00ms | 53.8% | 0.7% | PASS |
| `status_dirty_many_tables` | 23.03ms | 42.00ms | 54.8% | 0.7% | PASS |
| `diff_regular_working_one_table` | 17.59ms | 33.00ms | 53.3% | 1.3% | PASS |
| `diff_regular_working_many_tables` | 25.32ms | 50.00ms | 50.6% | 0.6% | PASS |
| `diff_stat_working_many_tables` | 25.47ms | 48.00ms | 53.1% | 0.8% | PASS |
| `diff_schema_working_many_tables` | 25.74ms | 48.00ms | 53.6% | 0.8% | PASS |
| `branch_list_many_branches` | 12.44ms | 25.00ms | 49.7% | 1.0% | PASS |
| `branch_create_delete` | 12.62ms | 27.00ms | 46.7% | 0.9% | PASS |
| `at_literal_deep_history` | 13.50ms | 28.00ms | 48.2% | 1.0% | PASS |
| `diff_literal_deep_history` | 13.26ms | 28.00ms | 47.4% | 1.2% | PASS |
| `history_literal_deep_history` | 13.97ms | 30.00ms | 46.6% | 1.0% | PASS |
| `checkout_branch_clean` | 19.23ms | 43.00ms | 44.7% | 0.5% | PASS |
| `merge_data_no_conflicts` | 14.62ms | 33.00ms | 44.3% | 0.5% | PASS |
| `merge_data_secondary_index` | 585.72ms | 944.00ms | 62.0% | 0.9% | PASS |
| `merge_schema_no_conflicts` | 11.24ms | 24.00ms | 46.8% | 1.2% | PASS |
| `merge_data_conflicts` | 17.28ms | 33.00ms | 52.4% | 0.6% | PASS |
| `merge_data_conflicts_with_resolve` | 17.99ms | 34.00ms | 52.9% | 0.6% | PASS |

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
| copy_fsync | candidate | 35.846 | 35.002–35.975 | 35.850 | 2789.71 | 107968266 |
| push_initial | candidate | 329.200 | 327.505–329.589 | 328.755 | 303.77 | 107956772 |
| clone_initial | candidate | 425.359 | 424.035–428.245 | 425.336 | 235.10 | 108475035 |
| push_noop | candidate | 0.141 | 0.137–0.164 | 0.142 | — | 0 |
| fetch_noop | candidate | 0.103 | 0.096–0.116 | 0.106 | — | 0 |
| push_incremental | candidate | 135.420 | 134.906–136.518 | 135.410 | 7.38 | 7909775 |
| fetch_incremental | candidate | 57.192 | 56.283–57.991 | 57.177 | 17.48 | 7910084 |
| pull_fast_forward | candidate | 51.303 | 49.987–51.742 | 51.303 | 19.49 | 7910844 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 90.54 | 175.487 | 108.763 | 18329 | 2066 |
| clone_initial | candidate | 90.75 | 295.183 | 109.784 | 47263 | 2337 |
| push_noop | candidate | 46.10 | 0.073 | 0.000 | 26 | 2 |
| fetch_noop | candidate | 46.10 | 0.135 | 0.000 | 40 | 0 |
| push_incremental | candidate | 46.10 | 96.920 | 7.910 | 22424 | 125 |
| fetch_incremental | candidate | 46.10 | 34.472 | 7.910 | 10808 | 124 |
| pull_fast_forward | candidate | 46.10 | 26.497 | 7.911 | 7031 | 126 |

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
| copy_fsync | candidate | 5574.465 | 5511.884–5587.537 | 313.003 | 179.39 | 1087718031 |
| push_initial | candidate | 8042.806 | 8024.947–8060.546 | 4263.282 | 124.33 | 1079566275 |
| clone_initial | candidate | 10634.102 | 9986.497–11378.857 | 6124.661 | 94.04 | 1102407326 |
| push_noop | candidate | 0.614 | 0.581–0.740 | 0.327 | — | 0 |
| fetch_noop | candidate | 0.197 | 0.169–0.199 | 0.200 | — | 0 |
| push_incremental | candidate | 992.983 | 992.388–999.556 | 938.215 | 1.01 | 15806003 |
| fetch_incremental | candidate | 276.755 | 272.455–310.308 | 220.559 | 3.61 | 15806513 |
| pull_fast_forward | candidate | 277.356 | 273.235–285.248 | 220.317 | 3.61 | 15807273 |

<details>
<summary>Memory and file I/O</summary>

Successful VFS bytes and VFS requests cover local and remote files during the operation; they include OS-cache hits and are not physical disk traffic. Peak RSS covers the fresh SQL process, including database open. The Python copy control is not instrumented.

| Operation | Binary | Peak RSS MiB | Read MB | Written MB | Read requests | Write requests |
|---|---|---:|---:|---:|---:|---:|
| push_initial | candidate | 134.75 | 2092.390 | 1087.622 | 263623 | 20541 |
| clone_initial | candidate | 124.02 | 3516.982 | 1132.819 | 612143 | 32243 |
| push_noop | candidate | 47.10 | 0.078 | 0.000 | 27 | 2 |
| fetch_noop | candidate | 47.10 | 0.137 | 0.000 | 40 | 0 |
| push_incremental | candidate | 47.10 | 615.537 | 15.928 | 149522 | 313 |
| fetch_incremental | candidate | 50.43 | 62.541 | 15.928 | 13971 | 313 |
| pull_fast_forward | candidate | 50.32 | 62.474 | 15.929 | 13967 | 315 |

</details>


</details>

## Reproducing

The workload definitions live in `test/sysbench_compare*.sh`, `test/vc_perf_ceiling.sh`, and `test/remote_perf.py`. The nightly workflow retains the complete raw samples and generated reports as Actions artifacts for 30 days.
