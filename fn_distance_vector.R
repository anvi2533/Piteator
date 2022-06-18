fn_distance_vector <- function() {

  distance <- c()
  
  for (i in 1:nr_files) {
    
    p = read_sf(paste(getwd(),"/GPX/",files[i],sep=""), layer = "track_points")
    
    datalist[[i]] <- data.frame(p$time,st_coordinates(p))
    
    distance_list <- c()
    
    for(j in 1:nrow(datalist[[i]])) {
      
      point_1 <- c(datalist[[i]][j,2],datalist[[i]][j,3])
      point_2 <- c(datalist[[i]][j+1,2],datalist[[i]][j+1,3])
      
      x <- distm(point_1,point_2,fun = distHaversine)
      distance_list <- c(distance_list,x)
      
    }
    
    distance[i] <- sum(distance_list[!is.na(distance_list)])
    
  }

  return(distance)

}