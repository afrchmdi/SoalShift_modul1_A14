#!/bin/bash

#membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau 
#hari jumat bulan Februari

#WHERE=`pwd`
i=1
WHERE=/home/Penunggu/Documents/sisop1/SoalShift_modul1_A14
#echo "$WHERE"
cd $WHERE
unzip $WHERE/nature.zip

for f in $WHERE/nature/*.jpg
do
	base64 -d $f | xxd -r > $i.jpg
	let "i++"
	mv *.jpg $f
done


#14 14 14 2 *

#. . . 2 5
