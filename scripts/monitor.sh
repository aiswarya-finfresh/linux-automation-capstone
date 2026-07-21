#!/bin/bash

DISK_THRESHOLD=80
MEM_THRESHOLD=500
LOAD_THRESHOLD="1.5"
PROC_THRESHOLD=150

LOG_FILE="$HOME/capstone/logs/alerts.log"
CURRENT_DATE="[$(date +"%Y-%m-%d %H:%M:%S")]"
HEALTHY=true

CURRENT_DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
CURRENT_MEM=$(free -m | awk 'NR==2 {print $7}')
CURRENT_LOAD=$(uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $1}' | xargs)
CURRENT_PROC=$(ps -ef | wc -l | xargs)

if [ "$CURRENT_DISK" -gt "$DISK_THRESHOLD" ]; then
    echo "$CURRENT_DATE ALERT: Disk Usage is at ${CURRENT_DISK}%, threshold is ${DISK_THRESHOLD}%" >> "$LOG_FILE"
    HEALTHY=false
fi

if [ "$CURRENT_MEM" -lt "$MEM_THRESHOLD" ]; then
    echo "$CURRENT_DATE ALERT: Available Memory is at ${CURRENT_MEM}MB, threshold is ${MEM_THRESHOLD}MB" >> "$LOG_FILE"
    HEALTHY=false
fi

if (( $(echo "$CURRENT_LOAD > $LOAD_THRESHOLD" | bc -l) )); then
    echo "$CURRENT_DATE ALERT: 1-Min Load Average is at ${CURRENT_LOAD}, threshold is ${LOAD_THRESHOLD}" >> "$LOG_FILE"
    HEALTHY=false
fi

if [ "$CURRENT_PROC" -gt "$PROC_THRESHOLD" ]; then
    echo "$CURRENT_DATE ALERT: Running Processes are at ${CURRENT_PROC}, threshold is ${PROC_THRESHOLD}" >> "$LOG_FILE"
    HEALTHY=false
fi

if [ "$HEALTHY" = true ]; then
    echo "$CURRENT_DATE OK: all metrics within thresholds" >> "$LOG_FILE"
fi