# Author: Cpt. Chaz
# Created: 2025-03-19
# Updated: 2025-03-19
# Version Number: V 1.0
# Description: A clean, fully automated script to install and/or update FFmpeg to the latest static version. This script will install FFmpeg even if no prior installation exists. It removes any existing FFmpeg installation in the specified directory, downloads the latest static build, installs it, and creates global symlinks.
# Dependancies: wget, tar
# Status: Tested
#
# Credits:
#  - FFmpeg static builds provided by John Van Sickle (https://johnvansickle.com/ffmpeg/)
#
# - This script was created with the help of ChatGPT, an OpenAI language model.
#
# Directions:
# 1. Set your desired INSTALL_DIR at the top of the script.
# 2. Run this script manually or through Unraid’s User Scripts plugin.
# 3. After successful execution, `ffmpeg` and `ffprobe` will be available globally via symlinks in /usr/bin.
# 4. For best results, schedule this script to run automatically once per month to keep FFmpeg current.
#
# Caution:
# If you have FFmpeg installed via another method (e.g. NerdPack, un-get, or a package manager),
# this script does not detect or respect those installs and may cause version conflicts.
# It is your responsibility to ensure that no conflicting versions exist in your system PATH.
# This script was designed to work in tandem with the install_ffmpeg.sh script and will not conflict with that installation method.
#
