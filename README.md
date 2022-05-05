
# shinysuspend

<!-- badges: start -->
<!-- badges: end -->

The goal of shinysuspend is to give you more control over Shiny input invalidation.

## Installation

You can install the development version of shinysuspend like so:

``` r
remotes::install_github("mikmart/shinysuspend")
```

## Example

Suspend changes to an input that's updated from the server side:

``` r
library(shiny)
library(shinysuspend)

ui <- fluidPage(
  useShinysuspend(),
  sliderInput("A", "Slider A", 0, 10, 5),
  sliderInput("B", "Slider B", 0, 10, 5),
  verbatimTextOutput("inputs")
)

server <- function(input, output, session) {
  observeEvent(input$A, {
    suspendForNextFlush("B")
    updateSliderInput(session, "B", value = input$A + 1)
  })
  observeEvent(input$B, {
    suspendForNextFlush("A")
    updateSliderInput(session, "A", value = input$B + 1)
  })
  output$inputs <- renderPrint({
    str(list(A = input$A, B = input$B))
  })
}

shinyApp(ui, server)
```
