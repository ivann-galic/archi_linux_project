#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4
file_size=$5




 # get the size of the logs files:
 if [ -e /home/$USER/$folder_name/$infos_log_file ] && [ -e /home/$USER/$folder_name/$errors_log_file ];
    then
        size_infos=`du -k /home/$USER/$folder_name/$infos_log_file | cut -f1`
        size_errors=`du -k /home/$USER/$folder_name/$errors_log_file| cut -f1`

        # compares the log file size to the size attribute and return the result.
        if [ $size_infos -gt $file_size ];
        then
            echo "The size of $infos_log_file ($size_infos ko) is higher than $file_size Ko";
            killall -9 generation.sh;
            tar -zcvf "$(date '+%Y-%m-%d').tar.gz" $infos_log_file $errors_log_file;
        elif [ $size_infos -eq $file_size ];
        then
            echo "The size of $infos_log_file ($size_infos ko) is equal to $file_size Ko";
        else 
            echo "The size of $infos_log_file ($size_infos ko) is lower than $file_size Ko";
        fi

        if [ $size_errors -gt $file_size ];
        then
            echo "The size of $errors_log_file ($size_errors ko) is higher than $file_size Ko";
            killall -9 generation.sh;
            tar -zcvf "$(date '+%Y-%m-%d').tar.gz" $infos_log_file $errors_log_file;
        elif [ $size_errors -eq $file_size ];
        then
            echo "The size of $errors_log_file ($size_errors ko) is equal to $file_size Ko";
        else 
            echo "The size of $errors_log_file ($size_errors ko) is lower than $file_size Ko";
        fi

    else 
        echo "Error: Missing log(s) file(s). Please execute generation.sh.";
fi