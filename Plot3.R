## Download file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('.household_power_consumption.txt')){
  download.file(fileurl,'./household_power_consumption.txt', method = "curl")
}


# Loading Libraries
library(tidyverse)
library(lubridate)


## Loading data

PowerConsumption <- read_delim("household_power_consumption.txt",
                               delim = ";",
                               na    = c("?"),
                               col_types = list(col_date(format = "%d/%m/%Y"),
                                                col_time(format = ""),
                                                col_number(),
                                                col_number(),
                                                col_number(),
                                                col_number(),
                                                col_number(),
                                                col_number(),
                                                col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

## Combine date and time

data <- mutate(PowerConsumption, datetime = ymd_hms(paste(Date, Time)))


## Plot3: Energy sub metering over time

# create plot

plot(Sub_metering_1 ~ datetime, data, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)

lines(Sub_metering_2 ~ datetime, data, type = "l", col = "red")

lines(Sub_metering_3 ~ datetime, data, type = "l", col = "blue")

legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1)

# save plot

dev.copy(png, "plot3.png",
        width  = 480,
        height = 480)

dev.off()
