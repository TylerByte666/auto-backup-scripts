# Scripts for backing up webserver databases and files daily.
## Scope and Purpose:
These scripts are meant for fullstacks, webdevs or sysadmins who use linux based webservers; who need daily backups of both MySql, RAW and HTML files. These scripts have been divided in two, one for MySql and the other for RAW & HTML files so you can choose which one you need :smiling_face_with_three_hearts:

These scripts do three things:
1. Make daily backups of RAW, HTML (auto_backup_html.sh) and mysql(auto_backup_mysql.sh) files.
2. Remove daily backups after the retention period that you have set passes.
3. Both compress RAW, HTML and MySql files using tar.

## Basic Instructions:
1. Clone this repo on your web server.
2. Run `sudo chmod +x` on each script to make them executable.
3. Add the desired script to your cronjobs at your desired time of day.
4. Edit the scripts to reflect your environment. See configs you must change below:

## Configs you must change:
auto_backup_html.sh
```bash
HTML_BACKUP_PATH='/folder/to/backup/to'
HTML_BACKUP_SRC='/folder/to/backup'
APP_NAME='The specific application you are backing up'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 120 days.
LOGFILE_NAME=The name you want your log to be called default html_backup_log
```

auto_backup_mysql.sh
```bash
DB_BACKUP_PATH='/folder/to/backup/to'
MYSQL_USER='Your MySql user'
MYSQL_PASSWORD='Your MySql password'
DATABASE_NAME='Db you want to backup'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 120 days.
LOGFILE_NAME=The name you want your log to be called default db_backup_log
```
