#'get_obs_project - function to retrive observations from a perticular 
#'  iNaturalist project.
#'@param grpid Name of the group or group id
#'@examples \dontrun{
#'  get_obs_project(354)
#'  get_obs_project("reptileindia") 
#'}
#'@import RCurl rjson
#'@export
get_obs_project <- function(grpid){
  url= paste("http://www.inaturalist.org/projects/",grpid,".json",sep="")
  xx=getURL(url,.opts=curlOptions(followlocation=TRUE))
  xx1=fromJSON(xx)
  recs=xx1$project_observations_count
  dat=NULL
  if(is.null(recs))(return(dat))
  cat(paste(recs," Records\n0"))
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
