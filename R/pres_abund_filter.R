#' Filter phyloseq-object based on presence/absence
#'
#' By default, this function implements a filter used by Subramanian \emph{et al}., \emph{Nature}, 2014.
#' It selects those OTUs/ASVs present at or above a level of confident detection (0.1% relative abundance) in at
#' least 2 samples.
#' This filter, especially using DADA2 data, results in a strong reduction of taxa, yet the total number of
#' reads should not drop too much. Always be considerate when using these filters, e.g. when running alpha-diversity
#' measures it might not be appropriate to use.
#'
#' @param ps phyloseq-object (can be contain raw reads/relative abundance)
#' @param pres number of samples in which given OTU/ASV should at least be present to be included
#' @param abund abundance which given OTU/ASV should at least be present
#' @param verbose (logical) print information on number of ASVs included/excluded
#'
#' @return A filtered phyloseq-object.
#' @export
#'
#' @examples
#' data(ps_NP)
#' phyloseq::ntaxa(ps_NP)
#' ps_NP_filt <- ps_NP %>% pres_abund_filter()
#' phyloseq::ntaxa(ps_NP_filt)
pres_abund_filter <- function(ps, pres = 2, abund = 0.001, verbose = TRUE) { # Subramanian filter
  is_raw <- max(phyloseq::otu_table(ps)) > 1 # detect is ps has raw reads

  if(is_raw) { # if raw reads; convert to RA for filtering
    ps_raw <- ps
    ps <- ps_raw %>% to_RA()
  }

  ps_filt <- phyloseq::filter_taxa(ps, function(x) sum(x > abund) >= pres, TRUE)

  if(verbose) {
    message(glue::glue("A total of {phyloseq::ntaxa(ps_filt)} ASVs were found to be present at or above a level of confident detection ({(abund * 100)}% relative abundance) in at least {pres} samples (n = {phyloseq::ntaxa(ps) - phyloseq::ntaxa(ps_filt)} ASVs excluded)."))
  }

  if(!is_raw) {
    return(ps_filt)
  } else {
    return(phyloseq::prune_taxa(phyloseq::taxa_names(ps_filt), ps_raw))
  }
}

