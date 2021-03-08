#' Get stats on users
#' 
#' 
#' @description Get stats on which users reported the most species or had tho most observations within a given range. This range can be by user, place, project, day or date range. Output will be a count of the total number of taxa observed at each taxonomic level.
#' @param date retrieve observations on a specific date, must be a string in the form YYYY-MM-DD
#' @param date_range a vector of dates, in the form YYYY-MM-DD
#' @param place get taxon stats by place, you can find place id's on the iNaturalist page: https://www.inaturalist.org/places, must be a numeric ID
#' @param project get taxon stats by project id
#' @param uid get taxon stats by user id 
#' 
#' @return a list with two data frames with of the 5 users with the most observations and the most species
#' @examples \dontrun{
#'  counts <- get_inat_user_stats(date = "2010-06-14")
#' }
#' @import httr
#' @importFrom curl has_internet
#' @export


get_inat_user_stats <- function(date = NULL, date_range = NULL, place = NULL, project = NULL, uid = NULL) {
  
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
  
  q_path <- "observations/user_stats.json"
  search <- ""
  
  if(!is.null(date)){
    search = paste0(search, "&on=", date)
  }
  if(!is.null(date_range)){
    search = paste0(search, "d1=", date_range[1], "&d2=", date_range[2])
  }
  if(!is.null(place)){
    search = paste0(search, "place_id=", place)
  }
  if(!is.null(project)){
    search = paste0(search, "projects=", project)
  }
  if(!is.null(uid)){
    search = paste0(search, "&user_id=", uid)
  }
  
  data <-  fromJSON(content(GET(base_url, path = q_path, query = search), as = "text"))

  
  return(data)
}
