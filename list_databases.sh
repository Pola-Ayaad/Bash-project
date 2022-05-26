#!/bin/bash
clear
echo "List Databases:"
echo "---------------"

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
    then
         mkdir ./Databases
fi

#Check if user has databases to be listed or not.
databases_count=`ls ./Databases | wc -l`
if [ $databases_count == 0 ]
    then
        echo "No Databases Found."
    else
        ls ./Databases
fi

echo "==========================================================="
echo "Please select your next action: "
select choice in "Back to main menu" "Exit" 
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