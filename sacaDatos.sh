dates="20220501	20220502 20220503 20220504"
systems="fra1s80118	fra1s80163	fra1s80130	fra1s80131	fra1s80121	fra2s80163"

for date in $dates
do
    for sys in $systems
    do
        grep $date zabbix_server.log|grep $sys > salida/$date.$sys.out
        awk -F\" '{print $2 $3 $4}' salida/$date.$sys.out|awk '{print $1}'|grep -v $sys |sort|uniq > salida/$date.$sys.AUX
        for item in `cat salida/$date.$sys.AUX`
        do
            NUM=$(grep -Fc "$item" salida/$date.$sys.out) 
            echo $date : $sys : $item : $NUM >>  salida/$date.$sys.items
        done
        rm salida/$date.$sys.AUX
    done
done