#!/bin/bash

function get_column_name {
	echo "enter column num $((index+1)) name :"
	read col_name
	. scripts/naming_check.sh $col_name
	if [ $res = "valid" ] 
	then
		if [[ " ${cloumn_names[*]} " == *"$col_name"* ]]; then
			echo "you already entered this column name"
			res="notvalid"
		fi
	fi
}

function get_column_datatype {
	if [ $res = "notvalid" ]; then
		return
	fi
	echo "enter column num $((index+1)) datatype : (number/string)"
	read datatype
	if [ $datatype != "number" -a $datatype != "string" ]
	then
		echo $datatype is not a valid choice
		res="notvalid"
	fi
}

function add_column {
	if [ $res = "valid" ]; then
		cloumn_names[$index]=$col_name
		cloumn_type[$index]=$datatype
		index=$index+1
		if [ $first_row = "empty" ]; then
			first_row=$datatype
			second_row=$col_name
		else
			first_row=$first_row:$datatype
			second_row=$second_row:$col_name
		fi
	fi
}


typeset -i index=0
first_row="empty"
second_row="empty"
while [ $index -ne 1 ]
do
	echo "(primary key)"
	datatype="number"
	get_column_name
	add_column
done

while [ $index -ne 2 ]
do
	echo "you need to enter another column to create the table"
	get_column_name
	get_column_datatype
	add_column
done

echo "do you want to add more columns ? ( 'n' to exit / any other key to continue)"
read ans
while [ $ans != "n" ]
do
	get_column_name
	get_column_datatype
	add_column
	echo "do you want to add more columns ? ( 'n' to exit / any other key to continue)"
	read ans
done