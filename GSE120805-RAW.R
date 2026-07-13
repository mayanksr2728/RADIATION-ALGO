# 1. Install/Load required packages
> if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
> BiocManager::install(c("recount3", "SummarizedExperiment"))
'getOption("repos")' replaces Bioconductor standard
repositories, see 'help("repositories", package =
"BiocManager")' for details.
Replacement repositories:
    CRAN: https://cran.rstudio.com/
Bioconductor version 3.23 (BiocManager 1.30.27), R 4.6.0
  (2026-04-24 ucrt)
Installing package(s) 'recount3'
also installing the dependency ‘sessioninfo’
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sessioninfo_1.2.4.zip'
trying URL 'https://bioconductor.org/packages/3.23/bioc/bin/windows/contrib/4.6/recount3_1.22.0.zip'
package ‘sessioninfo’ successfully unpacked and MD5 sums checked
package ‘recount3’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0\downloaded_packages
Installation paths not writeable, unable to update packages
  path: C:/Program Files/R/R-4.6.0/library
  packages:
    boot, class, cluster, KernSmooth, lattice, MASS, Matrix,
    mgcv, nlme, nnet, rpart, spatial, survival
Old packages: 'AICcmodavg', 'aisdk', 'aod', 'ape',
  'askpass', 'assertthat', 'babelgene', 'BiocManager',
  'bit', 'bit64', 'blob', 'bookdown', 'brio', 'broom',
  'bslib', 'cachem', 'callr', 'car', 'carData', 'caret',
  'caTools', 'cellranger', 'checkmate', 'chk', 'cli',
  'clipr', 'clock', 'cmprsk', 'colorspace', 'commonmark',
  'conflicted', 'corrplot', 'covr', 'cowplot', 'cpp11',
  'crayon', 'credentials', 'crosstalk', 'curl',
  'data.table', 'DBI', 'dbplyr', 'dcurves', 'Deriv', 'desc',
  'diffobj', 'digest', 'doBy', 'doParallel', 'dotCall64',
  'dqrng', 'DT', 'dtplyr', 'e1071', 'enrichit', 'EnvStats',
  'evaluate', 'exactRankTests', 'farver', 'fastDummies',
  'fastmap', 'ff', 'filelock', 'fitdistrplus', 'FNN',
  'fontawesome', 'fontquiver', 'forcats', 'foreach',
  'forecast', 'formatR', 'fracdiff', 'fs', 'futile.logger',
  'future', 'future.apply', 'gargle', 'gdtools', 'generics',
  'gert', 'ggbeeswarm', 'ggforce', 'ggfun', 'ggiraph',
  'ggnewscale', 'ggplot2', 'ggplotify', 'ggpubr', 'ggrepel',
  'ggridges', 'ggsci', 'ggsignif', 'ggtangle', 'ggtext',
  'gh', 'gitcreds', 'glmnet', 'glue', 'googledrive',
  'googlesheets4', 'gplots', 'gridExtra', 'gridGraphics',
  'gridtext', 'gson', 'gtable', 'gtools', 'hardhat',
  'harmony', 'haven', 'hdf5r', 'here', 'highr', 'Hmisc',
  'hms', 'htmlTable', 'htmltools', 'htmlwidgets', 'httpuv',
  'httr', 'httr2', 'ids', 'igraph', 'ini', 'inline',
  'ipred', 'irlba', 'isoband', 'iterators', 'jquerylib',
  'jsonlite', 'knitr', 'lambda.r', 'later', 'lava',
  'lazyeval', 'lifecycle', 'listenv', 'lmerTest', 'lmtest',
  'locfit', 'lubridate', 'magrittr', 'markdown', 'MatchIt',
  'MatrixModels', 'matrixStats', 'maxstat', 'memoise',
  'mets', 'miniUI', 'minpack.lm', 'minqa', 'ModelMetrics',
  'modelr', 'msigdbr', 'mvtnorm', 'nloptr', 'openssl',
  'otel', 'parallelly', 'patchwork', 'pbapply', 'pbkrtest',
  'pec', 'pheatmap', 'pillar', 'pkgbuild', 'pkgconfig',
  'pkgKitten', 'pkgload', 'plyr', 'polynom', 'praise',
  'prettyunits', 'pROC', 'processx', 'prodlim', 'progress',
  'progressr', 'promises', 'proxy', 'PRROC', 'ps',
  'Publish', 'purrr', 'quantreg', 'R.utils', 'R6', 'ragg',
  'ranger', 'RANN', 'rappdirs', 'rbibutils', 'Rcpp',
  'RcppAnnoy', 'RcppArmadillo', 'RcppEigen', 'RcppHNSW',
  'RcppML', 'RcppProgress', 'RcppTOML', 'Rdpack', 'readr',
  'readxl', 'recipes', 'reformulas', 'remaCor', 'rematch',
  'rematch2', 'remotes', 'rentrez', 'reprex', 'reshape2',
  'restfulr', 'reticulate', 'rex', 'riskRegression',
  'rlang', 'rmarkdown', 'rms', 'ROCR', 'rprojroot',
  'RSpectra', 'RSQLite', 'rstatix', 'rstudioapi', 'rsvd',
  'Rtsne', 'rvest', 'S7', 'sass', 'scales', 'scattermore',
  'scatterpie', 'sctransform', 'selectr', 'Seurat',
  'SeuratObject', 'shiny', 'sitmo', 'sourcetools', 'sp',
  'spam', 'SparseM', 'sparsevctrs', 'spatstat.data',
  'spatstat.explore', 'spatstat.geom', 'spatstat.random',
  'spatstat.sparse', 'spatstat.univar', 'spatstat.utils',
  'SQUAREM', 'statmod', 'stringr', 'survminer', 'sys',
  'systemfonts', 'testthat', 'textshaping', 'TH.data',
  'tidydr', 'tidyr', 'tidyselect', 'tidytree', 'tidyverse',
  'timechange', 'timereg', 'timeROC', 'tinytex', 'TMB',
  'tweenr', 'tzdb', 'umap', 'unmarked', 'urca', 'usethis',
  'utf8', 'uwot', 'vctrs', 'VGAM', 'vipor', 'viridis',
  'viridisLite', 'vroom', 'waldo', 'whisker', 'withr',
  'xml2', 'xtable', 'yaml', 'yulab.utils', 'zip', 'zoo'
Update all/some/none? [a/s/n]: library(recount3)
Update all/some/none? [a/s/n]: library(SummarizedExperiment)
Update all/some/none? [a/s/n]: 
Update all/some/none? [a/s/n]: # 2. Identify the project
Update all/some/none? [a/s/n]: human_projects <- available_projects()
Update all/some/none? [a/s/n]: proj_info <- subset(human_projects, project == "SRP162608")
Update all/some/none? [a/s/n]: 
Update all/some/none? [a/s/n]: # 3. Create the RSE (RangedSummarizedExperiment) object
Update all/some/none? [a/s/n]: # This pulls the standardized gene-level counts
Update all/some/none? [a/s/n]: rse_gene <- create_rse(proj_info)
Update all/some/none? [a/s/n]: 
Update all/some/none? [a/s/n]: # 4. Convert base-pair coverage to actual read counts
Update all/some/none? [a/s/n]: # This is the essential step for DESeq2 compatibility
Update all/some/none? [a/s/n]: assay(rse_gene, "counts") <- compute_read_counts(rse_gene)
Update all/some/none? [a/s/n]: 
Update all/some/none? [a/s/n]: # 5. Save the raw RSE object
Update all/some/none? [a/s/n]: if(!dir.exists("data")) dir.create("data")
Update all/some/none? [a/s/n]: saveRDS(rse_gene, "data/GSE120805_raw_rse.rds")
Update all/some/none? [a/s/n]: 
Update all/some/none? [a/s/n]: # Verification: Check sample count and dimension
Update all/some/none? [a/s/n]: dim(rse_gene)
Update all/some/none? [a/s/n]: 
a
Warning: packages ‘generics’, ‘ggplot2’, ‘gridExtra’, ‘pheatmap’, ‘reshape2’, ‘tidyr’ are in use and will not be installed

  There are binary versions available but the source
  versions are later:
           binary source needs_compilation
colorspace  2.1-2  2.1-3              TRUE
mvtnorm     1.4-1  1.4-2              TRUE
zip         3.0.0  3.0.1              TRUE

  Binaries will be installed
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/AICcmodavg_2.3-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/aisdk_1.4.12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/aod_1.3.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ape_5.8-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/askpass_1.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/assertthat_0.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/babelgene_22.9.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/BiocManager_1.30.27.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/bit_4.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/bit64_4.8.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/blob_1.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/bookdown_0.47.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/brio_1.1.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/broom_1.0.13.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/bslib_0.11.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cachem_1.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/callr_3.8.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/car_3.1-5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/carData_3.0-6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/caret_7.0-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/caTools_1.18.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cellranger_1.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/checkmate_2.3.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/chk_0.10.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cli_3.6.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/clipr_0.8.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/clock_0.7.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cmprsk_2.2-12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/colorspace_2.1-2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/commonmark_2.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/conflicted_1.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/corrplot_0.95.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/covr_3.6.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cowplot_1.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/cpp11_0.5.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/crayon_1.5.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/credentials_2.0.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/crosstalk_1.2.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/curl_7.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/data.table_1.18.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/DBI_1.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/dbplyr_2.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/dcurves_0.5.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Deriv_4.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/desc_1.4.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/diffobj_0.3.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/digest_0.6.39.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/doBy_4.7.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/doParallel_1.0.17.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/dotCall64_1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/dqrng_0.4.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/DT_0.34.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/dtplyr_1.3.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/e1071_1.7-17.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/enrichit_0.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/EnvStats_3.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/evaluate_1.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/exactRankTests_0.8-37.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/farver_2.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fastDummies_1.7.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fastmap_1.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ff_4.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/filelock_1.0.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fitdistrplus_1.2-6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/FNN_1.1.4.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fontawesome_0.5.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fontquiver_0.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/forcats_1.0.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/foreach_1.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/forecast_9.0.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/formatR_1.14.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fracdiff_1.5-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/fs_2.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/futile.logger_1.4.9.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/future_1.70.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/future.apply_1.20.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gargle_1.6.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gdtools_0.5.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gert_2.3.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggbeeswarm_0.7.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggforce_0.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggfun_0.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggiraph_0.9.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggnewscale_0.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggplotify_0.1.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggpubr_1.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggrepel_0.9.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggridges_0.5.7.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggsci_5.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggsignif_0.6.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggtangle_0.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ggtext_0.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gh_1.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gitcreds_0.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/glmnet_5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/glue_1.8.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/googledrive_2.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/googlesheets4_1.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gplots_3.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gridGraphics_0.5-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gridtext_0.1.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gson_0.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gtable_0.3.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/gtools_3.9.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/hardhat_1.4.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/harmony_2.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/haven_2.5.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/hdf5r_1.3.12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/here_1.0.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/highr_0.12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Hmisc_5.2-6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/hms_1.1.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/htmlTable_2.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/htmltools_0.5.9.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/htmlwidgets_1.6.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/httpuv_1.6.17.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/httr_1.4.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/httr2_1.2.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ids_1.0.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/igraph_2.3.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ini_0.3.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/inline_0.3.21.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ipred_0.9-15.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/irlba_2.3.7.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/isoband_0.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/iterators_1.0.14.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/jquerylib_0.1.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/jsonlite_2.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/knitr_1.51.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lambda.r_1.2.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/later_1.4.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lava_1.9.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lazyeval_0.2.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lifecycle_1.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/listenv_1.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lmerTest_3.2-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lmtest_0.9-40.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/locfit_1.5-9.12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/lubridate_1.9.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/magrittr_2.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/markdown_2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/MatchIt_4.7.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/MatrixModels_0.5-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/matrixStats_1.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/maxstat_0.7-26.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/memoise_2.0.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/mets_1.3.11.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/miniUI_0.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/minpack.lm_1.2-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/minqa_1.2.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ModelMetrics_1.2.2.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/modelr_0.1.11.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/msigdbr_26.1.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/mvtnorm_1.4-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/nloptr_2.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/openssl_2.4.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/otel_0.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/parallelly_1.48.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/patchwork_1.3.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pbapply_1.7-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pbkrtest_0.5.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pec_2025.06.24.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pillar_1.11.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pkgbuild_1.4.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pkgconfig_2.0.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pkgKitten_0.2.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pkgload_1.5.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/plyr_1.8.9.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/polynom_1.4-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/praise_1.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/prettyunits_1.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/pROC_1.19.0.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/processx_3.9.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/prodlim_2026.03.11.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/progress_1.2.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/progressr_1.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/promises_1.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/proxy_0.4-29.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/PRROC_1.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ps_1.9.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Publish_2025.07.24.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/purrr_1.2.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/quantreg_6.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/R.utils_2.13.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/R6_2.6.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ragg_1.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ranger_0.18.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RANN_2.6.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rappdirs_0.3.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rbibutils_2.4.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Rcpp_1.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppAnnoy_0.0.23.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppArmadillo_15.4.0-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppEigen_0.3.4.0.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppHNSW_0.7.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppML_0.3.7.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppProgress_0.4.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RcppTOML_0.2.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Rdpack_2.6.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/readr_2.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/readxl_1.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/recipes_1.3.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/reformulas_0.4.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/remaCor_0.0.20.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rematch_2.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rematch2_2.1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/remotes_2.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rentrez_1.2.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/reprex_2.1.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/restfulr_0.0.17.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/reticulate_1.46.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rex_1.2.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/riskRegression_2026.03.11.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rlang_1.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rmarkdown_2.31.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rms_8.1-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/ROCR_1.0-12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rprojroot_2.1.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RSpectra_0.16-2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/RSQLite_3.53.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rstatix_1.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rstudioapi_0.19.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rsvd_1.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Rtsne_0.17.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/rvest_1.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/S7_0.2.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sass_0.4.10.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/scales_1.4.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/scattermore_1.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/scatterpie_0.2.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sctransform_0.4.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/selectr_0.6-0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/Seurat_5.5.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/SeuratObject_5.4.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/shiny_1.14.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sitmo_2.0.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sourcetools_0.1.7-2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sp_2.2-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spam_2.11-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/SparseM_1.84-2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sparsevctrs_0.3.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.data_3.1-9.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.explore_3.8-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.geom_3.8-1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.random_3.5-0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.sparse_3.2-0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.univar_3.2-0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/spatstat.utils_3.2-3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/SQUAREM_2026.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/statmod_1.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/stringr_1.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/survminer_0.5.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/sys_3.4.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/systemfonts_1.3.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/testthat_3.3.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/textshaping_1.0.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/TH.data_1.1-5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tidydr_0.0.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tidyselect_1.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tidytree_0.4.8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tidyverse_2.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/timechange_0.4.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/timereg_2.0.7.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/timeROC_0.4.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tinytex_0.60.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/TMB_1.9.21.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tweenr_2.0.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/tzdb_0.5.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/umap_0.2.10.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/unmarked_1.5.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/urca_1.3-4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/usethis_3.2.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/utf8_1.2.6.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/uwot_0.2.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/vctrs_0.7.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/VGAM_1.1-14.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/vipor_0.4.7.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/viridis_0.6.5.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/viridisLite_0.4.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/vroom_1.7.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/waldo_0.6.2.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/whisker_0.4.1.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/withr_3.0.3.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/xml2_1.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/xtable_1.8-8.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/yaml_2.3.12.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/yulab.utils_0.2.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/zip_3.0.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/zoo_1.8-15.zip'
package ‘AICcmodavg’ successfully unpacked and MD5 sums checked
package ‘aisdk’ successfully unpacked and MD5 sums checked
package ‘aod’ successfully unpacked and MD5 sums checked
package ‘ape’ successfully unpacked and MD5 sums checked
package ‘askpass’ successfully unpacked and MD5 sums checked
package ‘assertthat’ successfully unpacked and MD5 sums checked
package ‘babelgene’ successfully unpacked and MD5 sums checked
package ‘BiocManager’ successfully unpacked and MD5 sums checked
package ‘bit’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘bit’
Warning: restored ‘bit’
package ‘bit64’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘bit64’
Warning: restored ‘bit64’
package ‘blob’ successfully unpacked and MD5 sums checked
package ‘bookdown’ successfully unpacked and MD5 sums checked
package ‘brio’ successfully unpacked and MD5 sums checked
package ‘broom’ successfully unpacked and MD5 sums checked
package ‘bslib’ successfully unpacked and MD5 sums checked
package ‘cachem’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘cachem’
Warning: restored ‘cachem’
package ‘callr’ successfully unpacked and MD5 sums checked
package ‘car’ successfully unpacked and MD5 sums checked
package ‘carData’ successfully unpacked and MD5 sums checked
package ‘caret’ successfully unpacked and MD5 sums checked
package ‘caTools’ successfully unpacked and MD5 sums checked
package ‘cellranger’ successfully unpacked and MD5 sums checked
package ‘checkmate’ successfully unpacked and MD5 sums checked
package ‘chk’ successfully unpacked and MD5 sums checked
package ‘cli’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘cli’
Warning: restored ‘cli’
package ‘clipr’ successfully unpacked and MD5 sums checked
package ‘clock’ successfully unpacked and MD5 sums checked
package ‘cmprsk’ successfully unpacked and MD5 sums checked
package ‘colorspace’ successfully unpacked and MD5 sums checked
package ‘commonmark’ successfully unpacked and MD5 sums checked
package ‘conflicted’ successfully unpacked and MD5 sums checked
package ‘corrplot’ successfully unpacked and MD5 sums checked
package ‘covr’ successfully unpacked and MD5 sums checked
package ‘cowplot’ successfully unpacked and MD5 sums checked
package ‘cpp11’ successfully unpacked and MD5 sums checked
package ‘crayon’ successfully unpacked and MD5 sums checked
package ‘credentials’ successfully unpacked and MD5 sums checked
package ‘crosstalk’ successfully unpacked and MD5 sums checked
package ‘curl’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘curl’
Warning: restored ‘curl’
package ‘data.table’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘data.table’
Warning: restored ‘data.table’
package ‘DBI’ successfully unpacked and MD5 sums checked
package ‘dbplyr’ successfully unpacked and MD5 sums checked
package ‘dcurves’ successfully unpacked and MD5 sums checked
package ‘Deriv’ successfully unpacked and MD5 sums checked
package ‘desc’ successfully unpacked and MD5 sums checked
package ‘diffobj’ successfully unpacked and MD5 sums checked
package ‘digest’ successfully unpacked and MD5 sums checked
package ‘doBy’ successfully unpacked and MD5 sums checked
package ‘doParallel’ successfully unpacked and MD5 sums checked
package ‘dotCall64’ successfully unpacked and MD5 sums checked
package ‘dqrng’ successfully unpacked and MD5 sums checked
package ‘DT’ successfully unpacked and MD5 sums checked
package ‘dtplyr’ successfully unpacked and MD5 sums checked
package ‘e1071’ successfully unpacked and MD5 sums checked
package ‘enrichit’ successfully unpacked and MD5 sums checked
package ‘EnvStats’ successfully unpacked and MD5 sums checked
package ‘evaluate’ successfully unpacked and MD5 sums checked
package ‘exactRankTests’ successfully unpacked and MD5 sums checked
package ‘farver’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘farver’
Warning: restored ‘farver’
package ‘fastDummies’ successfully unpacked and MD5 sums checked
package ‘fastmap’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘fastmap’
Warning: restored ‘fastmap’
package ‘ff’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘ff’
Warning: restored ‘ff’
package ‘filelock’ successfully unpacked and MD5 sums checked
package ‘fitdistrplus’ successfully unpacked and MD5 sums checked
package ‘FNN’ successfully unpacked and MD5 sums checked
package ‘fontawesome’ successfully unpacked and MD5 sums checked
package ‘fontquiver’ successfully unpacked and MD5 sums checked
package ‘forcats’ successfully unpacked and MD5 sums checked
package ‘foreach’ successfully unpacked and MD5 sums checked
package ‘forecast’ successfully unpacked and MD5 sums checked
package ‘formatR’ successfully unpacked and MD5 sums checked
package ‘fracdiff’ successfully unpacked and MD5 sums checked
package ‘fs’ successfully unpacked and MD5 sums checked
package ‘futile.logger’ successfully unpacked and MD5 sums checked
package ‘future’ successfully unpacked and MD5 sums checked
package ‘future.apply’ successfully unpacked and MD5 sums checked
package ‘gargle’ successfully unpacked and MD5 sums checked
package ‘gdtools’ successfully unpacked and MD5 sums checked
package ‘gert’ successfully unpacked and MD5 sums checked
package ‘ggbeeswarm’ successfully unpacked and MD5 sums checked
package ‘ggforce’ successfully unpacked and MD5 sums checked
package ‘ggfun’ successfully unpacked and MD5 sums checked
package ‘ggiraph’ successfully unpacked and MD5 sums checked
package ‘ggnewscale’ successfully unpacked and MD5 sums checked
package ‘ggplotify’ successfully unpacked and MD5 sums checked
package ‘ggpubr’ successfully unpacked and MD5 sums checked
package ‘ggrepel’ successfully unpacked and MD5 sums checked
package ‘ggridges’ successfully unpacked and MD5 sums checked
package ‘ggsci’ successfully unpacked and MD5 sums checked
package ‘ggsignif’ successfully unpacked and MD5 sums checked
package ‘ggtangle’ successfully unpacked and MD5 sums checked
package ‘ggtext’ successfully unpacked and MD5 sums checked
package ‘gh’ successfully unpacked and MD5 sums checked
package ‘gitcreds’ successfully unpacked and MD5 sums checked
package ‘glmnet’ successfully unpacked and MD5 sums checked
package ‘glue’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘glue’
Warning: restored ‘glue’
package ‘googledrive’ successfully unpacked and MD5 sums checked
package ‘googlesheets4’ successfully unpacked and MD5 sums checked
package ‘gplots’ successfully unpacked and MD5 sums checked
package ‘gridGraphics’ successfully unpacked and MD5 sums checked
package ‘gridtext’ successfully unpacked and MD5 sums checked
package ‘gson’ successfully unpacked and MD5 sums checked
package ‘gtable’ successfully unpacked and MD5 sums checked
package ‘gtools’ successfully unpacked and MD5 sums checked
package ‘hardhat’ successfully unpacked and MD5 sums checked
package ‘harmony’ successfully unpacked and MD5 sums checked
package ‘haven’ successfully unpacked and MD5 sums checked
package ‘hdf5r’ successfully unpacked and MD5 sums checked
package ‘here’ successfully unpacked and MD5 sums checked
package ‘highr’ successfully unpacked and MD5 sums checked
package ‘Hmisc’ successfully unpacked and MD5 sums checked
package ‘hms’ successfully unpacked and MD5 sums checked
package ‘htmlTable’ successfully unpacked and MD5 sums checked
package ‘htmltools’ successfully unpacked and MD5 sums checked
package ‘htmlwidgets’ successfully unpacked and MD5 sums checked
package ‘httpuv’ successfully unpacked and MD5 sums checked
package ‘httr’ successfully unpacked and MD5 sums checked
package ‘httr2’ successfully unpacked and MD5 sums checked
package ‘ids’ successfully unpacked and MD5 sums checked
package ‘igraph’ successfully unpacked and MD5 sums checked
package ‘ini’ successfully unpacked and MD5 sums checked
package ‘inline’ successfully unpacked and MD5 sums checked
package ‘ipred’ successfully unpacked and MD5 sums checked
package ‘irlba’ successfully unpacked and MD5 sums checked
package ‘isoband’ successfully unpacked and MD5 sums checked
package ‘iterators’ successfully unpacked and MD5 sums checked
package ‘jquerylib’ successfully unpacked and MD5 sums checked
package ‘jsonlite’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘jsonlite’
Warning: restored ‘jsonlite’
package ‘knitr’ successfully unpacked and MD5 sums checked
package ‘lambda.r’ successfully unpacked and MD5 sums checked
package ‘later’ successfully unpacked and MD5 sums checked
package ‘lava’ successfully unpacked and MD5 sums checked
package ‘lazyeval’ successfully unpacked and MD5 sums checked
package ‘lifecycle’ successfully unpacked and MD5 sums checked
package ‘listenv’ successfully unpacked and MD5 sums checked
package ‘lmerTest’ successfully unpacked and MD5 sums checked
package ‘lmtest’ successfully unpacked and MD5 sums checked
package ‘locfit’ successfully unpacked and MD5 sums checked
package ‘lubridate’ successfully unpacked and MD5 sums checked
package ‘magrittr’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘magrittr’
Warning: restored ‘magrittr’
package ‘markdown’ successfully unpacked and MD5 sums checked
package ‘MatchIt’ successfully unpacked and MD5 sums checked
package ‘MatrixModels’ successfully unpacked and MD5 sums checked
package ‘matrixStats’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘matrixStats’
Warning: restored ‘matrixStats’
package ‘maxstat’ successfully unpacked and MD5 sums checked
package ‘memoise’ successfully unpacked and MD5 sums checked
package ‘mets’ successfully unpacked and MD5 sums checked
package ‘miniUI’ successfully unpacked and MD5 sums checked
package ‘minpack.lm’ successfully unpacked and MD5 sums checked
package ‘minqa’ successfully unpacked and MD5 sums checked
package ‘ModelMetrics’ successfully unpacked and MD5 sums checked
package ‘modelr’ successfully unpacked and MD5 sums checked
package ‘msigdbr’ successfully unpacked and MD5 sums checked
package ‘mvtnorm’ successfully unpacked and MD5 sums checked
package ‘nloptr’ successfully unpacked and MD5 sums checked
package ‘openssl’ successfully unpacked and MD5 sums checked
package ‘otel’ successfully unpacked and MD5 sums checked
package ‘parallelly’ successfully unpacked and MD5 sums checked
package ‘patchwork’ successfully unpacked and MD5 sums checked
package ‘pbapply’ successfully unpacked and MD5 sums checked
package ‘pbkrtest’ successfully unpacked and MD5 sums checked
package ‘pec’ successfully unpacked and MD5 sums checked
package ‘pillar’ successfully unpacked and MD5 sums checked
package ‘pkgbuild’ successfully unpacked and MD5 sums checked
package ‘pkgconfig’ successfully unpacked and MD5 sums checked
package ‘pkgKitten’ successfully unpacked and MD5 sums checked
package ‘pkgload’ successfully unpacked and MD5 sums checked
package ‘plyr’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘plyr’
Warning: restored ‘plyr’
package ‘polynom’ successfully unpacked and MD5 sums checked
package ‘praise’ successfully unpacked and MD5 sums checked
package ‘prettyunits’ successfully unpacked and MD5 sums checked
package ‘pROC’ successfully unpacked and MD5 sums checked
package ‘processx’ successfully unpacked and MD5 sums checked
package ‘prodlim’ successfully unpacked and MD5 sums checked
package ‘progress’ successfully unpacked and MD5 sums checked
package ‘progressr’ successfully unpacked and MD5 sums checked
package ‘promises’ successfully unpacked and MD5 sums checked
package ‘proxy’ successfully unpacked and MD5 sums checked
package ‘PRROC’ successfully unpacked and MD5 sums checked
package ‘ps’ successfully unpacked and MD5 sums checked
package ‘Publish’ successfully unpacked and MD5 sums checked
package ‘purrr’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘purrr’
Warning: restored ‘purrr’
package ‘quantreg’ successfully unpacked and MD5 sums checked
package ‘R.utils’ successfully unpacked and MD5 sums checked
package ‘R6’ successfully unpacked and MD5 sums checked
package ‘ragg’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘ragg’
Warning: restored ‘ragg’
package ‘ranger’ successfully unpacked and MD5 sums checked
package ‘RANN’ successfully unpacked and MD5 sums checked
package ‘rappdirs’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘rappdirs’
Warning: restored ‘rappdirs’
package ‘rbibutils’ successfully unpacked and MD5 sums checked
package ‘Rcpp’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘Rcpp’
Warning: restored ‘Rcpp’
package ‘RcppAnnoy’ successfully unpacked and MD5 sums checked
package ‘RcppArmadillo’ successfully unpacked and MD5 sums checked
package ‘RcppEigen’ successfully unpacked and MD5 sums checked
package ‘RcppHNSW’ successfully unpacked and MD5 sums checked
package ‘RcppML’ successfully unpacked and MD5 sums checked
package ‘RcppProgress’ successfully unpacked and MD5 sums checked
package ‘RcppTOML’ successfully unpacked and MD5 sums checked
package ‘Rdpack’ successfully unpacked and MD5 sums checked
package ‘readr’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘readr’
Warning: restored ‘readr’
package ‘readxl’ successfully unpacked and MD5 sums checked
package ‘recipes’ successfully unpacked and MD5 sums checked
package ‘reformulas’ successfully unpacked and MD5 sums checked
package ‘remaCor’ successfully unpacked and MD5 sums checked
package ‘rematch’ successfully unpacked and MD5 sums checked
package ‘rematch2’ successfully unpacked and MD5 sums checked
package ‘remotes’ successfully unpacked and MD5 sums checked
package ‘rentrez’ successfully unpacked and MD5 sums checked
package ‘reprex’ successfully unpacked and MD5 sums checked
package ‘restfulr’ successfully unpacked and MD5 sums checked
package ‘reticulate’ successfully unpacked and MD5 sums checked
package ‘rex’ successfully unpacked and MD5 sums checked
package ‘riskRegression’ successfully unpacked and MD5 sums checked
package ‘rlang’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘rlang’
Warning: restored ‘rlang’
package ‘rmarkdown’ successfully unpacked and MD5 sums checked
package ‘rms’ successfully unpacked and MD5 sums checked
package ‘ROCR’ successfully unpacked and MD5 sums checked
package ‘rprojroot’ successfully unpacked and MD5 sums checked
package ‘RSpectra’ successfully unpacked and MD5 sums checked
package ‘RSQLite’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘RSQLite’
Warning: restored ‘RSQLite’
package ‘rstatix’ successfully unpacked and MD5 sums checked
package ‘rstudioapi’ successfully unpacked and MD5 sums checked
package ‘rsvd’ successfully unpacked and MD5 sums checked
package ‘Rtsne’ successfully unpacked and MD5 sums checked
package ‘rvest’ successfully unpacked and MD5 sums checked
package ‘S7’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘S7’
Warning: restored ‘S7’
package ‘sass’ successfully unpacked and MD5 sums checked
package ‘scales’ successfully unpacked and MD5 sums checked
package ‘scattermore’ successfully unpacked and MD5 sums checked
package ‘scatterpie’ successfully unpacked and MD5 sums checked
package ‘sctransform’ successfully unpacked and MD5 sums checked
package ‘selectr’ successfully unpacked and MD5 sums checked
package ‘Seurat’ successfully unpacked and MD5 sums checked
package ‘SeuratObject’ successfully unpacked and MD5 sums checked
package ‘shiny’ successfully unpacked and MD5 sums checked
package ‘sitmo’ successfully unpacked and MD5 sums checked
package ‘sourcetools’ successfully unpacked and MD5 sums checked
package ‘sp’ successfully unpacked and MD5 sums checked
package ‘spam’ successfully unpacked and MD5 sums checked
package ‘SparseM’ successfully unpacked and MD5 sums checked
package ‘sparsevctrs’ successfully unpacked and MD5 sums checked
package ‘spatstat.data’ successfully unpacked and MD5 sums checked
package ‘spatstat.explore’ successfully unpacked and MD5 sums checked
package ‘spatstat.geom’ successfully unpacked and MD5 sums checked
package ‘spatstat.random’ successfully unpacked and MD5 sums checked
package ‘spatstat.sparse’ successfully unpacked and MD5 sums checked
package ‘spatstat.univar’ successfully unpacked and MD5 sums checked
package ‘spatstat.utils’ successfully unpacked and MD5 sums checked
package ‘SQUAREM’ successfully unpacked and MD5 sums checked
package ‘statmod’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘statmod’
Warning: restored ‘statmod’
package ‘stringr’ successfully unpacked and MD5 sums checked
package ‘survminer’ successfully unpacked and MD5 sums checked
package ‘sys’ successfully unpacked and MD5 sums checked
package ‘systemfonts’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘systemfonts’
Warning: restored ‘systemfonts’
package ‘testthat’ successfully unpacked and MD5 sums checked
package ‘textshaping’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘textshaping’
Warning: restored ‘textshaping’
package ‘TH.data’ successfully unpacked and MD5 sums checked
package ‘tidydr’ successfully unpacked and MD5 sums checked
package ‘tidyselect’ successfully unpacked and MD5 sums checked
package ‘tidytree’ successfully unpacked and MD5 sums checked
package ‘tidyverse’ successfully unpacked and MD5 sums checked
package ‘timechange’ successfully unpacked and MD5 sums checked
package ‘timereg’ successfully unpacked and MD5 sums checked
package ‘timeROC’ successfully unpacked and MD5 sums checked
package ‘tinytex’ successfully unpacked and MD5 sums checked
package ‘TMB’ successfully unpacked and MD5 sums checked
package ‘tweenr’ successfully unpacked and MD5 sums checked
package ‘tzdb’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘tzdb’
Warning: restored ‘tzdb’
package ‘umap’ successfully unpacked and MD5 sums checked
package ‘unmarked’ successfully unpacked and MD5 sums checked
package ‘urca’ successfully unpacked and MD5 sums checked
package ‘usethis’ successfully unpacked and MD5 sums checked
package ‘utf8’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘utf8’
Warning: restored ‘utf8’
package ‘uwot’ successfully unpacked and MD5 sums checked
package ‘vctrs’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘vctrs’
Warning: restored ‘vctrs’
package ‘VGAM’ successfully unpacked and MD5 sums checked
package ‘vipor’ successfully unpacked and MD5 sums checked
package ‘viridis’ successfully unpacked and MD5 sums checked
package ‘viridisLite’ successfully unpacked and MD5 sums checked
package ‘vroom’ successfully unpacked and MD5 sums checked
package ‘waldo’ successfully unpacked and MD5 sums checked
package ‘whisker’ successfully unpacked and MD5 sums checked
package ‘withr’ successfully unpacked and MD5 sums checked
package ‘xml2’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘xml2’
Warning: restored ‘xml2’
package ‘xtable’ successfully unpacked and MD5 sums checked
package ‘yaml’ successfully unpacked and MD5 sums checked
package ‘yulab.utils’ successfully unpacked and MD5 sums checked
package ‘zip’ successfully unpacked and MD5 sums checked
package ‘zoo’ successfully unpacked and MD5 sums checked
The downloaded binary packages are in
	C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0\downloaded_packages
There were 32 warnings (use warnings() to see them)

> human_projects <- available_projects()
Error in available_projects() : 
  could not find function "available_projects"

> library(recount3)
Loading required package: SummarizedExperiment
Loading required package: MatrixGenerics
Loading required package: matrixStats

Attaching package: ‘matrixStats’

The following objects are masked from ‘package:Biobase’:

    anyMissing, rowMedians


Attaching package: ‘MatrixGenerics’

The following objects are masked from ‘package:matrixStats’:

    colAlls, colAnyNAs, colAnys, colAvgsPerRowSet,
    colCollapse, colCounts, colCummaxs, colCummins,
    colCumprods, colCumsums, colDiffs, colIQRDiffs,
    colIQRs, colLogSumExps, colMadDiffs, colMads,
    colMaxs, colMeans2, colMedians, colMins,
    colOrderStats, colProds, colQuantiles, colRanges,
    colRanks, colSdDiffs, colSds, colSums2,
    colTabulates, colVarDiffs, colVars,
    colWeightedMads, colWeightedMeans,
    colWeightedMedians, colWeightedSds,
    colWeightedVars, rowAlls, rowAnyNAs, rowAnys,
    rowAvgsPerColSet, rowCollapse, rowCounts,
    rowCummaxs, rowCummins, rowCumprods, rowCumsums,
    rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
    rowMadDiffs, rowMads, rowMaxs, rowMeans2,
    rowMedians, rowMins, rowOrderStats, rowProds,
    rowQuantiles, rowRanges, rowRanks, rowSdDiffs,
    rowSds, rowSums2, rowTabulates, rowVarDiffs,
    rowVars, rowWeightedMads, rowWeightedMeans,
    rowWeightedMedians, rowWeightedSds,
    rowWeightedVars

The following object is masked from ‘package:Biobase’:

    rowMedians

Loading required package: GenomicRanges
Warning message:
package ‘matrixStats’ was built under R version 4.6.1 
> 
> # 1. Fetch the human projects list directly from the recount3 server
> human_projects <- recount3::available_projects()
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): # 2. Subset for our target study
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): proj_info <- subset(human_projects, project == "SRP162608")
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): # 3. Create the RSE object
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): rse_gene <- recount3::create_rse(proj_info)
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): # 4. Convert base-pair coverage to actual read counts
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): assay(rse_gene, "counts") <- recount3::compute_read_counts(rse_gene)
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): # 5. Check the object
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): dim(rse_gene)
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): colData(rse_gene)$sra.sample_attribute[1:5]
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): 
C:\Users\nikit\AppData\Local/R/cache/R/recount3
  does not exist, create directory? (yes/no): no
using temporary cache C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0/BiocFileCache
2026-07-13 17:51:37.017648 caching file sra.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/sra/metadata/sra.recount_project.MD.gz'
                                                      
2026-07-13 17:51:47.842456 caching file gtex.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/gtex/metadata/gtex.recount_project.MD.gz'

2026-07-13 17:51:50.857415 caching file tcga.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/tcga/metadata/tcga.recount_project.MD.gz'

> # 1. Manually create the cache directory
> dir.create("C:/Users/nikit/AppData/Local/R/cache/R/recount3", recursive = TRUE, showWarnings = FALSE)
> 
> # 2. Set the option for recount3 to use this directory
> options(recount3_cache = "C:/Users/nikit/AppData/Local/R/cache/R/recount3")
> 
> # 3. Proceed with the fetch
> library(recount3)
> human_projects <- recount3::available_projects()
2026-07-13 17:51:54.788271 caching file sra.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/sra/metadata/sra.recount_project.MD.gz'

2026-07-13 17:51:58.281979 caching file gtex.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/gtex/metadata/gtex.recount_project.MD.gz'

2026-07-13 17:52:00.717191 caching file tcga.recount_project.MD.gz.
adding rname 'http://duffel.rail.bio/recount3/human/data_sources/tcga/metadata/tcga.recount_project.MD.gz'

> proj_info <- subset(human_projects, project == "SRP162608")
> 
> # 4. Create the RSE object
> rse_gene <- recount3::create_rse(proj_info)
Error in recount3::create_rse(proj_info) : 
  'project_info' should only have one row

> # Check what is inside proj_info
> print(proj_info)
[1] project      organism     file_source  project_home
[5] project_type n_samples   
<0 rows> (or 0-length row.names)
> library(recount3)
> 
> # 1. Fetch the full list of human projects again with no filters
> all_human <- available_projects(organism = "human")
2026-07-13 17:52:56.380273 caching file sra.recount_project.MD.gz.
2026-07-13 17:52:57.190577 caching file gtex.recount_project.MD.gz.
2026-07-13 17:52:57.95435 caching file tcga.recount_project.MD.gz.
> 
> # 2. Search for our study ID within the project column
> match_idx <- grep("SRP162608", all_human$project)
> 
> if(length(match_idx) > 0) {
+     proj_info <- all_human[match_idx, ]
+     print("Project Found:")
+     print(proj_info)
+ } else {
+     print("Project SRP162608 not found in the human project list.")
+     # Check the first few rows to see what the project IDs look like
+     print(head(all_human$project))
+ }
[1] "Project SRP162608 not found in the human project list."
[1] "SRP107565" "SRP149665" "SRP017465" "SRP119165"
[5] "SRP133965" "SRP096765"
> # Search the entire recount3 human project list for any mention of the study title
> all_human <- recount3::available_projects(organism = "human")
2026-07-13 17:53:42.83755 caching file sra.recount_project.MD.gz.
2026-07-13 17:53:43.571726 caching file gtex.recount_project.MD.gz.
2026-07-13 17:53:44.346143 caching file tcga.recount_project.MD.gz.
> # Search for 'lens' since the study is about lens epithelial cells
> match_idx <- grep("lens", all_human$project_home, ignore.case = TRUE)
> print(all_human[match_idx, ])
[1] project      organism     file_source  project_home
[5] project_type n_samples   
<0 rows> (or 0-length row.names)
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> library(GEOquery)
> 
> # 1. Download the study metadata
> gse <- getGEO("GSE120805", GSEMatrix = TRUE)
Found 1 file(s)
GSE120805_series_matrix.txt.gz
> metadata <- pData(gse[[1]])
> 
> # 2. Check for supplementary files directly from GEO
> # This will list the URLs of files associated with this study
> getGEOSuppFiles("GSE120805")
Using locally cached version of supplementary file(s) GSE120805 found here:
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 
                                                                         size
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 3107005
                                                                      isdir
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz FALSE
                                                                      mode
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  666
                                                                                    mtime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-12 16:06:24
                                                                                    ctime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-12 16:06:19
                                                                                    atime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-12 16:07:01
                                                                      exe
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  no
                                                                      uname
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz nikit
                                                                      udomain
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  GAURAV
                                                                                                   fname
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz GSE120805_2016HLECountTable.txt.gz
                                                                                                 destdir
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz C:/Users/nikit/Documents/GSE120805
                                                                                                                                   filepath
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz
                                                                            GEO
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz GSE120805
> 
> # 3. List the files we just downloaded to see if any are count tables
> list.files("GSE120805")
[1] "GSE120805_2016HLECountTable.txt.gz"
> # 1. Load the count data
> counts_raw <- read.table("GSE120805/GSE120805_2016HLECountTable.txt.gz", 
+                          header = TRUE, row.names = 1, check.names = FALSE)
> 
> # 2. Inspect the data structure
> dim(counts_raw)
[1] 60766    70
> print(counts_raw[1:5, 1:5])
                s1_ s10 s11 s12 s13
ENSG00000227232   0   0   0   0   4
ENSG00000278267   1   0   3   1   2
ENSG00000243485   0   0   0   0   0
ENSG00000274890   0   0   0   0   0
ENSG00000237613   0   0   0   0   0
> 
> # 3. Check for non-integer values (RNA-seq counts should be integers)
> all(apply(counts_raw, 2, function(x) all(x == floor(x))))
[1] TRUE
> # 1. Retrieve the metadata from GEO
> gse <- getGEO("GSE120805", GSEMatrix = TRUE)
Found 1 file(s)
GSE120805_series_matrix.txt.gz
Using locally cached version: C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0/GSE120805_series_matrix.txt.gz
Using locally cached version of GPL18573 found here:
C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0/GPL18573.soft.gz 
> metadata <- pData(gse[[1]])
> 
> # 2. Extract relevant columns (we need the sample title and the radiation dose)
> # Looking for 'characteristics_ch1' which usually contains the dose information
> sample_map <- metadata[, c("title", "characteristics_ch1")]
> print(head(sample_map))
             title     characteristics_ch1
GSM3416076  HCrep1         stress: control
GSM3416077  HCrep2         stress: control
GSM3416078  HCrep3         stress: control
GSM3416079  HCrep4         stress: control
GSM3416080  HCrep5         stress: control
GSM3416081 HD1rep1 stress: X-ray radiation
> 
> # 3. Create a clean sample information table
> # We will match the sample names in counts_raw to the rows in metadata
> sample_info <- data.frame(
+     sample_id = colnames(counts_raw),
+     dose = NA # We will fill this in next
+ )
> # 1. Look at all columns in the metadata to find the specific dose info
> colnames(metadata)
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
[14] "treatment_protocol_ch1" 
[15] "growth_protocol_ch1"    
[16] "molecule_ch1"           
[17] "extract_protocol_ch1"   
[18] "extract_protocol_ch1.1" 
[19] "taxid_ch1"              
[20] "description"            
[21] "data_processing"        
[22] "data_processing.1"      
[23] "data_processing.2"      
[24] "data_processing.3"      
[25] "data_processing.4"      
[26] "platform_id"            
[27] "contact_name"           
[28] "contact_email"          
[29] "contact_phone"          
[30] "contact_laboratory"     
[31] "contact_department"     
[32] "contact_institute"      
[33] "contact_address"        
[34] "contact_city"           
[35] "contact_state"          
[36] "contact_zip/postal_code"
[37] "contact_country"        
[38] "data_row_count"         
[39] "instrument_model"       
[40] "library_selection"      
[41] "library_source"         
[42] "library_strategy"       
[43] "relation"               
[44] "relation.1"             
[45] "supplementary_file_1"   
[46] "cell type:ch1"          
[47] "dose rate:ch1"          
[48] "dose:ch1"               
[49] "stress:ch1"             
> 
> # 2. Check the 'title' and 'description' or 'supplementary_file' columns
> # Often, the specific dose is in the title or an extended characteristics field
> head(metadata[, c("title", "source_name_ch1", "description")])
             title source_name_ch1
GSM3416076  HCrep1 lens epithelial
GSM3416077  HCrep2 lens epithelial
GSM3416078  HCrep3 lens epithelial
GSM3416079  HCrep4 lens epithelial
GSM3416080  HCrep5 lens epithelial
GSM3416081 HD1rep1 lens epithelial
           description
GSM3416076         s57
GSM3416077         s64
GSM3416078         s71
GSM3416079         s78
GSM3416080         s85
GSM3416081         s51
> # 1. Extract the dose column
> # We need to make sure the row order of 'metadata' matches 'colnames(counts_raw)'
> # GEOmetadata is usually ordered by GSM accession, which matches the columns in many supplementary files.
> doses <- metadata[["dose:ch1"]]
> 
> # 2. Check the unique values to verify we have all 7 doses
> unique(doses)
[1] "control" "0.01 Gy" "0.05 Gy" "0.25 Gy"
[5] "0.5 Gy"  "2 Gy"    "5 Gy"   
> 
> # 3. Create a design dataframe for DESeq2
> # We map each sample to its specific dose
> sample_data <- data.frame(
+     sample_id = colnames(counts_raw),
+     dose = as.numeric(gsub(" Gy", "", doses)) # Clean the string "0.01 Gy" to 0.01
+ )
Warning message:
In data.frame(sample_id = colnames(counts_raw), dose = as.numeric(gsub(" Gy",  :
  NAs introduced by coercion
> 
> # 4. Final verification: Count how many samples per dose
> table(sample_data$dose)

0.01 0.05 0.25  0.5    2    5 
  10   10   10   10   10   10 
> # 1. Fix the NAs (Control = 0 Gy)
> sample_data$dose[is.na(sample_data$dose)] <- 0
> 
> # 2. Final Verification
> table(sample_data$dose)

   0 0.01 0.05 0.25  0.5    2    5 
  10   10   10   10   10   10   10 
> 
> # 3. Create the DESeq2 object
> library(DESeq2)
> 
> # Ensure the column order of counts matches the row order of sample_data
> # This is a critical safety step
> counts_raw <- counts_raw[, sample_data$sample_id]
> 
> dds <- DESeqDataSetFromMatrix(
+     countData = counts_raw,
+     colData = sample_data,
+     design = ~ splines::ns(log2(dose + 0.005), df = 3)
+ )
> 
> # 4. Preliminary QC: Remove genes with very low counts across samples
> # This speeds up the GLM significantly and reduces noise
> keep <- rowSums(counts(dds)) >= 10
> dds <- dds[keep, ]
> 
> # 5. Run the Genome-Wide Screen
> # We use parallel processing if available
> dds <- DESeq(dds, test = "LRT", reduced = ~ 1)
estimating size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
-- replacing outliers and refitting for 3 genes
-- DESeq argument 'minReplicatesForReplace' = 7 
-- original counts are preserved in counts(dds)
estimating dispersions
fitting model and testing
> res <- results(dds)
> summary(res)

out of 31120 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 119, 0.38%
LFC < 0 (down)     : 87, 0.28%
outliers [1]       : 0, 0%
low counts [2]     : 11464, 37%
(mean count < 2)
[1] see 'cooksCutoff' argument of ?results
[2] see 'independentFiltering' argument of ?results

> # 1. Apply Variance Stabilizing Transformation (VST)
> vsd <- vst(dds, blind = FALSE)
> vst_counts <- assay(vsd)
> 
> # 2. Extract the significant genes
> sig_genes <- rownames(res[which(res$padj < 0.1), ])
> 
> # 3. Create a subset of normalized data for these genes
> # This matrix will be the input for the 4PL regression loop
> target_matrix <- vst_counts[sig_genes, ]
> # 1. Install and load drc
> if (!requireNamespace("drc", quietly = TRUE)) install.packages("drc")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/nikit/AppData/Local/R/win-library/4.6’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.6/drc_3.0-1.zip'
Content type 'application/zip' length 937585 bytes (915 KB)
downloaded 915 KB

package ‘drc’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\nikit\AppData\Local\Temp\Rtmp8igTH0\downloaded_packages
> library(drc)
Loading required package: MASS

'drc' has been loaded.

Please cite R and 'drc' if used for a publication,
for references type 'citation()' and 'citation('drc')'.


Attaching package: ‘drc’

The following objects are masked from ‘package:stats’:

    gaussian, getInitial

Warning message:
package ‘drc’ was built under R version 4.6.1 
> 
> # 2. Prepare storage for parameters
> param_results <- data.frame(matrix(NA, nrow=length(sig_genes), ncol=4))
> colnames(param_results) <- c("a", "b", "c", "d")
> rownames(param_results) <- sig_genes
> 
> # 3. Fit 4PL for each gene
> # We use a loop to iterate through the 206 significant genes
> for (gene in sig_genes) {
+     y <- target_matrix[gene, ]
+     x <- sample_data$dose
+     
+     # Fit the 4-parameter logistic model (LL.4)
+     # 'LL.4' is the standard log-logistic model with 4 parameters
+     try({
+         model <- drm(y ~ x, fct = LL.4())
+         param_results[gene, ] <- coef(model)
+     }, silent = TRUE)
+ }
> 
> # 4. Filter out any genes that failed to converge (NAs)
> final_fits <- param_results[complete.cases(param_results), ]
> 
> # Preview the results
> head(final_fits)
                        a        b        c         d
ENSG00000223764 -1.392971 8.271070 8.863567 0.8339738
ENSG00000187961 -1.308391 8.791487 9.224239 0.8475804
ENSG00000049249  4.025565 7.818500 8.230363 2.1353384
ENSG00000236269 -2.713954 5.412840 5.831231 0.9786731
ENSG00000228549 -1.816117 4.250929 4.583848 0.4680395
ENSG00000204362  4.422859 5.935216 5.637870 0.7905381
> # 1. Re-fit using the standard Logistic model (L.4) which works perfectly on linear doses
> refined_results <- data.frame(matrix(NA, nrow=length(sig_genes), ncol=4))
> colnames(refined_results) <- c("b_slope", "lower_asymp", "upper_asymp", "EC50")
> rownames(refined_results) <- sig_genes
> 
> for (gene in sig_genes) {
+     y <- target_matrix[gene, ]
+     x <- sample_data$dose
+     
+     try({
+         # L.4() parameters are: b (slope), c (lower), d (upper), e (EC50)
+         model <- drm(y ~ x, fct = L.4())
+         refined_results[gene, ] <- coef(model)
+     }, silent = TRUE)
+ }
> 
> # Clean out any non-converged rows
> final_fits_corrected <- refined_results[complete.cases(refined_results), ]
> 
> # 2. Preview the corrected metrics
> print("Corrected Parameter Preview:")
[1] "Corrected Parameter Preview:"
> print(head(final_fits_corrected))
                   b_slope
ENSG00000223764 -0.8482125
ENSG00000187961 -1.2334230
ENSG00000049249  4.0928825
ENSG00000236269 -1.1026837
ENSG00000228549 -1.9174673
ENSG00000204362 -3.4118947
                lower_asymp
ENSG00000223764    6.981554
ENSG00000187961    8.197479
ENSG00000049249    7.832429
ENSG00000236269    5.011717
ENSG00000228549    3.143488
ENSG00000204362    5.632542
                upper_asymp
ENSG00000223764    8.854318
ENSG00000187961    9.181840
ENSG00000049249    8.230675
ENSG00000236269    5.842707
ENSG00000228549    4.572655
ENSG00000204362    5.939835
                      EC50
ENSG00000223764 -0.9571600
ENSG00000187961 -0.3421465
ENSG00000049249  2.0426007
ENSG00000236269  0.1473036
ENSG00000228549 -0.6237179
ENSG00000204362  1.1424098
> 
> # 3. Plot the top gene to visually confirm the fit
> top_gene <- rownames(final_fits_corrected)[1]
> 
> plot(sample_data$dose, target_matrix[top_gene, ], 
+      main = paste("Dose Response Curve for", top_gene),
+      xlab = "Radiation Dose (Gy)", ylab = "Normalized Expression (VST)",
+      pch = 19, col = "darkblue")
> 
> # Overlay the fitted model line
> model_to_plot <- drm(target_matrix[top_gene, ] ~ sample_data$dose, fct = L.4())
> plot(model_to_plot, add = TRUE, col = "red", lwd = 2)
> # 1. Extract the dose rate
> dose_rates <- metadata[["dose rate:ch1"]]
> unique(dose_rates)
[1] "high" "low" 
> 
> # 2. Add to your existing sample_data
> sample_data$dose_rate <- dose_rates
> 
> # 3. Check distribution
> table(sample_data$dose_rate, sample_data$dose)
      
       0 0.01 0.05 0.25 0.5 2
  high 5    5    5    5   5 5
  low  5    5    5    5   5 5
      
       5
  high 5
  low  5
> # 1. Update the design with the interaction term
> # The '*' operator includes the main effects (dose_rate + dose_spline) AND the interaction
> design(dds) <- ~ dose_rate * splines::ns(log2(dose + 0.005), df = 3)
Error in validObject(object) : 
  invalid class “DESeqDataSet” object: all variables in design formula must be columns in colData

> # 1. Pre-compute the spline basis (df = 3)
> # We use the same log-scale formula as before
> spline_basis <- splines::ns(log2(sample_data$dose + 0.005), df = 3)
> 
> # 2. Add these to the colData (dds columns)
> # We name them 's1', 's2', 's3'
> colData(dds)$s1 <- spline_basis[, 1]
> colData(dds)$s1 <- spline_basis[, 2] # Correcting index names
> colData(dds)$s2 <- spline_basis[, 2]
> colData(dds)$s3 <- spline_basis[, 3]
> 
> # 3. Update the design to include the interaction
> # We test for interactions between dose_rate and all three spline terms
> design(dds) <- ~ dose_rate + s1 + s2 + s3 + 
+     dose_rate:s1 + dose_rate:s2 + dose_rate:s3
Error in validObject(object) : 
  invalid class “DESeqDataSet” object: all variables in design formula must be columns in colData

> # 1. Re-compute spline basis
> spline_basis <- splines::ns(log2(sample_data$dose + 0.005), df = 3)
> 
> # 2. Add as separate columns to colData(dds)
> colData(dds)$s1 <- spline_basis[, 1]
> colData(dds)$s2 <- spline_basis[, 2]
> colData(dds)$s3 <- spline_basis[, 3]
> 
> # 3. Update the design explicitly
> # R understands this notation, and because s1, s2, and s3 are now 
> # part of colData(dds), this will pass the validity check.
> design(dds) <- ~ dose_rate * (s1 + s2 + s3)
Error in validObject(object) : 
  invalid class “DESeqDataSet” object: all variables in design formula must be columns in colData

> # 1. Create a fresh sample_data dataframe that includes the spline columns
> new_colData <- colData(dds)
> new_colData$s1 <- spline_basis[, 1]
> new_colData$s2 <- spline_basis[, 2]
> new_colData$s3 <- spline_basis[, 3]
> 
> # 2. Create a clean, new DESeqDataSet object
> dds_new <- DESeqDataSetFromMatrix(
+     countData = counts(dds),
+     colData = new_colData,
+     design = ~ dose_rate * (s1 + s2 + s3)
+ )
Error in DESeqDataSet(se, design = design, ignoreRank) : 
  all variables in design formula must be columns in colData

> # 1. Extract the colData as a list/data.frame to be safe
Warning messages:
1: In doTryCatch(return(expr), name, parentenv, handler) :
  display list redraw incomplete
2: In doTryCatch(return(expr), name, parentenv, handler) :
  invalid graphics state
3: In doTryCatch(return(expr), name, parentenv, handler) :
  invalid graphics state
4: In doTryCatch(return(expr), name, parentenv, handler) :
  display list redraw incomplete
5: In doTryCatch(return(expr), name, parentenv, handler) :
  invalid graphics state
6: In doTryCatch(return(expr), name, parentenv, handler) :
  invalid graphics state
> # Re-binding columns ensures they are registered correctly
> temp_data <- as.data.frame(colData(dds))
> temp_data$s1 <- spline_basis[, 1]
> temp_data$s2 <- spline_basis[, 2]
> temp_data$s3 <- spline_basis[, 3]
> 
> # 2. Re-create the DESeqDataSet using the explicit data.frame
> # We use the original count data
> dds_new <- DESeqDataSetFromMatrix(
+     countData = counts(dds),
+     colData = temp_data,
+     design = ~ dose_rate * (s1 + s2 + s3)
+ )
Error in DESeqDataSet(se, design = design, ignoreRank) : 
  all variables in design formula must be columns in colData

> # 1. Start with a completely clean data frame
> # Ensure only the necessary columns exist to avoid metadata conflicts
> clean_meta <- data.frame(
+     sample_id = sample_data$sample_id,
+     dose_rate = factor(sample_data$dose_rate),
+     s1 = spline_basis[, 1],
+     s2 = spline_basis[, 2],
+     s3 = spline_basis[, 3]
+ )
> 
> # 2. Convert to the S4 DataFrame class explicitly
> library(S4Vectors)
> final_colData <- DataFrame(clean_meta)
> rownames(final_colData) <- final_meta$sample_id # Ensure row names match count columns
Error: object 'final_meta' not found

> # 1. Start with a completely clean data frame
> clean_meta <- data.frame(
+     sample_id = sample_data$sample_id,
+     dose_rate = factor(sample_data$dose_rate),
+     s1 = spline_basis[, 1],
+     s2 = spline_basis[, 2],
+     s3 = spline_basis[, 3]
+ )
> 
> # 2. Convert to the S4 DataFrame class explicitly
> library(S4Vectors)
> final_colData <- DataFrame(clean_meta)
> 
> # Fix: Use 'clean_meta' (or 'sample_data') to set the rownames
> rownames(final_colData) <- clean_meta$sample_id 
> 
> # 3. Create the object
> dds_interaction <- DESeqDataSetFromMatrix(
+     countData = counts_raw,
+     colData = final_colData,
+     design = ~ dose_rate * (s1 + s2 + s3)
+ )
> 
> # 4. Run the model
> dds_interaction <- DESeq(dds_interaction, test = "LRT", 
+                          reduced = ~ dose_rate + s1 + s2 + s3)
estimating size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
> 
> res_interaction <- results(dds_interaction)
> summary(res_interaction)

out of 42697 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 334, 0.78%
LFC < 0 (down)     : 359, 0.84%
outliers [1]       : 0, 0%
low counts [2]     : 25090, 59%
(mean count < 4)
[1] see 'cooksCutoff' argument of ?results
[2] see 'independentFiltering' argument of ?results

> # Get the gene IDs for the interaction-significant genes
> rate_sensitive_genes <- rownames(res_interaction[which(res_interaction$padj < 0.1), ])
> 
> # Optional: Save to a file for later use
> write.csv(rate_sensitive_genes, "rate_sensitive_gene_list.csv")
> # Example: Plot top gene
> top_rate_gene <- rate_sensitive_genes[1]
> plotCounts(dds_interaction, gene = top_rate_gene, intgroup = c("dose", "dose_rate"))
Error in plotCounts(dds_interaction, gene = top_rate_gene, intgroup = c("dose",  : 
  all variables in 'intgroup' must be columns of colData

> # 1. Check what columns exist in your dds_interaction
> colnames(colData(dds_interaction))
[1] "sample_id"  "dose_rate"  "s1"         "s2"        
[5] "s3"         "sizeFactor"
> 
> # 2. If 'dose' is missing, add it back from your original sample_data
> colData(dds_interaction)$dose <- sample_data$dose
> 
> # 3. Now try plotting again
> plotCounts(dds_interaction, gene = top_rate_gene, intgroup = c("dose", "dose_rate"))
Error in plotCounts(dds_interaction, gene = top_rate_gene, intgroup = c("dose",  : 
  all variables in 'intgroup' should be factors, or choose returnData=TRUE and plot manually

> # 1. Convert dose to a factor so plotCounts accepts it
> colData(dds_interaction)$dose <- factor(colData(dds_interaction)$dose)
> 
> # 2. Now plot using the returnData = TRUE method
> # This is more robust and lets us use ggplot
> plot_data <- plotCounts(dds_interaction, gene = top_rate_gene, 
+                         intgroup = c("dose", "dose_rate"), returnData = TRUE)
> 
> # 3. Create a nice visual using ggplot2
> library(ggplot2)
> ggplot(plot_data, aes(x = dose, y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.1)) +
+     geom_smooth(method = "loess", se = FALSE) +
+     theme_minimal() +
+     labs(title = paste("Rate-Dependent Response for", top_rate_gene),
+          y = "Normalized Expression", x = "Dose (Gy)")
Error in .Call.graphics(C_palette2, .Call(C_palette2, NULL)) : 
  invalid graphics state

> # 1. Close all open graphics devices
> dev.off() 
null device 
          1 
> # (If it says "null device", that's fine; it just means it's already closed)
> 
> # 2. Re-run the ggplot code
> library(ggplot2)
> ggplot(plot_data, aes(x = dose, y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.1)) +
+     geom_smooth(method = "loess", se = FALSE) +
+     theme_minimal() +
+     labs(title = paste("Rate-Dependent Response for", top_rate_gene),
+          y = "Normalized Expression", x = "Dose (Gy)")
`geom_smooth()` using formula = 'y
~ x'
> # 1. Apply consistent filtering (the same filter as your primary model)
> keep <- rowSums(counts(dds_interaction)) >= 10
> dds_filtered <- dds_interaction[keep, ]
> 
> # 2. Re-run DESeq with the filtered object
> dds_final <- DESeq(dds_filtered, test = "LRT", 
+                    reduced = ~ dose_rate + s1 + s2 + s3)
using pre-existing size factors
estimating dispersions
found already estimated dispersions, replacing these
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
> 
> # 3. Get results and check summary
> res_final <- results(dds_final)
> summary(res_final)

out of 31120 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 335, 1.1%
LFC < 0 (down)     : 360, 1.2%
outliers [1]       : 0, 0%
low counts [2]     : 13274, 43%
(mean count < 4)
[1] see 'cooksCutoff' argument of ?results
[2] see 'independentFiltering' argument of ?results

> # 1. Filter and sort by padj
> sig_res <- res_final[which(res_final$padj < 0.1), ]
> sig_res_sorted <- sig_res[order(sig_res$padj), ]
> 
> # 2. Get the truly top gene
> top_gene_id <- rownames(sig_res_sorted)[1]
> summary(top_gene_id)
   Length  N.unique   N.blank 
        1         1         0 
Min.nchar Max.nchar 
       15        15 
> # 1. Get plot data for the truly top gene
> # We keep dose as numeric for the x-axis
> plot_data <- plotCounts(dds_final, gene = top_gene_id, 
+                         intgroup = c("dose", "dose_rate"), returnData = TRUE)
> 
> # 2. Plot with log-scaled dose on the x-axis
> library(ggplot2)
> ggplot(plot_data, aes(x = log2(dose + 0.005), y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.05)) +
+     geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs"), se = FALSE) +
+     theme_minimal() +
+     labs(title = paste("True Top Rate-Sensitive Gene:", top_gene_id),
+          subtitle = "X-axis is log2(dose + 0.005) for geometric accuracy",
+          y = "Normalized Expression", x = "log2(Dose + 0.005)")
Warning messages:
1: In Ops.factor(dose, 0.005) : ‘+’ not meaningful for factors
2: In Ops.factor(dose, 0.005) : ‘+’ not meaningful for factors
3: Removed 70 rows containing
non-finite outside the scale
range (`stat_smooth()`). 
4: In min(x) : no non-missing arguments to min; returning Inf
5: In max(x) : no non-missing arguments to max; returning -Inf
6: Removed 70 rows containing
missing values or values
outside the scale range
(`geom_point()`). 

> # 1. Get plot data for the truly top gene
> # We keep dose as numeric for the x-axis
> plot_data <- plotCounts(dds_final, gene = top_gene_id, 
+                         intgroup = c("dose", "dose_rate"), returnData = TRUE)
> 
> # 2. Plot with log-scaled dose on the x-axis
> library(ggplot2)
> ggplot(plot_data, aes(x = log2(dose + 0.005), y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.05)) +
+     geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs"), se = FALSE) +
+     theme_minimal() +
+     labs(title = paste("True Top Rate-Sensitive Gene:", top_gene_id),
+          subtitle = "X-axis is log2(dose + 0.005) for geometric accuracy",
+          y = "Normalized Expression", x = "log2(Dose + 0.005)")
Warning messages:
1: In Ops.factor(dose, 0.005) : ‘+’ not meaningful for factors
2: In Ops.factor(dose, 0.005) : ‘+’ not meaningful for factors
3: Removed 70 rows containing
non-finite outside the scale
range (`stat_smooth()`). 
4: In min(x) : no non-missing arguments to min; returning Inf
5: In max(x) : no non-missing arguments to max; returning -Inf
6: Removed 70 rows containing
missing values or values
outside the scale range
(`geom_point()`). 

> # 1. Manually check the range of the x-axis values
> plot_data$log_dose <- log2(plot_data$dose + 0.005)
Warning message:
In Ops.factor(plot_data$dose, 0.005) : ‘+’ not meaningful for factors
> range(plot_data$log_dose)
[1] NA NA
> 
> # 2. Re-plot with explicit x-axis limits and a simpler trend line
> library(ggplot2)
> ggplot(plot_data, aes(x = log_dose, y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.05)) +
+     geom_smooth(method = "loess", span = 1, se = FALSE) + # Loess is more stable for small datasets
+     theme_minimal() +
+     scale_x_continuous(limits = c(-8, 3)) + # Force the axis to cover the transformed range
+     labs(title = paste("Top Rate-Sensitive Gene:", top_gene_id),
+          y = "Normalized Expression", x = "log2(Dose + 0.005)")
`geom_smooth()` using formula
= 'y ~ x'
Warning messages:
1: Removed 70 rows containing
non-finite outside the scale
range (`stat_smooth()`). 
2: In min(x) : no non-missing arguments to min; returning Inf
3: In max(x) : no non-missing arguments to max; returning -Inf
4: Removed 70 rows containing
missing values or values
outside the scale range
(`geom_point()`). 

> # 1. Manually check the range of the x-axis values
> plot_data$log_dose <- log2(plot_data$dose + 0.005)
Warning message:
In Ops.factor(plot_data$dose, 0.005) : ‘+’ not meaningful for factors
> range(plot_data$log_dose)
[1] NA NA
> 
> # 2. Re-plot with explicit x-axis limits and a simpler trend line
> library(ggplot2)
> ggplot(plot_data, aes(x = log_dose, y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(position = position_jitter(width = 0.05)) +
+     geom_smooth(method = "loess", span = 1, se = FALSE) + # Loess is more stable for small datasets
+     theme_minimal() +
+     scale_x_continuous(limits = c(-8, 3)) + # Force the axis to cover the transformed range
+     labs(title = paste("Top Rate-Sensitive Gene:", top_gene_id),
+          y = "Normalized Expression", x = "log2(Dose + 0.005)")
`geom_smooth()` using formula
= 'y ~ x'
Warning messages:
1: Removed 70 rows containing
non-finite outside the scale
range (`stat_smooth()`). 
2: In min(x) : no non-missing arguments to min; returning Inf
3: In max(x) : no non-missing arguments to max; returning -Inf
4: Removed 70 rows containing
missing values or values
outside the scale range
(`geom_point()`). 

> # 1. Manually pull the counts and join with the metadata
> # 'top_gene_id' must be defined from your previous steps
> count_vals <- counts(dds_final, normalized = TRUE)[top_gene_id, ]
> plot_df <- as.data.frame(colData(dds_final))
> plot_df$count <- count_vals
> plot_df$log_dose <- log2(as.numeric(as.character(plot_df$dose)) + 0.005)
> 
> # 2. Plot directly using the constructed data.frame
> library(ggplot2)
> ggplot(plot_df, aes(x = log_dose, y = count, color = dose_rate, group = dose_rate)) +
+     geom_point(size = 3) +
+     geom_smooth(method = "loess", se = TRUE, span = 0.8) +
+     theme_minimal() +
+     labs(title = paste("Top Rate-Sensitive Gene:", top_gene_id),
+          y = "Normalized Expression", 
+          x = "log2(Dose + 0.005)")
`geom_smooth()` using formula
= 'y ~ x'
> # 1. Create mapping table
> # Assuming you have org.Hs.eg.db installed
> library(org.Hs.eg.db)
Loading required package: AnnotationDbi

Attaching package: ‘AnnotationDbi’

The following object is masked from ‘package:MASS’:

    select
> canonical_symbols <- c("CDKN1A", "GADD45A", "FDXR", "MDM2", "BAX", "DDB2")
> 
> # Get mapping
> mapping <- mapIds(org.Hs.eg.db, keys = canonical_symbols, 
+                   column = "ENSEMBL", keytype = "SYMBOL", multiVals = "first")
'select()' returned 1:1 mapping between
keys and columns
> 
> # Display the table for confirmation
> mapping_table <- data.frame(Symbol = names(mapping), ENSG = mapping)
> print(mapping_table)
         Symbol            ENSG
CDKN1A   CDKN1A ENSG00000124762
GADD45A GADD45A ENSG00000116717
FDXR       FDXR ENSG00000161513
MDM2       MDM2 ENSG00000135679
BAX         BAX ENSG00000087088
DDB2       DDB2 ENSG00000134574
> # Extraction and plotting function
> plot_canonical <- function(ensg_id, symbol) {
+     # Extract raw counts from dds_final
+     vals <- counts(dds_final, normalized = TRUE)[ensg_id, ]
+     
+     # Prepare plotting df using data from the final model object
+     plot_df <- data.frame(
+         count = vals,
+         dose = as.numeric(as.character(colData(dds_final)$dose)),
+         dose_rate = colData(dds_final)$dose_rate
+     )
+     
+     # Plot
+     library(ggplot2)
+     p <- ggplot(plot_df, aes(x = dose, y = count, color = dose_rate)) +
+         geom_point(position = position_jitter(width = 0.05)) +
+         geom_smooth(method = "loess", se = FALSE, span = 1) +
+         theme_minimal() +
+         labs(title = paste("Canonical Response:", symbol), 
+              subtitle = paste("ENSG:", ensg_id),
+              y = "Normalized Expression", x = "Dose (Gy)")
+     print(p)
+ }
> 
> # Run for all genes in mapping_table
> for (i in 1:nrow(mapping_table)) {
+     plot_canonical(mapping_table$ENSG[i], mapping_table$Symbol[i])
+ }
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
> # 1. Get primary results (controlling for dose_rate)
> res_primary <- results(dds_final, contrast=c("dose", "5", "0")) # Comparing 5Gy vs 0Gy
Error in cleanContrast(object, contrast, expanded = isExpanded, listValues = listValues,  : 
  as 0 is the reference level, was expecting dose_5_vs_0 to be present in 'resultsNames(object)'

> # 1. Create a simplified DESeq object for primary dose effect
> # Use the same 'dds_filtered' subset to keep the gene universe identical
> dds_primary <- dds_filtered
> 
> # 2. Define a formula that includes only dose (as a factor) and rate
> # We treat dose as a factor to capture the global dose response
> design(dds_primary) <- ~ dose_rate + dose
> 
> # 3. Run the analysis (using the standard Wald test for simplicity)
> dds_primary <- DESeq(dds_primary)
using pre-existing size factors
estimating dispersions
found already estimated dispersions, replacing these
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
> 
> # 4. Get the primary dose-responsive genes (e.g., 5Gy vs 0Gy)
> res_primary <- results(dds_primary, contrast=c("dose", "5", "0"))
> 
> # 5. Extract the significant genes (padj < 0.1)
> discovery_genes <- rownames(res_primary[which(res_primary$padj < 0.1), ])
> 
> # 6. Save the list
> write.csv(discovery_genes, "final_discovery_cohort_genes_strict.csv")
> # Check how many genes passed the p-adjusted < 0.1 threshold
> length(discovery_genes)
[1] 785
> 
> # Verify the file exists in your current working directory
> file.exists("final_discovery_cohort_genes_strict.csv")
[1] TRUE
> dput(gse120805_genes)
Error: object 'gse120805_genes' not found

> ls()
  [1] "ae_data"             
  [2] "all_genes"           
  [3] "all_genes_named"     
  [4] "all_human"           
  [5] "annotation_col"      
  [6] "bax_ann"             
  [7] "canon_genes"         
  [8] "canonical_symbols"   
  [9] "clean_meta"          
 [10] "contrast_matrix"     
 [11] "cor_matrix"          
 [12] "count_vals"          
 [13] "counts_raw"          
 [14] "curated_probes"      
 [15] "dds"                 
 [16] "dds_filtered"        
 [17] "dds_final"           
 [18] "dds_interaction"     
 [19] "dds_primary"         
 [20] "design_matrix"       
 [21] "df_after"            
 [22] "df_before"           
 [23] "discovery_genes"     
 [24] "dose_rates"          
 [25] "doses"               
 [26] "exprs_before"        
 [27] "fc_threshold"        
 [28] "feature_info"        
 [29] "final_colData"       
 [30] "final_deliverable"   
 [31] "final_fits"          
 [32] "final_fits_corrected"
 [33] "fit"                 
 [34] "fit2"                
 [35] "gene"                
 [36] "geo_data"            
 [37] "get_pattern"         
 [38] "gse"                 
 [39] "heatmap_matrix"      
 [40] "human_projects"      
 [41] "i"                   
 [42] "is_sig"              
 [43] "keep"                
 [44] "label_data"          
 [45] "long_data"           
 [46] "mapping"             
 [47] "mapping_table"       
 [48] "match_idx"           
 [49] "mean_targets"        
 [50] "mean_targets_clean"  
 [51] "melt_targets"        
 [52] "melt_targets_clean"  
 [53] "melted_exprs"        
 [54] "metadata"            
 [55] "model"               
 [56] "model_to_plot"       
 [57] "new_colData"         
 [58] "p_hist"              
 [59] "p_summary"           
 [60] "p1"                  
 [61] "p2"                  
 [62] "p4"                  
 [63] "p4_a"                
 [64] "p4_b"                
 [65] "p5"                  
 [66] "p5_fixed"            
 [67] "p5_stat"             
 [68] "p6"                  
 [69] "p6_clean"            
 [70] "p6_final"            
 [71] "p6_final_fixed"      
 [72] "param_results"       
 [73] "passing_fc"          
 [74] "pca_data"            
 [75] "pca_res"             
 [76] "pca_results"         
 [77] "plot_canonical"      
 [78] "plot_data"           
 [79] "plot_df"             
 [80] "plot_long"           
 [81] "probe_colors"        
 [82] "probe_to_gene"       
 [83] "proj_info"           
 [84] "rate_sensitive_genes"
 [85] "raw_p"               
 [86] "refined_results"     
 [87] "res"                 
 [88] "res_final"           
 [89] "res_interaction"     
 [90] "res_primary"         
 [91] "result"              
 [92] "sample_data"         
 [93] "sample_info"         
 [94] "sample_map"          
 [95] "sanity_check"        
 [96] "sanity_summary"      
 [97] "sig_genes"           
 [98] "sig_genes_strict"    
 [99] "sig_res"             
[100] "sig_res_sorted"      
[101] "spline_basis"        
[102] "target_genes"        
[103] "target_matrix"       
[104] "target_probes"       
[105] "target_rows"         
[106] "target_rows_clean"   
[107] "targets"             
[108] "temp_data"           
[109] "time_factor"         
[110] "top_50_probes"       
[111] "top_gene"            
[112] "top_gene_id"         
[113] "top_rate_gene"       
[114] "verified_adj_p"      
[115] "volc_data"           
[116] "volc_long"           
[117] "vsd"                 
[118] "vst_counts"          
[119] "x"                   
[120] "y"                   
> # 1. Check the structure of geo_data to see if it holds gene lists
> str(geo_data)
List of 1
 $ GSE21748_series_matrix.txt.gz:Formal class 'ExpressionSet' [package "Biobase"] with 7 slots
  .. ..@ experimentData   :Formal class 'MIAME' [package "Biobase"] with 13 slots
  .. .. .. ..@ name             : chr "Cheol-Koo,,Lee"
  .. .. .. ..@ lab              : chr ""
  .. .. .. ..@ contact          : chr "cklee2005@korea.ac.kr"
  .. .. .. ..@ title            : chr "Time-dependent expressed markers and their characterization for premature senescence induced by ionizing radiation in MCF7"
  .. .. .. ..@ abstract         : chr "Recently, senescence has been suggested as a defense mechanism to block sporadic induction of cancer cells. Rad"| __truncated__
  .. .. .. ..@ url              : chr "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21748"
  .. .. .. ..@ pubMedIds        : chr "20596626"
  .. .. .. ..@ samples          : list()
  .. .. .. ..@ hybridizations   : list()
  .. .. .. ..@ normControls     : list()
  .. .. .. ..@ preprocessing    : list()
  .. .. .. ..@ other            :List of 25
  .. .. .. .. ..$ contact_address        : chr "Korea University, Biotechnology #318 West building, Anam-dong, Seongbuk-gu"
  .. .. .. .. ..$ contact_city           : chr "Seoul"
  .. .. .. .. ..$ contact_country        : chr "South Korea"
  .. .. .. .. ..$ contact_department     : chr "Biotechnology"
  .. .. .. .. ..$ contact_email          : chr "cklee2005@korea.ac.kr"
  .. .. .. .. ..$ contact_institute      : chr "Korea University"
  .. .. .. .. ..$ contact_laboratory     : chr "Functional Genomics"
  .. .. .. .. ..$ contact_name           : chr "Cheol-Koo,,Lee"
  .. .. .. .. ..$ contact_phone          : chr "82-2-3290-3008"
  .. .. .. .. ..$ contact_zip/postal_code: chr "136-701"
  .. .. .. .. ..$ contributor            : chr "Cheol-Koo,,Lee"
  .. .. .. .. ..$ geo_accession          : chr "GSE21748"
  .. .. .. .. ..$ last_update_date       : chr "Jan 18 2013"
  .. .. .. .. ..$ overall_design         : chr "Gene expression profiles were obtained from human MCF7 cells after ionizing radiation (6 Gy) at day 0 (no ioniz"| __truncated__
  .. .. .. .. ..$ platform_id            : chr "GPL6104"
  .. .. .. .. ..$ platform_taxid         : chr "9606"
  .. .. .. .. ..$ pubmed_id              : chr "20596626"
  .. .. .. .. ..$ sample_id              : chr "GSM544268 GSM544269 GSM544270 GSM544271 GSM544272 GSM544273 GSM544274 GSM544275 GSM544276 GSM544277 GSM544278 G"| __truncated__
  .. .. .. .. ..$ sample_taxid           : chr "9606"
  .. .. .. .. ..$ status                 : chr "Public on May 31 2010"
  .. .. .. .. ..$ submission_date        : chr "May 07 2010"
  .. .. .. .. ..$ summary                : chr "Recently, senescence has been suggested as a defense mechanism to block sporadic induction of cancer cells. Rad"| __truncated__
  .. .. .. .. ..$ supplementary_file     : chr "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE21nnn/GSE21748/suppl/GSE21748_RAW.tar\nftp://ftp.ncbi.nlm.nih.gov/geo/"| __truncated__
  .. .. .. .. ..$ title                  : chr "Time-dependent expressed markers and their characterization for premature senescence induced by ionizing radiation in MCF7"
  .. .. .. .. ..$ type                   : chr "Expression profiling by array"
  .. .. .. ..@ .__classVersion__:Formal class 'Versions' [package "Biobase"] with 1 slot
  .. .. .. .. .. ..@ .Data:List of 2
  .. .. .. .. .. .. ..$ : int [1:3] 1 0 0
  .. .. .. .. .. .. ..$ : int [1:3] 1 1 0
  .. .. .. .. .. ..$ names: chr [1:2] "MIAxE" "MIAME"
  .. ..@ assayData        :<environment: 0x000001fdc0562578> 
  .. ..@ phenoData        :Formal class 'AnnotatedDataFrame' [package "Biobase"] with 4 slots
  .. .. .. ..@ varMetadata      :'data.frame':	42 obs. of  1 variable:
  .. .. .. .. ..$ labelDescription: chr [1:42] NA NA NA NA ...
  .. .. .. ..@ data             :'data.frame':	20 obs. of  42 variables:
  .. .. .. .. ..$ title                  : chr [1:20] "Day0_1" "Day1_1" "Day2_1" "Day3_1" ...
  .. .. .. .. ..$ geo_accession          : chr [1:20] "GSM544268" "GSM544269" "GSM544270" "GSM544271" ...
  .. .. .. .. ..$ status                 : chr [1:20] "Public on May 31 2010" "Public on May 31 2010" "Public on May 31 2010" "Public on May 31 2010" ...
  .. .. .. .. ..$ submission_date        : chr [1:20] "May 18 2010" "May 18 2010" "May 18 2010" "May 18 2010" ...
  .. .. .. .. ..$ last_update_date       : chr [1:20] "May 24 2010" "May 24 2010" "May 24 2010" "May 24 2010" ...
  .. .. .. .. ..$ type                   : chr [1:20] "RNA" "RNA" "RNA" "RNA" ...
  .. .. .. .. ..$ channel_count          : chr [1:20] "1" "1" "1" "1" ...
  .. .. .. .. ..$ source_name_ch1        : chr [1:20] "MCF7.1" "MCF7.1.D1" "MCF7.1.D2" "MCF7.1.D3" ...
  .. .. .. .. ..$ organism_ch1           : chr [1:20] "Homo sapiens" "Homo sapiens" "Homo sapiens" "Homo sapiens" ...
  .. .. .. .. ..$ characteristics_ch1    : chr [1:20] "cell line: MCF7" "cell line: MCF7" "cell line: MCF7" "cell line: MCF7" ...
  .. .. .. .. ..$ characteristics_ch1.1  : chr [1:20] "cell type: human breast cancer cells" "cell type: human breast cancer cells" "cell type: human breast cancer cells" "cell type: human breast cancer cells" ...
  .. .. .. .. ..$ characteristics_ch1.2  : chr [1:20] "treatment: None" "treatment: IR 6 Gy" "treatment: IR 6 Gy" "treatment: IR 6 Gy" ...
  .. .. .. .. ..$ characteristics_ch1.3  : chr [1:20] "time: 0 days" "time: 1 days" "time: 2 days" "time: 3 days" ...
  .. .. .. .. ..$ treatment_protocol_ch1 : chr [1:20] "For irradiation, cells were exposed to gamma-ray with a 137Cs gamma ray source (Atomic Energy of Canada, Missis"| __truncated__ "For irradiation, cells were exposed to gamma-ray with a 137Cs gamma ray source (Atomic Energy of Canada, Missis"| __truncated__ "For irradiation, cells were exposed to gamma-ray with a 137Cs gamma ray source (Atomic Energy of Canada, Missis"| __truncated__ "For irradiation, cells were exposed to gamma-ray with a 137Cs gamma ray source (Atomic Energy of Canada, Missis"| __truncated__ ...
  .. .. .. .. ..$ growth_protocol_ch1    : chr [1:20] "Human breast cancer MCF7 cells were purchased from the American Type Culture Collection and cultured in DMEM (M"| __truncated__ "Human breast cancer MCF7 cells were purchased from the American Type Culture Collection and cultured in DMEM (M"| __truncated__ "Human breast cancer MCF7 cells were purchased from the American Type Culture Collection and cultured in DMEM (M"| __truncated__ "Human breast cancer MCF7 cells were purchased from the American Type Culture Collection and cultured in DMEM (M"| __truncated__ ...
  .. .. .. .. ..$ molecule_ch1           : chr [1:20] "total RNA" "total RNA" "total RNA" "total RNA" ...
  .. .. .. .. ..$ extract_protocol_ch1   : chr [1:20] "Total RNA from MCF7 cells was isolated using the Trizol reagent (Invitrogen, CA) according to the manufacturer’s instruction." "Total RNA from MCF7 cells was isolated using the Trizol reagent (Invitrogen, CA) according to the manufacturer’s instruction." "Total RNA from MCF7 cells was isolated using the Trizol reagent (Invitrogen, CA) according to the manufacturer’s instruction." "Total RNA from MCF7 cells was isolated using the Trizol reagent (Invitrogen, CA) according to the manufacturer’s instruction." ...
  .. .. .. .. ..$ label_ch1              : chr [1:20] "Biotin" "Biotin" "Biotin" "Biotin" ...
  .. .. .. .. ..$ label_protocol_ch1     : chr [1:20] "Biotin-labelled cRNA samples for hybridization were prepared according to Illumina’s recommended sample labelin"| __truncated__ "Biotin-labelled cRNA samples for hybridization were prepared according to Illumina’s recommended sample labelin"| __truncated__ "Biotin-labelled cRNA samples for hybridization were prepared according to Illumina’s recommended sample labelin"| __truncated__ "Biotin-labelled cRNA samples for hybridization were prepared according to Illumina’s recommended sample labelin"| __truncated__ ...
  .. .. .. .. ..$ taxid_ch1              : chr [1:20] "9606" "9606" "9606" "9606" ...
  .. .. .. .. ..$ hyb_protocol           : chr [1:20] "Labeled, amplified cRNA (1.5 ug per array) was hybridized to a ver. 2 of the Illumina HumanRef-8 BeadChip accor"| __truncated__ "Labeled, amplified cRNA (1.5 ug per array) was hybridized to a ver. 2 of the Illumina HumanRef-8 BeadChip accor"| __truncated__ "Labeled, amplified cRNA (1.5 ug per array) was hybridized to a ver. 2 of the Illumina HumanRef-8 BeadChip accor"| __truncated__ "Labeled, amplified cRNA (1.5 ug per array) was hybridized to a ver. 2 of the Illumina HumanRef-8 BeadChip accor"| __truncated__ ...
  .. .. .. .. ..$ scan_protocol          : chr [1:20] "Array signals were developed by Amersham fluorolink streptavidin-Cy3 (GE Healthcare Bio-Sciences, Little Chalfo"| __truncated__ "Array signals were developed by Amersham fluorolink streptavidin-Cy3 (GE Healthcare Bio-Sciences, Little Chalfo"| __truncated__ "Array signals were developed by Amersham fluorolink streptavidin-Cy3 (GE Healthcare Bio-Sciences, Little Chalfo"| __truncated__ "Array signals were developed by Amersham fluorolink streptavidin-Cy3 (GE Healthcare Bio-Sciences, Little Chalfo"| __truncated__ ...
  .. .. .. .. ..$ description            : chr [1:20] "Gene expression profile using Illumina HumanRef-8 V2 array." "Gene expression profile using Illumina HumanRef-8 V2 array." "Gene expression profile using Illumina HumanRef-8 V2 array." "Gene expression profile using Illumina HumanRef-8 V2 array." ...
  .. .. .. .. ..$ description.1          : chr [1:20] "1690411282_A" "1690411282_B" "1690411282_C" "1690411282_D" ...
  .. .. .. .. ..$ data_processing        : chr [1:20] "Array data processing and analysis was performed using Illumina BeadStudio software 3.1.3.0. Non-normalized dat"| __truncated__ "Array data processing and analysis was performed using Illumina BeadStudio software 3.1.3.0. Non-normalized dat"| __truncated__ "Array data processing and analysis was performed using Illumina BeadStudio software 3.1.3.0. Non-normalized dat"| __truncated__ "Array data processing and analysis was performed using Illumina BeadStudio software 3.1.3.0. Non-normalized dat"| __truncated__ ...
  .. .. .. .. ..$ platform_id            : chr [1:20] "GPL6104" "GPL6104" "GPL6104" "GPL6104" ...
  .. .. .. .. ..$ contact_name           : chr [1:20] "Cheol-Koo,,Lee" "Cheol-Koo,,Lee" "Cheol-Koo,,Lee" "Cheol-Koo,,Lee" ...
  .. .. .. .. ..$ contact_email          : chr [1:20] "cklee2005@korea.ac.kr" "cklee2005@korea.ac.kr" "cklee2005@korea.ac.kr" "cklee2005@korea.ac.kr" ...
  .. .. .. .. ..$ contact_phone          : chr [1:20] "82-2-3290-3008" "82-2-3290-3008" "82-2-3290-3008" "82-2-3290-3008" ...
  .. .. .. .. ..$ contact_laboratory     : chr [1:20] "Functional Genomics" "Functional Genomics" "Functional Genomics" "Functional Genomics" ...
  .. .. .. .. ..$ contact_department     : chr [1:20] "Biotechnology" "Biotechnology" "Biotechnology" "Biotechnology" ...
  .. .. .. .. ..$ contact_institute      : chr [1:20] "Korea University" "Korea University" "Korea University" "Korea University" ...
  .. .. .. .. ..$ contact_address        : chr [1:20] "Korea University, Biotechnology #318 West building, Anam-dong, Seongbuk-gu" "Korea University, Biotechnology #318 West building, Anam-dong, Seongbuk-gu" "Korea University, Biotechnology #318 West building, Anam-dong, Seongbuk-gu" "Korea University, Biotechnology #318 West building, Anam-dong, Seongbuk-gu" ...
  .. .. .. .. ..$ contact_city           : chr [1:20] "Seoul" "Seoul" "Seoul" "Seoul" ...
  .. .. .. .. ..$ contact_zip/postal_code: chr [1:20] "136-701" "136-701" "136-701" "136-701" ...
  .. .. .. .. ..$ contact_country        : chr [1:20] "South Korea" "South Korea" "South Korea" "South Korea" ...
  .. .. .. .. ..$ supplementary_file     : chr [1:20] "NONE" "NONE" "NONE" "NONE" ...
  .. .. .. .. ..$ data_row_count         : chr [1:20] "22184" "22184" "22184" "22184" ...
  .. .. .. .. ..$ cell line:ch1          : chr [1:20] "MCF7" "MCF7" "MCF7" "MCF7" ...
  .. .. .. .. ..$ cell type:ch1          : chr [1:20] "human breast cancer cells" "human breast cancer cells" "human breast cancer cells" "human breast cancer cells" ...
  .. .. .. .. ..$ time:ch1               : chr [1:20] "0 days" "1 days" "2 days" "3 days" ...
  .. .. .. .. ..$ treatment:ch1          : chr [1:20] "None" "IR 6 Gy" "IR 6 Gy" "IR 6 Gy" ...
  .. .. .. ..@ dimLabels        : chr [1:2] "sampleNames" "sampleColumns"
  .. .. .. ..@ .__classVersion__:Formal class 'Versions' [package "Biobase"] with 1 slot
  .. .. .. .. .. ..@ .Data:List of 1
  .. .. .. .. .. .. ..$ : int [1:3] 1 1 0
  .. .. .. .. .. ..$ names: chr "AnnotatedDataFrame"
  .. ..@ featureData      :Formal class 'AnnotatedDataFrame' [package "Biobase"] with 4 slots
  .. .. .. ..@ varMetadata      :'data.frame':	26 obs. of  3 variables:
  .. .. .. .. ..$ Column          : chr [1:26] "ID" "" "Source" "Search_Key" ...
  .. .. .. .. ..$ Description     : chr [1:26] "Unique identifier for the probe (across all products and species)" "Species =" "Transcript sequence source name" "Internal id useful for custom design array" ...
  .. .. .. .. ..$ labelDescription: chr [1:26] NA NA NA NA ...
  .. .. .. ..@ data             :'data.frame':	22184 obs. of  26 variables:
  .. .. .. .. ..$ ID                   : chr [1:22184] "ILMN_1343291" "ILMN_1343292" "ILMN_1343293" "ILMN_1343294" ...
  .. .. .. .. ..$ Species              : chr [1:22184] "Homo sapiens" "Homo sapiens" "Homo sapiens" "Homo sapiens" ...
  .. .. .. .. ..$ Source               : chr [1:22184] "RefSeq" "ILMN_Controls" "ILMN_Controls" "RefSeq" ...
  .. .. .. .. ..$ Search_Key           : chr [1:22184] "" "" "" "" ...
  .. .. .. .. ..$ Transcript           : chr [1:22184] "ILMN_137991" "ILMN_160455" "ILMN_160456" "ILMN_2565" ...
  .. .. .. .. ..$ ILMN_Gene            : chr [1:22184] "EEF1A1" "TUBB" "TXN" "ACTB" ...
  .. .. .. .. ..$ Source_Reference_ID  : chr [1:22184] "NM_001402.4" "NM_001069.1" "NM_003329.1" "NM_001101.2" ...
  .. .. .. .. ..$ RefSeq_ID            : chr [1:22184] "NM_001402.4" "NM_001069.1" "NM_003329.1" "NM_001101.2" ...
  .. .. .. .. ..$ Entrez_Gene_ID       : int [1:22184] 1915 NA NA 60 9906 80380 6234 9670 255928 60312 ...
  .. .. .. .. ..$ GI                   : int [1:22184] 25453469 4507728 4507744 5016088 33469136 31543389 71565158 41281424 23397557 125661040 ...
  .. .. .. .. ..$ Accession            : chr [1:22184] "NM_001402.4" "NM_001069.1" "NM_003329.1" "NM_001101.2" ...
  .. .. .. .. ..$ Symbol               : chr [1:22184] "EEF1A1" "TUBB" "TXN" "ACTB" ...
  .. .. .. .. ..$ Protein_Product      : chr [1:22184] "NP_001393.1" "" "" "NP_001092.1" ...
  .. .. .. .. ..$ Array_Address_Id     : int [1:22184] 2690379 4590356 4260048 5860528 3310274 5080022 7510672 2360064 2100735 1740450 ...
  .. .. .. .. ..$ Probe_Type           : chr [1:22184] "S" "S" "S" "S" ...
  .. .. .. .. ..$ Probe_Start          : int [1:22184] 1293 1408 72 1725 1103 1247 329 3437 2356 160 ...
  .. .. .. .. ..$ SEQUENCE             : chr [1:22184] "TGTGTTGAGAGCTTCTCAGACTATCCACCTTTGGGTCGCTTTGCTGTTCG" "CTCAGATCAATCGTGCATCCTTAGTGAACTTCTGTTGTCCTCAAGCATGG" "GCAGATCGAGAGCAAGACTGCTTTTCAGGAAGCCTTGGACGCTGCAGGTG" "GTGGGTGGAGGCAGCCAGGGCTTACCTGTACACTGACTTGAGACCAGTTG" ...
  .. .. .. .. ..$ Chromosome           : chr [1:22184] "6" "" "" "7" ...
  .. .. .. .. ..$ Probe_Chr_Orientation: chr [1:22184] "-" "" "" "-" ...
  .. .. .. .. ..$ Probe_Coordinates    : chr [1:22184] "74284362-74284378:74284474-74284506" "" "" "5533331-5533380" ...
  .. .. .. .. ..$ Definition           : chr [1:22184] "Homo sapiens eukaryotic translation elongation factor 1 alpha 1 (EEF1A1), mRNA." "Homo sapiens tubulin, beta polypeptide (TUBB), mRNA." "Homo sapiens thioredoxin (TXN), mRNA." "Homo sapiens actin, beta (ACTB), mRNA." ...
  .. .. .. .. ..$ Ontology_Component   : chr [1:22184] "cytoplasm [goid 5737] [evidence NAS]" "" "" "cytoskeleton [goid 5856] [evidence IEA]; actin filament [goid 5884] [evidence IEA]; TIP60 histone acetyltransfe"| __truncated__ ...
  .. .. .. .. ..$ Ontology_Process     : chr [1:22184] "translational elongation [goid 6414] [pmid 3570288] [evidence NAS]; protein biosynthesis [goid 6412] [evidence IEA]" "" "" "" ...
  .. .. .. .. ..$ Ontology_Function    : chr [1:22184] "translation elongation factor activity [goid 3746] [pmid 3570288] [evidence NAS]; GTP binding [goid 5525] [evid"| __truncated__ "" "" "ATP binding [goid 5524] [evidence IEA]; nucleotide binding [goid 166] [evidence IEA]; protein binding [goid 551"| __truncated__ ...
  .. .. .. .. ..$ Synonyms             : chr [1:22184] "PTI1; eEF1A-1; EEF1A; MGC16224; EF-Tu; EEF-1; HNGC:16303; GRAF-1EF; LENG7; EF1A" "" "" "PS1TP5BP1" ...
  .. .. .. .. ..$ GB_ACC               : chr [1:22184] "NM_001402.4" "NM_001069.1" "NM_003329.1" "NM_001101.2" ...
  .. .. .. ..@ dimLabels        : chr [1:2] "featureNames" "featureColumns"
  .. .. .. ..@ .__classVersion__:Formal class 'Versions' [package "Biobase"] with 1 slot
  .. .. .. .. .. ..@ .Data:List of 1
  .. .. .. .. .. .. ..$ : int [1:3] 1 1 0
  .. .. .. .. .. ..$ names: chr "AnnotatedDataFrame"
  .. ..@ annotation       : chr "GPL6104"
  .. ..@ protocolData     :Formal class 'AnnotatedDataFrame' [package "Biobase"] with 4 slots
  .. .. .. ..@ varMetadata      :'data.frame':	0 obs. of  1 variable:
  .. .. .. .. ..$ labelDescription: chr(0) 
  .. .. .. ..@ data             :'data.frame':	20 obs. of  0 variables
  .. .. .. ..@ dimLabels        : chr [1:2] "sampleNames" "sampleColumns"
  .. .. .. ..@ .__classVersion__:Formal class 'Versions' [package "Biobase"] with 1 slot
  .. .. .. .. .. ..@ .Data:List of 1
  .. .. .. .. .. .. ..$ : int [1:3] 1 1 0
  .. .. .. .. .. ..$ names: chr "AnnotatedDataFrame"
  .. ..@ .__classVersion__:Formal class 'Versions' [package "Biobase"] with 1 slot
  .. .. .. ..@ .Data:List of 4
  .. .. .. .. ..$ : int [1:3] 4 6 0
  .. .. .. .. ..$ : int [1:3] 2 72 0
  .. .. .. .. ..$ : int [1:3] 1 3 0
  .. .. .. .. ..$ : int [1:3] 1 0 0
  .. .. .. ..$ names: chr [1:4] "R" "Biobase" "eSet" "ExpressionSet"
> 
> # 2. If it is a data frame or list, check the first few rows/elements
> head(geo_data)
$GSE21748_series_matrix.txt.gz
ExpressionSet (storageMode: lockedEnvironment)
assayData: 22184 features, 20 samples 
  element names: exprs 
protocolData: none
phenoData
  sampleNames: GSM544268
    GSM544269 ...
    GSM544287 (20 total)
  varLabels: title
    geo_accession ...
    treatment:ch1 (42
    total)
  varMetadata:
    labelDescription
featureData
  featureNames:
    ILMN_1343291
    ILMN_1343292 ...
    ILMN_2038778 (22184
    total)
  fvarLabels: ID Species
    ... GB_ACC (26 total)
  fvarMetadata: Column
    Description
    labelDescription
experimentData: use 'experimentData(object)'
  pubMedIds: 20596626 
Annotation: GPL6104 

> 

> # 3. Check if 'gse' (item 38) might actually be the object containing the gene information
> head(gse)
$GSE120805_series_matrix.txt.gz
ExpressionSet (storageMode: lockedEnvironment)
assayData: 0 features, 70 samples 
  element names: exprs 
protocolData: none
phenoData
  sampleNames: GSM3416076
    GSM3416077 ...
    GSM3416145 (70 total)
  varLabels: title
    geo_accession ...
    stress:ch1 (49 total)
  varMetadata:
    labelDescription
featureData: none
experimentData: use 'experimentData(object)'
  pubMedIds: 30395761 
Annotation: GPL18573 

> # 1. Access the validation expression data
> gse_val <- gse$GSE120805_series_matrix.txt.gz
> exprs_val <- exprs(gse_val)
> pdata_val <- pData(gse_val)
> 
> # 2. Define groups based on treatment (assuming a dose-responsive column exists)
> # Check columns to identify dose/treatment: colnames(pdata_val)
> # Assuming 'treatment:ch1' or similar column distinguishes dose groups
> # Adjust 'dose_group' based on your actual column name
> val_dose <- as.numeric(as.factor(pdata_val$`treatment:ch1`)) 
> 
> # 3. Simple differential expression for validation cohort
> # We use limma for array data
> library(limma)
> design_val <- model.matrix(~ val_dose)
> fit_val <- lmFit(exprs_val, design_val)
Error in getEAWP(object) : 
  Data object doesn't contain numeric expression values

> # 1. Clean the expression matrix
> # Coerce to numeric matrix, suppressing warnings for non-convertible characters
> exprs_val_numeric <- apply(exprs(gse_val), 2, as.numeric)
> rownames(exprs_val_numeric) <- rownames(exprs(gse_val))
> 
> # 2. Check for NAs introduced by coercion
> if(any(is.na(exprs_val_numeric))) {
+   message("Warning: Some values were coerced to NA. Proceeding with complete cases.")
+   exprs_val_numeric <- na.omit(exprs_val_numeric)
+ }
> 
> # 3. Re-run the limma analysis
> fit_val <- lmFit(exprs_val_numeric, design_val)
Coefficients not estimable: (Intercept) val_dose 
Error in lm.fit(design, t(M)) : 0 (non-NA) cases

> # 1. Inspect the raw data object
> val_exprs <- exprs(gse$GSE120805_series_matrix.txt.gz)
> 
> # 2. Check the first few values
> head(val_exprs)
     GSM3416076 GSM3416077
     GSM3416078 GSM3416079
     GSM3416080 GSM3416081
     GSM3416082 GSM3416083
     GSM3416084 GSM3416085
     GSM3416086 GSM3416087
     GSM3416088 GSM3416089
     GSM3416090 GSM3416091
     GSM3416092 GSM3416093
     GSM3416094 GSM3416095
     GSM3416096 GSM3416097
     GSM3416098 GSM3416099
     GSM3416100 GSM3416101
     GSM3416102 GSM3416103
     GSM3416104 GSM3416105
     GSM3416106 GSM3416107
     GSM3416108 GSM3416109
     GSM3416110 GSM3416111
     GSM3416112 GSM3416113
     GSM3416114 GSM3416115
     GSM3416116 GSM3416117
     GSM3416118 GSM3416119
     GSM3416120 GSM3416121
     GSM3416122 GSM3416123
     GSM3416124 GSM3416125
     GSM3416126 GSM3416127
     GSM3416128 GSM3416129
     GSM3416130 GSM3416131
     GSM3416132 GSM3416133
     GSM3416134 GSM3416135
     GSM3416136 GSM3416137
     GSM3416138 GSM3416139
     GSM3416140 GSM3416141
     GSM3416142 GSM3416143
     GSM3416144 GSM3416145
> 
> # 3. Check the class of the data
> class(val_exprs[1,1])
Error in val_exprs[1, 1] : subscript out of bounds

> library(clusterProfiler)

clusterProfiler v4.20.0 Learn more at https://yulab-smu.top/contribution-knowledge-mining/

Please cite:

G Yu. Thirteen years of
clusterProfiler. The
Innovation. 2024,
5(6):100722

Attaching package: ‘clusterProfiler’

The following object is masked from ‘package:AnnotationDbi’:

    select

The following object is masked from ‘package:MASS’:

    select

The following object is masked from ‘package:XVector’:

    slice

The following object is masked from ‘package:IRanges’:

    slice

The following object is masked from ‘package:S4Vectors’:

    rename

The following object is masked from ‘package:stats’:

    filter
> library(org.Hs.eg.db)
> 
> # 1. Prepare Gene Lists
> # 'discovery_genes' are your 785 primary dose-responsive genes
> # 'rate_sensitive_genes' are your 695 interaction-significant genes
> 
> # 2. Enrichment Function
> run_enrichment <- function(gene_list, title) {
+     res <- enrichGO(gene = gene_list,
+                     OrgDb = org.Hs.eg.db,
+                     keyType = "ENSEMBL",
+                     ont = "BP",
+                     pAdjustMethod = "BH",
+                     qvalueCutoff = 0.05)
+     
+     # Return plot
+     return(dotplot(res, title = title))
+ }
> 
> # 3. Execute
> p_dose <- run_enrichment(discovery_genes, "Process: Dose-Responsive")
'select()' returned 1:many
mapping between keys and
columns
Warning message:
In bitr(gene, fromType = fromType, toType = "ENTREZID", OrgDb = OrgDb) :
  10.06% of input gene IDs are fail to map...
> p_rate <- run_enrichment(rate_sensitive_genes, "Process: Dose-Rate-Sensitive")
'select()' returned 1:many
mapping between keys and
columns
Warning message:
In bitr(gene, fromType = fromType, toType = "ENTREZID", OrgDb = OrgDb) :
  8.95% of input gene IDs are fail to map...
> 
> print(p_dose)
> print(p_rate)
> # Extract effect size vs. log-dose
> # We filter for genes with high dose-rate interaction scores
> res_interaction_df <- as.data.frame(res_interaction)
> sig_rate_genes <- res_interaction_df[which(res_interaction_df$padj < 0.05), ]
> 
> # Plot effect size (Log2FoldChange) vs Dose
> library(ggplot2)
> ggplot(sig_rate_genes, aes(x = log1p(dose), y = log2FoldChange)) +
+     geom_point(alpha = 0.3) +
+     geom_smooth(method = "gam") +
+     theme_minimal() +
+     labs(title = "Threshold Analysis: Effect Size vs. Log-Dose",
+          x = "Log-transformed Dose (Gy)", y = "Log2 Fold Change")
Error in `geom_point()`:
! Problem while computing
  aesthetics.
ℹ Error occurred in the 1st
  layer.
Caused by error:
! object 'dose' not found
Run `rlang::last_trace()` to see where the error occurred.

> # 1. Create a data frame that includes both the interaction results and dose info
> # We use the interaction design matrix to pull the dose values
> plot_data_threshold <- data.frame(
+     log2FoldChange = res_interaction$log2FoldChange,
+     dose = colData(dds_final)$dose[match(rownames(res_interaction), rownames(dds_final))] # This is a placeholder; let's use the colData directly
+ )
> 
> # Correction: Since interaction results are per-gene, let's plot the average effect 
> # of the interaction term across the doses present in the experiment
> plot_data_threshold <- data.frame(
+     log2FoldChange = res_interaction$log2FoldChange,
+     padj = res_interaction$padj
+ )
> plot_data_threshold <- plot_data_threshold[!is.na(plot_data_threshold$padj), ]
> 
> # 2. Use the significant genes identified
> sig_genes_plot <- plot_data_threshold[plot_data_threshold$padj < 0.05, ]
> 
> # 3. Plot
> library(ggplot2)
> ggplot(sig_genes_plot, aes(x = 1:nrow(sig_genes_plot), y = log2FoldChange)) +
+     geom_point(alpha = 0.3, color = "steelblue") +
+     geom_smooth(method = "loess", color = "darkred") +
+     theme_minimal() +
+     labs(title = "Threshold Analysis: Distribution of Interaction Effects",
+          x = "Significant Gene Rank", 
+          y = "Log2 Fold Change (Interaction Term)")
`geom_smooth()` using formula =
'y ~ x'
> 
> 
> 
> #external validation (personal)
> 
> 
> # 1. Download the supplementary data (usually a counts matrix)
> # Note: You may need to change the 'destfile' name based on what's available
> getGEOSuppFiles("GSE120805")
Using locally cached version of supplementary file(s) GSE120805 found here:
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 
                                                                         size
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 3107005
                                                                      isdir
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz FALSE
                                                                      mode
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  666
                                                                                    mtime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-12 16:06:24
                                                                                    ctime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-12 16:06:19
                                                                                    atime
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz 2026-07-13 17:55:13
                                                                      exe
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  no
                                                                      uname
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz nikit
                                                                      udomain
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz  GAURAV
                                                                                                   fname
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz GSE120805_2016HLECountTable.txt.gz
                                                                                                 destdir
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz C:/Users/nikit/Documents/GSE120805
                                                                                                                                   filepath
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz
                                                                            GEO
C:/Users/nikit/Documents/GSE120805/GSE120805_2016HLECountTable.txt.gz GSE120805
> 
> # 2. Unpack and load the counts
> # This will likely be a .txt or .csv file in the folder "GSE120805"
> # Replace 'filename.txt' with the actual file found in the directory
> val_counts <- read.table("GSE120805/GSE120805_counts.txt", header=TRUE, row.names=1)
Error in file(file, "rt") : cannot open the connection
In addition: 
Warning message:
In file(file, "rt") :
  cannot open file 'GSE120805/GSE120805_counts.txt': No such file or directory

> # List files in the download directory to see the exact name
> list.files("GSE120805")
[1] "GSE120805_2016HLECountTable.txt.gz"
> # 1. Load the count data
> val_counts <- read.table(gzfile("GSE120805/GSE120805_2016HLECountTable.txt.gz"), 
+                          header=TRUE, row.names=1, sep="\t")
> 
> # 2. Identify the validation gene list (e.g., top 1000 most variable genes 
> # or genes with highest variance across conditions as a proxy for 'responsive' genes)
> # Since we don't have the full metadata, we use a variance-based filter 
> # to select the most relevant genes for the validation overlap
> rv <- rowVars(as.matrix(val_counts))
> gse_validation_genes <- rownames(val_counts)[order(rv, decreasing=TRUE)[1:2000]]
> 
> # 3. Perform the Fisher's Exact Test
> discovery_set <- discovery_genes # Your 785 genes
> all_tested_genes <- rownames(val_counts)
> overlap <- intersect(discovery_set, gse_validation_genes)
> 
> contingency_table <- matrix(c(
+     length(overlap), 
+     length(discovery_set) - length(overlap),
+     length(gse_validation_genes) - length(overlap),
+     length(all_tested_genes) - (length(discovery_set) + length(gse_validation_genes) - length(overlap))
+ ), nrow=2)
> 
> fisher_res <- fisher.test(contingency_table, alternative="greater")
> print(fisher_res)

	Fisher's Exact Test for Count
	Data

data:  contingency_table
p-value < 2.2e-16
alternative hypothesis: true odds ratio is greater than 1
95 percent confidence interval:
 4.940742      Inf
sample estimates:
odds ratio 
  5.867945 

> print(paste("Overlap count:", length(overlap)))
[1] "Overlap count: 125"
> # 1. Map symbols to ENSG (assuming org.Hs.eg.db is loaded)
> canonical_symbols <- c("CDKN1A", "GADD45A", "FDXR", "MDM2", "BAX", "DDB2")
> canonical_mapping <- bitr(canonical_symbols, fromType="SYMBOL", toType="ENSEMBL", OrgDb=org.Hs.eg.db)
'select()' returned 1:1
mapping between keys and
columns
> 
> print(canonical_mapping)
   SYMBOL         ENSEMBL
1  CDKN1A ENSG00000124762
2 GADD45A ENSG00000116717
3    FDXR ENSG00000161513
4    MDM2 ENSG00000135679
5     BAX ENSG00000087088
6    DDB2 ENSG00000134574
> 
> # 2. Extract and plot raw data points
> # We extract normalized counts for these ENSG IDs
> canonical_counts <- counts(dds_final, normalized=TRUE)[canonical_mapping$ENSEMBL, ]
> canonical_df <- as.data.frame(t(canonical_counts))
> canonical_df$dose <- colData(dds_final)$dose
> 
> # 3. Reshape for plotting
> library(tidyr)
> library(ggplot2)
> canonical_long <- pivot_longer(canonical_df, cols = -dose, names_to = "ENSG", values_to = "Counts")
> 
> # 4. Plot
> ggplot(canonical_long, aes(x = as.factor(dose), y = Counts, color = ENSG)) +
+     geom_boxplot() +
+     geom_jitter(alpha = 0.5) +
+     theme_minimal() +
+     facet_wrap(~ENSG, scales = "free") +
+     labs(title = "Canonical Radiation Response Curves",
+          x = "Dose (Gy)", y = "Normalized Counts")
> # 1. Prepare your interaction results
> # Ensure 'res_interaction' is your DESeq2 results object for the interaction term
> results_df <- as.data.frame(res_interaction)
> 
> # 2. Define the literature BMD threshold range
> bmd_min <- 0.6
> bmd_max <- 2.5
> 
> # 3. Create the threshold visualization
> ggplot(results_df, aes(x = log2FoldChange, y = -log10(padj))) +
+     geom_point(alpha = 0.3, color = "grey") +
+     # Highlight the genes within our 695-gene list
+     geom_point(data = subset(results_df, padj < 0.1), aes(color = "Significant"), alpha = 0.6) +
+     # Add a vertical reference line for the threshold window
+     geom_vline(xintercept = log2(bmd_min), linetype="dashed", color="red") +
+     geom_vline(xintercept = log2(bmd_max), linetype="dashed", color="red") +
+     annotate("rect", xmin = log2(bmd_min), xmax = log2(bmd_max), ymin = -Inf, ymax = Inf, 
+              alpha = 0.2, fill = "red") +
+     theme_minimal() +
+     labs(title = "Dose-Rate Interaction vs. Literature BMD Threshold (0.6–2.5 Gy)",
+          x = "Log2 Fold Change (Interaction Term)",
+          y = "-Log10 Adjusted P-value",
+          subtitle = "Red area indicates the literature-defined BMD threshold range")
Warning message:
Removed 43159 rows containing
missing values or values outside the
scale range (`geom_point()`). 

> # 1. Prepare your interaction results
> # Ensure 'res_interaction' is your DESeq2 results object for the interaction term
> results_df <- as.data.frame(res_interaction)
> 
> # 2. Define the literature BMD threshold range
> bmd_min <- 0.6
> bmd_max <- 2.5
> 
> # 3. Create the threshold visualization
> ggplot(results_df, aes(x = log2FoldChange, y = -log10(padj))) +
+     geom_point(alpha = 0.3, color = "grey") +
+     # Highlight the genes within our 695-gene list
+     geom_point(data = subset(results_df, padj < 0.1), aes(color = "Significant"), alpha = 0.6) +
+     # Add a vertical reference line for the threshold window
+     geom_vline(xintercept = log2(bmd_min), linetype="dashed", color="red") +
+     geom_vline(xintercept = log2(bmd_max), linetype="dashed", color="red") +
+     annotate("rect", xmin = log2(bmd_min), xmax = log2(bmd_max), ymin = -Inf, ymax = Inf, 
+              alpha = 0.2, fill = "red") +
+     theme_minimal() +
+     labs(title = "Dose-Rate Interaction vs. Literature BMD Threshold (0.6–2.5 Gy)",
+          x = "Log2 Fold Change (Interaction Term)",
+          y = "-Log10 Adjusted P-value",
+          subtitle = "Red area indicates the literature-defined BMD threshold range")
Warning message:
Removed 43159 rows containing
missing values or values
outside the scale range
(`geom_point()`). 

> # Ensure ggplot2 and dplyr are loaded
> library(ggplot2)
> library(dplyr)

Attaching package: ‘dplyr’

The following object is masked from ‘package:AnnotationDbi’:

    select

The following object is masked from ‘package:MASS’:

    select

The following objects are masked from ‘package:GenomicRanges’:

    intersect, setdiff, union

The following object is masked from ‘package:matrixStats’:

    count

The following object is masked from ‘package:gridExtra’:

    combine

The following object is masked from ‘package:oligo’:

    summarize

The following objects are masked from ‘package:Biostrings’:

    collapse, intersect, setdiff, setequal, union

The following object is masked from ‘package:Seqinfo’:

    intersect

The following object is masked from ‘package:XVector’:

    slice

The following objects are masked from ‘package:IRanges’:

    collapse, desc, intersect, setdiff, slice,
    union

The following objects are masked from ‘package:S4Vectors’:

    first, intersect, rename, setdiff, setequal,
    union

The following object is masked from ‘package:Biobase’:

    combine

The following objects are masked from ‘package:BiocGenerics’:

    combine, intersect, setdiff, setequal, union

The following object is masked from ‘package:generics’:

    explain

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Warning message:
package ‘dplyr’ was built under R version 4.6.1 
> 
> # 1. Prepare the data with clear labels
> plot_data <- as.data.frame(res_interaction) %>%
+     mutate(status = ifelse(padj < 0.1 & !is.na(padj), "Significant", "Non-Significant"))
> 
> # 2. Define thresholds
> bmd_min <- 0.6
> bmd_max <- 2.5
> 
> # 3. Create the Publication-Ready Plot
> ggplot(plot_data, aes(x = log2FoldChange, y = -log10(padj))) +
+     # Add background genes first
+     geom_point(data = filter(plot_data, status == "Non-Significant"), 
+                aes(color = status), alpha = 0.2, size = 1) +
+     # Add significant genes on top
+     geom_point(data = filter(plot_data, status == "Significant"), 
+                aes(color = status), alpha = 0.6, size = 1.5) +
+     # Add the BMD threshold highlight
+     annotate("rect", xmin = log2(bmd_min), xmax = log2(bmd_max), 
+              ymin = -Inf, ymax = Inf, alpha = 0.15, fill = "red") +
+     geom_vline(xintercept = c(log2(bmd_min), log2(bmd_max)), 
+                linetype = "dashed", color = "red", size = 0.5) +
+     # Styling
+     scale_color_manual(values = c("Significant" = "red", "Non-Significant" = "grey70")) +
+     theme_minimal() +
+     labs(title = "Dose-Rate Interaction vs. Literature BMD Threshold (0.6–2.5 Gy)",
+          subtitle = "Red area indicates the literature-defined Benchmark Dose (BMD) range",
+          x = "Log2 Fold Change (Interaction Term)",
+          y = "-Log10 Adjusted P-value",
+          color = "Gene Status") +
+     theme(legend.position = "right",
+           plot.title = element_text(face = "bold"),
+           panel.grid.minor = element_blank())
Warning message:
Removed 43159 rows containing missing values or values
outside the scale range (`geom_point()`). 

> 
