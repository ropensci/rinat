#' Get stats on taxa 
#' 
#' @description get stats on taxa within a constrained range.  This range can be by user, place, project, day or date range.  
#' @param date retrieve observations on a specific date, must be a string in the form YYYY-MM-DD
#' @param date_range a vector of dates, in the form YYYY-MM-DD
#' @param place get taxon stats by place, you can find place id's on the iNaturalist page: http://www.inaturalist.org/places, must be a numeric ID
#' @param project get taxon stats by project id, 
#' 
#' @return a ggplot2 map object
#' @examples \dontrun{
#'   m_obs <- get_obs_inat(taxon="Ambystoma maculatum")
#'   salamander_map <- inat_map(m_obs,plot=FALSE)
#'   ### Now we can modify the returned map
#'   salamander_map + borders("state") + theme_bw()
#' }
#' @import map ggplot2
#' @export
