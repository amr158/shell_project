#!/bin/bash
shopt -s extglob
export LC_COLLATE=C


function get_col {
	while [ "$tmp" == "$record_num" ]
	do
		echo ""
		echo "enter the ${col_names[0]} of the record you want to edit :"
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
				edit_col=${tmp[*]}
			fi
		fi
	done
}

function update {
	tmp=$edit_col
	while [ "$tmp" == "$edit_col" ]
	do
		echo ""
		echo "choose column to edit :"
		echo ${col_names[*]}
		echo ""
		read answer
		case $answer in
		+([A-Za-z0-9_]) )
			if [[ ! " ${col_names[*]} " =~ " ${answer} " ]]; then
				echo ""
				echo "$answer does not exist"
				echo ""
				continue ;
			elif [ "$answer" == "${col_names[0]}" ]; then
				echo ""
				echo "you cannot edit the primary key value of this record"
				echo ""
				continue ;
			else
				typeset -i index
				for i in "${!col_names[@]}"; do
					if [[ "${col_names[$i]}" = "${answer}" ]]; then
						index=$i
					fi
				done
				echo ""
				echo "enter '${col_names[$index]}' : (${col_types[$index]})"
				read answer
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
		let index=$index+1
		awk -i inplace -v ans="$answer" -v ind="$index" -v r="$record_num"  -F: '{if(NR==r) $ind = ans; print $0;}' OFS=: $table_dir
		tm=($(awk -v r="$record_num" -F: '{if(NR==r)print $0;}' $table_dir))
		edit_col=${tm[*]}
		echo ""
		echo "record updated successfully"
		echo ""
	done
}

table_dir=$*
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
col_types=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==1)print $i;}' $table_dir))
busy_primary=($(awk -F: '{if(NR!=1&&NR!=2)print $1;}' $table_dir))
typeset -i col_num=${#col_names[@]}
let col_num=$col_num-1
typeset -i record_num=0
tmp=$record_num
row="empty"
edit_col="c"

echo ""
tail -n+2 $table_dir
get_col

update