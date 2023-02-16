#!/bin/bash
. ./config.conf
. ./info.sh

HOSTNAME=$(hostname)
timedatectl set-timezone Europe/Moscow
TIMEZONE="$(cat /etc/timezone) $(date -u "+%Z") $(date -u "+%z")"
USER=$(whoami)
OS=$(cat /etc/issue | awk '{print $1,$2,$3}' | tr -s '\r\n' ' ')
DATE=$(date "+%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(hostname -I | awk '{print $2}')
MASK=$(ifconfig | grep -m1 netmask | awk '{print $4}')
GATEWAY=$(ip route | grep default | awk '{print $3}')
RAM_TOTAL=$(free | grep "Mem" | awk '{printf "%.3f GB", ($2/1048576)}')
RAM_USED=$(free| grep "Mem" | awk '{printf "%.3f GB", ($3/1048576)}')
RAM_FREE=$(free| grep "Mem" | awk '{printf "%.3f GB", ($4/1048576)}')
SPACE_ROOT=$(df -m | grep "/$" | awk '{printf "%.2f MB", ($2/1024)}')
SPACE_ROOT_USED=$(df -m | grep "/$" | awk '{printf "%.2f MB", ($3/1024)}')
SPACE_ROOT_FREE=$(df -m | grep "/$" | awk '{printf "%.2f MB", ($4/1024)}')

reg="^[1-6]$"
default=0
if ! [[ $column1_background =~ $reg ]] || ! [[ $column1_font_color =~ $reg ]] || 
   ! [[ $column2_background =~ $reg ]] || ! [[ $column2_font_color =~ $reg ]]
then
    background1=6
    text1=1
    background2=2
    text2=4
    default=1
    info $background1 $text1 $background2 $text2
else
    info ${column1_background} ${column1_font_color} ${column2_background} ${column2_background}
fi    
