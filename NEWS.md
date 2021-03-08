# rinat 0.1.8

* Properly cater for mismatch in project observation numbers to stay on CRAN (attempt in previous version did not cover all cases)
* Improve console messages in `get_inat_obs_project()`
* Skip tests that use the iNaturalist API on CRAN
* Don't error when iNaturalist or Internet is not available, as per CRAN Repository Policies (#49)

# rinat 0.1.7

* Cater for a corner case in which a mismatch between a project's reported number of observations and the actual number of observations returned produced an error when merging data frames in `get_inat_obs_project()`

# rinat 0.1.6

* New maintainer: Stéphane Guillou (@stragu)
* Improve documentation
* Clean up code according to CRAN feedback
* Note that 0.1.x versions of rinat will only fix existing issues, before a move to the new iNaturalist API with version 0.2 (which is likely to introduce breaking changes).

## New features

* `get_inat_obs()` can now use objects of class `Spatial` or `sf` as a bounding box (#38, @Martin-Jung and #40, @LDalby; fixes #30)
* Allow the use of an iNat `place_id` when searching for observations (commit 1d7f14f, @LDalby)

## Bug fixes

* Lower result number limit when bounding box present (#20)
* Fix result pagination in `get_obs_project()` for cases when the number of results is a multiple of 100 (#1, @vijaybarve)
* Stop `get_inat_obs()` if no search parameter(s) provided (#32, @LDalby)
* Avoid API error by limiting search results to 10000 (#32, @LDalby)
* Fix argument name in `inat_handle()` (#32, @LDalby)
* Use JSON endpoint instead of CSV to avoid `get_inat_obs_project()` failing on some projects (#35, @LDalby and #38, @Martin-Jung; fixes #28 and #37)
* Fix code according to `devtools::check()` feedback in preparation for CRAN release

# rinat 0.1.5

## Bug fixes

* Fixed bug where an error occurred when >20K records were requested and code now throws a warning to not hammer the API
* Fixed warning thrown when building vignettes on Linux systems
* Fixed bug where example code parameter names were different than actual parameter names

## New features

* Added NEWS file.
* Added a full suite of tests
* Added new vignette that builds with markdown and not hacky prebuilt PDF