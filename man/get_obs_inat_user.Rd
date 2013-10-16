\name{get_obs_inat_user}
\alias{get_obs_inat_user}
\title{Get all the observations of a specific user}
\usage{
  get_obs_inat_user(username, maxresults = 100)
}
\arguments{
  \item{username}{Username of inaturalist user to fetch
  records}

  \item{maxresults}{the maximum number of results to
  return}
}
\value{
  a list with full details on a given record
}
\description{
  Get all the observations of a specific user
}
\examples{
\dontrun{
  m_obs <- get_obs_inat(query="Monarch Butterfly")
  get_obs_inat_id(m_obs$Id[1])
}
}

