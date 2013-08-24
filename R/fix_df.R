#' takes a dataframe that's all text and removes NA columns, converts numbers to numeric, and boolean to boolean.
#' @param df a dataframe to fix

fix_df <- function(df){
  torem <- vector()
  for(i in 1:dim(df)[2]){
    if( sum(df[,i] == "TRUE", na.rm=T) > 0 || sum(df[,i]=="FALSE",na.rm=T) > 0 ){
      df[,i] <- as.logical(df[,i])
    } else if(all(is.na(df[,i]))){
      torem <- c(torem,i)
    } else if(any(!is.na(as.numeric(as.character(df[,i]))))){
      df[,i] <- as.numeric(as.character(df[,i]))
    } else if(all(is.factor(df[,i]))){
      df[,i] <- as.character(df[,i])
    }
    
  }
  
  df <- df[,-torem]
  return(df)
}


