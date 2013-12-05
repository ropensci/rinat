 [![Build Status](https://api.travis-ci.org/ropensci/rinat.png)](https://travis-ci.org/ropensci/rinat)

# `riNat`


## Quickstart guide
 
 
## About
R wrapper for iNaturalist APIs for accessing the observations. The Detailed documentation of API is available on [iNaturlaist website](http://www.inaturalist.org/pages/api+reference) 



## Install

Install the development version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```coffee
install.packages("devtools")
require(devtools)

install_github("rinat", "ropensci")
require(rinat)
```


#### Get observations

__Searching__

You can search for observations by either common or latin name.  It will search the entire iNaturalist entry, so the search below will return all entries that mention Monarch butterflies, not just entries for Monarchs.

```coffee
butterflies <- get_obs_inat(query="Monarch Butterfly")
```

To return only records for a specific species or taxonomic group, use the taxon option.

```coffee
## Return just observations in the family Plecoptera
stone_flies <- get_obs_inat(taxon="Plecoptera")

## Return just Monarch Butterfly records
just_butterflies <- get_obs_inat(taxon="Danaus plexippus")
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
