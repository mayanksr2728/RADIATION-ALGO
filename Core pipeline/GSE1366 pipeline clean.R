#############################################################
# GSE1366 — STEP 1: DOWNLOAD + METADATA INSPECTION
# Clinical TBI (total body irradiation) patient blood, 1.5/3.0 Gy
# This is a LOCKED EXTERNAL VALIDATION cohort — do not tune anything
# based on results here. Just analyze correctly and report honestly.
# Run top to bottom in a FRESH R session.
#############################################################

## ---- 0. PACKAGES ----
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("GEOquery", "limma", "Biobase"), update = FALSE, ask = FALSE)
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

library(GEOquery); library(limma); library(Biobase); library(ggplot2)
if (!dir.exists("figures")) dir.create("figures")

## ---- 1. DOWNLOAD ----
geo_data <- getGEO("GSE1366", GSEMatrix = TRUE)
stopifnot(class(geo_data) == "list")
cat("Number of platforms/objects returned:", length(geo_data), "\n")
print(names(geo_data))
## NOTE: if length > 1, inspect each before picking one — don't assume [[1]]

gse <- geo_data[[1]]
stopifnot(class(gse) == "ExpressionSet")
cat("\nLoaded ExpressionSet with", nrow(exprs(gse)), "features and", ncol(exprs(gse)), "samples\n")

## ---- 2. CHECK RAW SCALE ----
raw_range <- range(exprs(gse), na.rm = TRUE)
cat("\nRaw expression range:", raw_range, "\n")
if (raw_range[2] > 100) {
    cat("Data appears to be on linear scale — applying log2 transform once.\n")
    exprs(gse) <- log2(exprs(gse))
} else {
    cat("Data appears to already be log-scale or ratio-based — skipping transform.\n")
}
logged_range <- range(exprs(gse), na.rm = TRUE)
cat("Final expression range:", logged_range, "\n")
stopifnot(logged_range[2] < 20)

## ---- 3. NORMALIZATION QUALITY CHECK ----
sample_medians <- apply(exprs(gse), 2, median, na.rm = TRUE)
sample_iqr <- apply(exprs(gse), 2, IQR, na.rm = TRUE)
cat("\nMedian range across samples:", range(sample_medians, na.rm = TRUE), "\n")
cat("IQR range across samples:", range(sample_iqr, na.rm = TRUE), "\n")

## ---- 4. INSPECT REAL METADATA ----
metadata <- pData(gse)
cat("\nAvailable metadata columns:\n")
print(colnames(metadata))

cat("\nAll sample titles:\n")
print(metadata$title)

cat("\nCharacteristics fields:\n")
char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
for (cc in char_cols) {
    cat("\n--", cc, "unique values:\n")
    print(unique(metadata[[cc]]))
}

## ---- 5. DATA PROCESSING NOTES — check for any authors' own exclusions/caveats ----
cat("\nData processing description (check for any noted exclusions, like E-GEOD-20951 had):\n")
cat(metadata$data_processing[1], "\n")

## ---- 6. SAVE RAW PARSE FOR REVIEW ----
sample_info_raw <- data.frame(Sample_ID = metadata$geo_accession, Title = metadata$title)
write.csv(sample_info_raw, "GSE1366_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)

## ---- 7. SESSION INFO ----
writeLines(capture.output(sessionInfo()), "session_info_GSE1366_STEP1.txt")

cat("\n===========================================\n")
cat("STEP 1 COMPLETE. STOP HERE.\n")
cat("This is a LOCKED validation cohort — paste back everything printed above\n")
cat("(columns, titles, characteristics, processing notes) before any model is built.\n")
cat("===========================================\n")
