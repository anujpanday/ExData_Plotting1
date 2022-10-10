library(tidyverse)
library(lubridate)


#read in data

power<-read.table("~/Desktop/household_power_consumption.txt", sep = ";", header = T) %>% as_tibble


###mutate columns to correct format
power2<-power %>% mutate(Date = dmy(Date)) %>% 
  mutate_at(.,vars(Global_active_power:Sub_metering_3), as.numeric)

power3 <- power2 %>% mutate(dt1 = paste(Date, Time))

subs<-power3 %>% filter(Date >= '2007-02-01', Date <='2007-02-02') %>% 
  mutate(dt2 = as.POSIXct(dt1))



##plot 3
dev.off()
png('~/Desktop/plot3.png', width = 480, height = 480)

plot(x = subs$dt2,, y = subs$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")

lines(y = subs$Sub_metering_2, x = subs$dt2, type = "l", col = "red")
lines(y = subs$Sub_metering_3, x = subs$dt2, type = "l", col = "blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red", "blue"), lty = c(1,1,1))

dev.off()