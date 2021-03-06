% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/to_RA.R
\name{to_RA}
\alias{to_RA}
\title{Convert phyloseq with raw read counts to relative abundance}
\usage{
to_RA(ps)
}
\arguments{
\item{ps}{phyloseq-object}
}
\value{
Returns an phyloseq-object containing relative abundances instead of raw read counts (uses total sum scaling).
}
\description{
Convert phyloseq with raw read counts to relative abundance
}
\examples{
data(ps_NP)
to_RA(ps_NP)
}
