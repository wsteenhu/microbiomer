% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prep_bar.R
\name{prep_bar}
\alias{prep_bar}
\title{Prepare data for barpot}
\usage{
prep_bar(ps, n, residuals = TRUE)
}
\arguments{
\item{ps}{phyloseq-object}

\item{n}{number of OTUs/ASVs to include}

\item{residuals}{include residuals (logical). Default: TRUE}
}
\value{
returns a data.frame in long-format with a column 'OTU' (containing formatted names of each OTU)
and 'value' containing either raw read counts or relative abundances (depending on what type of phyloseq
was initially loaded).
}
\description{
Prepare data for barpot
}
\examples{
data(ps_NP)
prep_bar(ps_NP, 15)
}
