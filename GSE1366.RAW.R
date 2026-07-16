#############################################################
> # GSE1366 — STEP 1: DOWNLOAD + METADATA INSPECTION
> # Clinical TBI (total body irradiation) patient blood, 1.5/3.0 Gy
> # This is a LOCKED EXTERNAL VALIDATION cohort — do not tune anything
> # based on results here. Just analyze correctly and report honestly.
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
> ## ---- 1. DOWNLOAD ----
> geo_data <- getGEO("GSE1366", GSEMatrix = TRUE)
Found 1 file(s)
GSE1366_series_matrix.txt.gz
Using locally cached version: C:\Users\nikit\AppData\Local\Temp\RtmpqcnEAI/GSE1366_series_matrix.txt.gz
Using locally cached version of GPL1217 found here:
C:\Users\nikit\AppData\Local\Temp\RtmpqcnEAI/GPL1217.soft.gz 
> stopifnot(class(geo_data) == "list")
> cat("Number of platforms/objects returned:", length(geo_data), "\n")
Number of platforms/objects returned: 1 
> print(names(geo_data))
[1] "GSE1366_series_matrix.txt.gz"
> ## NOTE: if length > 1, inspect each before picking one — don't assume [[1]]
> 
> gse <- geo_data[[1]]
> stopifnot(class(gse) == "ExpressionSet")
> cat("\nLoaded ExpressionSet with", nrow(exprs(gse)), "features and", ncol(exprs(gse)), "samples\n")

Loaded ExpressionSet with 6485 features and 4 samples
> 
> ## ---- 2. CHECK RAW SCALE ----
> raw_range <- range(exprs(gse), na.rm = TRUE)
> cat("\nRaw expression range:", raw_range, "\n")

Raw expression range: -9.117787 9.13084 
> if (raw_range[2] > 100) {
+     cat("Data appears to be on linear scale — applying log2 transform once.\n")
+     exprs(gse) <- log2(exprs(gse))
+ } else {
+     cat("Data appears to already be log-scale or ratio-based — skipping transform.\n")
+ }
Data appears to already be log-scale or ratio-based — skipping transform.
> logged_range <- range(exprs(gse), na.rm = TRUE)
> cat("Final expression range:", logged_range, "\n")
Final expression range: -9.117787 9.13084 
> stopifnot(logged_range[2] < 20)
> 
> ## ---- 3. NORMALIZATION QUALITY CHECK ----
> sample_medians <- apply(exprs(gse), 2, median, na.rm = TRUE)
> sample_iqr <- apply(exprs(gse), 2, IQR, na.rm = TRUE)
> cat("\nMedian range across samples:", range(sample_medians, na.rm = TRUE), "\n")

Median range across samples: -0.2603253 0.1282933 
> cat("IQR range across samples:", range(sample_iqr, na.rm = TRUE), "\n")
IQR range across samples: 0.412864 0.5752996 
> 
> ## ---- 4. INSPECT REAL METADATA ----
> metadata <- pData(gse)
> cat("\nAvailable metadata columns:\n")

Available metadata columns:
> print(colnames(metadata))
 [1] "title"                   "geo_accession"           "status"                 
 [4] "submission_date"         "last_update_date"        "type"                   
 [7] "channel_count"           "source_name_ch1"         "organism_ch1"           
[10] "molecule_ch1"            "taxid_ch1"               "source_name_ch2"        
[13] "organism_ch2"            "molecule_ch2"            "taxid_ch2"              
[16] "description"             "platform_id"             "contact_name"           
[19] "contact_email"           "contact_department"      "contact_institute"      
[22] "contact_address"         "contact_city"            "contact_state"          
[25] "contact_zip/postal_code" "contact_country"         "supplementary_file"     
[28] "data_row_count"         
> 
> cat("\nAll sample titles:\n")

All sample titles:
> print(metadata$title)
[1] "TBI dose1"     "TBI dose2"     "TBI dose 1 FS" "TBI dose 2 FS"
> 
> cat("\nCharacteristics fields:\n")

Characteristics fields:
> char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
> for (cc in char_cols) {
+     cat("\n--", cc, "unique values:\n")
+     print(unique(metadata[[cc]]))
+ }
> 
> ## ---- 5. DATA PROCESSING NOTES — check for any authors' own exclusions/caveats ----
> cat("\nData processing description (check for any noted exclusions, like E-GEOD-20951 had):\n")

Data processing description (check for any noted exclusions, like E-GEOD-20951 had):
> cat(metadata$data_processing[1], "\n")
 
> 
> ## ---- 6. SAVE RAW PARSE FOR REVIEW ----
> sample_info_raw <- data.frame(Sample_ID = metadata$geo_accession, Title = metadata$title)
> write.csv(sample_info_raw, "GSE1366_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)
> 
> ## ---- 7. SESSION INFO ----
> writeLines(capture.output(sessionInfo()), "session_info_GSE1366_STEP1.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 1 COMPLETE. STOP HERE.\n")
STEP 1 COMPLETE. STOP HERE.
> cat("This is a LOCKED validation cohort — paste back everything printed above\n")
This is a LOCKED validation cohort — paste back everything printed above
> cat("(columns, titles, characteristics, processing notes) before any model is built.\n")
(columns, titles, characteristics, processing notes) before any model is built.
> cat("===========================================\n")
===========================================
> 
