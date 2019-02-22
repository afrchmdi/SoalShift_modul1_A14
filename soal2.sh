#!/bin/bash

echo "Laporan Soal Shift No 2"
# print daftar nama negara
#awk -F',' 'FNR==1 { next } { f[$1] } END { for ( b in f ) { print b }}' wat.csv

#print semua data negara dan quantity
#awk -F ',' 'FNR==1 {next} //{print $1, $10 }' wat.csv

echo "--------------------------"

echo "a. Negara dengan penjualan(quantity) terbanyak pada tahun 2012 : "

#SOAL A
awk -F ',' '/2012/ NR > 1 { a[$1]+=$10 } END { for ( b in a ) { print a[b], "->", b }}' wat.csv | sort -rn > hehe.txt 
printf "   "
one=`awk -F '->' '{print $2}' hehe.txt | head -1`
echo $one

echo "---------------------------"

#SOAL B
echo "b. Tiga product line yang memiliki penjualan (quantity) terbanyak : "
awk -F ',' -v one="$one" '/one/ && ($7==2012) { f[$4]+=$10 } END { for ( r in f ) { print f[r], "->", r }}' wat.csv | sort -rn > ye.txt
awk -F '->' '{ print "   ", $2 }' ye.txt | head -3 

echo "---------------------------"

#SOAL C
echo "c. Tiga product yang memiliki penjualan(quantity) terbanyak berdasarkan product line soal b : "
printf "   "

#mapfile -t what < <( awk -F '->' '{print $2}' ye.txt | head -3)

#what=`awk -F '->' 'FNR <= 3 { print $2, "," }' ye.txt > hm.txt`

#printf '%s\n ' "${what[0]}"
#printf '%s\n' "${what[1]}"
#printf '%s\n ' "${what[2]}"

#ya="${what[0]}"
ya="Personal Accessories"
#printf 'Produk %s\n' "${what[0]}"
echo "Produk " $ya 
awk -F ',' '/Personal Accessories/  && ($7==2012) { y[$5]+=$10 } END { for (o in y) { print y[o] "," o }}' wat.csv | sort -rn |awk -F ',' '{ print "   ", $2 }' | head -3
printf "\n   =======\n"


#yo="${what[1]}"
#printf '   Produk %s\n' "${what[1]}"

yo="Camping Equipment"
echo "Produk " $yo
awk -F ',' '/Camping Equipment/ && ($7==2012) { x[$5]+=$10 } END { for (o in x) { print x[o] "," o }}' wat.csv | sort -rn |awk -F ',' '{ print "   ", $2 }' | head -3
printf "\n   =======\n"

#ye="${what[2]}"
#printf '   Produk %s\n' "${what[2]}"
ye="Outdoor Protection"
echo "Produk " $ye
awk -F ',' '/Outdoor Protection/ && ($7==2012) { y[$5]+=$10 } END { for (o in y) { print y[o], "->", o }}' wat.csv | sort -rn |awk -F '->' '{ print "   ", $2 }' | head -3
printf "\n   =======\n"



printf "\n---------------------------"



