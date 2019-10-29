#install.packages("ape")
#install.packages("shiny")
#install.packages("ggplot2")
#install.packages("DT")

library(ape)
library(shiny)
library(ggplot2)

gff.mito <- read.gff("mt_gff3.gz")
## the lengths of the sequence features:
#gff.mito$end - (gff.mito$start - 1)
genome <- DT::datatable(gff.mito)

ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "genome"',
        checkboxGroupInput("show_vars", "Columns in genome to show:",
                           names(gff.mito), selected = names(gff.mito))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("genome", DT::dataTableOutput("mytable1"))
      )
    )
  )
)

server <- function(input, output) {
  
  # choose columns to display
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(gff.mito[, input$show_vars, drop = FALSE])
    #DT::datatable(genome[, input$show_vars, drop = FALSE])
  })
  
}

shinyApp(ui, server)


#gff.mito <- read.gff("mt_gff3.gz")
## the lengths of the sequence features:
#gff.mito$end - (gff.mito$start - 1)
#table(gff.mito$type)
## where the exons start:
#gff.mito$start[gff.mito$type == "exon"]
