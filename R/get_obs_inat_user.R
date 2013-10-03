#' Get all the observations of a specific user
#' @param id a single id for an inaturalist observation record
#' @return a list with full details on a given record
#' @examples \dontrun{
#'   m_obs <- get_obs_inat(query="Monarch Butterfly")
#'   get_obs_inat_id(m_obs$Id[1])
#' }
#' @import httr plyr
#' @export


### Needs more work, there can be 1000's of results, need to implement pagination similar to the main observation query method.
get_obs_inat_user <- function(username){
  
  base_url <- "http://www.inaturalist.org/"
  q_path <- "observations.csv"
  ping_path <- "observations.json"
  ping_query <- paste(search,"&per_page=1&page=1",sep="")
  ### Make the first ping to the server to get the number of results
  ### easier to pull down if you make the query in json, but easier to arrange results
  ### that come down in CSV format
  ping <-  GET(base_url,path = ping_path, query = ping_query)
  total_res <- as.numeric(ping$headers$`x-total-entries`)
  
  if(total_res == 0){
    stop("Your search returned zero results.  Either your species of interest has no records or you entered an invalid search")
  }
  
  
  
  page_query <- paste(search,"&per_page=200&page=1",sep="")
  data <-  GET(base_url,path = q_path, query = page_query)
  data_out <-read.csv(textConnection(content(data)))
  if(maxresults > 200){
    for(i in 2:ceiling(total_res/200)){
      page_query <- paste(search,"&per_page=200&page=",i,sep="")
      data <-  GET(base_url,path = q_path, query = page_query)
      data_out <- rbind(data_out, read.csv(textConnection(content(data))))
    }
    
  }
  
  if(maxresults < dim(data_out)[1]){
    data_out <- data_out[1:maxresults,]
  }
  
  return(data_out)
}