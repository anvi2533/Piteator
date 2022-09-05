#Current location Alunda - Piteå - Alunda
cum_dist <- readRDS("cumulative_distance.RDS")
xy_c <- readRDS("cumulative_distance_coords.RDS")

closest_value <- which.min(abs(cum_dist - current_stat))

l2 <- paste(round(current_stat*100/max(cum_dist),1),"% (", sep="")
l3 <- paste(round(current_stat/1000,1),"/",round(max(cum_dist)/1000,1)," km)", sep="")

content <- paste(sep = "<br/>",
                 "<b>Här är jag nu</b>",
                 l2,l3)

content <- paste(sep = "",
                 l2,l3)

longitude <- xy_c[closest_value,1]
latitude <- xy_c[closest_value,2]

#Celebrations
#============
#Get coordinates
closest_value <- which.min(abs(cum_dist - 1500000))
celebration <- c(45238)
longitude_c <- xy_c[celebration,1]
latitude_c <- xy_c[celebration,2]
celebration <- c(56199)
longitude_c2 <- xy_c[celebration,1]
latitude_c2 <- xy_c[celebration,2]
celebration <- c(69534)
longitude_c3 <- xy_c[celebration,1]
latitude_c3 <- xy_c[celebration,2]
celebration <- c(73872)
longitude_c4 <- xy_c[celebration,1]
latitude_c4 <- xy_c[celebration,2]

#Bike icon

Bike <- makeIcon(
  iconUrl = 'Markers/Cykel.png',
  iconWidth = 102.28, iconHeight = 62.15,
  iconAnchorX = 47.28, iconAnchorY = 47.15
)

#Celebration icon
CelebrationIcon_1000 <- makeIcon(
  #iconUrl = "https://leafletjs.com/SlavaUkraini/examples/custom-icons/leaf-green.png",
  iconUrl = 'Markers/Celebration_1000.png',
  iconWidth = 38, iconHeight = 38,
  iconAnchorX = 19, iconAnchorY = 38
)

CelebrationIcon_1250 <- makeIcon(
  iconUrl = 'Markers/Celebration_1250.png',
  iconWidth = 38, iconHeight = 38,
  iconAnchorX = 19, iconAnchorY = 38
)

CelebrationIcon_1500 <- makeIcon(
  iconUrl = 'Markers/Celebration_1500.png',
  iconWidth = 38, iconHeight = 38,
  iconAnchorX = 19, iconAnchorY = 38
)

CelebrationIcon_goal <- makeIcon(
  iconUrl = 'Markers/Celebration_goal.png',
  iconWidth = 38, iconHeight = 38,
  iconAnchorX = 19, iconAnchorY = 38
)

n <- leaflet() %>%
  addTiles() %>%
  setView(lng = longitude, lat = latitude, zoom = 06) %>%
  addMarkers(lng = longitude, lat = latitude, icon = Bike,
             label = content,
             labelOptions = labelOptions(noHide = F, direction = "bottom",
                                         style = list(
                                           "color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "normal",
                                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "12px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  addMarkers(lng = longitude_c, lat = latitude_c,icon = CelebrationIcon_1000,
             label = "",
             labelOptions = labelOptions(noHide = F, textOnly = TRUE, direction = "bottom",
                                         style = list(
                                           #"color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "normal",
                                           #"box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  addMarkers(lng = longitude_c2, lat = latitude_c2,icon = CelebrationIcon_1250,
             label = "SPA",
             labelOptions = labelOptions(noHide = T, textOnly = TRUE, direction = "bottom",
                                         style = list(
                                           #"color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "normal",
                                           #"box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  addMarkers(lng = longitude_c3, lat = latitude_c3,icon = CelebrationIcon_1500,
             #label = label_c,
             labelOptions = labelOptions(noHide = T, textOnly = TRUE, direction = "bottom",
                                         style = list(
                                           #"color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "normal",
                                           #"box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  addMarkers(lng = longitude_c4, lat = latitude_c4,icon = CelebrationIcon_goal,
             #label = label_c,
             labelOptions = labelOptions(noHide = T, textOnly = TRUE, direction = "bottom",
                                         style = list(
                                           #"color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "normal",
                                           #"box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  addPolylines(xy_c[,1], xy_c[,2])

leaflet() %>%
  addTiles() %>%
  setView(lng = longitude, lat = latitude, zoom = 06) %>%
  addMarkers(lng = longitude, lat = latitude)


print(n)