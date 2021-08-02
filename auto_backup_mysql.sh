#!/bin/bash 
################################################################
##
##   MySQL Database Backup Script 
##   Written By: Tyler Geyser
##
################################################################ 
TODAY=`date +"%d%b%Y"`
################################################################
################## Update below values  ######################## 
DB_BACKUP_PATH='/var/backups'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER=''
DATABASE_NAME=''
BACKUP_RETAIN_DAYS=120  ## Number of days to keep local backup copy
LOGFILE="${DB_BACKUP_PATH}/log/${DATABASE_NAME}".log 
#################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY} 
echo "Backup started for database - ${DATABASE_NAME} @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "Backup retention: ${BACKUP_RETAIN_DAYS} days" >> "$LOGFILE"
 
 
mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz

FILE_SIZE=$(wc -c "${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz" | awk '{print $1}')
echo "Total Size: " $FILE_SIZE >> "$LOGFILE"

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
  echo "********************************************************************" >> "$LOGFILE"
else
  echo "Error found during backup @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
  echo "********************************************************************" >> "$LOGFILE"
  exit 1
fi
 
 
##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
            echo "Deleted older backup: ${DBDELDATE} @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
            echo "********************************************************************" >> "$LOGFILE"
      fi
fi
 
### End of script ####
