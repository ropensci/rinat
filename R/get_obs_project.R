#' Download observations and info for a project
#'@description retrieve observations from a particular iNaturalist project.  This function can be used to get either observations from a project, or info about a project
#'@param grpid Name of the group as an iNaturalist slug or group id
#'@param type Either "observations" or "info"  Observations returns all observations, and "info" returns project details similar to what you can find on a project webpage.
#'@details An iNaturalist slug is usually the project as single string with words seperated by hyphens. For instance, the project "State Flowers of the United States" has a slug of "state-flowers-of-the-united-states-eol-collection".  This can be extracted from the URL for the project usually. The state flowers project has the following URL http://www.inaturalist.org/projects/state-flowers-of-the-united-states-eol-collection
#'@examples \dontrun{
#'  get_obs_project(354, type = "observations")
#'  get_obs_project("crows-in-vermont", type="info") 
#'}
#'@import httr
#'@export

get_obs_project <- function(grpid,type = c("observations","info")){
  argstring = switch(match.arg(type),
         observations = "obs",
         info = "info")
  url= paste("http://www.inaturalist.org/projects/",grpid,".json",sep="")
  xx = content(GET(url))
  recs = xx$project_observations_count
 
  ### Error handling for empty projects
  dat = NULL
  if(is.null(recs))(return(dat))
  cat(paste(recs," Records\n0"))
  
  
  if(argstring == "info"){
    return(xx)
  } else if(argstring == "obs"){
  
  if (recs %% 100 == 0){loopval<-recs %/% 100}
  else{loopval <-(recs %/% 100)+1}
  for(i in 1:loopval){
    url1=paste("http://www.inaturalist.org/observations/project/",grpid,".csv?page=",i,"&per_page=100",sep="")
    cat(paste("-",i*100,sep=""))
    newdat=read.csv(url1)
    dat=rbind(dat,newdat)
  }
  return(dat)
}
  
}
