#!/bin/bash
clear
echo "Select From Table:"
echo "----------------- "

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
then
     mkdir ./Databases
fi

found=0
#Display Table
cat ./Databases/$dbname/$table_name
echo "==============================================="

#Get number of records in table
record_num=`awk -F: 'END {print NR}' ./Databases/$dbname/$table_name`
record_pointer=3

#Check if table is empty or not
if [ $record_num == 2 ]
then
    echo "Table is empty.Please insert some data first"
    sleep 5
    . ./display_table.sh yes
else
    #Ask user to enter value of primary key of record to be selected
    while true
    do
        read -p "Please enter primary key: " primary_key
        if [[ ! $primary_key =~ ^[1-9][0-9]*$ ]]
            then
                echo "Please enter a valid primary key"
            else
                break
        fi
    done

    #loop over table records till record to be selected is found
    while [ $record_pointer -le $record_num ]
    do
        if [ $primary_key -eq `awk -F: 'FNR == '$record_pointer' {print $1}' ./Databases/$dbname/$table_name` ]
        then
            awk 'FNR == '$record_pointer' {print}' ./Databases/$dbname/$table_name
            found=1
            break
        fi
        ((record_pointer=record_pointer+1))
    done
    #If no records found for given pk
    if [ $found == 0 ]
    then
        echo "Record not found"
    fi
fi
echo "====================================================================="
echo "Please select your next action: "
select choice in "Select another record" "Back" "Back to main menu" "Exit"
do
    case $REPLY in
        1) . ./select_from_table.sh
        ;;
        2) . ./display_table.sh yes
        ;;
        3) . ./main.sh
        ;;
        4) exit
        ;;
        *) echo "Wrong choice, Please enter a valid option"
    esac
done