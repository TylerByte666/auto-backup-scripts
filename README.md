# Scripts for backing up Web Server data.
## Scope and Purpose
These scripts are meant for web devs or sysadmins who use linux based webservers and who need daily backups of both mysql and html files.

These scipts do two things:
1. Make daily backups of html files and mysql files.
2. Remove daily backups after the retention period that you have set passes.

## Basic Instructions
1. Clone this repo on your web server.
2. Run chmod +x on each script to make them executable.
3. Add the desired script to your cronjobs at your desired time of day.
4. Edit the scripts to reflect your environment.