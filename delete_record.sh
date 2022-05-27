#!/bin/bash
clear
echo "Delete From Table:"
echo "----------------- "

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
then
     mkdir ./Databases
fi

cat ./Databases/"$dbname"/"$table_name"

check=`cat ./Databases/"$dbname"/"$table_name"| wc -l`


Records=`awk -F: 'END {print NR}' ./Databases/"$dbname"/"$table_name"`
counter=3

#check if this table contain data or not
if [ $Records == 2 ]
then
    echo "There are no Data Recorded in this table"
else
   #getting the value of the primary key of the record that the user want to delete 
   while true
   do
     echo "please Enter the primary key of the record you want to delete"
     read PK
      if [[ ! "$PK" =~  ^[1-9][0-9]*$ ]]
      then
        echo "please enter valid number"
      else
        break
      fi
   done

   #looping till find that number of that primary key and delete this record
   while [ $counter -le $Records ]
   do
     if  [ $PK -eq `awk -F: 'FNR == '$counter' {print $1}' ./Databases/"$dbname"/"$table_name"` ]
     then
        sed --in-place "/$PK/d" ./Databases/"$dbname"/"$table_name"
        break
     fi
        ((counter=counter+1)) 
   done

   #check if this primary key exist or not
   clear
   check2=`cat ./Databases/"$dbname"/"$table_name"| wc -l`
   if [ $check -gt $check2 ]
   then
    echo "Your Record has been deleted successfully"
   else
    echo "This record doesn't exist"
   fi
fi


if [ ! $Records == 2 ]
then
 #printing the table after the deleting operation
  echo "Your Table After Your this operaion become as following"
  cat ./Databases/"$dbname"/"$table_name"

  
  echo "please select your next action from the following actions"
  

select choice in "Delete another Record" "Add New Record" "Update Into Table" "Back" "Back To Main Menu" "Exit the Application"
    do
       case $REPLY in
        1). ./delete_record.sh
          ;;
        2). ./insert_into_table.sh
          ;;
        3) . ./update_table.sh
         ;;
        4). ./display_table.sh yes
          ;;
        5). ./main.sh
          ;;
        6) exit
          ;;
        *) echo "Wrong choice, Please enter a valid option"
          ;;
       esac
    done

else
 echo "please select your next action from the following actions"
    
    select choice in "Add New Record" "Back" "Back To Main Menu" "Exit the Application"
    do
       case $REPLY in
        1). ./insert_into_table.sh
          ;;
        2). ./display_table.sh yes
          ;;
        3). ./main.sh
          ;;
        4) exit
          ;;
        *) echo "Wrong choice, Please enter a valid option"
          ;;
       esac
    done
fi
