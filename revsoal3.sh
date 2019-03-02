#!/bin/bash

i=1
folder=`pwd`
this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

re=[0-9a-zA-Z]+
while ! [[ "$this" =~ ${re} ]]; do
	this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
	echo "eh"
done

flag=0
while [ "$flag" == 0 ]
do

	for ye in `find . -type f -name "password*"` 
	do
#		echo "hehe"
#		echo "$ye"
		ya=$(awk '{print $1}' $folder/$ye)
		echo $ya
		while [ "$this" == "$ya" ]
		do
			this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

			re=[0-9a-zA-Z]+
			while ! [ "$this" ~= ${re} ]
			do
				this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
				echo "ganti lagi\n"
			done
		done
		echo $i
		let "i++"
	done
		flag=1
done

a=1
while [ -f "password$a.txt" ]
do
        let "a++"
done

echo "$this" >> $folder/password$a.txt 
echo "ke -"$a
