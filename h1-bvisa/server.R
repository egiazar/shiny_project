


df_all$Initial.Approvals = as.numeric(gsub(",","", as.character(df_all$Initial.Approvals)))

df_all$Initial.Denials = as.numeric(gsub(",","", as.character(df_all$Initial.Denials)))


status = df_all %>% group_by(Fiscal.Year) %>% summarise(Num.Approved = sum(na.omit(Initial.Approvals)), Num.Denied = sum(na.omit(Initial.Denials)))

function(input, output) {
  
  
   banks_re <- reactive({
  
     banks = df_all %>% group_by(Fiscal.Year) %>% mutate(.,Employer =case_when(str_detect(Employer, "GOLDMAN SACHS") ~ "GS", 
                                                                            str_detect(Employer, "JPMORGAN") ~ "JPM",
                                                                            str_detect(Employer, "BANK OF AMERICA") ~ "BofA", 
                                                                            str_detect(Employer, "MORGAN STANLEY") ~ "MS", 
                                                                            str_detect(Employer, "CITIGROUP") ~ "Citi")) %>% filter(Employer !='NA')%>% group_by(Fiscal.Year, Employer) %>% summarise(Approved =sum(na.omit(Initial.Approvals)), 
                                                    Denied = sum(na.omit(Initial.Denials)))  %>% filter(., Employer == input$bank)
  
                       })


   tech_re <- reactive({
  
  
     tech = df_all %>% group_by(Fiscal.Year) %>% mutate(.,Employer = case_when(str_detect(Employer, "FACEBOOK") ~ "FB",
                                                                            str_detect(Employer, "APPLE") ~ "AAPL",
                                                                            str_detect(Employer, "AMAZON") ~ "AMZN", 
                                                                            str_detect(Employer, "MICROSOFT CORPORATION") ~ "MSFT",
                                                                            str_detect(Employer, "GOOGLE") ~ "GOOGL")) %>% filter(Employer !='NA') %>% group_by(Fiscal.Year, Employer) %>% summarise(Approved =sum(na.omit(Initial.Approvals)), 
                                                    Denied = sum(na.omit(Initial.Denials))) %>% filter(., Employer == input$tech) 
  
                      })



  
   output$approved <- renderPlot({

       status %>% ggplot(., aes(x = Fiscal.Year, y = Num.Approved)) + geom_col(fill= "blue") + labs(x = "Year", y = "Approved") + scale_y_continuous(labels = scales::comma)
    
                                })
  
   output$denied <- renderPlot({
    
       status %>% ggplot(., aes(x = Fiscal.Year, y = Num.Denied)) + geom_col(fill= "red") +labs(x = "Year", y = "Denied")
                                 })
 
   output$count1 <- renderPlot({
  
               banks_re() %>% ggplot(aes(x = Fiscal.Year, y = Approved))  + 
               geom_path(color= "blue") + labs(x = "Year", title = "Approved") + 
               theme(plot.title = element_text(hjust = 0.5)) 
      
                            })
                
   output$count2 <- renderPlot({
    
               banks_re() %>% ggplot(aes(x = Fiscal.Year, y = Denied))  + 
               geom_path(color= "red") + labs(x = "Year", title = "Denied") + 
               theme(plot.title = element_text(hjust = 0.5)) 
    
                               })
  
  
   output$count3 <- renderPlot({
    
              tech_re() %>% ggplot(aes(x = Fiscal.Year, y = Approved))  + 
              geom_path(color= "blue") + labs(x = "Year", title = "Approved") + 
              theme(plot.title = element_text(hjust = 0.5))
    
                              })
   
  output$count4 <- renderPlot({
    
              tech_re() %>% ggplot(aes(x = Fiscal.Year, y = Denied))  + 
              geom_path(color= "red") + labs(x = "Year", title = "Denied") + 
              theme(plot.title = element_text(hjust = 0.5))
    
                             })
  
  
  output$count5 <- renderPlot({
    
    df_all %>% filter(., Fiscal.Year == input$Year_States) %>% group_by(State) %>% summarise(Approved =sum(na.omit(Initial.Approvals)), Denied = sum(na.omit(Initial.Denials)))%>% arrange(., desc(Approved))%>% head(., 10) %>% ggplot(., aes(x = reorder(State, Approved), y = Approved))+ geom_col(fill = "blue") + labs(x = "States") + coord_flip()
    
    
                             })
  
  
 output$count6 <- renderPlot({
   
   df_all %>% filter(., Fiscal.Year == input$Year_Cities) %>% group_by(City)  %>% summarise(Approved =sum(na.omit(Initial.Approvals)), Denied = sum(na.omit(Initial.Denials))) %>% arrange(., desc(Approved))%>% head(., 10) %>% ggplot(., aes(x = reorder(City, Approved), y = Approved))+ geom_col(fill = "red") + labs(x = "Cities") + coord_flip()
   
                            })
 
 
 
 }
  
  
  
  
  
