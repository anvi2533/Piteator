#source("install_pack.R")
source("Load_lib.R")

#Location of the GPX files
path = paste(getwd(),"/GPX/",sep = "")

files <- list.files(path)
files <- unique(files)

#check if update is needed
nr_files <- length(files)

check <- readRDS("nr_files.RDS")

datalist = list()
date_time <- c()
training_date <- c()

if(nr_files != check){
  
  #create distance vector
  source("fn_distance_vector.R")
  distance <- fn_distance_vector()
  saveRDS(distance,"distance.RDS")
  
  #create date time vector
  source("fn_datetime_vector.R")
  date_time <- fn_datetime_vector()
  saveRDS(date_time,"date_time.RDS")
  
  #create duration vector
  source("fn_duration_vector.R")
  duration <- fn_duration_vector()
  saveRDS(duration,"duration.RDS")

  saveRDS(nr_files,"nr_files.RDS")
  saveRDS(nr_files,"Piteator/nr_files.RDS")
  
}

source("create_df_from_vectors.R", encoding = 'ISO-8859-1')

#Distance 2022 so far
dist_2022 <- df[!is.na(df$CY),]
current_stat <- sum(dist_2022$Distance)
m_left <- (1610000 - current_stat)/10000
print(paste(round(m_left,2), "mil"))

source("trendline.R", encoding = 'ISO-8859-1')
saveRDS(p,"trendline.RDS")
saveRDS(p,"Piteator/trendline.RDS")
readRDS("trendline.RDS")

source("Locus.R")
saveRDS(n,"piteator.RDS")
saveRDS(n,"Piteator/piteator.RDS")
readRDS("piteator.RDS")
#street view: http://www.instantstreetview.com/s/61.14598,17.03262

path = paste(getwd(),"/GPX/",files[length(files)],sep = "")

source("LastRun.R")
saveRDS(m,"latest_run.RDS")
saveRDS(m,"Piteator/latest_run.RDS")
readRDS("latest_run.RDS")
saveRDS(speed_list,"Piteator/km_list.RDS")

#Goal
#====
w_left <- as.numeric((as.Date("2022-12-31") - Sys.Date())/7)
km_left <- m_left*10
goal <- paste("För att uppnå målet behöver jag cykla", round(km_left/w_left,2), "km per vecka")
saveRDS(goal,"Piteator/goal.RDS")
readRDS("Piteator/goal.RDS")

#Title
#=====
title <- "Piteå tur och retur 2022"
saveRDS(title,"Piteator/title.RDS")
readRDS("Piteator/title.RDS")

texts <- c()
texts$title <- "Piteå tur och retur 2022"
texts$trend_dev <- paste(dev,"km från ideallinjen")
texts$goal_w <- paste("För att uppnå målet behöver jag cykla", round(km_left/w_left,2), "km per vecka")
saveRDS(texts,"Piteator/texts.RDS")
readRDS("Piteator/texts.RDS")


#Deviation from trendline
#========================
real_data <- real_data[real_data$type == substr(Sys.Date(),1,4),]
last_date <- real_data$Day[nrow(real_data)]
dev <- round(trendline_data$cum[last_date]-real_data$cum[nrow(real_data)],0)
dev_text <- paste(dev,"km frÃ¥n ideallinjen")
saveRDS(dev_text,"Piteator/dev_text.RDS")
readRDS("Piteator/dev_text.RDS")

source("Metrics.R")
saveRDS(metrics,"metrics.RDS")
saveRDS(weekly,"weekly.RDS")
saveRDS(monthly,"monthly.RDS")
saveRDS(yearly,"yearly.RDS")
readRDS("metrics.RDS")

saveRDS(metrics,"Piteator/metrics.RDS")
saveRDS(weekly,"Piteator/weekly.RDS")
saveRDS(monthly,"Piteator/monthly.RDS")
saveRDS(yearly,"Piteator/yearly.RDS")

#library(shiny)
#runApp("Piteator")

#install.packages('rsconnect')

rsconnect::setAccountInfo(name='anvi2533',
                          token='026B936A5A75EBDFDAE8AE09012C4BF0',
                          secret='fAQVZf7CdgMV8pUsG0l9Ud3x9pLZ3qhd8vBOdqgG')

library(rsconnect)
rsconnect::deployApp("Piteator", forceUpdate = T)









