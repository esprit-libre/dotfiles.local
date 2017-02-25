#! /usr/bin/env bash
#https://serversforhackers.com/video/customize-your-login-screen-via-linuxs-message-of-the-day-ubuntucentos
# Basic info
HOSTNAME=$(uname -n)
ROOT=$(df -Ph |grep /$ | awk '{print $4}')
UPTIME=$(uptime -p | sed -e 's/up //')

# System load
MEMORY1=$(free -t -m | grep Total | awk '{print $3" MB";}')
MEMORY2=$(free -t -m | grep "Mem" | awk '{print $2" MB";}')
LOAD1=$(cat /proc/loadavg | awk {'print $1'})
LOAD5=$(cat /proc/loadavg | awk {'print $2'})
LOAD15=$(cat /proc/loadavg | awk {'print $3'})

echo "
===============================================
 - Hostname............: $HOSTNAME
 - Disk Space..........: $ROOT remaining
 - Up since............: $UPTIME
===============================================
 - CPU usage...........: $LOAD1, $LOAD5, $LOAD15 (1, 5, 15 min)
 - Memory used.........: $MEMORY1 / $MEMORY2
 - Swap in use.........: `free -m | tail -n 1 | awk '{print $3}'` MB
===============================================
"
