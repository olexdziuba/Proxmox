# Proxmox Container Management Scripts

This repository contains a set of scripts designed to facilitate the management of individual Proxmox containers. Each script is tailored for specific container management tasks such as changing passwords, creating containers, and stopping them. It's important to note that these scripts operate on one container at a time, rather than processing a list of containers.


## Scripts Menu

- [Change Passwords](#change-passwords)
- [Create Single Container](#create-single-container)
- [Stop Container](#stop-container)
- [Add User](#add-user)
- [Start Stopped Containers](#start-stopped-containers)
- [Enable Root Login](#enable-root-login)
- [Start Container](#start-container)


### Change Passwords

**Script Name:** `change_passwords.sh`

**Description:** This script allows you to change the password for a specified container running on Proxmox. It prompts the user for a container ID (CTID) and the new password, then proceeds to change the password for the container's root user. Designed to operate on one container at a time.

**Usage:**

Start the script:
  
   `./change_passwords.sh`

Follow the on-screen prompts to enter the CTID and the new password.

### Create Single Container

**Script Name:** `single_cont_create.sh`

**Description**: This script is designed to create a single Proxmox container based on user-provided information such as the template ID, IP address prefix, hostname prefix, and container ID.

**Usage:**

Start the script:

`./single_cont_create.sh`

Input the required information as prompted by the script.


### Stop Container

**Script Name:** `stop_container.sh`

**Description**: Offers a straightforward method to stop a specified Proxmox container. Users are prompted to input the container ID (CTID), and the script attempts to stop that specific container. It's tailored for individual container management.



Usage:

Start the script:

`./stop_container.sh`

Enter the CTID of the container you wish to stop or type 'exit' to quit the script.
For each script, ensure you have the necessary permissions to execute the commands and manage Proxmox containers.


### Add User

**Script Name:** `add_user.sh`

**Description:**

This script facilitates the creation of a new user within a specified Proxmox container. It prompts for the container ID, the username, and the password, then proceeds to create the user with sudo privileges.

**Usage:**

1. **Run the script:**
   ```bash
   ./add_user.sh

2. Enter the Proxmox container ID when prompted.

3. Enter the username for the new user to be created.

4. Enter the password for the new user. The script ensures that the password is entered securely.

**Details**:

The script first logs into the specified container.
It then creates a new user with a home directory and bash as the default shell.
It sets the password for the new user.
Finally, it adds the new user to the sudoers file to grant sudo privileges without a password requirement.

**Example Output**:

` Enter the ID of the Proxmox container: 101 `

`Enter the username to be created: john_doe`

`Enter the password for the user john_doe: `

`User john_doe created in the container 101 with sudo rights.`


### Start Stopped Containers

**Script Name:** `start_stopped_containers.sh`

**Description:**  
This script is designed to automatically start all stopped Proxmox containers. It retrieves the list of all containers, checks their current status, and starts any that are not already running. This is particularly useful for batch operations or maintenance windows where multiple containers need to be restarted.

**Usage:**

1. **Start the script:**

   Execute the script by running:
   ```bash
   ./start_stopped_containers.sh

2. Script Operation:

The script will automatically:

Retrieve a list of all containers and their statuses.
Identify containers that are stopped.
Start each stopped container and print a confirmation message.

3. Completion:

Once all stopped containers have been addressed, the script will output:

`All stopped containers have been started.`

### Example Output:

`Starting container 101...`

`Starting container 102...`

`All stopped containers have been started.`


### Enable Root Login

**Script Name:** `root_login.sh`

**Description:**  
This script is designed to enable root login for a specified Proxmox container. It modifies the SSH configuration to allow root access via SSH, which is particularly useful for administrative tasks that require root privileges directly from SSH sessions.

**Usage:**

1. **Start the script:**

   Execute the script by running:
   ```bash
   ./root_login.sh

#### Script Operation:

The script will:

Prompt you to enter the ID of the Proxmox container.
Check if PermitRootLogin yes is already set in the sshd_config file.
If not set, it will add PermitRootLogin yes to the sshd_config and restart the SSH service.

#### Completion:

Once the script completes its operation, you will receive one of the following messages:

`Root login is already permitted.`

or

`Root login has been enabled and SSH service restarted.`

#### Example Output:
`Enter the ID of the Proxmox container: 101`

`Root login has been enabled and SSH service restarted.
`


### Start Container

**Script Name:** `start_container.sh`

**Description:**  
This script provides a straightforward method to start specified Proxmox containers by their Container ID (CTID). It is designed for interactive use, allowing the user to repeatedly start containers as needed and then exit gracefully.

**Usage:**

1. **Run the script:**
   ```bash
   ./start_container.sh

Script Interaction:

You will be prompted to enter a Container ID (CTID). Enter the CTID of the container you wish to start or type 'exit' to quit the script.
The script validates that the entered ID is a numerical value, which is required for a valid CTID.
After entering a valid CTID, the script attempts to start the specified container.
Follow-up:

Once the container is started, you will be asked if you want to start another container.
Enter yes to continue or any other key to exit.

Example Usage and Output:

  ```bash
   Please enter the container ID (CTID) or 'exit' to quit: 100
   --Starting container 100--
   Container 100 has been successfully started.
   Do you want to start another container? (yes/no): no
   Goodbye! 
   ```




#### Error Handling:

`Failed to start container 100. Please check if the container ID is correct and if you have the necessary permissions.`

If the container cannot be started (e.g., incorrect CTID, permissions issues), the script will inform you:


### Note
These scripts are intended for use with Proxmox Virtual Environment (VE). Please make sure you have a working Proxmox setup and are familiar with basic Proxmox and Linux command-line operations before using these scripts.

## Auteur

**Oleksandr Dziuba**

- Pour toutes questions ou suggestions, n'hésitez pas à me contacter.

