#!/bin/bash
echo "enter database name : "
read DB_name
. scripts/DB_Exist.sh $DB_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo $DB_name does not exist
        elif [ $exist = "true" ]
        then
				echo "you are in $DB_dir"
				select choice in "Create Table" "List Tables" "Connect to Table" "Drop Table" "Exit"
				do
					case $choice in
						"Create Table") 
							. scripts/table_create.sh
							;;
						"List Tables") 
							. scripts/table_list.sh
							;;
						"Connect to Table") 
							. scripts/table_connect.sh
							;;
						"Drop Table") 
							. scripts/table_drop.sh
							;;
						"Exit")
							break ;;
						*) echo $choice is not a valid choice
							;;
					esac
				done
		fi
fi