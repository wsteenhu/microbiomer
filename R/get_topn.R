#' Extract the top _n_ OTUs from a phyloseq-object
#'
#' @param ps phyloseq-object.
#' @param n number of OTUs to extract; ranking based on mean (relative) abundance.
#' @param residuals include residuals (logical).
#'
#' @return Returns a phyloseq-object only containing the top _n_ OTUs.
#' This function is mainly used in the context of plotting functions.
#' @export
#'
#' @examples
#' data(enterotype)
#' get_topn(enterotype)
get_topn <- function(ps, n = 15, residuals = TRUE) {
  otu_tab <- phyloseq::otu_table(ps)
  otu_tab_n <- otu_tab[order(rowMeans(otu_tab), decreasing = TRUE)[1:n], ]
  otu_tab_res <- otu_tab[-order(rowMeans(otu_tab), decreasing = TRUE)[1:n], ]

  if(residuals) {
    otu_tab_n <- otu_tab_n %>%
      t %>%
      data.frame(residuals = colSums(otu_tab_res), check.names = FALSE) %>%
      t
  }
  return(phyloseq::phyloseq(phyloseq::otu_table(otu_tab_n, taxa_are_rows = TRUE),
                            phyloseq::sample_data(ps)))
}
