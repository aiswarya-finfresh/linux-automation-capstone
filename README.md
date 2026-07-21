# Linux Server Automation & Monitoring Capstone

## Project Overview
This repository contains an automated server maintenance and performance monitoring setup developed using Bash scripting and cron scheduled tasks.

## Key Scripts
- `scripts/backup.sh`: Compresses target directory contents into timestamped `.tar.gz` archives, maintains logs, and deletes backups older than 7 days.
- `scripts/monitor.sh`: Checks system metrics (Disk, RAM, CPU Load, Process count) against threshold values and logs alerts or health status.

## Automation Setup
The scripts are automated using system crontab:
- Daily backups scheduled at 02:00 AM.
- System health checks performed every 15 minutes.

## Environment & Layout
Development was validated inside a Dockerized Linux shell and organized across synchronized `tmux` panes.