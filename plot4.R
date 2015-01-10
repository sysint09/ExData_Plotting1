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
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
with(dataplot,
     {
      ## Plot top left
     plot(datetime,Global_active_power,xlab="",xaxt="n",ylab="Global Active Power",type='l')
     axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
     ## Plot top right
     plot(datetime,Voltage,xlab="datetime",xaxt="n",type='l')
     axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
     ## Plot bottom left
     plot(datetime,Sub_metering_1,xlab="",xaxt="n",ylab="Energy sub metering",type='l')
     lines(datetime,Sub_metering_2,col="red")
     lines(datetime,Sub_metering_3,col="blue")
     legend("topright",,bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
     ## generate datetime label scale
     axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
     ## Plot top right
     plot(datetime,Global_reactive_power,xlab="datetime",xaxt="n",type='l')
     axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
     
     }
)

readline(prompt = "Before generate plot on PNG device ...please press one key ......")
## COPY on dev file PNG
## dev.copy(png,file="plot3.png")## width,height=480 are default values
## in this case rescaling process during dev to dev copy produces a bad png image
## so is better to directly replot in PNG dev  

## Open dev
png(filename="plot4.png",type="windows",bg="transparent")
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
with(dataplot,
{
      ## Plot top left
      plot(datetime,Global_active_power,xlab="",xaxt="n",ylab="Global Active Power",type='l')
      axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
      ## Plot top right
      plot(datetime,Voltage,xlab="datetime",xaxt="n",type='l')
      axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
      ## Plot bottom left
      plot(datetime,Sub_metering_1,xlab="",xaxt="n",ylab="Energy sub metering",type='l')
      lines(datetime,Sub_metering_2,col="red")
      lines(datetime,Sub_metering_3,col="blue")
      legend("topright",,bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
      ## generate datetime label scale
      axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
      ## Plot top right
      plot(datetime,Global_reactive_power,xlab="datetime",xaxt="n",type='l')
      axis.POSIXct(side=1, at=cut(xlabtime, "days"), format="%a")
      
}
)
## close dev
dev.off()
graphics.off()