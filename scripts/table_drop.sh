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
                rm $table_dir
                echo "$table_name dropped successfully"
        fi
fi