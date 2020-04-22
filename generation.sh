#!/bin/bash

delay=$1
folder_name=$2
infos_log_file=$3
errors_log_file=$4

mkdir -p $folder_name
touch $folder_name/$infos_log_file
touch $folder_name/$errors_log_file

./genTick $delay | ./genSensorData 2>&1 | {
while IFS= read -r RAW_LINE; do
echo $RAW_LINE
    line_cut= $(echo $RAW_LINE | cut -d';' -f1);
    if [[ $line_cut == "sensor" ]];
    then
        echo $RAW_LINE >> $folder_name/$infos_log_file;
    elif [[ $line_cut == "error" ]];
    then
        echo $RAW_LINE >> $folder_name/$errors_log_file;
    elif [[ $line_cut == "Bienve" ]];
    then
        continue;
    else
        echo "Error";
    fi
done
}

#./genTick $1 | ./genSensorData > $folder_name/$infos_log_file
