## Test environments

* local Ubuntu 24.04.3 64-bit, R 4.5.1
* win-builder R-devel (unstable - 2025-08-29 r88740 ucrt) with `devtools::check_win_devel()`
* win-builder R-release (4.5.1 - 2025-06-13 ucrt) with `devtools::check_win_release()`
* macOS, build system `r-devel-macosx-arm64|4.5.1|macosx|macOS 13.3.1 (22E261)|Mac mini|Apple M1||en_US.UTF-8|macOS 11.3|clang-1403.0.22.14.1|GNU Fortran (GCC) 14.2.0` with `devtools::check_mac_release()`

## R CMD check results

There were no ERRORs, no WARNINGs, no NOTEs.
