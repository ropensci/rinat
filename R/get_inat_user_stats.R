#' Get stats on users
#' 
#' 
#' @description get stats on which users reported the most species or had tho most observations within a given range.  This range can be by user, place, project, day or date range.  Output will be a count of the total number of taxa observed at each taxonomic level.
#' @param date retrieve observations on a specific date, must be a string in the form YYYY-MM-DD
#' @param date_range a vector of dates, in the form YYYY-MM-DD
#' @param place get taxon stats by place, you can find place id's on the iNaturalist page: http://www.inaturalist.org/places, must be a numeric ID
#' @param project get taxon stats by project id
#' @param uid get taxon stats by user id 
#' 
#' @return a list with two data frames with of the 5 users with the most observations and the most species
#' @examples \dontrun{
#'  counts <- get_inat_user_stats(date="2010-06-14")
#' }
#' @import httr
#' @export


get_inat_user_stats <- function(date = NULL, date_range = NULL, place = NULL, project = NULL, uid=NULL){
  
  base_url <- "http://www.inaturalist.org/"
  q_path <- "observations/user_stats.json"
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
  
  data <-  content(GET(base_url,path = q_path, query = search))
  out_sp_vec <- unlist(data$most_species)
  out_sp_vec <- out_sp_vec[which(names(out_sp_vec) !="user.user_icon_url")]
  out_sp <- data.frame(t(matrix(out_sp_vec,ncol=5,nrow=4)))
  colnames(out_sp) <- unique(names(out_sp_vec))
  out_sp$count <- as.numeric(as.character(out_sp$count))
  out_sp$user.id <- as.numeric(as.character(out_sp$user.id))
  
  out_obs_vec <- unlist(data$most_observations)
  out_obs_vec <- out_obs_vec[which(names(out_obs_vec) !="user.user_icon_url")]
  out_obs <- data.frame(t(matrix(out_obs_vec,ncol=5,nrow=4)))
  colnames(out_obs) <- unique(names(out_obs_vec))
  out_obs$count <- as.numeric(as.character(out_obs$count))
  out_obs$user.id <- as.numeric(as.character(out_obs$user.id))
  
  out <- list(species = out_sp,observatinos=out_obs)
  
  return(out)
}