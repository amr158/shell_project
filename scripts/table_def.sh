#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

function get_column_name {
	echo ""
	echo "enter column num $((index+1)) name :"
	echo ""
	read col_name
	echo ""
	. scripts/naming_check.sh $col_name
	if [ $res = "valid" ] 
	then
		if [[ " ${cloumn_names[*]} " =~ " ${col_name} " ]]; then
			echo ""
			echo "you already entered this column name"
			res="notvalid"
		fi
	fi
}

function get_column_datatype {
	if [ $res = "notvalid" ]; then
		return
	fi
	echo ""
	echo "enter column num $((index+1)) datatype : (number/string)"
	read datatype
	echo ""
	if [ $datatype != "number" -a $datatype != "string" ]
	then
		echo ""
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
echo ""
read ans
echo ""
while [ $ans != "n" ]
do
	get_column_name
	get_column_datatype
	add_column
	echo ""
	echo "do you want to add more columns ? ( 'n' to exit / any other key to continue)"
	read ans
done