fn_hhmmss <- function(x) {
  
  #timmar
  if(floor(x)<10) {
    h <- paste("0",floor(x),sep="")
  } else {h <- paste("",floor(x),sep="")}
  #min
  y <- (x-floor(x))*60
  if(floor(y)<10) {
    m <- paste("0",floor(y),sep="")
  } else {m <- paste("",floor(y),sep="")}
  z <- (y-floor(y))*60
  if(floor(z)<10) {
    s <- paste("0",floor(z),sep="")
  } else {s <- paste("",floor(z),sep="")}
  
  return(paste(h,":",m,":",s,sep=""))
  
}