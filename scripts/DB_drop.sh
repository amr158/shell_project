#!/bin/bash
echo ""
echo "enter database name : "
echo ""
read DB_name
. scripts/DB_Exist.sh $DB_name
if [ $res = "valid" ] 
then
    if [ $exist = "false" ]
    then
            echo ""
            echo $DB_name does not exist
    elif [ $exist = "true" ]
    then
            rm -r $DB_dir
            echo ""
            echo $DB_name dropped successfully
    fi
fi