#!/bin/bash
# File: root_login.sh


# Prompt for the ID of the Proxmox container
read -p "Enter the ID of the Proxmox container: " container_id

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
