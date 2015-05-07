
################################################################

#####            R Script to generate Plot 4               #####

################################################################


# Delete local file if present

     if (file.exists("householdpc.zip")) 
           {
              file.remove("householdpc.zip")
           }

# Read zipped file from the Web

download.file(url="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile="householdpc.zip")


# Extract the TXT file and assign it to variable (ec1)

    ec1 <- read.table(unz("householdpc.zip", 
                       "household_power_consumption.txt"),
                                   header=T, 
                                   sep=";", 
                                   na.strings="?", 
                                   stringsAsFactors=F)

# Copy (ec1) to (ec2)

    ec2 <- ec1


# Change the (Date) column to (Date) format

   ec2$Date <- as.Date(ec1$Date,"%d/%m/%Y")


# Extract only February 1st and 2nd date, data. Assign it 
# to (ec3)

   ec3 <- subset(ec2, Date == as.Date("01/02/2007","%d/%m/%Y") | 
                   Date == as.Date("02/02/2007","%d/%m/%Y"))


# Define new variable (DateTime) in (ec3)

  ec3$DateTime <- as.POSIXct(paste(ec3$Date, ec3$Time))


# Define graphical device as "png" and filename to print
# results to

   png(filename="plot4.png", width = 480, height = 480)


# Define (par) with (mfrow) parameter

   par(mfrow = c(2, 2))


# Plot the 4 graphs to graphical device

with(ec3, 
  {
    plot(DateTime, Global_active_power, type="l", 
               xlab="DateTime", 
               ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", xlab="DateTime", 
               ylab="Voltage")
     {
       plot(DateTime, Sub_metering_1, type = "n",
              xlab="DateTime", ylab="Energy sub metering")
       lines(DateTime, Sub_metering_1, col = "black")
       lines(DateTime, Sub_metering_2, col = "red")
       lines(DateTime, Sub_metering_3, col = "blue")
       legend("topright", lty=1, lwd=2, 
                     col = c("black", "red", "blue"), 
                     bty="n", xjust=1, 
                     legend = c("Sub_metering_1", 
                                "Sub_metering_2", 
                                "Sub_metering_3"))
     }
   plot(DateTime, Global_reactive_power, type="l", 
               xlab="DateTime",  
               ylab="Global_reactive_power")
 })


# Turn the graphical device off

   dev.off()


# Cleanup objects

   remove(ec1, ec2, ec3)








