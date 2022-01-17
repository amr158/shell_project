#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

# get reocord for delte
function get_record {
	# loop until getting record from user
	while [ "$tmp" == "$record_num" ]
	do
		echo ""
		echo "enter the $primary_name of the record you want to delete :"
		echo ""
		read answer
		# check if the user entered valid value as primary key
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo "Not an positive integer";	
		else
			# check if the entered value exist in table
			if [[ " ${busy_primary[*]} " != *"$answer"* ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
			else
				# get the record number and value to delete
				record_num=($(awk -v ans="$answer" -F: '{if($1==ans)print NR;}' $table_dir))
				tmp=($(awk -v ans="$answer" -F: '{if($1==ans)print $0;}' $table_dir))
				delete_record=${tmp[*]}
			fi
		fi
	done
}

table_dir=$1
table_name=$2
#check if the table is empty
tmp=($(awk -F: 'END {print NR;}' $table_dir))
if [ $tmp -eq 2 ]; then
	echo ""
	echo "no records to delete "
	echo ""
else
	# get primary key name
	primary_name=($(awk -F: '{if(NR==2)print $1;}' $table_dir))
	# get all primary key values in the table
	busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
	typeset -i record_num=0
	tmp=$record_num
	delete_record="c"

	# view the table before delete record
	scripts/table_view.sh $table_dir $table_name
	# get reocord for delte
	get_record
	# delte record
	echo ""
	echo "$delete_record deleted successfully"
	echo ""
	sed -i " /$delete_record/d  " $table_dir

	# view the table after delete record
	scripts/table_view.sh $table_dir $table_name
fi