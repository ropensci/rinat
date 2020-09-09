## Test environments

* local Ubuntu 18.04 install, R 4.0.2
* win-builder with:
  * devtools::check_win_devel()
  * devtools::check_win_release()
* devtools::check_rhub():
  * Fedora Linux, R-devel, clang, gfortran
  * Ubuntu Linux 16.04 LTS, R-release, GCC
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking for future file timestamps ... NOTE
  unable to verify current time

  This probably has to do with http://worldclockapi.com/ issuing a "Error 403 - This web app is stopped."

## Downstream dependencies

To my knowledge, no other package depends on rinat.

## Submission comments

Addressed Uwe's comments after submission (URL issues; single-quoting 'iNaturalist' in DESCRIPTION)