#!/bin/bash

clear
if ! [ -d ./Databases ]
    then
         mkdir ./Databases
fi

while true
do
    while true
    do
        read -p "Please enter database name: " dbname
        export dbname
        if [[ ! $dbname =~ ['!@#$%^&*()+'] ]] && [[ $dbname == +([A-Za-z])* ]];
            then
                break
            else
                echo "invalid name."
        fi
    done
    
    #check for database existence
    if [ -d ./Databases/"$dbname" ]
        then
            echo "Unfortunately, this name already exists try another name."
        else
            mkdir ./Databases/"$dbname"
            echo "congratulations, Your Database Added successfully"
            break
    fi  
done

echo "==========================================================="
echo "please select your next action:"

select choice in "Add Another Database" "Back To Main Menu" "Exit" 
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