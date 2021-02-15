#' Prepare data for barpot
#'
#' @param ps phyloseq-object
#' @param n number of OTUs/ASVs to include
#' @param residuals include residuals (logical). Default: TRUE
#'
#' @return returns a data.frame in long-format with a column 'OTU' (containing formatted names of each OTU)
#' and 'value' containing either raw read counts or relative abundances (depending on what type of phyloseq
#' was initially loaded).
#' @export
#'
#' @examples
#' data(ps_NP)
#' prep_bar(ps_NP, 15)
prep_bar <- function(ps, n, residuals = TRUE) {
  excl_cols <- c("sample_id", colnames(phyloseq::sample_data(ps)))

  df_topn <- ps %>%
    get_topn(n = n, residuals = residuals) %>%
    ps_to_df(sample_name = "sample_id") %>%
    tidyr::pivot_longer(-dplyr::all_of(excl_cols), names_to = "OTU", values_to = "value") %>%
    dplyr::mutate(OTU = format_OTU(.data$OTU) %>% forcats::fct_inorder() %>% forcats::fct_rev()) %>%
    dplyr::arrange(.data$sample_id) %>%
    dplyr::mutate(sample_id = forcats::fct_inorder(.data$sample_id))

  return(df_topn)
}
