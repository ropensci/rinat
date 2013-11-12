\name{get_obs_inat_user}
\alias{get_obs_inat_user}
\title{Download observations for a user}
\usage{
  get_obs_inat_user(username, maxresults = 100)
}
\arguments{
  \item{username}{Username of the inaturalist user to fetch
  records}

  \item{maxresults}{the maximum number of results to
  return}
}
\value{
  a list with full details on a given record
}
\description{
  Get all the observations of a specific inaturalist user
}
\examples{
\dontrun{
  m_obs <- get_obs_inat(query="Monarch Butterfly")
  get_obs_inat_user(as.character(m_obs$User.login[1]))
}
}

