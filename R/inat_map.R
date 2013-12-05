#' Plot iNaturalist observations 
#' 
#' @description Plot observations from iNaturalist.  You have the option of automatically plotting, or returning a ggplot map object that you can add layers on to.
#' @param data data frame of iNaturalist observations
#' @param map the map region to plot, you can find full documentation in the \code{\link{map}} package, default is usa.
#' @param subregion the name of the subregion to plot, see full documentation in the \code{\link{map}} package
#' @param plot a TRUE or FALSE variable, TRUE plots the map object and returns it, and FALSE returns a ggplot2 object that you can modify and plot later
#' 
#' @return a ggplot2 map object
#' @examples \dontrun{
#'   m_obs <- get_inat_obs(taxon="Ambystoma maculatum")
#'   salamander_map <- inat_map(m_obs,plot=FALSE)
#'   ### Now we can modify the returned map
#'   salamander_map + borders("state") + theme_bw()
#' }
#' @import maps ggplot2
#' @export

inat_map <- function(data, map = "usa",subregion=".",plot=TRUE){
  map_df <- map_data(map,region=subregion)
  base_map <- ggplot(map_df,aes(x=long,y=lat)) + geom_polygon(aes(group=group), fill="white", color="gray40", size=0.2)
  sp_map <- base_map + geom_point(data=data,aes(x=Longitude,y=Latitude))
  
  if(plot){
    print(sp_map)
    return(sp_map)
  } else {
    return(sp_map)
  }
  
}
