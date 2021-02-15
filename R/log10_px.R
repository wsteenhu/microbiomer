#' log10 pseudocount conversion
#'
#' @param ps phyloseq-object
#' @param pseudocount add a pseudocount (default = 1); prevents conversion-problems with zero.
#'
#' @return converted phyloseq-object
#' @export
#'
#' @examples
#' data(ps_NP)
#' log10_px(ps_NP, 0.00001)
log10_px <- function(ps, pseudocount = 1) {

  phyloseq::transform_sample_counts(ps, function(x) log10(x + pseudocount))

}
