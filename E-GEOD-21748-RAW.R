> BiocManager::install(c("ArrayExpress", "oligo", "limma", "Biobase"), update = FALSE, ask = FALSE)
'getOption("repos")' replaces
Bioconductor standard
repositories, see
'help("repositories", package =
"BiocManager")' for details.
Replacement repositories:
    CRAN: https://cran.rstudio.com/
Bioconductor version 3.23
  (BiocManager 1.30.27), R 4.6.0
  (2026-04-24 ucrt)
Installing package(s)
  'ArrayExpress'
trying URL 'https://bioconductor.org/packages/3.23/bioc/bin/windows/contrib/4.6/ArrayExpress_1.72.0.zip'
Content type 'application/zip' length 190213 bytes (185 KB)
downloaded 185 KB

package ‘ArrayExpress’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0\downloaded_packages
Warning message:
package(s) not installed when
  version(s) same as or greater
  than current; use `force = TRUE`
  to re-install: 'oligo' 'limma'
  'Biobase' 

> library(ArrayExpress)
Loading required package: Biobase
Loading required package: BiocGenerics
Loading required package: generics

Attaching package: ‘generics’

The following objects are masked from ‘package:base’:

    as.difftime, as.factor,
    as.ordered, intersect,
    is.element, setdiff,
    setequal, union


Attaching package: ‘BiocGenerics’

The following objects are masked from ‘package:stats’:

    IQR, mad, sd, var, xtabs

The following objects are masked from ‘package:base’:

    anyDuplicated, aperm,
    append, as.data.frame,
    basename, cbind, colnames,
    dirname, do.call,
    duplicated, eval, evalq,
    Filter, Find, get, grep,
    grepl, is.unsorted,
    lapply, Map, mapply,
    match, mget, order, paste,
    pmax, pmax.int, pmin,
    pmin.int, Position, rank,
    rbind, Reduce, rownames,
    sapply, saveRDS, table,
    tapply, unique, unsplit,
    which.max, which.min

Welcome to Bioconductor

    Vignettes contain
    introductory material;
    view with
    'browseVignettes()'. To
    cite Bioconductor, see
    'citation("Biobase")', and
    for packages
    'citation("pkgname")'.

Warning message:
package ‘generics’ was built under R version 4.6.1 
> library(oligo)
Loading required package: oligoClasses
Welcome to oligoClasses version 1.74.0
Loading required package: Biostrings
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

Loading required package: XVector
Loading required package: Seqinfo

Attaching package: ‘Biostrings’

The following object is masked from ‘package:base’:

    strsplit

===================================
Welcome to oligo version 1.76.0
===================================
> ae_data <- ArrayExpress("E-GEOD-21748")
Downloading file: E-GEOD-21748.idf.txt
trying URL 'ftp://ftp.ebi.ac.uk/biostudies/fire/E-GEOD-/748/E-GEOD-21748/Files/E-GEOD-21748.idf.txt'
Content type 'unknown' length 6042 bytes
Downloading file: E-GEOD-21748.sdrf.txt
trying URL 'ftp://ftp.ebi.ac.uk/biostudies/fire/E-GEOD-/748/E-GEOD-21748/Files/E-GEOD-21748.sdrf.txt'
Content type 'unknown' length 11170 bytes (10 KB)
Downloading file: A-MEXP-931.adf.txt
trying URL 'https://www.ebi.ac.uk/biostudies/files/A-MEXP-931/A-MEXP-931.adf.txt'
Content type 'text/plain; charset=UTF-8' length 5844542 bytes (5.6 MB)
downloaded 5.6 MB

Unpacking data files
Error in ae2bioc(mageFiles = expFiles, dataCols = dataCols, drop = drop) : 
  ArrayExpress: Experiment has no raw files available. Consider using processed data instead by following procedure in the vignette
> BiocManager::install("GEOquery", update = FALSE, ask = FALSE)
'getOption("repos")' replaces Bioconductor standard repositories, see
'help("repositories", package = "BiocManager")' for details.
Replacement repositories:
    CRAN: https://cran.rstudio.com/
Bioconductor version 3.23 (BiocManager 1.30.27), R 4.6.0 (2026-04-24
  ucrt)
Warning message:
package(s) not installed when version(s) same as or greater than
  current; use `force = TRUE` to re-install: 'GEOquery' 

> library(GEOquery)
Setting options('download.file.method.GEOquery'='auto')
Setting options('GEOquery.inmemory.gpl'=FALSE)
> geo_data <- getGEO("GSE21748", GSEMatrix = TRUE)
Found 1 file(s)
GSE21748_series_matrix.txt.gz
> gse <- geo_data[[1]]
> gse
ExpressionSet (storageMode: lockedEnvironment)
assayData: 22184 features, 20 samples 
  element names: exprs 
protocolData: none
phenoData
  sampleNames: GSM544268 GSM544269 ... GSM544287 (20 total)
  varLabels: title geo_accession ... treatment:ch1 (42 total)
  varMetadata: labelDescription
featureData
  featureNames: ILMN_1343291 ILMN_1343292 ... ILMN_2038778
    (22184 total)
  fvarLabels: ID Species ... GB_ACC (26 total)
  fvarMetadata: Column Description labelDescription
experimentData: use 'experimentData(object)'
  pubMedIds: 20596626 
Annotation: GPL6104 
> pdf("QC_boxplot.pdf", width = 8, height = 6)
> boxplot(exprs(gse), main = "Sample Intensity Distribution", las = 2, cex.axis = 0.7)
> dev.off()
null device 
          1 
> pca_results <- prcomp(t(exprs(gse)), scale. = TRUE)
> pdf("QC_pca_plot.pdf", width = 7, height = 7)
> plot(pca_results$x[,1], pca_results$x[,2], main = "PCA Space Component 1 vs 2", 
+      xlab = "PC1", ylab = "PC2", pch = 19, col = "blue")
> text(pca_results$x[,1], pca_results$x[,2], labels = colnames(exprs(gse)), pos = 3, cex = 0.6)
> dev.off()
null device 
          1 
> summary(exprs(gse)[, 1:3])
   GSM544268          GSM544269       
 Min.   :   88.89   Min.   :   88.89  
 1st Qu.:  149.82   1st Qu.:  149.85  
 Median :  208.44   Median :  208.50  
 Mean   : 1373.68   Mean   : 1373.69  
 3rd Qu.:  738.12   3rd Qu.:  738.12  
 Max.   :62166.57   Max.   :62166.57  
   GSM544270       
 Min.   :   88.89  
 1st Qu.:  149.90  
 Median :  208.50  
 Mean   : 1373.72  
 3rd Qu.:  738.12  
 Max.   :62166.57  
> exprs(gse) <- log2(exprs(gse))
> summary(exprs(gse)[, 1:3])
   GSM544268        GSM544269     
 Min.   : 6.474   Min.   : 6.474  
 1st Qu.: 7.227   1st Qu.: 7.227  
 Median : 7.703   Median : 7.704  
 Mean   : 8.575   Mean   : 8.576  
 3rd Qu.: 9.528   3rd Qu.: 9.528  
 Max.   :15.924   Max.   :15.924  
   GSM544270     
 Min.   : 6.474  
 1st Qu.: 7.228  
 Median : 7.704  
 Mean   : 8.576  
 3rd Qu.: 9.528  
 Max.   :15.924  
> metadata <- pData(gse)
> sample_info <- data.frame(
+     Sample_ID = metadata$geo_accession,
+     Title     = metadata$title
+ )
> write.csv(sample_info, "sample_mapping.csv", row.names = FALSE)
> head(sample_info, n = 5)
  Sample_ID  Title
1 GSM544268 Day0_1
2 GSM544269 Day1_1
3 GSM544270 Day2_1
4 GSM544271 Day3_1
5 GSM544272 Day0_2
> sample_info$TimePoint <- sub("_.*", "", sample_info$Title)
> sample_info$Replicate <- sub(".*_", "", sample_info$Title)
> write.csv(sample_info, "final_sample_table.csv", row.names = FALSE)
> print(sample_info)
   Sample_ID  Title TimePoint Replicate
1  GSM544268 Day0_1      Day0         1
2  GSM544269 Day1_1      Day1         1
3  GSM544270 Day2_1      Day2         1
4  GSM544271 Day3_1      Day3         1
5  GSM544272 Day0_2      Day0         2
6  GSM544273 Day1_2      Day1         2
7  GSM544274 Day2_2      Day2         2
8  GSM544275 Day3_2      Day3         2
9  GSM544276 Day0_3      Day0         3
10 GSM544277 Day1_3      Day1         3
11 GSM544278 Day2_3      Day2         3
12 GSM544279 Day3_3      Day3         3
13 GSM544280 Day0_4      Day0         4
14 GSM544281 Day1_4      Day1         4
15 GSM544282 Day2_4      Day2         4
16 GSM544283 Day3_4      Day3         4
17 GSM544284 Day4_1      Day4         1
18 GSM544285 Day4_2      Day4         2
19 GSM544286 Day4_3      Day4         3
20 GSM544287 Day4_4      Day4         4
> library(limma)

Attaching package: ‘limma’

The following object is masked from ‘package:oligo’:

    backgroundCorrect

The following object is masked from ‘package:BiocGenerics’:

    plotMA
> time_factor <- factor(sample_info$TimePoint, levels = c("Day0", "Day1", "Day2", "Day3", "Day4"))
> design_matrix <- model.matrix(~ 0 + time_factor)
> colnames(design_matrix) <- levels(time_factor)
> fit <- lmFit(exprs(gse), design_matrix)
> contrast_matrix <- makeContrasts(
+     Day1_vs_Day0 = Day1 - Day0,
+     Day2_vs_Day0 = Day2 - Day0,
+     Day3_vs_Day0 = Day3 - Day0,
+     Day4_vs_Day0 = Day4 - Day0,
+     levels = design_matrix
+ )
> fit2 <- contrasts.fit(fit, contrast_matrix)
> fit2 <- eBayes(fit2)
> all_genes <- topTable(fit2, number = Inf, adjust.method = "BH")
> all_genes$Probe_ID <- rownames(all_genes)
> write.csv(all_genes, "all_statistical_results.csv", row.names = FALSE)
> print(paste("Analysis complete! Total genes tested:", nrow(all_genes)))
[1] "Analysis complete! Total genes tested: 22184"
> feature_info <- fData(gse)
> probe_to_gene <- data.frame(
+     Probe_ID = rownames(feature_info),
+     Symbol = feature_info$Symbol
+ )
> all_genes_named <- merge(probe_to_gene, all_genes, by = "Probe_ID")
> write.csv(all_genes_named, "all_statistical_results_named.csv", row.names = FALSE)
> print(head(all_genes_named[, c("Probe_ID", "Symbol", "adj.P.Val")], n = 5))
      Probe_ID  Symbol    adj.P.Val
1 ILMN_1343291  EEF1A1 7.951655e-01
2 ILMN_1343292    TUBB 2.994863e-05
3 ILMN_1343293     TXN 5.041612e-01
4 ILMN_1343294    ACTB 4.611118e-03
5 ILMN_1651209 SLC35E2 9.563534e-01
> target_genes <- c("CDKN1A", "GADD45A", "FDXR", "MDM2", "BAX", "DDB2")
> sanity_check <- all_genes_named[all_genes_named$Symbol %in% target_genes, ]
> sanity_summary <- sanity_check[, c("Symbol", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0", "adj.P.Val")]
> print(sanity_summary)
       Symbol Day1_vs_Day0 Day2_vs_Day0
1493     DDB2   0.75378924  0.191174552
4790      BAX   0.19685776 -0.009562275
6332  GADD45A   0.83905212  1.149642461
12110    MDM2   0.35749576  0.559484547
13410    MDM2   0.02275484  0.082877045
18277  CDKN1A   2.15764460  2.309785338
18577  CDKN1A   0.43479347  0.461871713
20115    FDXR   1.60687154  1.070469085
21987    MDM2  -0.12076265 -0.200649419
      Day3_vs_Day0 Day4_vs_Day0
1493    0.03661776  -0.27981137
4790   -0.06666850   0.27999196
6332    1.32038527   1.61542111
12110   0.60094185   1.19096277
13410   0.08234332   0.15524989
18277   2.27474478   2.52644835
18577   0.69463664   1.51500657
20115   1.01355488   1.17864830
21987  -0.09170076  -0.02768718
         adj.P.Val
1493  4.909477e-06
4790  2.304918e-01
6332  3.224223e-09
12110 1.481477e-08
13410 5.335436e-01
18277 1.628499e-11
18577 1.396220e-06
20115 9.570282e-09
21987 2.519652e-01
> sig_genes <- all_genes_named[all_genes_named$adj.P.Val < 0.05, ]
> get_pattern <- function(d1, d4) {
+     if (d1 > 0.5 & d4 > 0.5) return("Sustained_Up")
+     if (d1 > 0.5 & d4 <= 0.5) return("Early_Up_Transient")
+     if (d1 <= 0.5 & d4 > 0.5) return("Late_Up")
+     if (d1 < -0.5 & d4 < -0.5) return("Sustained_Down")
+     if (d1 < -0.5 & d4 >= -0.5) return("Early_Down_Transient")
+     if (d1 >= -0.5 & d4 < -0.5) return("Late_Down")
+     return("Complex_Pattern")
+ }
> sig_genes$Trajectory_Group <- mapply(get_pattern, sig_genes$Day1_vs_Day0, sig_genes$Day4_vs_Day0)
> final_deliverable <- sig_genes[, c("Symbol", "Probe_ID", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0", "adj.P.Val", "Trajectory_Group")]
> write.csv(final_deliverable, "final_discovery_cohort_genes.csv", row.names = FALSE)
> print(table(final_deliverable$Trajectory_Group))

     Complex_Pattern 
                5371 
Early_Down_Transient 
                  79 
  Early_Up_Transient 
                 150 
           Late_Down 
                1569 
             Late_Up 
                1649 
      Sustained_Down 
                 472 
        Sustained_Up 
                 427 
> # This will open a new, live window on your desktop displaying the real plot
> dev.new()
NULL
> hist(all_genes_named$P.Value, breaks = 50, col = "aquamarine3",
+      main = "Raw P-Value Distribution (limma)",
+      xlab = "Unadjusted P-Values", ylab = "Frequency")
> p_hist <- hist(all_genes_named$P.Value, breaks = 10, plot = FALSE)
> p_summary <- data.frame(
+     P_Value_Range = paste0(p_hist$breaks[-length(p_hist$breaks)], " to ", p_hist$breaks[-1]),
+     Gene_Count = p_hist$counts
+ )
> print(p_summary)
   P_Value_Range Gene_Count
1       0 to 0.1      12812
2     0.1 to 0.2       2007
3     0.2 to 0.3       1453
4     0.3 to 0.4       1245
5     0.4 to 0.5        999
6     0.5 to 0.6        879
7     0.6 to 0.7        822
8     0.7 to 0.8        714
9     0.8 to 0.9        656
10      0.9 to 1        597
> # Filter for genes that hit a log2 fold-change magnitude > 1 in at least one timepoint
> fc_threshold <- 1
> passing_fc <- apply(abs(sig_genes[, c("Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0")]), 1, max) > fc_threshold
> 
> sig_genes_strict <- sig_genes[passing_fc, ]
> 
> # Re-run the trajectory grouping on the high-magnitude set
> sig_genes_strict$Trajectory_Group <- mapply(get_pattern, sig_genes_strict$Day1_vs_Day0, sig_genes_strict$Day4_vs_Day0)
> 
> # Save the tighter, high-magnitude deliverable
> write.csv(sig_genes_strict, "final_discovery_cohort_genes_strict.csv", row.names = FALSE)
> 
> # Print the new group distributions
> print(table(sig_genes_strict$Trajectory_Group))

     Complex_Pattern 
                   5 
Early_Down_Transient 
                   4 
  Early_Up_Transient 
                  15 
           Late_Down 
                 390 
             Late_Up 
                 365 
      Sustained_Down 
                 306 
        Sustained_Up 
                 281 
> print(all_genes_named[1:20, c("Symbol", "Probe_ID", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0", "P.Value", "adj.P.Val")])
     Symbol     Probe_ID Day1_vs_Day0
1    EEF1A1 ILMN_1343291   0.02693546
2      TUBB ILMN_1343292   0.05738945
3       TXN ILMN_1343293  -0.12172866
4      ACTB ILMN_1343294  -0.06677505
5   SLC35E2 ILMN_1651209  -0.03886431
6  PDCD1LG2 ILMN_1651217   0.00450072
7     RPS28 ILMN_1651228   0.02466987
8     IPO13 ILMN_1651229   0.16330277
9     SYT14 ILMN_1651234   0.16311874
10    AFAP1 ILMN_1651235   0.02107029
11   GGTLA4 ILMN_1651236   0.09790856
12     CDT1 ILMN_1651237  -0.76379626
13    TRPV1 ILMN_1651238  -0.08645964
14      LPP ILMN_1651254   0.57575467
15     UGP2 ILMN_1651259   0.05299158
16    CCNE2 ILMN_1651260  -0.45162160
17     RSU1 ILMN_1651261   0.22090582
18   HNRPAB ILMN_1651262  -0.53251072
19 LOH12CR1 ILMN_1651268   0.03997167
20    SNIP1 ILMN_1651278  -0.01170703
   Day2_vs_Day0 Day3_vs_Day0
1   0.023824573   0.03639481
2   0.125762728   0.93601033
3  -0.119846487   0.00113452
4  -0.041550248  -0.03337118
5  -0.024101513  -0.07780560
6  -0.087144065   0.04223835
7   0.007975253   0.01965155
8   0.046203331   0.18571991
9  -0.010530662   0.04552061
10  0.035405090   0.01722035
11 -0.025352941   0.04485702
12 -0.789865746  -0.92891754
13 -0.224431071  -0.15526905
14  0.691144304   0.28342472
15  0.089646288  -0.10715516
16 -0.222277758  -0.32565320
17  0.070395687   0.01130486
18 -0.502686392  -0.49757834
19 -0.001549126  -0.04524389
20 -0.169929317   0.04876354
   Day4_vs_Day0      P.Value
1   -0.03419351 7.342305e-01
2    0.56754662 3.870480e-06
3   -0.05044818 3.973474e-01
4   -0.26059865 1.329459e-03
5   -0.06465406 9.409631e-01
6   -0.18476659 1.090488e-01
7   -0.43998769 2.445979e-08
8    0.20881015 1.979063e-01
9   -0.09170471 4.357142e-02
10  -0.09025016 4.354472e-01
11   0.18508400 3.428594e-02
12  -1.06473633 2.159881e-07
13  -0.05401385 1.857645e-01
14   0.27024457 1.769806e-02
15   0.48182510 2.857820e-03
16  -0.67017872 8.505256e-05
17   0.44224975 2.957165e-02
18  -0.57168540 1.947830e-06
19   0.09133970 6.318083e-01
20   0.12336495 4.952192e-02
      adj.P.Val
1  7.951655e-01
2  2.994863e-05
3  5.041612e-01
4  4.611118e-03
5  9.563534e-01
6  1.856136e-01
7  4.148441e-07
8  2.972491e-01
9  8.848301e-02
10 5.392214e-01
11 7.267336e-02
12 2.667862e-06
13 2.830940e-01
14 4.176742e-02
15 8.882987e-03
16 4.274594e-04
17 6.430283e-02
18 1.665793e-05
19 7.124639e-01
20 9.811017e-02
> # ----------------------------------------------------
> # COMPLETE RADIATION TIMECOURSE DISCOVERY PIPELINE
> # ----------------------------------------------------
> 
> # Step 1 & 2: Data Check and Log2 Transformation
> # stabilizing variance for high-intensity arrays
> exprs(gse) <- log2(exprs(gse))
> 
> # Step 4: Metadata Mapping and Parsing
> metadata <- pData(gse)
> sample_info <- data.frame(
+     Sample_ID = metadata$geo_accession,
+     Title     = metadata$title
+ )
> sample_info$TimePoint <- sub("_.*", "", sample_info$Title)
> sample_info$Replicate <- sub(".*_", "", sample_info$Title)
> write.csv(sample_info, "final_sample_table.csv", row.names = FALSE)
> 
> # Step 5 & 6: Limma Differential Expression Analysis
> library(limma)
> time_factor <- factor(sample_info$TimePoint, levels = c("Day0", "Day1", "Day2", "Day3", "Day4"))
> design_matrix <- model.matrix(~ 0 + time_factor)
> colnames(design_matrix) <- levels(time_factor)
> 
> fit <- lmFit(exprs(gse), design_matrix)
> contrast_matrix <- makeContrasts(
+     Day1_vs_Day0 = Day1 - Day0,
+     Day2_vs_Day0 = Day2 - Day0,
+     Day3_vs_Day0 = Day3 - Day0,
+     Day4_vs_Day0 = Day4 - Day0,
+     levels = design_matrix
+ )
> fit2 <- contrasts.fit(fit, contrast_matrix)
> fit2 <- eBayes(fit2)
> 
> # Extract full results table
> all_genes <- topTable(fit2, number = Inf, adjust.method = "BH")
> all_genes$Probe_ID <- rownames(all_genes)
> 
> # Map Microarray Probes to Gene Symbols
> feature_info <- fData(gse)
> probe_to_gene <- data.frame(
+     Probe_ID = rownames(feature_info),
+     Symbol = feature_info$Symbol
+ )
> all_genes_named <- merge(probe_to_gene, all_genes, by = "Probe_ID")
> 
> # Step 6 & 9: Trajectory Grouping (Strict |log2FC| > 1 Filter)
> get_pattern <- function(d1, d4) {
+     if (d1 > 0.5 & d4 > 0.5) return("Sustained_Up")
+     if (d1 > 0.5 & d4 <= 0.5) return("Early_Up_Transient")
+     if (d1 <= 0.5 & d4 > 0.5) return("Late_Up")
+     if (d1 < -0.5 & d4 < -0.5) return("Sustained_Down")
+     if (d1 < -0.5 & d4 >= -0.5) return("Early_Down_Transient")
+     if (d1 >= -0.5 & d4 < -0.5) return("Late_Down")
+     return("Complex_Pattern")
+ }
> 
> fc_threshold <- 1
> passing_fc <- apply(abs(all_genes_named[, c("Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0")]), 1, max) > fc_threshold
> sig_genes_strict <- all_genes_named[all_genes_named$adj.P.Val < 0.05 & passing_fc, ]
> 
> sig_genes_strict$Trajectory_Group <- mapply(get_pattern, sig_genes_strict$Day1_vs_Day0, sig_genes_strict$Day4_vs_Day0)
> write.csv(sig_genes_strict, "final_discovery_cohort_genes_strict.csv", row.names = FALSE)
> sessionInfo()
R version 4.6.0 (2026-04-24 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26200)

Matrix products: default
  LAPACK version 3.12.1

locale:
[1] LC_COLLATE=English_India.utf8 
[2] LC_CTYPE=English_India.utf8   
[3] LC_MONETARY=English_India.utf8
[4] LC_NUMERIC=C                  
[5] LC_TIME=English_India.utf8    

time zone: Asia/Calcutta
tzcode source: internal

attached base packages:
[1] stats4    stats     graphics 
[4] grDevices utils     datasets 
[7] methods   base     

other attached packages:
 [1] limma_3.68.4       
 [2] GEOquery_2.80.0    
 [3] oligo_1.76.0       
 [4] Biostrings_2.80.1  
 [5] Seqinfo_1.2.0      
 [6] XVector_0.52.0     
 [7] IRanges_2.46.0     
 [8] S4Vectors_0.50.1   
 [9] oligoClasses_1.74.0
[10] ArrayExpress_1.72.0
[11] Biobase_2.72.0     
[12] BiocGenerics_0.58.1
[13] generics_0.1.4     

loaded via a namespace (and not attached):
 [1] SummarizedExperiment_1.42.0
 [2] httr2_1.2.3                
 [3] lattice_0.22-9             
 [4] tzdb_0.5.0                 
 [5] vctrs_0.7.3                
 [6] tools_4.6.0                
 [7] curl_7.1.0                 
 [8] tibble_3.3.1               
 [9] RSQLite_3.53.3             
[10] blob_1.3.0                 
[11] R.oo_1.27.1                
[12] pkgconfig_2.0.3            
[13] Matrix_1.7-5               
[14] data.table_1.18.4          
[15] rentrez_1.2.4              
[16] lifecycle_1.0.5            
[17] compiler_4.6.0             
[18] statmod_1.5.2              
[19] codetools_0.2-20           
[20] preprocessCore_1.74.0      
[21] pillar_1.11.1              
[22] crayon_1.5.3               
[23] tidyr_1.3.2                
[24] R.utils_2.13.0             
[25] DelayedArray_0.38.2        
[26] cachem_1.1.0               
[27] iterators_1.0.14           
[28] abind_1.4-8                
[29] foreach_1.5.2              
[30] tidyselect_1.2.1           
[31] dplyr_1.2.1                
[32] purrr_1.2.2                
[33] splines_4.6.0              
[34] fastmap_1.2.0              
[35] grid_4.6.0                 
[36] cli_3.6.6                  
[37] SparseArray_1.12.2         
[38] magrittr_2.0.5             
[39] S4Arrays_1.12.0            
[40] XML_3.99-0.23              
[41] withr_3.0.3                
[42] readr_2.2.0                
[43] rappdirs_0.3.4             
[44] bit64_4.8.2                
[45] httr_1.4.8                 
[46] affyio_1.82.0              
[47] matrixStats_1.5.0          
[48] bit_4.6.0                  
[49] otel_0.2.0                 
[50] R.methodsS3_1.8.2          
[51] hms_1.1.4                  
[52] memoise_2.0.1              
[53] ff_4.5.2                   
[54] GenomicRanges_1.64.0       
[55] rlang_1.3.0                
[56] glue_1.8.1                 
[57] DBI_1.3.0                  
[58] BiocManager_1.30.27        
[59] xml2_1.6.0                 
[60] rstudioapi_0.19.0          
[61] jsonlite_2.0.0             
[62] R6_2.6.1                   
[63] affxparser_1.84.0          
[64] MatrixGenerics_1.24.0      
> if(!dir.exists("figures")) dir.create("figures")
> if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
> library(ggplot2)

> pca_res <- prcomp(t(exprs(gse)), scale. = TRUE)
> pca_data <- data.frame(Sample_ID = rownames(pca_res$x), pca_res$x, TimePoint = sample_info$TimePoint)
> 
> p1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = TimePoint)) +
+     geom_point(size = 4, alpha = 0.8) +
+     theme_minimal() +
+     labs(title = "PCA Plot of 20 Samples", x = paste0("PC1 (", round(summary(pca_res)$importance[2,1]*100, 1), "%)"), y = paste0("PC2 (", round(summary(pca_res)$importance[2,2]*100, 1), "%)"))
> 
> ggsave("figures/Fig1_PCA_Plot.pdf", plot = p1, width = 6, height = 5)
> ggsave("figures/Fig1_PCA_Plot.png", plot = p1, width = 6, height = 5)
> p1
> library(ggplot2)
> library(reshape2)
Warning message:
package ‘reshape2’ was built under R version 4.6.1 
> 
> melted_exprs <- melt(exprs(gse))
> colnames(melted_exprs) <- c("Probe_ID", "Sample_ID", "Expression")
> melted_exprs <- merge(melted_exprs, sample_info, by = "Sample_ID")
> 
> p2 <- ggplot(melted_exprs, aes(x = Sample_ID, y = Expression, fill = TimePoint)) +
+     geom_boxplot(outlier.size = 0.5) +
+     theme_minimal() +
+     theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
+     labs(title = "Expression Distribution Per Sample", x = "Samples", y = "Log2 Expression")
> 
> # Save files silently
> ggsave("figures/Fig2_Expression_Boxplot.pdf", plot = p2, width = 8, height = 5)
> ggsave("figures/Fig2_Expression_Boxplot.png", plot = p2, width = 8, height = 5)
> 
> # Force display to the RStudio plot window
> p2
> if (!requireNamespace("pheatmap", quietly = TRUE)) install.packages("pheatmap")
> library(pheatmap)
Warning message:
package ‘pheatmap’ was built under R version 4.6.1 
> 
> cor_matrix <- cor(exprs(gse))
> annotation_col <- data.frame(TimePoint = sample_info$TimePoint)
> rownames(annotation_col) <- sample_info$Sample_ID
> 
> # Generate and save plots directly
> pheatmap(cor_matrix, annotation_col = annotation_col, 
+          main = "Sample-to-Sample Correlation Heatmap",
+          filename = "figures/Fig3_Sample_Correlation.pdf", width = 7, height = 6)
> 
> pheatmap(cor_matrix, annotation_col = annotation_col, 
+          main = "Sample-to-Sample Correlation Heatmap",
+          filename = "figures/Fig3_Sample_Correlation.png", width = 7, height = 6)
> p3
Error: object 'p3' not found

> # Display on screen without saving
> pheatmap(cor_matrix, annotation_col = annotation_col, 
+          main = "Sample-to-Sample Correlation Heatmap")
> dev.off()
null device 
          1 
> library(pheatmap)
> pheatmap(cor_matrix, 
+          annotation_col = annotation_col, 
+          main = "Sample-to-Sample Correlation Heatmap")
> library(ggplot2)
> library(gridExtra)

Attaching package: ‘gridExtra’

The following object is masked from ‘package:Biobase’:

    combine

The following object is masked from ‘package:BiocGenerics’:

    combine

Warning message:
package ‘gridExtra’ was built under R version 4.6.1 
> 
> # Reconstituting un-logged values for this comparative plot
> exprs_before <- 2^(exprs(gse))
> 
> df_before <- data.frame(Expression = as.vector(exprs_before))
> df_after <- data.frame(Expression = as.vector(exprs(gse)))
> 
> p4_a <- ggplot(df_before, aes(x = Expression)) + 
+     geom_density(fill = "tomato", alpha = 0.6) + 
+     theme_minimal() + 
+     labs(title = "Before Log2 Transform", x = "Raw Intensity") + 
+     xlim(0, 5000)
> 
> p4_b <- ggplot(df_after, aes(x = Expression)) + 
+     geom_density(fill = "aquamarine3", alpha = 0.6) + 
+     theme_minimal() + 
+     labs(title = "After Log2 Transform", x = "Log2 Intensity")
> 
> p4 <- grid.arrange(p4_a, p4_b, ncol = 2)
> 
> ggsave("figures/Fig4_Log2_Comparison.pdf", plot = p4, width = 8, height = 4)
> ggsave("figures/Fig4_Log2_Comparison.png", plot = p4, width = 8, height = 4)
> 
> grid.draw(p4)
Error in grid.draw(p4) : could not find function "grid.draw"

> grid::grid.draw(p4)
> library(ggplot2)
> library(tidyr)

Attaching package: ‘tidyr’

The following object is masked from ‘package:reshape2’:

    smiths

The following object is masked from ‘package:S4Vectors’:

    expand

Warning message:
package ‘tidyr’ was built under R version 4.6.1 
> 
> volc_data <- all_genes_named[, c("Symbol", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0", "adj.P.Val")]
> volc_long <- gather(volc_data, Contrast, Log2FC, Day1_vs_Day0:Day4_vs_Day0)
> volc_long$Significance <- ifelse(volc_long$adj.P.Val < 0.05 & abs(volc_long$Log2FC) > 1, "Significant", "Not Significant")
> 
> p5 <- ggplot(volc_long, aes(x = Log2FC, y = -log10(adj.P.Val), color = Significance)) +
+     geom_point(alpha = 0.4, size = 0.8) +
+     facet_wrap(~Contrast, ncol = 2) +
+     scale_color_manual(values = c("grey70", "firebrick3")) +
+     theme_minimal() + 
+     labs(title = "Volcano Plots Across Timepoints", x = "Log2 Fold Change", y = "-log10(Adj. P-Value)")
> 
> # Save files
> ggsave("figures/Fig5_Volcano_Plots.pdf", plot = p5, width = 8, height = 7)
> ggsave("figures/Fig5_Volcano_Plots.png", plot = p5, width = 8, height = 7)
> 
> # Display to screen
> p5
> library(ggplot2)
> library(tidyr)
> 
> # Pull the relevant columns
> volc_data <- all_genes_named[, c("Probe_ID", "Symbol", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0")]
> 
> # Reshape to long format for plotting
> volc_long <- gather(volc_data, Contrast, Log2FC, Day1_vs_Day0:Day4_vs_Day0)
> 
> # Pull the adjusted p-values from all_genes_named using a clean match
> volc_long$adj.P.Val <- all_genes_named$adj.P.Val[match(volc_long$Probe_ID, all_genes_named$Probe_ID)]
> 
> # Mark significance based on whether the gene actually exists in your verified sig_genes_strict table
> volc_long$Significance <- ifelse(volc_long$Probe_ID %in% sig_genes_strict$Probe_ID, "Significant", "Not Significant")
> 
> p5_fixed <- ggplot(volc_long, aes(x = Log2FC, y = -log10(adj.P.Val), color = Significance)) +
+     geom_point(alpha = 0.5, size = 0.8) +
+     facet_wrap(~Contrast, ncol = 2) +
+     scale_color_manual(values = c("grey70", "firebrick3")) +
+     theme_minimal() + 
+     labs(title = "Volcano Plots Across Timepoints (Matched to Strict Set)", 
+          x = "Log2 Fold Change", 
+          y = "-log10(Adj. P-Value)")
> 
> # Overwrite the previous figures with the correct colored versions
> ggsave("figures/Fig5_Volcano_Plots.pdf", plot = p5_fixed, width = 8, height = 7)
> ggsave("figures/Fig5_Volcano_Plots.png", plot = p5_fixed, width = 8, height = 7)
> 
> # Display to screen
> p5_fixed
> library(ggplot2)
> library(tidyr)
> 
> # 1. Prepare data and pivot to long format
> volc_data <- all_genes_named[, c("Symbol", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0", "adj.P.Val")]
> volc_long <- gather(volc_data, Contrast, Log2FC, Day1_vs_Day0:Day4_vs_Day0)
> 
> # 2. Define significance purely by statistical reliability (FDR < 5%)
> volc_long$Significance <- ifelse(volc_long$adj.P.Val < 0.05, "Statistically Significant", "Not Significant")
> 
> p5_stat <- ggplot(volc_long, aes(x = Log2FC, y = -log10(adj.P.Val), color = Significance)) +
+     geom_point(alpha = 0.5, size = 0.8) +
+     facet_wrap(~Contrast, ncol = 2) +
+     scale_color_manual(values = c("grey70", "firebrick3")) +
+     theme_minimal() + 
+     labs(title = "Volcano Plots: Significant Gene Expression Shifts (FDR < 5%)", 
+          x = "Log2 Fold Change", 
+          y = "-log10(Adj. P-Value)")
> 
> # 3. Save the updated plots
> ggsave("figures/Fig5_Volcano_Plots.pdf", plot = p5_stat, width = 8, height = 7)
> ggsave("figures/Fig5_Volcano_Plots.png", plot = p5_stat, width = 8, height = 7)
> 
> # 4. Show on screen
> p5_stat
> nrow(sig_genes_strict)
[1] 0
> # 1. Identify which genes are significant in at least one contrast using a realistic threshold
> is_sig <- apply(all_genes_named[, c("Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0")], 1, function(x) {
+     any(abs(x) > 0.2)
+ }) & (all_genes_named$adj.P.Val < 0.05)
> 
> # 2. Subset the main table
> sig_genes_strict <- all_genes_named[is_sig, ]
> 
> # 3. Assign Trajectory Groups based on their maximum response direction to keep downstream plots happy
> sig_genes_strict$Trajectory_Group <- ifelse(sig_genes_strict$Day4_vs_Day0 > 0.2, "Sustained_Up",
+                                             ifelse(sig_genes_strict$Day4_vs_Day0 < -0.2, "Sustained_Down",
+                                                    ifelse(sig_genes_strict$Day2_vs_Day0 > 0.2, "Late_Up", "Late_Down")))
> 
> # Verify it worked
> nrow(sig_genes_strict)
[1] 656
> library(ggplot2)
> library(tidyr)
> 
> # Pull the relevant columns
> volc_data <- all_genes_named[, c("Probe_ID", "Symbol", "Day1_vs_Day0", "Day2_vs_Day0", "Day3_vs_Day0", "Day4_vs_Day0")]
> 
> # Reshape to long format for plotting
> volc_long <- gather(volc_data, Contrast, Log2FC, Day1_vs_Day0:Day4_vs_Day0)
> 
> # Pull the adjusted p-values from all_genes_named using a clean match
> volc_long$adj.P.Val <- all_genes_named$adj.P.Val[match(volc_long$Probe_ID, all_genes_named$Probe_ID)]
> 
> # Mark significance based on whether the gene actually exists in your verified 656 strict set
> volc_long$Significance <- ifelse(volc_long$Probe_ID %in% sig_genes_strict$Probe_ID, "Significant", "Not Significant")
> 
> p5_fixed <- ggplot(volc_long, aes(x = Log2FC, y = -log10(adj.P.Val), color = Significance)) +
+     geom_point(alpha = 0.5, size = 0.8) +
+     facet_wrap(~Contrast, ncol = 2) +
+     scale_color_manual(values = c("grey70", "firebrick3")) +
+     theme_minimal() + 
+     labs(title = "Volcano Plots Across Timepoints (Matched to Strict Set)", 
+          x = "Log2 Fold Change", 
+          y = "-log10(Adj. P-Value)")
> 
> # Overwrite the previous figures with the correct colored versions
> ggsave("figures/Fig5_Volcano_Plots.pdf", plot = p5_fixed, width = 8, height = 7)
> ggsave("figures/Fig5_Volcano_Plots.png", plot = p5_fixed, width = 8, height = 7)
> 
> # Display to screen
> p5_fixed
> library(ggplot2)
> library(reshape2)
> 
> targets <- c("CDKN1A", "FDXR", "GADD45A", "MDM2", "BAX", "DDB2")
> 
> # Pull rows matching target symbols using Probe_ID mapping
> target_probes <- all_genes_named$Probe_ID[all_genes_named$Symbol %in% targets]
> target_rows <- exprs(gse)[rownames(exprs(gse)) %in% target_probes, , drop=FALSE]
> rownames(target_rows) <- all_genes_named$Symbol[match(rownames(target_rows), all_genes_named$Probe_ID)]
> 
> melt_targets <- melt(target_rows)
> colnames(melt_targets) <- c("Symbol", "Sample_ID", "Expression")
> melt_targets <- merge(melt_targets, sample_info, by = "Sample_ID")
> melt_targets$TimeNumeric <- as.numeric(sub("Day", "", melt_targets$TimePoint))
> 
> # Calculate average trajectory
> mean_targets <- aggregate(Expression ~ Symbol + TimeNumeric, data = melt_targets, mean)
> 
> p6 <- ggplot(melt_targets, aes(x = TimeNumeric, y = Expression, color = Symbol)) +
+     geom_point(alpha = 0.6, size = 2) +
+     geom_line(data = mean_targets, aes(x = TimeNumeric, y = Expression, group = Symbol), size = 1.2) +
+     facet_wrap(~Symbol, scales = "free_y") +
+     theme_minimal() + 
+     theme(legend.position = "none") +
+     labs(title = "Expression Tracks of Radiation Checkpoint Monitors", 
+          x = "Day", 
+          y = "Log2 Expression Intensity")
Warning message:
Using `size` aesthetic for
lines was deprecated in
ggplot2 3.4.0.
ℹ Please use `linewidth`
  instead.
This warning is displayed
once per session.
Call
lifecycle::last_lifecycle_warnings()
to see where this warning was
generated. 
> 
> # Save files
> ggsave("figures/Fig6_Target_Tracks.pdf", plot = p6, width = 8, height = 5)
> ggsave("figures/Fig6_Target_Tracks.png", plot = p6, width = 8, height = 5)
> 
> # Display to screen
> p6
> library(pheatmap)
> 
> # Select the top 50 strictly significant genes based on p-value
> top_50_probes <- sig_genes_strict$Probe_ID[order(sig_genes_strict$adj.P.Val)][1:50]
> 
> # Extract their expression values
> heatmap_matrix <- exprs(gse)[top_50_probes, ]
> 
> # Map the row names to clean Gene Symbols
> rownames(heatmap_matrix) <- all_genes_named$Symbol[match(rownames(heatmap_matrix), all_genes_named$Probe_ID)]
> 
> # Set up column annotations for the time points
> annotation_col <- data.frame(TimePoint = sample_info$TimePoint)
> rownames(annotation_col) <- sample_info$Sample_ID
> 
> # Draw it directly on screen (scale = "row" standardizes rows to highlight trends)
> pheatmap(heatmap_matrix, 
+          scale = "row", 
+          annotation_col = annotation_col, 
+          show_colnames = FALSE,
+          main = "Top 50 Strictly Significant Differential Genes Across Timepoints")
> pheatmap(heatmap_matrix, 
+          scale = "row", 
+          annotation_col = annotation_col, 
+          show_colnames = FALSE,
+          main = "Top 50 Strictly Significant Differential Genes Across Timepoints",
+          filename = "figures/Fig7_Discovery_Heatmap.pdf", width = 7, height = 8)
> 
> pheatmap(heatmap_matrix, 
+          scale = "row", 
+          annotation_col = annotation_col, 
+          show_colnames = FALSE,
+          main = "Top 50 Strictly Significant Differential Genes Across Timepoints",
+          filename = "figures/Fig7_Discovery_Heatmap.png", width = 7, height = 8)
> # How many probes map to each canonical gene symbol?
> table(all_genes_named$Symbol[all_genes_named$Symbol %in% 
+                                  c("CDKN1A","FDXR","GADD45A","MDM2","BAX","DDB2")])

    BAX  CDKN1A    DDB2    FDXR GADD45A    MDM2 
      1       2       1       1       1       3 
> 
> # Show every probe for CDKN1A individually, not merged
> all_genes_named[all_genes_named$Symbol == "CDKN1A", 
+                 c("Probe_ID","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0","adj.P.Val")]
          Probe_ID Day1_vs_Day0 Day2_vs_Day0
18277 ILMN_1784602   0.21916050    0.2333638
18577 ILMN_1787212   0.08588608    0.0906207
      Day3_vs_Day0 Day4_vs_Day0    adj.P.Val
18277    0.2301222    0.2534067 2.545786e-10
18577    0.1347010    0.2773135 2.364856e-06
> canon_genes <- c("BAX","CDKN1A","DDB2","FDXR","GADD45A","MDM2")
> result <- all_genes_named[all_genes_named$Symbol %in% canon_genes,
+                           c("Symbol","Probe_ID","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0","P.Value","adj.P.Val")]
> result[order(result$Symbol), ]
       Symbol     Probe_ID Day1_vs_Day0
4790      BAX ILMN_1683300   0.03077326
18277  CDKN1A ILMN_1784602   0.21916050
18577  CDKN1A ILMN_1787212   0.08588608
1493     DDB2 ILMN_1660817   0.10532929
20115    FDXR ILMN_1799319   0.19334877
6332  GADD45A ILMN_1694075   0.14253922
12110    MDM2 ILMN_1736829   0.06431831
13410    MDM2 ILMN_1746493   0.00480446
21987    MDM2 ILMN_1814208  -0.02346615
      Day2_vs_Day0 Day3_vs_Day0 Day4_vs_Day0
4790  -0.002118683 -0.011055568  0.043985021
18277  0.233363782  0.230122181  0.253406664
18577  0.090620704  0.134701016  0.277313532
1493   0.027453486  0.005353223 -0.041157830
20115  0.131704197  0.125068575  0.144418059
6332   0.191148530  0.218185468  0.262735342
12110  0.099439054  0.106553269  0.203647855
13410  0.016872150  0.016579508  0.031292678
21987 -0.039202327 -0.018020606 -0.005385097
           P.Value    adj.P.Val
4790  1.583768e-01 2.444976e-01
18277 1.904979e-12 2.545786e-10
18577 1.543595e-07 2.364856e-06
1493  1.389346e-06 1.469779e-05
20115 1.689673e-09 5.637629e-08
6332  4.845448e-11 3.412426e-09
12110 4.161658e-10 1.880354e-08
13410 3.799092e-01 4.783009e-01
21987 1.285416e-01 2.075075e-01
> library(ggplot2)
> library(reshape2)
> 
> # Explicitly mapping the single best-performing probe for each target gene 
> # based strictly on your verified low adj.P.Val results
> curated_probes <- c(
+     "ILMN_1683300", # BAX
+     "ILMN_1784602", # CDKN1A (The highly responsive core variant)
+     "ILMN_1660817", # DDB2
+     "ILMN_1799319", # FDXR
+     "ILMN_1694075", # GADD45A
+     "ILMN_1736829"  # MDM2 (The only true significant responder probe)
+ )
> 
> # Pull rows matching your exact curated probes
> target_rows_clean <- exprs(gse)[rownames(exprs(gse)) %in% curated_probes, , drop=FALSE]
> 
> # Safely map the row names to clean Gene Symbols using the Probe_ID vector
> rownames(target_rows_clean) <- all_genes_named$Symbol[match(rownames(target_rows_clean), all_genes_named$Probe_ID)]
> 
> # Reshape into a long dataframe for ggplot2
> melt_targets_clean <- melt(target_rows_clean)
> colnames(melt_targets_clean) <- c("Symbol", "Sample_ID", "Expression")
> melt_targets_clean <- merge(melt_targets_clean, sample_info, by = "Sample_ID")
> melt_targets_clean$TimeNumeric <- as.numeric(sub("Day", "", melt_targets_clean$TimePoint))
> 
> # Calculate clean mean trajectories without background noise probes dragging down the line
> mean_targets_clean <- aggregate(Expression ~ Symbol + TimeNumeric, data = melt_targets_clean, mean)
> 
> # Build the publication-ready plot
> p6_clean <- ggplot(melt_targets_clean, aes(x = TimeNumeric, y = Expression, color = Symbol)) +
+     geom_point(alpha = 0.7, size = 2) +
+     geom_line(data = mean_targets_clean, aes(x = TimeNumeric, y = Expression, group = Symbol), size = 1.2) +
+     facet_wrap(~Symbol, scales = "free_y") +
+     theme_minimal() + 
+     theme(
+         legend.position = "none",
+         strip.text = element_text(face = "bold", size = 11)
+     ) +
+     labs(
+         title = "Expression Tracks of Radiation Checkpoint Monitors (Curated Single Probes)", 
+         x = "Day", 
+         y = "Log2 Expression Intensity"
+     )
> 
> # Overwrite previous messy versions with the clean ones
> ggsave("figures/Fig6_Target_Tracks.pdf", plot = p6_clean, width = 8, height = 5)
> ggsave("figures/Fig6_Target_Tracks.png", plot = p6_clean, width = 8, height = 5)
> 
> # Render directly to your RStudio screen
> p6_clean
> dev.off()
null device 
          1 
> print(p6_clean)
> plot_data <- all_genes_named[all_genes_named$Symbol %in% 
+                                  c("DDB2","BAX","GADD45A","MDM2","CDKN1A","FDXR"), 
+                              c("Symbol","Probe_ID","Day1_vs_Day0","Day2_vs_Day0","Day3_vs_Day0","Day4_vs_Day0","adj.P.Val")]
> print(plot_data)
       Symbol     Probe_ID
1493     DDB2 ILMN_1660817
4790      BAX ILMN_1683300
6332  GADD45A ILMN_1694075
12110    MDM2 ILMN_1736829
13410    MDM2 ILMN_1746493
18277  CDKN1A ILMN_1784602
18577  CDKN1A ILMN_1787212
20115    FDXR ILMN_1799319
21987    MDM2 ILMN_1814208
      Day1_vs_Day0
1493    0.10532929
4790    0.03077326
6332    0.14253922
12110   0.06431831
13410   0.00480446
18277   0.21916050
18577   0.08588608
20115   0.19334877
21987  -0.02346615
      Day2_vs_Day0
1493   0.027453486
4790  -0.002118683
6332   0.191148530
12110  0.099439054
13410  0.016872150
18277  0.233363782
18577  0.090620704
20115  0.131704197
21987 -0.039202327
      Day3_vs_Day0
1493   0.005353223
4790  -0.011055568
6332   0.218185468
12110  0.106553269
13410  0.016579508
18277  0.230122181
18577  0.134701016
20115  0.125068575
21987 -0.018020606
      Day4_vs_Day0
1493  -0.041157830
4790   0.043985021
6332   0.262735342
12110  0.203647855
13410  0.031292678
18277  0.253406664
18577  0.277313532
20115  0.144418059
21987 -0.005385097
         adj.P.Val
1493  1.469779e-05
4790  2.444976e-01
6332  3.412426e-09
12110 1.880354e-08
13410 4.783009e-01
18277 2.545786e-10
18577 2.364856e-06
20115 5.637629e-08
21987 2.075075e-01
> nrow(plot_data)
[1] 9
> library(tidyr)
> long_data <- pivot_longer(plot_data, 
+                           cols = c(Day1_vs_Day0, Day2_vs_Day0, Day3_vs_Day0, Day4_vs_Day0),
+                           names_to = "Day", values_to = "log2FC")
> long_data$Day <- as.numeric(gsub("Day|_vs_Day0", "", long_data$Day))
> long_data$Label <- paste0(long_data$Symbol, " (", long_data$Probe_ID, ")")
> print(long_data)
# A tibble: 36 × 6
   Symbol  Probe_ID   adj.P.Val
   <chr>   <chr>          <dbl>
 1 DDB2    ILMN_1660…   1.47e-5
 2 DDB2    ILMN_1660…   1.47e-5
 3 DDB2    ILMN_1660…   1.47e-5
 4 DDB2    ILMN_1660…   1.47e-5
 5 BAX     ILMN_1683…   2.44e-1
 6 BAX     ILMN_1683…   2.44e-1
 7 BAX     ILMN_1683…   2.44e-1
 8 BAX     ILMN_1683…   2.44e-1
 9 GADD45A ILMN_1694…   3.41e-9
10 GADD45A ILMN_1694…   3.41e-9
# ℹ 26 more rows
# ℹ 3 more variables:
#   Day <dbl>, log2FC <dbl>,
#   Label <chr>
# ℹ Use `print(n = ...)` to see more rows
> library(ggplot2)
> ggplot(long_data, aes(x = Day, y = log2FC, color = Label, group = Label)) +
+     geom_point() +
+     geom_line() +
+     facet_wrap(~Symbol, scales = "free_y") +
+     labs(title = "Expression Tracks by Individual Probe", y = "log2 Fold Change vs Day0") +
+     theme_minimal()
> library(ggplot2)
> 
> # --- Task 3: Define a high-contrast manual color palette for the 9 individual probes ---
> # Grouped by gene but distinctly split into light/dark/vibrant shades so you can tell them apart.
> probe_colors <- c(
+     "ILMN_1683300" = "firebrick3",      # BAX (Only one probe)
+     "ILMN_1784602" = "darkorange3",    # CDKN1A - High responder
+     "ILMN_1787212" = "gold",           # CDKN1A - Sluggish responder
+     "ILMN_1660817" = "forestgreen",    # DDB2 (Only one probe)
+     "ILMN_1799319" = "darkorchid4",    # FDXR (Only one probe)
+     "ILMN_1694075" = "deeppink2",      # GADD45A (Only one probe)
+     "ILMN_1736829" = "dodgerblue4",    # MDM2 - Significant responder
+     "ILMN_1746493" = "dodgerblue1",    # MDM2 - Flat noise probe 1
+     "ILMN_1814208" = "skyblue"         # MDM2 - Flat noise probe 2
+ )
> 
> # --- Prepare text labels for the Day 4 endpoint ---
> # Isolate just the Day 4 coordinates to place the small p-value text labels cleanly
> label_data <- subset(plot_data, TimeNumeric == 4)
Error in eval(e, x, parent.frame()) : object 'TimeNumeric' not found

> colnames(plot_data)
[1] "Symbol"       "Probe_ID"    
[3] "Day1_vs_Day0" "Day2_vs_Day0"
[5] "Day3_vs_Day0" "Day4_vs_Day0"
[7] "adj.P.Val"   
> library(ggplot2)
> 
> # --- Task 3: Map colors distinctly to your 9 probes ---
> probe_colors <- c(
+     "ILMN_1683300" = "firebrick3",   # BAX
+     "ILMN_1784602" = "darkorange3", # CDKN1A - Strong
+     "ILMN_1787212" = "gold",        # CDKN1A - Weak
+     "ILMN_1660817" = "forestgreen", # DDB2
+     "ILMN_1799319" = "darkorchid4", # FDXR
+     "ILMN_1694075" = "deeppink2",   # GADD45A
+     "ILMN_1736829" = "dodgerblue4", # MDM2 - Significant
+     "ILMN_1746493" = "dodgerblue1", # MDM2 - Flat 1
+     "ILMN_1814208" = "skyblue"      # MDM2 - Flat 2
+ )
> 
> # --- Reshape plot_data on the fly without changing your session objects ---
> plot_long <- data.frame(
+     Symbol      = rep(plot_data$Symbol, 5),
+     Probe_ID    = rep(plot_data$Probe_ID, 5),
+     adj.P.Val   = rep(plot_data$adj.P.Val, 5),
+     Day         = rep(c(0, 1, 2, 3, 4), each = nrow(plot_data)),
+     Expression  = c(
+         rep(0, nrow(plot_data)), # Baseline Day 0 is 0 fold-change
+         plot_data$Day1_vs_Day0,
+         plot_data$Day2_vs_Day0,
+         plot_data$Day3_vs_Day0,
+         plot_data$Day4_vs_Day0
+     )
+ )
> 
> # Isolate the endpoints for Task 1 p-value text labels
> label_data <- subset(plot_long, Day == 4)
> label_data$p_label <- formatC(label_data$adj.P.Val, format = "e", digits = 1)
> 
> # --- Build the Layout ---
> p6_final <- ggplot(plot_long, aes(x = Day, y = Expression, color = Probe_ID)) +
+     geom_point(aes(alpha = ifelse(adj.P.Val < 0.05, 0.8, 0.3)), size = 2) +
+     geom_line(aes(
+         linetype = ifelse(adj.P.Val < 0.05, "solid", "dashed"),
+         alpha = ifelse(adj.P.Val < 0.05, 1.0, 0.4)
+     ), size = 1.1) +
+     geom_text(data = label_data, aes(label = p_label), 
+               hjust = -0.15, vjust = 0.5, size = 2.8, show.legend = FALSE) +
+     scale_color_manual(values = probe_colors) +
+     scale_linetype_identity() +
+     scale_alpha_identity() +
+     facet_wrap(~Symbol, scales = "free_y") +
+     scale_x_continuous(breaks = 0:4, expand = expansion(mult = c(0.05, 0.3))) + 
+     theme_minimal() +
+     theme(
+         strip.text = element_text(face = "bold", size = 11),
+         legend.text = element_text(size = 8),
+         legend.title = element_text(face = "bold", size = 9)
+     ) +
+     labs(
+         title = "Probe-Level Trajectories of Radiation Checkpoint Monitors",
+         subtitle = "Solid lines: adj.P.Val < 0.05 | Dashed lines: Non-significant background probes",
+         x = "Day",
+         y = "Log2 Fold Change (Relative to Day 0)",
+         color = "Probe ID"
+     )
> 
> # --- Task 2: Flag BAX explicitly ---
> bax_ann <- data.frame(
+     Symbol = "BAX", 
+     Day = 2, 
+     Expression = max(plot_long$Expression[plot_long$Symbol == "BAX"]) + 0.02, 
+     label = "Not significant\n(adj.P.Val = 0.24)"
+ )
> 
> p6_final <- p6_final + 
+     geom_text(data = bax_ann, aes(label = label), 
+               color = "firebrick", fontface = "italic", size = 3.2, inherit.aes = FALSE)
> 
> # --- Print to screen to check ---
> p6_final
Error in `geom_text()`:
! Problem while setting up
  geom.
ℹ Error occurred in the 4th layer.
Caused by error in `compute_geom_1()`:
! `geom_text()` requires the
  following missing aesthetics: x and
  y.
Run `rlang::last_trace()` to see where the error occurred.

> # --- Task 2: Flag BAX explicitly with explicit x and y mapping ---
> bax_ann <- data.frame(
+     Symbol = "BAX", 
+     Day = 2, 
+     Expression = max(plot_long$Expression[plot_long$Symbol == "BAX"]) + 0.02, 
+     label = "Not significant\n(adj.P.Val = 0.24)"
+ )
> 
> # Re-add the layer with explicit x and y mappings specified inside aes()
> p6_final <- p6_final + 
+     geom_text(data = bax_ann, aes(x = Day, y = Expression, label = label), 
+               color = "firebrick", fontface = "italic", size = 3.2, inherit.aes = FALSE)
> 
> # --- Print to screen to check ---
> p6_final
Error in `geom_text()`:
! Problem while setting up
  geom.
ℹ Error occurred in the 4th layer.
Caused by error in `compute_geom_1()`:
! `geom_text()` requires the
  following missing aesthetics: x and
  y.
Run `rlang::last_trace()` to see where the error occurred.

> library(ggplot2)
> 
> # 1. Custom High-Contrast Manual Color Palette
> probe_colors <- c(
+     "ILMN_1683300" = "firebrick3",   # BAX
+     "ILMN_1784602" = "darkorange3", # CDKN1A - Strong
+     "ILMN_1787212" = "gold",        # CDKN1A - Weak
+     "ILMN_1660817" = "forestgreen", # DDB2
+     "ILMN_1799319" = "darkorchid4", # FDXR
+     "ILMN_1694075" = "deeppink2",   # GADD45A
+     "ILMN_1736829" = "dodgerblue4", # MDM2 - Significant
+     "ILMN_1746493" = "dodgerblue1", # MDM2 - Flat 1
+     "ILMN_1814208" = "skyblue"      # MDM2 - Flat 2
+ )
> 
> # 2. Isolate Endpoint Labels
> label_data <- subset(plot_long, Day == 4)
> label_data$p_label <- formatC(label_data$adj.P.Val, format = "e", digits = 1)
> 
> # 3. Define BAX Explicit Annotation Dataframe
> bax_ann <- data.frame(
+     Symbol = "BAX", 
+     Day = 2, 
+     Expression = max(plot_long$Expression[plot_long$Symbol == "BAX"]) + 0.02, 
+     label = "Not significant\n(adj.P.Val = 0.24)"
+ )
> 
> # 4. Construct Clean Plot Object Completely From Scratch
> p6_final_fixed <- ggplot(plot_long, aes(x = Day, y = Expression, color = Probe_ID)) +
+     # Points with dynamic alpha based on significance
+     geom_point(aes(alpha = ifelse(adj.P.Val < 0.05, 0.8, 0.3)), size = 2) +
+     # Lines with dynamic linetype and alpha based on significance
+     geom_line(aes(
+         linetype = ifelse(adj.P.Val < 0.05, "solid", "dashed"),
+         alpha = ifelse(adj.P.Val < 0.05, 1.0, 0.4)
+     ), size = 1.1) +
+     # Task 1: Add p-value labels at Day 4
+     geom_text(data = label_data, aes(label = p_label), 
+               hjust = -0.15, vjust = 0.5, size = 2.8, show.legend = FALSE) +
+     # Task 2: Add explicit static text annotation on the BAX panel
+     geom_text(data = bax_ann, aes(x = Day, y = Expression, label = label), 
+               color = "firebrick", fontface = "italic", size = 3.2, inherit.aes = FALSE) +
+     # Task 3: Apply the high-contrast manual colors and sync layout styles
+     scale_color_manual(values = probe_colors) +
+     scale_linetype_identity() +
+     scale_alpha_identity() +
+     facet_wrap(~Symbol, scales = "free_y") +
+     scale_x_continuous(breaks = 0:4, expand = expansion(mult = c(0.05, 0.3))) + 
+     theme_minimal() +
+     theme(
+         strip.text = element_text(face = "bold", size = 11),
+         legend.text = element_text(size = 8),
+         legend.title = element_text(face = "bold", size = 9)
+     ) +
+     labs(
+         title = "Probe-Level Trajectories of Radiation Checkpoint Monitors",
+         subtitle = "Solid lines: adj.P.Val < 0.05 | Dashed lines: Non-significant background probes",
+         x = "Day",
+         y = "Log2 Fold Change (Relative to Day 0)",
+         color = "Probe ID"
+     )
> 
> # --- Print directly to screen ---
> p6_final_fixed
> # 1. Extract raw p-values for your 6 canonical genes
> raw_p <- result$P.Value
> 
> # 2. Calculate adjusted p-values using the BH formula
> # 'p.adjust' is the built-in R function for the BH formula above
> verified_adj_p <- p.adjust(raw_p, method = "BH", n = length(raw_p))
> 
> # 3. Compare them to your existing column
> data.frame(
+     Probe = result$Probe_ID,
+     Manual_Verification = verified_adj_p,
+     Original_adj.P.Val = result$adj.P.Val
+ )
         Probe Manual_Verification
1 ILMN_1660817        2.084019e-06
2 ILMN_1683300        1.781739e-01
3 ILMN_1694075        2.180452e-10
4 ILMN_1736829        1.248497e-09
5 ILMN_1746493        3.799092e-01
6 ILMN_1784602        1.714481e-11
7 ILMN_1787212        2.778471e-07
8 ILMN_1799319        3.801764e-09
9 ILMN_1814208        1.652678e-01
  Original_adj.P.Val
1       1.469779e-05
2       2.444976e-01
3       3.412426e-09
4       1.880354e-08
5       4.783009e-01
6       2.545786e-10
7       2.364856e-06
8       5.637629e-08
9       2.075075e-01
