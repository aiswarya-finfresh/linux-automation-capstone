#!/bin/bash

# Validate source directory argument
if [ -z "$1" ]; then
    echo "Error: No source directory provided."
    echo "Usage: $0 <source_directory>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$HOME/capstone/backups"
LOG_FILE="$HOME/capstone/logs/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")
ARCHIVE_NAME="backup-data-${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform backup
if tar -czf "${BACKUP_DIR}/${ARCHIVE_NAME}" "$SOURCE_DIR" 2>/dev/null; then
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] SUCCESS: archived ${SOURCE_DIR} -> ${ARCHIVE_NAME}" >> "$LOG_FILE"
    echo "Backup completed successfully!"
else
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] ERROR: failed to archive ${SOURCE_DIR}" >> "$LOG_FILE"
    echo "Backup failed!"
    exit 1
fi

# Cleanup backups older than 7 days
find "$BACKUP_DIR" -name "backup-data-*.tar.gz" -mtime +7 -exec rm -f {} \;