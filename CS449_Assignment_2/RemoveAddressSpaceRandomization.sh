#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install a package if it's not already installed
install_package() {
  local package_name="$1"
  if ! command_exists "$package_name"; then
    if command_exists apt-get; then
      sudo apt-get update
      sudo apt-get install -y "$package_name"
    elif command_exists yum; then
      sudo yum install -y "$package_name"
    else
      echo "Error: Unsupported package manager. You need to manually install $package_name."
      exit 1
    fi
  fi
}

# Check and install execstack if needed
if ! command_exists execstack || ! command_exists gcc-multilib; then
  echo "Installing execstack and gcc-multilib..."
  install_package execstack
  install_package gcc-multilib
fi

# Compile the C program
gcc -m32 -z execstack -fno -stack - protector -o vprog32 vprog.c

# Disable address space randomization
execstack -s vprog

# Make vprog32 a root-owned executable program
sudo chown root vprgo32
sudo chmod 4755 vprog32