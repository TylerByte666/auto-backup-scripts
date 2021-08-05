# 🚀 Scripts for automatically backing up MySql Databases and Folders/Files daily.

These scripts are meant for Fullstacks, Webdevs or Sysadmins who use linux based webservers; who need daily backups of MySql databases, Folders and/or Files. 

These scripts have been divided in two, one for MySql databases and the other for Files and Folders so you can choose which one you need.

**Please note**
You will need *root* access to use these scripts.

:smiling_face_with_three_hearts:

## Scope and Purpose:
These scripts do three things:
1. Make daily backups of Folders/Files(auto_backup_files.sh) and MySql databases(auto_backup_mysql.sh).
2. Remove backups after the retention period that you have set for them passes.
3. Compress Folders/Files and MySql database dump files.

## Basic Instructions:
1. Clone this repo on your web server making sure you are *root*.
2. Make each script you want to use executable, by running these commands in the directory where you cloned the code:

```
chmod +x auto_backup_files.sh
```
```
chmod +x auto_backup_mysql.sh
```

3. Edit the scripts to reflect your web server environment. See configs you must change below. 🔽

## Configs you must change:
auto_backup_files.sh
```bash
FILE_BACKUP_PATH='/folder/to/backup/to'
FILE_BACKUP_SRC='/folder/to/backup'
APP_NAME='The specific application you are backing up'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 60 days.
VERBOSE= By default verbose archiving is true, to limit the size of your logs, turn this to false.
```

auto_backup_mysql.sh
```bash
DB_BACKUP_PATH='/folder/to/backup/to'
MYSQL_USER='Your MySql user'
DATABASE_NAME='MySql db you want to backup'
BACKUP_RETAIN_DAYS=Days you want to keep backups, default 60 days.
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

If your file auto_backup_files.sh config looks like this 

`FILE_BACKUP_PATH='/var/backups/html'` 

then make that dir:
```config
mkdir -p /var/backups/html
```
If your file auto_backup_mysql.sh config looks like this 

`DB_BACKUP_PATH='/var/backups/mysql'` 

then make that dir:
```config
mkdir -p /var/backups/mysql
```
## 🚀 You're done and ready for disaster! 🚀  

---
<br>

# 🐛 Toubleshooting  
## The scripts do not run.

Make sure you can run the script manually, example:
```config
./auto_backup_files.sh
```
This should shout out any error.

## Where can I find logs to see if they ran or not.

- on Debian-based systems, like Ubuntu:
```bash
grep auto_backup /var/log/syslog
```
- on RHEL-based systems, like CentOS:
```bash
grep auto_backup /var/log/cron
```

## Make sure your cron service is running.

- on Debian-based systems, like Ubuntu:
```bash
systemctl status cron
```
- on RHEL-based systems, like CentOS:
```bash
systemctl status crond
```
---
# 🥳 DR Cheat Sheet 
## Files/Folders restore
For unzipping files, first clear the target directory:
```bash
rm -rf /directory/to/restore/to
```
Then extract and output the backup
```bash
tar -zxf backup.tar.gz -C /directory/to/restore/to
```
## MySql database restore
First, drop the db you are restoring:

Log into mysql
```bash
mysql -u root -p
```
Now make sure you choose the right database:
```mysql
SHOW DATABASES;
```
**WARNING** Make sure you drop the right one!
```mysql
DROP DATABASE db-to-restore;
```
Now create it again:
```mysql
CREATE DATABASE db-to-restore;
```
After that is successful, exit mysql and import the file:
```mysql
exit;
```
Then, extract the backup:
```bash
gzip -d < backup-dbname.sql.gz
```
Last import backed up db.
```bash
mysql -u root -p db-to-restore < backup-dbname.sql
```
