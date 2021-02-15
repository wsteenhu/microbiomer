#' Convert phyloseq OTU-table (otu_table) to dataframe.
#'
#' @param ps phyloseq-object
#' @param sample_name name of the column containing samples (default: 'sample_id')
#'
#' @return A dataframe with OTU-data contained in phyloseq.
#' @export
#'
#' @seealso
#' \code{\link{meta_to_df}}
#'
#' @examples
#' data(ps_NP)
#' otu_tab_to_df(ps_NP)
otu_tab_to_df <- function(ps, sample_name = "sample_id") {
  otu_tab <- phyloseq::otu_table(ps)
  df <- otu_tab %>%
    t %>%
    data.frame() %>%
    tibble::rownames_to_column(sample_name)
  return(df)
}
