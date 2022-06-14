## Test environments

* local Ubuntu 20.04, R 4.2.0
* win-builder R-devel with `devtools::check_win_devel()`
* win-builder R-release with `devtools::check_win_release()`
* Fedora Linux, R-devel, clang, gfortran with `devtools::check_rhub()`
* Windows Server 2022, R-devel, 64 bit with `devtools::check_rhub()`
* MacOS, build system `r-devel-macosx-arm64|4.2.0|macosx|macOS 11.5.2 (20G95)|Mac mini|Apple M1||en_US.UTF-8` with `devtools::check_mac_release()`

## R CMD check results

There were no ERRORs, no WARNINGs, and 1 NOTE related to version number and release date, resolved since.
