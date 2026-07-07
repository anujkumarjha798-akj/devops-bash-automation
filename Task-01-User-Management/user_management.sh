#!/bin/bash

echo "========================================="
echo "           User Management Tool          "
echo "========================================="

# Log file
LOG_FILE="./LOG_FILE.txt"

# Check if script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: Please run this script as root."
    echo "Example: sudo ./script.sh"
    exit 1
fi

# Get username from user
read -p "Enter username: " uname

# Check if username is empty
if [[ -z "$uname" ]]; then
    echo "Error: Username cannot be empty."
    exit 1
fi

# Check for spaces
if [[ "$uname" == *" "* ]]; then
    echo "Error: Username must not contain spaces."
    exit 1
fi

# Validate username format
if [[ ! "$uname" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    echo "Error: Username contains invalid characters."
    exit 1
fi

echo "Username entered: $uname"

# Check if user already exists
if grep -q "^$uname:" /etc/passwd; then
    echo "User '$uname' already exists."
else
    read -p "User not found. Do you want to create it? (yes/no): " ans

    # Check if answer is empty
    if [[ -z "$ans" ]]; then
        echo "Error: Please enter yes or no."
        exit 1
    fi

    if [[ "${ans,,}" == "yes" || "${ans,,}" == "y" ]]; then

        read -p "Enter new username: " unsame

        # Check if username is empty
        if [[ -z "$unsame" ]]; then
            echo "Error: Username cannot be empty."
            exit 1
        fi

        # Check for spaces
        if [[ "$unsame" == *" "* ]]; then
            echo "Error: Username must not contain spaces."
            exit 1
        fi

        # Validate username
        if [[ ! "$unsame" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
            echo "Error: Username contains invalid characters."
            exit 1
        fi

        # Create user
        if useradd "$unsame"; then
            echo "Creating user '$unsame'..."

            if grep -q "^$unsame:" /etc/passwd; then
                echo "$(date '+%Y-%m-%d %H:%M:%S') | User Created | Username: $unsame | Created By: $USER" >> "$LOG_FILE"

                echo "User '$unsame' created successfully."
            else
                echo "Error: User creation failed."
                exit 1
            fi
        else
            echo "Error: Unable to create user."
            exit 1
        fi

    elif [[ "${ans,,}" == "no" || "${ans,,}" == "n" ]]; then
        echo "Operation cancelled."

    else
        echo "Invalid choice. Please enter yes or no."
    fi
fi

echo "========================================="
echo "              Process Complete           "
echo "========================================="
