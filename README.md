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


#### Get observations

__Query__

Querying allows you to search for observations by either common or latin name.  It will search the entire iNaturalist entry, so the search below will return all entries that mention Monarch butterflies, not just entries for Monarchs.

```coffee
get_obs_inat(query="Monarch Butterfly")
```

Another use case might be by searching for a common name or habitat, e.g. searching for all observations that might happen in a vernal pool.  We can then see all the species names found.  

```coffee
vp_obs <- get_obs_inat(query="vernal pool")
vp_obs$Species.guess
```

#### Projects

```coffee
get_obs_project(354)
get_obs_project("reptileindia") 
```
