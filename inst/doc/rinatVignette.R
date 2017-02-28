## ----  message=FALSE,warning=FALSE,echo=FALSE----------------------------
options(stringsAsFactors = FALSE)

## ---- message=FALSE,warning=FALSE----------------------------------------
library(rinat)

butterflies <- get_inat_obs(query = "Monarch Butterfly")

## ---- message=FALSE,warning=FALSE----------------------------------------
vp_obs <- get_inat_obs(query = "vernal pool")
head(vp_obs$species_guess)

## ------------------------------------------------------------------------
## Return just observations in the family Plecoptera
stone_flies <- get_inat_obs(taxon_name  = "Plecoptera", year = 2010)

## Return just Monarch Butterfly records
just_butterflies <- get_inat_obs(taxon_name = "Danaus plexippus")

## ------------------------------------------------------------------------
## Search by area

bounds <- c(38.44047, -125, 40.86652, -121.837)
deer <- get_inat_obs(query = "Mule Deer", bounds = bounds)

## ------------------------------------------------------------------------
## Just get info about a project
vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)

## ------------------------------------------------------------------------
## Now get all the observations for that project
vt_crows_obs <- get_inat_obs_project(vt_crows$id, type = "observations")

## ------------------------------------------------------------------------
m_obs <- get_inat_obs(query = "Monarch Butterfly")
head(get_inat_obs_id(m_obs$id[1]))

## ------------------------------------------------------------------------
m_obs <- get_inat_obs(query = "Monarch Butterfly")
head(get_inat_obs_user(as.character(m_obs$user_login[1]), maxresults = 20))[,1:5]

## ------------------------------------------------------------------------
## By date
counts <- get_inat_taxon_stats(date = "2010-06-14")
print(counts$total)
print(counts$species_counts[1:5,])
print(counts$rank_counts)

## ------------------------------------------------------------------------
## By date
counts <- get_inat_user_stats(date = "2010-06-14")
print(counts$total)
print(counts$most_observations[1:10,])
print(counts$most_species[1:10,])

## ------------------------------------------------------------------------

## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)

## ------------------------------------------------------------------------
place_counts <- get_inat_user_stats(place = vt_crows$place_id)
print(place_counts$total)
print(place_counts$most_observations[1:10,])
print(place_counts$most_species[1:10,])


## ----fig.width=7.5,fig.height=4------------------------------------------
library(ggplot2)

## Map salamanders in the genuse Ambystoma
m_obs <- get_inat_obs(taxon_name = "Ambystoma maculatum")

salamander_map <- inat_map(m_obs, plot = FALSE)
### Now we can modify the returned map
salamander_map + borders("state") + theme_bw()

