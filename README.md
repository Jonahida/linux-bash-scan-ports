# Port Scan Script

`port_scan.sh` is a Bash script designed to perform network scans on specified IP addresses or subnets, targeting specific ports. The script provides flexibility by allowing users to choose between scanning a default port, a list of common ports, or a custom port.

## Features

- Scans a specified network IP address or subnet for open ports.
- Allows the user to select between:
  - A default port (`10005`).
  - Common ports (`21, 22, 23, 25, 80, 110, 143, 443, 3389`).
  - A custom port specified by the user.
- Supports scanning both TCP and UDP ports.
- Outputs a list of IP addresses with the specified port(s) open, including both TCP and UDP protocols.

## Requirements

- **Bash**: The script is written in Bash and should be run in a Unix-like environment.
- **nmap**: The network scanning tool `nmap` must be installed on the system.

### Installing nmap

You can install `nmap` using the following package managers:

- **Debian/Ubuntu-based systems**:
  ```bash
  sudo apt-get install nmap
  ```

- **Red Hat/CentOS-based systems**:
  ```bash
  sudo yum install nmap
  ```

- **macOS**:
  ```bash
  brew install nmap
  ```
## Usage

1. **Make the script executable**:

   ```bash
   chmod +x port_scan.sh
   ```

2. **Run the script**:

   ```bash
   sudo ./port_scan.sh
   ```

**Note**: You may need to run the script with sudo to ensure nmap has the necessary permissions for the scans.

3. **Follow the prompts**:

- **Enter the network IP address**: You can provide a specific IP address or subnet (e.g., `192.168.1.1/24`). If you press `Enter` without typing, the script will use the default `192.168.1.1/24`.

- **Select the port(s) to scan**:

- **Option 1**: Scan the default port (`10005`).
- **Option 2**: Scan common ports (`21, 22, 23, 25, 80, 110, 143, 443, 3389`).
- **Option 3**: Enter a custom port to scan.

4. **View the results**: The script will display a list of IP addresses with the specified port(s) open, along with the protocol (TCP or UDP).

## Example Output
   ```bash
Enter the network IP address (default is 192.168.1.1/24): 
Select the port(s) to scan:
1) Default port (10005)
2) Common ports (21,22,23,25,80,110,143,443,3389)
3) Custom port
Enter your choice (1, 2, or 3): 2

List of IPs with open ports:
192.168.1.1: 80/tcp 443/tcp 3389/udp 
192.168.1.10: 22/tcp 80/tcp 
192.168.1.17: 3389/udp 
   ```

## License
This script is released under the MIT License. See `LICENSE` for more information.