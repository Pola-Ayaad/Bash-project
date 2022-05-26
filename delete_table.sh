#!/bin/bash

clear

table_name=`ls ./Databases/$dbname | wc -l`
if [ "$table_name" = 0 ]
then
    echo "No Tables Found."
else
    echo "Here's a list of tables: "
    ls ./Databases/$dbname

     while true
        do
            echo "Please Enter the name of the Table you would like to delete "
            read deltable
               if [[ ! "$deltable" =~  ^[[:alpha:]][[:alnum:]]*$  ]]
               then
                echo "Table name formating is wrong"
                

               elif [ -f ./Databases/$dbname/"$deltable" ]
               then
                   rm ./Databases/$dbname/"$deltable"
		   sleep 1
                   echo "Your Table has been deleted"
		   sleep 1
                   echo "Available Tables"
                     ls ./Databases/$dbname 
                   break
               else

                   echo "Table Name doesn't exit"
               fi
        done
    fi




echo "Please select from the Following"
if [ ! "$table_name" == 0 ]
then
     select choice in "Delete another Table" "Back" "Back To Main Menu" "Exit the Application" 
      do
          case $REPLY in
            1). ./delete_table.sh
                  ;;
            2). ./database_connect.sh 
                  ;;
            3). ./main.sh  
                  ;;
            4) exit
                  ;;
            *) echo "Invalid Selection"
                  ;;
          esac
      done
else
     select choice in "Back" "Back To Main Menu" "Exit the Application" 
      do
          case $REPLY in
            1). ./database_connet.sh 
                  ;;    
            2). ./main.sh  
                  ;;      
            3) exit
                  ;;
            *) echo "Invalid Selection "
                  ;;
          esac
      done
fi
            		   
