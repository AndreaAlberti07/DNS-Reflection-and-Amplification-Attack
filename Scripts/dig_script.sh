#!/bin/bash

# Define the domain name to query
domain="ediproject.com"

# Define the number of queries to perform
num_queries=480

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
    sleep 0.5
  
done

