#!/bin/bash
#
# Author: [Cpt. Chaz]
# Created: [03/07/25]
# Updated: [04/30/25] - v1.1
# Description: A simple Unraid script for updating the un-get packages. This script will update, upgrade, and clean un-gets packages.
# Place script in the Unraid User Scripts plugin and schedule according to user preference.
# Status: Tested
#
# Credits:
# - un-get was created by **ich777**. More information can be found at:
#   https://github.com/ich777/un-get
# - big thank you to ich777 for all their work!
# - To install un-get on Unraid, paste the following into the Plugin tab manually:
#   https://raw.githubusercontent.com/ich777/un-get/master/un-get.plg
#    -Thanks to reddit user u/ceestars for this info
# - Also, check out https://github.com/shinji257/unraid_pkgs/tree/main for more unraid packages for un-get
#
# - This script was created with the help of ChatGPT, an OpenAI language model.
#
# This script updates, upgrades, and cleans up un-get packages,
# then notifies the Unraid GUI if everything runs smoothly.

set -e  # Exit on any error

# Ensure un-get is installed
if ! command -v un-get >/dev/null 2>&1; then
    echo "Error: un-get is not installed. Aborting."
    exit 1
fi

# Update package list
echo "Updating package list..."
un-get update

# Attempt normal upgrade first
echo "Upgrading packages..."
if ! un-get upgrade; then
    echo "Upgrade failed, attempting forced recovery..."
    un-get clean
    un-get update
    un-get upgrade --force || {
        echo "Automatic recovery with --force failed. Please check manually."
        exit 1
    }
fi

# Cleanup old packages
echo "Cleaning up old packages..."
un-get cleanup

# Notify success
echo "All un-get packages have been updated successfully!"

