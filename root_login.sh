#!/bin/bash
# File: root_login.sh

while true; do
    # Prompt for the ID of the Proxmox container or ESC to exit
    read -p "Enter the ID of the Proxmox container or ESC pour exit: " container_id

    # Check if the user pressed ESC (ASCII value 27)
    if [[ $container_id == $'\e' ]]; then
        echo "Exiting..."
        exit 0
    fi

    # Validate that the input is a numeric ID
    if [[ $container_id =~ ^[0-9]+$ ]]; then
        # Check if 'PermitRootLogin yes' is in the sshd_config
        if pct exec $container_id -- grep -q "PermitRootLogin yes" /etc/ssh/sshd_config; then
            echo "Root login is already permitted."
        else
            # If not found, add 'PermitRootLogin yes' to sshd_config
            pct exec $container_id -- bash -c "echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config"
            
            # Restart the SSH service
            pct exec $container_id -- systemctl restart sshd

            echo "Root login has been enabled and SSH service restarted."
        fi
    else
        echo "Invalid container ID. Please enter a numeric ID."
    fi
done
