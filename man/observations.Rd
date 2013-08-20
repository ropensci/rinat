\name{observations}
\alias{observations}
\title{observations - Primary function to retrive observations form iNaturalist}
\usage{
  observations(query = NA, page = NA, per_page = NA,
    maxresults = 100)
}
\arguments{
  \item{query}{Query string}

  \item{page}{page number}

  \item{per_page}{Records per page to download}

  \item{maxresults}{- yet to prgram this}
}
\description{
  observations - Primary function to retrive observations
  form iNaturalist
}
\examples{
\dontrun{
 observations(query="Monarch Butterfly",page=2,per_page=25)
}
}

