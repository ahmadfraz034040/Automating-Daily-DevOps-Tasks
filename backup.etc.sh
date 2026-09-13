#!/bin/bash
backup_dir="/home/ubuntu/backup"
filename="etc-backup-$(date +%F).tar.gz"
mkdir -p $backup_dir
tar -czf $backup_dir/$filename /etc
echo "backup completed  : $backup_dir/$filename"
