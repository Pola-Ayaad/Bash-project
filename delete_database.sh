#!/bin/bash

clear

     if ! [ -d ./Databases ]
     then 
        mkdir ./Databases
     fi

DB=`ls ./Databases | wc -l`

     if [ "$DB" == 0 ]
     then 
	     echo "There are no Databases"
     else 
	     echo "Databases List: "
	     ls ./Databases

	     while true
	     do 
		     echo "Please Enter The Name of the Database you wish to delete"
		     read delname
		        if [[ ! "$delname" =~  ^[[:alpha:]][[:alnum:]]*$  ]]
			then
				echo "Database name formating is wrong"




			elif [ -d ./Databases/"$delname" ]
			then 
				rm -r ./Databases/"$delname"
				echo "Your Databases has been DELETED"
				break
			else
				echo "The Database name that you entered doesn't exit"
			fi
		done
	fi

echo "==========================================================="
echo "please select your next action:"

if [ ! "$DB" == 0 ]
	then
		select choice in "Delete another database" "Back To Main Menu" "Exit" 
			do
   				case $REPLY in
					1). ./delete_database.sh
					;;
					2). ./main.sh
					;;
					3) exit
					;;
					*) echo "Wrong choice, Please enter a valid option"
					;;
    			esac
			done
else
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
fi

