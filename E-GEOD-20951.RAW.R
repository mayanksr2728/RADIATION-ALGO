#############################################################
> # E-GEOD-20951 — STEP 1: DOWNLOAD + METADATA INSPECTION
> # Human embryonic stem cells (hESCs), doses 0.4/2/4 Gy, single 24h timepoint
> # Agilent 4x44K array. Do NOT build any model until structure is confirmed.
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
package(s) not installed when version(s) same as or greater than current; use `force
  = TRUE` to re-install: 'GEOquery' 'limma' 'Biobase' 
> if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
> 
> library(GEOquery); library(limma); library(Biobase); library(ggplot2)
> if (!dir.exists("figures")) dir.create("figures")
> 
> ## ---- 1. DOWNLOAD (try GEO accession first; this dataset may also be
> ##         reachable via ArrayExpress as E-GEOD-20951 — same underlying data) ----
> geo_data <- getGEO("GSE20951", GSEMatrix = TRUE)
Found 1 file(s)
GSE20951_series_matrix.txt.gz
> stopifnot(class(geo_data) == "list")
> cat("Number of platforms/objects returned:", length(geo_data), "\n")
Number of platforms/objects returned: 1 
> ## NOTE: if length > 1, this series spans multiple platforms — inspect each
> ## before proceeding; don't assume [[1]] is the right one blindly.
> print(names(geo_data))
[1] "GSE20951_series_matrix.txt.gz"
> 
> gse <- geo_data[[1]]
> stopifnot(class(gse) == "ExpressionSet")
> cat("\nLoaded ExpressionSet with", nrow(exprs(gse)), "features and", ncol(exprs(gse)), "samples\n")

Loaded ExpressionSet with 29222 features and 12 samples
> cat("Expected roughly 24 samples (4 doses x conditions x replicates, exact n TBD from real metadata)\n")
Expected roughly 24 samples (4 doses x conditions x replicates, exact n TBD from real metadata)
> 
> ## ---- 2. CHECK RAW SCALE — VERIFY, DON'T ASSUME (same guard as prior datasets) ----
> raw_range <- range(exprs(gse), na.rm = TRUE)
> cat("\nRaw expression range:", raw_range, "\n")

Raw expression range: -9.498857 7.280357 
> if (raw_range[2] > 100) {
+     cat("Data appears to be on linear scale — applying log2 transform once.\n")
+     exprs(gse) <- log2(exprs(gse))
+ } else {
+     cat("Data appears to already be log-scale — skipping transform.\n")
+ }
Data appears to already be log-scale — skipping transform.
> logged_range <- range(exprs(gse), na.rm = TRUE)
> cat("Final expression range:", logged_range, "\n")
Final expression range: -9.498857 7.280357 
> stopifnot(logged_range[2] < 20)  # double-log guard
> 
> ## ---- 3. NORMALIZATION QUALITY CHECK ----
> sample_medians <- apply(exprs(gse), 2, median, na.rm = TRUE)
> sample_iqr <- apply(exprs(gse), 2, IQR, na.rm = TRUE)
> cat("\nMedian range across samples:", range(sample_medians, na.rm = TRUE), "\n")

Median range across samples: 0.02746776 0.1189408 
> cat("IQR range across samples:", range(sample_iqr, na.rm = TRUE), "\n")
IQR range across samples: 0.6282649 1.315077 
> cat("(Tight ranges = well normalized; wide ranges = flag for investigation)\n")
(Tight ranges = well normalized; wide ranges = flag for investigation)
> 
> ## ---- 4. INSPECT REAL METADATA — DO NOT ASSUME FIELD NAMES ----
> metadata <- pData(gse)
> cat("\nAvailable metadata columns:\n")

Available metadata columns:
> print(colnames(metadata))
 [1] "title"                     "geo_accession"            
 [3] "status"                    "submission_date"          
 [5] "last_update_date"          "type"                     
 [7] "channel_count"             "source_name_ch1"          
 [9] "organism_ch1"              "characteristics_ch1"      
[11] "characteristics_ch1.1"     "characteristics_ch1.2"    
[13] "growth_protocol_ch1"       "molecule_ch1"             
[15] "extract_protocol_ch1"      "label_ch1"                
[17] "label_protocol_ch1"        "taxid_ch1"                
[19] "source_name_ch2"           "organism_ch2"             
[21] "characteristics_ch2"       "growth_protocol_ch2"      
[23] "molecule_ch2"              "extract_protocol_ch2"     
[25] "label_ch2"                 "label_protocol_ch2"       
[27] "taxid_ch2"                 "hyb_protocol"             
[29] "scan_protocol"             "data_processing"          
[31] "platform_id"               "contact_name"             
[33] "contact_email"             "contact_institute"        
[35] "contact_address"           "contact_city"             
[37] "contact_state"             "contact_zip/postal_code"  
[39] "contact_country"           "supplementary_file"       
[41] "data_row_count"            "cell type:ch1"            
[43] "cell type:ch2"             "differentiation state:ch1"
[45] "treatment group:ch1"      
> 
> cat("\nSample titles (all of them, this dataset is smaller):\n")

Sample titles (all of them, this dataset is smaller):
> print(metadata$title)
 [1] "Control (non-irradiated) hESCs, Replicate 1"
 [2] "Control (non-irradiated) hESCs, Replicate 2"
 [3] "Control (non-irradiated) hESCs, Replicate 3"
 [4] "0.4 Gy irradiated hESCs, Replicate 1"       
 [5] "0.4 Gy irradiated hESCs, Replicate 2"       
 [6] "0.4 Gy irradiated hESCs, Replicate 3"       
 [7] "2 Gy irradiated hESCs, Replicate 1"         
 [8] "2 Gy irradiated hESCs, Replicate 2"         
 [9] "2 Gy irradiated hESCs, Replicate 3"         
[10] "4 Gy irradiated hESCs, Replicate 1"         
[11] "4 Gy irradiated hESCs, Replicate 2"         
[12] "4 Gy irradiated hESCs, Replicate 3"         
> 
> cat("\nCharacteristics fields — inspect before building design table:\n")

Characteristics fields — inspect before building design table:
> char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
> for (cc in char_cols) {
+     cat("\n--", cc, "unique values:\n")
+     print(unique(metadata[[cc]]))
+ }

-- characteristics_ch1 unique values:
[1] "cell type: H9 embryonic stem cells (hESCs)"

-- characteristics_ch1.1 unique values:
[1] "differentiation state: undifferentiated"

-- characteristics_ch1.2 unique values:
[1] "treatment group: non-irradiated"    "treatment group: 0.4 Gy irradiated"
[3] "treatment group: 2 Gy irradiated"   "treatment group: 4 Gy irradiated"  

-- characteristics_ch2 unique values:
[1] "cell type: pool of undifferentiated and differentiated hESCs, as well as fetal and neonatal tissues"
> 
> ## ---- 5. SAVE RAW PARSE FOR MANUAL REVIEW — STOP HERE ----
> sample_info_raw <- data.frame(
+     Sample_ID = metadata$geo_accession,
+     Title = metadata$title
+ )
> write.csv(sample_info_raw, "E-GEOD-20951_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)
> 
> ## ---- 6. SESSION INFO ----
> writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-20951_STEP1.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 1 COMPLETE.\n")
STEP 1 COMPLETE.
> cat("STOP HERE. Review the characteristics fields and titles printed above.\n")
STOP HERE. Review the characteristics fields and titles printed above.
> cat("Confirm: which field(s) actually contain dose information, and whether\n")
Confirm: which field(s) actually contain dose information, and whether
> cat("there's a real replicate/batch structure, before I write Step 2.\n")
there's a real replicate/batch structure, before I write Step 2.
> cat("Paste back: metadata columns, sample titles, and all characteristics\n")
Paste back: metadata columns, sample titles, and all characteristics
> cat("unique values shown above.\n")
unique values shown above.
> cat("===========================================\n")
===========================================
> # Check what VALUE actually represents for this platform
> cat("Platform ID:", unique(metadata$platform_id), "\n")
Platform ID: GPL6480 
> print(gse@experimentData@other$data_processing)
NULL
> # Or check a single GSM's data processing description directly
> cat(metadata$data_processing[1])
The image files were extracted using Agilent Feature Extraction software version 9.5.1 applying LOWESS background subtraction and dye-normalization. For probe selection criteria, 6 of 12 microarrays were required to have flags that were present or marginal.  One sample (0.4Gy-3) was excluded from  the analysis because it appeared to be an outlier compared to the other samples.
> cat("Actual samples in loaded object:", ncol(exprs(gse)), "\n")
Actual samples in loaded object: 12 
> print(metadata$title)  # confirm whether "0.4 Gy irradiated hESCs, Replicate 3" is present or already absent
 [1] "Control (non-irradiated) hESCs, Replicate 1"
 [2] "Control (non-irradiated) hESCs, Replicate 2"
 [3] "Control (non-irradiated) hESCs, Replicate 3"
 [4] "0.4 Gy irradiated hESCs, Replicate 1"       
 [5] "0.4 Gy irradiated hESCs, Replicate 2"       
 [6] "0.4 Gy irradiated hESCs, Replicate 3"       
 [7] "2 Gy irradiated hESCs, Replicate 1"         
 [8] "2 Gy irradiated hESCs, Replicate 2"         
 [9] "2 Gy irradiated hESCs, Replicate 3"         
[10] "4 Gy irradiated hESCs, Replicate 1"         
[11] "4 Gy irradiated hESCs, Replicate 2"         
[12] "4 Gy irradiated hESCs, Replicate 3"         
> sample_info <- data.frame(
+     Sample_ID = metadata$geo_accession,
+     Title = metadata$title,
+     Dose_raw = metadata[["treatment group:ch1"]]
+ )
> sample_info$Dose <- ifelse(grepl("non-irradiated", sample_info$Dose_raw), 0,
+                            as.numeric(gsub(" Gy.*", "", sample_info$Dose_raw)))
Warning message:
In ifelse(grepl("non-irradiated", sample_info$Dose_raw), 0, as.numeric(gsub(" Gy.*",  :
  NAs introduced by coercion
> 
> cat("Dose distribution:\n")
Dose distribution:
> print(table(sample_info$Dose))

  0 0.4   2   4 
  3   3   3   3 
> cat("Expected: 3-3-3-3, OR 3-2-3-3 if the excluded outlier is already absent from this object\n")
Expected: 3-3-3-3, OR 3-2-3-3 if the excluded outlier is already absent from this object
> 
> stopifnot(!any(is.na(sample_info$Dose)))
> rownames(sample_info) <- sample_info$Sample_ID
> stopifnot(identical(rownames(sample_info), colnames(exprs(gse))))
> pca_res <- prcomp(t(exprs(gse)), scale. = TRUE)
> pca_data <- data.frame(pca_res$x[,1:3], Title = sample_info$Title, Dose = factor(sample_info$Dose))
> print(pca_data[order(pca_data$Dose), c("Title","Dose","PC1","PC2","PC3")])
                                                Title Dose          PC1        PC2
GSM523876 Control (non-irradiated) hESCs, Replicate 1    0  -46.9983751 -18.990930
GSM523877 Control (non-irradiated) hESCs, Replicate 2    0   69.4392042  87.709509
GSM523878 Control (non-irradiated) hESCs, Replicate 3    0  -71.1569581 -74.286791
GSM523879        0.4 Gy irradiated hESCs, Replicate 1  0.4   89.1030408  84.706906
GSM523880        0.4 Gy irradiated hESCs, Replicate 2  0.4  -83.4225161 -22.853252
GSM523881        0.4 Gy irradiated hESCs, Replicate 3  0.4 -175.8602901 145.119477
GSM523882          2 Gy irradiated hESCs, Replicate 1    2  120.4161006   8.648554
GSM523883          2 Gy irradiated hESCs, Replicate 2    2   -9.2727275 -60.863488
GSM523884          2 Gy irradiated hESCs, Replicate 3    2   27.2866181 -37.097862
GSM523885          4 Gy irradiated hESCs, Replicate 1    4  119.7889708  10.601170
GSM523886          4 Gy irradiated hESCs, Replicate 2    4   -0.8938796 -74.085878
GSM523887          4 Gy irradiated hESCs, Replicate 3    4  -38.4291879 -48.607415
                  PC3
GSM523876    6.717985
GSM523877  -87.690340
GSM523878   44.986685
GSM523879   -8.421110
GSM523880   -7.970703
GSM523881   46.474179
GSM523882  132.570646
GSM523883  -14.554853
GSM523884 -100.445407
GSM523885    8.261964
GSM523886   73.291878
GSM523887  -93.220925
> cat("\nSpecifically checking the flagged sample:\n")

Specifically checking the flagged sample:
> print(pca_data[grepl("0.4 Gy.*Replicate 3", pca_data$Title), ])
                PC1      PC2      PC3                                Title Dose
GSM523881 -175.8603 145.1195 46.47418 0.4 Gy irradiated hESCs, Replicate 3  0.4
> cat("\nCompare against its dose-group siblings:\n")

Compare against its dose-group siblings:
> print(pca_data[pca_data$Dose == 0.4, ])
                 PC1       PC2       PC3                                Title Dose
GSM523879   89.10304  84.70691 -8.421110 0.4 Gy irradiated hESCs, Replicate 1  0.4
GSM523880  -83.42252 -22.85325 -7.970703 0.4 Gy irradiated hESCs, Replicate 2  0.4
GSM523881 -175.86029 145.11948 46.474179 0.4 Gy irradiated hESCs, Replicate 3  0.4
> cat("Excluding GSM523881 (0.4 Gy Replicate 3) — confirmed outlier via independent PCA,\n")
Excluding GSM523881 (0.4 Gy Replicate 3) — confirmed outlier via independent PCA,
> cat("consistent with original authors' documented exclusion.\n")
consistent with original authors' documented exclusion.
> 
> exclude_sample <- "GSM523881"
> gse_filtered <- gse[, colnames(exprs(gse)) != exclude_sample]
> sample_info_filtered <- sample_info[sample_info$Sample_ID != exclude_sample, ]
> 
> stopifnot(ncol(exprs(gse_filtered)) == 11)
> stopifnot(nrow(sample_info_filtered) == 11)
> stopifnot(identical(rownames(sample_info_filtered), colnames(exprs(gse_filtered))))
> 
> cat("\nFinal dose distribution after exclusion:\n")

Final dose distribution after exclusion:
> print(table(sample_info_filtered$Dose))

  0 0.4   2   4 
  3   2   3   3 
> cat("(Expect: 0=3, 0.4=2, 2=3, 4=3)\n")
(Expect: 0=3, 0.4=2, 2=3, 4=3)
> 
> #############################################################
> # E-GEOD-20951 — STEP 2: FORMAL DOSE-RESPONSE MODEL
> # Run in the SAME session as Step 1 (needs: gse_filtered, sample_info_filtered)
> # 11 samples: 0 Gy(3), 0.4 Gy(2), 2 Gy(3), 4 Gy(3). Two-color Agilent, hESCs.
> #############################################################
> 
> library(limma); library(ggplot2); library(reshape2)
> if (!requireNamespace("clusterProfiler", quietly = TRUE)) BiocManager::install(c("clusterProfiler","org.Hs.eg.db"), update=FALSE, ask=FALSE)
> library(clusterProfiler); library(org.Hs.eg.db)
> 
> ## ---- 1. DESIGN MATRIX — DOSE AS A FACTOR (only 3 nonzero levels + control,
> ##         too few points per level for a spline; use factor-based contrasts) ----
> sample_info_filtered$Dose_factor <- factor(sample_info_filtered$Dose, levels = c(0, 0.4, 2, 4))
> design_matrix <- model.matrix(~ 0 + Dose_factor, data = sample_info_filtered)
> colnames(design_matrix) <- c("D0", "D0_4", "D2", "D4")
> 
> stopifnot(identical(rownames(sample_info_filtered), colnames(exprs(gse_filtered))))
> fit <- lmFit(exprs(gse_filtered), design_matrix)
> 
> contrast_matrix <- makeContrasts(
+     Dose0_4_vs_Control = D0_4 - D0,
+     Dose2_vs_Control    = D2 - D0,
+     Dose4_vs_Control    = D4 - D0,
+     levels = design_matrix
+ )
> fit2 <- contrasts.fit(fit, contrast_matrix)
> fit2 <- eBayes(fit2)
> cat("Contrasts built:\n"); print(colnames(contrast_matrix))
Contrasts built:
[1] "Dose0_4_vs_Control" "Dose2_vs_Control"   "Dose4_vs_Control"  
> 
> ## ---- 2. GENE ANNOTATION ----
> feature_info <- fData(gse_filtered)
> cat("\nAvailable feature columns:\n"); print(colnames(feature_info))

Available feature columns:
 [1] "ID"                   "SPOT_ID"              "CONTROL_TYPE"        
 [4] "REFSEQ"               "GB_ACC"               "GENE"                
 [7] "GENE_SYMBOL"          "GENE_NAME"            "UNIGENE_ID"          
[10] "ENSEMBL_ID"           "TIGR_ID"              "ACCESSION_STRING"    
[13] "CHROMOSOMAL_LOCATION" "CYTOBAND"             "DESCRIPTION"         
[16] "GO_ID"                "SEQUENCE"            
> ## Agilent platforms commonly use "GENE_SYMBOL" — verify before trusting:
> symbol_col <- colnames(feature_info)[grep("symbol", colnames(feature_info), ignore.case = TRUE)][1]
> cat("Using symbol column:", symbol_col, "\n")
Using symbol column: GENE_SYMBOL 
> stopifnot(!is.na(symbol_col))
> 
> probe_to_gene <- data.frame(Probe_ID = rownames(feature_info), Symbol = feature_info[[symbol_col]])
> 
> ## ---- 3. FULL RESULTS + PER-CONTRAST EXTRACTION (never trust shared adj.P.Val) ----
> all_results_list <- list()
> for (cn in colnames(contrast_matrix)) {
+     r <- topTable(fit2, coef = cn, number = Inf, adjust.method = "BH")
+     r$Probe_ID <- rownames(r)
+     r_named <- merge(probe_to_gene, r, by = "Probe_ID")
+     all_results_list[[cn]] <- r_named
+     write.csv(r_named, paste0("E-GEOD-20951_", cn, "_FULL.csv"), row.names = FALSE)
+ }
> 
> ## ---- 4. CANONICAL GENE CHECKPOINT ----
> canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
> cat("\n=== CANONICAL GENE CHECK, per contrast ===\n")

=== CANONICAL GENE CHECK, per contrast ===
> for (cn in names(all_results_list)) {
+     r <- all_results_list[[cn]]
+     canon <- r[r$Symbol %in% canon_genes, c("Symbol","Probe_ID","logFC","adj.P.Val")]
+     cat("\n--", cn, "--\n")
+     print(canon[order(canon$adj.P.Val), ])
+ }

-- Dose0_4_vs_Control --
       Symbol     Probe_ID      logFC adj.P.Val
2598     MDM2 A_23_P139895  0.3767442 0.9999835
5570      BAX A_23_P208706  0.1157173 0.9999835
6438  GADD45A  A_23_P23221  0.5090101 0.9999835
7751     MDM2 A_23_P309545  0.8803314 0.9999835
8793      BAX A_23_P346309 -0.3044442 0.9999835
8794      BAX A_23_P346311  0.4254334 0.9999835
9788     FDXR  A_23_P38154  0.3024247 0.9999835
11820    MDM2 A_23_P502750  0.6759913 0.9999835
11992    DDB2  A_23_P52610  0.2761771 0.9999835
12430  CDKN1A  A_23_P59210 -0.1317370 0.9999835
23375  CDKN1A  A_24_P89457 -0.0519352 0.9999835
23802    MDM2 A_24_P925664  0.4778337 0.9999835

-- Dose2_vs_Control --
       Symbol     Probe_ID      logFC adj.P.Val
7751     MDM2 A_23_P309545  1.3350878 0.9858073
9788     FDXR  A_23_P38154  1.0117610 0.9858073
2598     MDM2 A_23_P139895  1.1254530 0.9998860
5570      BAX A_23_P208706  0.4654891 0.9998860
6438  GADD45A  A_23_P23221  0.8496974 0.9998860
8793      BAX A_23_P346309 -0.5781538 0.9998860
8794      BAX A_23_P346311  0.5432177 0.9998860
11820    MDM2 A_23_P502750  0.6765501 0.9998860
11992    DDB2  A_23_P52610  1.0634772 0.9998860
12430  CDKN1A  A_23_P59210  0.6942546 0.9998860
23375  CDKN1A  A_24_P89457  1.1472593 0.9998860
23802    MDM2 A_24_P925664  1.0401296 0.9998860

-- Dose4_vs_Control --
       Symbol     Probe_ID       logFC adj.P.Val
2598     MDM2 A_23_P139895  1.09395989 0.9999679
5570      BAX A_23_P208706  0.51222546 0.9999679
6438  GADD45A  A_23_P23221  0.60502726 0.9999679
7751     MDM2 A_23_P309545  0.86117856 0.9999679
8793      BAX A_23_P346309 -0.06370187 0.9999679
8794      BAX A_23_P346311  0.50098300 0.9999679
9788     FDXR  A_23_P38154  1.02151901 0.9999679
11820    MDM2 A_23_P502750  0.77025209 0.9999679
11992    DDB2  A_23_P52610  1.18790789 0.9999679
12430  CDKN1A  A_23_P59210  0.84482317 0.9999679
23375  CDKN1A  A_24_P89457  1.07226747 0.9999679
23802    MDM2 A_24_P925664  1.06024965 0.9999679
> 
> ## ---- 5. TECHNICAL ARTIFACT CHECK (control-probe pattern, same discipline as GSE59861) ----
> cat("\n=== Technical artifact check — any non-gene / control probe patterns? ===\n")

=== Technical artifact check — any non-gene / control probe patterns? ===
> cat("Probe ID pattern sample (check for AFFX-style or other control probe prefixes):\n")
Probe ID pattern sample (check for AFFX-style or other control probe prefixes):
> print(head(grep("^A_|^CONTROL|^ERCC", rownames(exprs(gse_filtered)), value = TRUE, ignore.case = TRUE), 20))
 [1] "A_23_P100001" "A_23_P100011" "A_23_P100022" "A_23_P100056" "A_23_P100074"
 [6] "A_23_P100092" "A_23_P100103" "A_23_P100111" "A_23_P100127" "A_23_P100133"
[11] "A_23_P100141" "A_23_P100156" "A_23_P100177" "A_23_P100189" "A_23_P100196"
[16] "A_23_P100203" "A_23_P100220" "A_23_P10025"  "A_23_P100263" "A_23_P100292"
> ## NOTE: Agilent control probe naming differs from Affymetrix AFFX- convention.
> ## Inspect the printed patterns above and confirm whether any need excluding.
> 
> ## ---- 6. SIGNIFICANCE SUMMARY ----
> cat("\n=== Significant gene counts per contrast (padj<0.05, |logFC|>1) ===\n")

=== Significant gene counts per contrast (padj<0.05, |logFC|>1) ===
> for (cn in names(all_results_list)) {
+     r <- all_results_list[[cn]]
+     n_sig <- sum(r$adj.P.Val < 0.05 & abs(r$logFC) > 1, na.rm = TRUE)
+     cat(cn, "—", n_sig, "significant genes\n")
+ }
Dose0_4_vs_Control — 0 significant genes
Dose2_vs_Control — 0 significant genes
Dose4_vs_Control — 0 significant genes
> 
> ## ---- 7. FIGURE: PCA (post-exclusion) ----
> pca_res <- prcomp(t(exprs(gse_filtered)), scale. = TRUE)
> pca_data <- data.frame(pca_res$x, Dose = factor(sample_info_filtered$Dose))
> p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Dose)) +
+     geom_point(size = 4, alpha = 0.8) + theme_minimal() +
+     labs(title = "E-GEOD-20951 PCA (post-outlier-exclusion, n=11)")
> if (!dir.exists("figures")) dir.create("figures")
> ggsave("figures/E-GEOD-20951_Fig1_PCA.pdf", p1, width = 7, height = 5)
> ggsave("figures/E-GEOD-20951_Fig1_PCA.png", p1, width = 7, height = 5)
> 
> ## ---- 8. FIGURE: canonical gene dose curves ----
> canon_probes <- probe_to_gene[probe_to_gene$Symbol %in% canon_genes, ]
> canon_expr <- exprs(gse_filtered)[canon_probes$Probe_ID, , drop = FALSE]
> rownames(canon_expr) <- canon_probes$Symbol[match(rownames(canon_expr), canon_probes$Probe_ID)]
> canon_melt <- melt(canon_expr); colnames(canon_melt) <- c("Symbol","Sample_ID","Expression")
> canon_melt <- merge(canon_melt, sample_info_filtered, by.x = "Sample_ID", by.y = "Sample_ID")
> 
> p2 <- ggplot(canon_melt, aes(x = Dose, y = Expression, color = Symbol)) +
+     geom_point(size = 2, alpha = 0.7) + geom_smooth(method = "loess", se = FALSE) +
+     facet_wrap(~Symbol, scales = "free_y") + theme_minimal() +
+     labs(title = "Canonical Genes — E-GEOD-20951 (hESCs)", x = "Dose (Gy)", y = "Log2 Ratio (vs pooled reference)")
> ggsave("figures/E-GEOD-20951_Fig2_Canonical.pdf", p2, width = 9, height = 6)
`geom_smooth()` using formula = 'y ~ x'
There were 23 warnings (use warnings() to see them)
> ggsave("figures/E-GEOD-20951_Fig2_Canonical.png", p2, width = 9, height = 6)
`geom_smooth()` using formula = 'y ~ x'
There were 23 warnings (use warnings() to see them)
> 
> ## ---- 9. SESSION INFO ----
> writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-20951_STEP2.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 2 COMPLETE. Review canonical gene checkpoint and significance\n")
STEP 2 COMPLETE. Review canonical gene checkpoint and significance
> cat("summary above before treating any contrast as a locked deliverable.\n")
summary above before treating any contrast as a locked deliverable.
> cat("Remember: hESCs are your SENSITIVITY CHECK dataset, not core weight —\n")
Remember: hESCs are your SENSITIVITY CHECK dataset, not core weight —
> cat("results here support/challenge your discovery signature, not replace it.\n")
results here support/challenge your discovery signature, not replace it.
> cat("===========================================\n")
===========================================
> cat("CONTROL_TYPE unique values:\n")
CONTROL_TYPE unique values:
> print(table(feature_info$CONTROL_TYPE))

FALSE   pos 
29197    25 
> canon_probe_ids <- probe_to_gene$Probe_ID[probe_to_gene$Symbol %in% canon_genes]
> cat("Any canonical gene probes flagged as controls?",
+     sum(feature_info$CONTROL_TYPE[match(canon_probe_ids, rownames(feature_info))] != "FALSE"), "\n")
Any canonical gene probes flagged as controls? 0 
> 
> # Confirm significance counts don't change when restricted to real probes only
> real_probe_ids <- rownames(feature_info)[feature_info$CONTROL_TYPE == "FALSE"]
> for (cn in names(all_results_list)) {
+     r <- all_results_list[[cn]]
+     r_real <- r[r$Probe_ID %in% real_probe_ids, ]
+     n_sig <- sum(r_real$adj.P.Val < 0.05 & abs(r_real$logFC) > 1, na.rm = TRUE)
+     cat(cn, "— significant genes among REAL probes only:", n_sig, "\n")
+ }
Dose0_4_vs_Control — significant genes among REAL probes only: 0 
Dose2_vs_Control — significant genes among REAL probes only: 0 
Dose4_vs_Control — significant genes among REAL probes only: 0 




> #############################################################









