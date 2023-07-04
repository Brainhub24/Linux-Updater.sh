#!/bin/bash

########################################################################
# Developer: Brainhub24
# Project: Linux Updater Script
# Version: 1.0.0
# Description: The Linux Updater Script is a robust and efficient
#              tool meticulously crafted to streamline package
#              management on diverse Linux distributions. It automates
#              the update, upgrade, autoclean, and autoremove processes
#              with precision, ensuring your system remains secure,
#              up-to-date, and optimized.
#
# Changelog:
#
#   - Version 1.0.0 (2023-07-04):
#     * Support for the most commonly used Linux distributions like Debian, Ubuntu, openSUSE, Red Hat, and CentOS.
#
#   - Version 0.0.0 (2023-07-04):
#     * Initial release of the Linux Updater Script (The simple way!).
#       [sudo apt update && sudo apt upgrade -y] on Debian-based distros
########################################################################

# Function to update Debian-based distributions (Debian, Ubuntu)
update_debian() {
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get autoclean
  sudo apt-get autoremove -y
}

# Function to update openSUSE
update_suse() {
  sudo zypper refresh
  sudo zypper update -y
  sudo zypper clean --all
  sudo zypper remove --clean-deps -a
}

# Function to update Red Hat-based distributions (Red Hat, CentOS)
update_redhat() {
  sudo yum update -y
  sudo yum clean all
  sudo package-cleanup --oldkernels --count=1 -y
}

# Determine the Linux distribution
if [ -f /etc/debian_version ]; then
  echo "Updating Debian-based distribution..."
  update_debian
elif [ -f /etc/SuSE-release ] || [ -f /etc/opensuse-release ]; then
  echo "Updating openSUSE..."
  update_suse
elif [ -f /etc/redhat-release ]; then
  echo "Updating Red Hat-based distribution..."
  update_redhat
else
  echo "Unsupported Linux distribution."
  exit 1
fi

echo "Update completed successfully."