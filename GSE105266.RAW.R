#############################################################
> # GSE105266 — STEP 1: DOWNLOAD + METADATA INSPECTION
> # Mouse aorta, 0.05-2.0 Gy, 4h. CROSS-SPECIES check for your discovery signature.
> # Note: canonical human gene symbols (CDKN1A etc.) need MOUSE orthologs
> # (Cdkn1a etc. - different capitalization) - build that mapping explicitly.
> # Run top to bottom in a FRESH R session.
> #############################################################
> 
> ## ---- 0. PACKAGES ----
> if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
> BiocManager::install(c("GEOquery", "limma", "Biobase"), update = FALSE, ask = FALSE)
'getOption("repos")' replaces Bioconductor
standard repositories, see
'help("repositories", package =
"BiocManager")' for details.
Replacement repositories:
    CRAN: https://cran.rstudio.com/
Bioconductor version 3.23 (BiocManager
  1.30.27), R 4.6.0 (2026-04-24 ucrt)
Warning message:
package(s) not installed when version(s)
  same as or greater than current; use
  `force = TRUE` to re-install: 'GEOquery'
  'limma' 'Biobase' 
> if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
> 
> library(GEOquery); library(limma); library(Biobase); library(ggplot2)
> if (!dir.exists("figures")) dir.create("figures")
> 
> ## ---- 1. DOWNLOAD ----
> geo_data <- getGEO("GSE105266", GSEMatrix = TRUE)
Found 1 file(s)
GSE105266_series_matrix.txt.gz
> stopifnot(class(geo_data) == "list")
> cat("Number of platform objects:", length(geo_data), "\n")
Number of platform objects: 1 
> print(names(geo_data))
[1] "GSE105266_series_matrix.txt.gz"
> for (i in seq_along(geo_data)) {
+     cat("\n--- Object", i, "---\n")
+     cat("Samples:", ncol(exprs(geo_data[[i]])), "| Features:", nrow(exprs(geo_data[[i]])), "\n")
+ }

--- Object 1 ---
Samples: 20 | Features: 0 
> 
> gse <- geo_data[[1]]
> stopifnot(class(gse) == "ExpressionSet")
> cat("\n[TENTATIVE] Object 1:", nrow(exprs(gse)), "features,", ncol(exprs(gse)), "samples\n")

[TENTATIVE] Object 1: 0 features, 20 samples
> cat("Manifest expected 20 samples\n")
Manifest expected 20 samples
> 
> ## ---- 2. CHECK RAW SCALE (this is RNA-seq per your manifest — may be raw counts) ----
> raw_range <- range(exprs(gse), na.rm = TRUE)
Warning messages:
1: In min(x, na.rm = na.rm) :
  no non-missing arguments to min; returning Inf
2: In max(x, na.rm = na.rm) :
  no non-missing arguments to max; returning -Inf
> cat("\nRaw expression range:", raw_range, "\n")

Raw expression range: Inf -Inf 
> cat("If this looks like raw counts (large integers, min near 0), do NOT log2 --\n")
If this looks like raw counts (large integers, min near 0), do NOT log2 --
> cat("counts need proper count-based normalization (DESeq2-style), not a log transform.\n")
counts need proper count-based normalization (DESeq2-style), not a log transform.
> 
> ## ---- 3. INSPECT METADATA ----
> metadata <- pData(gse)
> cat("\nAvailable metadata columns:\n"); print(colnames(metadata))

Available metadata columns:
 [1] "title"                  
 [2] "geo_accession"          
 [3] "status"                 
 [4] "submission_date"        
 [5] "last_update_date"       
 [6] "type"                   
 [7] "channel_count"          
 [8] "source_name_ch1"        
 [9] "organism_ch1"           
[10] "characteristics_ch1"    
[11] "characteristics_ch1.1"  
[12] "characteristics_ch1.2"  
[13] "characteristics_ch1.3"  
[14] "characteristics_ch1.4"  
[15] "characteristics_ch1.5"  
[16] "characteristics_ch1.6"  
[17] "treatment_protocol_ch1" 
[18] "growth_protocol_ch1"    
[19] "molecule_ch1"           
[20] "extract_protocol_ch1"   
[21] "extract_protocol_ch1.1" 
[22] "taxid_ch1"              
[23] "description"            
[24] "data_processing"        
[25] "data_processing.1"      
[26] "data_processing.2"      
[27] "data_processing.3"      
[28] "data_processing.4"      
[29] "platform_id"            
[30] "contact_name"           
[31] "contact_email"          
[32] "contact_phone"          
[33] "contact_laboratory"     
[34] "contact_department"     
[35] "contact_institute"      
[36] "contact_address"        
[37] "contact_city"           
[38] "contact_state"          
[39] "contact_zip/postal_code"
[40] "contact_country"        
[41] "data_row_count"         
[42] "instrument_model"       
[43] "library_selection"      
[44] "library_source"         
[45] "library_strategy"       
[46] "relation"               
[47] "relation.1"             
[48] "supplementary_file_1"   
[49] "age:ch1"                
[50] "developmental stage:ch1"
[51] "genetic alteration:ch1" 
[52] "radiation dose:ch1"     
[53] "radiation:ch1"          
[54] "Sex:ch1"                
[55] "strain:ch1"             
> cat("\nAll sample titles:\n"); print(metadata$title)

All sample titles:
 [1] "Proton0.S1"    "Proton5.S2"   
 [3] "Proton10.S3"   "Proton25.S4"  
 [5] "Proton50.S5"   "Proton75.S6"  
 [7] "Proton100.S7"  "Proton125.S8" 
 [9] "Proton150.S9"  "Proton200.S10"
[11] "Gamma0.S11"    "Gamma5.S12"   
[13] "Gamma10.S13"   "Gamma25.S14"  
[15] "Gamma50.S15"   "Gamma75.S16"  
[17] "Gamma100.S17"  "Gamma125.S18" 
[19] "Gamma150.S19"  "Gamma200.S20" 
> 
> char_cols <- grep("characteristics", colnames(metadata), value = TRUE)
> cat("\nCharacteristics fields:\n")

Characteristics fields:
> for (cc in char_cols) {
+     cat("\n--", cc, "unique values:\n")
+     print(unique(metadata[[cc]]))
+ }

-- characteristics_ch1 unique values:
[1] "strain: C57BL/6"

-- characteristics_ch1.1 unique values:
[1] "developmental stage: adult"

-- characteristics_ch1.2 unique values:
[1] "Sex: male"

-- characteristics_ch1.3 unique values:
[1] "age: 10 to 12 week"

-- characteristics_ch1.4 unique values:
[1] "genetic alteration: wildtype"

-- characteristics_ch1.5 unique values:
[1] "radiation: Proton" "radiation: Gamma" 

-- characteristics_ch1.6 unique values:
 [1] "radiation dose: 0 cGy"  
 [2] "radiation dose: 5 cGy"  
 [3] "radiation dose: 10 cGy" 
 [4] "radiation dose: 25 cGy" 
 [5] "radiation dose: 50 cGy" 
 [6] "radiation dose: 75 cGy" 
 [7] "radiation dose: 100 cGy"
 [8] "radiation dose: 125 cGy"
 [9] "radiation dose: 150 cGy"
[10] "radiation dose: 200 cGy"
> 
> cat("\nOrganism check (must confirm mouse):\n")

Organism check (must confirm mouse):
> print(unique(metadata$organism_ch1))
[1] "Mus musculus"
> 
> ## ---- 4. GENE ANNOTATION CHECK — mouse gene symbols are capitalized differently ----
> ## Human: CDKN1A, BAX, GADD45A (all caps). Mouse: Cdkn1a, Bax, Gadd45a (only first letter caps).
> feature_info <- fData(gse)
> cat("\nFeature/annotation columns:\n"); print(colnames(feature_info))

Feature/annotation columns:
character(0)
> symbol_col <- colnames(feature_info)[grep("symbol|gene_name|GENE", colnames(feature_info), ignore.case = TRUE)][1]
> cat("Auto-detected symbol column:", symbol_col, "\n")
Auto-detected symbol column: NA 
> if (!is.na(symbol_col)) {
+     cat("Sample of actual symbols (check mouse-style capitalization):\n")
+     print(head(feature_info[[symbol_col]], 20))
+ } else {
+     cat("WARNING: no symbol column found automatically — inspect manually:\n")
+     print(head(feature_info, 5))
+ }
WARNING: no symbol column found automatically — inspect manually:
data frame with 0 columns and 0 rows
> 
> ## ---- 5. SAVE RAW PARSE ----
> sample_info_raw <- data.frame(Sample_ID = metadata$geo_accession, Title = metadata$title)
> write.csv(sample_info_raw, "GSE105266_sample_table_RAW_INSPECT_FIRST.csv", row.names = FALSE)
> 
> ## ---- 6. SESSION INFO ----
> writeLines(capture.output(sessionInfo()), "session_info_GSE105266_STEP1.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 1 COMPLETE. STOP HERE.\n")
STEP 1 COMPLETE. STOP HERE.
> cat("Paste back everything above — especially the raw scale (counts vs\n")
Paste back everything above — especially the raw scale (counts vs
> cat("normalized) and the mouse gene symbol format, before any model is built.\n")
normalized) and the mouse gene symbol format, before any model is built.
> cat("===========================================\n")
===========================================
> # Check what supplementary files are actually available for this accession
> gse_supp <- getGEOSuppFiles("GSE105266", makeDirectory = TRUE, fetch_files = FALSE)
> print(gse_supp)
                                                                      fname
1 GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz
                                                                                                                                           url
1 https://ftp.ncbi.nlm.nih.gov/geo/series/GSE105nnn/GSE105266/suppl//GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz
> #############################################################
> # GSE105266 — STEP 2: DOWNLOAD REAL COUNT MATRIX + VERIFY
> # Run in the SAME session as Step 1 (needs: gse, metadata)
> #############################################################
> 
> ## ---- 1. DOWNLOAD THE ACTUAL COUNT FILE ----
> getGEOSuppFiles("GSE105266", makeDirectory = TRUE, fetch_files = TRUE)
                                                                                                               size
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz 906845
                                                                                                             isdir
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz FALSE
                                                                                                             mode
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz  666
                                                                                                                           mtime
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz 2026-07-18 03:08:19
                                                                                                                           ctime
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz 2026-07-18 03:08:15
                                                                                                                           atime
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz 2026-07-18 03:08:19
                                                                                                             exe
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz  no
                                                                                                             uname
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz nikit
                                                                                                             udomain
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz  GAURAV
                                                                                                                                                                                 fname
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz
                                                                                                                                        destdir
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz C:/Users/nikit/Documents/GSE105266
                                                                                                                                                                                                                 filepath
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz
                                                                                                                   GEO
C:/Users/nikit/Documents/GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz GSE105266
> count_file <- list.files("GSE105266", pattern = "gene_counts", full.names = TRUE)
> stopifnot(length(count_file) == 1)
> cat("Found count file:", count_file, "\n")
Found count file: GSE105266/GSE105266_master_list_gene_counts_MIN.sense.Gamma_Proton_radiation.txt.gz 
> 
> counts_raw <- read.table(count_file, header = TRUE, row.names = 1, check.names = FALSE, sep = "\t")
> cat("\nRaw count matrix dims:", dim(counts_raw), "\n")

Raw count matrix dims: 21078 22 
> cat("Column names (should be sample IDs — check these match your 20 GSM samples):\n")
Column names (should be sample IDs — check these match your 20 GSM samples):
> print(colnames(counts_raw))
 [1] "Proton0.S1"     "Proton5.S2"    
 [3] "Proton10.S3"    "Proton25.S4"   
 [5] "Proton50.S5"    "Proton75.S6"   
 [7] "Proton100.S7"   "Proton125.S8"  
 [9] "Proton150.S9"   "Proton200.S10" 
[11] "Gamma0.S11"     "Gamma5.S12"    
[13] "Gamma10.S13"    "Gamma25.S14"   
[15] "Gamma50.S15"    "Gamma75.S16"   
[17] "Gamma100.S17"   "Gamma125.S18"  
[19] "Gamma150.S19"   "Gamma200.S20"  
[21] "geneCoordinate" "geneSymbol"    
> 
> ## ---- 2. CONFIRM THESE ARE REAL RAW COUNTS ----
> cat("\nValue range:", range(counts_raw, na.rm = TRUE), "\n")
Error in FUN(X[[i]], ...) : 
  only defined on a data frame with all numeric-alike variables

> # Split the gene annotation columns from the 20 real sample count columns
> gene_annotation <- counts_raw[, c("geneCoordinate", "geneSymbol")]
> counts_only <- counts_raw[, !(colnames(counts_raw) %in% c("geneCoordinate", "geneSymbol"))]
> 
> cat("Counts-only matrix dims:", dim(counts_only), "(should be 21078 genes x 20 samples)\n")
Counts-only matrix dims: 21078 20 (should be 21078 genes x 20 samples)
> stopifnot(ncol(counts_only) == 20)
> 
> # Now the range check works correctly
> cat("\nValue range:", range(counts_only, na.rm = TRUE), "\n")

Value range: 0 161018 
> cat("Are all values whole numbers (confirms raw counts)?\n")
Are all values whole numbers (confirms raw counts)?
> print(all(counts_only == floor(counts_only), na.rm = TRUE))
[1] TRUE
> 
> # Check gene symbol format directly - mouse style should be like "Cdkn1a" not "CDKN1A"
> cat("\nSample of gene symbols (check mouse-style capitalization):\n")

Sample of gene symbols (check mouse-style capitalization):
> print(head(gene_annotation$geneSymbol, 20))
 [1] "Gnai3" "Cdc45" "H19"   "Scml2" "Apoh" 
 [6] "Narf"  "Cav2"  "Klf6"  "Scmh1" "Cox5a"
[11] "Tbx2"  "Tbx4"  "Ngfr"  "Wnt9a" "Fer"  
[16] "Xpo6"  "Tcfe3" "Axin2" "Baat1" "Gna12"
> 
> # Direct check for your canonical genes in mouse format
> canon_genes_mouse <- c("Bax","Cdkn1a","Ddb2","Fdxr","Gadd45a","Mdm2")
> for (g in canon_genes_mouse) {
+     cat(g, "found:", sum(gene_annotation$geneSymbol == g, na.rm = TRUE), "times\n")
+ }
Bax found: 1 times
Cdkn1a found: 1 times
Ddb2 found: 1 times
Fdxr found: 1 times
Gadd45a found: 1 times
Mdm2 found: 1 times
> #############################################################
> # GSE105266 — STEP 3: FORMAL DOSE-RESPONSE MODEL
> # Run in the SAME session (needs: counts_only, gene_annotation, metadata)
> # Mouse aorta, 10 dose levels x 2 radiation types (Gamma, Proton), n=20
> #############################################################
> 
> if (!requireNamespace("DESeq2", quietly = TRUE)) BiocManager::install("DESeq2", update=FALSE, ask=FALSE)
> library(DESeq2); library(ggplot2)
Loading required package: S4Vectors
Loading required package: stats4

Attaching package: ‘S4Vectors’

The following object is masked from ‘package:utils’:

    findMatches

The following objects are masked from ‘package:base’:

    expand.grid, I, unname

Loading required package: IRanges

Attaching package: ‘IRanges’

The following object is masked from ‘package:grDevices’:

    windows

Loading required package: GenomicRanges
Loading required package: Seqinfo
Loading required package: SummarizedExperiment
Loading required package: MatrixGenerics
Loading required package: matrixStats

Attaching package: ‘matrixStats’

The following objects are masked from ‘package:Biobase’:

    anyMissing, rowMedians


Attaching package: ‘MatrixGenerics’

The following objects are masked from ‘package:matrixStats’:

    colAlls, colAnyNAs, colAnys,
    colAvgsPerRowSet, colCollapse,
    colCounts, colCummaxs, colCummins,
    colCumprods, colCumsums, colDiffs,
    colIQRDiffs, colIQRs,
    colLogSumExps, colMadDiffs,
    colMads, colMaxs, colMeans2,
    colMedians, colMins,
    colOrderStats, colProds,
    colQuantiles, colRanges, colRanks,
    colSdDiffs, colSds, colSums2,
    colTabulates, colVarDiffs,
    colVars, colWeightedMads,
    colWeightedMeans,
    colWeightedMedians,
    colWeightedSds, colWeightedVars,
    rowAlls, rowAnyNAs, rowAnys,
    rowAvgsPerColSet, rowCollapse,
    rowCounts, rowCummaxs, rowCummins,
    rowCumprods, rowCumsums, rowDiffs,
    rowIQRDiffs, rowIQRs,
    rowLogSumExps, rowMadDiffs,
    rowMads, rowMaxs, rowMeans2,
    rowMedians, rowMins,
    rowOrderStats, rowProds,
    rowQuantiles, rowRanges, rowRanks,
    rowSdDiffs, rowSds, rowSums2,
    rowTabulates, rowVarDiffs,
    rowVars, rowWeightedMads,
    rowWeightedMeans,
    rowWeightedMedians,
    rowWeightedSds, rowWeightedVars

The following object is masked from ‘package:Biobase’:

    rowMedians

Warning message:
package ‘matrixStats’ was built under R version 4.6.1 
> 
> ## ---- 1. BUILD VERIFIED SAMPLE METADATA FROM COLUMN NAMES ----
> sample_names <- colnames(counts_only)
> radiation_type <- ifelse(grepl("^Proton", sample_names), "Proton", "Gamma")
> dose_cGy <- as.numeric(gsub("^(Proton|Gamma)([0-9]+)\\..*", "\\2", sample_names))
> 
> sample_data <- data.frame(
+     Sample_ID = sample_names,
+     Radiation_Type = radiation_type,
+     Dose_cGy = dose_cGy,
+     Dose_Gy = dose_cGy / 100
+ )
> cat("Parsed sample table:\n"); print(sample_data)
Parsed sample table:
       Sample_ID Radiation_Type Dose_cGy
1     Proton0.S1         Proton        0
2     Proton5.S2         Proton        5
3    Proton10.S3         Proton       10
4    Proton25.S4         Proton       25
5    Proton50.S5         Proton       50
6    Proton75.S6         Proton       75
7   Proton100.S7         Proton      100
8   Proton125.S8         Proton      125
9   Proton150.S9         Proton      150
10 Proton200.S10         Proton      200
11    Gamma0.S11          Gamma        0
12    Gamma5.S12          Gamma        5
13   Gamma10.S13          Gamma       10
14   Gamma25.S14          Gamma       25
15   Gamma50.S15          Gamma       50
16   Gamma75.S16          Gamma       75
17  Gamma100.S17          Gamma      100
18  Gamma125.S18          Gamma      125
19  Gamma150.S19          Gamma      150
20  Gamma200.S20          Gamma      200
   Dose_Gy
1     0.00
2     0.05
3     0.10
4     0.25
5     0.50
6     0.75
7     1.00
8     1.25
9     1.50
10    2.00
11    0.00
12    0.05
13    0.10
14    0.25
15    0.50
16    0.75
17    1.00
18    1.25
19    1.50
20    2.00
> 
> stopifnot(!any(is.na(sample_data$Dose_cGy)))
> cat("\nDose x Radiation_Type cross-tab (should be 1 sample per cell, 10 doses x 2 types):\n")

Dose x Radiation_Type cross-tab (should be 1 sample per cell, 10 doses x 2 types):
> print(table(sample_data$Dose_cGy, sample_data$Radiation_Type))
     
      Gamma Proton
  0       1      1
  5       1      1
  10      1      1
  25      1      1
  50      1      1
  75      1      1
  100     1      1
  125     1      1
  150     1      1
  200     1      1
> 
> rownames(sample_data) <- sample_data$Sample_ID
> stopifnot(identical(rownames(sample_data), colnames(counts_only)))
> 
> ## ---- 2. BUILD DESEQ2 OBJECT ----
> dds <- DESeqDataSetFromMatrix(
+     countData = counts_only,
+     colData = sample_data,
+     design = ~ Radiation_Type + splines::ns(log2(Dose_Gy + 0.005), df = 3)
+ )
Warning message:
In DESeqDataSet(se, design = design, ignoreRank) :
  some variables in design formula are characters, converting to factors
> 
> keep <- rowSums(counts(dds)) >= 10
> dds <- dds[keep, ]
> cat("\nGenes after low-count filter:", nrow(dds), "\n")

Genes after low-count filter: 16654 
> 
> dds <- estimateSizeFactors(dds)
> cat("Size factor summary:\n"); print(summary(sizeFactors(dds)))
Size factor summary:
   Min. 1st Qu.  Median    Mean 3rd Qu. 
 0.9592  0.9918  1.0013  0.9996  1.0130 
   Max. 
 1.0264 
> 
> ## ---- 3. PRIMARY DOSE MODEL (controlling for radiation type) ----
> dds_primary <- DESeq(dds, test = "LRT", reduced = ~ Radiation_Type)
using pre-existing size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
> res_primary <- results(dds_primary)
> cat("\nPrimary dose model summary:\n"); print(summary(res_primary))

Primary dose model summary:

out of 16654 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 1692, 10%
LFC < 0 (down)     : 1110, 6.7%
outliers [1]       : 0, 0%
low counts [2]     : 3552, 21%
(mean count < 5)
[1] see 'cooksCutoff' argument of ?results
[2] see 'independentFiltering' argument of ?results

NULL
> 
> sig_primary <- rownames(res_primary)[which(res_primary$padj < 0.1)]
> cat("Significant dose-responsive genes:", length(sig_primary), "\n")
Significant dose-responsive genes: 2802 
> 
> ## ---- 4. RADIATION-TYPE INTERACTION MODEL (does Proton behave differently than Gamma?) ----
> dds_int <- DESeqDataSetFromMatrix(
+     countData = counts(dds), colData = sample_data,
+     design = ~ Radiation_Type * splines::ns(log2(Dose_Gy + 0.005), df = 3)
+ )
Warning message:
In DESeqDataSet(se, design = design, ignoreRank) :
  some variables in design formula are characters, converting to factors
> dds_int <- DESeq(dds_int, test = "LRT",
+                  reduced = ~ Radiation_Type + splines::ns(log2(Dose_Gy + 0.005), df = 3))
estimating size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
> res_int <- results(dds_int)
> cat("\nRadiation-type interaction summary:\n"); print(summary(res_int))

Radiation-type interaction summary:

out of 16654 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 4, 0.024%
LFC < 0 (down)     : 0, 0%
outliers [1]       : 0, 0%
low counts [2]     : 0, 0%
(mean count < 0)
[1] see 'cooksCutoff' argument of ?results
[2] see 'independentFiltering' argument of ?results

NULL
> sig_int <- rownames(res_int)[which(res_int$padj < 0.1)]
> cat("Radiation-type-sensitive genes (Proton vs Gamma differ):", length(sig_int), "\n")
Radiation-type-sensitive genes (Proton vs Gamma differ): 4 
> 
> ## ---- 5. CANONICAL GENE CHECKPOINT (mouse symbols, real ENSMUSG-style row IDs) ----
> canon_genes_mouse <- c("Bax","Cdkn1a","Ddb2","Fdxr","Gadd45a","Mdm2")
> canon_ids <- rownames(gene_annotation)[gene_annotation$geneSymbol %in% canon_genes_mouse]
> canon_present <- intersect(canon_ids, rownames(res_primary))
> cat("\nCanonical genes present in filtered results:", length(canon_present), "of 6\n")

Canonical genes present in filtered results: 6 of 6
> 
> canon_results <- data.frame(
+     GeneID = canon_present,
+     Symbol = gene_annotation[canon_present, "geneSymbol"],
+     log2FoldChange = res_primary[canon_present, "log2FoldChange"],
+     padj = res_primary[canon_present, "padj"]
+ )
> print(canon_results)
              GeneID  Symbol log2FoldChange
1 ENSMUSG00000002109    Ddb2    0.001767698
2 ENSMUSG00000003873     Bax    1.179893838
3 ENSMUSG00000018861    Fdxr   -0.445527232
4 ENSMUSG00000020184    Mdm2    0.773720490
5 ENSMUSG00000023067  Cdkn1a    2.919267337
6 ENSMUSG00000036390 Gadd45a   -0.514586193
          padj
1 4.259849e-01
2 1.204411e-39
3 1.747619e-01
4 2.336292e-24
5 3.325164e-53
6 6.074696e-01
> 
> ## ---- 6. SAVE DELIVERABLES ----
> write.csv(as.data.frame(res_primary), "GSE105266_primary_dose_model_FULL.csv", row.names = TRUE)
> write.csv(data.frame(GeneID = sig_primary), "GSE105266_sig_primary_genes_LOCKED.csv", row.names = FALSE)
> write.csv(as.data.frame(res_int), "GSE105266_interaction_model_FULL.csv", row.names = TRUE)
> write.csv(sample_data, "GSE105266_sample_metadata_VERIFIED.csv", row.names = FALSE)
> 
> ## ---- 7. FIGURE: PCA ----
> vsd <- vst(dds_primary, blind = FALSE)
> pca_res <- prcomp(t(assay(vsd)), scale. = TRUE)
> pca_data <- data.frame(pca_res$x, Dose = factor(sample_data$Dose_cGy), Type = sample_data$Radiation_Type)
> p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Dose, shape = Type)) +
+     geom_point(size = 3, alpha = 0.8) + theme_minimal() +
+     labs(title = "GSE105266 PCA — mouse aorta, Gamma vs Proton")
> if (!dir.exists("figures")) dir.create("figures")
> ggsave("figures/GSE105266_Fig1_PCA.pdf", p1, width = 7, height = 5)
> ggsave("figures/GSE105266_Fig1_PCA.png", p1, width = 7, height = 5)
> 
> ## ---- 8. FIGURE: canonical gene dose curves ----
> canon_expr <- assay(vsd)[canon_present, , drop = FALSE]
> canon_melt <- reshape2::melt(canon_expr)
> colnames(canon_melt) <- c("GeneID","Sample_ID","Expression")
> canon_melt$Symbol <- gene_annotation[canon_melt$GeneID, "geneSymbol"]
> canon_melt <- merge(canon_melt, sample_data, by = "Sample_ID")
> 
> p2 <- ggplot(canon_melt, aes(x = Dose_Gy, y = Expression, color = Radiation_Type)) +
+     geom_point(size = 2) + geom_smooth(method = "loess", se = FALSE) +
+     facet_wrap(~Symbol, scales = "free_y") + theme_minimal() +
+     labs(title = "Canonical Genes — Mouse Aorta (GSE105266)", x = "Dose (Gy)", y = "VST Expression")
> ggsave("figures/GSE105266_Fig2_Canonical.pdf", p2, width = 9, height = 6)
`geom_smooth()` using formula = 'y ~ x'
> ggsave("figures/GSE105266_Fig2_Canonical.png", p2, width = 9, height = 6)
`geom_smooth()` using formula = 'y ~ x'
> 
> ## ---- 9. SESSION INFO ----
> writeLines(capture.output(sessionInfo()), "session_info_GSE105266_STEP3.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("STEP 3 COMPLETE. Review canonical gene checkpoint above.\n")
STEP 3 COMPLETE. Review canonical gene checkpoint above.
> cat("This is your CROSS-SPECIES check — mouse vs your human discovery cohort.\n")
This is your CROSS-SPECIES check — mouse vs your human discovery cohort.
> cat("===========================================\n")
===========================================
> #############################################################
> # GSE105266 — CROSS-SPECIES CROSS-COHORT VALIDATION
> # Tests whether your human discovery signature (E-GEOD-21748) overlaps
> # with mouse aorta dose-responsive genes, via symbol-based ortholog matching.
> # Run in the SAME session (needs: res_primary, sig_primary, gene_annotation)
> #############################################################
> 
> ## ---- 1. LOAD YOUR LOCKED DISCOVERY COHORT ----
> discovery_file <- "final_discovery_cohort_genes_LOCKED.csv"
> stopifnot(file.exists(discovery_file))
> e_geod_genes <- read.csv(discovery_file)
> cat("Loaded discovery cohort:", nrow(e_geod_genes), "rows\n")
Loaded discovery cohort: 1366 rows
> 
> human_symbols <- unique(e_geod_genes$Symbol)
> cat("Unique human gene symbols:", length(human_symbols), "\n")
Unique human gene symbols: 1314 
> 
> ## ---- 2. SIMPLE, TRANSPARENT ORTHOLOG MATCHING: uppercase mouse symbol,
> ## compare directly to human symbol. This is a crude but honest, commonly-used
> ## first-pass approach for well-conserved genes (most 1:1 orthologs share the
> ## same letters, differing only in case) — NOT a full ortholog database lookup.
> ## Report the match rate explicitly so this limitation is visible, not hidden.
> mouse_symbols_upper <- toupper(gene_annotation$geneSymbol)
> names(mouse_symbols_upper) <- rownames(gene_annotation)
> 
> ## Map: for every gene in res_primary (mouse), get its uppercased symbol
> mouse_tested_genes <- rownames(res_primary)
> mouse_tested_upper <- mouse_symbols_upper[mouse_tested_genes]
> 
> cat("\nMouse genes tested with a resolvable symbol:", sum(!is.na(mouse_tested_upper)),
+     "of", length(mouse_tested_genes), "\n")

Mouse genes tested with a resolvable symbol: 16654 of 16654 
> 
> ## ---- 3. BUILD THE OVERLAP ----
> ## Background: all mouse genes tested (with resolvable symbol) that ALSO have
> ## a same-named human ortholog candidate in the discovery cohort's tested universe
> ## (we use human_symbols as a proxy set here, not the full human genome —
> ## report this limitation explicitly)
> matched_discovery_genes_ids <- names(mouse_tested_upper)[mouse_tested_upper %in% human_symbols]
> cat("Mouse genes whose symbol (uppercased) matches a discovery-cohort human symbol:",
+     length(matched_discovery_genes_ids), "\n")
Mouse genes whose symbol (uppercased) matches a discovery-cohort human symbol: 971 
> 
> n_overlap <- length(intersect(matched_discovery_genes_ids, sig_primary))
> n_discovery <- length(matched_discovery_genes_ids)
> n_validation <- length(sig_primary)
> N <- length(mouse_tested_genes)
> 
> cat("\nFisher's test inputs (all live-computed):\n")

Fisher's test inputs (all live-computed):
> cat("n_overlap:", n_overlap, "| n_discovery:", n_discovery,
+     "| n_validation:", n_validation, "| N:", N, "\n")
n_overlap: 183 | n_discovery: 971 | n_validation: 2802 | N: 16654 
> 
> contingency_table <- matrix(c(
+     n_overlap, n_discovery - n_overlap,
+     n_validation - n_overlap, N - (n_discovery + n_validation - n_overlap)
+ ), nrow = 2, dimnames = list(
+     Discovery = c("In_Discovery", "Not_Discovery"),
+     Validation = c("In_Validation", "Not_Validation")
+ ))
> print(contingency_table)
               Validation
Discovery       In_Validation
  In_Discovery            183
  Not_Discovery           788
               Validation
Discovery       Not_Validation
  In_Discovery            2619
  Not_Discovery          13064
> print(fisher.test(contingency_table, alternative = "greater"))

	Fisher's Exact Test for Count Data

data:  contingency_table
p-value = 0.04685
alternative hypothesis: true odds ratio is greater than 1
95 percent confidence interval:
 1.002717      Inf
sample estimates:
odds ratio 
  1.158447 

> 
> ## ---- 4. DIRECTIONAL CONCORDANCE ON THE OVERLAP ----
> overlap_genes <- intersect(matched_discovery_genes_ids, sig_primary)
> cat("\nOverlap gene count for concordance check:", length(overlap_genes), "\n")

Overlap gene count for concordance check: 183 
> 
> if (length(overlap_genes) > 0) {
+     overlap_symbols_mouse <- mouse_symbols_upper[overlap_genes]
+     
+     discovery_direction <- sapply(overlap_symbols_mouse, function(sym) {
+         rows <- e_geod_genes[toupper(e_geod_genes$Symbol) == sym, ]
+         if (nrow(rows) == 0) return(NA)
+         sign(mean(rows$Day4_vs_Day0))
+     })
+     
+     mouse_direction <- sign(res_primary[overlap_genes, "log2FoldChange"])
+     
+     concordance_df <- data.frame(
+         MouseGeneID = overlap_genes,
+         Symbol = overlap_symbols_mouse,
+         Discovery_Sign = discovery_direction,
+         Mouse_Sign = mouse_direction
+     )
+     concordance_df$Concordant <- concordance_df$Discovery_Sign == concordance_df$Mouse_Sign
+     
+     cat("\nDirectional concordance:\n")
+     print(table(concordance_df$Concordant))
+     print(concordance_df)
+     
+     n_concordant <- sum(concordance_df$Concordant, na.rm = TRUE)
+     n_total <- sum(!is.na(concordance_df$Concordant))
+     cat(sprintf("\n%d of %d (%.1f%%) overlap genes directionally concordant\n",
+                 n_concordant, n_total, 100 * n_concordant / max(n_total,1)))
+     
+     if (n_total >= 5) {
+         print(binom.test(n_concordant, n_total, p = 0.5, alternative = "greater"))
+     } else {
+         cat("Too few overlap genes for a meaningful binomial test.\n")
+     }
+     
+     write.csv(concordance_df, "GSE105266_directional_concordance.csv", row.names = FALSE)
+ }

Directional concordance:

FALSE  TRUE 
  118    65 
                          MouseGeneID
ENSMUSG00000001576 ENSMUSG00000001576
ENSMUSG00000002428 ENSMUSG00000002428
ENSMUSG00000003534 ENSMUSG00000003534
ENSMUSG00000004383 ENSMUSG00000004383
ENSMUSG00000005102 ENSMUSG00000005102
ENSMUSG00000005125 ENSMUSG00000005125
ENSMUSG00000005233 ENSMUSG00000005233
ENSMUSG00000005370 ENSMUSG00000005370
ENSMUSG00000006262 ENSMUSG00000006262
ENSMUSG00000007659 ENSMUSG00000007659
ENSMUSG00000009569 ENSMUSG00000009569
ENSMUSG00000011148 ENSMUSG00000011148
ENSMUSG00000011831 ENSMUSG00000011831
ENSMUSG00000017493 ENSMUSG00000017493
ENSMUSG00000017548 ENSMUSG00000017548
ENSMUSG00000017697 ENSMUSG00000017697
ENSMUSG00000017707 ENSMUSG00000017707
ENSMUSG00000017737 ENSMUSG00000017737
ENSMUSG00000018196 ENSMUSG00000018196
ENSMUSG00000018401 ENSMUSG00000018401
ENSMUSG00000018983 ENSMUSG00000018983
ENSMUSG00000019841 ENSMUSG00000019841
ENSMUSG00000019877 ENSMUSG00000019877
ENSMUSG00000019907 ENSMUSG00000019907
ENSMUSG00000020091 ENSMUSG00000020091
ENSMUSG00000020108 ENSMUSG00000020108
ENSMUSG00000020150 ENSMUSG00000020150
ENSMUSG00000020184 ENSMUSG00000020184
ENSMUSG00000020189 ENSMUSG00000020189
ENSMUSG00000020205 ENSMUSG00000020205
ENSMUSG00000020290 ENSMUSG00000020290
ENSMUSG00000020423 ENSMUSG00000020423
ENSMUSG00000020580 ENSMUSG00000020580
ENSMUSG00000020592 ENSMUSG00000020592
ENSMUSG00000020629 ENSMUSG00000020629
ENSMUSG00000021025 ENSMUSG00000021025
ENSMUSG00000021068 ENSMUSG00000021068
ENSMUSG00000021111 ENSMUSG00000021111
ENSMUSG00000021500 ENSMUSG00000021500
ENSMUSG00000021585 ENSMUSG00000021585
ENSMUSG00000021811 ENSMUSG00000021811
ENSMUSG00000021987 ENSMUSG00000021987
ENSMUSG00000021990 ENSMUSG00000021990
ENSMUSG00000022074 ENSMUSG00000022074
ENSMUSG00000022139 ENSMUSG00000022139
ENSMUSG00000022175 ENSMUSG00000022175
ENSMUSG00000022358 ENSMUSG00000022358
ENSMUSG00000022360 ENSMUSG00000022360
ENSMUSG00000022385 ENSMUSG00000022385
ENSMUSG00000022471 ENSMUSG00000022471
ENSMUSG00000022620 ENSMUSG00000022620
ENSMUSG00000022672 ENSMUSG00000022672
ENSMUSG00000022781 ENSMUSG00000022781
ENSMUSG00000022884 ENSMUSG00000022884
ENSMUSG00000022973 ENSMUSG00000022973
ENSMUSG00000022995 ENSMUSG00000022995
ENSMUSG00000023067 ENSMUSG00000023067
ENSMUSG00000023852 ENSMUSG00000023852
ENSMUSG00000024007 ENSMUSG00000024007
ENSMUSG00000024079 ENSMUSG00000024079
ENSMUSG00000024087 ENSMUSG00000024087
ENSMUSG00000024302 ENSMUSG00000024302
ENSMUSG00000024472 ENSMUSG00000024472
ENSMUSG00000024664 ENSMUSG00000024664
ENSMUSG00000024754 ENSMUSG00000024754
ENSMUSG00000024799 ENSMUSG00000024799
ENSMUSG00000024974 ENSMUSG00000024974
ENSMUSG00000025060 ENSMUSG00000025060
ENSMUSG00000025227 ENSMUSG00000025227
ENSMUSG00000025241 ENSMUSG00000025241
ENSMUSG00000025278 ENSMUSG00000025278
ENSMUSG00000025283 ENSMUSG00000025283
ENSMUSG00000025323 ENSMUSG00000025323
ENSMUSG00000026341 ENSMUSG00000026341
ENSMUSG00000026436 ENSMUSG00000026436
ENSMUSG00000026463 ENSMUSG00000026463
ENSMUSG00000026879 ENSMUSG00000026879
ENSMUSG00000026922 ENSMUSG00000026922
ENSMUSG00000027006 ENSMUSG00000027006
ENSMUSG00000027203 ENSMUSG00000027203
ENSMUSG00000027466 ENSMUSG00000027466
ENSMUSG00000027519 ENSMUSG00000027519
ENSMUSG00000027656 ENSMUSG00000027656
ENSMUSG00000027663 ENSMUSG00000027663
ENSMUSG00000028086 ENSMUSG00000028086
ENSMUSG00000028312 ENSMUSG00000028312
ENSMUSG00000028484 ENSMUSG00000028484
ENSMUSG00000028790 ENSMUSG00000028790
ENSMUSG00000028967 ENSMUSG00000028967
ENSMUSG00000029484 ENSMUSG00000029484
ENSMUSG00000029860 ENSMUSG00000029860
ENSMUSG00000030284 ENSMUSG00000030284
ENSMUSG00000030435 ENSMUSG00000030435
ENSMUSG00000030619 ENSMUSG00000030619
ENSMUSG00000030847 ENSMUSG00000030847
ENSMUSG00000030978 ENSMUSG00000030978
ENSMUSG00000031386 ENSMUSG00000031386
ENSMUSG00000031799 ENSMUSG00000031799
ENSMUSG00000031870 ENSMUSG00000031870
ENSMUSG00000032252 ENSMUSG00000032252
ENSMUSG00000032253 ENSMUSG00000032253
ENSMUSG00000032402 ENSMUSG00000032402
ENSMUSG00000032536 ENSMUSG00000032536
ENSMUSG00000032555 ENSMUSG00000032555
ENSMUSG00000033054 ENSMUSG00000033054
ENSMUSG00000033319 ENSMUSG00000033319
ENSMUSG00000033400 ENSMUSG00000033400
ENSMUSG00000033671 ENSMUSG00000033671
ENSMUSG00000033863 ENSMUSG00000033863
ENSMUSG00000033964 ENSMUSG00000033964
ENSMUSG00000034320 ENSMUSG00000034320
ENSMUSG00000034349 ENSMUSG00000034349
ENSMUSG00000034422 ENSMUSG00000034422
ENSMUSG00000034708 ENSMUSG00000034708
ENSMUSG00000034926 ENSMUSG00000034926
ENSMUSG00000035478 ENSMUSG00000035478
ENSMUSG00000035851 ENSMUSG00000035851
ENSMUSG00000035941 ENSMUSG00000035941
ENSMUSG00000036093 ENSMUSG00000036093
ENSMUSG00000036550 ENSMUSG00000036550
ENSMUSG00000036678 ENSMUSG00000036678
ENSMUSG00000036777 ENSMUSG00000036777
ENSMUSG00000036781 ENSMUSG00000036781
ENSMUSG00000036908 ENSMUSG00000036908
ENSMUSG00000036985 ENSMUSG00000036985
ENSMUSG00000037031 ENSMUSG00000037031
ENSMUSG00000037035 ENSMUSG00000037035
ENSMUSG00000037235 ENSMUSG00000037235
ENSMUSG00000037278 ENSMUSG00000037278
ENSMUSG00000037286 ENSMUSG00000037286
ENSMUSG00000037321 ENSMUSG00000037321
ENSMUSG00000037608 ENSMUSG00000037608
ENSMUSG00000037995 ENSMUSG00000037995
ENSMUSG00000038178 ENSMUSG00000038178
ENSMUSG00000038508 ENSMUSG00000038508
ENSMUSG00000038766 ENSMUSG00000038766
ENSMUSG00000039263 ENSMUSG00000039263
ENSMUSG00000039316 ENSMUSG00000039316
ENSMUSG00000039621 ENSMUSG00000039621
ENSMUSG00000040532 ENSMUSG00000040532
ENSMUSG00000040690 ENSMUSG00000040690
ENSMUSG00000040811 ENSMUSG00000040811
ENSMUSG00000041219 ENSMUSG00000041219
ENSMUSG00000041313 ENSMUSG00000041313
ENSMUSG00000041415 ENSMUSG00000041415
ENSMUSG00000041488 ENSMUSG00000041488
ENSMUSG00000041548 ENSMUSG00000041548
ENSMUSG00000041570 ENSMUSG00000041570
ENSMUSG00000041731 ENSMUSG00000041731
ENSMUSG00000041801 ENSMUSG00000041801
ENSMUSG00000042978 ENSMUSG00000042978
ENSMUSG00000043154 ENSMUSG00000043154
ENSMUSG00000043885 ENSMUSG00000043885
ENSMUSG00000043991 ENSMUSG00000043991
ENSMUSG00000044477 ENSMUSG00000044477
ENSMUSG00000045211 ENSMUSG00000045211
ENSMUSG00000047126 ENSMUSG00000047126
ENSMUSG00000048874 ENSMUSG00000048874
ENSMUSG00000049502 ENSMUSG00000049502
ENSMUSG00000050310 ENSMUSG00000050310
ENSMUSG00000050737 ENSMUSG00000050737
ENSMUSG00000051329 ENSMUSG00000051329
ENSMUSG00000052085 ENSMUSG00000052085
ENSMUSG00000052534 ENSMUSG00000052534
ENSMUSG00000053398 ENSMUSG00000053398
ENSMUSG00000057137 ENSMUSG00000057137
ENSMUSG00000057897 ENSMUSG00000057897
ENSMUSG00000058454 ENSMUSG00000058454
ENSMUSG00000059923 ENSMUSG00000059923
ENSMUSG00000061353 ENSMUSG00000061353
ENSMUSG00000061436 ENSMUSG00000061436
ENSMUSG00000061607 ENSMUSG00000061607
ENSMUSG00000062825 ENSMUSG00000062825
ENSMUSG00000062949 ENSMUSG00000062949
ENSMUSG00000063415 ENSMUSG00000063415
ENSMUSG00000063727 ENSMUSG00000063727
ENSMUSG00000066026 ENSMUSG00000066026
ENSMUSG00000068329 ENSMUSG00000068329
ENSMUSG00000068740 ENSMUSG00000068740
ENSMUSG00000071072 ENSMUSG00000071072
ENSMUSG00000071637 ENSMUSG00000071637
ENSMUSG00000072235 ENSMUSG00000072235
ENSMUSG00000079553 ENSMUSG00000079553
                      Symbol Discovery_Sign
ENSMUSG00000001576    ERGIC1              1
ENSMUSG00000002428      HLTF             -1
ENSMUSG00000003534      DDR1              1
ENSMUSG00000004383     LARGE              1
ENSMUSG00000005102   EIF2AK4             -1
ENSMUSG00000005125     NDRG1             -1
ENSMUSG00000005233     SPC25             -1
ENSMUSG00000005370      MSH6             -1
ENSMUSG00000006262   MOBKL1A             -1
ENSMUSG00000007659    BCL2L1              1
ENSMUSG00000009569      MKL2             -1
ENSMUSG00000011148    ADSSL1              1
ENSMUSG00000011831      EVI5             -1
ENSMUSG00000017493    IGFBP4              1
ENSMUSG00000017548     SUZ12             -1
ENSMUSG00000017697       ADA              1
ENSMUSG00000017707   SERINC3              1
ENSMUSG00000017737      MMP9             -1
ENSMUSG00000018196     GLRX2             -1
ENSMUSG00000018401     MTMR4             -1
ENSMUSG00000018983      E2F2             -1
ENSMUSG00000019841     REV3L             -1
ENSMUSG00000019877   SERINC1              1
ENSMUSG00000019907  PPP1R12A             -1
ENSMUSG00000020091  EIF4EBP2             -1
ENSMUSG00000020108     DDIT4              1
ENSMUSG00000020150      GAMT              1
ENSMUSG00000020184      MDM2              1
ENSMUSG00000020189    OSBPL8             -1
ENSMUSG00000020205    PHLDA1              1
ENSMUSG00000020290      XPO1             -1
ENSMUSG00000020423      BTG2              1
ENSMUSG00000020580     ROCK2             -1
ENSMUSG00000020592      SDC1              1
ENSMUSG00000020629      ADI1             -1
ENSMUSG00000021025    NFKBIA              1
ENSMUSG00000021068       NIN             -1
ENSMUSG00000021111    PAPOLA             -1
ENSMUSG00000021500     DDX46             -1
ENSMUSG00000021585      CAST             -1
ENSMUSG00000021811    DNAJC9             -1
ENSMUSG00000021987     MTMR6             -1
ENSMUSG00000021990   SPATA13              1
ENSMUSG00000022074 TNFRSF10B              1
ENSMUSG00000022139     MBNL2             -1
ENSMUSG00000022175     LRP10              1
ENSMUSG00000022358    FBXO32              1
ENSMUSG00000022360     ATAD2             -1
ENSMUSG00000022385     GTSE1             -1
ENSMUSG00000022471     XRCC6             -1
ENSMUSG00000022620      ARSA              1
ENSMUSG00000022672     PRKDC             -1
ENSMUSG00000022781      PAK2              1
ENSMUSG00000022884    EIF4A2              1
ENSMUSG00000022973     SYNJ1             -1
ENSMUSG00000022995      ENAH             -1
ENSMUSG00000023067    CDKN1A              1
ENSMUSG00000023852      CHD1             -1
ENSMUSG00000024007     PPIL1             -1
ENSMUSG00000024079   EIF2AK2              1
ENSMUSG00000024087    CYP1B1              1
ENSMUSG00000024302      DTNA              1
ENSMUSG00000024472      DCP2             -1
ENSMUSG00000024664     FADS3              1
ENSMUSG00000024754     TMEM2              1
ENSMUSG00000024799    TM7SF2              1
ENSMUSG00000024974      SMC3             -1
ENSMUSG00000025060       SLK             -1
ENSMUSG00000025227   TMEM180             -1
ENSMUSG00000025241     FYCO1              1
ENSMUSG00000025278      FLNB              1
ENSMUSG00000025283      SAT1              1
ENSMUSG00000025323       SP4             -1
ENSMUSG00000026341     ACTR3             -1
ENSMUSG00000026436      ELK4             -1
ENSMUSG00000026463    ATP2B4              1
ENSMUSG00000026879       GSN              1
ENSMUSG00000026922    AGPAT2              1
ENSMUSG00000027006   DNAJC10             -1
ENSMUSG00000027203       DUT             -1
ENSMUSG00000027466     RBCK1              1
ENSMUSG00000027519    RAB22A             -1
ENSMUSG00000027656     WISP2              1
ENSMUSG00000027663     ZMAT3              1
ENSMUSG00000028086     FBXW7              1
ENSMUSG00000028312      SMC2             -1
ENSMUSG00000028484     PSIP1             -1
ENSMUSG00000028790   KHDRBS1             -1
ENSMUSG00000028967    ERRFI1              1
ENSMUSG00000029484     ANXA3              1
ENSMUSG00000029860       ZYX              1
ENSMUSG00000030284    CRELD1              1
ENSMUSG00000030435     U2AF2             -1
ENSMUSG00000030619       EED             -1
ENSMUSG00000030847      BAG3              1
ENSMUSG00000030978      RRM1             -1
ENSMUSG00000031386     HCFC1             -1
ENSMUSG00000031799      TPM4              1
ENSMUSG00000031870       PGR              1
ENSMUSG00000032252      GLCE             -1
ENSMUSG00000032253      PHIP             -1
ENSMUSG00000032402     SMAD3              1
ENSMUSG00000032536     TRAK1              1
ENSMUSG00000032555    TOPBP1             -1
ENSMUSG00000033054      NPAT             -1
ENSMUSG00000033319     FEM1C             -1
ENSMUSG00000033400       AGL             -1
ENSMUSG00000033671    CEP350             -1
ENSMUSG00000033863      KLF9              1
ENSMUSG00000033964    ZBTB41             -1
ENSMUSG00000034320   SLC26A2              1
ENSMUSG00000034349      SMC4             -1
ENSMUSG00000034422    PARP14              1
ENSMUSG00000034708       GRN              1
ENSMUSG00000034926    DHCR24             -1
ENSMUSG00000035478      MBD3             -1
ENSMUSG00000035851    YTHDC1              1
ENSMUSG00000035941      IBTK             -1
ENSMUSG00000036093     ARL5A             -1
ENSMUSG00000036550     CNOT1             -1
ENSMUSG00000036678      AAAS             -1
ENSMUSG00000036777      ANLN             -1
ENSMUSG00000036781    RPS27L              1
ENSMUSG00000036908   UNC93B1              1
ENSMUSG00000036985    ZDHHC9              1
ENSMUSG00000037031   TSPAN15              1
ENSMUSG00000037035     INHBB              1
ENSMUSG00000037235      MXD4              1
ENSMUSG00000037278    TMEM97             -1
ENSMUSG00000037286     STAG1             -1
ENSMUSG00000037321      TAP1              1
ENSMUSG00000037608    BCLAF1             -1
ENSMUSG00000037995     IGSF9             -1
ENSMUSG00000038178   SLC43A2              1
ENSMUSG00000038508     GDF15              1
ENSMUSG00000038766    GABPB2             -1
ENSMUSG00000039263    NPEPL1              1
ENSMUSG00000039316     RFTN1              1
ENSMUSG00000039621     PREX1              1
ENSMUSG00000040532    ABHD11              1
ENSMUSG00000040690   COL16A1              1
ENSMUSG00000040811      EML2              1
ENSMUSG00000041219 ARHGAP11A             -1
ENSMUSG00000041313    SLC7A1             -1
ENSMUSG00000041415    DICER1             -1
ENSMUSG00000041488      STX3              1
ENSMUSG00000041548     HSPB8              1
ENSMUSG00000041570 CAMSAP1L1             -1
ENSMUSG00000041731      PGM5              1
ENSMUSG00000041801    PHLDA3              1
ENSMUSG00000042978      SBK1              1
ENSMUSG00000043154   PPP2R3A             -1
ENSMUSG00000043885   SLC36A4             -1
ENSMUSG00000043991      PURA             -1
ENSMUSG00000044477    ZFAND3              1
ENSMUSG00000045211    NUDT18              1
ENSMUSG00000047126      CLTC             -1
ENSMUSG00000048874      PHF3             -1
ENSMUSG00000049502     DTX3L              1
ENSMUSG00000050310    RICTOR             -1
ENSMUSG00000050737     PTGES              1
ENSMUSG00000051329    NUP160             -1
ENSMUSG00000052085     DOCK8             -1
ENSMUSG00000052534      PBX1              1
ENSMUSG00000053398     PHGDH             -1
ENSMUSG00000057137   TMEM140              1
ENSMUSG00000057897    CAMK2B              1
ENSMUSG00000058454     DHCR7             -1
ENSMUSG00000059923      GRB2              1
ENSMUSG00000061353    CXCL12              1
ENSMUSG00000061436     HIPK2              1
ENSMUSG00000061607      MDC1             -1
ENSMUSG00000062825     ACTG1              1
ENSMUSG00000062949    ATP11C             -1
ENSMUSG00000063415   CYP26B1              1
ENSMUSG00000063727 TNFRSF11B              1
ENSMUSG00000066026     DHRS3              1
ENSMUSG00000068329     HTRA2              1
ENSMUSG00000068740    CELSR2              1
ENSMUSG00000071072    PTGES3             -1
ENSMUSG00000071637     CEBPD              1
ENSMUSG00000072235    TUBA1A             -1
ENSMUSG00000079553     KIFC1             -1
                   Mouse_Sign Concordant
ENSMUSG00000001576         -1      FALSE
ENSMUSG00000002428          1      FALSE
ENSMUSG00000003534         -1      FALSE
ENSMUSG00000004383         -1      FALSE
ENSMUSG00000005102          1      FALSE
ENSMUSG00000005125         -1       TRUE
ENSMUSG00000005233          1      FALSE
ENSMUSG00000005370          1      FALSE
ENSMUSG00000006262          1      FALSE
ENSMUSG00000007659          1       TRUE
ENSMUSG00000009569          1      FALSE
ENSMUSG00000011148          1       TRUE
ENSMUSG00000011831          1      FALSE
ENSMUSG00000017493         -1      FALSE
ENSMUSG00000017548          1      FALSE
ENSMUSG00000017697         -1      FALSE
ENSMUSG00000017707          1       TRUE
ENSMUSG00000017737         -1       TRUE
ENSMUSG00000018196         -1       TRUE
ENSMUSG00000018401         -1       TRUE
ENSMUSG00000018983         -1       TRUE
ENSMUSG00000019841          1      FALSE
ENSMUSG00000019877          1       TRUE
ENSMUSG00000019907          1      FALSE
ENSMUSG00000020091         -1       TRUE
ENSMUSG00000020108          1       TRUE
ENSMUSG00000020150         -1      FALSE
ENSMUSG00000020184          1       TRUE
ENSMUSG00000020189          1      FALSE
ENSMUSG00000020205         -1      FALSE
ENSMUSG00000020290         -1       TRUE
ENSMUSG00000020423          1       TRUE
ENSMUSG00000020580          1      FALSE
ENSMUSG00000020592          1       TRUE
ENSMUSG00000020629         -1       TRUE
ENSMUSG00000021025          1       TRUE
ENSMUSG00000021068          1      FALSE
ENSMUSG00000021111          1      FALSE
ENSMUSG00000021500          1      FALSE
ENSMUSG00000021585          1      FALSE
ENSMUSG00000021811          1      FALSE
ENSMUSG00000021987          1      FALSE
ENSMUSG00000021990         -1      FALSE
ENSMUSG00000022074          1       TRUE
ENSMUSG00000022139          1      FALSE
ENSMUSG00000022175         -1      FALSE
ENSMUSG00000022358          1       TRUE
ENSMUSG00000022360          1      FALSE
ENSMUSG00000022385          1      FALSE
ENSMUSG00000022471          1      FALSE
ENSMUSG00000022620         -1      FALSE
ENSMUSG00000022672          1      FALSE
ENSMUSG00000022781          1       TRUE
ENSMUSG00000022884          1       TRUE
ENSMUSG00000022973          1      FALSE
ENSMUSG00000022995          1      FALSE
ENSMUSG00000023067          1       TRUE
ENSMUSG00000023852          1      FALSE
ENSMUSG00000024007         -1       TRUE
ENSMUSG00000024079          1       TRUE
ENSMUSG00000024087          1       TRUE
ENSMUSG00000024302          1       TRUE
ENSMUSG00000024472          1      FALSE
ENSMUSG00000024664         -1      FALSE
ENSMUSG00000024754          1       TRUE
ENSMUSG00000024799         -1      FALSE
ENSMUSG00000024974          1      FALSE
ENSMUSG00000025060          1      FALSE
ENSMUSG00000025227          1      FALSE
ENSMUSG00000025241          1       TRUE
ENSMUSG00000025278          1       TRUE
ENSMUSG00000025283          1       TRUE
ENSMUSG00000025323          1      FALSE
ENSMUSG00000026341         -1       TRUE
ENSMUSG00000026436         -1       TRUE
ENSMUSG00000026463          1       TRUE
ENSMUSG00000026879         -1      FALSE
ENSMUSG00000026922         -1      FALSE
ENSMUSG00000027006          1      FALSE
ENSMUSG00000027203          1      FALSE
ENSMUSG00000027466         -1      FALSE
ENSMUSG00000027519          1      FALSE
ENSMUSG00000027656         -1      FALSE
ENSMUSG00000027663          1       TRUE
ENSMUSG00000028086          1       TRUE
ENSMUSG00000028312          1      FALSE
ENSMUSG00000028484          1      FALSE
ENSMUSG00000028790         -1       TRUE
ENSMUSG00000028967          1       TRUE
ENSMUSG00000029484         -1      FALSE
ENSMUSG00000029860         -1      FALSE
ENSMUSG00000030284         -1      FALSE
ENSMUSG00000030435         -1       TRUE
ENSMUSG00000030619          1      FALSE
ENSMUSG00000030847         -1      FALSE
ENSMUSG00000030978          1      FALSE
ENSMUSG00000031386         -1       TRUE
ENSMUSG00000031799         -1      FALSE
ENSMUSG00000031870          1       TRUE
ENSMUSG00000032252          1      FALSE
ENSMUSG00000032253          1      FALSE
ENSMUSG00000032402         -1      FALSE
ENSMUSG00000032536         -1      FALSE
ENSMUSG00000032555          1      FALSE
ENSMUSG00000033054          1      FALSE
ENSMUSG00000033319          1      FALSE
ENSMUSG00000033400          1      FALSE
ENSMUSG00000033671          1      FALSE
ENSMUSG00000033863          1       TRUE
ENSMUSG00000033964          1      FALSE
ENSMUSG00000034320          1       TRUE
ENSMUSG00000034349          1      FALSE
ENSMUSG00000034422          1       TRUE
ENSMUSG00000034708         -1      FALSE
ENSMUSG00000034926         -1       TRUE
ENSMUSG00000035478         -1       TRUE
ENSMUSG00000035851          1       TRUE
ENSMUSG00000035941          1      FALSE
ENSMUSG00000036093          1      FALSE
ENSMUSG00000036550          1      FALSE
ENSMUSG00000036678          1      FALSE
ENSMUSG00000036777          1      FALSE
ENSMUSG00000036781          1       TRUE
ENSMUSG00000036908          1       TRUE
ENSMUSG00000036985         -1      FALSE
ENSMUSG00000037031         -1      FALSE
ENSMUSG00000037035         -1      FALSE
ENSMUSG00000037235          1       TRUE
ENSMUSG00000037278         -1       TRUE
ENSMUSG00000037286          1      FALSE
ENSMUSG00000037321          1       TRUE
ENSMUSG00000037608          1      FALSE
ENSMUSG00000037995         -1       TRUE
ENSMUSG00000038178         -1      FALSE
ENSMUSG00000038508          1       TRUE
ENSMUSG00000038766          1      FALSE
ENSMUSG00000039263         -1      FALSE
ENSMUSG00000039316         -1      FALSE
ENSMUSG00000039621         -1      FALSE
ENSMUSG00000040532         -1      FALSE
ENSMUSG00000040690         -1      FALSE
ENSMUSG00000040811         -1      FALSE
ENSMUSG00000041219          1      FALSE
ENSMUSG00000041313          1      FALSE
ENSMUSG00000041415          1      FALSE
ENSMUSG00000041488          1       TRUE
ENSMUSG00000041548         -1      FALSE
ENSMUSG00000041570          1      FALSE
ENSMUSG00000041731          1       TRUE
ENSMUSG00000041801          1       TRUE
ENSMUSG00000042978         -1      FALSE
ENSMUSG00000043154          1      FALSE
ENSMUSG00000043885          1      FALSE
ENSMUSG00000043991          1      FALSE
ENSMUSG00000044477         -1      FALSE
ENSMUSG00000045211         -1      FALSE
ENSMUSG00000047126          1      FALSE
ENSMUSG00000048874          1      FALSE
ENSMUSG00000049502          1       TRUE
ENSMUSG00000050310          1      FALSE
ENSMUSG00000050737         -1      FALSE
ENSMUSG00000051329          1      FALSE
ENSMUSG00000052085          1      FALSE
ENSMUSG00000052534          1       TRUE
ENSMUSG00000053398         -1       TRUE
ENSMUSG00000057137          1       TRUE
ENSMUSG00000057897         -1      FALSE
ENSMUSG00000058454         -1       TRUE
ENSMUSG00000059923         -1      FALSE
ENSMUSG00000061353         -1      FALSE
ENSMUSG00000061436          1       TRUE
ENSMUSG00000061607          1      FALSE
ENSMUSG00000062825         -1      FALSE
ENSMUSG00000062949          1      FALSE
ENSMUSG00000063415         -1      FALSE
ENSMUSG00000063727         -1      FALSE
ENSMUSG00000066026         -1      FALSE
ENSMUSG00000068329         -1      FALSE
ENSMUSG00000068740         -1      FALSE
ENSMUSG00000071072         -1       TRUE
ENSMUSG00000071637          1       TRUE
ENSMUSG00000072235         -1       TRUE
ENSMUSG00000079553          1      FALSE

65 of 183 (35.5%) overlap genes directionally concordant

	Exact binomial test

data:  n_concordant and n_total
number of successes = 65, number of
trials = 183, p-value = 1
alternative hypothesis: true probability of success is greater than 0.5
95 percent confidence interval:
 0.2963586 1.0000000
sample estimates:
probability of success 
             0.3551913 

> 
> ## ---- 5. SAVE ----
> writeLines(capture.output(sessionInfo()), "session_info_GSE105266_crosscohort.txt")
> 
> cat("\n===========================================\n")

===========================================
> cat("CROSS-SPECIES VALIDATION COMPLETE.\n")
CROSS-SPECIES VALIDATION COMPLETE.
> cat("IMPORTANT LIMITATION TO REPORT: ortholog matching used simple\n")
IMPORTANT LIMITATION TO REPORT: ortholog matching used simple
> cat("uppercase-symbol matching, not a curated ortholog database (e.g.\n")
uppercase-symbol matching, not a curated ortholog database (e.g.
> cat("biomaRt/HomoloGene). This will miss real orthologs with different\n")
biomaRt/HomoloGene). This will miss real orthologs with different
> cat("names and may include some false matches. Report the match rate\n")
names and may include some false matches. Report the match rate
> cat("and this limitation explicitly in methods.\n")
and this limitation explicitly in methods.
> cat("===========================================\n")
===========================================
> # Check concordance JUST among your 6 canonical genes within this overlap set
> # (these are guaranteed true orthologs, not symbol-matching artifacts)
> canon_check <- concordance_df[concordance_df$Symbol %in% c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2"), ]
> print(canon_check)
                          MouseGeneID
ENSMUSG00000020184 ENSMUSG00000020184
ENSMUSG00000023067 ENSMUSG00000023067
                   Symbol Discovery_Sign
ENSMUSG00000020184   MDM2              1
ENSMUSG00000023067 CDKN1A              1
                   Mouse_Sign Concordant
ENSMUSG00000020184          1       TRUE
ENSMUSG00000023067          1       TRUE
> 
> 
> 
