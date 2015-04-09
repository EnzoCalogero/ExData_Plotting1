plot1<-function(){
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ##read the data set file 
  dataset<-fread("./household_power_consumption.txt")
  
  #Aggregate the date and the time and trasform in date using the 
  #lubridate library functions
  
  dataset<-mutate(dataset,  Date= dmy_hms(paste(dataset$Date,dataset$Time,sep="-")))
  
  #Filtered the data set for the two requested days
  dataset<-filter(dataset, Date >= ymd_hms("2007-02-01 00:00:00"),Date < ymd_hms("2007-02-03 00:00:00"))
  
  #Convert the variable "Global_active_power" from character to numeric
  dataset$Global_active_power<-as.numeric(dataset$Global_active_power)
  
  #Set the graphics devices to the PNG
  png(filename="plot1.png",width=480,height=480)
  
  #create the Plot 
  with(dataset, hist(Global_active_power,col="red",xlab="Global Active Power (kilowat)",main="Global Active Power"))
  
  #close the set device 
  dev.off()
}