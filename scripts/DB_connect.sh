#!/bin/bash
echo ""
echo "enter database name : "
echo ""
read DB_name
echo ""
# check if the DB
. scripts/DB_Exist.sh $DB_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo ""
				echo $DB_name does not exist
				echo ""
        elif [ $exist = "true" ]
        then
			PS3=">($DB_name DB minu) select one of the above : "
			select choice in "Create Table" "List Tables" "Connect to Table" "Drop Table" "Exit"
			do
				case $choice in
					"Create Table") 
						scripts/table_create.sh $DB_dir
						;;
					"List Tables") 
						scripts/table_list.sh $DB_dir $DB_name
						;;
					"Connect to Table") 
						scripts/table_connect.sh $DB_dir $DB_name
						;;
					"Drop Table") 
						scripts/table_drop.sh $DB_dir
						;;
					"Exit")
						PS3=">(Main minu)select one of the above : "
						break ;;
					*) 
						echo ""
						echo $choice is not a valid choice
						;;
				esac
			done
		fi
fi