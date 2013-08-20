#'observations - Primary function to retrive observations form iNaturalist
#'@param query Query string
#'@param page page number
#'@param per_page Records per page to download
#'@param maxresults - yet to prgram this
#'@examples \dontrun{
#'  observations(query="Monarch Butterfly",page=2,per_page=25)
#'}
#'@export
observations <- function(query=NA,page=NA,per_page=NA,maxresults=100) 
{  
  url = "http://www.inaturalist.org/observations.csv"
  arg="?"
  if(!is.na(query)){
    arg <- paste(arg, "&q=", gsub(" ","+",query), sep="")
  }
  if(!is.na(page)){
    arg <- paste(arg, "&page=", page, sep="")
  }
  if(!is.na(per_page)){
    arg <- paste(arg, "&per_page=", per_page, sep="")
  }
  #cat(arg)
  cat(paste(url,arg,sep=""))
  out <- read.csv(paste(url,arg,sep=""))
  
  return(out)
}