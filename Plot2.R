
## Download file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('.household_power_consumption.txt')){
  download.file(fileurl,'./household_power_consumption.txt', method = "curl")
}

# Loading Libraries
library(tidyverse)
library(data.table)
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


## Plot 2: Global active power over time 

plot(Global_active_power ~ datetime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

# Save Plot 

dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

dev.off()

