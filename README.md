[![Build
Status](https://api.travis-ci.org/ropensci/rinat.png)](https://travis-ci.org/ropensci/rinat)
[![Build
status](https://ci.appveyor.com/api/projects/status/gv7s9um107bep4na/branch/master)](https://ci.appveyor.com/project/sckott/rinat/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rinat/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rinat?branch=master)
[![](https://cranlogs.r-pkg.org/badges/grand-total/rinat)](http://cran.rstudio.com/web/packages/rinat/index.html)

About
-----

R wrapper for iNaturalist APIs for accessing the observations. The
detailed documentation of API is available on [iNaturalist
website](http://www.inaturalist.org/pages/api+reference) and is part of
our larger species occurrence searching packages
[SPOCC](http://github.com/ropensci/spocc).

Quickstart guide
----------------

### Get observations

#### Fuzzy search

You can search for observations by either common or latin name. It will
search the entire iNaturalist entry, so the search below will return all
entries that mention Monarch butterflies, not just entries for Monarchs.

    library(rinat)

    butterflies <- get_inat_obs(query = "Monarch Butterfly")

Another use for a fuzzy search is searching for a common name or
habitat, e.g. searching for all observations that might happen in a
vernal pool. We can then see all the species names found.

    vp_obs <- get_inat_obs(query = "vernal pool")
    head(vp_obs$species_guess)

    ## [1] "spatterdock"          "Spotted Salamander"   "Green Frog"          
    ## [4] "Eastern Spadefoot"    "Wood Frog"            "Rhizomnium punctatum"

#### Taxon query

To return only records for a specific species or taxonomic group, use
the taxon option.

    ## Return just observations in the family Nymphalidae
    nymphalidae <- get_inat_obs(taxon_name  = "Nymphalidae", year = 2020)

    ## Return just Monarch Butterfly records
    just_butterflies <- get_inat_obs(taxon_name = "Danaus plexippus")

#### Bounding box search

You can also search within a bounding box by giving a simple set of
coordinates.

    ## Search by area

    bounds <- c(38.44047, -125, 40.86652, -121.837)
    deer <- get_inat_obs(query = "Mule Deer", bounds = bounds)

### Other functions

#### Get information and observations by project

You can get all the observations for a project if you know its ID or
name as an iNaturalist slug.

    ## Just get info about a project
    vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)

    ## 177  Records

    ## Now get all the observations for that project
    vt_crows_obs <- get_inat_obs_project(vt_crows$id, type = "observations")

    ## 177  Records
    ## 0-200

#### Get observation details

Detailed information about a specific observation can be retrieved by
observation ID. The easiest way to get the ID is from a more general
search.

    m_obs <- get_inat_obs(query = "Monarch Butterfly")
    head(get_inat_obs_id(m_obs$id[1]))

    ## $id
    ## [1] 52325884
    ## 
    ## $observed_on
    ## [1] "2020-06-29"
    ## 
    ## $description
    ## NULL
    ## 
    ## $latitude
    ## [1] "39.897534445"
    ## 
    ## $longitude
    ## [1] "-105.2221506277"
    ## 
    ## $map_scale
    ## NULL

#### Get all observations by user

If you just want all the observations by a user you can download all
their observations by user ID. A word of warning though, this can be
quite large (easily into the 1000’s).

    m_obs <- get_inat_obs(query = "Monarch Butterfly")
    head(get_inat_obs_user(as.character(m_obs$user_login[1]), maxresults = 20))[,1:5]

    ##        scientific_name                  datetime description
    ## 1       Vanessa cardui 2020-07-02 09:14:00 -0600            
    ## 2     Vanessa atalanta 2020-07-02 09:11:00 -0600            
    ## 3     Vanessa atalanta 2020-07-02 09:10:00 -0600            
    ## 4 Papilio multicaudata 2020-07-02 09:40:00 -0600            
    ## 5  Icaricia icarioides 2020-07-02 09:59:00 -0600            
    ## 6 Papilio multicaudata 2020-07-02 09:39:00 -0600            
    ##             place_guess latitude
    ## 1 Adams County, CO, USA 39.79939
    ## 2 Adams County, CO, USA 39.79940
    ## 3 Adams County, CO, USA 39.79943
    ## 4 Adams County, CO, USA 39.79871
    ## 5 Adams County, CO, USA 39.80964
    ## 6 Adams County, CO, USA 39.79870

#### Stats by taxa

Basic statistics are available for taxa counts by date, date range,
place ID (numeric ID), or user ID (string).

    ## By date
    counts <- get_inat_taxon_stats(date = "2010-06-14")
    print(counts$total)

    ## [1] 589

    print(counts$species_counts[1:5,])

    ##   count taxon.id             taxon.name taxon.rank taxon.rank_level
    ## 1     5    41708         Phoca vitulina    species               10
    ## 2     5    57495        Melitaea cinxia    species               10
    ## 3     4     8229    Cyanocitta cristata    species               10
    ## 4     4    14995 Dumetella carolinensis    species               10
    ## 5     4    47980        Speyeria cybele    species               10
    ##   taxon.default_name.id   taxon.default_name.name taxon.default_name.is_valid
    ## 1                131201               Common Seal                        TRUE
    ## 2                 91278      Glanville Fritillary                        TRUE
    ## 3                912596                  Blue Jay                        TRUE
    ## 4                 18116              Gray Catbird                        TRUE
    ## 5                 76800 Great Spangled Fritillary                        TRUE
    ##   taxon.default_name.lexicon taxon.default_name.taxon_id
    ## 1                    English                       41708
    ## 2                    English                       57495
    ## 3                    English                        8229
    ## 4                    English                       14995
    ## 5                    English                       47980
    ##   taxon.default_name.created_at taxon.default_name.updated_at
    ## 1      2011-05-18T03:04:19.000Z      2020-02-23T03:44:55.002Z
    ## 2      2010-03-17T06:57:02.000Z      2010-03-17T06:57:02.000Z
    ## 3      2017-04-21T00:19:26.303Z      2020-01-16T09:10:54.451Z
    ## 4      2008-03-13T03:23:49.000Z      2020-01-16T09:15:06.013Z
    ## 5      2008-07-26T00:10:01.000Z      2008-07-26T00:10:01.000Z
    ##   taxon.default_name.creator_id taxon.default_name.position
    ## 1                            NA                           0
    ## 2                            NA                           0
    ## 3                         17932                           0
    ## 4                            NA                           0
    ## 5                            NA                           0
    ##                                                       taxon.image_url
    ## 1 https://static.inaturalist.org/photos/3238907/square.jpg?1459150554
    ## 2 https://static.inaturalist.org/photos/5403994/square.jpg?1545659971
    ## 3    https://static.inaturalist.org/photos/1150/square.jpg?1545367741
    ## 4   https://static.inaturalist.org/photos/13786/square.jpg?1545400835
    ## 5  https://static.inaturalist.org/photos/480076/square.JPG?1377990891
    ##   taxon.iconic_taxon_name taxon.conservation_status_name
    ## 1                Mammalia                  least_concern
    ## 2                 Insecta                           <NA>
    ## 3                    Aves                  least_concern
    ## 4                    Aves                  least_concern
    ## 5                 Insecta                           <NA>

    print(counts$rank_counts)

    ## $species
    ## [1] 495
    ## 
    ## $genus
    ## [1] 37
    ## 
    ## $subspecies
    ## [1] 27
    ## 
    ## $family
    ## [1] 12
    ## 
    ## $variety
    ## [1] 6
    ## 
    ## $subfamily
    ## [1] 3
    ## 
    ## $kingdom
    ## [1] 2
    ## 
    ## $order
    ## [1] 2
    ## 
    ## $phylum
    ## [1] 2
    ## 
    ## $class
    ## [1] 1
    ## 
    ## $infraorder
    ## [1] 1
    ## 
    ## $tribe
    ## [1] 1

#### Stats by user

Similar statistics can be gotten for users. The same input parameters
can be used, but results are the top five users by species count and
observation count.

    ## By date
    counts <- get_inat_user_stats(date = "2010-06-14")
    print(counts$total)

    ## [1] 222

    print(counts$most_observations[1:10,])

    ##    count user.id      user.login              user.name
    ## 1     53  811118     sandbankspp                       
    ## 2     34  541847      billhubick            Bill Hubick
    ## 3     25   46945             abe           T. Abe Lloyd
    ## 4     25  761669 kathleenfspicer                   <NA>
    ## 5     21    2616     alice_abela            Alice Abela
    ## 6     21  495266        maxa11an    Max Allan Niklasson
    ## 7     20  922078        hakai470 ES470: Hakai Institute
    ## 8     19 1588724         jrcagle                       
    ## 9     12  357375     richardling           Richard Ling
    ## 10    12  522214      tdavenport        Tripp Davenport
    ##                                                                     user.user_icon_url
    ## 1  https://static.inaturalist.org/attachments/users/icons/811118/thumb.jpeg?1535236899
    ## 2   https://static.inaturalist.org/attachments/users/icons/541847/thumb.jpg?1582771190
    ## 3    https://static.inaturalist.org/attachments/users/icons/46945/thumb.jpg?1475588685
    ## 4                                                                                 <NA>
    ## 5     https://static.inaturalist.org/attachments/users/icons/2616/thumb.jpg?1475528533
    ## 6  https://static.inaturalist.org/attachments/users/icons/495266/thumb.jpeg?1579782546
    ## 7                                                                                 <NA>
    ## 8  https://static.inaturalist.org/attachments/users/icons/1588724/thumb.jpg?1566852095
    ## 9   https://static.inaturalist.org/attachments/users/icons/357375/thumb.jpg?1484462740
    ## 10  https://static.inaturalist.org/attachments/users/icons/522214/thumb.jpg?1558671195

    print(counts$most_species[1:10,])

    ##    count user.id      user.login              user.name
    ## 1     47  811118     sandbankspp                       
    ## 2     24  761669 kathleenfspicer                   <NA>
    ## 3     19   46945             abe           T. Abe Lloyd
    ## 4     17    2616     alice_abela            Alice Abela
    ## 5     17  495266        maxa11an    Max Allan Niklasson
    ## 6     17  541847      billhubick            Bill Hubick
    ## 7     14  922078        hakai470 ES470: Hakai Institute
    ## 8     14 1588724         jrcagle                       
    ## 9     10    9706      greglasley            Greg Lasley
    ## 10    10  357375     richardling           Richard Ling
    ##                                                                     user.user_icon_url
    ## 1  https://static.inaturalist.org/attachments/users/icons/811118/thumb.jpeg?1535236899
    ## 2                                                                                 <NA>
    ## 3    https://static.inaturalist.org/attachments/users/icons/46945/thumb.jpg?1475588685
    ## 4     https://static.inaturalist.org/attachments/users/icons/2616/thumb.jpg?1475528533
    ## 5  https://static.inaturalist.org/attachments/users/icons/495266/thumb.jpeg?1579782546
    ## 6   https://static.inaturalist.org/attachments/users/icons/541847/thumb.jpg?1582771190
    ## 7                                                                                 <NA>
    ## 8  https://static.inaturalist.org/attachments/users/icons/1588724/thumb.jpg?1566852095
    ## 9     https://static.inaturalist.org/attachments/users/icons/9706/thumb.jpg?1533329961
    ## 10  https://static.inaturalist.org/attachments/users/icons/357375/thumb.jpg?1484462740

    ## By place_ID
    vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)

    ## 177  Records

    place_counts <- get_inat_user_stats(place = vt_crows$place_id)
    print(place_counts$total)

    ## [1] 9637

    print(place_counts$most_observations[1:10,])

    ##    count user.id    user.login      user.name
    ## 1  52470   12158 erikamitchell Erika Mitchell
    ## 2  34783    2179       charlie   Charlie Hohn
    ## 3  16233   12610  susanelliott  Susan Elliott
    ## 4   9898   12045      larry522 Larry Clarfeld
    ## 5   8643   12036       zaccota       Zac Cota
    ## 6   7838  108365     judywelna               
    ## 7   7473     317   kpmcfarland Kent McFarland
    ## 8   7228    6624   joannerusso               
    ## 9   7188   28921         rwp84    roy pilcher
    ## 10  7058   13355        beeboy  Spencer Hardy
    ##                                                                    user.user_icon_url
    ## 1   https://static.inaturalist.org/attachments/users/icons/12158/thumb.jpg?1586465563
    ## 2    https://static.inaturalist.org/attachments/users/icons/2179/thumb.jpg?1569109298
    ## 3   https://static.inaturalist.org/attachments/users/icons/12610/thumb.jpg?1475533475
    ## 4   https://static.inaturalist.org/attachments/users/icons/12045/thumb.jpg?1475533238
    ## 5   https://static.inaturalist.org/attachments/users/icons/12036/thumb.jpg?1475533232
    ## 6  https://static.inaturalist.org/attachments/users/icons/108365/thumb.jpg?1475547470
    ## 7     https://static.inaturalist.org/attachments/users/icons/317/thumb.jpg?1475527502
    ## 8   https://static.inaturalist.org/attachments/users/icons/6624/thumb.jpeg?1562532360
    ## 9   https://static.inaturalist.org/attachments/users/icons/28921/thumb.jpg?1588726887
    ## 10  https://static.inaturalist.org/attachments/users/icons/13355/thumb.jpg?1475533838

    print(place_counts$most_species[1:10,])

    ##    count user.id          user.login           user.name
    ## 1   2704   12158       erikamitchell      Erika Mitchell
    ## 2   2217   12045            larry522      Larry Clarfeld
    ## 3   2176   12610        susanelliott       Susan Elliott
    ## 4   1829    2179             charlie        Charlie Hohn
    ## 5   1677    6624         joannerusso                    
    ## 6   1487 1088797 montpelierbioblitz1 Montpelier BioBlitz
    ## 7   1474   11792           kylejones          Kyle Jones
    ## 8   1426   13355              beeboy       Spencer Hardy
    ## 9   1352  108365           judywelna                    
    ## 10  1350     317         kpmcfarland      Kent McFarland
    ##                                                                    user.user_icon_url
    ## 1   https://static.inaturalist.org/attachments/users/icons/12158/thumb.jpg?1586465563
    ## 2   https://static.inaturalist.org/attachments/users/icons/12045/thumb.jpg?1475533238
    ## 3   https://static.inaturalist.org/attachments/users/icons/12610/thumb.jpg?1475533475
    ## 4    https://static.inaturalist.org/attachments/users/icons/2179/thumb.jpg?1569109298
    ## 5   https://static.inaturalist.org/attachments/users/icons/6624/thumb.jpeg?1562532360
    ## 6                                                                                <NA>
    ## 7   https://static.inaturalist.org/attachments/users/icons/11792/thumb.jpg?1475533125
    ## 8   https://static.inaturalist.org/attachments/users/icons/13355/thumb.jpg?1475533838
    ## 9  https://static.inaturalist.org/attachments/users/icons/108365/thumb.jpg?1475547470
    ## 10    https://static.inaturalist.org/attachments/users/icons/317/thumb.jpg?1475527502

### Mapping

Basic maps can be created as well to quickly visualize search results.
Maps can either be plotted automatically `plot = TRUE` or simply return
a ggplot2 object with `plot = FALSE`. This works well with single
species data, but more complicated plots are best made from scratch.

    library(ggplot2)

    ## Map salamanders in the genuse Ambystoma
    m_obs <- get_inat_obs(taxon_name = "Ambystoma maculatum")

    salamander_map <- inat_map(m_obs, plot = FALSE)
    ### Now we can modify the returned map
    salamander_map + borders("state") + theme_bw()

    ## Warning: Removed 5 rows containing missing values (geom_point).

<img src="README_files/figure-markdown_strict/unnamed-chunk-14-1.png" width="672" />

------------------------------------------------------------------------

[![](http://ropensci.org/public_images/github_footer.png)](https://ropensci.org/)
