# ==============================================================================
# scripts/03_p53_mechanistic_control.R
# Mechanistic Validation: p53-Null Murine Biological Control Audit
# ==============================================================================

# ---- 1. SETUP ----
suppressPackageStartupMessages({
  library(dplyr)
})

# Load the core Tier 1 signature derived from the human meta-analysis
if (!file.exists("outputs/tier1_genes_full.csv")) {
  stop("Input file 'outputs/tier1_genes_full.csv' not found. Run scripts/02_loco_meta_analysis.R first.")
}
tier1_full <- read.csv("outputs/tier1_genes_full.csv")

# File existence check for murine validation dataset
murine_file <- "E-GEOD-56704_Dose80_vs_Sham_FULL.csv"
if (!file.exists(murine_file)) {
  stop(paste("Input file", murine_file, "not found in working directory."))
}

# ==============================================================================
# STAGE 2: MURINE DATA LOADING & SYMBOL NORMALIZATION
# ==============================================================================

cat("\n[STAGE 2] Loading Murine Mechanistic Validation Dataset...\n")
p53_null_df <- read.csv(murine_file)

# Normalize gene symbols to uppercase to align Human symbols with Mouse orthologs
p53_null_df$Symbol_Upper <- toupper(trimws(as.character(p53_null_df$Symbol)))
tier1_full$Symbol_Upper <- toupper(trimws(as.character(tier1_full$Symbol)))

# ==============================================================================
# STAGE 3: FILTERING & MULTI-PROBE COLLAPSING
# ==============================================================================

cat("Filtering for Tier 1 matched genes and collapsing probes...\n")
p53_collapsed <- p53_null_df %>%
  filter(!is.na(Symbol_Upper) & Symbol_Upper %in% tier1_full$Symbol_Upper) %>%
  group_by(Symbol_Upper) %>%
  slice_min(adj.P.Val, with_ties = FALSE) %>%
  ungroup()

# ==============================================================================
# STAGE 4: STATISTICAL AUDIT OF p53-DEPENDENCE
# ==============================================================================

cat("\n[STAGE 4] Executing p53-Dependence Audit...\n")

n_matched <- nrow(p53_collapsed)
if (n_matched == 0) {
  stop("Zero Tier 1 genes matched the murine dataset. Check input column names.")
}

# Calculate metrics: High-confidence genes lose response in p53-null (adj.P.Val > 0.05)
n_loss_response <- sum(p53_collapsed$adj.P.Val > 0.05, na.rm = TRUE)
percent_p53_dependent <- (n_loss_response / n_matched) * 100

cat("------------------------------------------------------------\n")
cat(paste("Tier 1 genes matched in Trp53-null mammary tissue:", n_matched, "\n"))
cat(paste("Genes losing radiation response (adj.P.Val > 0.05):", n_loss_response, "\n"))
cat(paste("Percentage of signature showing p53-dependence:", round(percent_p53_dependent, 2), "%\n"))
cat("------------------------------------------------------------\n")

# ==============================================================================
# STAGE 5: DATA EXPORT
# ==============================================================================

cat("Exporting mechanistic validation summary...\n")

if (!dir.exists("outputs")) dir.create("outputs")
write.csv(p53_collapsed, "outputs/03_p53_control_summary.csv", row.names = FALSE)

cat("Success: outputs/03_p53_control_summary.csv saved.\n")

