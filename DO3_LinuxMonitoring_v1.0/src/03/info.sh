#!/bin/bash

. ./colors.sh

function info {
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

case $1 in
1) colback1=$white_back ;;
2) colback1=$red_back ;;
3) colback1=$green_back ;;
4) colback1=$blue_back ;;
5) colback1=$purple_back ;;
6) colback1=$black_back ;;
esac

case $2 in
1) colfont1=$white_text ;;
2) colfont1=$red_text ;;
3) colfont1=$green_text ;;
4) colfont1=$blue_text ;;
5) colfont1=$purple_text ;;
6) colfont1=$black_text ;;
esac

case $3 in
1) colback2=$white_back ;;
2) colback2=$red_back ;;
3) colback2=$green_back ;;
4) colback2=$blue_back ;;
5) colback2=$purple_back ;;
6) colback2=$black_back ;;
esac

case $4 in
1) colfont2=$white_text ;;
2) colfont2=$red_text ;;
3) colfont2=$green_text ;;
4) colfont2=$blue_text ;;
5) colfont2=$purple_text ;;
6) colfont2=$black_text ;;
esac

echo -e "${colback1}${colfont1}HOSTNAME = ${colback2}${colfont2}$HOSTNAME${default}" 
echo -e "${colback1}${colfont1}TIMEZONE = ${colback2}${colfont2}$TIMEZONE${default}" 
echo -e "${colback1}${colfont1}USER = ${colback2}${colfont2}$USER${default}"
echo -e "${colback1}${colfont1}OS = ${colback2}${colfont2}$OS${default}"
echo -e "${colback1}${colfont1}DATE = ${colback2}${colfont2}$DATE${default}"
echo -e "${colback1}${colfont1}UPTIME = ${colback2}${colfont2}$UPTIME${default}"
echo -e "${colback1}${colfont1}UPTIME_SEC = ${colback2}${colfont2}$UPTIME_SEC${default}"
echo -e "${colback1}${colfont1}IP = ${colback2}${colfont2}$IP${default}"
echo -e "${colback1}${colfont1}MASK = ${colback2}${colfont2}$MASK${default}"
echo -e "${colback1}${colfont1}GATEWAY = ${colback2}${colfont2}$GATEWAY${default}"
echo -e "${colback1}${colfont1}RAM_TOTAL = ${colback2}${colfont2}$RAM_TOTAL${default}"
echo -e "${colback1}${colfont1}RAM_USED = ${colback2}${colfont2}$RAM_USED${default}"
echo -e "${colback1}${colfont1}RAM_FREE = ${colback2}${colfont2}$RAM_FREE${default}"
echo -e "${colback1}${colfont1}SPACE_ROOT = ${colback2}${colfont2}$SPACE_ROOT${default}"
echo -e "${colback1}${colfont1}SPACE_ROOT_USED = ${colback2}${colfont2}$SPACE_ROOT_USED${default}"
echo -e "${colback1}${colfont1}SPACE_ROOT_FREE = ${colback2}${colfont2}$SPACE_ROOT_FREE${default}"
}
