#!/bin/bash
clear

tables=`ls ./Databases/$dbname | wc -l`
if [ $tables == 0 ]
then
    echo "Sorry, No tables found."
else
    echo "Tables List: "
    echo "==============================="
    ls ./Databases/$dbname
    echo "==============================="
    while true
    do
        if [ $1 == "yes" ]
        then
            table_name=$table_name
        else
            read -p "Please enter table name that you want to display: " table_name
        fi

        if [[ $table_name == +([A-Za-z_])* ]] && [[ ! $table_name =~ ['!@#$%^&*()+'] ]]
        then
            if [ -f ./Databases/$dbname/$table_name ]
            then
                clear
                cat ./Databases/$dbname/$table_name
                break
            else
                echo "Table Not Found!"
            fi
        else
            echo "Invalid Input. Try again."
        fi
    done
fi

echo "========================================"
echo "please select your next action: "
if [ ! $tables == 0 ]
then
    select choice in "Insert into table" "Select from table" "Delete from table" "Update Table" "Display Another Table" "Connect to another database" "Back to main menu" "Exit"
    do
        case $REPLY in
            1) . ./insert_into_table.sh
            ;;
            2) . ./select_from_table.sh
            ;;
            3) . ./delete_record.sh
            ;;
            4) . ./update_table.sh
            ;;
            5) . ./display_table.sh no
            ;;
            6) . ./database_connect.sh no
            ;;
            7) . ./main.sh
            ;;
            8) exit
            ;;
            *) echo "Invalid Option. Try again."
        esac
    done
else
    select choice in "Back" "Back to connect to another database" "Back to main menu" "Exit"
    do
        case $REPLY in
            1) . ./database_connect.sh yes
            ;;
            2) . ./database_connect.sh no
            ;;
            3) . ./main.sh
            ;;
            4) exit
            ;;
            *) echo "Invalid Option. Try again."
        esac
    done
fi
