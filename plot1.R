# Creates a Global Active Power histogram

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

#set white background
par(bg = "white")

# plot a histogram
hist(as.numeric(feb1_2_07$Global_active_power), main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", col = "red")

# copy the histogram to a png file 480x480 pixels
dev.copy(png, filename="plot1.png",height=480, width=480)
dev.off()