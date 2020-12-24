#!/bin/bash

set -e

PATH="/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin"                                                                                            
 
if pidof -x $(basename $0) > /dev/null; then
   for p in $(pidof -x $(basename $0)); do
   if [ $p -ne $$ ]; then
   echo "Script $0 is already running: exiting"
    exit
   fi
   done
fi

LANG=en_us_8859_1 

curdate=$(date +"%d/%b/%Y:%T")

pastdate=$(cat date.txt)

if ! [ -n "$1" ]
then
echo "Error: Parametr is not set"
exit 10
fi


path=$1

if ! find $1 &> /dev/null
then
echo "Error: File not found"
exit 20
fi

echo "Обработанный временной диапазон: "

if ! find date.txt &> /dev/null
then
echo "C  16/Oct/2020:0:00:00 " 
else
echo "C  $pastdate"	
fi

echo "По $curdate"

#echo $curdate > date.txt




past=${pastdate:0:2}\\${pastdate:2:4}\\${pastdate:6:8}
cur=${curdate:0:2}\\${curdate:2:4}\\${curdate:6:8}



if grep $past test3.txt &> /dev/null; then
	sed -n "/${past}/,/${cur}/p" test3.txt > file.txt
else
	sed -n "/16/Oct/2020:08:05:32/,/${cur}/p" test3.txt > file.txt
fi



myArray=$(awk '/[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?/{print $1}' file.txt)
myArray=($(echo "${myArray[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))



declare -A assoc

for i in ${!myArray[@]}; do
	assoc[${myArray[$i]}]=$(grep -c ${myArray[$i]} file.txt)
done

arr=()
size=${#myArray[@]}
stop=0
st=0
function recur {

	st=$(($st+1))
	local i=$2
	local position=0
	for (( i; i < size; i++ )); do

		if [[ $1 -lt ${assoc[${myArray[$i]}]} ]]; then

			for a in ${!arr[@]}; do
				
				if [[ ${assoc[${myArray[$i]}]} -eq ${arr[$a]} ]]; then
					stop=1
					break
				fi
			done

			if [[ $stop -eq 0 ]]; then
				recur ${assoc[${myArray[$i]}]} $i

			fi
			stop=0

		fi
	done
	
	
	arr+=($1)

	if [[ ${#arr[@]} -lt 16 ]]; then
		echo "${myArray[$2]} - $1"
	fi


}

echo "Топ 15 IP адресов"

recur 0 0

echo -----------------------------



myArrayRes=$(awk '{print $7}' file.txt)
myArrayRes=($(echo "${myArrayRes[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

declare -A res

for i in ${!myArrayRes[@]}; do
	res[${myArrayRes[$i]}]=$(grep -c ${myArrayRes[$i]} file.txt)
done

mas1=()

size=${#myArrayRes[@]}
stop=0
st=0
function recurRes {
	st=$(($st+1))
	local i=$2
	local position=0
	for (( i; i < size; i++ )); do
		if [[ $1 -lt ${res[${myArrayRes[$i]}]} ]]; then
			for a in ${!mas1[@]}; do
				
				if [[ ${res[${myArrayRes[$i]}]} -eq ${mas1[$a]} ]]; then
					stop=1
					break
				fi
			done
			if [[ $stop -eq 0 ]]; then
				recurRes ${res[${myArrayRes[$i]}]} $i

			fi
			stop=0

		fi
	done	
	
	mas1+=($1)

	if [[ ${#mas1[@]} -lt 4 ]]; then
		echo "${myArrayRes[$2]} - $1"
	fi


}

echo "Топ 15 ресурсов сайта"
recurRes 0 0
echo -----------------------------




myArrayCode=$(awk '{print $9}' file.txt)
myArrayCode=($(echo "${myArrayCode[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo "Коды возврата"
for i in ${!myArrayCode[@]}; do
	echo "${myArrayCode[$i]} - $(grep -c ${myArrayCode[$i]} file.txt)"
done

echo -----------------------------



echo "Коды ошибок возврата"
for i in ${!myArrayCode[@]}; do
	if [[ ${myArrayCode[$i]} =~ ^4..$ ]]; then
		echo "${myArrayCode[$i]} - $(grep -c ${myArrayCode[$i]} file.txt)"
	elif [[ ${myArrayCode[$i]} =~ ^5..$ ]]; then
		echo "${myArrayCode[$i]} - $(grep -c ${myArrayCode[$i]} file.txt)"
	fi
done

echo -----------------------------

rm file.txt

echo $regular


