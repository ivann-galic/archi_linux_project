#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4
file_weight=$5

 # get the weigth of the logs folder :
 if [ -e /home/$USER/$folder_name/$infos_log_file ] && [ -e /home/$USER/$folder_name/$errors_log_file ];
    then
        du -sh /home/$USER/$folder_name/$infos_log_file;
        du -sh /home/$USER/$folder_name/$errors_log_file;
    else 
        echo "Error: Missing log(s) file(s). Please execute generation.sh.";
    fi