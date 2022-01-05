#!/bin/bash
shopt -s extglob
export LC_COLLATE=C


function get_record {
	while [ "$tmp" == "$record_num" ]
	do
		echo ""
		echo "enter the $primary_name of the record you want to delete :"
		echo ""
		read answer
		re='^[1-9]+[0-9]*$'
		if ! [[ $answer =~ $re ]] ; then
			echo "Not an positive integer";	
		else
			if [[ " ${busy_primary[*]} " != *"$answer"* ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
			else
				record_num=($(awk -v ans="$answer" -F: '{if($1==ans)print NR;}' $table_dir))
				tmp=($(awk -v ans="$answer" -F: '{if($1==ans)print $0;}' $table_dir))
				delete_record=${tmp[*]}
			fi
		fi
	done
}

table_dir=$*
primary_name=($(awk -F: '{if(NR==2)print $1;}' $table_dir))
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
typeset -i record_num=0
tmp=$record_num
delete_record="c"

echo ""
tail -n+2 $table_dir
get_record

echo ""
echo "$delete_record deleted successfully"
echo ""
sed -i " /$delete_record/d  " $table_dir