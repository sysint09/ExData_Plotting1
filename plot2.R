## Take care: required package sqldf
##
## setwd("DataScience/04_Exploratory_Data_Analysis/Course Project")
##
## load data
library(sqldf)
filename<-c("household_power_consumption.txt")
data <- read.csv.sql(filename, sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'",sep=";")

## datetime management
datetime1<-paste(data$Date,data$Time)
datetime<-strptime(datetime1,format="%d/%m/%Y %H:%M:%S")
## include dummy value to display last tick in the datetime dimension
xlabtime<-c(datetime,strptime("3/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S"))
## one dataplot dataframe
dataplot<-cbind(datetime,data)
## managing datetime in the plot
Sys.setlocale("LC_TIME", "English") ## sorry my personal LOCALE is Italian
with(dataplot,plot(datetime,Global_active_power,xlab="",xaxt="n",ylab="Global Active Power (kilowatts)",type='l'))
## generate datetime label scale
axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")

readline(prompt = "Before generate plot on PNG device ...please press one key ......")
## COPY on dev file PNG
dev.copy(png,file="plot2.png",type="windows",bg="transparent")## width,height=480 are default values
## close dev
dev.off()
graphics.off()