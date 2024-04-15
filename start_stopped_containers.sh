#!/bin/bash
# File: start_stopped_containers.sh

# Retrieve the list of all containers and their statuses
pct list | while read line; do
  # Read the container ID and status
  container_id=$(echo $line | awk '{print $1}')
  status=$(echo $line | awk '{print $3}')
  
  # Check if the container is not running
  if [[ "$status" != "running" && "$container_id" != "VMID" ]]; then
    echo "Starting container $container_id..."
    pct start $container_id
  fi
done

echo "All stopped containers have been started."
