#' Plot iNaturalist observations
#'
#' @description Plot observations from iNaturalist. You have the option of automatically plotting, or returning a ggplot map object that you can add layers onto.
#' @param data data frame of iNaturalist observations.
#' @param map the map area to plot, default is USA. See the same \code{map} argument in \code{\link[ggplot2]{map_data}} for available areas.
#' @param subregion the name of the subregion to plot. See the \code{region} argument in \code{\link[ggplot2]{map_data}} for more details.
#' @param plot a logical value. TRUE plots the map object and returns it, and FALSE returns a ggplot object that you can modify and plot later.
#'
#' @return A ggplot map object.
#' @examples \dontrun{
#' m_obs <- get_inat_obs(taxon_name = "Ambystoma maculatum")
#' salamander_map <- inat_map(m_obs, plot = FALSE)
#' ### Now we can modify the returned map
#' salamander_map + borders("state") + theme_bw()
#' }
#' @import maps ggplot2
#' @export

inat_map <- function(data, map = "usa", subregion = ".", plot = TRUE) {
  map_df <- map_data(map, region = subregion)
  base_map <-
    ggplot(map_df, aes(x = long, y = lat)) +
    geom_polygon(aes(group = group), fill = "white", color = "gray40", linewidth = 0.2)
  sp_map <- base_map +
    geom_point(data = data, aes(x = longitude, y = latitude))

  if (plot) {
    print(sp_map)
    return(sp_map)
  } else {
    return(sp_map)
  }
}
