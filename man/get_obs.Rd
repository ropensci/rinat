\name{get_obs}
\alias{get_obs}
\title{get_obs - Primary function to retrive observations from iNaturalist}
\usage{
  get_obs(query = NA, page = NA, per_page = NA,
    maxresults = 100)
}
\arguments{
  \item{query}{Query string}

  \item{page}{page number}

  \item{per_page}{Records per page to download}

  \item{maxresults}{- yet to prgram this}
}
\description{
  get_obs - Primary function to retrive observations from
  iNaturalist
}
\examples{
\dontrun{
 get_obs(query="Monarch Butterfly",page=2,per_page=25)
}
}

