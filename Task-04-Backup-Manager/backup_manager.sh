#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo "Use this script as an Admin (Root User)."
    echo "Example:"
    echo "sudo backup_manager.sh"
    exit 1
fi

# ==========================================================
# Banner
# ==========================================================

echo "==================================="
echo "          BACKUP MANAGER           "
echo "==================================="

# ==========================================================
# Source Directory Input
# ==========================================================

read -p "Enter your Source Destination: " source

# Check if user entered any input
if [[ -z "$source" ]]; then
    echo "Please provide a source directory."
    exit 1
fi

# Check whether source exists
if [[ ! -e "$source" ]]; then
    echo "Source directory not found."
    exit 1
fi

# Check whether source directory is empty
if [[ -z "$(ls -A "$source")" ]]; then
    echo "Source directory is empty."
    exit 1
fi

# ==========================================================
# Generate Timestamp
# ==========================================================

when=$(date +"%Y-%m-%d::%H-%M-%S")

# ==========================================================
# Backup Destination
# ==========================================================

read -p "Enter your Backup Destination: " backup

# ==========================================================
# Create Backup Directory (If Not Exists)
# ==========================================================

if [[ ! -d "$backup" ]]; then

    echo "Destination not found."

    read -p "Do you want to create it? (yes/no): " ans

    if [[ "${ans,,}" == "yes" || "${ans,,}" == "y" ]]; then

        read -p "Enter your directory name: " folder

        echo "Creating backup directory..."

        mkdir -p "$folder"

        echo "$folder created successfully."

        # Create compressed backup
        tar -czf "$folder/backup_${when}.tar.gz" -C "$source" .

        echo "==============================="
        echo "DATE & TIME : $when"
        echo "Backup completed successfully."
        echo "==============================="
        echo "PATH : $backup/backup_${when}.tar.gz"

        backup_file="$backup/backup_${when}.tar.gz"

        ls -lh "$folder"

    elif [[ "${ans,,}" == "no" || "${ans,,}" == "n" ]]; then

        echo "Operation cancelled."

        exit 1

    else

        echo "Invalid input."

    fi

# ==========================================================
# Backup Directory Already Exists
# ==========================================================

else

    echo "Backup directory already exists."

    backup_file="$backup/backup_${when}.tar.gz"

    # Create compressed backup
    tar -czf "$backup/backup_${when}.tar.gz" -C "$source" .

    echo "==============================="
    echo "DATE & TIME : $when"
    echo "Backup completed successfully."
    echo "==============================="
    echo "PATH : $backup/backup_${when}.tar.gz"
    echo "==============================="

    # Backup file path
    file_path="$backup/backup_${when}.tar.gz"

    # Display backup size
    echo "Backup File Size:"
    echo "📏 Size: $(du -m "$file_path" | awk '{print $1}')" MB

    echo
    echo "Available Backups:"
    ls -lh "$backup"

fi

# ==========================================================
# Backup Verification
# ==========================================================
# Verify whether the backup archive is valid.

file_path="$backup/backup_${when}.tar.gz"

if tar -tzf "$backup_file" >/dev/null 2>&1; then
    echo
    echo "✅ Backup verified successfully!"
else
    echo
    echo "❌ Backup verification failed!"
    echo "Backup archive is corrupted."
    exit 1
fi
