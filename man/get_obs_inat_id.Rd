\name{get_obs_inat_id}
\alias{get_obs_inat_id}
\title{Get information on a specific observation}
\usage{
  get_obs_inat_id(id)
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
  m_obs <- get_obs_inat(query="Monarch Butterfly")
  get_obs_inat_id(m_obs$Id[1])
}
}

