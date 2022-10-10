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


##plot 2
dev.off()

png('~/Desktop/plot2.png', width = 480, height = 480)
plot(y = subs$Global_active_power, x = subs$dt2, type = "l", ylab = "Global Active power (kilowatts)", xlab = "")
dev.off()
