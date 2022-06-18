library(tibble)

#Metrics
df <- metrics_df

##Weekly
tw_dist <- round(sum(df$Distance[!is.na(df$CW)])/1000,1)
tw_pace <- round(mean(df$Pace[!is.na(df$CW)]),1)
tw_dura <- round(sum(df$Duration[!is.na(df$CW)]),2)
tw_activities <- nrow(df[!is.na(df$CW),])

lw_dist <- round(sum(df$Distance[!is.na(df$LW)])/1000,1)
lw_pace <- round(mean(df$Pace[!is.na(df$LW)]),1)
lw_dura <- round(sum(df$Duration[!is.na(df$LW)]),2)
lw_activities <- nrow(df[!is.na(df$LW),])

type <- rep(c("Distance", "Avg pace", "Duration", "Activities"),times = 2)
period <- rep(c("This Week","Last Week"), each = 4)
values <- c(tw_dist,tw_pace,tw_dura,tw_activities,lw_dist,lw_pace,lw_dura,lw_activities)

weekly <- data.frame(type,period,values)

##Monthly
tm_dist <- round(sum(df$Distance[!is.na(df$CM)])/1000,1)
tm_pace <- round(mean(df$Pace[!is.na(df$CM)]),1)
tm_dura <- round(sum(df$Duration[!is.na(df$CM)]),2)
tm_activities <- nrow(df[!is.na(df$CM),])

lm_dist <- round(sum(df$Distance[!is.na(df$LM)])/1000,1)
lm_pace <- round(mean(df$Pace[!is.na(df$LM)]),1)
lm_dura <- round(sum(df$Duration[!is.na(df$LM)]),2)
lm_activities <- nrow(df[!is.na(df$LM),])

type <- rep(c("Distance", "Avg pace", "Duration", "Activities"),times = 2)
period <- rep(c("This Month","Last Month"), each = 4)
values <- c(tm_dist,tm_pace,tm_dura,tm_activities,lm_dist,lm_pace,lm_dura,lm_activities)

monthly <- data.frame(type,period,values)

##Yearly
ty_dist <- round(sum(df$Distance[!is.na(df$CY)])/1000,1)
ty_pace <- round(mean(df$Pace[!is.na(df$CY)]),1)
ty_dura <- round(sum(df$Duration[!is.na(df$CY)]),2)
ty_activities <- nrow(df[!is.na(df$CY),])

ly_dist <- round(sum(df$Distance[!is.na(df$LY)])/1000,1)
ly_pace <- round(mean(df$Pace[!is.na(df$LY)]),1)
ly_dura <- round(sum(df$Duration[!is.na(df$LY)]),2)
ly_activities <- nrow(df[!is.na(df$LY),])

type <- rep(c("Distance", "Avg pace", "Duration", "Activities"),times = 2)
period <- rep(c("This Year","Last Year"), each = 4)
values <- c(ty_dist,ty_pace,ty_dura,ty_activities,ly_dist,ly_pace,ly_dura,ly_activities)

yearly <- data.frame(type,period,values)

metrics <- tibble(rbind(weekly,monthly,yearly))

#print(metrics)

type <- c("Distance", "Avg pace", "Duration", "Activities")
tw <- c(tw_dist,tw_pace,tw_dura,tw_activities)
lw <- c(lw_dist,lw_pace,lw_dura,lw_activities)
tm <- c(tm_dist,tm_pace,tm_dura,tm_activities)
lm <- c(lm_dist,lm_pace,lm_dura,lm_activities)
ty <- c(ty_dist,ty_pace,ty_dura,ty_activities)
ly <- c(ly_dist,ly_pace,ly_dura,ly_activities)
weekly <- tibble("Type" = type,"This week" = tw, "Last week" = lw)
monthly <- tibble("Type" = type,"This month" = tm, "Last month" = lm)
yearly <- tibble("Type" = type,"This year" = ty, "Last year" = ly)

df
