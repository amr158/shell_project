#!/bin/bash
shopt -s extglob
export LC_COLLATE=C


function get_next_free_primary {
	typeset -i tmp=1
	free_primary=0
	while [ $free_primary -eq 0 ]
	do
		if [[ " ${busy_primary[*]} " != *"$tmp"* ]]; then
			free_primary=$tmp
		fi
		let tmp=$tmp+1
	done
}


typeset -i free_primary=0
table_dir="databases/mydb/mytable"
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==1)print $i;}' $table_dir))
col_types=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))

echo ${col_names[*]}
echo ${col_types[*]}
echo ${busy_primary[*]}
get_next_free_primary
echo $free_primary

read yournumber

re='^[1-9]+[0-9]+$'
if ! [[ $yournumber =~ $re ]] ; then
   echo "sorry Not a number" >&2;
fi

read str
if [[ $str =~ [':'] ]]; then
    echo no
else
    echo yes
fi





function get_column_name {
	echo "enter column num $((index+1)) name :"
	read name
	. scripts/naming_check.sh $name
	if [ $res = "valid" ] 
	then
		if [[ " ${cloumn_name[*]} " == *"$name"* ]]; then
			echo "you already entered this column name"
			res="notvalid"
		fi
	fi
}

function get_column_datatype {
	if [ $res = "notvalid" ]; then
		return
	fi
	echo "enter column num $((index+1)) datatype : (int/str)"
	read datatype
	if [ $datatype != "int" -a $datatype != "str" ]
	then
		echo $datatype is not a valid choice
		res="notvalid"
	fi
}

function add_column {
	if [ $res = "valid" ]; then
		cloumn_name[$index]=$name
		cloumn_type[$index]=$datatype
		index=$index+1
		if [ $first_row = "empty" ]; then
			first_row=$datatype
			second_row=$name
		else
			first_row=$first_row:$datatype
			second_row=$second_row:$name
		fi
	fi
}



# typeset -i index=0
# first_row="empty"
# second_row="empty"
# while [ $index -ne 1 ]
# do
# 	echo "(primary key)"
# 	datatype="int"
# 	get_column_name
# 	add_column
# done

# while [ $index -ne 2 ]
# do
# 	echo "you need to enter another column to create the table"
# 	get_column_name
# 	get_column_datatype
# 	add_column
# done

# echo "do you want to add more columns ? ( 'n' to exit / any other key to continue)"
# read ans
# while [ $ans != "n" ]
# do
# 	get_column_name
# 	get_column_datatype
# 	add_column
# 	echo "do you want to add more columns ? ( 'n' to exit / any other key to continue)"
# 	read ans
# done

# echo $first_row
# echo $second_row