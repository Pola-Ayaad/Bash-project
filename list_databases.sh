#!/bin/bash

clear
if ! [ -d ./Databases ]
    then
         mkdir ./Databases
fi

databases_count=`ls ./Databases | wc -l`
if [ "$databases_count" = 0 ]
    then
        echo "No Databases Found."
    else
        ls ./Databases
fi

echo "==========================================================="
echo "please select your next action:"
select choice in "Back To Main Menu" "Exit" 
do
   case $REPLY in
    1). ./main.sh
       ;;
    2) exit
       ;;
    *) echo "Wrong choice, Please enter a valid option"
       ;;
    esac
done