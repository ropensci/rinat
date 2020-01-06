#' Get stats on taxon counts
#' 
#' 
#' @description get stats on taxa within a constrained range.  This range can be by user, place, project, day or date range.  Output will be a count of the total number of taxa observed at each taxonomic level.
#' @param date retrieve observations on a specific date, must be a string in the form YYYY-MM-DD
#' @param date_range a vector of dates, in the form YYYY-MM-DD
#' @param place get taxon stats by place, you can find place id's on the iNaturalist page: http://www.inaturalist.org/places, must be a numeric ID
#' @param project get taxon stats by project id (numeric ID)
#' @param uid get taxon stats by user id (string)
#' 
#' @return a vector listing counts of observations at each level of identification possible (species, genus, etc..)
#' @examples \dontrun{
#'  counts <- get_inat_taxon_stats(date="2010-06-14")
#' }
#' @import httr jsonlite
#' @export


get_inat_taxon_stats <- function(date = NULL, date_range = NULL, place = NULL, project = NULL, uid=NULL){
  
  base_url <- "http://www.inaturalist.org/"
  q_path <- "observations/taxon_stats.json"
  search = ""
  
  if(!is.null(date)){
    search = paste(search,"&on=",date,sep="")
  }
  if(!is.null(date_range)){
    search = paste(search,"d1=",date_range[1],"&d2=",date_range[2],sep="")
  }
  if(!is.null(place)){
    search = paste(search,"place_id=",place, sep="")
  }
  if(!is.null(project)){
    search = paste(search,"projects=",project,sep="")
  }
  if(!is.null(uid)){
    search = paste(search,"&user_id=",uid,sep="")
  }
  
  data <-  fromJSON(content(GET(base_url,path = q_path, query = search),as = "text"))
  return(data)
}

