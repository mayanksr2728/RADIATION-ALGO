#############################################################
# E-GEOD-21748 DISCOVERY COHORT PIPELINE — CLEAN REBUILD
# Radiation timecourse: MCF7 cells, 6 Gy, Day0-Day4, 4 reps/timepoint
# Run this top to bottom in a FRESH R session (no leftover objects)
#############################################################

## ---- 0. PACKAGE INSTALLATION (run once; skip if already installed) ----
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("GEOquery", "limma", "Biobase"), update = FALSE, ask = FALSE)
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("reshape2", quietly = TRUE)) install.packages("reshape2")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("gridExtra", quietly = TRUE)) install.packages("gridExtra")
if (!requireNamespace("pheatmap", quietly = TRUE)) install.packages("pheatmap")

library(GEOquery)
library(limma)
library(Biobase)
library(ggplot2)
library(reshape2)
library(tidyr)
library(gridExtra)
library(pheatmap)

if (!dir.exists("figures")) dir.create("figures")

## ---- 1. DOWNLOAD DATA (fresh, single load) ----
geo_data <- getGEO("GSE21748", GSEMatrix = TRUE)
stopifnot(class(geo_data) == "list", length(geo_data) == 1)  # sanity check on structure

gse <- geo_data[[1]]
stopifnot(class(gse) == "ExpressionSet")  # must be an ExpressionSet before continuing

cat("Loaded ExpressionSet with", nrow(exprs(gse)), "features and", ncol(exprs(gse)), "samples\n")

## ---- 2. CHECK RAW SCALE, THEN LOG2 TRANSFORM EXACTLY ONCE ----
raw_range <- range(exprs(gse))
cat("Raw expression range (should be ~88 to ~62000):", raw_range, "\n")
stopifnot(raw_range[2] > 1000)  # confirms this is raw intensity, NOT already logged

exprs(gse) <- log2(exprs(gse))

logged_range <- range(exprs(gse))
cat("Post-log2 range (should be ~6.47 to ~15.92):", logged_range, "\n")
stopifnot(logged_range[2] < 20)  # confirms single log2, would be ~4 if double-logged

## ---- 3. BUILD SAMPLE METADATA ----
metadata <- pData(gse)
sample_info <- data.frame(
    Sample_ID = metadata$geo_accession,
    Title     = metadata$title
)
sample_info$TimePoint <- sub("_.*", "", sample_info$Title)
sample_info$Replicate <- sub(".*_", "", sample_info$Title)
write.csv(sample_info, "final_sample_table.csv", row.names = FALSE)
print(sample_info)

## ---- 4. LIMMA DIFFERENTIAL EXPRESSION ----
time_factor <- factor(sample_info$TimePoint, levels = c("Day0","Day1","Day2","Day3","Day4"))
design_matrix <- model.matrix(~ 0 + time_factor)
colnames(design_matrix) <- levels(time_factor)

fit <- lmFit(exprs(gse), design_matrix)
contrast_matrix <- makeContrasts(
    Day1_vs_Day0 = Day1 - Day0,
    Day2_vs_Day0 = Day2 - Day0,
    Day3_vs_Day0 = Day3 - Day0,
    Day4_vs_Day0 = Day4 - Day0,
    levels = design_matrix
)
fit2 <- contrasts.fit(fit, contrast_matrix)
fit2 <- eBayes(fit2)

all_genes <- topTable(fit2, number = Inf, adjust.method = "BH")
all_genes$Probe_ID <- rownames(all_genes)

## ---- 5. MAP PROBES TO GENE SYMBOLS ----
feature_info <- fData(gse)
probe_to_gene <- data.frame(Probe_ID = rownames(feature_info), Symbol = feature_info$Symbol)
all_genes_named <- merge(probe_to_gene, all_genes, by = "Probe_ID")
write.csv(all_genes_named, "all_statistical_results_named.csv", row.names = FALSE)

cat("Total genes tested:", nrow(all_genes_named), "(should be 22184)\n")

## ---- 6. P-VALUE HISTOGRAM QC CHECK ----
pdf("figures/pvalue_histogram.pdf", width = 7, height = 5)
hist(all_genes_named$P.Value, breaks = 50, col = "aquamarine3",
     main = "Raw P-Value Distribution (limma)",
     xlab = "Unadjusted P-Values", ylab = "Frequency")
dev.off()

p_hist <- hist(all_genes_named$P.Value, breaks = 10, plot = FALSE)
print(data.frame(
    P_Value_Range = paste0(p_hist$breaks[-length(p_hist$breaks)], " to ", p_hist$breaks[-1]),
    Gene_Count = p_hist$counts
))

## ---- 7. CANONICAL GENE SANITY CHECK ----
canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
sanity_check <- all_genes_named[all_genes_named$Symbol %in% canon_genes,
    c("Symbol","Probe_ID","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0","adj.P.Val")]
print(sanity_check[order(sanity_check$Symbol), ])
cat("\nExpected: CDKN1A ILMN_1784602 Day1 ~2.16, adj.P.Val ~1.6e-11\n")
cat("Expected: BAX adj.P.Val ~0.24 (non-significant)\n\n")

## ---- 8. STRICT SIGNIFICANT GENE FILTER (LOCKED DELIVERABLE) ----
get_pattern <- function(d1, d4) {
    if (d1 > 0.5 & d4 > 0.5) return("Sustained_Up")
    if (d1 > 0.5 & d4 <= 0.5) return("Early_Up_Transient")
    if (d1 <= 0.5 & d4 > 0.5) return("Late_Up")
    if (d1 < -0.5 & d4 < -0.5) return("Sustained_Down")
    if (d1 < -0.5 & d4 >= -0.5) return("Early_Down_Transient")
    if (d1 >= -0.5 & d4 < -0.5) return("Late_Down")
    return("Complex_Pattern")
}

fc_threshold <- 1
passing_fc <- apply(abs(all_genes_named[, c("Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0")]), 1, max) > fc_threshold
sig_genes_strict <- all_genes_named[all_genes_named$adj.P.Val < 0.05 & passing_fc, ]
sig_genes_strict$Trajectory_Group <- mapply(get_pattern, sig_genes_strict$Day1_vs_Day0, sig_genes_strict$Day4_vs_Day0)

cat("Strict significant gene count (MUST be 1366):", nrow(sig_genes_strict), "\n")
stopifnot(nrow(sig_genes_strict) == 1366)  # hard stop if this doesn't match

print(table(sig_genes_strict$Trajectory_Group))

## Save with explicit row.names=FALSE to avoid the "X","x" corruption bug
write.csv(sig_genes_strict, "final_discovery_cohort_genes_LOCKED.csv", row.names = FALSE)

## Verify the save itself is clean
check <- read.csv("final_discovery_cohort_genes_LOCKED.csv")
cat("Reloaded file rows (must be 1366):", nrow(check), "\n")
cat("Reloaded file columns (must NOT be 'X','x'):\n")
print(colnames(check))
stopifnot(!identical(colnames(check), c("X","x")))

## ---- 9. FIGURE 1: PCA ----
pca_res <- prcomp(t(exprs(gse)), scale. = TRUE)
pca_data <- data.frame(Sample_ID = rownames(pca_res$x), pca_res$x, TimePoint = sample_info$TimePoint)

p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = TimePoint)) +
    geom_point(size = 4, alpha = 0.8) +
    theme_minimal() +
    labs(title = "PCA Plot of 20 Samples",
         x = paste0("PC1 (", round(summary(pca_res)$importance[2,1]*100, 1), "%)"),
         y = paste0("PC2 (", round(summary(pca_res)$importance[2,2]*100, 1), "%)"))
ggsave("figures/Fig1_PCA_Plot.pdf", plot = p1, width = 6, height = 5)
ggsave("figures/Fig1_PCA_Plot.png", plot = p1, width = 6, height = 5)

## ---- 10. FIGURE 2: EXPRESSION BOXPLOT ----
melted_exprs <- melt(exprs(gse))
colnames(melted_exprs) <- c("Probe_ID", "Sample_ID", "Expression")
melted_exprs <- merge(melted_exprs, sample_info, by = "Sample_ID")

p2 <- ggplot(melted_exprs, aes(x = Sample_ID, y = Expression, fill = TimePoint)) +
    geom_boxplot(outlier.size = 0.5) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Expression Distribution Per Sample", x = "Samples", y = "Log2 Expression")
ggsave("figures/Fig2_Expression_Boxplot.pdf", plot = p2, width = 8, height = 5)
ggsave("figures/Fig2_Expression_Boxplot.png", plot = p2, width = 8, height = 5)

## ---- 11. FIGURE 3: SAMPLE CORRELATION HEATMAP ----
cor_matrix <- cor(exprs(gse))
annotation_col <- data.frame(TimePoint = sample_info$TimePoint)
rownames(annotation_col) <- sample_info$Sample_ID

pheatmap(cor_matrix, annotation_col = annotation_col,
         main = "Sample-to-Sample Correlation Heatmap",
         filename = "figures/Fig3_Sample_Correlation.pdf", width = 7, height = 6)
pheatmap(cor_matrix, annotation_col = annotation_col,
         main = "Sample-to-Sample Correlation Heatmap",
         filename = "figures/Fig3_Sample_Correlation.png", width = 7, height = 6)

## ---- 12. FIGURE 4: BEFORE/AFTER LOG2 DENSITY ----
exprs_before <- 2^(exprs(gse))
df_before <- data.frame(Expression = as.vector(exprs_before))
df_after  <- data.frame(Expression = as.vector(exprs(gse)))

p4_a <- ggplot(df_before, aes(x = Expression)) +
    geom_density(fill = "tomato", alpha = 0.6) + theme_minimal() +
    labs(title = "Before Log2 Transform", x = "Raw Intensity") + xlim(0, 5000)
p4_b <- ggplot(df_after, aes(x = Expression)) +
    geom_density(fill = "aquamarine3", alpha = 0.6) + theme_minimal() +
    labs(title = "After Log2 Transform", x = "Log2 Intensity")

p4 <- grid.arrange(p4_a, p4_b, ncol = 2)
ggsave("figures/Fig4_Log2_Comparison.pdf", plot = p4, width = 8, height = 4)
ggsave("figures/Fig4_Log2_Comparison.png", plot = p4, width = 8, height = 4)

## ---- 13. FIGURE 5: VOLCANO PLOTS (matched to strict set) ----
volc_data <- all_genes_named[, c("Probe_ID","Symbol","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0")]
volc_long <- gather(volc_data, Contrast, Log2FC, Day1_vs_Day0:Day4_vs_Day0)
volc_long$adj.P.Val <- all_genes_named$adj.P.Val[match(volc_long$Probe_ID, all_genes_named$Probe_ID)]
volc_long$Significance <- ifelse(volc_long$Probe_ID %in% sig_genes_strict$Probe_ID, "Significant", "Not Significant")

p5 <- ggplot(volc_long, aes(x = Log2FC, y = -log10(adj.P.Val), color = Significance)) +
    geom_point(alpha = 0.5, size = 0.8) +
    facet_wrap(~Contrast, ncol = 2) +
    scale_color_manual(values = c("grey70", "firebrick3")) +
    theme_minimal() +
    labs(title = "Volcano Plots Across Timepoints (Matched to Strict Set)",
         x = "Log2 Fold Change", y = "-log10(Adj. P-Value)")
ggsave("figures/Fig5_Volcano_Plots.pdf", plot = p5, width = 8, height = 7)
ggsave("figures/Fig5_Volcano_Plots.png", plot = p5, width = 8, height = 7)

## ---- 14. FIGURE 6: PROBE-LEVEL TRAJECTORY PLOT (per-probe, significance-annotated) ----
plot_data <- all_genes_named[all_genes_named$Symbol %in% canon_genes,
    c("Symbol","Probe_ID","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0","adj.P.Val")]
cat("\nCanonical gene rows for Fig6 (should be 9):", nrow(plot_data), "\n")

plot_long <- data.frame(
    Symbol     = rep(plot_data$Symbol, 5),
    Probe_ID   = rep(plot_data$Probe_ID, 5),
    adj.P.Val  = rep(plot_data$adj.P.Val, 5),
    Day        = rep(c(0,1,2,3,4), each = nrow(plot_data)),
    Expression = c(
        rep(0, nrow(plot_data)),
        plot_data$Day1_vs_Day0, plot_data$Day2_vs_Day0,
        plot_data$Day3_vs_Day0, plot_data$Day4_vs_Day0
    )
)

label_data <- subset(plot_long, Day == 4)
label_data$p_label <- formatC(label_data$adj.P.Val, format = "e", digits = 1)

bax_ann <- data.frame(
    Symbol = "BAX", Day = 2,
    Expression = max(plot_long$Expression[plot_long$Symbol == "BAX"]) + 0.02,
    label = "Not significant\n(adj.P.Val = 0.24)"
)

p6 <- ggplot(plot_long, aes(x = Day, y = Expression, color = Probe_ID)) +
    geom_point(aes(alpha = ifelse(adj.P.Val < 0.05, 0.8, 0.3)), size = 2) +
    geom_line(aes(linetype = ifelse(adj.P.Val < 0.05, "solid", "dashed"),
                  alpha = ifelse(adj.P.Val < 0.05, 1.0, 0.4)), linewidth = 1.1) +
    geom_text(data = label_data, aes(label = p_label),
              hjust = -0.15, vjust = 0.5, size = 2.8, show.legend = FALSE) +
    geom_text(data = bax_ann, aes(x = Day, y = Expression, label = label),
              color = "firebrick", fontface = "italic", size = 3.2, inherit.aes = FALSE) +
    scale_linetype_identity() +
    scale_alpha_identity() +
    facet_wrap(~Symbol, scales = "free_y") +
    scale_x_continuous(breaks = 0:4, expand = expansion(mult = c(0.05, 0.3))) +
    theme_minimal() +
    theme(strip.text = element_text(face = "bold", size = 11),
          legend.text = element_text(size = 8), legend.title = element_text(face = "bold", size = 9)) +
    labs(title = "Probe-Level Trajectories of Radiation Checkpoint Monitors",
         subtitle = "Solid lines: adj.P.Val < 0.05 | Dashed lines: Non-significant",
         x = "Day", y = "Log2 Fold Change (Relative to Day 0)", color = "Probe ID")
ggsave("figures/Fig6_Target_Tracks.pdf", plot = p6, width = 9, height = 6)
ggsave("figures/Fig6_Target_Tracks.png", plot = p6, width = 9, height = 6)

## ---- 15. FIGURE 7: TOP 50 HEATMAP ----
top_50_probes <- sig_genes_strict$Probe_ID[order(sig_genes_strict$adj.P.Val)][1:50]
heatmap_matrix <- exprs(gse)[top_50_probes, ]
rownames(heatmap_matrix) <- all_genes_named$Symbol[match(rownames(heatmap_matrix), all_genes_named$Probe_ID)]

pheatmap(heatmap_matrix, scale = "row", annotation_col = annotation_col, show_colnames = FALSE,
         main = "Top 50 Strictly Significant Differential Genes Across Timepoints",
         filename = "figures/Fig7_Discovery_Heatmap.pdf", width = 7, height = 8)
pheatmap(heatmap_matrix, scale = "row", annotation_col = annotation_col, show_colnames = FALSE,
         main = "Top 50 Strictly Significant Differential Genes Across Timepoints",
         filename = "figures/Fig7_Discovery_Heatmap.png", width = 7, height = 8)

## ---- 16. SESSION INFO (save for reproducibility record) ----
writeLines(capture.output(sessionInfo()), "session_info_E-GEOD-21748.txt")

cat("\n===========================================\n")
cat("PIPELINE COMPLETE.\n")
cat("Locked deliverable: final_discovery_cohort_genes_LOCKED.csv (", nrow(sig_genes_strict), "genes )\n")
cat("Figures saved in figures/ (Fig1-Fig7)\n")
cat("===========================================\n")
