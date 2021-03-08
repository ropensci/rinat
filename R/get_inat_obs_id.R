#' Get information on a specific observation
#'
#' @export
#' @import httr plyr jsonlite
#' @importFrom curl has_internet
#' @param id a single id for an iNaturalist observation record
#' @return a list with full details on a given record
#' @examples \dontrun{
#' m_obs <- get_inat_obs(query="Monarch Butterfly")
#' get_inat_obs_id(m_obs$id[1])
#' }
get_inat_obs_id <- function(id) {
  
  # check Internet connection
  if (!curl::has_internet()) {
    message("No Internet connection.")
    return(invisible(NULL))
  }
  
  base_url <- "http://www.inaturalist.org/"
  # check that iNat can be reached
  if (httr::http_error(base_url)) { # TRUE: 400 or above
    message("iNaturalist API is unavailable.")
    return(invisible(NULL))
  }
  
  q_path <- paste("observations/", as.character(id), ".json", sep = "")
  fromJSON(content(GET(base_url,path = q_path), as = "text"))
}
