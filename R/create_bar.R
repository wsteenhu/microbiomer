#' Create a per-sample barplot of the top \emph{n} OTUs/ASVs
#'
#' Takes either a phyloq-object or an (edited) result of \code{\link{prep_bar}} as an input. And
#' creates a per-sample barplot.
#'
#' @param ps phyloseq-object (optional)
#' @param df_topn topn-data.frame (result of \code{\link{prep_bar}})
#' @param id name of the 'id'-column (default: 'sample_id')
#' @param n number of OTUs/ASVs to plot
#' @param ncol_legend number of columns in the legend
#' @param name_legend name of the legend
#' @param RA specify whether or not the phyloseq is based on relative abundances (logical). Default: TRUE
#'
#' @return returns a per-sample barplot showing the \emph{n} most abundant OTUs.
#' @export
#'
#' @examples
#' data(ps_NP)
#' ps_NP %>%
#'   phyloseq::subset_samples(visit_name == "w1" & birth_mode == "vag") %>%
#'   create_bar() +
#'   ggplot2::coord_flip()
create_bar <- function(ps = NULL, df_topn = NULL, id = "sample_id", n = 15, ncol_legend = 3, name_legend = "OTU", RA = TRUE) {

  # accepts either ps (running prep_bar) or a dataframe already prepared with prep_bar
  if(any(class(ps)=="phyloseq")) { df_topn <- prep_bar(ps = ps, n = n) }

  bar <- df_topn %>%
    ggplot2::ggplot(ggplot2::aes_string(x = id, y = "value", fill = "OTU")) +
    ggplot2::geom_bar(stat="identity", colour="white") +
    ggplot2::scale_fill_manual(name = name_legend, values = c("grey90", rev(make_color_scheme("Paired", n)))) +
    ggplot2::labs(x = "" , y = "Number of reads") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1, vjust = 0.5),
                   legend.position = "bottom", legend.text = ggtext::element_markdown(),
                   panel.grid.major = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank()) +
    ggplot2::guides(fill = ggplot2::guide_legend(ncol = ncol_legend))

  if(RA) {
    bar <- bar +
      ggplot2::scale_y_continuous(expand = c(0.01, 0.01), labels = scales::percent) +
      ggplot2::ylab("Relative abundance")
  }
  return(bar)
  #https://bookdown.org/rdpeng/RProgDA/non-standard-evaluation.html
}
