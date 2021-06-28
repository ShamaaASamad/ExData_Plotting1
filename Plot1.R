
##Download file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('.household_power_consumption.txt')){
  download.file(fileurl,'./household_power_consumption.txt', method = "curl")
  unzip("household_power_consumption.txt", exdir = getwd())
}

#Loading Libraries
library(tidyverse)
library(data.table)
library(lubridate)


##Loading data

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


##Plot 1: Global Active Power

#create histogram
hist(PowerConsumption$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")

#save plot as png
dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

dev.off()
