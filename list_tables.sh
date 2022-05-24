#!/bin/bash
clear

if ! [ -d ./Databases ]
then
     mkdir ./Databases
fi
tables_count=`ls ./Databases/$dbname | wc -l`
if [ "$tables_count" = 0 ]
then
    echo "No Tables Found."
else
    echo "Here's a list of tables: "
    ls ./Databases/$dbname
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