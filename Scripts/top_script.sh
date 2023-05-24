#!/bin/bash

# Define the duration of the monitoring in seconds
duration=240

# Define the delay between each measurement in seconds
delay=1

# Create a timestamped output file
output_file="usage_$(date +"%Y%m%d%H%M%S").txt"

# Loop to perform measurements
for ((i=0; i<=$duration; i+=delay))
do
    # Get CPU usage percentage
    cpu_usage=$(top -bn1 | grep "%Cpu(s)" | awk '{print $2}')

    # Get memory usage percentage
    memory_usage=$(free -m | awk '/Mem:/ {print $3/$2 * 100}')

    # Get timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Append the measurement to the output file
    echo "$timestamp;CPU: $cpu_usage%  Memory: $memory_usage%" >> "$output_file"

    # Delay before the next measurement
    sleep $delay
done
