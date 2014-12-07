plot2 <- function() {
  # Get the column names from text file without reading it completely
  temp_data <- read.table("./household_power_consumption.txt", header = TRUE, stringsAsFactors=FALSE, sep=";" , na.strings = "?", nrows=1)
  column_names <- colnames(temp_data)
  
  # Remove the temporary variable
  rm(temp_data)
  
  # Read Date column only as 'character' 
  date_info <- read.table("./household_power_consumption.txt", colClasses =  c("character",rep("NULL",8)) ,header = TRUE, stringsAsFactors=FALSE, sep=";" , na.strings = "?")
  
  # Convert to 'Date' type 
  D <- as.Date(date_info$Date, format="%d/%m/%Y")
  
  # Start and End dates for this analysis 
  start_date <- as.Date("1/2/2007", format="%d/%m/%Y")
  end_date <- as.Date("2/2/2007", format="%d/%m/%Y")
  
  # Row where the start date appears for the first time 
  first_row <- head(which(D==start_date),1)
  # Row where the end date appears for the last time
  last_row <- tail(which(D==end_date),1)
  
  # Remove the temporary variables
  rm(date_info,D)
  
  # Read the specific data from text file
  power_data <- read.table("./household_power_consumption.txt", col.names = column_names, skip = first_row, nrows = last_row-first_row+1,header = FALSE, stringsAsFactors=FALSE, sep=";" , na.strings = "?")
  
# Convert character to Date format   
  power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Combine Date and Time objects in to single Date-Time objects

Date_Time <- paste(power_data$Date, power_data$Time)
Date_Time <- strptime(Date_Time, "%Y-%m-%d %H:%M:%S")
  
# Save the plot in a PNG file 
png(file="plot2.png", width=480, height=480)


  # Plot the data
  plot(Date_Time,power_data$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)", type="l")
  
    
  # Switch off the PNG device 
  dev.off()
  
}
