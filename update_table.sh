#!/bin/bash
clear
echo "Update Table:"
echo "-------------"

#If user doesn't have directory for databases, create it
if ! [ -d ./Databases ]
then
     mkdir ./Databases
fi

table_rows=`cat ./Databases/$dbname/$table_name | wc -l`
  

if [ $table_rows == 2 ]
then
    echo "There are no Rows in this table."
else
    #Table has rows in it
    echo "Table: $table_name"
    echo "==========================="
    cat ./Databases/$dbname/$table_name
    echo "==================================================="
    #Ask user to enter value for pk to be modified and validate it
    while true
    do
        read -p "Enter the value of primary key of the row you want to modify: " pk_val
        row_pointer=3
        exist=0
        #check if primary key exist
        if [[ $pk_val =~  ^[1-9][0-9]*$ ]]
        then
            while [ $row_pointer -le $table_rows ]
            do
                if  [ $pk_val -eq `awk -F: 'FNR == '$row_pointer' {print $1}' ./Databases/$dbname/$table_name` ]
                then
                    exist=1
                    break
                fi
                ((row_pointer=row_pointer+1)) 
            done
        fi

        if [[ ! "$pk_val" =~  ^[1-9][0-9]*$ ]]
        then
           echo "please enter valid number "
        elif [ $exist == 0 ]
        then
            echo "this primary key not exist " 
        else
            break
        fi
    done

    #list all columns to choose
    echo "Available data of the enterd primary key in columns are"
    typeset -i ci=2
    for col in `awk -F: '{i=2; while(i<=NF){if(NR=='$row_pointer'){print $i};i++}}' ./Databases/$dbname/$table_name`
    do
        echo $ci")" $col
        arr[ci]=$ci
        ci=ci+1
    done

    while true
    do
        echo  "Choose the number of Column that corrosponding to the field value you want to Update "
        read option

        #check option exist in array
        found=0
        for var in `echo ${arr[@]}`
        do
            if [ "$var" == "$option" ]
            then
                found=1  
            fi
        done

        if [[ ! $option =~  ^[1-9][0-9]*$  ]]
        then
                echo "please enter valid number "
        elif [ $found == 0 ]
        then
            echo "This Option doesnot Exist . try again "
        else
            break  
        fi
    done

   #get type of option selected 
    type_select=`awk -F: -v i=$option '{if(NR==1){print $i}}' ./Databases/$dbname/$table_name`
    echo "type:"$type_select         
 
    while true
    do  
        echo "enter new value"
        read new

        if [[ $type_select == "string" ]]
        then
        
            if [[ ! "$new" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
            then
                echo Error in Naming Format it should be string 
                echo Must start with letter 
                echo Contain no spaces 
                echo Only AlphaNumeric is Allowed
            else
                    break
            fi  
        elif [[ $type_select == "integer" ]]  
        then
    
            if [[ ! $new =~  ^[1-9][0-9]*$  ]]
            then
                    echo "please enter valid number "
            else
                    break
            fi 
        else
        echo "type not exist !!! "        
        fi   
    done
    awk -F : -i inplace -v OFS=: -v ident="$pk_val" -v insert="$new" -v op="$option" '($1==ident){$op=insert} 1' ./Databases/$dbname/$table_name
    echo "congratulations, Your Have Updated Record Successfully "

    echo "new data after update"
    cat ./Databases/$dbname/$table_name
       
fi

#check which Action the user need after completing his current operation
echo "==========================================================="
echo "Please select your next action: "

if [ ! $table_rows == 2 ]
then
    select choice in "Update Another Record" "Insert Into Table" "Delete From Table" "Back" "Back To Main Menu" "Exit the Application" 
    do
        case $REPLY in
            1) . ./update_table.sh 
            ;;
            2) . ./insert_into_table.sh
            ;;
            3) . ./delete_record.sh
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
