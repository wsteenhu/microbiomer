#' Convert phyloseq metadata (sample_data) to dataframe.
#'
#' @param ps phyloseq-object
#' @param sample_name name of the column containing samples (default: 'sample_id')
#'
#' @return A dataframe with metadata contained in phyloseq.
#' @export
#'
#' @examples
#' data(ps_NP)
#' meta_to_df(ps_NP)
meta_to_df <- function(ps, sample_name = "sample_id") {
  meta <- phyloseq::sample_data(ps)
  df <- meta %>%
    data.frame() %>%
    tibble::rownames_to_column(sample_name)
  return(df)
}
