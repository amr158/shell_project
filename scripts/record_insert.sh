#!/bin/bash

# get next free primary key value for auto increment
function get_next_free_primary {
	typeset -i tmp=1
	free_primary=0
	# loop untill getting next free primary key
	while [ $free_primary -eq 0 ]
	do
		# check if value already exist in table
		if [[ " ${busy_primary[*]} " != *"$tmp"* ]]; then
			free_primary=$tmp
		fi
		let tmp=$tmp+1
	done
}

table_dir=$1
table_name=$2
typeset -i free_primary=0
# get column names and datatybes
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
col_types=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==1)print $i;}' $table_dir))
# get all primary values in table
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
# get columns count
typeset -i col_num=${#col_names[@]}
let col_num=$col_num-1
row="empty"

# loop untill get all values to insert
while [ $row = "empty" ]
do
	# ask for enter primary key or use auto assign
	echo ""
	echo "'${col_names[0]}' value"
	echo "do you want to use auto assign ? ( y to use / any other key to continue without )"
 	read answer
	echo ""
	# use auto assign
	if [ "$answer" == "y" ] ;then
		get_next_free_primary
		row=$free_primary
		echo "${col_names[0]} value is $free_primary"
	# get primary key value from user
	else
		echo "enter ${col_names[0]} value : (positive integer)"
		read answer
		# check if primary key value is valid
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo ""
			echo "sorry Not an positive integer";
		# check if primary key value already exist in table		
		elif [[ " ${busy_primary[*]} " == *"$answer"* ]]; then
			echo ""
			echo "already exist";
		else
			row=$answer
		fi
	fi
done

# loop to get other columns values
for i in $(seq 1 $col_num); 
do
	tmp=$row
	# loop untill get current column value
	while [ "$row" == "$tmp" ];
	do
		echo ""
		echo "enter '${col_names[$i]}' value : (${col_types[$i]})"
		read answer
		# check if the value is matched to the datatybe
		if [ ${col_types[$i]} = "number" ]; then
			re='^[0-9]+([.][0-9]+)?$'
			if ! [[ $answer =~ $re ]] ; then
				echo ""
				echo "sorry Not a number";	
			else
				row=$row:$answer
			fi
		elif [ ${col_types[$i]} = "string" ]; then
			if [[ $answer =~ [':'] ]]; then
				echo ""
			    echo "your value cannot contains ':'"
			else
			    row=$row:$answer
			fi
		fi
	done
done
# insert the new record
echo $row >> $table_dir
echo ""
echo "inserted successfully"
echo ""
# view the table after insert
scripts/table_view.sh $table_dir $table_name