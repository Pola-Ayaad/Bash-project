#!/bin/bash

clear

while true; do
select choice in "Create Database" "Connect to a Database" "List Databases" "Drop Database" "Exit"
    do
        case $REPLY in
            1)
            . ./create_database.sh
            break
            ;;
            2)
            . ./database_connect.sh
            break 
            ;;
            3)
            . ./list_databases.sh
            break
            ;;
            4)
            . ./delete_database.sh
            break
            ;;
            5)
            echo "Good Bye!" 
            exit 0 
            ;;
            *) echo "Wrong choice, Please enter a valid option"; break
        esac
    done
done
