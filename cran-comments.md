## Test environments

* local Ubuntu 18.04, R 4.0.4
* win-builder R-devel with `devtools::check_win_devel()`
* win-builder R-release with `devtools::check_win_release()`

## R CMD check results

There were no ERRORs, no WARNINGs

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
  Maintainer: 'St�phane Guillou <stephane.guillou@member.fsf.org>'
  New submission
  Package was archived on CRAN
  Possibly mis-spelled words in DESCRIPTION:
  APIs (3:42)
  CRAN repository db overrides:
  X-CRAN-Comment: Archived on 2021-03-04 for policy violation.
  
Misspelling is irrelevant, and reason for archival is addressed in this release.