context("Check basic queries")
res_set <- get_inat_obs("Ambystoma maculatum", maxresults = 10)
bounds <- c(38.44047,-125,40.86652,-121.837)
test_that("Check all search parameters", {
  expect_equal(dim(res_set)[1],10)
  expect_match("Ambystoma maculatum",res_set[1,1])
  expect_equal(dim(get_inat_obs(taxon_name = 'Ambystoma maculatum', maxresults = 10))[1],10)
  
  expect_equal(dim(get_inat_obs(taxon_id = 26790, maxresults = 10))[1],10)
  expect_equal(dim(get_inat_obs(taxon_id = 26790,quality = 'research', maxresults = 10))[1],10)
  expect_equal(dim(get_inat_obs(taxon_id = 26790,geo = TRUE, maxresults = 10))[1],10)
  expect_equal(dim(get_inat_obs(taxon_id = 26790,day=10,maxresults = 10))[1],10)
  expect_equal(dim(get_inat_obs(taxon_id = 26790,year=2016, maxresults = 10))[1],10)
  expect_equal(dim(get_inat_obs(taxon_id = 26790,month=7, maxresults = 10))[1],10)
  expect_equal( get_inat_obs(query="Monarch Butterfly", meta=TRUE)$meta$returned,100)
  
  expect_equal(  dim(get_inat_obs(query="Mule Deer", bounds=bounds,maxresults = 10))[1],10)
  
               })
  