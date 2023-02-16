#!/bin/bash

function condition {
if [[ $1 -ge 1 ]] && [[ $1 -le 6 ]]; 
then
    if [[ $2 -ge 1 ]] && [[ $2 -le 6 ]]; 
    then
        if [[ $1 -ne $2 ]];
        then
			if [[ $3 -ge 1 ]] && [[ $3 -le 6 ]];
            then
				if [[ $4 -ge 1 ]] && [[ $4 -le 6 ]]; 
                then
					if [[ $3 -ne $4 ]]; 
                    then
						echo "1"
						exit
					else 
						echo "3"
						exit
					fi		
				fi
			fi
		else 
			echo "2"
			exit
		fi
	fi
echo "0"	
fi
}
