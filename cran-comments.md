## Resubmission

This is a resubmission. In this version, I have:

* Addressed Uwe's comments after 1st submission (URL issues; single-quoting 'iNaturalist' in DESCRIPTION)
* Addressed Gregor Seyer's comments after 2nd submission (using warnings and messages over cat(); resetting options, or not modifying them at all)

## Test environments

* local Ubuntu 18.04 install, R 4.0.3
* win-builder with:
  * devtools::check_win_devel()
  * devtools::check_win_release()
* devtools::check_rhub():
  * Fedora Linux, R-devel, clang, gfortran
  * Ubuntu Linux 16.04 LTS, R-release, GCC
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit

## R CMD check results

Locally, there were no ERRORs, no WARNINGs, no NOTES.

On R-hub's Windows environment, one NOTE:

* Possibly mis-spelled words in DESCRIPTION: APIs (3:42)

## Downstream dependencies

To my knowledge, no other package depends on rinat.