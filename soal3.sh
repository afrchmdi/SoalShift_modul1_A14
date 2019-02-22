#!/bin/bash

i=1
folder=`pwd`
this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

#echo $this $folder
flag=0
while [ "$flag" == 0 ]
do
	if [ -f "$folder/password$i.txt" ]
	then
		ya=$(awk '{print $1}' $folder/password$i.txt)

		while [ $this == $ya ]
		do
			this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
		done
		let "i++"
	else
		echo "$this" >> $folder/password$i.txt 
		flag=1
		exit
	fi
done



