#Creates 4 plots on 1 canvas

#if file is not in the working directory, download and unzip
if (!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "./household_power_consumption.zip", method="curl")
  unzip("./household_power_consumption.zip", exdir="./") 
}

# read file into a data frame
df <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                 stringsAsFactors = FALSE)

# convert the Date column into Date format
df$Date <- as.Date(df$Date, format =  "%d/%m/%Y")

# Select data only for '2007-02-01' and  '2007-02-02'
feb1_2_07 <-df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

#merge data from Date and Time columns to create a DateTime format
dt <- as.POSIXct(paste(feb1_2_07$Date, feb1_2_07$Time), format="%Y-%m-%d %H:%M:%S")

# add a separate columng corresponding to DateTime
feb1_2_07$DateTime <- dt

# set layout 2 rows and 2 columns
par(mfrow = c(2,2))

#set white background
par(bg = "white")

#Plot 1 Global Active Power
plot(feb1_2_07$DateTime, feb1_2_07$Global_active_power, type="l", lty="solid", 
     xlab = "", ylab="Global Active Power", 
     cex.lab=0.7, cex.axis=0.7) # reduced size of ticks and axis labels

#Plot 2 Voltage
plot(feb1_2_07$DateTime, feb1_2_07$Voltage, type="l", lty="solid", 
     xlab = "datetime", ylab="Voltage", 
     cex.lab=0.8, cex.axis=0.8) # reduced size of ticks and axis labels)

#Plot 3 energy sub metering
plot(feb1_2_07$DateTime, feb1_2_07$Sub_metering_1, type="n", 
     xlab="", ylab="Energy sub metering", 
     cex.lab=0.8, cex.axis=0.8) # reduced size of ticks and axis labels)
# plot the graph for Sub-metering_1
lines(feb1_2_07$DateTime, feb1_2_07$Sub_metering_1)

# plot the graph for Sub-metering_2
lines(feb1_2_07$DateTime, feb1_2_07$Sub_metering_2, col="red")

# plot the graph for Sub-metering_3
lines(feb1_2_07$DateTime, feb1_2_07$Sub_metering_3, col="blue")

# add a legend
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), # puts text in the legend 
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       
       lwd=c(1.5, 1.5, 1.5), col=c("black","red", "blue"),# gives the legend lines the correct color and width
       bty = "n") # no border for the legend box

#Plot 4 Global_reactive_power
plot(feb1_2_07$DateTime, feb1_2_07$Global_reactive_power, type="l", lty="solid", 
     xlab = "datetime", ylab="Global_reactive_power", 
     cex.lab=0.8, cex.axis=0.8) # reduced size of ticks and axis labels)

# copy the plot to a png file 480x480 pixels
dev.copy(png,filename="plot4.png",height=480, width=480)
dev.off()