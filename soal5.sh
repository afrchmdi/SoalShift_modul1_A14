#!/bin/bash

WHERE=/home/Penunggu/modul1

awk '/[Cc][Rr][Oo][Nn]/ && !/[Ss][Uu][Dd][Oo]/ { if ( NF < 13 ) { print $0 }}' /var/log/syslog >> $WHERE/logs

#crontab
#2-30/6 * * * *
