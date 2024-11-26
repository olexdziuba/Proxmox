# Backup Script

A Bash script to back up the `/home` directory from a remote server to a local machine. This script ensures that the required utilities (`rsync` and `sshpass`) are installed both locally and on the remote server before performing the backup.

## Features
- **Interactive prompts**: Asks for the server's IP address, username, and password.
- **Automatic dependency check**: Verifies and installs `rsync` on both the local machine and the remote server if missing.
- **Flexible**: Supports backing up multiple servers in one session.
- **Error handling**: Displays meaningful error messages for failed operations.

---

## Prerequisites
- A Linux system with **sudo** privileges on the local machine.
- SSH access to the remote server with a username and password.
- The `sshpass` utility installed on the local machine.
- The ability to install packages (`rsync`) on the remote server via `sudo`.

---

## Installation

### 1. Clone or download the script
Save the script as `backup.sh` in your preferred directory.

### 2. Make the script executable
Run the following command to give the script execute permissions:
```bash
chmod +x backup.sh
```

### 3.  Install required dependencies on the local machine
Ensure sshpass is installed on your system:

```bash
sudo apt update
sudo apt install sshpass
```
##  Usage
```bash
./backup.sh
```

## Workflow
The script will prompt you to enter the IP address of the server, username, and password.
It will check if rsync is installed on both the local machine and the remote server:
If missing, the script installs it automatically.
The script will back up the /home directory from the remote server to a local folder named backup_<server_IP> (e.g., backup_192.168.0.241).
After completing the backup, you will be asked if you want to perform another backup or exit.
