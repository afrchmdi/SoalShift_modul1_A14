#!/bin/bash

JAM=`date +"%H"`
MENIT=`date +"%M"`
TANGGAL=`date +"%d-%m-%y"`

big="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
little="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

WHERE=/home/Penunggu/Documents/sisop1/soal4

awk '{ a[$0] } END { for (i in a) { print i }}' /var/log/syslog | tr '{'$big':0:26}{'$little':0:26}' '{'$big':'$JAM':26}{'$little':'$JAM:'26}' > $WHERE/$JAM:$MENIT\ $TANGGAL.txt





