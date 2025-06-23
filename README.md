# System Health Check & Alert Script

This is a lightweight and portable Bash-based system monitoring tool for Linux systems. It runs automatically every hour, checks for system health issues, logs all results, and sends alerts to Microsoft Teams and/or Slack if any thresholds are exceeded.

## What It Does

- Monitors:
  - System uptime
  - CPU load
  - Disk usage on the root (/) partition
  - Zombie processes
- Logs daily metrics to `/var/log/sys-health-check/YYYY-MM-DD.log`
- Sends alerts to Microsoft Teams or Slack when any threshold is breached
- Shows top 3 resource-consuming processes by CPU usage

## Prerequisites

- Linux system with Bash shell (Ubuntu, Debian, CentOS, RHEL, Rocky, Alma)
- `cron` installed and running
- Webhook URL for Slack and/or Microsoft Teams

## Make Scripts Executable

    chmod +x healthcheck.sh setup-cron.sh

## Update Configuration

    Open the configuration file:
        $ nano config.sh

        NB: In this file, you can set:

            CPU_THRESHOLD — e.g., 2.0 means alert if 1-minute load average is over 2.0
            DISK_THRESHOLD — e.g., 80 means alert if disk usage is over 80%
            ZOMBIE_THRESHOLD — e.g., 1 means alert if more than 1 zombie process is found
            SEND_TEAMS=true — enable sending alerts to Microsoft Teams
            SEND_SLACK=true — enable sending alerts to Slack
            Provide valid TEAMS_WEBHOOK and/or SLACK_WEBHOOK URLs

        Save and close the file.

##  Install Cron Job

    To schedule the script to run every hour:
        $ sudo ./setup-cron.sh

    This sets up a cron job that runs healthcheck.sh at the start of every hour 
    and logs its output to /var/log/sys-health-check/cron.log.

## Viewing Logs

    Daily logs are stored in:
        /var/log/sys-health-check/YYYY-MM-DD.log

    NB: These logs include all health checks and alerts that were triggered for that day.

## Changing the Check Frequency

    If you'd like to run the script more or less frequently 
    than every hour, you can manually edit the cron job:

    $ sudo nano /etc/cron.d/sys-health-check

    NB: Modify the timing format to your preference using standard cron syntax.

## Alert Example

    If the CPU load or disk usage exceeds the set threshold, you’ll receive a notification in Teams or Slack formatted as follows:

    ********************************************************************************************************
    ========================================================================================================

    System Health Check Alert — Host: prod-server-01

    Timestamp: 2025-06-19 13:00 UTC

    System Status Overview:

    | Metric           | Value     | Threshold | Status   |
    |------------------|-----------|-----------|----------|
    | Uptime           | 42 min    | —         | Warning  |
    | CPU Load         | 2.67      | 2.0       | High     |
    | Disk Usage (/)   | 82%       | 80%       | High     |
    | Zombie Processes | 2         | 1         | High     |

    Top Resource-Consuming Processes:

    | PID   | Process Name | CPU %  | Memory % |
    |-------|--------------|--------|----------|
    | 1543  | java         | 45.7   | 10.2     |
    | 2112  | python3      | 35.1   | 9.5      |
    | 3021  | postgres     | 25.4   | 7.6      |

    Recommended Actions:
    - Check and optimize the listed high CPU usage processes
    - Free up disk space on root partition (/)
    - Investigate zombie processes if any

    ********************************************************************************************************
    ========================================================================================================

## Notes

    - Alerts will only be sent if any threshold is exceeded. If everything is normal, no alert will be sent.
    - This script is designed to be efficient and low-impact on system performance.
    - No third-party dependencies are required — only standard Linux utilities.