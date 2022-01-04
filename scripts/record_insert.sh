#!/bin/bash

function get_next_free_primary {
	typeset -i tmp=1
	free_primary=0
	while [ $free_primary -eq 0 ]
	do
		if [[ " ${busy_primary[*]} " =~ " ${tmp} " ]]; then
			free_primary=$tmp
		fi
		let tmp=$tmp+1
	done
}

table_dir=$1
typeset -i free_primary=0
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
col_types=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==1)print $i;}' $table_dir))
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
typeset -i col_num=${#col_names[@]}
let col_num=$col_num-1
row="empty"


while [ $row = "empty" ]
do
	echo ""
	echo "'${col_names[0]}' value"
	echo "do you want to use auto assign ? ( y to use / any other key to continue without )"
 	read answer
	if [ $answer = "y" ] ;then
		get_next_free_primary
		row=$free_primary
		echo "${col_names[0]} value is $free_primary"
	else
		echo "enter ${col_names[0]} value : (positive integer)"
		read answer
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo "sorry Not an positive integer";	
		else
			row=$answer
		fi
	fi
done

for i in $(seq 1 $col_num); 
do
	tmp=$row
	while [ "$row" == "$tmp" ];
	do
		echo ""
		echo "enter '${col_names[$i]}' value : (${col_types[$i]})"
		read answer
		if [ ${col_types[$i]} = "number" ]; then
			re='^[0-9]+([.][0-9]+)?$'
			if ! [[ $answer =~ $re ]] ; then
				echo "sorry Not a number";	
			else
				row=$row:$answer
			fi
		elif [ ${col_types[$i]} = "string" ]; then
			if [[ $answer =~ [':'] ]]; then
			    echo "your value cannot contains ':'"
			else
			    row=$row:$answer
			fi
		fi
	done
done
echo $row >> $table_dir
echo "inserted successfully"