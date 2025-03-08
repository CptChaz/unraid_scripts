#!/bin/bash
#
# Author: [Cpt. Chaz]
# Created: [03/07/25]
# Updated: [03/07/25]
# Description: A simple Unraid script for updating the un-get packages. This script will update, upgrade, and clean un-gets packages.
# Place script in the Unraid User Scripts plugin and schedule according to user preference.
# Status: Tested
#
# Credits:
# - un-get was created by **ich777**. More information can be found at:
#   https://github.com/ich777/un-get
# - big thank you to ich777 for all their work!
# - To install un-get on Unraid, run the following command in the terminal:
#   curl -sL https://raw.githubusercontent.com/ich777/un-get/main/un-get-installer | bash
#
# - This script was created with the help of ChatGPT, an OpenAI language model.
#
set -e  # Stop immediately on error

# Ensure un-get is installed
if ! command -v un-get >/dev/null 2>&1; then
    echo \"Error: un-get is not installed. Aborting.\"
    exit 1
fi

# Update package list
echo \"Updating package list...\"
un-get update

# Upgrade packages (pipe 'yes' to automate prompt)
echo \"Upgrading packages...\"
if ! yes | un-get upgrade; then
    echo \"Upgrade failed, attempting recovery...\"
    un-get clean
    un-get update
    yes | un-get upgrade || {
        echo \"Automatic recovery failed. Please check manually.\"
        exit 1
    }
fi

# Cleanup old packages
echo \"Cleaning up old packages...\"
un-get cleanup

# Notify success
echo \"All un-get packages have been updated successfully!\"
