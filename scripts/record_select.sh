#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

# get the record for view
function get_record {
	# loop untill get the primary key value of the record to view
	while [ "$tmp" == "$record_num" ]
	do
		echo ""
		echo "enter the $primary_name of the record you want to select :"
		echo ""
		read answer
		# check if the value is valid as positive integer
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo "Not an positive integer";	
		else
			#check if the value exist or not
			if [[ " ${busy_primary[*]} " != *"$answer"* ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
			else
				# get record number to view
				record_num=($(awk -v ans="$answer" -F: '{if($1==ans)print NR;}' $table_dir))
			fi
		fi
	done
}

table_dir=$1
table_name=$2
# get primary key column name
primary_name=($(awk -F: '{if(NR==2)print $1;}' $table_dir))
# get primary key values in the table
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
typeset -i record_num=0
tmp=$record_num
# get the record for view
get_record
# get columns names
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
echo ""
# view record
for i in "${!col_names[@]}"; 
do
	let ind=i+1
	tmp=($(awk -v r="$record_num" -v ind="$ind" -F: '{if(NR==r)print $ind;}' $table_dir))
	echo "${col_names[$i]} : ${tmp[*]}"
done
echo ""