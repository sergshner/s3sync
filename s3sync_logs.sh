#!/bin/bash
source `dirname $0`/s3sync_init.sh
for dir in "${LOGS_DIRS[@]}"; do
	/usr/bin/s3cmd sync $dir s3://$LOGS_BUCKET$dir
	if [ $? -eq 0 ]
	then
	  echo "$dir successfully synced to S3"
	else
	  echo "The error has happened during sync $dir to S3" >&2
	  exit $?
	fi
done