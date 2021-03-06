\name{drsam.null}
\alias{drsam.null}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Generate null distribution for DR-SAM analysis }
\description{
  A null distribution is generated by randomly permuting the class labels of the 
	samples and recomputing the DR-SAM statistic for each gene.
}
\usage{
drsam.null(DNA.data, RNA.data, labels, transform.type, k)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{DNA.data}{ matrix of DNA copy number data }
  \item{RNA.data}{ matrix of gene expression data, samples (columns) in same order as DNA matrix  }
  \item{labels}{ class labels of the two comparison groups, either \code{1} or \code{2} }
  \item{transform.type}{ type of transformation to apply to data, either "standardize", "rank", or "raw" }
  \item{k}{ number of permutations to perform }
}
\details{
}
\value{
  \item{null}{ n * k matrix of null data, where n = number of genes and k = number of permutations }
}
\references{
Salari, K., Tibshirani, R., and Pollack, J.R. (2009) DR-Integrator: a new analytic tool for integrating 
DNA copy number and gene expression data. http://pollacklab.stanford.edu/
}
\author{ Keyan Salari, Robert Tibshirani, Jonathan R. Pollack }
\note{
}
\seealso{
\code{\link{drcorrelate}}, \code{\link{drcorrelate.null}}, \code{\link{drsam}}, 
\code{\link{drsam.null}}, \code{\link{dri.fdrCutoff}}, \code{\link{dri.sig_genes}}, 
\code{\link{dri.heatmap}}, \code{\link{dri.merge.CNbyRNA}}, \code{\link{dri.smooth.cghdata}}, 
\code{\link{runFusedLasso}}
}
\examples{
require(impute)
data(mySampleData)
attach(mySampleData)

# DNA data should contain no missing values - pre-smooth beforehand
# Impute missing values for gene expression data
RNA.data <- dri.impute(RNA.data)

# DR-SAM analysis to find genes with alterations in both DNA and RNA between
# different classes
labels <- c(rep(1,25), rep(2,25)) # 25 samples in class 1 and 25 in class 2
obs <- drsam(DNA.data, RNA.data, labels, transform.type="raw")
# generate null distribution for FDR calculation (10 permutations)
null <- drsam.null(DNA.data, RNA.data, labels, transform.type="raw", 10)
# identify the correlation cutoff corresponding to your desired FDR
n.cutoff <- dri.fdrCutoff(obs$test.summed, null, targetFDR=0.05, bt=TRUE)
cutoff <- n.cutoff[2]
# retrieve all genes that are significant at the determined cutoff, and
# calculate gene-specific FDRs
Results <- dri.sig_genes(cutoff, obs, null, GeneIDs, GeneNames, Chr, Nuc, 
bt=TRUE, method="drsam") 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{}
\keyword{}% __ONLY ONE__ keyword per line
