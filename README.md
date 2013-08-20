# `riNat`


## About
R wrapper for iNaturalist APIs for accessing the observations. The Detailed documentation of API is available on [iNaturlaist website](http://www.inaturalist.org/pages/api+reference) 

## Install

### Install the development version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```R
install.packages("devtools")
require(devtools)

install_github("rinat", "vijaybarve")
require(rinat)
```

Note: 

Windows users have to first install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

### Packages `bdvis` depends on
+ nothing right now


### Functions currently available

#### observations

```coffee
observations(query="Monarch Butterfly",page=2,per_page=25)
```

