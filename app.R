
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# Developed with R version 3.3.2 (64-bit)

# load libraries
library(dplyr)
library(stringr)
library(png)
library(shinyjs)
library(DT)
library(visNetwork)
library(rintrojs)

# load data from FAO
# dat_files = list.files(pattern='.rda')
# lapply(dat_files, load, .GlobalEnv)

load("wfp_topics.rda", .GlobalEnv)
load("countries.rda", .GlobalEnv)
load("population_all_data.rda", .GlobalEnv)
load('land_cover_all_data.rda', .GlobalEnv)
load("crop_production_all_data.rda", .GlobalEnv)
load('background_questions.rda', .GlobalEnv)

# Panel div for visualization
# override the currently broken definition in shinyLP version 1.1.0
panel_div <- function(class_type, content) {
  div(class = sprintf("panel panel-%s", class_type),
      div(class = "panel-body", content)
  )
}


# NAVIGATION BAR
ui = shinyUI(navbarPage(title = img(src="cornell_logo.png", height = "40px"), id = "navBar",
                        theme = "paper.css",
                        collapsible = TRUE,
                        inverse = TRUE,
                        windowTitle = "NYYI: Data-Driven Stories",
                        position = "fixed-top",
                        footer = includeHTML("./www/include_footer.html"),
                        header = tags$style(
                          ".navbar-right {
                       float: right !important;
                       }",
                          "body {padding-top: 75px;}"),
                        
                        tabPanel("", value = "",
                                 
                                 shinyjs::useShinyjs(),
                                 
                                 tags$head(tags$script(HTML('
                                                       var fakeClick = function(tabName) {
                                                       var dropdownList = document.getElementsByTagName("a");
                                                       for (var i = 0; i < dropdownList.length; i++) {
                                                       var link = dropdownList[i];
                                                       if(link.getAttribute("data-value") == tabName) {
                                                       link.click();
                                                       };
                                                       }
                                                       };
                                                       '))),
                                 fluidRow(
                                   tags$img(height = 350, width = 1870, src = "wfp.png")
                                 ),
                                 
                                 # INTRO
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><center> <h1><b>Telling Stories About Food Using Data</b></h1> </center>"),
                                          shiny::HTML("<center> <h3>New York Youth Institute 2022</h3> </center><br>"),
                                          column(1),column(10,
                                                           shiny::HTML("<h5> An interactive tool to help you explore different ways to present your research.
                                                   By combining visualizations and analysis of FAO data with exerpts from your research paper, this tool 
                                                   gives students the opportunity to transform their research paper into a data-driven visual product.</h5>")),
                                          column(1),
                                   ),
                                   column(2)
                                 ),

                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><left> <h1><b> Background Information </b></h1> </left><br>"),
                                          a(shiny::HTML("<left> <h5> CLICK HERE to View: Using Data to Tell Stories Slide Deck </h5> </left>"),
                                            target="_blank",href="FINAL_storytelling_data_slides.pdf"),
                                          #a("slides",target="_blank",href="FINAL_storytelling_data_slides.pdf"),
                                          a(shiny::HTML("<left> <h5> CLICK HERE to View: Example of magazine produced with this tool </h5> </left>"),
                                            target="_blank",href="FINAL_example_magazine.pdf"),
                                 ),
                                 column(2)),
                                          
                                          
                                          

                                 
                                 # PAGE BREAK
                                 # tags$hr(),
                                 
                                 # SPREAD 1 - AUTHOR INTRO
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><left> <h1><b> Create your magazine: </b></h1> </left>"),
                                          # Data entry
                                          shiny::HTML("<br><left> <h2><b>1.  Author background & paper summary </b></h2> </left><br>"),
                                          shiny::HTML("<left> <h5> First and last name</h5> </left>"),
                                          textInput(inputId = "student_name",
                                                    label = "",
                                                    value = "First Last"),
                                          #p(textOutput("student_name")),
                                          
                                          shiny::HTML("<br><left> <h5> School name</h5> </left>"),
                                          textInput(inputId = "school_name",
                                                    label = "",
                                                    value = "School"),
                                         # p(textOutput("school_name")),
                                          
                                          shiny::HTML("<br><left> <h5> Grade </h5> </left>"),
                                          selectInput(inputId = "grade",
                                                      label = "",
                                                      choices = c("Freshman", "Sophomore", "Junior", "Senior")),
                                          #p(textOutput("grade")),
                                          
                                          shiny::HTML("<br><left> <h5> Country of focus </h5> </left>"),
                                          selectInput(inputId = "country_name",
                                                      label="",
                                                      choices = countries),
                                         # p(textOutput("country")),
                                          
                                          shiny::HTML("<br><left> <h5> Category of focus </h5> </left>"),
                                          selectInput(inputId = "category_name",
                                                      label= "",
                                                      choices = wfp_topics),
                                          #p(textOutput("category_name")),
                                          
                                          shiny::HTML("<br><left> <h5> Paper title </h5> </left>"),
                                          textInput(inputId = "paper_title",
                                                    label="",
                                                    value= "Title"),
                                          p(textOutput('mc_text_paper_title')),
                                          #p(textOutput("paper_title")),
                                          
                                          shiny::HTML("<br><left> <h5> Short summary of the challenge your paper focuses on (3-10 words) </h5> </left>"),
                                          textInput(inputId = "challenge_short",
                                                    label="",
                                                    value= "Challenge short"),
                                          p(textOutput('mc_text_challenge_short')),
                                          #p(textOutput("challenge_short")),
                                          
                                          shiny::HTML("<br><left> <h5> Short summary of the solution you propose in your paper (3-10 words) </h5> </left>"),
                                          textInput(inputId = "solution_short",
                                                    label="",
                                                    value= "Solution short"),
                                          p(textOutput('mc_text_solution_short')),
                                          #p(textOutput("solution_short")),
                                          
                                          
                                          shiny::HTML("<br><left> <h5> 2-3 sentence summary of your paper</h5> </left>"),
                                          textAreaInput(inputId = "paper_summary", 
                                                        width = '100%',
                                                        height = '100px',
                                                        label = "",
                                                        value = ""),
                                          p(textOutput('mc_text_paper_summary')),
                                          #p(textOutput("paper_summary")),
                                   ),
                                   column(2)),
                                 
                                 # SPREAD 2 - COUNTRY BACKGROUND
                                 
                                 # population data, total plot, percent urban and rural for most recent year data is available
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          # shiny::HTML('<br><br>'),
                                          # h1('2. ', textOutput('country'), ' background'), if we wanted to do this, would use paste() function in server()
                                          shiny::HTML('<br><br><left> <h2><b>2. Country background</b></h2> </left><br>'),
                                          shiny::HTML("<left> <h5> Preview population data </h5> </left>"),
                                          
                                          # Population data preview
                                          DTOutput("pop_dat"),
                                          shiny::HTML("<br></br>"),
                                          
                                          # Plots preview
                                          plotOutput("pop_plot_total"),
                                          shiny::HTML("<br>"),
                                          
                                          # Percent urban and rural for most recent year data is available
                                          # Plots preview
                                          plotOutput("urban_rural_plot"),
                                          shiny::HTML("<br>"),
                                          fluidRow(style = "height:80px;")),
                                   column(2)),
                                 
                                 # top 3 crops and output
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<left> <h5> Preview land cover data </h5> </left>"),
                                          # Crop data preview
                                          DTOutput("land_cover_dat"),
                                          shiny::HTML("<br></br>"),
                                          plotOutput("land_cover_plot"),


                                          shiny::HTML("<left> <h5> Preview crop production data </h5> </left>"),
                                          # Crop data preview
                                          DTOutput("crop_dat"),
                                          shiny::HTML("<br></br>"),

                                          # Crop neticon and top 3 stats
                                          h5('Top 5 crops by production area (2019):'),
                                          h5(textOutput('crop_1')),
                                          h5(textOutput('crop_2')),
                                          h5(textOutput('crop_3')),
                                          h5(textOutput('crop_4')),
                                          h5(textOutput('crop_5')),

                                          fluidRow(style = "height:80px;")),
                                   column(2)),

                                 # background questions
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<left> <h5> Please provide additional information about a typical family and/or farm in your country (5-10 words each)</h5> </left>"),
                                          selectInput(inputId = "background_question_1",
                                                      label="",
                                                      width = '100%',
                                                      choices = background_questions),
                                          
                                          textAreaInput(inputId = "question_1_answer", 
                                                        width = '100%',
                                                        height = '100px',
                                                        label = "",
                                                        value = ""),
                                          p(textOutput('mc_text_bg_q1')),
                                          
                                          
                                          shiny::HTML("<br>"),
                                          selectInput(inputId = "background_question_2",
                                                      label="",
                                                      width = '100%',
                                                      choices = background_questions),
                                          
                                          textAreaInput(inputId = "question_2_answer", 
                                                        width = '100%',
                                                        height = '100px',
                                                        label = "",
                                                        value = ""),
                                          p(textOutput('mc_text_bg_q2')),
                                   ),
                                   column(2)),
                                 
                                 
                                 # SPREAD 3 - KEY CHALLENGE
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><left> <h2><b>3. Key Challenge </b></h2> </left><br>"),
                                          shiny::HTML("<left> <h5> Enter a 3-4 sentence quote from your paper that describes the challenge your paper focuses on:  </h5> </left>"),
                                          textAreaInput(inputId = "challenge_quote", 
                                                        width = '100%',
                                                        height = '100px',
                                                        label = "",
                                                        value = ""),
                                          p(textOutput('mc_text_challenge_quote')),
                                          

                                   ),
                                   column(2)),
                                 
                                 fluidRow(
                                   
                                   style = "height:50px;"),
                                 
                                 # SPREAD 4 - PROPOSED SOLUTIONS
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><left> <h2><b>4. Proposed Solution </b></h2> </left><br>"),
                                          
                                          shiny::HTML("<left> <h5> Enter a 3-4 sentence quote from your paper that addresses proposed solutions to the challenges your paper focuses on:  </h5> </left>"),
                                          textAreaInput(inputId = "solution_quote", 
                                                        width = '100%',
                                                        height = '100px',
                                                        label = "",
                                                        value = ""),
                                          p(textOutput('mc_text_solution_quote')),
                                          
                                   ),
                                   column(2)),
                                 
                                 #SPREAD 5 - Acknowledgements + works cited
                                 fluidRow(
                                   column(2),
                                   column(8,
                                          shiny::HTML("<br><br><left> <h2><b>5. Works Cited </b></h2> </left><br>"),

                                          shiny::HTML("<left> <h5> Enter your paper's works cited:  </h5> </left>"),
                                          textAreaInput(inputId = "works_cited",
                                                        width = '100%',
                                                        height = '200px',
                                                        label = "",
                                                        value = ""),
                                   ),
                                   column(2)),

                                 fluidRow(
                                   column(2),
                                   column(8,
                                          downloadButton(outputId = "down", label = "STEP 1: DOWNLOAD INPUTS", style = "width:100%; font-size:25px;", class = 'butt'),
                                           tags$head(tags$style(".butt{color: black !important;}")), #  font color
                                          
                                          fluidRow(style = "height:80px;"),
                                          
                                          # downloadButton(outputId = "down2", label = "STEP 2: DOWNLOAD BOOKLET", style = "width:100%; font-size:25px;", class = 'butt'),
                                          # tags$head(tags$style(".butt{color: black !important;}")), #  font color
                                          # #https://drive.google.com/drive/folders/14Bzow-CfbH4u6WRoyV6C00F2IiPf-MRd?usp=sharing
                                          # 
                                          shiny::actionButton(inputId='drive', label = "STEP 2: UPLOAD ZIP FILE", style = "width:100%; font-size:25px;"),
                                                              icon = icon("th"),
                                                              onclick ="window.open('https://drive.google.com/drive/folders/14Bzow-CfbH4u6WRoyV6C00F2IiPf-MRd?usp=sharing', '_blank')",
                                   ),
                                   column(2)),
                        )))


library(DT)
server = function(input, output){
  
  # SPREAD 1 - AUTHOR INTRO
  student_name = reactive({
    input$student_name
  })
  output$student_name = renderText({student_name()})
  
  school_name = reactive({
    input$school_name
  })
  output$school_name = renderText({school_name()})
  
  grade = reactive({
    input$grade
  })
  output$grade = renderText({grade()})

  country = reactive({
    input$country_name
  })
  output$country = renderText({country()})
  
  category_name = reactive({
    input$category_name
  })
  output$category_name = renderText({category_name()})
  
  paper_title = reactive({
    input$paper_title
  })
  output$paper_title = renderText({paper_title()})
  
  maxc_paper_title = 50
  output$mc_text_paper_title <- reactive({ paste0(maxc_paper_title-nchar(input$paper_title), ' characters remaining.' ) })
  
  challenge_short = reactive({
    input$challenge_short
  })
  output$challenge_short = renderText({challenge_short()})
  maxc_challenge_short = 60
  output$mc_text_challenge_short <- reactive({ paste0(maxc_challenge_short-nchar(input$challenge_short), ' characters remaining.' ) })
  
  
  solution_short = reactive({
    input$solution_short
  })
  output$solution_short = renderText({solution_short()})
  maxc_solution_short = 60
  output$mc_text_solution_short <- reactive({ paste0(maxc_solution_short-nchar(input$solution_short), ' characters remaining.' ) })
  
  paper_summary = reactive({
    input$paper_summary
  })
  output$paper_summary = renderText({paper_summary()})
  maxc_paper_summary = 450
  output$mc_text_paper_summary <- reactive({ paste0(maxc_paper_summary -nchar(input$paper_summary ), ' characters remaining.' ) })
  
  
  works_cited = reactive({
    input$works_cited
  })
  output$works_cited = renderText({works_cited()})
  maxc_works_cited = 1800
  output$mc_text_works_cited <- reactive({ paste0(maxc_works_cited -nchar(input$works_cited ), ' characters remaining.' ) })
  
  # SPREAD 2 - COUNTRY BACKGROUND
  # population data 
  pop_subset_df <- eventReactive(input$country_name,{
    pop_subset_df <- population_all_data[toupper(population_all_data$area)==toupper(input$country_name),][c(6,8:10)]
    pop_subset_df
  })
  
  # total population plot
  output$pop_dat = renderDT(pop_subset_df(), options = list(pageLength = 5,lengthChange = FALSE))
  source("./www/pop_plot_func.R")
  population_plotInput = function(){
    pop_plot_func(pop_subset_df(), country(), 'total_population___both_sexes')      
  }
  output$pop_plot_total = renderPlot(pop_plot_func(pop_subset_df(), country(), 'total_population___both_sexes'))
  
  # urban rural population plot
  source('./www/urban_rural_func.R')
  urban_rural_plotInput = function(){
    urban_rural_func(pop_subset_df(), country())
  }
  output$urban_rural_plot = renderPlot(urban_rural_plotInput())
  
  urban_percent = function(){
    urban_rural_vec(pop_subset_df(), country())[1]
  }
  
  rural_percent = function(){
    urban_rural_vec(pop_subset_df(), country())[2]
  }
  
  # land cover data
  land_cover_subset_df <- eventReactive(input$country_name,{  #
    land_cover_subset_df <- land_cover_all_data[toupper(land_cover_all_data$area)==toupper(input$country_name),][c(4,6,8:10)]
    land_cover_subset_df = land_cover_subset_df[which(land_cover_subset_df$year == 2019),]
    land_cover_subset_df
  })
  output$land_cover_dat = renderDT(land_cover_subset_df(), options = list(pageLength = 5,lengthChange = FALSE))

  # land cover plot
  source('./www/land_cover_func.R')
  land_cover_plotInput = function(){
    land_cover_func(land_cover_subset_df(), country())
  }
  output$land_cover_plot = renderPlot(land_cover_plotInput())

  # crop data
  crop_subset_df <- eventReactive(input$country_name,{
    crop_subset_df <- crop_production_all_data[toupper(crop_production_all_data$area)==toupper(input$country_name),][c(4,6,8:10)]
    crop_subset_df = crop_subset_df[which(crop_subset_df$year == 2019),]
    crop_subset_df
  })
  output$crop_dat = renderDT(crop_subset_df(), options = list(pageLength = 5,lengthChange = FALSE))
  
  # top 5 crops info - figure out how to be able to download this part next
  source('./www/top_5_crops_func.R')
  top_5_output = eventReactive(input$country_name,{
    top_5_output = top_5_crops_func(crop_subset_df(), country())
    top_5_output
  })
  output$crop_1 = renderPrint(cat(top_5_output()[1]))
  output$crop_2 = renderPrint(cat(top_5_output()[2]))
  output$crop_3 = renderPrint(cat(top_5_output()[3]))
  output$crop_4 = renderPrint(cat(top_5_output()[4]))
  output$crop_5 = renderPrint(cat(top_5_output()[5]))
  
  
  # family background questions
  background_question_1 = reactive({
    input$background_question_1
  })
  output$background_question_1 = renderText(background_question_1())
  
  question_1_answer = reactive({
    input$question_1_answer
  })
  output$question_1_answer = renderText(question_1_answer())
  maxc_bg_q1 = 50
  output$mc_text_bg_q1 <- reactive({ paste0(maxc_bg_q1-nchar(input$question_1_answer), ' characters remaining.' ) })
  
  background_question_2 = reactive({
    input$background_question_2
  })
  output$background_question_2 = renderText(background_question_2())
  maxc_bg_q2 = 50
  output$mc_text_bg_q2 <- reactive({ paste0(maxc_bg_q2-nchar(input$question_2_answer), ' characters remaining.' ) })
  
  
  question_2_answer = reactive({
    input$question_2_answer
  })
  output$question_2_answer = renderText(question_2_answer())
  
  # SECTION 4
  challenge_quote = reactive({
    input$challenge_quote
  })
  maxc_challenge_quote = 700
  output$mc_text_challenge_quote <- reactive({ paste0(maxc_challenge_quote -nchar(input$challenge_quote ), ' characters remaining.' ) })
  
  
  solution_quote = reactive({
    input$solution_quote
  })
  maxc_solution_quote = 550
  output$mc_text_solution_quote <- reactive({ paste0(maxc_solution_quote -nchar(input$solution_quote ), ' characters remaining.' ) })
  
  # source('./www/map_func.R')
  # 
  # country_map_img = function(){
  #   map_func(country())
  # }
  
  # worksCited
  
  output$down = downloadHandler(
    filename = paste(student_name(),'_nyyi.zip',sep=""),
    content = function( file){

      write.table(paste(
        student_name(),
        school_name(),
        grade(),
        country(),
        category_name(),
        paper_title(),
        challenge_short(),
        solution_short(),
        paper_summary(),
        urban_percent(),
        rural_percent(),
        question_1_answer(),
        question_2_answer(),
        paste(top_5_output()[1], top_5_output()[2], top_5_output()[3], top_5_output()[4], top_5_output()[5],
              sep = '\t'),
        challenge_quote(),
        solution_quote(),
        
        works_cited(),
        sep = '\n'), file = './www/student_intro.txt', quote = F, row.names = F, col.names = F)

      # Save the plots
      ggsave( './www/pop_total.png', plot = population_plotInput(), device = "png", width = 2500, height = 1500, units = 'px')
      ggsave( './www/land_cover.png', plot = land_cover_plotInput(), device = "png", bg = 'transparent', width = 2200, height = 2000, units = 'px')
      #ggsave( './www/map_image.png', plot = country_map_img(), device = "png", bg = 'transparent', width = 650, height = 550, units = 'px')
      
      # Zip them up
      zip( file, c( './www/student_intro.txt', './www/pop_total.png', './www/land_cover.png'))
    }
  )
  
  # this block does not work yet
  # output$down2 = downloadHandler(
  #   filename = 'nyyi_template.pdf',
  #   content = function(file){
  #     library('reticulate')
  #     use_python("./www/python3")
  #     source_python('./www/DRAFTINGoutputToTemplate.py')
  #     convert('./www/student_intro.txt')
  #     
  #     file.copy('./out3.pdf',file)
  #   }
  # )
  # 
  # Initialize the user selections and tooltip (title)
  selections <- vector(mode = "character", length = 0)
  edgeLabels <- vector(mode = "character", length = 0)
  tips <- vector(mode = "character", length = 0)
  
  # Initialize empty data.frames for nodes and edges
  nodes <- data.frame(id = integer(), label = character(), title = character(), 
                      shape = character(), icon.face = character(), icon.code = character(), 
                      color = character(), stringsAsFactors = FALSE)
  
  # Initialize edges data
  edges <- data.frame(from = numeric(), to = numeric(), length = numeric())
  
  # source("./www/getLink.R")
  # source("./www/make_breaks.R")
  
  shinyServer(function(input, output, session){
    
    # Navbar ------------------------------------------------------------------
    shinyjs::addClass(id = "navBar", class = "navbar-right")
    
    # DT Options --------------------------------------------------------------
    options(DT.options = list( lengthMenu = c(10, 20),
                               dom = 'tl'
    ))})
  
}



shinyApp(ui=ui,server=server)
