#!/bin/bash

echo "Laporan Soal Shift No 2"
# print daftar nama negara
#awk -F',' 'FNR==1 { next } { f[$1] } END { for ( b in f ) { print b }}' wat.csv

#print semua data negara dan quantity
#awk -F ',' 'FNR==1 {next} //{print $1, $10 }' wat.csv

echo "--------------------------"

echo "a. Negara dengan penjualan(quantity) terbanyak pada tahun 2012 : "

#SOAL A
one=`awk -F ',' '($7==2012) { a[$1]+=$10 } END { for ( b in a ) { print a[b], "->", b }}' wat.csv | sort -rn | awk -F '->' '( NR==1 ) { print$2 }'`

printf "   "

this="$(echo -e "${one}" | sed -e 's/^[[:space:]]*//')"

echo $this

echo "---------------------------"


#SOAL B

echo "b. Tiga product line yang memiliki penjualan (quantity) terbanyak : "

awk -F ',' -v neg="$this" '{ if ( $1==neg && $7==2012 ) { f[$4] += $10 }} END { for ( r in f ) { print f[r]"->"r }}' wat.csv | sort -rn > ye.txt

awk -F '->' '{ print "   ", $2 }' ye.txt | head -3

echo "---------------------------"


#SOAL C
echo "c. Tiga product yang memiliki penjualan(quantity) terbanyak berdasarkan product line soal b : "

satu=`awk -F '->' 'NR==1 { print $2 }' ye.txt`
dua=`awk -F '->' 'NR==2 { print $2 }' ye.txt`
tiga=`awk -F '->' 'NR==3 { print $2 }' ye.txt`

that="$(echo -e "${satu}" | sed -e 's/^[[:space:]]*//')"

yo="$(echo -e "${dua}" | sed -e 's/^[[:space:]]*//')"

ye="$(echo -e "${tiga}" | sed -e 's/^[[:space:]]*//')"

awk -F ',' -v tu="$that" -v neg="$this" -v wa="$yo" -v ga="$ye" '{ if (($4==tu || $4==wa || $4==ga) && $7==2012 && $1==neg) { y[$6]+=$10 }} END { for (o in y) { print y[o] "," o }}' wat.csv | sort -rn | awk -F ',' '{ print "   ", $2 }' | head -3

printf "\n---------------------------\n"
