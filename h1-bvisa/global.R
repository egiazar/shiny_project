library(shiny)
library(dplyr)
library(ggplot2)
library(readr)
library(ggthemr)
ggthemr("flat")





df19 = read.csv("h1b_datahubexport-2019.csv", stringsAsFactors = FALSE)

df18 = read.csv("h1b_datahubexport-2018.csv", stringsAsFactors = FALSE)

df17 = read.csv("h1b_datahubexport-2017.csv", stringsAsFactors = FALSE)

df16 = read.csv("h1b_datahubexport-2016.csv", stringsAsFactors = FALSE)

df15 = read.csv("h1b_datahubexport-2015.csv", stringsAsFactors = FALSE)

df14 = read.csv("h1b_datahubexport-2014.csv", stringsAsFactors = FALSE)




df_all = rbind(df14, df15, df16, df17, df18, df19)