#!/bin/bash
. ./function.sh

start=`date +%s`

if [[ -n $1 ]]
then
    if [[ -d $1 ]]
    then
        if [[ ${1: -1} = "/" ]]
        then
            total_number_folders $1
            top_five_folders $1
            total_number_files $1
            number_configure_files $1
            top_ten_files_large_weight $1
            top_ten_executables_files $1
            time_execution_script $start
        else
            echo "Directory does not end with '/'"
        fi
    else
        echo "It's not a directory"
    fi
else
    echo "Parameter is required. Try again."
fi
        