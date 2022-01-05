#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
DB_dir=$1
echo ""
echo "enter table name : "
echo ""
read table_name
echo ""
. scripts/table_Exist.sh $table_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo ""
                echo "$table_name does not exist"
        elif [ $exist = "true" ]
        then
                PS3=">($table_name table minu) select one of the above : "
                select choice in "select" "insert" "update" "delete" "Exit"
                do
                        case $choice in
                                "select") 
                                        scripts/record_select.sh $table_dir
                                        ;;
                                "insert") 
                                        scripts/record_insert.sh $table_dir
                                        ;;
                                "update") 
                                        scripts/record_update.sh $table_dir
                                        ;;
                                "delete") 
                                        scripts/record_delete.sh $table_dir
                                        ;;
                                "Exit")
                                        break ;;
                                *) echo $choice is not a valid choice
                                        ;;
                        esac
                done
        fi
fi