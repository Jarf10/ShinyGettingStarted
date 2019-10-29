# install.packages("ape")
# install.packages("shiny")
# install.packages("ggplot2")
# install.packages("DT")

library(ape)
library(shiny)
library(ggplot2)

# d <- "ftp://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/"
# f <- "GRCh38_latest_genomic.gff.gz"
# download.file(paste0(d, f), "mt_gff3.gz")

gff.mito <- read.gff("mt_gff3.gz")
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
  })
  
}

shinyApp(ui, server)
