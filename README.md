# SoalShift_modul1_A14

Soal Shift Modul 1
1. [Soal 1](#1-soal-1)
2. [Soal 2](#2-soal-2)
3. [Soal 3](#3-soal-3)
4. [Soal 4](#4-soal-4)
5. [Soal 5](#5-soal-5)



### 1. Soal 1
##### Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari. Hint: Base64, Hexdump

File *nature.zip* disimpan dalam folder `/home/Penunggu/Documents/sisop1/soal1`. Pada folder yang sama, dibuat sebuah bash script bernama `soal1.sh` yang akan meng*unzip* *nature.zip*, serta men*decrypt* file-file jpg yang ada dalam *zip* tersebut.
Isi dari bash script `soal1.sh` :

```sh
#!/bin/bash

WHERE=`pwd`
i=1

#echo "$WHERE"

unzip $WHERE/nature.zip

for f in $WHERE/nature/*.jpg
do
        base64 -d $f | xxd -r > $i.jpg
        let "i++"
        mv *.jpg $f
done

```

Variabel `WHERE` akan menyimpan direktori saat ini yaitu direktori dimana bash script berada dan akan dijalankan.
File *nature.zip* yang sudah diunduh pertama-tama harus di*unzip* terlebih dahulu dengan *command* `unzip $WHEREnature.zip`.
Setelah berhasil di*unzip*, hasilnya tersimpan dalam sebuah direktori bernama *nature*. Untuk men*decrypt* tiap file jpg yang ada di dalam direktori *nature*, dilakukan looping untuk semua file yang ada pada direktori tersebut 

``` for f in $WHEREnature.zip```

Selama melakukan looping, *command* yang dilakukan untuk dijalankan pada tiap file adalah 
```sh
$ base64 -d $f | xxd -r > $i.jpg
```
command `base64 -d` berfungsi untuk mendecode file-file yang telah dienkripsi sebelumnya yang lalu akan menjadi hexdump. Kemudian output dari command ini kita pipe `|` dan diubah menjadi file aslinya (direverse) dengan command `xxd -r`. File-file jpg yang sudah di *decrypt* lalu di pindah ke folder semula dengan nama yang sama, sehingga file-file lama yang masih ter*enkripsi* tergantikan oleh file jpg yang dapat dibuka.


### 2. Soal 2
##### Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:

##### a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
##### b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
##### c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

File WA_Sales_Products_2012-14.csv dan bash script diletakkan pada folder yang sama yaitu di `/home/Penunggu/Documents/sisop1/soal2/`. 

Dibuat bash script dengan nama `soal2.sh` yang isinya :

```sh
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
one=awk -F '->' '{print $2}' hehe.txt | head -1
echo $one

echo "---------------------------"

#SOAL B
echo "b. Tiga product line yang memiliki penjualan (quantity) terbanyak : "
printf "   "
awk -F ',' -v one="$one" '/one/ && ($7=='2012') { f[$4]+=$10 } END { for ( r in f ) { print f[r], "->", r }}' wat.csv | sort -rn > ye.txt
printf "   "
two=`awk -F '->' '{ print $2 }' ye.txt | head -3`
echo $two

echo "---------------------------"

#SOAL C
echo "c. Tiga product yang memiliki penjualan(quantity) terbanyak berdasarkan product line soal b : "
printf "   "
IFS=$'\n'
what=($(awk -F '->' 'FNR <= 3 { printf "%s\n", $2 }' ye.txt))

#printf '%s ' "${what[@]}"
#printf '\n   %s' "${what[1]}"

printf 'Produk %s\n' "${what[0]}"
awk -F ',' -v apa="${what[0]}" '/apa/ && ($7=='2012') { y[$5]+=$10 } END { for (o in y) { print y[o], "->", o }}' wat.csv | sort -rn |awk -F '->' '{ print " $
printf "\n=======\n"


printf '   Produk %s\n' "${what[1]}"
awk -F ',' -v apa1="${what[1]}" '/apa1/ && ($7=='2012') { x[$5]+=$10 } END { for (o in x) { print x[o], "->", o }}' wat.csv | sort -rn |awk -F '->' '{ print $
printf "\n=======\n"

printf '   Produk %s\n' "${what[2]}"
awk -F ',' -v apa2="${what[2]}" '/apa2/ && ($7==2012) { y[$5]+=$10 } END { for (o in y) { print y[o], "->", o }}' wat.csv | sort -rn |awk -F '->' '{ print " $
printf "\n=======\n"

echo "---------------------------"

```

###### Untuk soal pertama yaitu soal a, diminta nama negara dengan penjualan terbanyak pada tahun 2012. Untuk memfilter data tersebut digunakan `awk` sesuai dengan kondisi yang diminta.

```sh
awk -F ',' '/2012/ NR > 1 { a[$1]+=$10 } END { for ( b in a ) { print a[b], "->", b }}' wat.csv | sort -rn > hehe.txt
printf "   "
one=`awk -F '->' '{print $2}' hehe.txt | head -1`
echo $one

```

+ `awk -F ','` berarti koma (,) digunakan sebagai separator tiap kolom/field.

+ `'/2012/ NR > 1 { a[$1]+=$10 } END { for ( b in a ) { print a[b], "->", b }}' wat.csv | sort -rn > hehe.txt` berarti pencarian dilakukan dengan inputan file wat.csv, dengan filter tiap baris yang mengandung "2012" dan pencarian dilakukan dimulai dari baris kedua. Dibuat sebuah array *a* yang indeksnya adalah data yang ada pada kolom pertama dalam file csv, yaitu field *Retailer Country*. Setelah itu dilakukan *looping* untuk mengoutputkan data yang telah difilter tadi dalam kondisi sudah di *sort* secara 
*reverse numeric* / *descending*. Record-record tersebut kemudian disimpan dalam file `hehe.txt`.

+ one=`awk -F '->' '{print $2}' hehe.txt | head -1` data yang ada pada file `hehe.txt` difilter lagi dengan separator tiap field/ kolomnya adalah `->` dengan hanya mengambil data pada kolom kedua pada `hehe.txt` yaitu negara dengan penjualan terbanyak pada tahun 2012 yang dimasukkan ke dalam variabel `one`.

###### Soal kedua yaitu soal b, kita diminta untuk mengoutputkan 3 product line yang memiliki penjualan quantity terbanyak. `awk` kembali digunakan untuk mendapatkan output yag diinginkan.

```sh
echo "b. Tiga product line yang memiliki penjualan (quantity) terbanyak : "
awk -F ',' -v one="$one" '/one/ && ($7==2012) { f[$4]+=$10 } END { for ( r in f ) { print f[r], "->", r }}' wat.csv | sort -rn > ye.txt
awk -F '->' '{ print "   ", $2 }' ye.txt | head -3 

```

+ `awk -F ','` berarti koma (,) digunakan sebagai separator tiap kolom/field.

+ `-v one="$one"` untuk meng*assign* variabel shell `one` ke variabel `one` awk.

+ `'/one/ && ($7==2012) { f[$4]+=$10 } END { for ( r in f ) { print f[r], "->", r }}' wat.csv | sort -rn > ye.txt` pencarian dilakukan dengan inputan file wat.csv, dengan filter data yang mengandung *United States*


### 3. Soal 3
##### Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:

##### a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
##### b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
##### c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
##### d. Password yang dihasilkan tidak boleh sama.

Untuk meng-*generate* password sebanyak 12 karakter dengan ketentuan pada soal, dibuat bash script *soal3.sh* :

```sh
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

```

+ `this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)` untuk meng-*generate* password yang disimpan dalam variabel `this`. 

`tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1` untuk memnuhi syarat karakter dari password tersebut, yaitu terdiri dari huruf kecil, huruf besar, serta angka. `fold -w 12` untuk membatasi jumlah karakter password, yaitu 12 karakter. dan `head -n 1` agar ketika script dijalankan, password yang dihasilkan hanya 1.

```sh
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

```

kemudian dilakukan while loop dimana selama loop dilakukan dalam folder sekarang file `password$i` dicek apakah ada dan merupakan suatu file. Kemudian variabel ya digunakan untuk menyimpan password yang ada dalam file dengan indeks `i` looping-an saat itu. Apabila password yang di-*generate* sama dengan password yang dicek saat itu (variabel ya), maka password akan digenerate lagi dikarenakan adanya syarat tidak boleh ada password yang sama.

Namun jika ternyata tidak sama, maka password akan ditulis dalam file password yang indeks `i`-nya sudah di*increment*.


### 4. Soal 4
##### Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal- bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

##### a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
##### b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.
##### c. setelah huruf z akan kembali ke huruf a
##### d. Backup file syslog setiap jam.
##### e. dan buatkan juga bash script untuk dekripsinya.

Untuk membackup file syslog tiap jam sesuai ketentuan pada soal, dibuat bash script berikut :

```sh
#!/bin/bash

JAM=`date +"%H"`
MENIT=`date +"%M"`
TANGGAL=`date +"%d-%m-%y"`

big="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
little="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

WHERE=/home/Penunggu/Documents/sisop1/soal4

awk '{ a[$0] } END { for (i in a) { print i }}' /var/log/syslog | tr '{'$big':0:26}{'$little':0:26}' '{'$big':'$JAM':26}{'$little':'$JAM:'26}' > $WHERE/$JAM:$MENIT\ $TANGGAL.txt

```

+ `JAM=date +"%H"` variabel yang menyimpan jam saat ini

+ `MENIT=date +"%M"` variabel yang menyimpan menit saat ini

+ `TANGGAL=date +"%d-%m-%y"` variabel yang menyimpan tanggal saat ini

+ `awk '{ a[$0] } END { for (i in a) { print i }}' /var/log/syslog` awk ini digunakan untuk mengambil seluruh baris data yang ada pada file */var/log/syslog*.

+ `tr '{'$big':0:26}{'$little':0:26}' '{'$big':'$JAM':26}{'$little':'$JAM:'26}' > $WHERE/$JAM:$MENIT\ $TANGGAL.txt` seluruh baris data yang diambil kemudian di *encrypt* dengan menggunakan command `tr` dimana tiap huruf alfabetnya diganti/dishift dengan n dimana n adalah jam saat itu dan disimpan dalam folder dan dengan nama `/home/Penunggu/Documents/sisop1/soal4/$JAM:$MENIT\ $TANGGAL.txt`.

Agar file log terbackup tiap jam, maka perlu ditambahkan crontab.

``sh
$crontab -e
``

lalu akan muncul file  `/tmp/crontab.r3hRkM/crontab`. Pada bagian bawah file, tambahkan cronjob
```sh
*/60 * * * * /bin/bash /home/Penunggu/Documents/sisop1/soal4/soal4.sh

```
cronjob ditambahkan agar bash script `soal4.sh` dijalankan tiap jam dan file syslog akan terbackup tiap jam.


### 5. Soal 5
##### Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:

##### a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
##### b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
##### c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
##### d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

Untuk memfilter record syslog yang diambil yang memenuhi kondisi yang disyaratkan, digunakan `awk` dalam sebuah bash script.
Isi bash script `soal5.sh` :

```sh
#!/bin/bash

WHERE=/home/Penunggu/modul1

awk '/[Cc][Rr][Oo][Nn]/ && !/[Ss][Uu][Dd][Oo]/ { if ( NF < 13 ) { print $0 }}' /var/log/syslog >> $WHERE/logs

#crontab
#2-30/6 * * * *

```

+ `awk '/[Cc][Rr][Oo][Nn]/ && !/[Ss][Uu][Dd][Oo]/ { if ( NF < 13 ) { print $0 }}' /var/log/syslog >> $WHERE/logs` sebagai pemfilter data yang dibutuhkan, dimana file inputan yang dibaca adalah `/var/log/syslog` dan filter yang digunakan string yang mengandung *cron* tetapi tidak mengandung *sudo* yang tidak bersifat *case sensitive*. 
`{ if ( NF < 13 ) { print $0 }}` agar data yang diambil hanya jika jumlah fieldnya kurang dari 13. dan lalu hasilnya disimpan dalam direktori yang ditentukan, `/home/[user]/modul1`.

Agar script dijalankan tiap 6 menit dari menit ke 2 hingga 30, maka ditambahkan crontab
```sh
crontab -e
```
Lalu pada akhir file `/tmp/crontab.r3hRkM/crontab` ditambahkan cronjob 
`2-30/6 * * * * /bin/bash /home/Penunggu/Documents/sisop1/soal5/soal5.sh`
