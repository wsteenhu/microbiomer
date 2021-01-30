#' Convert phyloseq with raw read counts to relative abundance
#'
#' @param ps phyloseq-object.
#'
#' @return Returns an phyloseq-object containing relative abundances instead of raw read counts (uses total sum scaling).
#' @export
#'
#' @examples
#' data(enterotype)
#' to_RA(enterotype)
to_RA <- function(ps) {
  phyloseq::transform_sample_counts(ps, function(OTU) OTU / sum(OTU))
}
