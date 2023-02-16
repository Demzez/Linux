#!/bin/bash

function info {
    get_color $1
    colback1="\033[4$?m"
    get_color $2
    colfont1="\033[3$?m"
    get_color $3
    colback2="\033[4$?m"
    get_color $4
    colfont2="\033[3$?m"
    default_colors="\033[0m"
    
    echo -e "${colback1}${colfont1}HOSTNAME${default_colors} = ${colback2}${colfont2}$HOSTNAME${default_colors}"
    echo -e "${colback1}${colfont1}TIMEZONE${default_colors} = ${colback2}${colfont2}$TIMEZONE${default_colors}"
    echo -e "${colback1}${colfont1}USER${default_colors} = ${colback2}${colfont2}$USER${default_colors}"
    echo -e "${colback1}${colfont1}OS${default_colors} = ${colback2}${colfont2}$OS${default_colors}"
    echo -e "${colback1}${colfont1}DATE${default_colors} = ${colback2}${colfont2}$DATE${default_colors}"
    echo -e "${colback1}${colfont1}UPTIME${default_colors} = ${colback2}${colfont2}$UPTIME${default_colors}"
    echo -e "${colback1}${colfont1}UPTIME_SEC${default_colors} = ${colback2}${colfont2}$UPTIME_SEC${default_colors}"
    echo -e "${colback1}${colfont1}IP${default_colors} = ${colback2}${colfont2}$IP${default_colors}"
    echo -e "${colback1}${colfont1}MASK${default_colors} = ${colback2}${colfont2}$MASK${default_colors}"
    echo -e "${colback1}${colfont1}GATEWAY${default_colors} = ${colback2}${colfont2}$GATEWAY${default_colors}"
    echo -e "${colback1}${colfont1}RAM_TOTAL${default_colors} = ${colback2}${colfont2}$RAM_TOTAL${default_colors}"
    echo -e "${colback1}${colfont1}RAM_USED${default_colors} = ${colback2}${colfont2}$RAM_USED${default_colors}"
    echo -e "${colback1}${colfont1}RAM_FREE${default_colors} = ${colback2}${colfont2}$RAM_FREE${default_colors}"
    echo -e "${colback1}${colfont1}SPACE_ROOT${default_colors} = ${colback2}${colfont2}$SPACE_ROOT${default_colors}"
    echo -e "${colback1}${colfont1}SPACE_ROOT_USED${default_colors} = ${colback2}${colfont2}$SPACE_ROOT_USED${default_colors}"
    echo -e "${colback1}${colfont1}SPACE_ROOT_FREE${default_colors} = ${colback2}${colfont2}$SPACE_ROOT_FREE${default_colors}"
    print_info_color $default
}
function get_color {
    res=0
    case "$1" in
        1) res=7 ;;
        2) res=1 ;;
        3) res=2 ;;
        4) res=4 ;;
        5) res=5 ;;
        6) res=0 ;;
    esac
    return $res
}

function print_info_color {
    echo -e "\nColumn 1 background = $(if [[ $1 -eq 1 ]] ; then echo "default (black)" ; else echo -n ${column1_background}; print_color_text ${column1_background}; fi)"
    echo "Column 1 font color = $(if [[ $1 -eq 1 ]] ; then echo "default (white)" ; else echo -n ${column1_font_color}; print_color_text ${column1_font_color}; fi) "
    echo "Column 2 background = $(if [[ $1 -eq 1 ]] ; then echo "default (red)" ; else echo -n ${column2_background}; print_color_text ${column2_background}; fi)"
    echo "Column 2 font color = $(if [[ $1 -eq 1 ]] ; then echo "default (blue)" ; else echo -n ${column2_font_color}; print_color_text ${column2_font_color}; fi)"
}

function print_color_text {
    case "$1" in
        1) echo " (white)" ;;
        2) echo " (red)" ;;
        3) echo " (green)" ;;
        4) echo " (blue)" ;;
        5) echo " (purple)" ;;
        6) echo " (black)" ;;
    esac
}
