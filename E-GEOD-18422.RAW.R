 #############################################################
> # E-GEOD-18422 — STEP 1: DOWNLOAD + METADATA INSPECTION
> # Radioprotection study, 8.5 Gy, n=8
> # This tests whether a protective agent changes radiation response —
> # a different question than pure dose-response. Inspect design carefully.
> # Run top to bottom in a FRESH R session.
> #############################################################
> 
> ## ---- 0. PACKAGES ----
> if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
> BiocManager::install(c("GEOquery", "limma", "Biobase"), update = FALSE, ask = FALSE)
'getOption("repos")' replaces Bioconductor standard repositories, see
'help("repositories", package = "BiocManager")' for details.
Replacement repositories:
    CRAN: https://cran.rstudio.com/
Bioconductor version 3.23 (BiocManager 1.30.27), R 4.6.0 (2026-04-24 ucrt)
Warning message:
package(s) not installed when version(s) same as or greater than current; use
  `force = TRUE` to re-install: 'GEOquery' 'limma' 'Biobase' 
> if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
> 
> library(GEOquery); library(limma); library(Biobase); library(ggplot2)
> if (!dir.exists("figures")) dir.create("figures")
> 
> ## ---- 1. DOWNLOAD ----
> geo_data <- getGEO("GSE18422", GSEMatrix = TRUE)
Found 2 file(s)
GSE18422-GPL9355_series_matrix.txt.gz
GSE18422-GPL9356_series_matrix.txt.gz
> stopifnot(class(geo_data) == "list")
> cat("Number of platform objects:", length(geo_data), "\n")
Number of platform objects: 2 
> print(names(geo_data))
[1] "GSE18422-GPL9355_series_matrix.txt.gz" "GSE18422-GPL9356_series_matrix.txt.gz"
> for (i in seq_along(geo_data)) {
+     cat("\n--- Object", i, "---\n")
+     cat("Samples:", ncol(exprs(geo_data[[i]])), "| Features:", nrow(exprs(geo_data[[i]])), "\n")
+ }

--- Object 1 ---
Samples: 4 | Features: 19700 

--- Object 2 ---
Samples: 4 | Features: 19700 
> 
> gse <- geo_data[[1]]
> stopifnot(class(gse) == "ExpressionSet")
> cat("\n[TENTATIVE] Object 1:", nrow(exprs(gse)), "features,", ncol(exprs(gse)), "samples\n")

[TENTATIVE] Object 1: 19700 features, 4 samples
> cat("Manifest expected n=8\n")
Manifest expected n=8
> 
> ## ---- 2. CHECK RAW SCALE (learn from E-GEOD-701 - check for negatives first) ----
> raw_range <- range(exprs(gse), na.rm = TRUE)
> cat("\nRaw expression range:", raw_range, "\n")

Raw expression range: -7.6422 12.773 
> cat("Negative values present:", sum(exprs(gse) < 0, na.rm = TRUE), "of", length(exprs(gse)), "\n")
Negative values present: 47699 of 78800 
> 
> if (raw_range[1] < 0) {
+     cat("WARNING: negative values present — do NOT log2 transform yet.\n")
+     cat("This may be background-subtracted data (like E-GEOD-701) or already-log data.\n")
+ } else if (raw_range[2] > 100) {
+     exprs(gse) <- log2(exprs(gse))
+     cat("Applied log2 transform (no negatives, large positive range).\n")
+ } else {
+     cat("Data already log-scale — no transform applied.\n")
+ }
WARNING: negative values present — do NOT log2 transform yet.
This may be background-subtracted data (like E-GEOD-701) or already-log data.
> 
> ## ---- 3. INSPECT METADATA ----
> metadata <- pData(gse)
> cat("\nAvailable metadata columns:\n"); print(colnames(metadata))

Available metadata columns:
 [1] "title"                   "geo_accession"           "status"                 
 [4] "submission_date"         "last_update_date"        "type"                   
 [7] "channel_count"           "source_name_ch1"         "organism_ch1"           
[10] "characteristics_ch1"     "characteristics_ch1.1"   "treatment_protocol_ch1" 
[13] "molecule_ch1"            "extract_protocol_ch1"    "label_ch1"              
[16] "label_protocol_ch1"      "taxid_ch1"               "hyb_protocol"           
[19] "scan_protocol"           "description"             "data_processing"        
[22] "platform_id"             "contact_name"            "contact_email"          
[25] "contact_laboratory"      "contact_department"      "contact_institute"      
[28] "contact_address"         "contact_city"            "contact_state"          
[31] "contact_zip/postal_code" "contact_country"         "supplementary_file"     
[34] "data_row_count"          "cell line:ch1"           "cell type:ch1"          
> cat("\nAll sample titles:\n"); print(metadata$title)

All sample titles:
[1] "Control"    "50uM"       "8.5 Gy"     "50uM+8.5Gy"
> 
> char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
> cat("\nCharacteristics fields:\n")

Characteristics fields:
> for (cc in char_cols) {
+     cat("\n--", cc, "unique values:\n")
+     print(unique(metadata[[cc]]))
+ }

-- characteristics_ch1 unique values:
[1] "cell line: U87"

-- characteristics_ch1.1 unique values:
[1] "cell type: glioma"
> 
> cat("\nData processing notes:\n"); cat(metadata$data_processing[1], "\n")

Data processing notes:
Initial dataset that consisted of 40,320 probes was filtered to exclude QC probes and empty spots.The data was transformed using log-transformation (log2) and median absolute deviation was performed. An exploratory approach consisting of two-stages to detect outliers from bivariate population and determining differentially expressed candidates from these outliers.The approach provides the fold-change value considering the scatter of observations and thereby provides up and down regulated genes across samples. Thus, for functional classification, differentially expressed genes were identified by Multivariate Outlier Detection Method. 
> 
> ## ---- 4. GENE ANNOTATION CHECK ----
> feature_info <- fData(gse)
> cat("\nFeature/annotation columns:\n"); print(colnames(feature_info))

Feature/annotation columns:
[1] "ID"       "ORF"      "SEQUENCE" "GB_ACC"  
> ## Use exact "Gene Symbol" if present (learned from E-GEOD-701 auto-detect mistake)
> symbol_col <- if ("Gene Symbol" %in% colnames(feature_info)) "Gene Symbol" else
+     colnames(feature_info)[grep("symbol", colnames(feature_info), ignore.case = TRUE)][1]
> cat("Using symbol column:", symbol_col, "\n")
Using symbol column: NA 
> if (!is.na(symbol_col)) {
+     print(head(feature_info[[symbol_col]], 15))
+     canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
+     cat("\nDirect canonical gene check:\n")
+     for (g in canon_genes) {
+         cat(g, "found:", sum(feature_info[[symbol_col]] == g, na.rm = TRUE), "times\n")
+     }
+ } else {
+     cat("WARNING: no symbol column found — inspect manually:\n")
+     print(head(feature_info, 5))
+ }
WARNING: no symbol column found — inspect manually:
                                 ID    ORF
obshum40K:A#00001 obshum40K:A#00001  ACTN2
obshum40K:A#00002 obshum40K:A#00002 GUCY2D
obshum40K:A#00003 obshum40K:A#00003   ANK3
obshum40K:A#00004 obshum40K:A#00004  HNRPL
obshum40K:A#00005 obshum40K:A#00005 BTN2A3
                                                            SEQUENCE      GB_ACC
obshum40K:A#00001 AGGAAGAATGGCCTGATGGATCATGAGGATTTCAGAGCCTGCCTGATTTC NM_001103.1
obshum40K:A#00002 GGCAGACGCGGCTTCAACAAGCCCATCCCCAAACCGCCTGACCTGCAACC NM_000180.1
obshum40K:A#00003 CAAAAGCAGGGAGAAGGTTTTAAGGTGAAAACGAAGAAAGAAATCCGGCA  BX648574.1
obshum40K:A#00004 GTCCATACCCTTACACTCTGAAGTTGTGTTTCTCCACTGCTCAGCACGCC  BC069184.1
obshum40K:A#00005 GAAAAAAAAGATTCTCATCTCATGACATTCAACCTCTGTCTGTCCCTTGC NM_024018.1
> 
> ## ---- 5. SAVE + SESSION INFO ----
> sample_info_raw <- data.frame(Sample_ID = metadata$geo_accession, Title = metadata$title)
> write.csv(sample_info_raw, "E-GEOD-18422_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)
> writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-18422_STEP1.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 1 COMPLETE. STOP HERE. Paste back everything above.\n")
STEP 1 COMPLETE. STOP HERE. Paste back everything above.
> cat("===========================================\n")
===========================================
> symbol_col <- "ORF"
> canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
> cat("Canonical gene check on ORF column:\n")
Canonical gene check on ORF column:
> for (g in canon_genes) {
+     cat(g, "found:", sum(feature_info[[symbol_col]] == g, na.rm = TRUE), "times\n")
+ }
BAX found: 2 times
CDKN1A found: 2 times
DDB2 found: 1 times
FDXR found: 1 times
GADD45A found: 1 times
MDM2 found: 7 times
> metadata2 <- pData(geo_data[[2]])
> cat("Object 2 titles:\n")
Object 2 titles:
> print(metadata2$title)
[1] "Control"    "50uM"       "8.5 Gy"     "50uM+8.5Gy"
> #############################################################
> # E-GEOD-18422 — STEP 2: FORMAL RADIOPROTECTION MODEL
> # Run in the SAME session (needs: geo_data, gse, feature_info)
> # 2x2 design: Drug(50uM) x Radiation(8.5Gy), n=2 per condition
> # (combining both platform objects as biological replicates)
> # U87 glioma cells. Data already log2-transformed by submitters - do NOT re-log.
> #############################################################
> 
> library(limma); library(ggplot2); library(reshape2)
Warning message:
package ‘reshape2’ was built under R version 4.6.1 
> 
> ## ---- 1. VERIFY BOTH OBJECTS HAVE IDENTICAL STRUCTURE BEFORE COMBINING ----
> gse1 <- geo_data[[1]]
> gse2 <- geo_data[[2]]
> stopifnot(identical(pData(gse1)$title, pData(gse2)$title))
> stopifnot(nrow(exprs(gse1)) == nrow(exprs(gse2)))
> cat("Both objects confirmed same 4 conditions, same feature count:", nrow(exprs(gse1)), "\n")
Both objects confirmed same 4 conditions, same feature count: 19700 
> 
> ## ---- 2. CONFIRM PROBE IDs MATCH BEFORE COMBINING (don't assume row order aligns) ----
> stopifnot(identical(rownames(exprs(gse1)), rownames(exprs(gse2))))
Error: identical(rownames(exprs(gse1)), rownames(exprs(gse2))) is not TRUE

> cat("Object 1 probe count:", length(rownames(exprs(gse1))), "\n")
Object 1 probe count: 19700 
> cat("Object 2 probe count:", length(rownames(exprs(gse2))), "\n")
Object 2 probe count: 19700 
> 
> cat("\nFirst 10 probe IDs, Object 1:\n")

First 10 probe IDs, Object 1:
> print(head(rownames(exprs(gse1)), 10))
 [1] "obshum40K:A#00001" "obshum40K:A#00002" "obshum40K:A#00003"
 [4] "obshum40K:A#00004" "obshum40K:A#00005" "obshum40K:A#00006"
 [7] "obshum40K:A#00007" "obshum40K:A#00008" "obshum40K:A#00009"
[10] "obshum40K:A#00010"
> cat("\nFirst 10 probe IDs, Object 2:\n")

First 10 probe IDs, Object 2:
> print(head(rownames(exprs(gse2)), 10))
 [1] "obshum40K:B#00020" "obshum40K:B#00062" "obshum40K:B#00098"
 [4] "obshum40K:B#00104" "obshum40K:B#00138" "obshum40K:B#00172"
 [7] "obshum40K:B#00173" "obshum40K:B#00211" "obshum40K:B#00221"
[10] "obshum40K:B#00229"
> 
> cat("\nHow many probe IDs are shared between the two objects:\n")

How many probe IDs are shared between the two objects:
> print(length(intersect(rownames(exprs(gse1)), rownames(exprs(gse2)))))
[1] 0
> 
> cat("\nAre they the same SET, just different ORDER?\n")

Are they the same SET, just different ORDER?
> print(setequal(rownames(exprs(gse1)), rownames(exprs(gse2))))
[1] FALSE
> # Correct approach: these are complementary probe sets for the SAME 4 samples,
> # not two replicate sets. Confirm sample correspondence first:
> cat("Object 1 sample titles:\n"); print(pData(gse1)$title)
Object 1 sample titles:
[1] "Control"    "50uM"       "8.5 Gy"     "50uM+8.5Gy"
> cat("Object 2 sample titles:\n"); print(pData(gse2)$title)
Object 2 sample titles:
[1] "Control"    "50uM"       "8.5 Gy"     "50uM+8.5Gy"
> # If both show the same 4 conditions in the same order, they ARE the same
> # physical samples, just split across two array halves (A probes + B probes)
> 
> # If confirmed, stack the probes (rbind), keep 4 samples (not 8)
> stopifnot(identical(pData(gse1)$title, pData(gse2)$title))
> combined_exprs_full <- rbind(exprs(gse1), exprs(gse2))
> cat("\nCombined matrix (should be", nrow(exprs(gse1)) + nrow(exprs(gse2)), "probes x 4 samples):\n")

Combined matrix (should be 39400 probes x 4 samples):
> print(dim(combined_exprs_full))
[1] 39400     4
> #############################################################
> # E-GEOD-18422 — STEP 3: FORMAL MODEL (CORRECTED STRUCTURE)
> # Run in the SAME session (needs: gse1, gse2, feature_info, combined_exprs_full)
> # CORRECTED: n=1 per condition (not n=2 as originally assumed), 39400 probes
> # (two complementary array halves stacked, not biological replicates)
> #############################################################
> 
> library(ggplot2); library(reshape2)
> 
> ## ---- 1. BUILD FEATURE ANNOTATION FOR THE STACKED MATRIX ----
> feature_info1 <- fData(gse1)
> feature_info2 <- fData(gse2)
> stopifnot(identical(colnames(feature_info1), colnames(feature_info2)))
Error: identical(colnames(feature_info1), colnames(feature_info2)) is not TRUE

> cat("Object 1 feature columns:\n")
Object 1 feature columns:
> print(colnames(feature_info1))
[1] "ID"       "ORF"      "SEQUENCE"
[4] "GB_ACC"  
> 
> cat("\nObject 2 feature columns:\n")

Object 2 feature columns:
> print(colnames(feature_info2))
[1] "ID"       "ORF"      "SEQUENCE"
[4] "GB_ACC"   "SPOT_ID" 
> 
> cat("\nColumns in Object 1 but NOT Object 2:\n")

Columns in Object 1 but NOT Object 2:
> print(setdiff(colnames(feature_info1), colnames(feature_info2)))
character(0)
> 
> cat("\nColumns in Object 2 but NOT Object 1:\n")

Columns in Object 2 but NOT Object 1:
> print(setdiff(colnames(feature_info2), colnames(feature_info1)))
[1] "SPOT_ID"
> shared_cols <- intersect(colnames(feature_info1), colnames(feature_info2))
> cat("Shared columns to use:", shared_cols, "\n")
Shared columns to use: ID ORF SEQUENCE GB_ACC 
> 
> feature_info1_aligned <- feature_info1[, shared_cols]
> feature_info2_aligned <- feature_info2[, shared_cols]
> stopifnot(identical(colnames(feature_info1_aligned), colnames(feature_info2_aligned)))
> 
> feature_info_full <- rbind(feature_info1_aligned, feature_info2_aligned)
> stopifnot(identical(rownames(feature_info_full), rownames(combined_exprs_full)))
> cat("Feature annotation aligned:", nrow(feature_info_full), "probes\n")
Feature annotation aligned: 39400 probes
> ## ---- 2. SAMPLE METADATA (n=1 per condition - no replicate structure) ----
> sample_info <- data.frame(
+     Sample_ID = colnames(combined_exprs_full),
+     Condition = pData(gse1)$title
+ )
> cat("\nSample table:\n"); print(sample_info)

Sample table:
  Sample_ID  Condition
1 GSM459231    Control
2 GSM459232       50uM
3 GSM459233     8.5 Gy
4 GSM459234 50uM+8.5Gy
> 
> ## ---- 3. WITH n=1/CONDITION: compute fold-changes directly, NO formal p-values ----
> get_fc <- function(condition_col, control_col) {
+     combined_exprs_full[, condition_col] - combined_exprs_full[, control_col]
+ }
> 
> fc_table <- data.frame(
+     Probe_ID = rownames(combined_exprs_full),
+     Symbol = feature_info_full$ORF,
+     Radiation_vs_Control = get_fc("8.5 Gy", "Control"),
+     Drug_vs_Control = get_fc("50uM", "Control"),
+     DrugRad_vs_Control = get_fc("50uM+8.5Gy", "Control"),
+     ProtectionEffect = get_fc("50uM+8.5Gy", "8.5 Gy")
+ )
Error in combined_exprs_full[, condition_col] : subscript out of bounds

> # Rename columns to condition labels, using the verified sample_info mapping
> stopifnot(identical(colnames(combined_exprs_full), sample_info$Sample_ID))
> colnames(combined_exprs_full) <- sample_info$Condition
> cat("Renamed columns:\n")
Renamed columns:
> print(colnames(combined_exprs_full))
[1] "Control"    "50uM"      
[3] "8.5 Gy"     "50uM+8.5Gy"
> 
> # Now the fold-change function will find them correctly
> get_fc <- function(condition_col, control_col) {
+     combined_exprs_full[, condition_col] - combined_exprs_full[, control_col]
+ }
> 
> fc_table <- data.frame(
+     Probe_ID = rownames(combined_exprs_full),
+     Symbol = feature_info_full$ORF,
+     Radiation_vs_Control = get_fc("8.5 Gy", "Control"),
+     Drug_vs_Control = get_fc("50uM", "Control"),
+     DrugRad_vs_Control = get_fc("50uM+8.5Gy", "Control"),
+     ProtectionEffect = get_fc("50uM+8.5Gy", "8.5 Gy")
+ )
> 
> write.csv(fc_table, "E-GEOD-18422_fold_changes_ALL_PROBES.csv", row.names = FALSE)
> cat("\nSaved fold-change table:", nrow(fc_table), "probes\n")

Saved fold-change table: 39400 probes
> 
> canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
> canon_fc <- fc_table[fc_table$Symbol %in% canon_genes, ]
> cat("\n=== Canonical gene fold-changes ===\n")

=== Canonical gene fold-changes ===
> print(canon_fc[order(canon_fc$Symbol), ])
                           Probe_ID
obshum40K:A#07688 obshum40K:A#07688
obshum40K:A#35485 obshum40K:A#35485
obshum40K:A#19955 obshum40K:A#19955
obshum40K:A#36535 obshum40K:A#36535
obshum40K:A#07413 obshum40K:A#07413
obshum40K:A#09356 obshum40K:A#09356
obshum40K:A#02615 obshum40K:A#02615
obshum40K:A#00936 obshum40K:A#00936
obshum40K:A#02051 obshum40K:A#02051
obshum40K:A#03065 obshum40K:A#03065
obshum40K:A#11900 obshum40K:A#11900
obshum40K:A#12549 obshum40K:A#12549
obshum40K:A#15791 obshum40K:A#15791
obshum40K:A#38901 obshum40K:A#38901
obshum40K:B#11800 obshum40K:B#11800
obshum40K:B#12580 obshum40K:B#12580
obshum40K:B#42465 obshum40K:B#42465
                   Symbol
obshum40K:A#07688     BAX
obshum40K:A#35485     BAX
obshum40K:A#19955  CDKN1A
obshum40K:A#36535  CDKN1A
obshum40K:A#07413    DDB2
obshum40K:A#09356    FDXR
obshum40K:A#02615 GADD45A
obshum40K:A#00936    MDM2
obshum40K:A#02051    MDM2
obshum40K:A#03065    MDM2
obshum40K:A#11900    MDM2
obshum40K:A#12549    MDM2
obshum40K:A#15791    MDM2
obshum40K:A#38901    MDM2
obshum40K:B#11800    MDM2
obshum40K:B#12580    MDM2
obshum40K:B#42465    MDM2
                  Radiation_vs_Control
obshum40K:A#07688              -2.3875
obshum40K:A#35485              -0.1590
obshum40K:A#19955              -0.2581
obshum40K:A#36535               0.2910
obshum40K:A#07413               0.6091
obshum40K:A#09356              -0.9850
obshum40K:A#02615               0.3152
obshum40K:A#00936              -0.1076
obshum40K:A#02051              -2.6822
obshum40K:A#03065               0.4117
obshum40K:A#11900              -2.1724
obshum40K:A#12549              -0.3903
obshum40K:A#15791              -0.1562
obshum40K:A#38901              -0.3328
obshum40K:B#11800              -0.0430
obshum40K:B#12580               0.3854
obshum40K:B#42465               0.6260
                  Drug_vs_Control
obshum40K:A#07688         -1.4225
obshum40K:A#35485         -0.1963
obshum40K:A#19955          0.0320
obshum40K:A#36535          0.2004
obshum40K:A#07413          0.8556
obshum40K:A#09356         -1.2100
obshum40K:A#02615         -1.6005
obshum40K:A#00936          0.1403
obshum40K:A#02051         -1.9386
obshum40K:A#03065          0.0896
obshum40K:A#11900         -1.5149
obshum40K:A#12549          0.4495
obshum40K:A#15791         -0.0644
obshum40K:A#38901          0.3953
obshum40K:B#11800          0.1348
obshum40K:B#12580          0.6190
obshum40K:B#42465          1.3734
                  DrugRad_vs_Control
obshum40K:A#07688            -2.0845
obshum40K:A#35485            -0.3018
obshum40K:A#19955            -0.0714
obshum40K:A#36535            -0.1054
obshum40K:A#07413             0.8993
obshum40K:A#09356            -1.1430
obshum40K:A#02615            -0.6367
obshum40K:A#00936            -0.2338
obshum40K:A#02051            -1.6847
obshum40K:A#03065             0.0278
obshum40K:A#11900            -1.3122
obshum40K:A#12549            -0.8595
obshum40K:A#15791             0.3259
obshum40K:A#38901             0.1428
obshum40K:B#11800            -0.1167
obshum40K:B#12580             0.5627
obshum40K:B#42465             1.1941
                  ProtectionEffect
obshum40K:A#07688           0.3030
obshum40K:A#35485          -0.1428
obshum40K:A#19955           0.1867
obshum40K:A#36535          -0.3964
obshum40K:A#07413           0.2902
obshum40K:A#09356          -0.1580
obshum40K:A#02615          -0.9519
obshum40K:A#00936          -0.1262
obshum40K:A#02051           0.9975
obshum40K:A#03065          -0.3839
obshum40K:A#11900           0.8602
obshum40K:A#12549          -0.4692
obshum40K:A#15791           0.4821
obshum40K:A#38901           0.4756
obshum40K:B#11800          -0.0737
obshum40K:B#12580           0.1773
obshum40K:B#42465           0.5681

> 
> 
