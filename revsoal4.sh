#!/bin/bash

JAM=`date +"%H"`
nama=$(date +"%H:%M %d-%m%y")
big="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
little="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
#WHERE=`pwd`
WHERE=/home/Penunggu/Documents/sisop1/soal4

awk '{ print $0 }' /var/log/syslog | tr "${big:0:26}${little:0:26}" "${big:$JAM:26}${little:$JAM:26}" > "$WHERE"/"$nama".txt





