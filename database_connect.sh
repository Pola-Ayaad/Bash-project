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
	echo "Would you like to create a New Database? (Y or N)"
	read input 
	if [ $input == "Y" ]
	then
		./create_database.sh
	else
		echo " Program will close"
		sleep 3
		echo " Good Bye !"
		exit 0
       fi

    else
        echo "Databases list: "
        ls ./Databases 
        
        while true
        do
          if [ "$1" == "yes" ]
          then
            dbname = $dbname
          else
            echo "Please Enter the Database Name "
            read dbname
          fi  
               
               if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                echo "Database Formating is Wrong" 
                 
                 
                

                
               elif [ ! -d ./Databases/"$dbname" ]
               then
                   echo "This Database doesn't exit"
               
               else
                     clear
                     echo "Welcome to" $dbname
                     break

                fi
        done
    fi



echo "Please Choose from the following"

if [ ! "$db" == 0 ]
then
    select choice in "Create New Table" "Delete Specific Table" "List All Available Database Tables" "Back To Choose Another DB" "Back To Main Menu" "Exit the Application"

    do
	    case $REPLY in
       1) . ./create_table.sh
            ;;
       2) echo "./DeleteTable"
            ;;
       3) . ./list_tables.sh
            ;;
       4) . ./database_connect.sh no
   	     ;;
       5) . ./main.sh
            ;;
       6)    exit
            ;;
       *)  echo "Invalid Selection, Please Try again"
            ;;
       esac
    done
else
      select choice in "Back To Main Menu" "Exit the Application"
      do
          case $REPLY in
            1). ./main.sh
                  ;;
            2) exit
                  ;;
            *) echo "Invalid Selection Please Try again"
                  ;;
          esac
      done
fi

