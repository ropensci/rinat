#' Simply flattens a list with lots of structure into a usable dataframe with ldply 
#' @param x a list to be flattened, returned from content(GET(json))
flatten_list <- function(x){
  return(t(data.frame(unlist(x))))
}
