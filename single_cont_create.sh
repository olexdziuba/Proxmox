#!/bin/bash

# File: single_cont_create.sh

# Collect information from the user
echo "Please enter the Container template ID (e.g., 111):"
read TPLID

echo "Please enter the full IP address with subnet mask (e.g., 10.10.0.15/19):"
read IPADDRESS

echo "Please enter the Hostname prefix (e.g., 410-):"
read HOSTNAMEPREFIX

echo "Please enter the Container ID (e.g., 101):"
read CTID

echo "Please enter the Gateway IP address (e.g., 10.10.0.1):"
read GATEWAY

echo "Please enter the DNS server IP address (e.g., 8.8.8.8):"
read DNS

# Display the collected information and ask for confirmation
echo "You have entered the following information:"
echo "Container Template ID: $TPLID"
echo "IP Address: $IPADDRESS"
echo "Hostname Prefix: $HOSTNAMEPREFIX"
echo "Container ID: $CTID"
echo "Gateway: $GATEWAY"
echo "DNS Server: $DNS"
echo "Do you wish to proceed with creating the container? (Y/N)"
read CONFIRM

if [[ $CONFIRM =~ ^[Yy]$ ]]; then
    # Using the provided values to create a container
    echo "--Creating container $CTID--------------"
    pct clone $TPLID $CTID --full=yes --hostname=${HOSTNAMEPREFIX}${CTID} --storage=DATA

    # Set the network configuration
    pct set $CTID --net0 name=eth0,bridge=vmbr0,ip=$IPADDRESS,gw=$GATEWAY
    # Set the DNS server
    pct set $CTID --nameserver $DNS

    echo "Container $CTID with IP $IPADDRESS has been successfully created."
else
    echo "Container creation cancelled."
    exit 0
fi
