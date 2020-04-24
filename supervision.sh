#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4
file_size=$5
report_file=report.log
script_execution=true

check_generation=$(pgrep generation >/dev/null ; echo $?)

current_path=$(echo $PWD)

while [ script_execution ]; do

    # Verifies if generation.sh is not already running to start the script :
    if [ $check_generation -ne 0 ]
        then
            ./generation.sh $delay $folder_name $infos_log_file $errors_log_file &
            sleep 1
    fi

    if [ -e /home/$USER/$folder_name/$infos_log_file ] && [ -e /home/$USER/$folder_name/$errors_log_file ]
        then
            # gets the size of the logs files:
            size_infos=`du -k /home/$USER/$folder_name/$infos_log_file | cut -f1`
            size_errors=`du -k /home/$USER/$folder_name/$errors_log_file| cut -f1`

        # compares the log file size to the size attribute and return the result.
        if [ $size_infos -gt $file_size ];
        then
            echo "The size of $infos_log_file ($size_infos ko) is higher than $file_size Ko"
        elif [ $size_infos -eq $file_size ];
        then
            echo "The size of $infos_log_file ($size_infos ko) is equal to $file_size Ko"
        else 
            echo "The size of $infos_log_file ($size_infos ko) is lower than $file_size Ko"
        fi

        if [ $size_errors -gt $file_size ];
        then
            echo "The size of $errors_log_file ($size_errors ko) is higher than $file_size Ko"
        elif [ $size_errors -eq $file_size ];
        then
            echo "The size of $errors_log_file ($size_errors ko) is equal to $file_size Ko"
        else 
            echo "The size of $errors_log_file ($size_errors ko) is lower than $file_size Ko"
        fi

        if [ $size_infos -gt $file_size ] || [ $size_errors -gt $file_size ]
        then
            # kills the generation script, compresses log files :
            killall generation.sh
            check_generation=1
            cd $HOME/$folder_name/
            # sorts infos and errors.log by id number :
            sort --output $infos_log_file --version-sort --reverse $infos_log_file  
            sort --output $errors_log_file--version-sort --reverse $errors_log_file 
            number_line_infos=$(wc -l $infos_log_file | cut -d' ' -f1)
            number_line_errors=$(wc -l $errors_log_file | cut -d' ' -f1)
            # creates report.log to write how many lines there are in infos and errors.log :
            touch report.log
            echo "$infos_log_file countains $number_line_infos lines." > $report_file
            echo "$errors_log_file countains $number_line_errors lines." >> $report_file
            tar -zcvf "$(date '+%Y-%m-%d_%H%M%S').tar.gz" $report_file $infos_log_file $errors_log_file
            # removes the last log files, creates new ones and retart generation script :
            rm $infos_log_file $errors_log_file $report_file
            # touch $infos_log_file $errors_log_file
            cd -
        fi
    else 
        echo "Error: Missing log(s) file(s). Please execute generation.sh.";
    fi
sleep 3
done 

