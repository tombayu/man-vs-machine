# GRS60312 - Remote Sensing and GIS Integration
# Integrated Data Handling and Visualization
# Man vs. Machine
# by Group 10
# Csilla Vamos, Jens van der Zee, Ricardo Hauffe, Robbie Vinogradov, Tombayu Amadeo Hidayat

rm(list = ls())

library(readxl)
library(shiny)
library(plotly)
library(ggplot2)
library(ggforce)
library(shinythemes)

# The raw data
#measurements <- read_excel("D:/IDV_gr10/B_Process/B1_Script/data/measurements.xlsx")
#machine <- read_excel("D:/IDV_gr10/B_Process/B1_Script/data/machine.xlsx")
measurements <- read_excel("./data/measurements.xlsx")
machine <- read_excel("./data/machine.xlsx")

# Texts for contents
# Introduction Tab
introtext <- ("Terrestrial laser scanning (TLS) is making its way into forestry and forest ecology supporting decision making on forest resources (Liang et al., 2016). TLS is a recent imaging method that rapidly acquires accurate 3D point clouds and automatically measures the surrounding three-dimensional space. The major advantage of using TLS in forest inventory lies in its capability to document the forest rapidly and in millimeter-level detail (Liang et al., 2016). It provides a detailed description of the three dimensional structure of trees, which can be used to derive typical tree parameters such as DBH (diameter at breast-height), tree height and canopy projection. Traditionally, such parameters are derived by labour-intensive manual measurements (Bruce, 1975). The potential to derive all possible tree parameters from a single standardized measuring method may improve forest biomass assessments as these parameters are used in allometric equations for tree biomass estimation (Mengesha, et al., 2014).")
introtext2 <- ("The main objective of this study was to compare tree parameters (DBH, height and canopy projection) measured manually and derived from TLS point clouds. Knowing how well the results of the two methods match provides useful insight into how TLS may substitute for labour-intensive traditional measurements. In order to make a comparison of manual and LIDAR-based measurement of biomass estimation parameters, 55 volunteers were asked to manually measure a Lime tree in \"The Living Lab the Reirinck\" (Gelderland, The Netherlands). In this way, it was possible to closely examine the variation of manual measurements on a single tree and how much their estimates per parameter vary from the actual measurements done by the TLS scanner.")
author <- "This research was part of the Remote Sensing and GIS Integration course and was carried out by group 10, consisting of Tombayu Hidayat, Csilla Vamos, Jens van der Zee, Ricardo Hauffe and Robbie Vinogradov."
sampling0 <- "The field site for our study case was located at the Living Lab at the Reirinck near Groenlo and the German border in the Netherlands. It is a historic property which is currently used as a hostel. The surrounding properties include historic buildings, an area of (historic) forest, nature areas and some cultural objects (e.g., statute, historic defence objects). The land-use around the Reirinck is characterized by a combination of agriculture (both arable and livestock) and natural areas."
sampling1 <- "The picture below shows an overview of the area in the Reirinck. The tree within the red circle was used for doing the measurements as it was one of the few trees in the area which was standing alone and was therefore easy to measure."
sampling2 <- "The pictures below show the appearance of the Lime tree in the Reirinck that was planted in the 1990\'s. All 55 measurements were carried out in two days at the end of May. During these two days, the weather conditions were optimal for doing measurements, with no wind and clear skies."
param1 <- "The variables that were collected in this project are circumference, tree height and canopy projection and are described below."
param2 <- "The diameter at breast height is a standard method of expressing the diameter of a trunk of a standing tree and is an important predictive variable for variations in biomass (measured in centimeters). However, for simplicity purposes, in this research the circumference was measured at a height of 130 centimeters. To determine the DBH, the circumference only has to be divided by pi."
param3 <- "Canopy projection refers to the area of foliage and branches growing outward from the trunk of the tree. The crown size is an important parameter to characterize tree biomass, as it is related to the tree's photosynthetic capacity (measured in centimeters)."
param4 <- "Tree height is the vertical distance between the base of the tree and the tip of the highest branch of the tree (measured in centimeters)."
meas1 <- "Volunteers were individually invited to manually measure the different tree parameters using four manual measuring tools. The name of the volunteer was noted down on the field form which can be found under appendix. Next, the measurement protocol per tree parameter was started. To increase the accuracy of the results, the measurement procedure is standardized so the order in which the measurements are made by the volunteers is important."
meas2 <- "First, the volunteer was asked to measure the circumference 130 centimeters up the trunk of the tree from the ground. Traditionally, the diameter at breast height is a standard method of expressing the diameter of a trunk of a standing tree and is an important predictive variable for variations in biomass (measured in centimeters). However, for simplicity purposes, in this research the circumference was measured at a height of 130 centimeters. To determine the DBH, the circumference only has to be divided by pi. With the help of a measuring stick, the volunteer had to determine the height of 130 independently. Thereafter, by wrapping a diameter measuring tape around the tree trunk at 130 centimeters, the volunteer was requested to determine the corresponding circumference at that particular height by measuring the length of the tape."
meas3 <- "Next, the volunteer was asked to measure the canopy projection using the measuring tape. Canopy projection refers to the area of foliage and branches growing outward from the trunk of the tree. The crown size is an important parameter to characterize tree biomass, as it is related to the tree's photosynthetic capacity (measured in centimeters). The measurement was done according to the 'spoke method'. This means that four measurements have to be taken from center of the trunk to the outer dripline (furthest point) of the crown. Four reference points around the tree were made beforehand using a compass, representing each cardinal direction (North, East, South, West). Using measuring tape (minimum 5 meters), the volunteer was asked to independently determine the dripline of the crown (from the tree trunk) in each cardinal direction, always starting with North, proceeding clockwise. Then the volunteer was asked to measure the distance to this point starting from the center of the trunk while a member of our team was holding the beginning of the measuring tape on the center of the trunk. This procedure was repeated until each cardinal direction had been measured."
meas4 <- "Tree height is the vertical distance between the base of the tree and the tip of the highest branch of the tree (measured in centimeters).To measure the tree height, the volunteer had to make use of the Nikon Forestry Pro. This device uses laser to measure distances up to 500 meters. The volunteer was guided by a group member to a location 15 - 25 meters away from the tree. The volunteer was then instructed to first find the highest point of the tree and to push the appropriate buttons to measure its distance. To account for the height of the volunteer, he/she was then instructed to capture the distance from the base of the tree trunk using the same buttons as before. These two measurements together indicated the total measured tree height."
manual1 <- "This tab shows the results of the manual tree measurements, performed by 55 volunteers. As can be seen in the graph below, most variation occurred in measuring the tree height. This variation could have been caused by differences in volunteers' height, the fact that some volunteers indicated that they found it hard to keep the device steady in one's hand when taking a measurement, differences in an individual's interpretation of the highest point and differences in measuring distances."
manual2 <- "The least variation can be observed for the circumference measurements (referred to as DBH in the graph above). This makes the circumference parameter the most reliable in terms of man made measurements. This could be due to ease in accessibility to this part of the tree, or due to lack of variation in the shape of the trunk itself. Factors that could have influenced the variation between measurements include not wrapping the measuring tape horizontally around the tree trunk, not holding the measuring tape tight enough around the trunk or not establishing the correct tree height at which the volunteer was expected to measure the tree height (i.e. 130 centimeters)."
manual3 <- "An interesting trend can be observed for the measurements of the crown projection. Measurements of the crown in each direction vary, yet become more stable as one goes clockwise. This could suggest that the volunteers were becoming more experienced with each measurement taken, hence acquiring more accurate results. However, when looking at the profile of the crown in each direction, another cause becomes more apparent; the profile of the north side is jagged, making it difficult for one to determine the further most branch. Coincidently, the profile of each cardinal direction becomes less jagged and more constant as one proceeds clockwise, meaning that it becomes easier to determine the furthermost branch. The measurement distribution results under the tab \"Results: Manual Measurements\" seem to reflect this."
tls <- "The TLS scanner that was used to scan the limetree is the RIEGL VZ- 400 laser scanner (TLS). Measurements using this scanner were carried out in five locations around the chosen tree, at areas where different angles, the height, canopy size, and circumference of the tree could be represented. Ten reflectors were placed around the tree and used to align scans afterwards. The scheme below shows a regular distribution for scanning positions of a single tree. However in our case, only five positions were used to measure the tree with the TLS scanner."
conclusion1 <- "After performing and analyzing the fieldwork, we discovered a few findings. First, we experienced that traditional tree measuring methods are labor intensive and time consuming. Machine measurements (with the TLS) were much easier to execute. TLS measurements are also more accurate, except (to our surprise) for measuring the circumference of the tree trunk. This is because when estimating the circumference of the trunk in R, the program tries to fit a cross section of the tree to a perfect circle; the best fit is deemed as the circumference. However, because the tree used had an irregular shaped trunk, such a measurement method did not work very well. When done manually, using a measuring tape, one was able to better represent the true circumference. Therefore, we concluded that manual circumference measurements are more reliable than LiDAR measurements."
conclusion2 <- "RiScan was better able to measure canopy projection than when done manually. Using RIScan, there was a much better sense of measurements in the point cloud; the program was easily able to determine location of critical points in the point cloud for our objectives. Measuring the furthest branch manually was difficult, as it involved guessing which branch met the criteria, and then performing measurements based on educated guesses. RiScan was also able recreate a full canopy geometry instead of just the 4 directions that was done manually, resulting in more accurate measurements."
conclusion3 <- "It was also easy to extract tree height in RiScan (done by determining the difference in vertical distance). When doing the manual measurements, it was difficult to hold the measuring device steady when taking measurements, as well as determining which point was the highest, contributing to measurement errors."
conclusion4 <- "Finally, manual measurements may also have been influenced by instructions given by the team members. Specific instructions may have varied a little when different team members were giving them for the same task. The way the task was carried out differed between volunteers as well, resulting in different methodologies."
conclusion5 <- "Overall it can be concluded that human decisions still have a significant effect on the accuracy of LiDAR-based tree parameter estimations and therefore need to be taken into account when doing the analysis."

# Compare Tab
compareText <- "This data explorer can be used to make a comparison of individual manual measurements and the LiDAR based measurement of the three tree parameters. Simply choose a manual measurement in the top drop down menu and choose another manual measurement or the LiDAR based measurement (called \"The Machine\") in the drop down menu below to make a comparison between measurements. The column \"rank\" shows whose measurements were closest to the measurements performed by the TLS scanner."

# The Machine Tab
machineText <- "The TLS point cloud was analysed to derive the same tree parameters that were measured manually. RiSCAN PRO was used to extract the tree point cloud. The parameters were then computed in R. The full script that was used to do so can be found below. A short description of the steps that have been taken to calculate the different tree parameters are  presented in the right panel."
dl <- "You can download our script here"
machine1 <- "In order to calculate the circumference of the tree at breast height, a horizontal section was made between 1.295 and 1.305 meters above the foot of the tree in the R statistical software. Next, using the package \'circular\', optimal circle fitting was applied to fit a circle through the data points, see figure below. When estimating the circumference of the trunk, the algorithm tried to fit a perfect circle onto the cross section; the best fit was deemed as the circumference. However, due to the irregular shape of the trunk, this method yielded a measurement of 108 centimeters. Compared to the results of the manual circumference measurements, this method is underestimating the actual circumference."
machine2 <- "To calculate the crown width in all four cardinal directions, the markers that were placed in field were first detected in the point cloud. These were then used to demarcate the North-South and East-West lines through the tree. Using these lines, the crown length was then measured as the distance between the tree centre and the furthest point on that line (see figures below). The LiDAR measurements of the crown width in the four directions are displayed below."
machine3 <- "In order to analyse the tree height, points at the base of the tree were selected and their z-coordinate values averaged. Subsequently, the highest point of the tree was selected and the difference between its z-coordinate and the value of the averaged base points was taken as the tree height, in this case 8.58 meters."

# About Tab
about1 <- "This application was designed for the course Remote Sensing and GIS Integration for the Masters Program Geo-Information Science at Wageningen University. Specifically, this application was part of the Integrated Data Handling and Visualization Project, where the goal was to explore and analyse current developments in the geo-information science field and develop a digital earth application for a specific use case. It was required to use the Living Lab The Reirinck, The Netherlands, as the study area."
about2 <- "Our group decided to choose to do our project on comparison of measurements of biomass of trees using manual and TLS measurements because while it is still common to measure the biomass of trees manually, it is not known how accurate these measurements really are. Additionally, one member of our group, Jens, has expertise in tree measurements, allowing for the execution of the project to run more smoothly. The purpose of this project was to explore how accurate man-made measurements actually are by inviting volunteers to manually measure a tree after given proper instruction. Afterwards, these measurements were compared with measurements taken by a Terrestrial Laser Scanner (TLS) of the same tree. Results are shown under the Compare tab."
csilla <- "Csilla is a Masters student studying Geo-Information Science at Wageningen University and Research in Wageningen, The Netherlands. She did her bachelors in Urban Studies, with a minor in Latin American and Iberian Studies at Haverford College, Pennsylvania, USA. Her research interests include studying the relationship between urban and natural environments using GIS, spatial analysis and visualization."
tom <- "Tombayu (Tom) is currently studying Geo-Information Science at Wageningen University and Research in the Netherlands. He previously studied Geodesy and Geomatics Engineering at Institut Teknologi Bandung, Indonesia during his bachelor years. His research interest includes Geo-information domain in general, particularly in GIS, spatial analysis and data visualization."
ricardo <- "Ricardo graduated in 2016, holding a B.S.c in Coastal and Marine Management from Van Hall Larenstein University of Applied Science, the Netherlands. Currently, he is studying Geo-Information Science at Wageningen University & Research. He is in particular interested in the visualization of 3D geospatial information as well as statistical analysis."
robbie <- "Coming from a bachelor in Human Geography, topics related to urban development and city geography are very familiar to Robbie. During his bachelor he learned that urban and GIS-related topics interested him most, and therefore he decided he wanted to do a master that combined the two and was more practically oriented at the same time. The master Geo-Information Science at the Wageningen University he started in September 2017, was just what he was looking for."
jens <- "Jens is following a double MSc program in Geo-Information Science and Forest & Nature Conservation at Wageningen University. His main interest is in the intersection of remote sensing and ecology with a big love for forests and trees. Other relevant interests include computer programming, statistics and philosophy of human-nature relationships."

# Function to assemble coordinates
assemble_data <- function(measurements) {
  data <- measurements
  x <- c(0, data$Crown_East, 0, data$Crown_West * -1)
  y <- c(data$Crown_North, 0, data$Crown_South * -1, 0)
  dir <- c("North", "East", "South", "West")
  pt <- data.frame(dir, x, y)
  return(pt)
}

# Function to assemble the circle
circleFun <- function(diameter, center = c(0,0), npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

# Alternative function to assemble the circles
assemble_circle <- function(diameter) {
  x0 <- 0
  y0 <- 0
  r <- diameter / 2
  circle <- data.frame(x0, y0, r)
  circle
}

ui <- navbarPage("Man vs. Machine!",
                 #                 title = "Man versus Machine",
                 theme = shinytheme("lumen"),
                 tabPanel("Introduction",
                          sidebarLayout(
                            sidebarPanel(h2("Man vs. Machine"),
                                         h4(em("Accuracy assessment for measurements of different biomass estimation parameters")),
                                         h5("by Group 10"),
                                         div(style = "text-align: justify", introtext),
                                         br(),
                                         div(style = "text-align: justify", introtext2),
                                         br(),
                                         em(div(style = "text-align: justify", author))
                                         #div("This research was part of the Remote Sensing and GIS Integration course and was carried out by group 10, consisting of Tombayu Hidayat, Csilla Vamos, Jens van der Zee, Ricardo Hauffe and Robbie Vinogradov.")
                            ),
                            mainPanel(
                              tabsetPanel(
                                type = "tabs",
                                tabPanel("Sampling Strategy",
                                         br(),
                                         div(style = "text-align: justify", sampling0),
                                         br(),
                                         img(src = 'https://pbs.twimg.com/media/DfBElb1X0AE-UBt.jpg', width = 700, style = "display: block; margin-left: auto; margin-right: auto;"),
                                         br(),
                                         div(style = "text-align: justify", sampling1),
                                         br(),
                                         img(src = 'https://pbs.twimg.com/media/De7bkVfX0AA5Kn7.jpg', style = "display: block; margin-left: auto; margin-right: auto;"),
                                         br(),
                                         br(),
                                         div(style = "text-align: justify", sampling2),
                                         br(),
                                         img(src = "https://pbs.twimg.com/media/De7cxhUWkAAGiZL.jpg", style = "display: block; margin-left: auto; margin-right: auto;")
                                ),
                                tabPanel("Measurement Tools & Protocol",
                                         br(),
                                         div(style = "text-align: justify", param1),
                                         br(),
                                         div(style = "text-align: justify", meas1),
                                         br(),
                                         h4("Circumference"),
                                         div(style = "text-align: justify", meas2),
                                         br(),
                                         h4("Canopy projection"),
                                         div(style = "text-align: justify", meas3),
                                         img(src = 'https://pbs.twimg.com/media/De7bg3bXcAAQkdK.jpg', style = "display: block; margin-left: auto; margin-right: auto;"),
                                         br(),
                                         h4("Tree Height"),
                                         div(style = "text-align: justify", meas4),
                                         img(src = 'https://pbs.twimg.com/media/De7bkTuWsAAfWoz.jpg', style = "display: block; margin-left: auto; margin-right: auto;"),
                                         br()
                                ),
                                tabPanel("Manual Measurements",
                                         br(),
                                         div(style = "text-align: justify", manual1),
                                         br(),
                                         img(src = 'https://pbs.twimg.com/media/De7bkUrW0AAd2sy.png', width = 700, style = "display: block; margin-left: auto; margin-right: auto;"),
                                         br(),
                                         div(style = "text-align: justify", manual2),
                                         br(),
                                         div(style = "text-align: justify", manual3),
                                         br(),
                                         img(src = 'https://pbs.twimg.com/media/De7bg6RWsAAMeU0.png', width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
                                ),
                                tabPanel("TLS Measurements",
                                         br(),
                                         div(style = "text-align: justify", tls),
                                         br(),
                                         img(src = 'https://pbs.twimg.com/media/De7bkUCX4AAI2lV.jpg', style = "display: block; margin-left: auto; margin-right: auto;")
                                ),
                                tabPanel("Discussion & Conclusion",
                                         br(),
                                         div(style = "text-align: justify", conclusion1),
                                         br(),
                                         div(style = "text-align: justify", conclusion2),
                                         br(),
                                         div(style = "text-align: justify", conclusion3),
                                         br(),
                                         div(style = "text-align: justify", conclusion4),
                                         br(),
                                         div(style = "text-align: justify", conclusion5))
                              )
                            )
                          )),
                 tabPanel("Compare",
                          fluidRow(
                            column(3,
                                   selectInput("name", "Choose your hero", choices = c("All", measurements$Name)),
                                   selectInput("compare", "Compare your data", choices = c(machine$Name, measurements$Name))
                            ),
                            column(5,
                                   h4("Data Explorer"),
                                   div(style = "text-align: justify", compareText))
                          ),
                          fluidRow(
                            column(4,
                                   h4("Crown Width"),
                                   plotOutput("crownplot"),
                                   textOutput("crownText")),
                            column(4,
                                   h4("Circumference"),
                                   plotOutput("dbhplot"),
                                   textOutput("dbhText")),
                            column(4,
                                   h4("Tree Height"),
                                   plotOutput("heightPlot"),
                                   textOutput("heightText"))
                          ),
                          fluidRow(
                            h4("Data Table"),
                            DT::dataTableOutput("table")
                          )
                 ),
                 tabPanel("Results: Manual Measurements",
                          sidebarLayout(
                            sidebarPanel(
                              h4("Manual Measurement Results"),
                              br(),
                              div(style = "text-align: justify", "This section can let you explore the statistics of the manual measurements. Simply choose the tree parameter of interest and then the corresponding graph will be shown."),
                              br(),
                              selectInput("manualExplore", "Choose your parameters", choices = c("Circumference", "Crown Overall", "Crown North", "Crown East", "Crown South", "Crown West", "Tree Height")),
                              h5("Download the R Script"),
                              actionButton("downloadScript2", "Download", icon = icon("download"), onclick = "window.open('https://www.dropbox.com/s/pk4ltfsw46ei55y/treevisualizations.R?dl=1', '_blank')")
                            ),
                            mainPanel(
                              uiOutput("graph")
                            )
                          )),
                 tabPanel("Results: The Machine",
                          sidebarLayout(
                            sidebarPanel(
                              h4("TLS Measurement Results"),
                              br(),
                              img(src = 'https://pbs.twimg.com/media/DfBH2o8X0AA8BIi.jpg', width = 300, style = "display: block; margin-left: auto; margin-right: auto;"),
                              br(),
                              div(style = "text-align: justify", machineText),
                              h5("Download the R Script"),
                              actionButton("downloadScript", "Script", icon = icon("download"), onclick = "window.open('https://www.dropbox.com/s/nbeaeygrd442pui/Tree_parameter_extraction.R?dl=1', '_blank')"),
                              h5("Download the LAS Data"),
                              actionButton("downloadData", "Data", icon = icon("download"), onclick = "window.open('https://www.dropbox.com/s/uagi0oc8qubtram/TLStree.las?dl=1', '_blank')")
                            ),
                            mainPanel(
                              fluidRow(
                                h4("Circumference"),
                                div(style = "text-align: justify", machine1),
                                br(),
                                img(src = 'https://pbs.twimg.com/media/DfBH2nvWAAIRHXI.jpg', width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
                              ),
                              fluidRow(
                                h4("Crown Projection"),
                                div(style = "text-align: justify", machine2),
                                br(),
                                tags$ul(
                                  tags$li("Crown North: 325 cm"),
                                  tags$li("Crown East: 351 cm"),
                                  tags$li("Crown South: 374 cm"),
                                  tags$li("Crown West: 358 cm")
                                ),
                                column(6,
                                       img(src = 'https://pbs.twimg.com/media/DfBH2nuXkAAAFba.jpg', width = 500, style = "display: block; margin-left: auto; margin-right: auto;")
                                ),
                                column(6,
                                       img(src = 'https://pbs.twimg.com/media/DfBH2opW4AAl3Dd.jpg', width = 500, style = "display: block; margin-left: auto; margin-right: auto;")
                                )
                              ),
                              fluidRow(
                                h4("Tree Height"),
                                div(style = "text-align: justify", machine3),
                                br(),
                                img(src = 'https://pbs.twimg.com/media/Dfe3uoNW0AAAzTM.jpg', width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
                              )
                            )
                          )
                 ),
                 tabPanel("About",
                          sidebarLayout(
                            sidebarPanel(
                              h3("About the app"),
                              br(),
                              div(style = "text-align: justify", about1),
                              br(),
                              div(style = "text-align: justify", "The goal of this project was to:"),
                              tags$ul(
                                tags$li("Combine open geo-data sources with own measured geo-data;"),
                                tags$li("Make use of 3D visualization elements and data sources;"),
                                tags$li("Publish newly acquired data-sets as open data sources and document data quality;"),
                                tags$li("Prepare and present a visualization demonstrator based on a specified usability strategy.")
                              ),
                              div(style = "text-align: justify", about2),
                              hr(),
                              div(em(style = "text-align: justify", "This app was developed using Shiny by RStudio")),
                              div(em(style = "text-align: justify", "Questions and suggestions: htombayu@gmail.com"))
                            ),
                            mainPanel(
                              fluidRow(
                                column(10,
                                       h3("The group"),
                                       h4("Csilla Vamos"),
                                       div(style = "text-align: justify", csilla),
                                       h4("Tombayu Amadeo Hidayat"),
                                       div(style = "text-align: justify", tom),
                                       h4("Ricardo Hauffe"),
                                       div(style = "text-align: justify", ricardo),
                                       h4("Robbie Vinogradov"),
                                       div(style = "text-align: justify", robbie),
                                       h4("Jens van der Zee"),
                                       div(style = "text-align: justify", jens)
                                )
                              ),
                              fluidRow(
                                column(10,
                                       h3("References"),
                                       div(style = "text-align: justify", "Bruce, D. (1975). Evaluating accuracy of tree measurements made with optical instruments. Science, 21(4): 421-426."),
                                       br(),
                                       div(style = "text-align: justify", "Liang, X. et al. (2016). Terrestrial laser scanning in forest inventories. ISPRS Journal of Photogrammetry and Remote Sensing Volume, 115:63-77."),
                                       br(),
                                       div(style = "text-align: justify", "Mengesha, T., Hawkins, M. & Nieuwenhuis, M. (2014). Validation of terrestrial laser scanning data using conventional forest inventory methods. European Journal of Forest Research, 134(2): 211-222.")
                                )
                              )
                            )
                          )
                 )
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    data <- measurements
    if (input$name != "All") {
      data <- subset(data, data$Name == input$name)
    }
    data
  })
  
  comparisonData <- reactive({
    if (input$compare != "The Machine") {
      data <- measurements
      data <- subset(data, data$Name == input$compare)
      data
    } else {
      data <- machine
      data <- subset(data, data$Name == input$compare)
      data
    }
  })
  
  output$table <- DT::renderDataTable({
    a <- filtered_data()
    b <- comparisonData()
    data <- rbind(a, b)
    data
  })
  
  output$crownplot <- renderPlot({
    
    if (input$name != "All") {
      data <- filtered_data()
      compare <- comparisonData()
      data <- assemble_data(data)
      compare <- assemble_data(compare)
      uName <- filtered_data()$Name
      cName <- comparisonData()$Name
      plot <- ggplot(compare, aes(x = x, y = y)) +
        geom_point() +
        geom_polygon(data = compare, fill = NA, color = "black", aes(linetype = "solid")) +
        geom_polygon(data = data, fill = NA, color = "brown", aes(x = x, y = y, linetype = "dashed")) +
        scale_linetype_manual(name = "", labels = c(uName, cName), values = c("solid", "dashed")) +
        geom_text(data = data, aes(label = dir)) +
        coord_fixed() +
        labs(x = "E-W", y = "N-S")
      plot
    } else {
      compare <- machine
      compare <- assemble_data(compare)
      plot <- ggplot(compare, aes(x = x, y = y)) +
        geom_polygon(data = compare, fill = NA, color = "black", linetype = "solid") +
        geom_text(data = compare, aes(label = dir)) +
        coord_fixed() +
        labs(x = "E-W", y = "N-S")
      plot
    }
    
  })
  
  output$crownText <- renderText({
    if (input$name != "All") { 
      data <- filtered_data()
      compare <- comparisonData()
      uN <- data$Crown_North
      uE <- data$Crown_East
      uS <- data$Crown_South
      uW <- data$Crown_West
      cN <- compare$Crown_North
      cE <- compare$Crown_East
      cS <- compare$Crown_South
      cW <- compare$Crown_West
      u <- (uN + uE + uS + uW)
      c <- (cN + cE + cS + cW)
      diff <- abs(u - c)
      uName <- data$Name
      cName <- compare$Name
      text <- paste0("Crown Width: ", uName, " vs. ", cName,", ", diff, " cm difference")
      #text <- paste0("In total, ", uName, "'s measurements have a difference of ", diff, " cm compared to ", cName, "'s.")
      text
    } else {
      text <- ""
      text
    }    
  })
  
  output$dbhplot <- renderPlot({
    if (input$name != "All") {
      data <- filtered_data()
      compare <- comparisonData()
      omtrek <- data$Circumference
      d <- omtrek / pi
      refCircle <- circleFun(compare$Circumference/pi)
      userCircle <- circleFun(d)
      diff <- abs(data$Circumference - compare$Circumference)
      text <- paste0(diff, " cm")
      uName <- data$Name
      cName <- compare$Name
      plot <- ggplot(refCircle, aes(x,y)) +
        geom_path(color = "black", aes(linetype = "solid")) +
        geom_path(data = userCircle, color = "brown", aes(linetype = "dashed")) +
        #geom_arc2(data = refCircle, aes(x0 = x0, y0 = y0, r = r, alpha = 0.001, fill = "white")) +
        #geom_arc2(data = userCircle, aes(x0 = x0, y0 = y0, r = r, alpha = 0.001, fill = "white")) +
        scale_linetype_manual(name = "", labels = c(uName, cName), values = c("solid", "dashed")) +
        #geom_text(data = userCircle, aes(x = 0, y = 0, label = r)) +
        coord_fixed() +
        guides(color = F) +
        labs(x = "", y = "") +
        annotate("text", x = 0, y = 0, label = text, colour = "black", size = 10)
      plot
    } else {
      compare <- machine
      omtrek <- compare$Circumference
      d <- omtrek / pi
      circle <- circleFun(d)
      plot <- ggplot(circle, aes(x,y)) +
        geom_path(aes(linetype = "solid")) +
        #geom_circle(data = circle, fill = "black", aes(x0 = x0, y0 = y0, r = r, alpha = 0.3)) +
        coord_fixed() +
        theme(legend.position = "none") +
        labs(x = "", y = "")
      plot
    }
  })
  
  output$dbhText <- renderText({
    if (input$name != "All") { 
      data <- filtered_data()
      compare <- comparisonData()
      user <- data$Circumference
      ref <- compare$Circumference
      diff <- abs(user - ref)
      uName <- data$Name
      cName <- compare$Name
      text <- paste0("Circumference: ", uName," vs. ", cName,", ", diff, " cm difference")
      text
    } else {
      text <- ""
      text
    }
  })
  
  output$heightPlot <- renderPlot({
    
    if (input$name != "All") {
      data <- filtered_data()
      compare <- comparisonData()
      labels <- c(data$Name, compare$Name)
      height <- c(data$Height_Total, compare$Height_Total)
      dfHeight <- data.frame(labels, height)
      plot <- ggplot(dfHeight) + geom_col(fill = "brown", aes(labels, y = height, alpha = 0.8)) + geom_text(aes(x = labels, y = height + 0.5, label = height, size = 5)) + labs(x = "Source", y = "Height") + theme(legend.position = "none")
      #barplot(height, names.arg = labels, ylab = "Height", col = "green", main = "Height Comparison", ylim = c(0, 10), alpha = 0.3)
      plot
    } else {
      compare <- comparisonData()
      labels <- c(compare$Name)
      height <- c(compare$Height_Total)
      dfHeight <- data.frame(labels, height)
      plot <- ggplot(dfHeight) + geom_col(fill = "brown", aes(labels, y = height, alpha = 0.8)) + geom_text(aes(x = labels, y = height + 0.5, label = height, size = 5)) + labs(x = "Source", y = "Height") + theme(legend.position = "none")
      #barplot(height, names.arg = labels, ylab = "Height", col = "green", main = "Height Comparison", ylim = c(0, 10))
      plot
    }
  })
  
  output$heightText <- renderText({
    if (input$name != "All") {
      data <- filtered_data()
      compare <- comparisonData()
      uName <- data$Name
      cName <- compare$Name
      uHeight <- data$Height_Total * 100
      cHeight <- compare$Height_Total * 100
      diff <- abs(cHeight - uHeight)
      text <- paste0("Tree Height: ", uName," vs. ", cName,", ", diff, " cm difference")
      text
    } else {
      text <- ""
      text
    }
  })
  
  output$graph <- renderUI({
    if (input$manualExplore == "Crown North") {
      tags$img(src = "https://pbs.twimg.com/media/DfaiYicXkAAstBy.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    }  else if (input$manualExplore == "Crown East") {
      tags$img(src = "https://pbs.twimg.com/media/DfaiWLSXkAA3h2v.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    } else if (input$manualExplore == "Crown South") {
      tags$img(src = "https://pbs.twimg.com/media/DfaiYjKXUAAaExt.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    } else if (input$manualExplore == "Crown West") {
      tags$img(src = "https://pbs.twimg.com/media/DfaiYiUWAAEWTB9.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    } else if (input$manualExplore == "Circumference") {
      tags$img(src = "https://pbs.twimg.com/media/Dfe71IaWkAMKTaw.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    } else if (input$manualExplore == "Tree Height") {
      tags$img(src = "https://pbs.twimg.com/media/DfaiWLhX4AEg2MN.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    } else if (input$manualExplore == "Crown Overall") {
      tags$img(src = "https://pbs.twimg.com/media/DfezZJ_XUAEOY4I.jpg", width = 700, style = "display: block; margin-left: auto; margin-right: auto;")
    }
  })
  
}

shinyApp(ui = ui, server = server)