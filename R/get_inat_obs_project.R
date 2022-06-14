#' Download observations or info from a project
#' 
#' Retrieve observations from a particular iNaturalist project. This function can be used to get either observations or information from a project by project name or ID.
#' 
#' @param grpid Name of the group as an iNaturalist slug or group ID.
#' @param type Character, either "observations" or "info". "observations" returns all observations, and "info" returns project details similar to what you can find on a project's page.
#' @param raw Logical. If TRUE and searching for project info, returns the raw output of parsed JSON for that project. Otherwise just some basic information is returned as a list.
#' @details An iNaturalist slug is usually the project name as a single string with words separated by hyphens. For instance, the project "World Oceans Week 2022" has a slug of "world-oceans-week-2022", which you can find by searching projects on iNaturalist and looking at the \href{https://www.inaturalist.org/projects/world-oceans-week-2022}{project's page's URL}.
#'
#' @examples \dontrun{
#'  get_inat_obs_project(354, type = "observations")
#'  get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE)
#'}
#' @import httr jsonlite
#' @importFrom curl has_internet
#' @export

get_inat_obs_project <- function(grpid, type = c("observations", "info"), raw = FALSE) {
  
  # check Internet connection
  if (!curl::has_internet()) {
    message("No Internet connection.")
    return(invisible(NULL))
  }
  
  base_url <- "http://www.inaturalist.org/"
  # check that iNat can be reached
  if (httr::http_error(base_url)) { # TRUE: 400 or above
    message("iNaturalist API is unavailable.")
    return(invisible(NULL))
  }
  
  argstring <- switch(match.arg(type),
                      observations = "obs",
                      info = "info")
  
  url <- paste0(base_url, "projects/", grpid, ".json")
  xx <- fromJSON(content(GET(url), as = "text"))
  recs <- xx$project_observations_count

  ### Error handling for empty projects
  dat <- NULL
  if(is.null(recs))(return(dat))
  message(paste(recs,"records\n"))

  if(argstring == "info"){
    output <- list()
    output[["title"]] <- xx$title
    output[["description"]] <- xx$description
    output[["slug"]] <- xx$slug
    output[["created_at"]] <- xx$created_at
    output[["id"]] <- xx$id
    output[["location"]] <- c(as.numeric(xx$lat),as.numeric(xx$long))
    output[["place_id"]] <- xx$place_id
    output[["taxa_number"]] <- xx$observed_taxa_count
    output[["taxa_count"]] <- xx$project_observations_count
    if(raw){
      output[["raw"]] <- xx
    }
    return(output)
  } else if (argstring == "obs") {
    per_page <- 200
    if (recs %% per_page == 0) {
      loopval <- recs %/% per_page
    }
    if (recs >= 10000) {
      warning(
        "Number of observations in project greater than current API limit.\nReturning the first 10000.\n"
      )
      loopval <- 10000 / per_page
    } else {
      loopval <- (recs %/% per_page) + 1
    }
    obs_list <- vector("list", loopval)
    for (i in 1:loopval) {
      url1 <-
        paste0(
          base_url, "observations/project/", grpid,
          ".json?page=", i,
          "&per_page=", per_page
        )
      if (i == 1) {
        message(paste0("Getting records 0-", per_page))
      }
      if (i > 1) {
        message(paste0("Getting records up to ", i * per_page))
      }
      obs_list[[i]] <-
        fromJSON(content(GET(url1), as = "text"), flatten = TRUE)
    }
    message("Done.\n")
    # remove empty results, in case of mismatch between info and reality
    # (problem has been observed)
    if (length(obs_list[[loopval]]) == 0) {
      obs_list[[i]] <- NULL
    }
    project_obs <- do.call("rbind.fill", obs_list)
    if (recs != nrow(project_obs)) {
      message("Note: mismatch between number of observations reported and returned by the API.")
    }
    return(project_obs)
  }
}
