#' Filter phyloseq-object based on presence/absence
#'
#' @param ps phyloseq-object
#' @param pres number of samples in which given ASV should at least be present to be included
#' @param abund abundance which given ASV should at least be present
#' @param verbose (logical) print information on number of ASVs included/excluded
#'
#' @return A filtered phyloseq-object
#' @export
#'
#' @examples
#' data(esophagus)
#' phyloseq::ntaxa(esophagus)
#' esophagus_filtered <- esophagus %>% pres_abund_filter()
#' phyloseq::ntaxa(esophagus_filtered)
pres_abund_filter <- function(ps, pres = 2, abund = 0.001, verbose = T) {
  # Subramanian filter
  ps_filtered <- phyloseq::filter_taxa(ps, function(x) sum(x >= abund) >= pres, TRUE)

  if(verbose) {
  print(glue::glue("A total of {phyloseq::ntaxa(ps_filtered)} ASVs were found to be present at or above a level of confident detection ({(abund * 100)}% relative abundance) in at least {pres} samples (n = {phyloseq::ntaxa(ps) - phyloseq::ntaxa(ps_filtered)} ASVs excluded)."))
  }
}


