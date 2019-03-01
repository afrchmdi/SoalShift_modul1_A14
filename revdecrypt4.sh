#!/bin/bash
what=$1
#folder=`pwd`
folder=/home/Penunggu/Documents/sisop1/soal4
echo $what
big="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
little="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

#change=`awk -F ':' '{ print $1 }' "/home/Penunggu/Documents/sisop1/soal4/$what"`

change=`echo $what |awk -F ':' '{ print $1 }'`
#awk -F ':' '{ print }' "$folder/$what"

awk '{ print }' "$folder/$what" | tr "${big:$change:26}${little:$change:26}" "${big:0:26}${little:0:26}" > "$folder/dec$what"

