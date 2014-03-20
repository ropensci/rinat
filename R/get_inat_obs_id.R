#' Get information on a specific observation
#' @param id a single id for an inaturalist observation record
#' @return a list with full details on a given record
#' @examples \dontrun{
#'   m_obs <- get_inat_obs(query="Monarch Butterfly")
#'   get_inat_obs_id(m_obs$Id[1])
#' }
#' @import httr plyr jsonlite
#' @export

get_inat_obs_id <- function(id){
  base_url <- "http://www.inaturalist.org/"
  q_path <- paste("observations/",as.character(id),".json",sep="")
  id_info <-  fromJSON(content(GET(base_url,path = q_path), as = "text"))
  ## convert to string

  return(id_info)
}

