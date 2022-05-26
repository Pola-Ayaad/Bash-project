#!/bin/bash
clear
echo "List Tables:"
echo "------------"

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
then
     mkdir ./Databases
fi

tables_count=`ls ./Databases/$dbname | wc -l`
if [ $tables_count == 0 ]
then
    echo "No Tables Found."
else
    ls ./Databases/$dbname
fi

echo "==========================================================="
echo "Please select your next action: "
select choice in "Back" "Back to main menu" "Exit" 
do
   case $REPLY in
      1). ./database_connect.sh yes
      ;;
      2). ./main.sh
      ;;
      3) exit
      ;;
      *) echo "Wrong choice, Please enter a valid option"
      ;;
    esac
done