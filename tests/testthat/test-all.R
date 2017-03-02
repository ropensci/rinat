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


test_that("Check that getting observation by ID works",{
    expect_gt(length(get_inat_obs_id(res_set$id[1])),0)
    expect_equal(get_inat_obs_id(res_set$id[1])$id,res_set$id[1])
})

test_that("Check that project info is retrieved",{
  expect_match(get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE)$slug, "crows-in-vermont" )
})

test_that("Check that getting observations by users works",{
  expect_gt(dim(get_inat_obs_user(as.character(res_set$user_login[1])))[1],0)
  
})

test_that("Check that taxon stats works",{
  expect_gt(get_inat_taxon_stats(date="2010-06-14")$total,0)
})

test_that("Check that user stats works",{
  expect_gt(get_inat_user_stats(date="2010-06-14")$total,0)
  
})



