# ==============================================================================
# scripts/04_tcga_clinical_survival.R
# Clinical Validation: TCGA-HNSC Negative Control Survival Audit
# ==============================================================================

# ---- 1. SETUP ----
suppressPackageStartupMessages({
  library(TCGAbiolinks)
  library(SummarizedExperiment)
  library(survival)
  library(dplyr)
})

# Load the 52-gene robust core identified in the human meta-analysis
if (!file.exists("outputs/loco_robust_core_52.csv")) {
  stop("Input file 'outputs/loco_robust_core_52.csv' not found. Run scripts/02_loco_meta_analysis.R first.")
}
robust_core <- read.csv("outputs/loco_robust_core_52.csv")$Symbol

# ==============================================================================
# STAGE 2: TCGA DATA ACQUISITION (WITH CACHING)
# ==============================================================================

cat("\n[STAGE 2] Retrieving TCGA-HNSC Transcriptomic and Clinical Data...\n")
cache_file <- "outputs/tcga_hnsc.rds"

if (!file.exists(cache_file)) {
  cat("Cache not found. Querying GDC API...\n")
  query <- GDCquery(
    project = "TCGA-HNSC",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
  )
  GDCdownload(query)
  data <- GDCprepare(query)
  
  if (!dir.exists("outputs")) dir.create("outputs")
  saveRDS(data, cache_file)
  cat("Data downloaded and cached to outputs/tcga_hnsc.rds\n")
} else {
  cat("Loading cached TCGA-HNSC data from outputs/tcga_hnsc.rds\n")
  data <- readRDS(cache_file)
}

# ==============================================================================
# STAGE 3: EXPRESSION PROCESSING & RISK SCORING
# ==============================================================================

cat("\n[STAGE 3] Processing Expression Matrix (TPM Normalization & Scaling)...\n")

# Extract unstranded TPM matrix and gene symbol mappings
expr_tpm <- assay(data, "tpm_unstrand")
gene_symbols <- rowData(data)$gene_name

# Subset for robust core genes present in TCGA
matched_idx <- which(gene_symbols %in% robust_core)
tcga_sub_tpm <- expr_tpm[matched_idx, ]
sub_symbols <- gene_symbols[matched_idx]

# Collapse duplicate gene symbols by taking row sums prior to scaling
tcga_sub_tpm <- rowsum(tcga_sub_tpm, group = sub_symbols)

# Log2 transformation followed by per-gene z-score scaling across patients
tcga_log_tpm <- log2(tcga_sub_tpm + 1)
tcga_z_tpm <- t(scale(t(tcga_log_tpm)))

# Calculate composite patient signature risk scores (mean of scaled expression)
sig_score_tpm <- colMeans(tcga_z_tpm, na.rm = TRUE)

# ==============================================================================
# STAGE 4: CLINICAL SURVIVAL WRANGLING
# ==============================================================================

cat("\n[STAGE 4] Constructing Survival Dataframe...\n")

clinical <- as.data.frame(colData(data))

# Extract Demographics and Survival Metrics
df_surv <- data.frame(
  patient_id = clinical$patient,
  status     = ifelse(clinical$vital_status %in% c("Dead", "DECEASED"), 1, 0),
  days_death = suppressWarnings(as.numeric(as.character(clinical$days_to_death))),
  days_follow = suppressWarnings(as.numeric(as.character(clinical$days_to_last_follow_up))),
  age        = clinical$age_at_index,
  gender     = clinical$gender,
  Sig_Score  = sig_score_tpm[rownames(clinical)]
)

# Calculate Time in months (using standard 30.4375 factor)
df_surv$time <- ifelse(!is.na(df_surv$days_death) & df_surv$days_death > 0, 
                        df_surv$days_death, 
                        df_surv$days_follow) / 30.4375

# Filter for valid survival metrics
df_surv <- df_surv %>% filter(!is.na(time) & time > 0 & !is.na(Sig_Score))

cat(paste("Total patients analyzed with valid survival data:", nrow(df_surv), "\n"))

# ==============================================================================
# STAGE 5: COX PROPORTIONAL HAZARDS MODELING
# ==============================================================================

cat("\n[STAGE 5] Executing Cox Proportional Hazards Models...\n")

# Model 1: Unadjusted Continuous Cox
cox_unadj <- coxph(Surv(time, status) ~ Sig_Score, data = df_surv)
cat("\n--- MODEL 1: UNADJUSTED COX (TPM-NORMALIZED) ---\n")
print(summary(cox_unadj))

# Model 2: Multivariate Adjusted Cox (Age + Gender)
cox_adj <- coxph(Surv(time, status) ~ Sig_Score + age + gender, data = df_surv)
cat("\n--- MODEL 2: MULTIVARIATE COX (ADJUSTED FOR AGE/SEX) ---\n")
print(summary(cox_adj))

# ==============================================================================
# STAGE 6: DATA EXPORT
# ==============================================================================

cat("\nSaving survival analysis summaries to outputs/...\n")
tcga_results <- list(unadjusted = summary(cox_unadj), multivariate = summary(cox_adj))
saveRDS(tcga_results, "outputs/04_tcga_cox_results.rds")

cat("Success: outputs/04_tcga_cox_results.rds saved. Pipeline complete.\n")
