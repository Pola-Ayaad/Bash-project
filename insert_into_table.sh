#!/bin/bash
clear

col_pointer=2
col_separator=":"
new_record=""

#Get last primary key inserted in table
primary_key=`sed '$!d' ./Databases/$dbname/$table_name | cut -f1 -d:`
#Check if it's the first record to be inserted set pk to 1 else increment it
expr $primary_key + 0 > /dev/null 2> /dev/null
if [ $? != 0 ]
then
    primary_key=1
else
    ((primary_key=$primary_key+1))
fi

#Get number of columns in table
col_num=`awk -F: 'END {print NF}' ./Databases/$dbname/$table_name`
while [ $col_pointer -le $col_num ]
do
    #Get column name
    col_name=`awk -F: 'FNR == 2 {print $'$col_pointer'}' ./Databases/$dbname/$table_name`
    read -p "Enter the value of $col_name: " field_data

    #check data type of column against entered data
    data_type=`awk -F: 'FNR == 1 {print $'$col_pointer'}' ./Databases/$dbname/$table_name`
    if [ $data_type == integer ]
    then
        if [[ ! $field_data =~ ^[0-9][0-9]*$ ]]
        then
            echo "It's not an integer value. Try again."
            continue
        fi
    fi
    if [ $data_type == string ]
    then
        if [[ ! $field_data == +([A-Za-z])* ]]
        then
            echo "It's not a string value. Try again."
            continue
        fi
    fi

    #check if it's the last column in table
    if [ $col_pointer -eq $col_num ]
    then
        new_record=$new_record$field_data
    else
        new_record=$new_record$field_data$col_separator
    fi
    #Move to the next column
    ((col_pointer=col_pointer+1))      
done

#Add primary key to the record and append it to the table file
new_record=$primary_key$col_separator$new_record
echo $new_record >> ./Databases/$dbname/$table_name
clear
echo "Record was added to the table successfuly."
echo "============================================================="
#Display table after insertion
cat ./Databases/$dbname/$table_name

echo "============================================================="
echo "please select your next action:"
select choice in "Add another record." "Back" "Back To Main Menu" "Exit" 
do
   case $REPLY in
    1). ./insert_into_table.sh
    ;;
    2). ./display_table.sh yes
    ;;
    3). ./main.sh
    ;;
    4) exit
    ;;
    *) echo "Wrong choice, Please enter a valid option"
    ;;
    esac
done