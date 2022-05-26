#!/bin/bash
clear

echo '
     +----------------------------- \
     |DBMS                           \
     |Made by : Muhammad Amin & Pola  \
     |DevOps Track                     \
     |Supervisor : Eng. Shereen         \
     +----------------------------------- '
echo "Main Menu:"
echo "----------"
PS3="> "
while true 
do
    select choice in "Create database" "Connect to a database" "List databases" "Drop database" "Exit"
    do
        case $REPLY in
            1)
            . ./create_database.sh
            ;;
            2)
            . ./database_connect.sh
            ;;
            3)
            . ./list_databases.sh
            ;;
            4)
            . ./delete_database.sh
            ;;
            5)
            clear
            echo "Thanks for using our DBMS!"
            echo "Program is closing.."
            sleep 5 
            exit 
            ;;
            *) echo "Wrong choice, Please enter a valid option"; break
        esac
    done
done
