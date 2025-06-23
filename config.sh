#!/bin/bash

##==## config.sh - [ Configuration for system health check {Editable} ] ##==##

CPU_THRESHOLD=2.0
DISK_THRESHOLD=80
ZOMBIE_THRESHOLD=1

LOG_DIR="/var/log/sys-health-check"

# Alert destination toggles
SEND_TEAMS=true
SEND_SLACK=false

# Webhooks (replace with your actual URLs)
TEAMS_WEBHOOK="https://outlook.office.com/webhook/YOUR_TEAMS_WEBHOOK"
SLACK_WEBHOOK="https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK"