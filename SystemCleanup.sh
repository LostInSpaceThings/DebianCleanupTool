#!/bin/bash
#
# This script performs common cleanup tasks on a Debian-based system.
# It requires root privileges (sudo) to run all commands.
#
# IMPORTANT: Always review scripts before running them with sudo.
# This script will remove old packages and cache files.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting system cleanup..."
echo "-------------------------------------"

# Step 1: Update the package list and upgrade all installed packages.
# This ensures your system and all software are up to date.
echo "Updating package list and upgrading packages..."
sudo apt-get update
sudo apt-get upgrade -y

echo "-------------------------------------"

# Step 2: Remove packages that were automatically installed to satisfy
# dependencies but are no longer needed by any other installed package.
echo "Removing orphaned packages..."
sudo apt-get autoremove -y

echo "-------------------------------------"

# Step 3: Clean up the local repository of retrieved package files.
# This clears out old .deb files from the cache that can accumulate over time.
echo "Cleaning up the APT cache..."
sudo apt-get autoclean -y

echo "-------------------------------------"

# Step 4: Clear the entire local package cache.
# This is a more aggressive cache cleanup.
echo "Clearing the entire APT cache..."
sudo apt-get clean

echo "-------------------------------------"

# Step 5: Vacuum systemd journal logs to a reasonable size.
# Journal logs can grow quite large, consuming disk space.
# This command limits the total size of journal files to 50M.
echo "Vacuuming systemd journal logs..."
sudo journalctl --vacuum-size=50M

echo "-------------------------------------"

# Step 6: Empty the user's trash bin.
# NOTE: This is a more aggressive cleanup step. Files will be permanently deleted.
echo "Emptying the current user's trash bin..."
rm -rf ~/.local/share/Trash/*

echo "-------------------------------------"
echo "Cleanup complete! Your system should be a little bit tidier now."
