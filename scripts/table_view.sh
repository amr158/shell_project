#!/bin/bash
shopt -s extglob
export LC_COLLATE=C


table_dir=$1
table_name=$2
col_names=($(awk -F: '{for(i=1;i<=NF;i++)if(NR==2)print $i;}' $table_dir))
let record_length=0
for i in "${!col_names[@]}"; do
    let index=$i+1
    tmp=($(awk -v ind="$index" -F: ' BEGIN{max=0} {if(length($ind)>max)max=length($ind);} END{print max;}' $table_dir))
    col_length[$i]=${tmp[*]}
    let col_length[$i]=${col_length[$i]}+1
    let record_length=$record_length+${col_length[$i]}
done
record_count=($(awk -F: 'END{print NR}' $table_dir))
echo ""
echo "+----------------------- $table_name -----------------------+"
tmp_record="+"
for i in "${!col_length[@]}"; do
    tmp_record=$tmp_record"-"
    for j in $(seq 1 ${col_length[$i]});do
    tmp_record=$tmp_record"-"
    done
    tmp_record=$tmp_record"+"
done

echo ""
echo $tmp_record
for i in $(seq 2 $record_count);do
    line=""
    for j in "${!col_length[@]}";do
        line=$line"| "
        let index=$j+1
        tmp_1=($(awk -v ind="$index" -v r="$i" -F: '{if(NR==r){print $ind;}}' $table_dir))
        tmp_2=($(awk -v ind="$index" -v r="$i" -F: '{if(NR==r){print length($ind);}}' $table_dir))
        let index=${col_length[$j]}-$tmp_2
        line=$line${tmp_1[*]}
        for k in $(seq 1 $index);do
            line=$line"+"
        done
    done
    line=$line"|"
    echo "${line//+/ }"
    if [ $i -eq 2 ]; then
        echo $tmp_record
    fi
done
echo $tmp_record
echo ""