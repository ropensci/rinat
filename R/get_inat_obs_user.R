#' Download observations for a user
#' 
#' @description Get all the observations of a specific inaturalist user
#' @param username Username of the inaturalist user to fetch records
#' @param maxresults the maximum number of results to return
#' @return a list with full details on a given record
#' @examples \dontrun{
#'   m_obs <- get_inat_obs(query="Monarch Butterfly")
#'   get_inat_obs_user(as.character(m_obs$User.login[1]))
#' }
#' @import httr plyr jsonlite
#' @export


get_inat_obs_user <- function(username,maxresults=100){
  
  base_url <- "http://www.inaturalist.org/"
  q_path <- paste(username,".csv",sep="")
  ping_path <- paste(username,".json",sep="")
  
  ping_query <- paste("&per_page=1&page=1",sep="")
  ### Make the first ping to the server to get the number of results
  ### easier to pull down if you make the query in json, but easier to arrange results
  ### that come down in CSV format
  ping <-  GET(base_url,path = paste("observations/",ping_path,sep=""), query = ping_query)
  total_res <- as.numeric(ping$headers$`x-total-entries`)
  
  if(total_res == 0){
    stop("Your search returned zero results.  Perhaps your user does not exist")
  }
  page_query <-"&per_page=200&page=1"
  dat <-  GET(base_url,path = paste("observations/",q_path,sep=""), query = page_query)
  data_out <- read.csv(textConnection(content(dat, as = "text")))
  if(maxresults > 200){
    for(i in 2:ceiling(total_res/200)){
      page_query <- paste("&per_page=200&page=",i,sep="")
      dat <-  GET(base_url,path = paste("observations/",q_path,sep=""), query = page_query)
      data_out <- rbind(data_out, read.csv(textConnection(content(dat, as = "text"))))
    }
    
  }
  
  if(maxresults < dim(data_out)[1]){
    data_out <- data_out[1:maxresults,]
  }
  
  return(data_out)
}