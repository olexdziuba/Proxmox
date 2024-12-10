# Backup Script Collection

This repository contains two Bash scripts for performing backups:

1. **`backup_ct.sh`**: A script to back up the `/home` directory from a remote server to a local machine via SSH.
2. **`backup_ct_list.sh`**: A script designed to back up data from multiple Proxmox containers specified in a CSV file.

---

## Features

### `backup_ct.sh`
- **Interactive prompts**: Asks for the server's IP address, username, and password.
- **Automatic dependency check**: Verifies and installs `rsync` on both the local machine and the remote server if missing.
- **Flexible**: Supports backing up multiple servers in one session.
- **Error handling**: Displays meaningful error messages for failed operations.

### `backup_ct_list.sh`
- **CSV-based backups**: Reads a list of Proxmox containers from a CSV file for automated processing.
- **Customizable IP structure**: Asks for the base IP (e.g., `10.10.0.`) and appends the last segment from the CSV file to construct the container's IP address.
- **Dependency management**: Ensures `rsync` is installed both locally and on each container.
- **Iterative backups**: Processes all containers listed in the CSV file sequentially.
- **Clear output**: Provides feedback on success or failure for each container.

---

## Prerequisites

- A Linux system with **sudo** privileges on the local machine.
- For **`backup_ct.sh`**:
  - SSH access to the remote server with a username and password.
- For **`backup_ct_list.sh`**:
  - A CSV file containing container information in the following format:
    ```
    ID_container;IP_suffix;user;password;firstname;lastname
    ```

    Example:
    ```
    101;241;root;password123;John;Doe
    102;242;root;password456;Jane;Smith
    ```
  - SSH access to each container with the `root` user.

---

## Installation

### 1. Clone or download the scripts
Save the scripts as `backup_ct.sh` and `backup_ct_list.sh` in your preferred directory.

### 2. Make the scripts executable
Run the following command to give the scripts execute permissions:
```bash
chmod +x backup_ct.sh
chmod +x backup_ct_list.sh
```
### 3. Install required dependencies on the local machine
Ensure sshpass is installed on your system:
```bash
sudo apt update
sudo apt install sshpass
```
## Usage

**`backup_ct.sh`**

Run the script interactively:
```bash
./backup_ct.sh
```

### Workflow
1. The script prompts you to enter the server's IP address, username, and password.
2. It checks if rsync is installed on both the local machine and the remote server. If not, it installs it automatically.
3. The script backs up the /home directory from the remote server to a local folder named `backup_<server_IP>` (e.g., `backup_192.168.0.241`).
4. After completing the backup, you will be asked if you want to perform another backup or exit.

**`backup_ct_list.sh`**

Run the script interactively:

```bash
./backup_ct_list.sh
```
### Workflow
1. The script asks for the name of the CSV file containing the list of containers.
2. It prompts you for the first three parts of the IP address (e.g., 10.10.0.).
3. For each container in the CSV file:
- Constructs the full IP address by appending the last segment from the CSV file.
- Uses the root user and the password provided in the CSV file to connect via SSH.
- Checks if rsync is installed on the container. If not, it installs it.
- Copies the /home directory from the container to a local folder named backup_<container_IP>.
- Displays the success or failure of the backup operation.
4. The script processes each line in the CSV file until the end.

### Example Sessions

**backup_ct.sh**
```bash
=== Backup Script ===
Enter the server IP address: 192.168.0.241
Enter the username: root
Enter the password: 
Copying the contents of /home from the server at 192.168.0.241 to ./backup_192.168.0.241...
Backup completed successfully!
Do you want to perform a backup for another server? (y/n): n
Script finished. Goodbye!
```

**backup_ct_list.sh**
```bash
Please enter the name of the CSV file with the list of containers (e.g., montest.csv):
containers.csv
Enter the first three parts of the IP address (e.g., 10.10.0.):
10.10.0.
The script will back up the /home directory of all containers listed in containers.csv.
Do you want to proceed? (y/n): y
Processing container 101 with IP 10.10.0.241...
Copying the contents of /home from the container at 10.10.0.241 to ./backup_10.10.0.241...
Backup for container 101 completed successfully!
Processing container 102 with IP 10.10.0.242...
Copying the contents of /home from the container at 10.10.0.242 to ./backup_10.10.0.242...
Backup for container 102 completed successfully!
Backup process completed for all containers in containers.csv.
```

### Notes
Customizations:
You can modify the scripts to back up directories other than `/home` by editing the rsync command.
Change the backup folder name format in the scripts if needed.
CSV Requirements: Ensure the CSV file follows the exact format described in the prerequisites for `backup_ct_list.sh`.
Security: For better security, consider using SSH keys instead of passwords. Update the scripts to remove sshpass and configure key-based authentication.

### Author
Created by Oleksandr Dziuba


