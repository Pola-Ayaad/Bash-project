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
            DBname = $DBname
          else
            echo "Please Enter the Database Name "
            read DBname
          fi  
               
               if [[ ! "$DBname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                echo "Database Formating is Wrong" 
                 
                 
                

                
               elif [ ! -d ./Databases/"$DBname" ]
               then
                   echo "This Database doesn't exit"
               
               else
                     clear
                     echo "Welcome to" $DBname
                     break

                fi
        done
    fi
