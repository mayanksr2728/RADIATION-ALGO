```r
# ==============================================================================
# scripts/02_loco_meta_analysis.R
# Meta-Aggregation and Leave-One-Cohort-Out (LOCO) Sensitivity Pipeline
# ==============================================================================

# ---- 1. SETUP ----
suppressPackageStartupMessages({
  library(dplyr)
  library(metap)
})

# Source utility functions (run_meta, run_loco_intersections)
source("R/utils_meta_analysis.R")

# Load preprocessed evidence table
if (!file.exists("outputs/01_evidence_table.rds")) {
  stop("Input file 'outputs/01_evidence_table.rds' not found. Run scripts/01_data_preprocessing.R first.")
}
ev_collapsed <- readRDS("outputs/01_evidence_table.rds")

# ==============================================================================
# STAGE 2: PRIMARY TIER-1 META-ANALYSIS
# ==============================================================================

cat("\nExecuting Primary Tier-1 Meta-Analysis...\n")
# Criteria: N_Datasets >= 3, 100% Directional Concordance, Fisher p < 1e-5
tier1_full <- run_meta(ev_collapsed, min_datasets = 3)

cat(paste("Total Tier-1 core genes identified:", nrow(tier1_full), "\n"))

# ==============================================================================
# STAGE 3: LEAVE-ONE-COHORT-OUT (LOCO) CROSS-VALIDATION
# ==============================================================================

cat("\nStarting 4-iteration LOCO Sensitivity Analysis...\n")
datasets_to_test <- unique(ev_collapsed$Dataset)
loo_results_list <- list()

for (excluded_ds in datasets_to_test) {
  cat(paste("  Iteration: Excluding", excluded_ds, "...\n"))
  
  # Subset data excluding the current cohort
  ev_subset <- ev_collapsed %>% filter(Dataset != excluded_ds)
  
  # Execute meta-analysis on the subset
  # Criteria: N_Datasets >= 2 (since one is removed), Concordance, Fisher p < 1e-5
  iteration_res <- run_meta(ev_subset, min_datasets = 2)
  
  # Store resulting symbols for intersection analysis
  loo_results_list[[excluded_ds]] <- iteration_res$Symbol
  
  cat(paste("    Genes passing filter in this iteration:", length(iteration_res$Symbol), "\n"))
}

# Calculate the LOCO robust core (genes surviving all four exclusions)
robust_core <- run_loco_intersections(loo_results_list)

cat(paste("\nLOCO Robust Core Size:", length(robust_core), "genes (survived all exclusions)\n"))

# ==============================================================================
# STAGE 4: DATA EXPORT
# ==============================================================================

cat("\nSaving meta-analysis results to outputs/...\n")

# Save the full Tier-1 signature
write.csv(tier1_full, "outputs/tier1_genes_full.csv", row.names = FALSE)

# Save the robust 52-gene core (Note: count verified in forensic audit)
write.csv(data.frame(Symbol = robust_core), "outputs/loco_robust_core_52.csv", row.names = FALSE)

cat("Success: tier1_genes_full.csv and loco_robust_core_52.csv saved.\n")
```
