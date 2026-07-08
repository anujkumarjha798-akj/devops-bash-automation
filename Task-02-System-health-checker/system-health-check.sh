#!/bin/bash

# ==============================
# Root Privilege Check
# ==============================
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script requires root privileges."
    echo "Usage: sudo ./system-health-check.sh"
    exit 1
fi

# ==============================
# Disk Usage
# ==============================
disk() {
    d_usage=$(df -h / | awk 'NR==2 {print int($5)}')

    echo
    echo "=========== DISK USAGE ==========="
    echo "Current Disk Usage : ${d_usage}%"

    if [[ "$d_usage" -gt 80 ]]; then
        echo "Warning: Disk usage is above 80% (Current: ${d_usage}%)"
    else
        echo "Disk usage is within the safe limit."
    fi
}

# ==============================
# RAM Usage
# ==============================
ram() {
    echo
    echo "=========== RAM USAGE ==========="

    echo "Total RAM : $(free -h | awk 'NR==2 {print $2}')"
    echo "Used RAM  : $(free -h | awk 'NR==2 {print $3}')"

    ram_used=$(free | awk 'NR==2 {print int(($3/$2)*100)}')

    echo "Current RAM Usage : ${ram_used}%"

    if [[ "$ram_used" -gt 75 ]]; then
        echo "Warning: RAM usage is above 75% (Current: ${ram_used}%)"
    else
        echo "RAM usage is within the safe limit."
    fi
}

# ==============================
# CPU Usage
# ==============================
cpu() {
    echo
    echo "=========== CPU USAGE ==========="

    cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100-$8)}')

    echo "Current CPU Usage : ${cpu_usage}%"

    if [[ "$cpu_usage" -gt 90 ]]; then
        echo "Warning: CPU usage is above 90% (Current: ${cpu_usage}%)"
    else
        echo "CPU usage is within the safe limit."
    fi
}

# ==============================
# Overall Health
# ==============================
overall() {
    echo
    echo "======= OVERALL SYSTEM HEALTH ======="

    if [[ "$cpu_usage" -gt 90 || "$ram_used" -gt 75 || "$d_usage" -gt 80 ]]; then
        echo "System Health Status : ATTENTION REQUIRED"
    else
        echo "System Health Status : HEALTHY"
    fi

    echo
}

# ==============================
# Log File
# ==============================
log_file="system_health.txt"

{
    echo "======================================="
    echo "         SYSTEM HEALTH REPORT"
    echo "======================================="
    echo "Generated On : $(date '+%Y-%m-%d %H:%M:%S')"
    echo

    disk
    ram
    cpu
    overall

} | tee -a "$log_file"
