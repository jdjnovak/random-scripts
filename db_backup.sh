#!/bin/bash

BACKUP_DIR="/path/to/backup/directory"
DB_NAME="Name of the DB"
DB_USER="Database user"

MAX_BACKUP=7 # Maximum backups will be allowed

# Check for backup directory, create if doesn't exist
if [ ! -d $BACKUP_DIR ]; then
    mkdir $BACKUP_DIR
fi

# Functions to count backups
count() {
    CURR_BACKUPS=$( ls $BACKUP_DIR | wc -l )
}

# Count current backups
count

# Check if max backups is reached
if [ "$CURR_BACKUPS" -eq "$MAX_BACKUP" ]; then
    # Note: I realise now that this is a little counter intuitive
    #       but 1.backup is the oldest backup and 7.backup is the
    #       newest backup. So this deletes 1.backup and renames
    #       all the backups from 2-7 to 1-6 respectively. Then it
    #       recreates 7.backup
    PREV=1;
    rm "$BACKUP_DIR/1.backup";
    for NUM in {2..7}; do
        mv "$BACKUP_DIR/$NUM.backup" "$BACKUP_DIR/$PREV.backup";
        PREV=$NUM;
    done;
    pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_DIR/7.backup";
else
    # If the maximum number of backups exist, then just make the
    # next backup
    let NEXT=$(expr $CURR_BACKUPS+1)
    pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_DIR/$NEXT.backup";
fi
