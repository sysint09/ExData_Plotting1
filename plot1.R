## load data
## setwd("DataScience/04_Exploratory_Data_Analysis/Course Project")
library(sqldf)
filename<-c("household_power_consumption.txt")
data <- read.csv.sql(filename, sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'",sep=";")

## set plot
with(data,hist(Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power"))

readline(prompt = "Before generate plot on PNG device ...please press one key ......")
## COPY on dev file PNG
dev.copy(png,file="plot1.png",type="windows",bg="transparent")## width,height=480 are default values
## close dev
dev.off()
graphics.off()