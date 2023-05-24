#!/bin/bash

# Define the domain name to query
domain="ediproject.com"

# Define the number of queries to perform
num_queries=480

# Define the delay between each measurement in seconds
delay=0.5

# Create a timestamped output file
output_file="usage_$(date +"%Y%m%d%H%M%S").txt"

# Loop to perform multiple queries
for ((i=1; i<=$num_queries; i++))
do
    # Run dig and capture the output
    output=$(dig +stats @192.168.1.3 -t A $domain)

    # Extract the query time using text processing (e.g., using grep and awk)
    query_time=$(echo "$output" | grep "Query time:" | awk '{print $4}')

    # Print the individual query time
    echo "Query $i: $query_time msec"

    # Optional: Store the query times in a file for further analysis
    echo "$query_time" >> DDoS_query_times.txt
 
 
    
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


