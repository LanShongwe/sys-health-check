#!/bin/bash

##==## setup-cron.sh - [ Installs cron job to run healthcheck.sh 
##==##                   hourly {Adjustable based on your requirements}] 

CRON_FILE="/etc/cron.d/sys-health-check"

echo "Setting up system health check cron..."

# Create cron job (runs every hour at minute 0)
echo "0 * * * * root /healthcheck.sh >> /var/log/sys-health-check/cron.log 2>&1" > "$CRON_FILE"

# Set correct permissions
chmod 644 "$CRON_FILE"

# Restart cron service (for most systems)
systemctl restart cron || service cron restart

echo "✅ Cron job installed to run hourly."