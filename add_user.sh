#!/bin/bash
# File: add_user.sh

# Demande l'ID du container Proxmox
read -p "Entrez l'ID du container Proxmox: " container_id

# Demande le nom de l'utilisateur
read -p "Entrez le nom de l'utilisateur à créer: " username

# Demande le mot de passe de l'utilisateur
read -sp "Entrez le mot de passe pour l'utilisateur $username: " password
echo

# Commande pour accéder au container et créer l'utilisateur
pct exec $container_id -- bash -c "useradd -m -s /bin/bash $username && echo '$username:$password' | chpasswd"

# Ajout de l'utilisateur aux sudoers
pct exec $container_id -- bash -c "echo '$username ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

# Affichage des informations
echo "Utilisateur $username créé dans le container $container_id avec les droits sudo."
