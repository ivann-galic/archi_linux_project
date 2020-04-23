#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4
file_size=$5
script_execution=true


current_path=$(echo $PWD);
#if $script_execution;
#then

    #./generation.sh $delay $folder_name $infos_log_file $errors_log_file
    #while IFS= read -r RAW_LINE; do

    if [ -e /home/$USER/$folder_name/$infos_log_file ] && [ -e /home/$USER/$folder_name/$errors_log_file ];
        then
            # get the size of the logs files:
            size_infos=`du -k /home/$USER/$folder_name/$infos_log_file | cut -f1`
            size_errors=`du -k /home/$USER/$folder_name/$errors_log_file| cut -f1`

            # compares the log file size to the size attribute and return the result.
            if [ $size_infos -gt $file_size ];
            then
                echo "The size of $infos_log_file ($size_infos ko) is higher than $file_size Ko";
            elif [ $size_infos -eq $file_size ];
            then
                echo "The size of $infos_log_file ($size_infos ko) is equal to $file_size Ko";
            else 
                echo "The size of $infos_log_file ($size_infos ko) is lower than $file_size Ko";
            fi

            if [ $size_errors -gt $file_size ];
            then
                echo "The size of $errors_log_file ($size_errors ko) is higher than $file_size Ko";
            elif [ $size_errors -eq $file_size ];
            then
                echo "The size of $errors_log_file ($size_errors ko) is equal to $file_size Ko";
            else 
                echo "The size of $errors_log_file ($size_errors ko) is lower than $file_size Ko";
            fi

            if [ $size_infos -gt $file_size ] || [ $size_errors -gt $file_size ]
            then
                # kills the generation script, compresses log files :
                killall -9 generation.sh;
                cd /home/coding/$folder_name/
                tar -zcvf "$(date '+%Y-%m-%d').tar.gz" $infos_log_file $errors_log_file
                # removes the last log files, creates new ones and retart generation script :
                rm $infos_log_file $errors_log_file
                touch $infos_log_file $errors_log_file
                
                cd $current_path
            fi

        else 
            echo "Error: Missing log(s) file(s). Please execute generation.sh.";
    fi
   #done 
#fi