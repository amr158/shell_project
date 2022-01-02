#!/bin/bash
echo "enter database name : "
read DB_name
. scripts/DB_Exist.sh $DB_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                mkdir $DB_dir
                echo $DB_name database created successfully
        elif [ $exist = "true" ]
        then
                echo database already exist
        fi
fi