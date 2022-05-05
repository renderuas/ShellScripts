#!/bin/bash
LOGPATH=/var/tmp
ARRAYDAYS=($(awk -F: '{print $2}' $LOGPATH/zabbix_server.log|sort|uniq))
ARRAYDAYS=(20220505)
#ARRAYSYS=($( awk -F\" '/connection restored/ {print $2}' zabbix_server.log | sort |uniq -c | sort -n -r|head -n 10))

for DAY in "${ARRAYDAYS[@]}"
do

        #ARRAYSYS=($(grep $DAY zabbix_server.log| awk -F\" '/connection restored/ {print $2}' | sort |uniq -c | sort -n -r|head -n 10))
        ARRAYSYS=(sha1s00010 sha1s00800 sha1s40101 fra1s80169 fra1s80167 fra1s80165 fra1s80163 fra2s80101 sha1s40501 fra1s80118)
        for SYS in "${ARRAYSYS[@]}"
        do
                grep $DAY $LOGPATH/zabbix_server.log |grep $SYS > /var/tmp/salida/$DAY.$SYS.day
                grep $DAY $LOGPATH/zabbix_server.log|grep $SYS|awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, '/Zabbix agent item/ {print $5}'|sort|uniq > /var/tmp/salida/$DAY.$SYS.AUX
                for ITEM in `cat /var/tmp/salida/$DAY.$SYS.AUX`
                do
                        echo $DAY $SYS $ITEM $(grep -Fc "$ITEM" /var/tmp/salida/$DAY.$SYS.day)>> salida/$DAY.$SYS.item.aux
                done
                sort -k4 -rn salida/$DAY.$SYS.item.aux > salida/$DAY.$SYS.item
                rm /var/tmp/salida/$DAY.$SYS.day
                rm /var/tmp/salida/$DAY.$SYS.AUX
                rm /var/tmp/salida/$DAY.$SYS.item.aux
        done

done

