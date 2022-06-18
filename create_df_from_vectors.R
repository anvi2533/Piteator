
#Join vectors into a data_frame
df <- c()
df <- data.frame(readRDS("date_time.RDS"),readRDS("duration.RDS"),readRDS("distance.RDS"))
names(df)[1] <- "DateTime"
names(df)[2] <- "Duration"
names(df)[3] <- "Distance"

Current_Year <- substr(Sys.Date(),1,4)
Last_Year <- as.numeric(substr(Sys.Date(),1,4))-1
Current_Week <- strftime(Sys.Date(), format = "%V")
Last_Week <- as.numeric(Current_Week)-1
Current_Month <- substr(Sys.Date(),1,7)
#Last_Month
current <- c("01","02","03","04","05","06","07","08","09","10","11","12")
prev <- c("12","01","02","03","04","05","06","07","08","09","10","11")
index <- match(substr(Sys.Date(),6,7), current)
#prev[index]
Last_Month <- paste(substring(Sys.Date(),1,5),prev[index],sep="")
#Day of year
library(lubridate)

#Add more columns
#length(distance)
#length(duration)
#nrow(df)
df$Pace <- distance/(1000*duration)
df$Week_nr <- strftime(df$DateTime, format = "%V")
df$Runda[df$Distance > 32700 & df$Distance < 32900] <- "Morkarla"
df$Runda[df$Distance > 13400 & df$Distance < 14500] <- "Löddby"
df$Runda[df$Distance > 26600 & df$Distance < 27200] <- "Voxome_Haberga"
df$Runda[df$Distance > 18100 & df$Distance < 18600] <- "Golvsta_Haberga"
df$Runda[df$Distance > 19700 & df$Distance < 20000 & substr(df$DateTime,1,4) == "2022"] <- "Special"
df$Runda[df$Distance > 36000 & df$Distance < 36700 & substr(df$DateTime,1,4) == "2022"] <- "Voxome_Löddby"
df$Runda[df$Distance > 50200 & df$Distance < 51250 & substr(df$DateTime,1,4) == "2022"] <- "Gimo-Fornbro"
df$Runda[120] <- "Special"
df$Yday <- yday(df$DateTime)
df$CY[substr(df$DateTime,1,4) == Current_Year] <- 1  
df$LY[substr(df$DateTime,1,4) == Last_Year] <- 1  
df$CM[substr(df$DateTime,1,7) == Current_Month] <- 1 
df$LM[substr(df$DateTime,1,7) == Last_Month] <- 1
df$CW[df$Week_nr == Current_Week & substr(df$DateTime,1,4) == Current_Year] <- 1 
df$LW[df$Week_nr == Last_Week & substr(df$DateTime,1,4) == Current_Year] <- 1

#sort ascending
df <- df[order(df$DateTime), ]

df[120:nrow(df),]

metrics_df <- df

#Position of last run
runda <- df$Runda[nrow(df)]
date <- as.Date(df$DateTime[nrow(df)])
runda_df <- df[df$Runda == runda & df$CY == 1,]
lista <- runda_df[!(is.na(runda_df$Runda)), ]
lista_desc <- lista[order(lista$Pace,decreasing = TRUE),]
position <- match(df$DateTime[nrow(df)],lista_desc$DateTime)
position_text <- paste("This run",date,"is in position",position,"out of",nrow(lista),runda,"runs")
saveRDS(position_text,"Piteator/pos_text.RDS")

#This run
lista_desc[position,]

#Best five runs
lista_desc$Date <- as.Date(lista_desc$DateTime)
lista_desc$Pace <- round(lista_desc$Pace,2)

source("fn_hhmmss.R")

for(i in 1:nrow(lista_desc)) {
  
  lista_desc$Duration_hhmmss[i] <- fn_hhmmss(lista_desc$Duration[i])
  
}

best_10 <- lista_desc[1:10,c(14,15,4)]
names(best_10)[2] <- "Duration"
saveRDS(best_10,"Piteator/best_10.RDS")


#Fastest Löddby
loddby <- df[df$Runda == "Löddby" & df$CY == 1,]
loddby <- loddby[!(is.na(loddby$Runda)), ]
for(i in 1:length(loddby$Duration)) {
  
  loddby$dur[i] <- fn_hhmmss(loddby$Duration[i])
  
}
loddby <- loddby[order(loddby$Pace,decreasing = TRUE),]
