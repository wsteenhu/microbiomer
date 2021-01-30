#' Combine phyloseq OTU-table (otu_table) and metadata (sample_data) into one dataframe.
#'
#' @param ps phyloseq-object
#' @param sample_name name of the column containing samples (default: 'sample_id')
#'
#' @return A dataframe with OTU-data and metadata contained in phyloseq.
#' @export
#'
#' @seealso
#' \code{\link{meta_to_df}} \code{\link{otu_tab_to_df}}
#'
#' @examples
#' data(enterotype)
#' ps_to_df(enterotype)
ps_to_df <- function(ps, sample_name = "sample_id") {
  df_meta <- meta_to_df(ps, sample_name)
  df_otu <- otu_tab_to_df(ps, sample_name)

  dplyr::left_join(df_meta, df_otu, by = sample_name) %>% tibble::as_tibble()
}
