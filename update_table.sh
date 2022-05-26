#!/bin/bash


clear

tb=`cat ./Databases/$dbname/$table_name | wc -l`
  

if [ "$tb" == 2 ]
then
        echo "There are no Rows in this table "

else
    echo "Table: ""$table_name"
    cat ./Databases/$dbname/$table_name


    while true
    do
       echo  "Enter the value of primary key of the row you want to modify"
        read val_prim
        counter=3
        chk=0
     #check if primary key exist
     if [[ "$val_prim" =~  ^[1-9][0-9]*$ ]]
     then
        while [ $counter -le $tb ]
        do
            if  [ $val_prim -eq `awk -F: 'FNR == '$counter' {print $1}' ./Databases/$dbname/$table_name` ]
            then
            chk=1
           break
            fi
            ((counter=counter+1)) 
        done
     fi
record_num=$counter

       if [[ ! "$val_prim" =~  ^[1-9][0-9]*$ ]]
       then
           echo "please enter valid number "
        elif [ $chk == 0 ]
        then
            echo "this primary key not exist " 
        else
            break
        fi
 done

#list all columns to choose
echo "Available data of the enterd primary key in columns are"
    typeset -i ci=2
    for col in `awk -F: '{i=2; while(i<=NF){if(NR=='$counter'){print $i};i++}}' ./Databases/$dbname/$table_name`
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

        if [[ $type_select == "String" ]]
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
        elif [[ $type_select == "Integer" ]]  
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
        awk -F : -i inplace -v OFS=: -v ident="$val_prim" -v insert="$new" -v op="$option" '($1==ident){$op=insert} 1' ./Databases/$dbname/$table_name
        echo "congratulations, Your Have Updated Record Successfully "

        echo "new data after update"
        cat ./Databases/$dbname/$table_name
       
fi

#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"

if [ ! $tb == 2 ]
then
    select choice in "Update Another Record" "Insert Into Table" "Delete From Table" "Back" "Back To Main Menu" "Exit the Application" 
    do
    case $REPLY in
        1) . ./update_record.sh 
        ;;
        2) . ./insert_into_table.sh
        ;;
        3) . ./delete_record.sh
        ;;
        4). ./list_tables.sh yes
          ;;  
        5). ./main.sh
        ;;
        6) exit
        ;;
        *) echo "Invalid Selection !"
        ;;
        esac
    done 
else
    select choice in "Add New Record" "Back" "Back To Main Menu" "Exit the Application" 
    do
       case $REPLY in
        1). ./insert_into_table.sh
          ;;
        2). ./list_tables.sh yes
          ;;  
        3). ./main.sh
          ;;
        4) exit
          ;;
        *) echo "Invalid Selection!"
          ;;
       esac
    done
fi      
