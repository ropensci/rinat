#' get_obs_inat - Primary function to retrive observations from iNaturalist
#' @param query Query string
#' @param maxresults - 
#' @examples \dontrun{
#'   get_obs(query="Monarch Butterfly")
#' }
#' @import httr plyr
#' @export



get_obs_inat <- function(query=NULL,maxresults=100) 
{  
  base_url <- "http://www.inaturalist.org/"
  q_path <- "observations.json"
  search <- paste("&q=",gsub(" ","+",query),sep="")
  data_list <- list()
  ### Make the first ping to the server to get the number of results
  if(maxresults > 200){
    page_query <- paste(search,"&per_page=200&page=1",sep="")
    data <-  GET(base_url,path = q_path, query = page_query)
    total_res <- as.numeric(data$headers$`x-total-entries`)
    ### add rnat::
    data_list[[1]] <- fix_df(ldply(content(data,as = "parsed"),flatten_list))
      for(i in 2:ceiling(total_res/200)){
        page_query <- paste(search,"&per_page=200&page=",i,sep="")
        data <-  GET(base_url,path = q_path, query = page_query)
        ### add rnat::
        data_list[[i]] <- fix_df(ldply(content(data,as = "parsed"),flatten_list))
      }
    
  
  }
  
 
  return(out)
}
