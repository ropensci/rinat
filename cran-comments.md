## Test environments

* local Ubuntu 18.04 install, R 4.0.2
* win-builder with:
  * devtools::check_win_devel()
  * devtool::check_win_release()

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking for future file timestamps ... NOTE
  unable to verify current time

  This probably has to do with http://worldclockapi.com/ issuing a "Error 403 - This web app is stopped."

## Downstream dependencies

To my knowledge, no other package depends on rinat.