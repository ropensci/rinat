\name{get_obs_project}
\alias{get_obs_project}
\title{Download observations and info for a project}
\usage{
  get_obs_project(grpid, type = c("observations", "info"))
}
\arguments{
  \item{grpid}{Name of the group as an iNaturalist slug or
  group id}

  \item{type}{Either "observations" or "info" Observations
  returns all observations, and "info" returns project
  details similar to what you can find on a project
  webpage.}
}
\description{
  retrieve observations from a particular iNaturalist
  project.  This function can be used to get either
  observations from a project, or info about a project
}
\details{
  An iNaturalist slug is usually the project as single
  string with words seperated by hyphens. For instance, the
  project "State Flowers of the United States" has a slug
  of "state-flowers-of-the-united-states-eol-collection".
  This can be extracted from the URL for the project
  usually. The state flowers project has the following URL
  http://www.inaturalist.org/projects/state-flowers-of-the-united-states-eol-collection
}
\examples{
\dontrun{
 get_obs_project(354, type = "observations")
 get_obs_project("crows-in-vermont", type="info")
}
}

