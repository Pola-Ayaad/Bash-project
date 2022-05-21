#!/bin/bash

clear
if ! [ -d ./Databases ]
    then
         mkdir ./Databases
fi
maxchar=24

while true
do
    while true
    do
        read -p "Please enter database name: " name
        export name
        if [ ${#name} -lt $maxchar ] && [[ $name == +([A-Za-z])* ]];
            then
                break
            else
                echo "invalid name."
        fi
    done
    
    #check for database existence
    if [ -d ./Databases/"$name" ]
        then
            echo "Unfortunately, this name already exists try another name."
        else
            mkdir ./Databases/"$name"
            echo "congratulations, Your Database Added successfully 😀"
            break
    fi  
done

echo "==========================================================="
echo "please select your next action:"

select choice in "Add Another Database" "Back To Main Menu" "Exit The Application" 
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