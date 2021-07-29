# 🚀 Scripts for automatically backing up MySql Databases and Folders/Files daily.

These scripts are meant for fullstacks, webdevs or sysadmins who use linux based webservers; who need daily backups of MySql and Folders/Files. 

These scripts have been divided in two, one for MySql and the other for Files and Folders so you can choose which one you need.

**Please note**
You will need *root* access to use these scripts.

:smiling_face_with_three_hearts:.

## Scope and Purpose:
These scripts do three things:
1. Make daily backups of Folders/Files(auto_backup_files.sh) and MySql(auto_backup_mysql.sh) databases.
2. Remove backups after the retention period that you have set for them passes.
3. Compress Folders/Files and MySql dump files.

## Basic Instructions:
1. Clone this repo on your web server making sure you are *root*.
2. Make each script you want to use executable, by running these commands in the directory where you cloned the code:

```
chmod +x auto_backup_files.sh
```
```
chmod +x auto_backup_mysql.sh
```

3. Edit the scripts to reflect your environment. See configs you must change below. 🔽

## Configs you must change:
auto_backup_files.sh
```bash
HTML_BACKUP_PATH='/folder/to/backup/to'
HTML_BACKUP_SRC='/folder/to/backup'
APP_NAME='The specific application you are backing up'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 120 days.
LOGFILE_NAME=The name you want your log to be called default html_backup.log.
```

auto_backup_mysql.sh
```bash
DB_BACKUP_PATH='/folder/to/backup/to'
MYSQL_USER='Your MySql user'
DATABASE_NAME='Db you want to backup'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 120 days.
LOGFILE_NAME=The name you want your log to be called default mysql_backup.log.
```
4. Add the mysqldump password paramater to your `.my.cnf`. 
The *my.cnf* file is hidden in your home directory, usually `/home/username/.my.cnf`. 🔽

**Please note:** This will allow passwordless mysqldump commands.
```config
nano ~/.my.cnf
```
Edit and Enter in the following two lines replacing *YOUR_PASSWORD_HERE* with your own and save the file.
```config
[mysqldump]
password=YOUR_PASSWORD_HERE
```
Next, change the file permissions.
```config
chmod 600 ~/.my.cnf
```
5. Add the desired script to your `/etc/cronjob.daily`. 🔽
```config
cp auto_backup_files.sh /etc/cronjob.daily/
```
```config
cp auto_backup_mysql.sh /etc/cronjob.daily/
```

6. Create your backup folders for the MySql and/or the Folders/Files according to the config you have set, example:

If your file auto_backup_files.sh config looks like this `HTML_BACKUP_PATH='/var/backups/html'`
```config
mkdir /var/backups/html
```
If your file auto_backup_mysql.sh config looks like this `DB_BACKUP_PATH='/var/backups/mysql'`
```config
mkdir /var/backups/mysql
```
# 🚀 You're done and ready for disaster! 🚀
## Toubleshooting 🐛
1. The scripts do not run.

Make sure you can run the script manually, example:
```config
./auto_backup_files.sh
```
This should shout out any error.

2. Where can I find logs to see if they ran or not.

- on Debian based systems, like Ubuntu:
```bash
grep auto_backup /var/log/syslog
```
- on Fedora based systems, like CentOS:
```bash
grep auto_backup /var/log/cron
```

3. Make sure your cron service is running.

- on Debian based systems, like Ubuntu:
```bash
systemctl status cron
```
- on Fedora based systems, like CentOS:
```bash
systemctl status crond
```

## DR - Distater Recovery 🥳
WIP
