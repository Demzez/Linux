#!/bin/bash
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

    info
    read -p "Do you want to save data into file? (Y/N):" input

    if [[ $input = y ]] || [[ $input = Y ]]
    then
        current_date=$(date +'%d_%m_%y_%H_%M_%S.status')
        touch $current_date
        info >> "$current_date"
        echo "File saved"
    else
        echo "File not saved"
    fi
