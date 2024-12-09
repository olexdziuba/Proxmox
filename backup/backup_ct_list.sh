#!/bin/bash

# Function to check and install rsync on the local machine
check_and_install_rsync_local() {
    if ! command -v rsync &> /dev/null; then
        echo "The 'rsync' utility is not installed on the local machine. Attempting to install..."
        sudo apt update
        sudo apt install -y rsync
        if [ $? -eq 0 ]; then
            echo "rsync has been successfully installed on the local machine."
        else
            echo "Failed to install rsync on the local machine. Exiting the script."
            exit 1
        fi
    fi
}

# Function to check and install rsync on the remote server
check_and_install_rsync_remote() {
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no root@"$CONTAINER_IP" "command -v rsync &> /dev/null || sudo apt update && sudo apt install -y rsync"
    if [ $? -eq 0 ]; then
        echo "The 'rsync' utility has been successfully installed on the server at $CONTAINER_IP."
    else
        echo "Failed to install rsync on the server at $CONTAINER_IP."
        exit 1
    fi
}

# Check and install rsync on the local machine
check_and_install_rsync_local

# Prompt for the CSV file
echo "Please enter the name of the CSV file with the list of containers (e.g., montest.csv):"
read CSV_FILE

# Verify the file exists
if [[ ! -f "$CSV_FILE" ]]; then
    echo "The file $CSV_FILE does not exist. Exiting."
    exit 1
fi

# Prompt for the first three parts of the IP address
echo "Enter the first three parts of the IP address (e.g., 10.10.0.):"
read BASE_IP

# Confirm the backup process
echo "The script will back up the /home directory of all containers listed in $CSV_FILE."
read -p "Do you want to proceed? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "Backup process canceled."
    exit 0
fi

# Read the CSV file line by line
while IFS=';' read -r ID_CONTAINER IP_SUFFIX USER PASSWORD FIRST_NAME LAST_NAME; do
    # Construct the full container IP address
    CONTAINER_IP="${BASE_IP}${IP_SUFFIX}"
    echo "Processing container $ID_CONTAINER with IP $CONTAINER_IP..."

    # Set the username to 'root' (always)
    USERNAME="root"

    # Check connectivity to the container
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$CONTAINER_IP" "exit"
    if [ $? -ne 0 ]; then
        echo "Failed to connect to the container at $CONTAINER_IP. Skipping."
        continue
    fi

    # Check and install rsync on the remote server
    check_and_install_rsync_remote

    # Create a local backup folder
    BACKUP_FOLDER="./backup_$CONTAINER_IP"
    mkdir -p "$BACKUP_FOLDER"

    # Copy the contents of the /home directory from the remote server
    echo "Copying the contents of /home from the container at $CONTAINER_IP to $BACKUP_FOLDER..."
    sshpass -p "$PASSWORD" rsync -avz --progress "$USERNAME@$CONTAINER_IP:/home/" "$BACKUP_FOLDER/"
    
    # Check the result of the backup operation
    if [ $? -eq 0 ]; then
        echo "Backup for container $ID_CONTAINER completed successfully!"
    else
        echo "An error occurred during the backup of container $ID_CONTAINER. Skipping."
    fi

done < "$CSV_FILE"

echo "Backup process completed for all containers in $CSV_FILE."
