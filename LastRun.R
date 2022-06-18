#Last run

file <- max(files)
path = paste(sep="","C:/repos/GPS_2022/GPX/",file)

p = read_sf(path, layer = "track_points")
time_coords <- data.frame(p$time,st_coordinates(p))

max_row = nrow(time_coords)-1

y = c(0)
for(i in 1:max_row){
  
  x <- distm(time_coords[i,2:3],time_coords[i+1,2:3],fun = distHaversine)
  
  y <- c(y,x)
  
  i = i+1
  
}

time_coords$distance <- y
time_coords$cum <- cumsum(time_coords$distance)

#find values
kms <- c(0)
km_seq <- seq(1000,100000,1000)
kms <- c(kms,km_seq)

#set km marks

z <- c()

for (i in kms) {
  
  x <- closest_value <- which.min(abs(time_coords$cum - i))
  
  z <- c(z,x)
  
}

marker_list <- as.numeric(names(table(z)))

km_marker_list <- time_coords[marker_list,]

#trim last marker
last_row <- nrow(km_marker_list)-1
km_markers <- km_marker_list[2:last_row,]


#map markers

m <- leaflet() %>%
  addTiles() %>%
  #addAwesomeMarkers(df[1,1],df[1,2],icon = icon.start) %>%
  #addAwesomeMarkers(df[nrow(df),1],df[nrow(df),2],icon = icon.stop) %>%
  addLabelOnlyMarkers(km_markers$X,km_markers$Y,label = round(km_markers$cum/1000,0),
                      labelOptions = labelOptions(noHide = T, direction = "top",
                                                  style = list(
                                                    #"color" = "red",
                                                    #"font-family" = "serif",
                                                    "font-weight" = "bold",
                                                    #"box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                                    "font-size" = "10px",
                                                    "background-color" = "#87CEEB"
                                                    #"border-color" = "red"
                                                  ))) %>%
  addPolylines(time_coords$X,time_coords$Y)


print(m)

speed <- c()


for(i in 1:nrow(km_marker_list)-1) {
  
  speed[i] <- (km_marker_list$cum[i+1]-km_marker_list$cum[i])/1000*60/as.numeric(km_marker_list$p.time[i+1]-km_marker_list$p.time[i])

}

speed_list <- data.frame("km" = 1:length(speed),"km_h" = round(speed,1))
names(speed_list)[1] <- "Kilometer"
names(speed_list)[2] <- "km/h"

#Snabbaste liknande runda

current_runda <- metrics_df$Runda[nrow(metrics_df)]
similar_runda <- metrics_df[metrics_df$Runda == current_runda & metrics_df$CY == 1,]
similar_runda <- similar_runda[!is.na(similar_runda$Runda),]
fastest_runda <- similar_runda$DateTime[similar_runda$Pace == max(similar_runda$Pace)]
filename_fast <- paste(substring(fastest_runda,1,10),"-",substring(fastest_runda,12,13),substring(fastest_runda,15,16),substring(fastest_runda,18,19),".gpx",sep="")

file <- filename_fast
path = paste(sep="","C:/repos/GPS_2022/GPX/",file)

p = read_sf(path, layer = "track_points")
time_coords <- data.frame(p$time,st_coordinates(p))

max_row = nrow(time_coords)-1

y = c(0)
for(i in 1:max_row){
  
  x <- distm(time_coords[i,2:3],time_coords[i+1,2:3],fun = distHaversine)
  
  y <- c(y,x)
  
  i = i+1
  
}

time_coords$distance <- y
time_coords$cum <- cumsum(time_coords$distance)

#find values
kms <- c(0)
km_seq <- seq(1000,100000,1000)
kms <- c(kms,km_seq)

#set km marks

z <- c()

for (i in kms) {
  
  x <- closest_value <- which.min(abs(time_coords$cum - i))
  
  z <- c(z,x)
  
}

marker_list <- as.numeric(names(table(z)))

km_marker_list <- time_coords[marker_list,]

#trim last marker
last_row <- nrow(km_marker_list)-1
km_markers <- km_marker_list[2:last_row,]

speed <- c()


for(i in 1:nrow(km_marker_list)-1) {
  
  speed[i] <- (km_marker_list$cum[i+1]-km_marker_list$cum[i])/1000*60/as.numeric(km_marker_list$p.time[i+1]-km_marker_list$p.time[i])
  
}

speed_list2 <- data.frame("km" = 1:length(speed),"km_h" = round(speed,1))
names(speed_list2)[1] <- "Kilometer"
names(speed_list2)[2] <- "km/h"

speed_list$best_run <- speed_list2$`km/h`





