#############################################################
> # E-GEOD-56704 — STEP 1: DOWNLOAD + METADATA INSPECTION
> # Mouse mammary tissue, high-LET Silicon-ion radiation, 10/30/80 cGy, n=45
> # High-LET (particle radiation) is physically different from the X-ray/gamma
> # in your other datasets - a real, distinct biological comparison, not just
> # another replication. Mouse gene symbols expected (Cdkn1a, not CDKN1A).
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
> geo_data <- getGEO("GSE56704", GSEMatrix = TRUE)
Found 1 file(s)
GSE56704_series_matrix.txt.gz
> stopifnot(class(geo_data) == "list")
> cat("Number of platform objects:", length(geo_data), "\n")
Number of platform objects: 1 
> print(names(geo_data))
[1] "GSE56704_series_matrix.txt.gz"
> for (i in seq_along(geo_data)) {
+     cat("\n--- Object", i, "---\n")
+     cat("Samples:", ncol(exprs(geo_data[[i]])), "| Features:", nrow(exprs(geo_data[[i]])), "\n")
+ }

--- Object 1 ---
Samples: 45 | Features: 35556 
> 
> gse <- geo_data[[1]]
> stopifnot(class(gse) == "ExpressionSet")
> cat("\n[TENTATIVE] Object 1:", nrow(exprs(gse)), "features,", ncol(exprs(gse)), "samples\n")

[TENTATIVE] Object 1: 35556 features, 45 samples
> cat("Manifest expected 45 samples\n")
Manifest expected 45 samples
> 
> ## ---- 2. CHECK RAW SCALE ----
> raw_range <- range(exprs(gse), na.rm = TRUE)
> cat("\nRaw expression range:", raw_range, "\n")

Raw expression range: 1.34324 14.05683 
> if (raw_range[2] > 100) {
+     exprs(gse) <- log2(exprs(gse))
+     cat("Applied log2 transform.\n")
+ } else {
+     cat("Data already log-scale — no transform applied.\n")
+ }
Data already log-scale — no transform applied.
> stopifnot(max(exprs(gse), na.rm = TRUE) < 20)
> 
> ## ---- 3. NORMALIZATION CHECK ----
> sample_medians <- apply(exprs(gse), 2, median, na.rm = TRUE)
> cat("\nMedian range across samples:", range(sample_medians, na.rm = TRUE), "\n")

Median range across samples: 5.476646 5.804495 
> 
> ## ---- 4. INSPECT METADATA ----
> metadata <- pData(gse)
> cat("\nAvailable metadata columns:\n"); print(colnames(metadata))

Available metadata columns:
 [1] "title"                    "geo_accession"           
 [3] "status"                   "submission_date"         
 [5] "last_update_date"         "type"                    
 [7] "channel_count"            "source_name_ch1"         
 [9] "organism_ch1"             "characteristics_ch1"     
[11] "characteristics_ch1.1"    "characteristics_ch1.2"   
[13] "characteristics_ch1.3"    "characteristics_ch1.4"   
[15] "treatment_protocol_ch1"   "growth_protocol_ch1"     
[17] "molecule_ch1"             "extract_protocol_ch1"    
[19] "label_ch1"                "label_protocol_ch1"      
[21] "taxid_ch1"                "hyb_protocol"            
[23] "scan_protocol"            "description"             
[25] "data_processing"          "platform_id"             
[27] "contact_name"             "contact_department"      
[29] "contact_institute"        "contact_address"         
[31] "contact_city"             "contact_state"           
[33] "contact_zip/postal_code"  "contact_country"         
[35] "supplementary_file"       "data_row_count"          
[37] "disease state (host):ch1" "protocol (host):ch1"     
[39] "strain (donor):ch1"       "strain (host):ch1"       
[41] "tissue (donor):ch1"      
> cat("\nSample titles (all 45):\n"); print(metadata$title)

Sample titles (all 45):
 [1] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  1" 
 [2] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  2" 
 [3] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  3" 
 [4] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  4" 
 [5] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  5" 
 [6] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  6" 
 [7] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  7" 
 [8] "Trp53-null-mammary-tumor, 80 cGy Si-irradiated host repeat  8" 
 [9] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  1" 
[10] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  2" 
[11] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  3" 
[12] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  4" 
[13] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  5" 
[14] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  6" 
[15] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  7" 
[16] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  8" 
[17] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  9" 
[18] "Trp53-null-mammary-tumor, 30 cGy Si-irradiated host repeat  10"
[19] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  1" 
[20] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  2" 
[21] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  3" 
[22] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  4" 
[23] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  5" 
[24] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  6" 
[25] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  7" 
[26] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  8" 
[27] "Trp53-null-mammary-tumor, 10 cGy Si-irradiated host repeat  9" 
[28] "Trp53-null-mammary-tumor, sham-irradiated host repeat  1"      
[29] "Trp53-null-mammary-tumor, sham-irradiated host repeat  2"      
[30] "Trp53-null-mammary-tumor, sham-irradiated host repeat  3"      
[31] "Trp53-null-mammary-tumor, sham-irradiated host repeat  4"      
[32] "Trp53-null-mammary-tumor, sham-irradiated host repeat  5"      
[33] "Trp53-null-mammary-tumor, sham-irradiated host repeat  6"      
[34] "Trp53-null-mammary-tumor, sham-irradiated host repeat  7"      
[35] "Trp53-null-mammary-tumor, sham-irradiated host repeat  8"      
[36] "Trp53-null-mammary-tumor, sham-irradiated host repeat  9"      
[37] "Trp53-null-mammary-tumor, sham-irradiated host repeat  10"     
[38] "Trp53-null-mammary-tumor, sham-irradiated host repeat  11"     
[39] "Trp53-null-mammary-tumor, sham-irradiated host repeat  12"     
[40] "Trp53-null-mammary-tumor, sham-irradiated host repeat  13"     
[41] "Trp53-null-mammary-tumor, sham-irradiated host repeat  14"     
[42] "Trp53-null-mammary-tumor, sham-irradiated host repeat  15"     
[43] "Trp53-null-mammary-tumor, sham-irradiated host repeat  16"     
[44] "Trp53-null-mammary-tumor, sham-irradiated host repeat  17"     
[45] "Trp53-null-mammary-tumor, sham-irradiated host repeat  18"     
> 
> char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
> cat("\nCharacteristics fields:\n")

Characteristics fields:
> for (cc in char_cols) {
+     cat("\n--", cc, "unique values:\n")
+     print(unique(metadata[[cc]]))
+ }

-- characteristics_ch1 unique values:
[1] "strain (donor): BALB/c"

-- characteristics_ch1.1 unique values:
[1] "tissue (donor): Trp53-null mammary fragments"

-- characteristics_ch1.2 unique values:
[1] "strain (host): BALB/c"

-- characteristics_ch1.3 unique values:
[1] "protocol (host): Irradiated with 80 cGy Si"
[2] "protocol (host): Irradiated with 30 cGy Si"
[3] "protocol (host): Irradiated with 10 cGy Si"
[4] "protocol (host): Sham-irradiated"          

-- characteristics_ch1.4 unique values:
[1] "disease state (host): Trp53-null mammary tumors"
> 
> cat("\nOrganism check:\n"); print(unique(metadata$organism_ch1))

Organism check:
[1] "Mus musculus"
> cat("\nData processing notes:\n"); cat(metadata$data_processing[1], "\n")

Data processing notes:
Background subtraction and normalization was performed using the Robust Multichip Average algorithm from the Bioconductor package oligo 
> 
> ## ---- 5. GENE ANNOTATION CHECK (mouse symbols expected) ----
> feature_info <- fData(gse)
> cat("\nFeature/annotation columns:\n"); print(colnames(feature_info))

Feature/annotation columns:
 [1] "ID"              "GB_LIST"         "SPOT_ID"         "seqname"        
 [5] "RANGE_GB"        "RANGE_STRAND"    "RANGE_START"     "RANGE_STOP"     
 [9] "total_probes"    "gene_assignment" "mrna_assignment" "category"       
> symbol_col <- colnames(feature_info)[grep("symbol|gene_name|GENE", colnames(feature_info), ignore.case = TRUE)][1]
> cat("Auto-detected symbol column:", symbol_col, "\n")
Auto-detected symbol column: gene_assignment 
> if (!is.na(symbol_col)) {
+     cat("Sample symbols (check mouse-style capitalization):\n")
+     print(head(feature_info[[symbol_col]], 15))
+     
+     canon_genes_mouse <- c("Bax","Cdkn1a","Ddb2","Fdxr","Gadd45a","Mdm2")
+     cat("\nDirect canonical gene check:\n")
+     for (g in canon_genes_mouse) {
+         cat(g, "found:", sum(feature_info[[symbol_col]] == g, na.rm = TRUE), "times\n")
+     }
+ } else {
+     cat("WARNING: no symbol column found — inspect manually:\n")
+     print(head(feature_info, 5))
+ }
Sample symbols (check mouse-style capitalization):
 [1] "---" "---" "---" "---" "---" "---" "---" "---" "---" "---" "---" "---" "---"
[14] "---" "---"

Direct canonical gene check:
Bax found: 0 times
Cdkn1a found: 0 times
Ddb2 found: 0 times
Fdxr found: 0 times
Gadd45a found: 0 times
Mdm2 found: 0 times
> 
> ## ---- 6. SAVE + SESSION INFO ----
> sample_info_raw <- data.frame(Sample_ID = metadata$geo_accession, Title = metadata$title)
> write.csv(sample_info_raw, "E-GEOD-56704_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)
> writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-56704_STEP1.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 1 COMPLETE. STOP HERE. Paste back everything above.\n")
STEP 1 COMPLETE. STOP HERE. Paste back everything above.
> cat("===========================================\n")
===========================================
> cat("Real (non-placeholder) gene_assignment sample:\n")
Real (non-placeholder) gene_assignment sample:
> real_rows <- feature_info$gene_assignment[feature_info$gene_assignment != "---"]
> print(head(real_rows, 5))
[1] "ENSMUST00000097833 // Gm10568 // predicted gene 10568 // --- // 100038431"                                                                                                                                                                                                                                                                                                                                                                         
[2] "ENSMUST00000097833 // Gm10568 // predicted gene 10568 // --- // 100038431 /// ENSMUST00000097833 // Gm10568 // predicted gene 10568 // --- // 100038431 /// ENSMUST00000097833 // Gm10568 // predicted gene 10568 // --- // 100038431 /// XR_030609 // Gm6123 // predicted gene 6123 // 1 A1 // 620009"                                                                                                                                            
[3] "NM_008866 // Lypla1 // lysophospholipase 1 // 1 A1 // 18777 /// ENSMUST00000027036 // Lypla1 // lysophospholipase 1 // 1 A1 // 18777 /// BC013536 // Lypla1 // lysophospholipase 1 // 1 A1 // 18777 /// ENSMUST00000115529 // Lypla1 // lysophospholipase 1 // 1 A1 // 18777"                                                                                                                                                                      
[4] "NM_011541 // Tcea1 // transcription elongation factor A (SII) 1 // 1 A1 // 21399 /// NM_001159750 // Tcea1 // transcription elongation factor A (SII) 1 // 1 A1 // 21399 /// NM_001159751 // Tcea1 // transcription elongation factor A (SII) 1 // 1 A1 // 21399 /// ENSMUST00000081551 // Tcea1 // transcription elongation factor A (SII) 1 // 1 A1 // 21399 /// BC083127 // Tcea1 // transcription elongation factor A (SII) 1 // 1 A1 // 21399"
[5] "NM_133826 // Atp6v1h // ATPase, H+ transporting, lysosomal V1 subunit H // 1 A1 // 108664 /// ENSMUST00000044369 // Atp6v1h // ATPase, H+ transporting, lysosomal V1 subunit H // 1 A1 // 108664 /// BC009154 // Atp6v1h // ATPase, H+ transporting, lysosomal V1 subunit H // 1 A1 // 108664"                                                                                                                                                     
> 
> cat("\nCanonical gene check via substring search (not exact match):\n")

Canonical gene check via substring search (not exact match):
> canon_genes_mouse <- c("Bax","Cdkn1a","Ddb2","Fdxr","Gadd45a","Mdm2")
> for (g in canon_genes_mouse) {
+     hits <- grep(paste0("// ", g, " //"), feature_info$gene_assignment, fixed = FALSE)
+     cat(g, "found:", length(hits), "times\n")
+ }
Bax found: 1 times
Cdkn1a found: 1 times
Ddb2 found: 2 times
Fdxr found: 1 times
Gadd45a found: 1 times
Mdm2 found: 1 times
> #############################################################
> # E-GEOD-56704 — STEP 2: FORMAL DOSE-RESPONSE MODEL
> # Run in the SAME session (needs: gse, metadata, feature_info)
> # Trp53-null mouse mammary tumor tissue, high-LET Si-ion, 4 dose groups, n=45
> # IMPORTANT: p53-dependent pathway is genetically disabled in this tissue —
> # canonical genes (largely p53-regulated) may show weak/absent response,
> # which would be a real, expected biological finding, not a bug.
> #############################################################
> 
> library(limma); library(ggplot2); library(reshape2)
> 
> ## ---- 1. BUILD VERIFIED DOSE VARIABLE FROM THE CLEAN characteristics FIELD ----
> dose_raw <- metadata[["protocol (host):ch1"]]
> sample_info <- data.frame(
+     Sample_ID = metadata$geo_accession,
+     Title = metadata$title,
+     Dose_raw = dose_raw
+ )
> sample_info$Dose_cGy <- ifelse(grepl("Sham", dose_raw), 0,
+                                as.numeric(gsub(".*Irradiated with ([0-9]+) cGy.*", "\\1", dose_raw)))
Warning message:
In ifelse(grepl("Sham", dose_raw), 0, as.numeric(gsub(".*Irradiated with ([0-9]+) cGy.*",  :
  NAs introduced by coercion
> 
> cat("Dose parsing check:\n")
Dose parsing check:
> print(table(sample_info$Dose_raw, sample_info$Dose_cGy, useNA = "always"))
                           
                             0 10 30 80 <NA>
  Irradiated with 10 cGy Si  0  9  0  0    0
  Irradiated with 30 cGy Si  0  0 10  0    0
  Irradiated with 80 cGy Si  0  0  0  8    0
  Sham-irradiated           18  0  0  0    0
  <NA>                       0  0  0  0    0
> stopifnot(!any(is.na(sample_info$Dose_cGy)))
> 
> rownames(sample_info) <- sample_info$Sample_ID
> stopifnot(identical(rownames(sample_info), colnames(exprs(gse))))
> 
> ## ---- 2. BUILD GENE SYMBOL MAPPING FROM gene_assignment (extract clean symbol) ----
> ## Format: "ACCESSION // SYMBOL // description // location // ID [/// repeats]"
> ## Take the FIRST symbol found (before the first ///) as the primary annotation
> extract_symbol <- function(x) {
+     if (x == "---" || is.na(x)) return(NA)
+     parts <- strsplit(x, " // ")[[1]]
+     if (length(parts) >= 2) return(parts[2])
+     return(NA)
+ }
> feature_info$Symbol <- sapply(feature_info$gene_assignment, extract_symbol)
> cat("\nProbes with a resolvable symbol:", sum(!is.na(feature_info$Symbol)), "of", nrow(feature_info), "\n")

Probes with a resolvable symbol: 25917 of 35556 
> 
> ## Re-verify canonical genes survived this extraction
> canon_genes_mouse <- c("Bax","Cdkn1a","Ddb2","Fdxr","Gadd45a","Mdm2")
> for (g in canon_genes_mouse) {
+     cat(g, "found after extraction:", sum(feature_info$Symbol == g, na.rm = TRUE), "times\n")
+ }
Bax found after extraction: 1 times
Cdkn1a found after extraction: 1 times
Ddb2 found after extraction: 1 times
Fdxr found after extraction: 1 times
Gadd45a found after extraction: 1 times
Mdm2 found after extraction: 1 times
> 
> ## ---- 3. BUILD DESIGN — DOSE AS FACTOR (4 groups, uneven n, no spline needed) ----
> sample_info$Dose_factor <- factor(sample_info$Dose_cGy, levels = c(0, 10, 30, 80))
> design_matrix <- model.matrix(~ 0 + Dose_factor, data = sample_info)
> colnames(design_matrix) <- c("D0", "D10", "D30", "D80")
> rownames(design_matrix) <- sample_info$Sample_ID
> stopifnot(identical(rownames(design_matrix), colnames(exprs(gse))))
> 
> fit <- lmFit(exprs(gse), design_matrix)
> contrast_matrix <- makeContrasts(
+     Dose10_vs_Sham = D10 - D0,
+     Dose30_vs_Sham = D30 - D0,
+     Dose80_vs_Sham = D80 - D0,
+     levels = design_matrix
+ )
> fit2 <- contrasts.fit(fit, contrast_matrix)
> fit2 <- eBayes(fit2)
> cat("\nContrasts built:\n"); print(colnames(contrast_matrix))

Contrasts built:
[1] "Dose10_vs_Sham" "Dose30_vs_Sham" "Dose80_vs_Sham"
> 
> ## ---- 4. PER-CONTRAST RESULTS + CANONICAL GENE CHECKPOINT ----
> probe_to_gene <- data.frame(Probe_ID = rownames(feature_info), Symbol = feature_info$Symbol)
> all_results_list <- list()
> for (cn in colnames(contrast_matrix)) {
+     r <- topTable(fit2, coef = cn, number = Inf, adjust.method = "BH")
+     r$Probe_ID <- rownames(r)
+     r_named <- merge(probe_to_gene, r, by = "Probe_ID")
+     all_results_list[[cn]] <- r_named
+     write.csv(r_named, paste0("E-GEOD-56704_", cn, "_FULL.csv"), row.names = FALSE)
+     
+     canon <- r_named[r_named$Symbol %in% canon_genes_mouse, c("Symbol","Probe_ID","logFC","adj.P.Val")]
+     cat("\n--- Canonical genes,", cn, "---\n")
+     print(canon[order(canon$adj.P.Val), ])
+ }

--- Canonical genes, Dose10_vs_Sham ---
       Symbol Probe_ID       logFC adj.P.Val
17148  Cdkn1a 10443463  0.29167388 0.9971209
9502     Mdm2 10372668 -0.02422913 0.9973162
11548    Fdxr 10392881 -0.02341315 0.9973162
21557    Ddb2 10484999 -0.05477358 0.9973162
30057     Bax 10563303 -0.04646683 0.9973162
27931 Gadd45a 10545130 -0.03636675 0.9976767

--- Canonical genes, Dose30_vs_Sham ---
       Symbol Probe_ID       logFC adj.P.Val
9502     Mdm2 10372668 -0.27378056 0.8906282
17148  Cdkn1a 10443463 -0.36534938 0.9512034
21557    Ddb2 10484999  0.12619488 0.9795683
27931 Gadd45a 10545130 -0.17765034 0.9826785
11548    Fdxr 10392881 -0.06627478 0.9863338
30057     Bax 10563303 -0.05783930 0.9876445

--- Canonical genes, Dose80_vs_Sham ---
       Symbol Probe_ID       logFC adj.P.Val
27931 Gadd45a 10545130  0.90899576 0.6842003
30057     Bax 10563303  0.11991414 0.9349820
17148  Cdkn1a 10443463  0.23563830 0.9422880
9502     Mdm2 10372668 -0.07820684 0.9535276
11548    Fdxr 10392881 -0.07586673 0.9605495
21557    Ddb2 10484999  0.09238661 0.9672535
> 
> ## ---- 5. SIGNIFICANCE SUMMARY ----
> cat("\n=== Significant gene counts per contrast (padj<0.05, |logFC|>1) ===\n")

=== Significant gene counts per contrast (padj<0.05, |logFC|>1) ===
> for (cn in names(all_results_list)) {
+     r <- all_results_list[[cn]]
+     n_sig <- sum(r$adj.P.Val < 0.05 & abs(r$logFC) > 1, na.rm = TRUE)
+     cat(cn, "—", n_sig, "significant genes\n")
+ }
Dose10_vs_Sham — 0 significant genes
Dose30_vs_Sham — 0 significant genes
Dose80_vs_Sham — 0 significant genes
> 
> ## ---- 6. FIGURE: PCA ----
> pca_res <- prcomp(t(exprs(gse)), scale. = TRUE)
> pca_data <- data.frame(pca_res$x, Dose = factor(sample_info$Dose_cGy))
> p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Dose)) +
+     geom_point(size = 3, alpha = 0.7) + theme_minimal() +
+     labs(title = "E-GEOD-56704 PCA — Trp53-null mammary, Si-ion (n=45)")
> if (!dir.exists("figures")) dir.create("figures")
> ggsave("figures/E-GEOD-56704_Fig1_PCA.pdf", p1, width = 7, height = 5)
> ggsave("figures/E-GEOD-56704_Fig1_PCA.png", p1, width = 7, height = 5)
> 
> ## ---- 7. SAVE SAMPLE TABLE + SESSION INFO ----
> write.csv(sample_info, "E-GEOD-56704_sample_metadata_VERIFIED.csv", row.names = FALSE)
> writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-56704_STEP2.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 2 COMPLETE.\n")
STEP 2 COMPLETE.
> cat("Remember: Trp53-null tissue may show WEAK canonical gene response by\n")
Remember: Trp53-null tissue may show WEAK canonical gene response by
> cat("design (p53-dependent pathway disabled) — this would be a real,\n")
design (p53-dependent pathway disabled) — this would be a real,
> cat("expected finding, not evidence something went wrong.\n")
expected finding, not evidence something went wrong.
> cat("===========================================\n")
===========================================
> 
>
> 
> 
