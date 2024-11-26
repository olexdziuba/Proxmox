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
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$SERVER_IP" "command -v rsync &> /dev/null || sudo apt update && sudo apt install -y rsync"
    if [ $? -eq 0 ]; then
        echo "The 'rsync' utility has been successfully installed on the server at $SERVER_IP."
    else
        echo "Failed to install rsync on the server at $SERVER_IP."
        exit 1
    fi
}

# Check and install rsync on the local machine
check_and_install_rsync_local

# Main loop to handle backups for multiple servers
while true; do
    echo "=== Backup Script ==="

    # Prompt for the server IP, username, and password
    read -p "Enter the server IP address: " SERVER_IP
    read -p "Enter the username: " USERNAME
    read -s -p "Enter the password: " PASSWORD
    echo

    # Check connectivity to the server
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$SERVER_IP" "exit"
    if [ $? -ne 0 ]; then
        echo "Failed to connect to the server at $SERVER_IP. Please check your credentials."
        continue
    fi

    # Check and install rsync on the remote server
    check_and_install_rsync_remote

    # Create a backup folder locally
    BACKUP_FOLDER="./backup_$SERVER_IP"
    mkdir -p "$BACKUP_FOLDER"

    # Copy the contents of the /home directory from the remote server
    echo "Copying the contents of /home from the server at $SERVER_IP to $BACKUP_FOLDER..."
    sshpass -p "$PASSWORD" rsync -avz --progress "$USERNAME@$SERVER_IP:/home/" "$BACKUP_FOLDER/"
    
    # Check the result of the backup operation
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully!"
    else
        echo "An error occurred during the backup process!"
        continue
    fi

    # Ask the user whether to continue or exit
    read -p "Do you want to perform a backup for another server? (y/n): " CONTINUE
    if [[ "$CONTINUE" != "y" ]]; then
        echo "Script finished. Goodbye!"
        break
    fi
done
