
#trendline to achive goal
V1 <- seq(1,365,1)
df_1 <- data.frame("Day" = V1,"type" = "ideal", "km" = c(4411.983/1000))
df_1$cum <- cumsum(df_1$km)

df_2 <- data.frame("Day" = df$Yday, "type" = substring(df$DateTime,1,4), "km" = df$Distance/1000, "CY" = df$CY, "LY" = df$LY)
df_2 <- df_2[!is.na(df_2$CY),c(1,2,3)]
df_2$cum <- cumsum(df_2$km)

df_3 <- data.frame("Day" = df$Yday, "type" = substring(df$DateTime,1,4), "km" = df$Distance/1000, "CY" = df$CY, "LY" = df$LY)
df_3 <- df_3[!is.na(df_3$LY),c(1,2,3)]
df_3$cum <- cumsum(df_3$km)

df_4 <- rbind.data.frame(df_1,df_2,df_3)

trendline_data <- df_1
real_data <- rbind.data.frame(df_2,df_3)

library(ggplot2)

p <- ggplot(df_4, aes(x = Day, y = cum, color = type)) + geom_line()
p <- p + labs(x = "Day of year", y = "Cumulative distance (km)") #+ theme(legend.position = "none") 
