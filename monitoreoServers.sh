#! /bin/bash
#Script para monitoreo de Recursos del Servidor:
#Se utiliza de base el script de esta pagina: https://kloudvm.com/linux/bash-script-monitor-cpu-memory-disk-usage-on-linux/
#y se realizan adaptaciones para que el monitoreo se ejecute 3 veces por dia mediante jenkins:
#Autor: Jose Castrejon:

printf "Memory\t\tDisk\t\tCPU\n"
MEMORYNUMBER=$(free -m | awk 'NR==2{printf $3*100/$2}')
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
echo "$MEMORY$DISK$CPU"
if [[ $MEMORYNUMBER > 50 && $MEMORYNUMBER < 80 ]]; then
	echo "El uso de la memoria Ram rebasa el 50%"
elif [[ $MEMORYNUMBER > 80 ]]; then
	echo "Uso de memoria Ram rebasa el 80% tomar acciones"
else
	echo "Todo en orden, el uso de memoria ram esta por debajo del 50%"
fi
