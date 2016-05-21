#!/bin/bash
source `dirname $0`/s3sync_init.sh
# Backup web root
/usr/bin/s3cmd sync $BACKUP_WEB_PATH s3://$BACKUP_BUCKET/$BACKUP_WEB_PATH/
if [ $? -eq 0 ]
then
  echo "$BACKUP_WEB_PATH successfully synced to S3"
else
  echo "The error has happened during sync $BACKUP_WEB_PATH to S3" >&2
  exit $?
fi

# Backup mysql databases
docker exec -it mysql_c mysqldump -uroot -p$MYSQL_ROOT_PASS --all-databases --single-transaction > $BACKUP_MYSQL_PATH
if [ $? -eq 0 ]
then
  echo "mysqldump successfully created at $BACKUP_MYSQL_PATH"
else
  echo "The error has happened during mysqldump" >&2
  exit $?
fi
/usr/bin/s3cmd sync $BACKUP_MYSQL_PATH s3://$BACKUP_BUCKET/$BACKUP_MYSQL_PATH
if [ $? -eq 0 ]
then
  echo "$BACKUP_MYSQL_PATH successfully synced to S3"
else
  echo "The error has happened during sync $BACKUP_MYSQL_PATH to S3" >&2
  exit $?
fi
