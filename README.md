# Proxmox Container Management Scripts

This repository contains a set of scripts designed to facilitate the management of individual Proxmox containers. Each script is tailored for specific container management tasks such as changing passwords, creating containers, and stopping them. It's important to note that these scripts operate on one container at a time, rather than processing a list of containers.


## Scripts Menu

- [Change Passwords](#change-passwords)
- [Create Single Container](#create-single-container)
- [Stop Container](#stop-container)

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


### Note
These scripts are intended for use with Proxmox Virtual Environment (VE). Please make sure you have a working Proxmox setup and are familiar with basic Proxmox and Linux command-line operations before using these scripts.

## Auteur

**Oleksandr Dziuba**

- Pour toutes questions ou suggestions, n'hésitez pas à me contacter.

