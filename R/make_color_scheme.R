#' Expands colors of any brewer.pal-scheme to \emph{n} colors
#'
#' @param name name of the color scheme, e.g. 'Paired', 'Spectral' or 'BrBG'.
#' @param n number of colors needed.
#'
#' @return returns a vector of colors which can be used in various plots/plotting functions.
#' @export
#'
#' @examples
#' make_color_scheme("Paired", 15)
#'
#' @seealso
#' For scheme-options see \code{\link[RColorBrewer:RColorBrewer]{RColorBrewer::brewer.pal.info()}}.
make_color_scheme <- function(name, n) {
  max_n <-  RColorBrewer::brewer.pal.info %>%
    tibble::rownames_to_column("name_pal") %>%
    dplyr::filter(.data$name_pal == name) %>%
    dplyr::pull(.data$maxcolors)

  grDevices::colorRampPalette(RColorBrewer::brewer.pal(
    dplyr::case_when(n < 3 ~ 3, n < max_n ~ n, TRUE ~ as.numeric(max_n)), name))(n)
}
