#!/bin/bash
BACKUP_BUCKET=myproject-backups
LOGS_BUCKET=myproject-logs
BACKUP_WEB_PATH=/var/www/html
BACKUP_MYSQL_PATH=/var/docker/backups/mysql_backup.sql
LOGS_DIRS=(
	"/var/docker/log/*"
)
