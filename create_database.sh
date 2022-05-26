#!/bin/bash
clear
echo "Create Database:"
echo "----------------"

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
    then
         mkdir ./Databases
fi

while true
do
    while true
    do
        read -p "Please enter database name: " dbname
        #Used across multiple files in project.
        export dbname
        #Validate database name, begins with a letter and doesn't contain special characters.
        if [[ ! $dbname =~ ['!@#$%^&*()+'] ]] && [[ $dbname == +([A-Za-z])* ]];
        then
            break
        else
            echo "Invalid name for a database."
        fi
    done
    
    #Check for database existence
    if [ -d ./Databases/$dbname ]
    then
        echo "Unfortunately, this name already exists try another name."
    else
        mkdir ./Databases/$dbname
        echo "Congratulations, Your Database Added successfully"
        break
    fi  
done

echo "==========================================================="
echo "Please select your next action: "

select choice in "Add another Database" "Back to main menu" "Exit" 
do
   case $REPLY in
        1). ./create_database.sh
        ;;
        2). ./main.sh
        ;;
        3) exit
        ;;
        *) echo "Wrong choice, Please enter a valid option"
        ;;
    esac
done