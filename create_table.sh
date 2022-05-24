#!/bin/bash
clear
if ! [ -d ./Databases ]
then
    mkdir ./Databases
fi

while true
do
    while true
    do
        read -p "Enter name of the table you want to create: " table_name
        export table_name

        #Validate table name (Must start with a letter or _ and doesn't contain special characters)
        if [[ $table_name == +([A-Za-z_])* ]] && [[ ! $table_name =~ ['!@#$%^&*()+'] ]]
        then
            break
        else
            echo "invalid name."
        fi
    done

    #check for table existence
    if [ -f ./Databases/$dbname/"$table_name" ]
    then
        echo "Unfortunately, this name already exists try another name."
    else
        #collect info about table
        col_counter=1
        col_separator=":"

        #Determine number of columns in the table
        while true
        do
            read -p "Enter number of columns: " col_num
            export col_num
            if [[ ! "$col_num" =~  ^[1-9][0-9]*$ ]]
            then
                echo "Enter a valid number of columns"
            else
                break
            fi
        done

        #Determine primary key column
        while true
        do
            read -p "Please enter name of primary key: " pk
            #Validate pk name
            if [[ $pk == +([A-Za-z])* ]] && [[ ! $pk =~ ['!@#$%^&*()+_'] ]]
            then
                break
            else
                echo "invalid name."
            fi
        done
        
        #initialize metadata
        datatype_metadata="integer"
        name_metadata=$pk

        #Determine other columns in table
        while [ $col_counter -lt $col_num ]
        do
            #Validate column name
            while true
            do
                read -p "Enter name of column $(( $col_counter+1 )): " col_name
                if [[ $col_name == +([A-Za-z])* ]] && [[ ! $col_name =~ ['!@#$%^&*()+_'] ]]
                then
                    break
                else
                    echo "invalid name."
                fi
            done

            #check column existence
            found=0
            for col in `echo ${columns[@]} $pk`
            do
                if [ $col == $col_name ]
                    then
                        found=1
                        break
                fi
            done
            if [ $found == 1 ]
                then
                    echo "Column name already exist"
                    continue
            fi
            columns[$col_counter]=$col_name
            
            #Determine column data type
            echo "Now, please specify column data type: "
            while true
            do
                echo "1- integer"
                echo "2- string"
                read -p "Choice: " choice
                case $choice in
                    1) 
                    col_type="integer"
                    break
                    ;;
                    2)
                    col_type="string"
                    break
                    ;;
                    *)
                    echo "Invalid choice"
                    ;;
                esac
            done
            datatype_metadata=$datatype_metadata$col_separator$col_type
            name_metadata=$name_metadata$col_separator$col_name
            ((col_counter=col_counter+1))
        done
        touch ./Databases/$dbname/$table_name
        echo $datatype_metadata >> ./Databases/$dbname/$table_name
        echo $name_metadata >> ./Databases/$dbname/$table_name
        clear
        echo "Table created successfully"
        unset columns
        break
    fi
done
echo "==========================================================="
echo "please select your next action:"

select choice in "Add another Table" "Back To Main Menu" "Exit"
do
    case $REPLY in
        1). ./create_table.sh
        ;;
        2). ./main.sh
        ;;
        3) exit
        ;;
        *) echo "Wrong choice, Please enter a valid option"
        ;;
    esac
done