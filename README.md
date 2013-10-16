# `riNat`


## About
R wrapper for iNaturalist APIs for accessing the observations. The Detailed documentation of API is available on [iNaturlaist website](http://www.inaturalist.org/pages/api+reference) 

## Install

### Install the development version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```R
install.packages("devtools")
require(devtools)

install_github("rinat", "ropensci")
require(rinat)
```

Note: 

This package is currently in development.

Windows users have to first install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

#### observations

```coffee
get_obs(query="Monarch Butterfly")
```

#### Projects
```coffee
get_obs_project(354)
get_obs_project("reptileindia") 
```
