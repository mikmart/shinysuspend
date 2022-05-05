#' Suspend or resume changes to a Shiny input
#'
#' Suspended inputs are prevented from changing their values visible to Shiny.
#' Suspending and resuming take effect immediately. `suspendForNextFlush()` is
#' a convenience wrapper to suspend an input for the duration of a single flush
#' cycle, useful for e.g. avoiding invalidations by `update*()` functions.
#'
#' @inheritParams shiny::updateActionButton
#' @export
suspendInput <- function(inputId, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("shinysuspend:suspendinput", list(id = inputId))
}

#' @rdname suspendInput
#' @export
resumeInput <- function(inputId, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("shinysuspend:resumeinput", list(id = inputId))
}

#' @rdname suspendInput
#' @export
suspendForNextFlush <- function(inputId, session = getDefaultReactiveDomain()) {
  session$onFlush(function() suspendInput(inputId, session = session))
  session$onFlushed(function() resumeInput(inputId, session = session))
}
