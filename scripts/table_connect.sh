#!/bin/bash
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
                cat $table_dir
        fi
fi