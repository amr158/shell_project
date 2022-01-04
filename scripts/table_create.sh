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
                . scripts/table_def.sh
                touch $table_dir
                echo $first_row >> $table_dir
                echo $second_row >> $table_dir
                echo $table_name table created successfully
        elif [ $exist = "true" ]
        then
                echo $table_name table already exist
        fi
fi