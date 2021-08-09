#!/bin/bash 
################################################################
##
##   File/Folder Backup Script 
##   Written By: Tyler Geyser
##
################################################################ 
TODAY=`date +"%d%b%Y"`
################################################################
################## Update below values  ######################## 
FILE_BACKUP_PATH='/var/backups'
FILE_BACKUP_SRC='/var/www/html'
APP_NAME='myApp'
BACKUP_RETAIN_DAYS=60   ## Number of days to keep local backup copy
LOGFILE="${FILE_BACKUP_PATH}/log/${APP_NAME}".log
VERBOSE=true
#################################################################

mkdir -p ${FILE_BACKUP_PATH}/${TODAY}
mkdir -p ${FILE_BACKUP_PATH}/log
echo "Backup started for html files @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "Backup retention: ${BACKUP_RETAIN_DAYS} days" >> "$LOGFILE"

cd ${FILE_BACKUP_PATH}/${TODAY}

if $VERBOSE 
then
      tar -cvzf ${APP_NAME}-${TODAY}.tar.gz ${FILE_BACKUP_SRC} >> "$LOGFILE" 2>&1
else
      tar -czf ${APP_NAME}-${TODAY}.tar.gz ${FILE_BACKUP_SRC} >> "$LOGFILE" 2>&1
fi


if [ $? -eq 0 ]; then
      FILE_SIZE=$(wc -c "${APP_NAME}-${TODAY}.tar.gz" | awk '{print $1}')
      echo "Total Size: " $FILE_SIZE >> "$LOGFILE"
      echo "FILE/FOLDER backup successfully completed @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
      echo "********************************************************************" >> "$LOGFILE"
else
      echo "Error found during backup @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
      echo "********************************************************************" >> "$LOGFILE"
      exit 1
fi

##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${FILE_BACKUP_PATH} ]; then
      cd ${FILE_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
            echo "Deleted older backup: ${DBDELDATE} @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
            echo "********************************************************************" >> "$LOGFILE"
      fi
fi
 
### End of script ####