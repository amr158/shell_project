#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

# get record for update
function get_record {
	# loop untill get record number
	while [ "$tmp" == "$record_num" ]
	do
		# ask for primary key value
		echo ""
		echo "enter the ${col_names[0]} of the record you want to edit :"
		echo ""
		read answer
		# check if the value is valid
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo "Not an positive integer";
		# check if the value already exist	
		else
			if [[ " ${busy_primary[*]} " != *"$answer"* ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
			else
			# get the record number and value to update
				record_num=($(awk -v ans="$answer" -F: '{if($1==ans)print NR;}' $table_dir))
				tmp=($(awk -v ans="$answer" -F: '{if($1==ans)print $0;}' $table_dir))
				edit_record=${tmp[*]}
			fi
		fi
	done
}

function update {
	tmp=$edit_record
	# loop untill update the record
	while [ "$tmp" == "$edit_record" ]
	do
		# ask for column name to update
		echo ""
		echo "choose column to edit :"
		echo ${col_names[*]}
		echo ""
		read answer
		# check if the column name is valid
		case $answer in
		+([A-Za-z0-9_]) )
			if [[ ! " ${col_names[*]} " =~ " ${answer} " ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
				continue ;
			# check if the column name exist in the table
			elif [ "$answer" == "${col_names[0]}" ]; then
				echo ""
				echo "you cannot edit the primary key value of this record"
				echo ""
				continue ;
			else
				# get index of the column name
				typeset -i index
				for i in "${!col_names[@]}"; do
					if [[ "${col_names[$i]}" = "${answer}" ]]; then
						index=$i
					fi
				done
				# ask for new value
				echo ""
				echo "enter '${col_names[$index]}' : (${col_types[$index]})"
				read answer
				# check if the entered value is matched with the datatybe of the column
				if [ ${col_types[$index]} = "number" ]; then
					re='^[0-9]+([.][0-9]+)?$'
					if ! [[ $answer =~ $re ]] ; then
                        echo ""
						echo "sorry Not a number";	
						continue ;
					fi
				elif [ ${col_types[$index]} = "string" ]; then
					if [[ $answer =~ [':'] ]]; then
					    echo ""
                        echo "your value cannot contains ':'"
						continue ;
					fi
				fi
			fi
			;;
		*)
			echo "column name can only contains small or capital letter or _"
			continue ;
			;;
		esac
		# update the new value in the choosed filed in the choosed record
		let index=$index+1
		awk -i inplace -v ans="$answer" -v ind="$index" -v r="$record_num"  -F: '{if(NR==r) $ind = ans; print $0;}' OFS=: $table_dir
		tm=($(awk -v r="$record_num" -F: '{if(NR==r)print $0;}' $table_dir))
		edit_record=${tm[*]}
		# check if the value is updated or it is the same value
		if [ "$tmp" == "$edit_record" ]; then
			echo ""
			echo "nothing to update"
			echo ""
		else
			echo ""
			echo "record updated successfully"
			echo ""
		fi
	done
}

table_dir=$1
table_name=$2
#check if the table is empty
tmp=($(awk -F: 'END {print NR;}' $table_dir))
if [ $tmp -eq 2 ]; then
	echo ""
	echo "no records to update "
	echo ""
else
	# get columns names
	col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
	# get columns datatybes
	col_types=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==1)print $i;}' $table_dir))
	# get primary key values in the table
	busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
	typeset -i record_num=0
	tmp=$record_num
	edit_record="c"
	# view table before update
	scripts/table_view.sh $table_dir $table_name
	# get record to update
	get_record
	# update the record
	update
	# view table after update
	scripts/table_view.sh $table_dir $table_name
fi