#' log10 pseudocount conversion
#'
#' @param ps phyloseq-object
#' @param pseudocount add a pseudocount (default = 1); prevents conversion-problems with zero.
#'
#' @return converted phyloseq-object
#' @export
#'
#' @examples
#' data(enterotype)
#' log10_px(enterotype, 0.00001)
log10_px <- function(ps, pseudocount = 1) {
  ps %>% phyloseq::transform_sample_counts(., function(x) log10(x + pseudocount))
}
