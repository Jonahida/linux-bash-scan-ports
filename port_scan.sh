#!/bin/bash

# Default network IP address
default_network_ip="192.168.1.1/24"

# Default port number
default_port="10005"

# Common ports to scan
common_ports="21,22,23,25,80,110,143,443,3389"

# Prompt for the network IP address
read -p "Enter the network IP address (default is ${default_network_ip}): " network_ip

# Use the default if no input is provided
network_ip=${network_ip:-$default_network_ip}

# Display port options to the user
echo "Select the port(s) to scan:"
echo "1) Default port (${default_port})"
echo "2) Common ports (${common_ports})"
echo "3) Custom port"

# Prompt for the port selection
read -p "Enter your choice (1, 2, or 3): " port_choice

# Determine which port(s) to use based on user choice
case $port_choice in
    1)
        port=$default_port
        ;;
    2)
        port=$common_ports
        ;;
    3)
        read -p "Enter the custom port number to scan: " custom_port
        port=$custom_port
        ;;
    *)
        echo "Invalid choice, using default port ${default_port}"
        port=$default_port
        ;;
esac

# Run nmap scan for the specified port(s)
nmap_output=$(nmap -p "$port" -sS -sU -T5 -A -v "$network_ip")

# Initialize an empty list to store IPs with specified port(s) open
declare -A ip_ports
current_ip=""

# Parse the nmap output
while IFS= read -r line; do
    if [[ $line == Nmap\ scan\ report* ]]; then
        # Extract IP address
        current_ip=$(echo "$line" | awk '{print $NF}')
    elif [[ $line =~ ^[0-9]+/ ]]; then
        # Extract open port and protocol
        port_protocol=$(echo "$line" | awk '{print $1}')
        port_number=$(echo "$port_protocol" | cut -d '/' -f 1)
        protocol=$(echo "$port_protocol" | cut -d '/' -f 2)

        # Store IP and port information
        ip_ports["$current_ip"]+="$port_number/$protocol "
    fi
done <<< "$nmap_output"

# Display the list of IPs with specified port(s) open
echo "List of IPs with open ports:"
for ip in "${!ip_ports[@]}"; do
    if [ -n "${ip_ports[$ip]}" ]; then
        echo "$ip: ${ip_ports[$ip]}"
    else
        echo "$ip: No open ports found"
    fi
done
