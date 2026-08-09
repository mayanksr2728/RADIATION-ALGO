Reproducibility & Reviewer Guide

This repository contains the complete, modular source code for the radiogenomic transcriptomic meta-analysis pipeline. The core execution scripts are streamlined for pipeline automation and do not include automated package installation commands (install.packages or BiocManager::install). Reviewers must configure their local R environment using the setup instructions below prior to running the pipeline.
1. System & Hardware Requirements
Due to the computational demands of multi-cohort microarrays, DESeq2 spline models, and high-dimensional TCGA STAR-Counts matrices, a modern, updated workstation is required to execute this pipeline without memory allocation failures.
 * Processor (CPU)
   * Minimum: Intel Core i7 / AMD Ryzen 7 (4+ physical cores)
   * Recommended: Apple Silicon (M-series) or Intel i9/Ryzen 9 (8+ cores)
 * System RAM
   * Minimum: 16 GB
   * Recommended: 32 GB or higher
 * Disk Space
   * Minimum: 10 GB free SSD storage
   * Recommended: 25 GB+ NVMe SSD (for cached TCGA .rds files)
 * Network Connection
   * Minimum: Broadband Internet connection
   * Recommended: High-speed connection (required for Stage 1 GEO downloads & Stage 4 GDC API queries)
 * R Environment
   * Minimum: R \ge 4.2.0
   * Recommended: R \ge 4.3.2
2. Environment Setup (One-Time Package Installation)
Run the following setup code block in your R console once before running any pipeline stage scripts. This installs all required CRAN and Bioconductor dependencies.
# ---- ONE-TIME ENVIRONMENT SETUP FOR REVIEWERS ----
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

# CRAN Packages
cran_packages <- c("dplyr", "metap", "survival", "survminer", "splines")
new_cran <- cran_packages[!(cran_packages %in% installed.packages()[,"Package"])]
if(length(new_cran)) install.packages(new_cran)

# Bioconductor Packages
bioc_packages <- c(
    "GEOquery", 
    "limma", 
    "DESeq2", 
    "clusterProfiler", 
    "org.Hs.eg.db", 
    "TCGAbiolinks", 
    "SummarizedExperiment"
)
new_bioc <- bioc_packages[!(bioc_packages %in% installed.packages()[,"Package"])]
if(length(new_bioc)) BiocManager::install(new_bioc)

3. Sequential Execution Workflow
Scripts must be executed in order from the project root directory. Each stage generates cached intermediate objects in the outputs/ directory to preserve computational state across steps.
# Execute Stage 1: Fetch and normalize 4 human discovery cohorts (~5-10 mins depending on network)
source("scripts/01_data_preprocessing.R")

# Execute Stage 2: Fisher meta-aggregation and 4-iteration LOCO cross-validation (~1-2 mins)
source("scripts/02_loco_meta_analysis.R")

# Execute Stage 3: Biological control via Trp53-null mouse tissue audit (< 30 secs)
source("scripts/03_p53_mechanistic_control.R")

# Execute Stage 4: Clinical specificity audit via TCGA-HNSC Cox models (~3-5 mins)
source("scripts/04_tcga_clinical_survival.R")

4. Expected Deliverables Audit Checklist
Upon completion, verify that the following data artifacts exist in your /outputs directory:
 * 01_evidence_table.rds: Standardized logFC and p-value evidence table across all 4 discovery datasets.
 * tier1_genes_full.csv: Candidate genes passing Fisher combined p < 1\times 10^{-5} and 100% directional concordance.
 * loco_robust_core_52.csv: The 52-gene core signature surviving all 4 Leave-One-Cohort-Out exclusions.
 * 03_p53_control_summary.csv: Gene-level response loss metrics in the Trp53-null mouse context.
 * 04_tcga_cox_results.rds: Fitted unadjusted and multivariate Cox Proportional Hazards summary objects.
 * 
