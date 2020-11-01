#!/bin/bash

LANG=en_us_8859_1 

curdate=$(date +"%d/%b/%Y:%T")
#curdate=18/10/2020:15:44:15
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



# pasthour=${pastdate:11:2}
# curhour=${curdate:11:2}
# pastminute=${pastdate:14:2}
# curminute=${curdate:14:2}
# pastsecond=${pastdate:17:2}
# cursecond=${curdate:17:2}
# echo "$pasthour $pastminute $pastsecond"
# echo "$curhour $curminute $cursecond"
# pastday=${pastdate:0:2}
# curday=${curdate:0:2}
# pastmon=${pastdate:3:2}
# curmon=${curdate:3:2}

# # echo ${pastsecond:1:1}
#  if [[ ${pastsecond:0:1} != 5 ]]; then
#  	echo yeap
#  	let pastsecond1=${pastsecond:0:1}+1
#  else
#  	let pastsecond1=5
#  fi
#  if [[ ${pastminute:0:1} != 5 ]]; then
# 	let pastminute1=${pastminute:0:1}+1
#  else
#  	let pastminute1=5
#  fi
#  if [[ ${pastminute:1:1} != 9 ]]; then
# 	let pastminute2=${pastminute:1:1}+1
# else
#  	let pastminute2=9
#  fi
#  if [[ ${pasthour:0:1} != 2 ]]; then
#  	let pasthour1=${pasthour:0:1}+1
#  else
#  	let pasthour1=2
#  fi
#  if [[ ${pasthour:1:1} != 9 ]]; then
#  	let pasthour2=${pasthour:1:1}+1
#  else
#  	let pasthour2=9
#  fi
# # let pastsecond1=${pastsecond:0:1}+1
# # let pastminute1=${pastminute:0:1}+1
# # let pastminute2=${pastminute:1:1}+1
# # let pasthour1=${pasthour:0:1}+1
# # let pasthour2=${pasthour:1:1}+1

# regular="("

# if [[ $pastmon != $curmon ]]; then
# 	echo $pastmon
# 	# if [[ $pastmon -lt 10 ]]; then
# 	# 	regular+="0"
# 	# fi
# 	regular+="$pastday\/$(date +%b -d "$pastmon/05/20")\/20..:($pasthour:($pastminute:(${pastsecond:0:1}[${pastsecond:1:1}-9])"
# 	if [[  ${pastsecond:0:1} != 5 ]]; then
# 		echo blya
# 		regular+="|([$pastsecond1-5][0-9])"
# 	fi
# 	regular+=")|(${pastminute:0:1}[$pastminute2-9])"
# 	if [[  ${pastminute:0:1} != 5 ]]; then
# 		regular+="|([$pastminute1-5][0-9])"
# 	fi
# 	regular+=")|(${pasthour:0:1}[$pasthour2-9])"
# 	if [[  ${pastminute:0:1} != 5 ]]; then
# 		regular+="|([$pasthour1-2][0-9])"
# 	fi
# 	regular+=")|("
# 	for (( i=$pastday+1; i <= 31; i++ )); do
# 		if [[ $i -lt 10 ]]; then
# 			regular+="0"
# 		fi
# 		regular+=$i
# 		if [[ $i -ne 31 ]]; then
# 			regular+="|"
# 		fi	
# 	done

# 	regular+=")\/$(date +%b -d "$pastmon/05/20")"
# 	incmon=$(date +%m -d "$pastmon/05/20 + 1 month")
# 	echo "$incmon $curmon"
# 	if [[ $incmon != $curmon ]]; then
# 		regular+="|([0-3][0-9]\/$(date +%b -d "$incmon/05/20")"
# 		incmon=$incmon+1
# 		#statements
# 	fi
# 	regular+="|("
# 	for (( i=1; i < curday; i++ )); do
# 		if [[ $i -lt 10 ]]; then
# 			regular+="0"
# 		fi
# 		regular+=$i
# 		if [[ $i+1 -ne $curday ]]; then
# 			regular+="|"
# 		fi
# 	done
# 	regular+=")\/$(date +%b -d "$curmon/05/20")"

# 	regular+="|$curday\/$(date +%b -d "$curmon/05/20")\/20..:"
# 	regular+="("


# else
# 	for (( i=$pastday; i < $curday; i++ )); do
# 		if [[ $i -lt 10 ]]; then
# 			regular+="0"
# 		fi
# 		regular+=$i
# 		if [[ $i+1 -ne $curday ]]; then
# 			regular+="|"
# 		fi
# 	done
# 	regular+=")\/$(date +%b -d "$curmon/05/20")"
# fi




# echo $(date +%b -d "09/05/20")

# reg='18\/Oct\/2020:23'

#regular+="'"

#awk '/(14|15|16)\/Oct/{print $0}' test2.txt
#grep '[1-2][6-8]\/Oct' test2.txt
#egrep '(14|15|16)\/Oct\/2020:16:05:4(([5-9]|[5-5]))' test2.txt

#grep $regular test2.txt
#sed -n '/$pastdate/,/$curdate/p' "test2.txt"
#sed -n '/18\/Oct\/2020:13:05:00/,/18\/Oct\/2020:15:18:35/p' test2.txt
#sed -in "/${pastdate}/,/${curdate}/p" test2.txt
S1="17\/Oct\/2020:08:05:23"
S2="17\/Oct\/2020:09:05:25"

past=${pastdate:0:2}\\${pastdate:2:4}\\${pastdate:6:8}
cur=${curdate:0:2}\\${curdate:2:4}\\${curdate:6:8}



if grep $past test2.txt &> /dev/null; then
	sed -n "/${past}/,/${cur}/p" test2.txt > file.txt
else
	sed -n "/16/Oct/2020:08:05:32/,/${cur}/p" test2.txt > file.txt
fi
#sed -n "/${past}/,/${cur}/p" test2.txt
#sed -n "/${S1}/,/${S2}/p" test1.txt


myArray=$(awk '/[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?/{print $1}' file.txt)
myArray=($(echo "${myArray[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# for i in ${!myArray[@]}; do
# 	echo ${myArray[$i]}
# done

declare -A assoc

for i in ${!myArray[@]}; do
	assoc[${myArray[$i]}]=$(grep -c ${myArray[$i]} file.txt)
done

arr=()
size=${#myArray[@]}
stop=0
st=0
function recur {
	#for key in "${!assoc[@]}"; do
	# if [[ st -gt 15 ]]; then
	# 	return
	# fi
	st=$(($st+1))
	local i=$2
	local position=0
	for (( i; i < size; i++ )); do
		
		#echo "$1 $2"
		#echo "цикл: $i"
		#echo "$1 ? ${assoc[${myArray[$i]}]}"
		if [[ $1 -lt ${assoc[${myArray[$i]}]} ]]; then
			#echo "$1 меньше ${assoc[${myArray[$i]}]}"
			for a in ${!arr[@]}; do
				
				if [[ ${assoc[${myArray[$i]}]} -eq ${arr[$a]} ]]; then
					stop=1
					break
				fi
			done
			#echo "flag: $stop"
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
# for i in ${!arr[@]}; do
# 	echo ${arr[$i]}
# done
echo -----------------------------
# for key in "${!assoc[@]}"; do
#     echo "${key} - ${assoc[$key]}"
# done
#echo ${myArray[@]}

#grep -c 137.117.180.241 file.txt


rm file.txt

echo $regular


