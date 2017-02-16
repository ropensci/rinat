[![Build Status](https://api.travis-ci.org/ropensci/rinat.png)](https://travis-ci.org/ropensci/rinat)
[![Build status](https://ci.appveyor.com/api/projects/status/gv7s9um107bep4na/branch/master)](https://ci.appveyor.com/project/sckott/rinat/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rinat/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rinat?branch=master)

# `rinat`


## Quickstart guide


## About
R wrapper for iNaturalist APIs for accessing the observations. The Detailed documentation of API is available on [iNaturlaist website](http://www.inaturalist.org/pages/api+reference) and is part of our larger species occurence searching packages [SPOCC](http://github.com/ropensci/spocc)


## Install

Install the development version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.


```r
install.packages("devtools")
require(devtools)

install_github("rinat", "ropensci")
library(rinat)
```


## Get observations

__Searching__

_Fuzzy search_

You can search for observations by either common or latin name.  It will search the entire iNaturalist entry, so the search below will return all entries that mention Monarch butterflies, not just entries for Monarchs.


```r
butterflies <- get_inat_obs(query="Monarch Butterfly")
```






Another use for a fuzzy search is searching for a common name or habitat, e.g. searching for all observations that might happen in a vernal pool.  We can then see all the species names found.

```r
library(rinat)

vp_obs <- get_inat_obs(query="vernal pool")
head(vp_obs$Species.guess)
```

```
## NULL
```


_Taxon query_
To return only records for a specific species or taxonomic group, use the taxon option.


```r
## Return just observations in the family Plecoptera
stone_flies <- get_inat_obs(taxon="Plecoptera")

## Return just Monarch Butterfly records
just_butterflies <- get_inat_obs(taxon="Danaus plexippus")
```


_Bounding box search_

You can also search within a bounding box by giving a simple set of coordinates.


```r
## Search by area

bounds <- c(38.44047,-125,40.86652,-121.837)
deer <- get_inat_obs(query="Mule Deer", bounds=bounds)
```

__Other functions__



_Get information and observations by project_

You can get all the observations for a project if you know it's ID or name as an intaturalist slug


```r
## Just get info about a project
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE)
```

```
## 25  Records
## 0
```

```r
## Now get all the observations for that project
vt_crows_obs <- get_inat_obs_project(vt_crows$id,type="observations")
```

```
## 25  Records
## 0-100
```



_Get observation details_

Detailed information about a specific observation can be retrieved by observation ID.  The easiest way to get the ID is from a more general search.


```r
m_obs <- get_inat_obs(query="Monarch Butterfly")
head(get_inat_obs_id(m_obs$Id[1]))
```

```
## Error in parseJSON(txt): lexical error: invalid char in json text.
##                                        <!DOCTYPE html PUBLIC "-//W3C//
##                      (right here) ------^
```

_Get all observations by user_

If you just want all the observations by a user you can download all their observations by user ID.  A word of warning though, this can be quite large (easily into the 1000's)


```r
m_obs <- get_inat_obs(query="Monarch Butterfly")
head(get_inat_obs_user(as.character(m_obs$User.login[1]),maxresults=20))[,1:5]
```

```
## Error in if (total_res == 0) {: argument is of length zero
```

_Stats by taxa_

Basic statistics are available for taxa counts by date, date range, place ID (numeric ID), or user ID (string)


```r
## By date
counts <- get_inat_taxon_stats(date="2010-06-14")
counts
```

```
## $total
## [1] 65
## 
## $species_counts
##   count taxon.id           taxon.name taxon.rank taxon.rank_level
## 1     2    17008      Sayornis phoebe    species               10
## 2     1    11935  Tachycineta bicolor    species               10
## 3     1    51752     Brodiaea elegans    species               10
## 4     1    52851     Arnica discoidea    species               10
## 5     1    81746 Necrophila americana    species               10
##   taxon.default_name.taxon_id taxon.default_name.lexicon
## 1                       17008                    English
## 2                       11935                    English
## 3                       51752                    English
## 4                       52851                    English
## 5                       81746                    English
##   taxon.default_name.is_valid taxon.default_name.id
## 1                        TRUE                 20369
## 2                        TRUE                 14831
## 3                        TRUE                 82256
## 4                        TRUE                148530
## 5                        TRUE                211685
##   taxon.default_name.position taxon.default_name.name
## 1                           0          Eastern Phoebe
## 2                           0            Tree Swallow
## 3                           0        harvest brodiaea
## 4                           0          rayless arnica
## 5                           0 American Carrion Beetle
##   taxon.default_name.created_at taxon.default_name.updated_at
## 1 2008-03-12T23:33:20.000-04:00 2008-03-12T23:33:20.000-04:00
## 2 2008-03-12T23:10:45.000-04:00 2008-03-12T23:10:45.000-04:00
## 3 2009-06-08T03:00:11.000-04:00 2009-06-08T03:00:11.000-04:00
## 4 2011-05-17T23:21:12.000-04:00 2011-05-17T23:21:12.000-04:00
## 5 2011-10-22T07:37:44.842-04:00 2011-10-22T07:37:44.842-04:00
##                                                  taxon.image_url
## 1 http://farm6.staticflickr.com/5009/5346970195_d0eac9966b_s.jpg
## 2   http://farm1.staticflickr.com/177/435466650_1ea6cb197e_s.jpg
## 3 http://farm4.staticflickr.com/3269/2709963753_b800de8900_s.jpg
## 4         http://static.inaturalist.org/photos/122558/square.jpg
## 5 http://farm5.staticflickr.com/4013/4658689710_1a534b47ef_s.jpg
##   taxon.iconic_taxon_name taxon.conservation_status_name
## 1                    Aves                  least_concern
## 2                    Aves                  least_concern
## 3                 Plantae                           <NA>
## 4                 Plantae                           <NA>
## 5                 Insecta                           <NA>
## 
## $rank_counts
## $rank_counts$subspecies
## [1] 2
## 
## $rank_counts$variety
## [1] 1
## 
## $rank_counts$genus
## [1] 4
## 
## $rank_counts$species
## [1] 58
```

```r
## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE)
```

```
## 25  Records
## 0
```

```r
place_counts <- get_inat_taxon_stats(place = vt_crows$place_id)
place_counts
```

```
## $total
## [1] 4730
## 
## $species_counts
##   count taxon.id        taxon.name taxon.rank taxon.rank_level
## 1   521    52391     Pinus strobus    species               10
## 2   493    49005     Quercus rubra    species               10
## 3   417    49202 Fagus grandifolia    species               10
## 4   359    52543    Acer saccharum    species               10
## 5   353    48734  Tsuga canadensis    species               10
##   taxon.default_name.taxon_id taxon.default_name.lexicon
## 1                       52391                    English
## 2                       49005                    English
## 3                       49202                    English
## 4                       52543                    English
## 5                       48734                    English
##   taxon.default_name.is_valid taxon.default_name.id
## 1                        TRUE                 83116
## 2                        TRUE                 78334
## 3                        TRUE                 78629
## 4                        TRUE                 83332
## 5                        TRUE                 77895
##   taxon.default_name.position taxon.default_name.name
## 1                           0      Eastern White Pine
## 2                           0        northern red oak
## 3                           0          American beech
## 4                           0             Sugar Maple
## 5                           0         eastern hemlock
##   taxon.default_name.created_at taxon.default_name.updated_at
## 1 2009-07-14T15:17:36.000-04:00 2012-08-27T06:25:39.412-04:00
## 2 2009-01-09T21:20:56.000-05:00 2013-09-29T07:23:43.168-04:00
## 3 2009-01-21T02:04:08.000-05:00 2014-08-28T16:47:30.188-04:00
## 4 2009-08-07T03:39:49.000-04:00 2012-10-10T22:53:16.669-04:00
## 5 2008-11-17T10:31:09.000-05:00 2014-12-10T18:18:41.735-05:00
##                                                  taxon.image_url
## 1 http://farm4.staticflickr.com/3261/2923651680_b6f373defd_s.jpg
## 2 http://farm4.staticflickr.com/3473/3235731853_5f08927f08_s.jpg
## 3 http://farm4.staticflickr.com/3169/2925868680_201c5c6b06_s.jpg
## 4 http://farm3.staticflickr.com/2244/1539715208_4781bb8f11_s.jpg
## 5 http://farm4.staticflickr.com/3076/2861403736_aef342656f_s.jpg
##   taxon.iconic_taxon_name taxon.conservation_status_name
## 1                 Plantae                  least_concern
## 2                 Plantae                           <NA>
## 3                 Plantae                           <NA>
## 4                 Plantae                           <NA>
## 5                 Plantae                near_threatened
## 
## $rank_counts
## $rank_counts$suborder
## [1] 13
## 
## $rank_counts$subspecies
## [1] 83
## 
## $rank_counts$stateofmatter
## [1] 1
## 
## $rank_counts$subfamily
## [1] 33
## 
## $rank_counts$form
## [1] 5
## 
## $rank_counts$fo
## [1] 1
## 
## $rank_counts$subphylum
## [1] 1
## 
## $rank_counts$phylum
## [1] 11
## 
## $rank_counts$variety
## [1] 30
## 
## $rank_counts$superfamily
## [1] 20
## 
## $rank_counts$subclass
## [1] 4
## 
## $rank_counts$unranked
## [1] 1
## 
## $rank_counts$order
## [1] 55
## 
## $rank_counts$kingdom
## [1] 5
## 
## $rank_counts$tribe
## [1] 17
## 
## $rank_counts$class
## [1] 19
## 
## $rank_counts$infraorder
## [1] 2
## 
## $rank_counts$family
## [1] 203
## 
## $rank_counts$epifamily
## [1] 1
## 
## $rank_counts$genus
## [1] 680
## 
## $rank_counts$hybrid
## [1] 19
## 
## $rank_counts$species
## [1] 3524
## 
## $rank_counts$subtribe
## [1] 2
```

_Stats by user_

Similar statistics can be gotten for users.  The same input parameters can be used, but results are the top five users by species count and observation count.


```r
## By date
counts <- get_inat_user_stats(date="2010-06-14")
counts
```

```
## $total
## [1] 35
## 
## $most_observations
##    count user.id               user.login
## 1     10    9706               greglasley
## 2      4     357                annetanne
## 3      4   10285                  finatic
## 4      3   10946                cgcbosque
## 5      3   64596 juancarlosgarciamorales1
## 6      3   18056                 plantman
## 7      3   38530              kevinhintsa
## 8      3     382                  tsoleau
## 9      3     873                 tapbirds
## 10     3    3403                   davidr
## 11     2   70352                wonder_al
## 12     2    2619                 asnyder5
## 13     2    1000                     muir
## 14     2   12158            erikamitchell
## 15     1   57533      banks_peninsula_tui
## 16     1   31399               sacagewea2
## 17     1    9560       dianaterryhibbitts
## 18     1   11831                  halbyte
## 19     1    5239                 marcellc
## 20     1   10612                    zieak
## 21     1   20727                ciovarnat
## 22     1   16823                 jnstuart
## 23     1     129               field_daze
## 24     1   38442             robertgeorge
## 25     1    2048                   josiah
## 26     1      10                      jam
## 27     1   48178                 asemerdj
## 28     1    3926                pmikejack
## 29     1    4857          c_michael_hogan
## 30     1   65504                scottking
## 31     1     206                lfelliott
## 32     1   13467           paulalongshore
## 33     1   10299               summermule
## 34     1   13167                  arleigh
## 35     1    2839                    hari2
##                                                                user.user_icon_url
## 1    http://www.inaturalist.org/attachments/users/icons/9706-thumb.jpg?1412292583
## 2     http://www.inaturalist.org/attachments/users/icons/357-thumb.jpg?1362061338
## 3   http://www.inaturalist.org/attachments/users/icons/10285-thumb.jpg?1350000458
## 4                                                                            <NA>
## 5   http://www.inaturalist.org/attachments/users/icons/64596-thumb.jpg?1416786295
## 6                                                                            <NA>
## 7   http://www.inaturalist.org/attachments/users/icons/38530-thumb.jpg?1400990725
## 8                http://www.inaturalist.org/attachments/users/icons/382-thumb.jpg
## 9                http://www.inaturalist.org/attachments/users/icons/873-thumb.jpg
## 10   http://www.inaturalist.org/attachments/users/icons/3403-thumb.jpg?1394954695
## 11  http://www.inaturalist.org/attachments/users/icons/70352-thumb.jpg?1421399985
## 12                                                                           <NA>
## 13              http://www.inaturalist.org/attachments/users/icons/1000-thumb.jpg
## 14 http://www.inaturalist.org/attachments/users/icons/12158-thumb.jpeg?1357418870
## 15 http://www.inaturalist.org/attachments/users/icons/57533-thumb.jpeg?1413332307
## 16  http://www.inaturalist.org/attachments/users/icons/31399-thumb.jpg?1398521627
## 17  http://www.inaturalist.org/attachments/users/icons/9560-thumb.jpeg?1351261191
## 18                                                                           <NA>
## 19              http://www.inaturalist.org/attachments/users/icons/5239-thumb.jpg
## 20  http://www.inaturalist.org/attachments/users/icons/10612-thumb.jpg?1375105310
## 21  http://www.inaturalist.org/attachments/users/icons/20727-thumb.jpg?1398894069
## 22  http://www.inaturalist.org/attachments/users/icons/16823-thumb.jpg?1383090510
## 23               http://www.inaturalist.org/attachments/users/icons/129-thumb.jpg
## 24  http://www.inaturalist.org/attachments/users/icons/38442-thumb.jpg?1400160213
## 25              http://www.inaturalist.org/attachments/users/icons/2048-thumb.jpg
## 26                                                                           <NA>
## 27  http://www.inaturalist.org/attachments/users/icons/48178-thumb.jpg?1416364944
## 28              http://www.inaturalist.org/attachments/users/icons/3926-thumb.jpg
## 29              http://www.inaturalist.org/attachments/users/icons/4857-thumb.jpg
## 30  http://www.inaturalist.org/attachments/users/icons/65504-thumb.jpg?1417720839
## 31               http://www.inaturalist.org/attachments/users/icons/206-thumb.jpg
## 32 http://www.inaturalist.org/attachments/users/icons/13467-thumb.jpeg?1361747141
## 33  http://www.inaturalist.org/attachments/users/icons/10299-thumb.jpg?1350591832
## 34  http://www.inaturalist.org/attachments/users/icons/13167-thumb.jpg?1361106538
## 35   http://www.inaturalist.org/attachments/users/icons/2839-thumb.jpg?1398943785
## 
## $most_species
##    count user.id               user.login
## 1     10    9706               greglasley
## 2      4   10285                  finatic
## 3      3     873                 tapbirds
## 4      3    3403                   davidr
## 5      3   64596 juancarlosgarciamorales1
## 6      3   18056                 plantman
## 7      3     382                  tsoleau
## 8      3   38530              kevinhintsa
## 9      2   70352                wonder_al
## 10     2    1000                     muir
## 11     2    2619                 asnyder5
## 12     2     357                annetanne
## 13     1   10299               summermule
## 14     1   13167                  arleigh
## 15     1    2839                    hari2
## 16     1   57533      banks_peninsula_tui
## 17     1   31399               sacagewea2
## 18     1    9560       dianaterryhibbitts
## 19     1    5239                 marcellc
## 20     1   11831                  halbyte
## 21     1     129               field_daze
## 22     1   10612                    zieak
## 23     1   20727                ciovarnat
## 24     1   38442             robertgeorge
## 25     1   16823                 jnstuart
## 26     1    2048                   josiah
## 27     1      10                      jam
## 28     1    3926                pmikejack
## 29     1   48178                 asemerdj
## 30     1    4857          c_michael_hogan
## 31     1   65504                scottking
## 32     1   12158            erikamitchell
## 33     1   13467           paulalongshore
##                                                                user.user_icon_url
## 1    http://www.inaturalist.org/attachments/users/icons/9706-thumb.jpg?1412292583
## 2   http://www.inaturalist.org/attachments/users/icons/10285-thumb.jpg?1350000458
## 3                http://www.inaturalist.org/attachments/users/icons/873-thumb.jpg
## 4    http://www.inaturalist.org/attachments/users/icons/3403-thumb.jpg?1394954695
## 5   http://www.inaturalist.org/attachments/users/icons/64596-thumb.jpg?1416786295
## 6                                                                            <NA>
## 7                http://www.inaturalist.org/attachments/users/icons/382-thumb.jpg
## 8   http://www.inaturalist.org/attachments/users/icons/38530-thumb.jpg?1400990725
## 9   http://www.inaturalist.org/attachments/users/icons/70352-thumb.jpg?1421399985
## 10              http://www.inaturalist.org/attachments/users/icons/1000-thumb.jpg
## 11                                                                           <NA>
## 12    http://www.inaturalist.org/attachments/users/icons/357-thumb.jpg?1362061338
## 13  http://www.inaturalist.org/attachments/users/icons/10299-thumb.jpg?1350591832
## 14  http://www.inaturalist.org/attachments/users/icons/13167-thumb.jpg?1361106538
## 15   http://www.inaturalist.org/attachments/users/icons/2839-thumb.jpg?1398943785
## 16 http://www.inaturalist.org/attachments/users/icons/57533-thumb.jpeg?1413332307
## 17  http://www.inaturalist.org/attachments/users/icons/31399-thumb.jpg?1398521627
## 18  http://www.inaturalist.org/attachments/users/icons/9560-thumb.jpeg?1351261191
## 19              http://www.inaturalist.org/attachments/users/icons/5239-thumb.jpg
## 20                                                                           <NA>
## 21               http://www.inaturalist.org/attachments/users/icons/129-thumb.jpg
## 22  http://www.inaturalist.org/attachments/users/icons/10612-thumb.jpg?1375105310
## 23  http://www.inaturalist.org/attachments/users/icons/20727-thumb.jpg?1398894069
## 24  http://www.inaturalist.org/attachments/users/icons/38442-thumb.jpg?1400160213
## 25  http://www.inaturalist.org/attachments/users/icons/16823-thumb.jpg?1383090510
## 26              http://www.inaturalist.org/attachments/users/icons/2048-thumb.jpg
## 27                                                                           <NA>
## 28              http://www.inaturalist.org/attachments/users/icons/3926-thumb.jpg
## 29  http://www.inaturalist.org/attachments/users/icons/48178-thumb.jpg?1416364944
## 30              http://www.inaturalist.org/attachments/users/icons/4857-thumb.jpg
## 31  http://www.inaturalist.org/attachments/users/icons/65504-thumb.jpg?1417720839
## 32 http://www.inaturalist.org/attachments/users/icons/12158-thumb.jpeg?1357418870
## 33 http://www.inaturalist.org/attachments/users/icons/13467-thumb.jpeg?1361747141
```

```r
## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE)
```

```
## 25  Records
## 0
```

```r
place_counts <- get_inat_user_stats(place = vt_crows$place_id)
head(place_counts$most_observations)
```

```
##   count user.id    user.login
## 1  8022    2179       charlie
## 2  4464   12610  susanelliott
## 3  3278   12036         zcota
## 4  3187   12158 erikamitchell
## 5  3121   11792     kylejones
## 6  2751     317   kpmcfarland
##                                                               user.user_icon_url
## 1   http://www.inaturalist.org/attachments/users/icons/2179-thumb.jpg?1416962625
## 2  http://www.inaturalist.org/attachments/users/icons/12610-thumb.jpg?1390441055
## 3  http://www.inaturalist.org/attachments/users/icons/12036-thumb.jpg?1387504441
## 4 http://www.inaturalist.org/attachments/users/icons/12158-thumb.jpeg?1357418870
## 5  http://www.inaturalist.org/attachments/users/icons/11792-thumb.jpg?1394793142
## 6    http://www.inaturalist.org/attachments/users/icons/317-thumb.jpg?1373935791
```

## Mapping.

Basic maps can be created as well to quickly visualize search results.  Maps can either be plotted automatically `plot = TRUE` or simply return a ggplot2 object with `plot = FALSE`.  This works well with single species data, but more complicated plots are best made from scratch.


```r
library(rinat)
library(ggplot2)

## Map salamanders in the genuse Ambystoma
m_obs <- get_inat_obs(taxon="Ambystoma maculatum")

salamander_map <- inat_map(m_obs,plot=FALSE)
### Now we can modify the returned map
salamander_map + borders("state") + theme_bw()
```

```
## Error in eval(expr, envir, enclos): object 'Longitude' not found
```

---
  
This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to ecoengine unless your needs are limited to this single source.    

---

[![ropensci footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

