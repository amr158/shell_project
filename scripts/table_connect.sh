#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
DB_dir=$1
echo "enter table name : "
read table_name
. scripts/table_Exist.sh $table_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo "$table_name does not exist"
        elif [ $exist = "true" ]
        then
                echo "you are in $table_dir"
                select choice in "select" "insert" "update" "delete" "Exit"
                do
                        case $choice in
                                "select") 
                                        
                                        ;;
                                "insert") 
                                        scripts/record_insert.sh $table_dir
                                        ;;
                                "update") 
                                        scripts/record_update.sh $table_dir
                                        ;;
                                "delete") 
                                        
                                        ;;
                                "Exit")
                                        break ;;
                                *) echo $choice is not a valid choice
                                        ;;
                        esac
                done
        fi
fi