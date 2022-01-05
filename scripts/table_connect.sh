#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
DB_dir=$1
echo ""
echo "enter table name : "
echo ""
read table_name
echo ""
# check if the table exist
. scripts/table_Exist.sh $table_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo ""
                echo "$table_name does not exist"
                echo ""
        elif [ $exist = "true" ]
        then
                PS3=">($table_name table minu) select one of the above : "
                # view the table
                scripts/table_view.sh $table_dir $table_name
                select choice in "select" "insert" "update" "delete" "Exit"
                do
                        case $choice in
                                "select") 
                                        scripts/record_select.sh $table_dir $table_name
                                        ;;
                                "insert") 
                                        scripts/record_insert.sh $table_dir $table_name
                                        ;;
                                "update") 
                                        scripts/record_update.sh $table_dir $table_name
                                        ;;
                                "delete") 
                                        scripts/record_delete.sh $table_dir $table_name
                                        ;;
                                "Exit")
                                        PS3=">($2 DB minu) select one of the above : "
                                        break ;;
                                *) echo $choice is not a valid choice
                                        ;;
                        esac
                done
        fi
fi