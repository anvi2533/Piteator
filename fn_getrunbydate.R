getrunbydate <- function() {
  
  file <- max(files)
  path = paste(sep="","C:/repos/GPS_2022/GPX/",file)
  
  p = read_sf(path, layer = "track_points")
  df <- data.frame(p$time,st_coordinates(p))
  max_row = nrow(df)-1
  y = c(0)
  for(i in 1:max_row){
    
    x <- distm(df[i,2:3],df[i+1,2:3],fun = distHaversine)
    
    y <- c(y,x)
    
    i = i+1
    
  }
  
  length(y)
  nrow(df)
  
  coords <- data.frame("X"=df$X,"Y"=df$Y)
  
  df$distance <- y
  df$cum <- cumsum(df$distance)
  
  #find values
  kms <- seq(1000,100000,1000)
  max_pos <- length(kms)
  
  #set km marks
  my_list = df[1,]
  for(i in 1:max_pos) {
    
    closest_value <- which.min(abs(df$cum - kms[i]))
    
    new <- df[closest_value,]
    my_list[nrow(my_list) + 1,] <- new
    
  }
  
  my_list <- subset(my_list,my_list$cum >= 0)
  
  my_list <- subset(my_list,my_list$cum < max(my_list$cum))
  
  #Kilometertider senaste rundan
  
  (df$cum[24]/1000*60)/as.numeric(df$p.time[24] - df$p.time[1])
  
  kms <- c(1:nrow(my_list))
  speed <- c()
  
  for(i in kms) {
    
    speed[i] <- ((my_list$cum[i+1]-my_list$cum[i])/1000*60)/as.numeric(my_list$p.time[i+1] - my_list$p.time[i])
    
  }
  km_list <- data.frame(kms,speed)
  km_list <- na.omit(km_list)
  km_list$speed <- round(km_list$speed,1) 
  names(km_list)[1] <- "Kilometer"
  names(km_list)[2] <- "km/h"
  print(my_list)
  return(km_list)
   
}