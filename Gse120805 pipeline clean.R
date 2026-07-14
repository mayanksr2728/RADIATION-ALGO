#############################################################
# GSE120805 DOSE-RESPONSE PIPELINE — CLEAN REBUILD
# Human lens epithelial cells, 0-5 Gy, 2 dose rates, 20h timepoint, n=70
# Run this top to bottom in a FRESH R session (no leftover objects)
#############################################################

## ---- 0. PACKAGE INSTALLATION ----
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("GEOquery", "DESeq2", "clusterProfiler", "org.Hs.eg.db"),
                      update = FALSE, ask = FALSE)
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("drc", quietly = TRUE)) install.packages("drc")

library(GEOquery)
library(DESeq2)
library(ggplot2)
library(clusterProfiler)
library(org.Hs.eg.db)
library(drc)

if (!dir.exists("figures")) dir.create("figures")

## ---- 1. DOWNLOAD REAL METADATA + REAL COUNT MATRIX ----
gse_meta <- getGEO("GSE120805", GSEMatrix = TRUE)
stopifnot(class(gse_meta) == "list", length(gse_meta) == 1)
metadata <- pData(gse_meta[[1]])
cat("Metadata rows (should be 70):", nrow(metadata), "\n")
stopifnot(nrow(metadata) == 70)

getGEOSuppFiles("GSE120805")
count_file <- list.files("GSE120805", pattern = "CountTable", full.names = TRUE)
stopifnot(length(count_file) == 1)
cat("Found count file:", count_file, "\n")

counts_raw <- read.table(count_file, header = TRUE, row.names = 1, check.names = FALSE)
cat("Raw count matrix dims (should be 60766 x 70):", dim(counts_raw), "\n")
stopifnot(nrow(counts_raw) == 60766, ncol(counts_raw) == 70)
stopifnot(all(apply(counts_raw, 2, function(x) all(x == floor(x)))))  # confirms integer counts

## ---- 2. EXPLICITLY MATCH SAMPLES — DO NOT ASSUME ROW ORDER ----
## The count matrix columns are named like "s57", the metadata has this in
## its 'description' field, NOT in the same order as the GSM accessions.
## This step was MISSING in the original session and is added here as a
## mandatory, verified join — never assume positional alignment.
cat("First few count matrix column names:", head(colnames(counts_raw)), "\n")
cat("First few metadata description values:", head(metadata$description), "\n")

match_idx <- match(metadata$description, colnames(counts_raw))
cat("Number of metadata rows with NO match in count matrix (must be 0):", sum(is.na(match_idx)), "\n")
stopifnot(sum(is.na(match_idx)) == 0)

counts_ordered <- counts_raw[, match_idx]
colnames(counts_ordered) <- metadata$geo_accession  # rename to GSM IDs for clarity
stopifnot(identical(colnames(counts_ordered), metadata$geo_accession))
cat("Samples successfully matched and reordered:", ncol(counts_ordered), "\n")

## ---- 3. BUILD VERIFIED SAMPLE METADATA (dose + dose_rate) ----
cat("Available metadata columns:\n")
print(colnames(metadata))

raw_dose <- metadata[["dose:ch1"]]
cat("Unique raw dose values:", unique(raw_dose), "\n")

raw_rate <- metadata[["dose rate:ch1"]]
cat("Unique raw dose rate values:", unique(raw_rate), "\n")
stopifnot(length(unique(raw_rate)) == 2)  # expect exactly 2 dose-rate groups

sample_data <- data.frame(
    sample_id = metadata$geo_accession,
    title     = metadata$title,
    dose_raw  = raw_dose,
    dose      = as.numeric(gsub(" Gy", "", raw_dose)),
    dose_rate = factor(raw_rate)
)
sample_data$dose[is.na(sample_data$dose)] <- 0  # "control" -> 0 Gy

cat("\nFinal dose distribution (should be 10 per level x 7 levels):\n")
print(table(sample_data$dose))
cat("\nDose x dose_rate cross-tab (should be 5 per cell):\n")
print(table(sample_data$dose, sample_data$dose_rate))
stopifnot(nrow(sample_data) == 70, sum(is.na(sample_data$dose)) == 0)

rownames(sample_data) <- sample_data$sample_id
stopifnot(identical(rownames(sample_data), colnames(counts_ordered)))  # final alignment check

## ---- 4. BUILD DESeq2 OBJECT AND APPLY CONSISTENT LOW-COUNT FILTER ----
dds <- DESeqDataSetFromMatrix(
    countData = counts_ordered,
    colData   = sample_data,
    design    = ~ dose_rate + splines::ns(log2(dose + 0.005), df = 3)
)

keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]
cat("\nGenes after low-count filter (this defines our gene universe N):", nrow(dds), "\n")

## Verify size factors landed sensibly before trusting normalization
dds <- estimateSizeFactors(dds)
cat("Size factor summary (should cluster loosely around 1):\n")
print(summary(sizeFactors(dds)))

## ---- 5. PRIMARY DOSE-RESPONSE MODEL (LRT vs dose-rate-only reduced model) ----
dds_primary <- DESeq(dds, test = "LRT", reduced = ~ dose_rate)
res_primary <- results(dds_primary)
cat("\nPrimary dose model summary:\n")
print(summary(res_primary))

sig_primary_genes <- rownames(res_primary)[which(res_primary$padj < 0.1)]
cat("Significant primary dose-responsive genes (verify this count):", length(sig_primary_genes), "\n")

N_universe <- nrow(dds)
cat("Full tested gene universe N:", N_universe, "\n")

## ---- 6. DOSE-RATE INTERACTION MODEL (same filtered gene set) ----
dds_int <- DESeqDataSetFromMatrix(
    countData = counts(dds),  # same filtered counts as primary model
    colData   = sample_data,
    design    = ~ dose_rate * splines::ns(log2(dose + 0.005), df = 3)
)
dds_int <- DESeq(dds_int, test = "LRT",
                  reduced = ~ dose_rate + splines::ns(log2(dose + 0.005), df = 3))
res_int <- results(dds_int)
cat("\nDose-rate interaction model summary:\n")
print(summary(res_int))

rate_sensitive_genes <- rownames(res_int)[which(res_int$padj < 0.1)]
cat("Dose-rate-sensitive genes:", length(rate_sensitive_genes), "\n")

## ---- 7. CANONICAL GENE CHECKPOINT (real ENSG IDs, verified against biology) ----
canon_map <- c(
    BAX     = "ENSG00000087088",
    GADD45A = "ENSG00000116717",
    CDKN1A  = "ENSG00000124762",
    DDB2    = "ENSG00000134574",
    MDM2    = "ENSG00000135679",
    FDXR    = "ENSG00000161513"
)
canon_present <- canon_map[canon_map %in% rownames(res_primary)]
cat("\nCanonical genes present in primary model universe:", length(canon_present), "of 6\n")

canon_results <- data.frame(
    Symbol = names(canon_present),
    ENSG   = canon_present,
    log2FoldChange = res_primary[canon_present, "log2FoldChange"],
    padj           = res_primary[canon_present, "padj"]
)
print(canon_results)

## ---- 8. SAVE LOCKED DELIVERABLES ----
write.csv(as.data.frame(res_primary), "GSE120805_primary_dose_model_FULL.csv", row.names = TRUE)
write.csv(data.frame(ENSG = sig_primary_genes),
          "GSE120805_sig_primary_genes_LOCKED.csv", row.names = FALSE)
write.csv(as.data.frame(res_int), "GSE120805_interaction_model_FULL.csv", row.names = TRUE)
write.csv(data.frame(ENSG = rate_sensitive_genes),
          "GSE120805_rate_sensitive_genes_LOCKED.csv", row.names = FALSE)
write.csv(sample_data, "GSE120805_sample_metadata_VERIFIED.csv", row.names = FALSE)

## Verify saves are clean, not corrupted
check1 <- read.csv("GSE120805_sig_primary_genes_LOCKED.csv")
cat("\nReloaded sig_primary_genes rows:", nrow(check1), "| columns:", colnames(check1), "\n")
stopifnot(!identical(colnames(check1), c("X","x")))

## ---- 9. FIGURE: PCA colored by dose ----
vsd <- vst(dds_primary, blind = FALSE)
pca_res <- prcomp(t(assay(vsd)), scale. = TRUE)
pca_data <- data.frame(pca_res$x, dose = factor(sample_data$dose), dose_rate = sample_data$dose_rate)

p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = dose, shape = dose_rate)) +
    geom_point(size = 3, alpha = 0.8) +
    theme_minimal() +
    labs(title = "GSE120805 PCA — colored by dose, shaped by dose rate")
ggsave("figures/GSE120805_Fig1_PCA.pdf", p1, width = 7, height = 5)
ggsave("figures/GSE120805_Fig1_PCA.png", p1, width = 7, height = 5)

## ---- 10. FIGURE: Canonical gene dose-response curves (real ENSG, labeled) ----
target_matrix <- assay(vsd)[canon_present, , drop = FALSE]
melt_targets <- data.frame(
    ENSG = rep(rownames(target_matrix), ncol(target_matrix)),
    Sample = rep(colnames(target_matrix), each = nrow(target_matrix)),
    Expression = as.vector(target_matrix)
)
melt_targets$Symbol <- names(canon_present)[match(melt_targets$ENSG, canon_present)]
melt_targets <- merge(melt_targets, sample_data, by.x = "Sample", by.y = "sample_id")
melt_targets$Label <- paste0(melt_targets$Symbol, " (", melt_targets$ENSG, ")")
melt_targets$padj_label <- formatC(
    canon_results$padj[match(melt_targets$Symbol, canon_results$Symbol)], format = "e", digits = 1)

p2 <- ggplot(melt_targets, aes(x = dose, y = Expression, color = dose_rate)) +
    geom_point(alpha = 0.6, size = 1.8) +
    geom_smooth(method = "loess", se = FALSE) +
    facet_wrap(~ paste0(Label, "\npadj=", padj_label), scales = "free_y") +
    theme_minimal() +
    theme(strip.text = element_text(size = 8)) +
    labs(title = "Canonical Radiation Response Genes — GSE120805",
         x = "Dose (Gy)", y = "VST Normalized Expression")
ggsave("figures/GSE120805_Fig2_Canonical_Genes.pdf", p2, width = 10, height = 7)
ggsave("figures/GSE120805_Fig2_Canonical_Genes.png", p2, width = 10, height = 7)

## ---- 11. FIGURE: BMD-threshold plot (real dose on log-scaled AXIS, not log-transformed comparison) ----
sig_expr <- assay(vsd)[sig_primary_genes, ]
plot_df <- data.frame(
    Gene = rep(rownames(sig_expr), ncol(sig_expr)),
    Sample = rep(colnames(sig_expr), each = nrow(sig_expr)),
    Expression = as.vector(sig_expr)
)
plot_df <- merge(plot_df, sample_data, by.x = "Sample", by.y = "sample_id")

## For log-scale plotting only, control (0 Gy) samples are nudged to a small
## visual placeholder dose — this is a DISPLAY convenience only, not a data change.
plot_df$dose_for_plot <- ifelse(plot_df$dose == 0, 0.005, plot_df$dose)

p3 <- ggplot(plot_df, aes(x = dose_for_plot, y = Expression, group = Gene)) +
    geom_line(alpha = 0.08, color = "gray40") +
    stat_summary(fun = median, geom = "line", color = "red", linewidth = 1.2, aes(group = 1)) +
    scale_x_log10(breaks = c(0.005, 0.01, 0.05, 0.25, 0.5, 2, 5),
                  labels = c("0 (ctrl)", "0.01", "0.05", "0.25", "0.5", "2", "5")) +
    annotate("rect", xmin = 0.6, xmax = 2.5, ymin = -Inf, ymax = Inf, alpha = 0.15, fill = "blue") +
    theme_minimal() +
    labs(title = paste0("Primary Model Dose-Response: ", length(sig_primary_genes), " Significant Genes"),
         subtitle = "Blue band: literature-reported BMD threshold (0.6-2.5 Gy, Chauhan et al. 2018)",
         x = "Dose (Gy, log scale; 0 Gy shown as placeholder)", y = "VST Normalized Expression")
ggsave("figures/GSE120805_Fig3_BMD_Threshold.pdf", p3, width = 8, height = 6)
ggsave("figures/GSE120805_Fig3_BMD_Threshold.png", p3, width = 8, height = 6)

## ---- 12. FIGURE: Dose-rate interaction, top hit ----
if (length(rate_sensitive_genes) > 0) {
    top_rate_gene <- rate_sensitive_genes[order(res_int[rate_sensitive_genes, "padj"])][1]
    cat("\nTop dose-rate-sensitive gene:", top_rate_gene, "\n")

    gene_expr <- assay(vsd)[top_rate_gene, ]
    plot_gene_df <- data.frame(Sample = names(gene_expr), Expression = gene_expr)
    plot_gene_df <- merge(plot_gene_df, sample_data, by.x = "Sample", by.y = "sample_id")
    plot_gene_df$log_dose <- log2(plot_gene_df$dose + 0.005)

    p4 <- ggplot(plot_gene_df, aes(x = log_dose, y = Expression, color = dose_rate)) +
        geom_point(size = 3) +
        geom_smooth(method = "loess", se = TRUE, span = 0.8) +
        theme_minimal() +
        labs(title = paste("Top Rate-Sensitive Gene:", top_rate_gene),
             x = "log2(Dose + 0.005)", y = "VST Normalized Expression")
    ggsave("figures/GSE120805_Fig4_Rate_Interaction.pdf", p4, width = 7, height = 5)
    ggsave("figures/GSE120805_Fig4_Rate_Interaction.png", p4, width = 7, height = 5)
}

## ---- 13. GO ENRICHMENT on PRIMARY dose-responsive genes (not interaction genes) ----
ego <- enrichGO(gene = sig_primary_genes, OrgDb = org.Hs.eg.db, keyType = "ENSEMBL", ont = "BP")
go_table <- as.data.frame(ego@result[, c("ID", "Description", "p.adjust")])
cat("\nTop GO enrichment terms (primary dose model genes):\n")
print(head(go_table, 15))
write.csv(go_table, "GSE120805_GO_enrichment_primary.csv", row.names = FALSE)

## ---- 14. CROSS-COHORT VALIDATION (only runs if discovery cohort file is present) ----
discovery_file <- "final_discovery_cohort_genes_LOCKED.csv"
if (file.exists(discovery_file)) {
    e_geod_genes <- read.csv(discovery_file)
    cat("\nLoaded discovery cohort file:", nrow(e_geod_genes), "rows\n")

    unique_symbols <- unique(e_geod_genes$Symbol)
    cat("Unique gene symbols in discovery cohort:", length(unique_symbols), "\n")

    symbols_to_ensg <- bitr(unique_symbols, fromType = "SYMBOL", toType = "ENSEMBL", OrgDb = org.Hs.eg.db)
    all_genes_gse <- rownames(res_primary)
    matched_discovery_genes <- intersect(symbols_to_ensg$ENSEMBL, all_genes_gse)
    cat("Discovery genes present in GSE120805 platform (live count):", length(matched_discovery_genes), "\n")

    n_overlap <- length(intersect(matched_discovery_genes, sig_primary_genes))
    n_discovery <- length(matched_discovery_genes)
    n_validation <- length(sig_primary_genes)
    N <- length(all_genes_gse)

    cat("\nFisher's test inputs (all live-computed):\n")
    cat("n_overlap:", n_overlap, "| n_discovery:", n_discovery,
        "| n_validation:", n_validation, "| N:", N, "\n")

    contingency_table <- matrix(c(
        n_overlap, n_discovery - n_overlap,
        n_validation - n_overlap, N - (n_discovery + n_validation - n_overlap)
    ), nrow = 2, dimnames = list(
        Discovery  = c("In_Discovery", "Not_Discovery"),
        Validation = c("In_Validation", "Not_Validation")
    ))
    print(contingency_table)
    print(fisher.test(contingency_table, alternative = "greater"))
} else {
    cat("\nDiscovery cohort file not found in this directory — skipping cross-cohort step.\n")
    cat("Copy final_discovery_cohort_genes_LOCKED.csv here to enable this step.\n")
}

## ---- 15. SESSION INFO ----
writeLines(capture.output(sessionInfo()), "session_info_GSE120805.txt")

cat("\n===========================================\n")
cat("GSE120805 PIPELINE COMPLETE.\n")
cat("Primary dose-responsive genes:", length(sig_primary_genes), "\n")
cat("Dose-rate-sensitive genes:", length(rate_sensitive_genes), "\n")
cat("Figures saved in figures/\n")
cat("===========================================\n")
