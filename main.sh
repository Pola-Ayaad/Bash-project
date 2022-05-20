#!/bin/bash

databasesPath="/home/muhmdamin/project/databases"
create_database () {
    maxchar=24
    read -p "Please enter database name: " name 
    #check for database existence
    for database in `ls $databasesPath`
    do
        if [ $name = $database ] 
        then
            echo "database already exist, Please enter a valid name."
            read -p "Please enter database name: " name
            continue
        fi
    done

    if [ ${#name} -lt $maxchar ] && [[ $name == +([A-Za-z])* ]];
    then
        mkdir "$databasesPath/$name"
        echo "Database created successfully."
    else
        echo "invalid name."
        create_database
    fi
}

list_database () {
    ls $databasesPath
}

while true; do
select choice in "Create Database" "Connect to a Database" "List Databases" "Drop Database" "Exit"
    do
        case $choice in
            "Create Database")
            create_database
            break
            ;;
            "Connect to a Database")
            echo "database connected."
            break 
            ;;
            "List Databases")
            list_database
            break
            ;;
            "Drop Database")
            echo "Database dropped."
            break
            ;;
            "Exit")
            echo "Good Bye!" 
            exit 0 
            ;;
            *) echo "Wrong choice, Please enter a valid option"; break
        esac
    done
done
