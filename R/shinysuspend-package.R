#' @keywords internal
#' @import shiny
"_PACKAGE"

#' Include dependencies for shinysuspend in a Shiny app
#' @export
useShinysuspend <- function() {
  htmltools::htmlDependency(
    name = "shinysuspend",
    version = packageVersion("shinysuspend"),
    package = "shinysuspend",
    src = "js",
    script = "shinysuspend.js"
  )
}

## usethis namespace: start
## usethis namespace: end
NULL
