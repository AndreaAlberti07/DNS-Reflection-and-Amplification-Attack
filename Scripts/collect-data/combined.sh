#!/bin/bash

# Define the domain name to query
domain="ediproject.com"

# Define the number of queries to perform
num_queries=480

# Define the delay between each measurement in seconds
delay=0.5

# Loop to perform multiple queries
for ((i=1; i<=$num_queries; i++))
do
    # Run dig and capture the output
    output=$(dig +stats @192.168.1.4 -t A $domain)

    # Extract the query time using text processing (e.g., using grep and awk)
    query_time=$(echo "$output" | grep "Query time:" | awk '{print $4}')

    # Get timestamp
    timestamp=$(date +"%H:%M:%S")

    # Get CPU usage percentage
    cpu_usage=$(top -l 2 -n 0 | grep "CPU usage" | tail -n 1 | awk '{print $3}')

    # Get memory usage percentage
    memory_usage=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2}')


    # Run ping command and store output in a variable
    ping_output=$(ping -c 1 192.168.1.4)

    # Extract the RTT time from the ping output using awk
    rtt_time=$(echo "$ping_output" | awk '/time=/{print $7}' | cut -d '=' -f 2)

    # Optional: Store the query times in a file for further analysis
    echo "$timestamp; Query_time: $query_time; CPU: $cpu_usage%; Memory: $memory_usage; Ping: $rtt_time"
    echo "$timestamp; Query_time: $query_time; CPU: $cpu_usage%; Memory: $memory_usage; Ping: $rtt_time" >> DDoS_50000_ANY_dnsperf.txt
 
    # Delay before the next measurement
    sleep $delay
  
done


