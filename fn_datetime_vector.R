#function duration vector

fn_datetime_vector <- function() {
  
  datalist <- list()
  date_time <- c()
  
  for (i in 1:length(files)) {
    
    p = read_sf(paste(getwd(),"/GPX/",files[i],sep=""), layer = "track_points")
    
    datalist[[i]] <- data.frame(p$time,st_coordinates(p))
    
    date_time <- datalist[[i]][,1]
    
    #duration[i] <- as.numeric(difftime(max(date_time),date_time[1],units = "hours"))
    
    training_date[i] <- as.character(datalist[[i]][1,1])
    
  }
  
  return(training_date)
  
}