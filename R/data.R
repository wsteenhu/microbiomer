#' Nasopharyngeal (NP) microbiota data of young infants.
#'
#' A dataset containing the nasopharyngeal microbiota data of 97 infants at the age of 1 week,
#' 1 month and 1 year (\emph{n} = 287 samples). Data from these subjects was already published
#' (Bosch \emph{et al}, \emph{Am J Resp Crit Care Med}, 2017), yet for the current data, we revisited
#' our initial bioinformatic processing steps, this time running DADA2 and \code{decontam} to
#' curate data.
#'
#' @format A phyloseq-object with 1793 taxa, 287 samples and 5 clinical variables. Datasets contained
#' in this object can be accessed through functions in the phyloseq-package (e.g. \code{\link[phyloseq]{otu_table}},
#' \code{\link[phyloseq]{tax_table}}, and \code{\link[phyloseq]{sample_data}}). Alternatively, wrappers around
#' these functions contained in this package can be used (e.g. \code{\link{meta_to_df}}).
#'
#' \describe{
#' \item{seq_id}{subject identifier}
#' \item{visit_name}{name of the visit, week 1 (w1), month 1 (m1) or year 1 (y1)}
#' \item{age}{age in days after birth}
#' \item{birth mode}{either vaginal (vag) or by caesarian section (sc)}
#' \item{bf_group_3m_yn}{exclusive breastfeeding within the first 3 months of life yes (1) or no (0)}
#' }
#' @source \url{https://www.atsjournals.org/doi/full/10.1164/rccm.201703-0554OC}
#' @examples
#' ps_NP
#' ps_NP %>% meta_to_df() %>% dplyr::count(visit_name, birth_mode)
"ps_NP"
