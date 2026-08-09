# ==============================================================================
# scripts/01_data_preprocessing.R
# Preprocessing of Human Discovery Cohorts for Meta-Analysis
# ==============================================================================

# ---- 1. LIBRARY LOADING ----
suppressPackageStartupMessages({
    library(GEOquery)
    library(limma)
    library(DESeq2)
    library(org.Hs.eg.db)
    library(clusterProfiler)
    library(dplyr)
    library(splines)
})

# Source utility functions for meta-analysis
source("R/utils_meta_analysis.R")

# ==============================================================================
# STAGE 2: COHORT PROCESSING
# ==============================================================================

# 2.1 E-GEOD-21748: MCF7 Time-Course (Illumina)
cat("\nProcessing E-GEOD-21748...\n")
geo_21748 <- getGEO("GSE21748", GSEMatrix = TRUE)[[1]]
exprs(geo_21748) <- log2(exprs(geo_21748))
metadata_21748 <- pData(geo_21748)

metadata_21748$TimePoint <- factor(sub("_.*", "", metadata_21748$title))
design_21748 <- model.matrix(~ 0 + TimePoint, data = metadata_21748)
colnames(design_21748) <- levels(metadata_21748$TimePoint)

fit_21748 <- lmFit(exprs(geo_21748), design_21748)
cont_21748 <- makeContrasts(Day4_vs_Day0 = Day4 - Day0, levels = design_21748)
fit2_21748 <- eBayes(contrasts.fit(fit_21748, cont_21748))

d1 <- topTable(fit2_21748, number = Inf) %>%
    mutate(Symbol = fData(geo_21748)$Symbol,
           Direction = sign(logFC),
           PValue = adj.P.Val,
           Dataset = "Discovery")

# 2.2 GSE120805: Lens Epithelial Dose-Response (RNA-Seq)
cat("Processing GSE120805...\n")
getGEOSuppFiles("GSE120805")
counts_raw <- read.table("GSE120805/GSE120805_2016HLECountTable.txt.gz", 
                         header = TRUE, row.names = 1, check.names = FALSE)

gse_meta <- getGEO("GSE120805", GSEMatrix = TRUE)[[1]]
sample_data <- pData(gse_meta)

# Extract numeric values from characteristics columns
sample_data$dose <- as.numeric(sub(".*: ", "", sample_data$characteristics_ch1.1))
sample_data$dose_rate <- factor(sub(".*: ", "", sample_data$characteristics_ch1.2))

# Match samples
common_samples <- intersect(colnames(counts_raw), rownames(sample_data))
counts_raw <- counts_raw[, common_samples]
sample_data <- sample_data[common_samples, ]

dds <- DESeqDataSetFromMatrix(countData = counts_raw, colData = sample_data, 
                              design = ~ dose_rate + splines::ns(log2(dose + 0.005), df = 3))
dds <- DESeq(dds, test = "LRT", reduced = ~ dose_rate)
res_120805 <- as.data.frame(results(dds))

mapping_120805 <- bitr(rownames(res_120805), fromType = "ENSEMBL", toType = "SYMBOL", OrgDb = org.Hs.eg.db)
d2 <- merge(res_120805, mapping_120805, by.x = 0, by.y = "ENSEMBL") %>%
    mutate(Symbol = SYMBOL,
           logFC = log2FoldChange,
           PValue = padj,
           Direction = sign(log2FoldChange),
           Dataset = "GSE120805") %>%
    filter(!is.na(PValue))

# 2.3 GSE59861: Fibroblast Priming (Affymetrix)
cat("Processing GSE59861...\n")
geo_59861 <- getGEO("GSE59861", GSEMatrix = TRUE)[[1]]
exprs(geo_59861) <- log2(exprs(geo_59861) + 1)

metadata_59861 <- pData(geo_59861)
metadata_59861$Group <- factor(make.names(metadata_59861$characteristics_ch1.1))
design_59861 <- model.matrix(~ 0 + Group, data = metadata_59861)
colnames(design_59861) <- levels(metadata_59861$Group)

fit_59861 <- lmFit(exprs(geo_59861), design_59861)
# Ensure contrast terms match actual levels in make.names output
target_contrast <- paste0(colnames(design_59861)[2], " - ", colnames(design_59861)[1])
cont_59861 <- makeContrasts(contrasts = target_contrast, levels = design_59861)
fit2_59861 <- eBayes(contrasts.fit(fit_59861, cont_59861))

d3 <- topTable(fit2_59861, number = Inf) %>%
    mutate(Symbol = fData(geo_59861)$Symbol,
           Direction = sign(logFC),
           PValue = adj.P.Val,
           Dataset = "GSE59861")

# 2.4 E-GEOD-20951: Human ESC (Agilent)
cat("Processing E-GEOD-20951...\n")
geo_20951 <- getGEO("GSE20951", GSEMatrix = TRUE)[[1]]
geo_20951 <- geo_20951[, colnames(exprs(geo_20951)) != "GSM523881"]
exprs(geo_20951) <- log2(exprs(geo_20951) + 1)

metadata_20951 <- pData(geo_20951)
metadata_20951$Dose <- factor(make.names(metadata_20951$characteristics_ch1))
design_20951 <- model.matrix(~ 0 + Dose, data = metadata_20951)
colnames(design_20951) <- levels(metadata_20951$Dose)

fit_20951 <- lmFit(exprs(geo_20951), design_20951)
# Explicit contrast between highest dose and baseline level
dose_levels <- colnames(design_20951)
contrast_str <- paste0(dose_levels[length(dose_levels)], " - ", dose_levels[1])
cont_20951 <- makeContrasts(contrasts = contrast_str, levels = design_20951)
fit2_20951 <- eBayes(contrasts.fit(fit_20951, cont_20951))

d4 <- topTable(fit2_20951, number = Inf) %>%
    mutate(Symbol = fData(geo_20951)$Symbol,
           Direction = sign(logFC),
           PValue = adj.P.Val,
           Dataset = "E-GEOD-20951")

# ==============================================================================
# STAGE 3: STANDARDIZATION & EXPORT
# ==============================================================================

cat("\nConsolidating evidence table...\n")
all_evidence <- rbind(
    d1[, c("Symbol", "logFC", "PValue", "Direction", "Dataset")],
    d2[, c("Symbol", "logFC", "PValue", "Direction", "Dataset")],
    d3[, c("Symbol", "logFC", "PValue", "Direction", "Dataset")],
    d4[, c("Symbol", "logFC", "PValue", "Direction", "Dataset")]
)

all_evidence <- all_evidence[!is.na(all_evidence$Symbol) & all_evidence$Symbol != "", ]

cat("Collapsing multi-probe entries...\n")
ev_collapsed <- collapse_probes(all_evidence)

if (!dir.exists("outputs")) dir.create("outputs")
saveRDS(ev_collapsed, "outputs/01_evidence_table.rds")
cat("Success: outputs/01_evidence_table.rds saved successfully.\n")
