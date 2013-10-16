\name{get_obs_inat}
\alias{get_obs_inat}
\title{Primary function to retrive observations from iNaturalist, allows users to search for data, or just filter results by a subset of what is offered by the API}
\usage{
  get_obs_inat(query = NULL, quality = NULL, geo = NULL,
    year = NULL, month = NULL, day = NULL, bounds = NULL,
    maxresults = 100)
}
\arguments{
  \item{query}{Query string for a general search}

  \item{quality}{the quality grade to be used.  Must be
  either "casual" or "research" If left blank both will be
  returned.}

  \item{geo}{flag for returning only results that are
  georeferenced, TRUE will exclude non-georeferenced
  results, but they cannot be excluded.}

  \item{year}{return observations only in that year (can
  only be one year, not a range of years)}

  \item{month}{return observations only by month, must be
  numeric, 1...12}

  \item{day}{return observations only on a given day of the
  month, 1...31}

  \item{bounds}{a bounding box of longitude (-180 to 180)
  and latitude (-90 to 90) to search within.  It is a
  vector in the form of southern latitude, western
  longitude, northern latitude, and easter longitude}

  \item{maxresults}{the maximum number of results to
  return}
}
\value{
  a dataframe of the number of observations requestsed
}
\description{
  Primary function to retrive observations from
  iNaturalist, allows users to search for data, or just
  filter results by a subset of what is offered by the API
}
\examples{
\dontrun{
  ### Make a standard query
  get_obs_inat(query="Monarch Butterfly")

  ##Filter by a bounding box of Northern California
  bounds <- c(38.44047,-125,40.86652,-121.837)
  get_obs_inat(query="Mule Deer", bounds=bounds)
}
}

