

fluidPage(
  
                    titlePanel("H1-B Visa Program"),
  
                    sidebarLayout(
     
                             sidebarPanel(
      
                                        selectizeInput(inputId = "bank",
                                                       label = "Banks",
                                                       choices = unique(banks$Employer)),
                                     
                                     
                                        selectizeInput(inputId = "tech",
                                                      label = "Tech Companies",
                                                      choices = unique(tech$Employer), selected = "AAPL"),
                                     
                                     
                                        selectizeInput(inputId = "Year_States",
                                                      label = "Top States by Year",
                                                      choices = unique(df_all$Fiscal.Year)),
                                  
                                         selectizeInput(inputId = "Year_Cities",
                                                      label = "Top Cities by Year",
                                                      choices = unique(df_all$Fiscal.Year))
                       
                                        ),
    
                              mainPanel(
                                 tabsetPanel(type = "tabs", 
                                             tabPanel("Outcomes", fluidRow
                                                      (
                                                      column(6, plotOutput("approved")),
                                                      column(6, plotOutput("denied"))
                                                 
                                                      ))
                                                      ,
                                             tabPanel("Banks", fluidRow
                                                      
                                                      (
                                                      column(6, plotOutput("count1")),
                                                      column(6, plotOutput("count2"))
                                                      )),
                                              
                                             tabPanel("Tech companies", fluidRow
                                                      
                                                      (
                                                      column(6, plotOutput("count3")),
                                                      column(6, plotOutput("count4"))
                                                      )),
                                             
                                             tabPanel("Top 5 States", plotOutput("count5")),
                                             
                                             tabPanel("Top 5 cities", plotOutput("count6"))
 
                                             ) 
                                        )
                                    )
                  )

 
      
     
    




       
