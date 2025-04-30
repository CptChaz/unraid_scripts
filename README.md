# unraid_scripts

A collection of Unraid scripts optimized for use with the User Scripts plugin, thoughtfully crafted with assistance from ChatGPT.

## Included Scripts

### `install_ffmpeg.sh`
Installs the latest static build of FFmpeg x86_64 system-wide on Unraid  
WARNING: This script installs FFmpeg at the system level and creates symlinks in /usr/bin  
Best practice is to use Docker or VM isolation. Users assume all risk  
If you plan to keep FFmpeg updated regularly, consider using [`update_ffmpeg.sh`](./update_ffmpeg.sh), which performs a fresh install each time and is safe to schedule monthly.  
[View Script](./install_ffmpeg.sh)

---

### `update_ffmpeg.sh`  
Removes any existing FFmpeg installation in the target directory and installs the latest static build from johnvansickle.com  
Creates system-wide symlinks and is designed for monthly automated updates using the User Scripts plugin  
Does not detect or preserve FFmpeg installations from NerdPack, un-get, or other package managers  
WARNING: This script installs FFmpeg at the system level and creates symlinks in /usr/bin  
Best practice is to use Docker or VM isolation. Users assume all risk  
[View Script](./update_ffmpeg.sh)

---

### `update_un-get.sh`  
Updates all installed un-get packages on Unraid  
Includes automatic cleanup and optional GUI notifications  
[View Script](./update_un-get.sh)

---

## How to Use These Scripts

These scripts are designed with ease of use in mind, to be used with the User Scripts plugin

1. Open the User Scripts tab from the Unraid web UI  
2. Click Add New Script and give it a name such as install_ffmpeg  
3. Find the new script and click the gear icon, then choose Edit Script  
4. Copy and paste the full script contents from this repository  
5. Make any required changes such as file paths, then click Save  
6. Run manually or schedule as needed

Note: Some scripts such as install_ffmpeg.sh only need to be run once.  
You may remove them afterward to keep your script list clean

---

## License

MIT
