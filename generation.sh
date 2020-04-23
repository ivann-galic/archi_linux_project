#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4

myUserPath=/home/$USER #get the user's main folder path
mkdir -p $myUserPath/$folder_name
touch $myUserPath/$folder_name/$infos_log_file
touch $myUserPath/$folder_name/$errors_log_file


# gets all the results form genTick and redirect it on a specific log file :
./genTick $delay | ./genSensorData 2>&1 | {
while IFS= read -r RAW_LINE; do
    line_cut=$(echo $RAW_LINE | cut -d';' -f1);
    result_to_write=$(echo $RAW_LINE | cut -d';' -f1,2,3,5,6);
    if [[ $line_cut == "sensor" ]];
    then
        echo $result_to_write >> $myUserPath/$folder_name/$infos_log_file;
    elif [[ $line_cut == "error" ]];
    then
        echo $RAW_LINE >> $myUserPath/$folder_name/$errors_log_file;
    elif [[ $RAW_LINE == "Welcome !" ]];
    then
        continue;
    else
        echo "Error";
    fi
done
}