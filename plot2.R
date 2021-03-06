# Download file and unzip the archive to the current working directory
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile=paste0(getwd(),"/Power_consumption.zip"),method = "curl")
unzip("Power_consumption.zip",exdir="./")

# Read 5 rows to get headers
initial<-read.table("household_power_consumption.txt", header=TRUE,sep=";", nrows=5)

# Read 2900 rows that contain information on 2007-02-01 and 2007-02-02
hpc<-read.table("household_power_consumption.txt", header=TRUE,sep=";", skip=66630, 
                nrows=2900, col.names=names(initial), na.strings=c("?"),
                colClasses=c("character", "character","numeric","numeric","numeric","numeric",
                             "numeric","numeric","numeric"))
# Converting Date and Time variables to Date/Time format
hpc$Date<-as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time<-strptime(paste(hpc$Date,hpc$Time),"%F %T")

# Subsetting loaded data for 2007-02-01 and 2007-02-02 
hpc<-subset(hpc,hpc$Date %in% as.Date(c("2007-02-01","2007-02-02")))

# Plot 2
png("plot2.png", width=480, height=480)
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
dev.off()