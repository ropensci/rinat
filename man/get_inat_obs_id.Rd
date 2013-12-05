\name{get_inat_obs_id}
\alias{get_inat_obs_id}
\title{Get information on a specific observation}
\usage{
  get_inat_obs_id(id)
}
\arguments{
  \item{id}{a single id for an inaturalist observation
  record}
}
\value{
  a list with full details on a given record
}
\description{
  Get information on a specific observation
}
\examples{
\dontrun{
  m_obs <- get_inat_obs(query="Monarch Butterfly")
  get_inat_obs_id(m_obs$Id[1])
}
}

