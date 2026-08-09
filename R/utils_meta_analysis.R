# ==============================================================================
# R/utils_meta_analysis.R
# Meta-Analysis Utility Functions for Transcriptomic Radiation Signatures
# ==============================================================================

#' Collapse multiple probes per gene per dataset by selecting minimum P-value
collapse_probes <- function(all_evidence) {
  all_evidence %>%
    dplyr::group_by(Symbol, Dataset) %>%
    dplyr::slice_min(PValue, with_ties = FALSE) %>%
    dplyr::ungroup()
}

#' Execute meta-aggregation using Fisher's Combined Probability Test
run_meta <- function(ev_data, min_datasets = 3) {
  summary_df <- ev_data %>%
    dplyr::group_by(Symbol) %>%
    dplyr::summarise(
      N_Datasets = dplyr::n(),
      # Directional concordance: 100% in one direction (all up or all down)
      Consistent_Direction = max(
        sum(Direction == 1, na.rm = TRUE), 
        sum(Direction == -1, na.rm = TRUE)
      ) == dplyr::n(),
      # Extract valid p-values for Fisher's method
      Combined_P_Fisher = {
        valid_p <- PValue[PValue > 0 & !is.na(PValue)]
        if (length(valid_p) >= 2) metap::sumlog(valid_p)$p else NA_real_
      },
      .groups = 'drop'
    )
  
  # Apply strict Tier 1 filtering criteria
  tier1_sig <- summary_df %>%
    dplyr::filter(
      !is.na(Combined_P_Fisher),
      N_Datasets >= min_datasets,
      Consistent_Direction == TRUE,
      Combined_P_Fisher < 1e-5
    )
  
  return(tier1_sig)
}

#' Calculate the robust intersection of LOCO results
run_loco_intersections <- function(loo_results_list) {
  Reduce(intersect, loo_results_list)
}
