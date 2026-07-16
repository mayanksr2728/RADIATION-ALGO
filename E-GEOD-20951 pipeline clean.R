#############################################################
# E-GEOD-20951 — STEP 1: DOWNLOAD + METADATA INSPECTION
# Human embryonic stem cells (hESCs), doses 0.4/2/4 Gy, single 24h timepoint
# Agilent 4x44K array. Do NOT build any model until structure is confirmed.
# Run top to bottom in a FRESH R session.
#############################################################

## ---- 0. PACKAGES ----
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("GEOquery", "limma", "Biobase"), update = FALSE, ask = FALSE)
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

library(GEOquery); library(limma); library(Biobase); library(ggplot2)
if (!dir.exists("figures")) dir.create("figures")

## ---- 1. DOWNLOAD (try GEO accession first; this dataset may also be
##         reachable via ArrayExpress as E-GEOD-20951 — same underlying data) ----
geo_data <- getGEO("GSE20951", GSEMatrix = TRUE)
stopifnot(class(geo_data) == "list")
cat("Number of platforms/objects returned:", length(geo_data), "\n")
## NOTE: if length > 1, this series spans multiple platforms — inspect each
## before proceeding; don't assume [[1]] is the right one blindly.
print(names(geo_data))

gse <- geo_data[[1]]
stopifnot(class(gse) == "ExpressionSet")
cat("\nLoaded ExpressionSet with", nrow(exprs(gse)), "features and", ncol(exprs(gse)), "samples\n")
cat("Expected roughly 24 samples (4 doses x conditions x replicates, exact n TBD from real metadata)\n")

## ---- 2. CHECK RAW SCALE — VERIFY, DON'T ASSUME (same guard as prior datasets) ----
raw_range <- range(exprs(gse), na.rm = TRUE)
cat("\nRaw expression range:", raw_range, "\n")
if (raw_range[2] > 100) {
    cat("Data appears to be on linear scale — applying log2 transform once.\n")
    exprs(gse) <- log2(exprs(gse))
} else {
    cat("Data appears to already be log-scale — skipping transform.\n")
}
logged_range <- range(exprs(gse), na.rm = TRUE)
cat("Final expression range:", logged_range, "\n")
stopifnot(logged_range[2] < 20)  # double-log guard

## ---- 3. NORMALIZATION QUALITY CHECK ----
sample_medians <- apply(exprs(gse), 2, median, na.rm = TRUE)
sample_iqr <- apply(exprs(gse), 2, IQR, na.rm = TRUE)
cat("\nMedian range across samples:", range(sample_medians, na.rm = TRUE), "\n")
cat("IQR range across samples:", range(sample_iqr, na.rm = TRUE), "\n")
cat("(Tight ranges = well normalized; wide ranges = flag for investigation)\n")

## ---- 4. INSPECT REAL METADATA — DO NOT ASSUME FIELD NAMES ----
metadata <- pData(gse)
cat("\nAvailable metadata columns:\n")
print(colnames(metadata))

cat("\nSample titles (all of them, this dataset is smaller):\n")
print(metadata$title)

cat("\nCharacteristics fields — inspect before building design table:\n")
char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
for (cc in char_cols) {
    cat("\n--", cc, "unique values:\n")
    print(unique(metadata[[cc]]))
}

## ---- 5. SAVE RAW PARSE FOR MANUAL REVIEW — STOP HERE ----
sample_info_raw <- data.frame(
    Sample_ID = metadata$geo_accession,
    Title = metadata$title
)
write.csv(sample_info_raw, "E-GEOD-20951_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)

## ---- 6. SESSION INFO ----
writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-20951_STEP1.txt")

cat("\n===========================================\n")
cat("STEP 1 COMPLETE.\n")
cat("STOP HERE. Review the characteristics fields and titles printed above.\n")
cat("Confirm: which field(s) actually contain dose information, and whether\n")
cat("there's a real replicate/batch structure, before I write Step 2.\n")
cat("Paste back: metadata columns, sample titles, and all characteristics\n")
cat("unique values shown above.\n")
cat("===========================================\n")

# Check what VALUE actually represents for this platform
cat("Platform ID:", unique(metadata$platform_id), "\n")
print(gse@experimentData@other$data_processing)
# Or check a single GSM's data processing description directly
cat(metadata$data_processing[1])

cat("Actual samples in loaded object:", ncol(exprs(gse)), "\n")
print(metadata$title)  # confirm whether "0.4 Gy irradiated hESCs, Replicate 3" is present or already absent

sample_info <- data.frame(
    Sample_ID = metadata$geo_accession,
    Title = metadata$title,
    Dose_raw = metadata[["treatment group:ch1"]]
)
sample_info$Dose <- ifelse(grepl("non-irradiated", sample_info$Dose_raw), 0,
                     as.numeric(gsub(" Gy.*", "", sample_info$Dose_raw)))

cat("Dose distribution:\n")
print(table(sample_info$Dose))
cat("Expected: 3-3-3-3, OR 3-2-3-3 if the excluded outlier is already absent from this object\n")

stopifnot(!any(is.na(sample_info$Dose)))
rownames(sample_info) <- sample_info$Sample_ID
stopifnot(identical(rownames(sample_info), colnames(exprs(gse))))

pca_res <- prcomp(t(exprs(gse)), scale. = TRUE)
pca_data <- data.frame(pca_res$x[,1:3], Title = sample_info$Title, Dose = factor(sample_info$Dose))
print(pca_data[order(pca_data$Dose), c("Title","Dose","PC1","PC2","PC3")])

cat("\nSpecifically checking the flagged sample:\n")
print(pca_data[grepl("0.4 Gy.*Replicate 3", pca_data$Title), ])
cat("\nCompare against its dose-group siblings:\n")
print(pca_data[pca_data$Dose == 0.4, ])

cat("Excluding GSM523881 (0.4 Gy Replicate 3) — confirmed outlier via independent PCA,\n")
cat("consistent with original authors' documented exclusion.\n")

exclude_sample <- "GSM523881"
gse_filtered <- gse[, colnames(exprs(gse)) != exclude_sample]
sample_info_filtered <- sample_info[sample_info$Sample_ID != exclude_sample, ]

stopifnot(ncol(exprs(gse_filtered)) == 11)
stopifnot(nrow(sample_info_filtered) == 11)
stopifnot(identical(rownames(sample_info_filtered), colnames(exprs(gse_filtered))))

cat("\nFinal dose distribution after exclusion:\n")
print(table(sample_info_filtered$Dose))
cat("(Expect: 0=3, 0.4=2, 2=3, 4=3)\n")

#############################################################
# E-GEOD-20951 — STEP 2: FORMAL DOSE-RESPONSE MODEL
# Run in the SAME session as Step 1 (needs: gse_filtered, sample_info_filtered)
# 11 samples: 0 Gy(3), 0.4 Gy(2), 2 Gy(3), 4 Gy(3). Two-color Agilent, hESCs.
#############################################################

library(limma); library(ggplot2); library(reshape2)
if (!requireNamespace("clusterProfiler", quietly = TRUE)) BiocManager::install(c("clusterProfiler","org.Hs.eg.db"), update=FALSE, ask=FALSE)
library(clusterProfiler); library(org.Hs.eg.db)

## ---- 1. DESIGN MATRIX — DOSE AS A FACTOR (only 3 nonzero levels + control,
##         too few points per level for a spline; use factor-based contrasts) ----
sample_info_filtered$Dose_factor <- factor(sample_info_filtered$Dose, levels = c(0, 0.4, 2, 4))
design_matrix <- model.matrix(~ 0 + Dose_factor, data = sample_info_filtered)
colnames(design_matrix) <- c("D0", "D0_4", "D2", "D4")

stopifnot(identical(rownames(sample_info_filtered), colnames(exprs(gse_filtered))))
fit <- lmFit(exprs(gse_filtered), design_matrix)

contrast_matrix <- makeContrasts(
    Dose0_4_vs_Control = D0_4 - D0,
    Dose2_vs_Control    = D2 - D0,
    Dose4_vs_Control    = D4 - D0,
    levels = design_matrix
)
fit2 <- contrasts.fit(fit, contrast_matrix)
fit2 <- eBayes(fit2)
cat("Contrasts built:\n"); print(colnames(contrast_matrix))

## ---- 2. GENE ANNOTATION ----
feature_info <- fData(gse_filtered)
cat("\nAvailable feature columns:\n"); print(colnames(feature_info))
## Agilent platforms commonly use "GENE_SYMBOL" — verify before trusting:
symbol_col <- colnames(feature_info)[grep("symbol", colnames(feature_info), ignore.case = TRUE)][1]
cat("Using symbol column:", symbol_col, "\n")
stopifnot(!is.na(symbol_col))

probe_to_gene <- data.frame(Probe_ID = rownames(feature_info), Symbol = feature_info[[symbol_col]])

## ---- 3. FULL RESULTS + PER-CONTRAST EXTRACTION (never trust shared adj.P.Val) ----
all_results_list <- list()
for (cn in colnames(contrast_matrix)) {
    r <- topTable(fit2, coef = cn, number = Inf, adjust.method = "BH")
    r$Probe_ID <- rownames(r)
    r_named <- merge(probe_to_gene, r, by = "Probe_ID")
    all_results_list[[cn]] <- r_named
    write.csv(r_named, paste0("E-GEOD-20951_", cn, "_FULL.csv"), row.names = FALSE)
}

## ---- 4. CANONICAL GENE CHECKPOINT ----
canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
cat("\n=== CANONICAL GENE CHECK, per contrast ===\n")
for (cn in names(all_results_list)) {
    r <- all_results_list[[cn]]
    canon <- r[r$Symbol %in% canon_genes, c("Symbol","Probe_ID","logFC","adj.P.Val")]
    cat("\n--", cn, "--\n")
    print(canon[order(canon$adj.P.Val), ])
}

## ---- 5. TECHNICAL ARTIFACT CHECK (control-probe pattern, same discipline as GSE59861) ----
cat("\n=== Technical artifact check — any non-gene / control probe patterns? ===\n")
cat("Probe ID pattern sample (check for AFFX-style or other control probe prefixes):\n")
print(head(grep("^A_|^CONTROL|^ERCC", rownames(exprs(gse_filtered)), value = TRUE, ignore.case = TRUE), 20))
## NOTE: Agilent control probe naming differs from Affymetrix AFFX- convention.
## Inspect the printed patterns above and confirm whether any need excluding.

## ---- 6. SIGNIFICANCE SUMMARY ----
cat("\n=== Significant gene counts per contrast (padj<0.05, |logFC|>1) ===\n")
for (cn in names(all_results_list)) {
    r <- all_results_list[[cn]]
    n_sig <- sum(r$adj.P.Val < 0.05 & abs(r$logFC) > 1, na.rm = TRUE)
    cat(cn, "—", n_sig, "significant genes\n")
}

## ---- 7. FIGURE: PCA (post-exclusion) ----
pca_res <- prcomp(t(exprs(gse_filtered)), scale. = TRUE)
pca_data <- data.frame(pca_res$x, Dose = factor(sample_info_filtered$Dose))
p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Dose)) +
    geom_point(size = 4, alpha = 0.8) + theme_minimal() +
    labs(title = "E-GEOD-20951 PCA (post-outlier-exclusion, n=11)")
if (!dir.exists("figures")) dir.create("figures")
ggsave("figures/E-GEOD-20951_Fig1_PCA.pdf", p1, width = 7, height = 5)
ggsave("figures/E-GEOD-20951_Fig1_PCA.png", p1, width = 7, height = 5)

## ---- 8. FIGURE: canonical gene dose curves ----
canon_probes <- probe_to_gene[probe_to_gene$Symbol %in% canon_genes, ]
canon_expr <- exprs(gse_filtered)[canon_probes$Probe_ID, , drop = FALSE]
rownames(canon_expr) <- canon_probes$Symbol[match(rownames(canon_expr), canon_probes$Probe_ID)]
canon_melt <- melt(canon_expr); colnames(canon_melt) <- c("Symbol","Sample_ID","Expression")
canon_melt <- merge(canon_melt, sample_info_filtered, by.x = "Sample_ID", by.y = "Sample_ID")

p2 <- ggplot(canon_melt, aes(x = Dose, y = Expression, color = Symbol)) +
    geom_point(size = 2, alpha = 0.7) + geom_smooth(method = "loess", se = FALSE) +
    facet_wrap(~Symbol, scales = "free_y") + theme_minimal() +
    labs(title = "Canonical Genes — E-GEOD-20951 (hESCs)", x = "Dose (Gy)", y = "Log2 Ratio (vs pooled reference)")
ggsave("figures/E-GEOD-20951_Fig2_Canonical.pdf", p2, width = 9, height = 6)
ggsave("figures/E-GEOD-20951_Fig2_Canonical.png", p2, width = 9, height = 6)

## ---- 9. SESSION INFO ----
writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-20951_STEP2.txt")

cat("\n===========================================\n")
cat("STEP 2 COMPLETE. Review canonical gene checkpoint and significance\n")
cat("summary above before treating any contrast as a locked deliverable.\n")
cat("Remember: hESCs are your SENSITIVITY CHECK dataset, not core weight —\n")
cat("results here support/challenge your discovery signature, not replace it.\n")
cat("===========================================\n")

cat("CONTROL_TYPE unique values:\n")
print(table(feature_info$CONTROL_TYPE))

canon_probe_ids <- probe_to_gene$Probe_ID[probe_to_gene$Symbol %in% canon_genes]
cat("Any canonical gene probes flagged as controls?",
    sum(feature_info$CONTROL_TYPE[match(canon_probe_ids, rownames(feature_info))] != "FALSE"), "\n")

# Confirm significance counts don't change when restricted to real probes only
real_probe_ids <- rownames(feature_info)[feature_info$CONTROL_TYPE == "FALSE"]
for (cn in names(all_results_list)) {
    r <- all_results_list[[cn]]
    r_real <- r[r$Probe_ID %in% real_probe_ids, ]
    n_sig <- sum(r_real$adj.P.Val < 0.05 & abs(r_real$logFC) > 1, na.rm = TRUE)
    cat(cn, "— significant genes among REAL probes only:", n_sig, "\n")
}
