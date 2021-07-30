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
BACKUP_RETAIN_DAYS=120   ## Number of days to keep local backup copy
LOGFILE="${FILE_BACKUP_PATH}/log/${APP_NAME}".log
#################################################################

mkdir -p ${FILE_BACKUP_PATH}/${TODAY}
echo "Backup started for html files @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "Backup retention: ${BACKUP_RETAIN_DAYS} days" >> "$LOGFILE"

cd ${FILE_BACKUP_PATH}/${TODAY}
tar -cvzf ${APP_NAME}-${TODAY}.tar.gz ${FILE_BACKUP_SRC} >> "$LOGFILE" 2>&1


echo "FILE/FOLDER backup successfully completed @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "********************************************************************" >> "$LOGFILE"


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