#!/bin/bash
vdate=$(date +"%H:%M:%S" -d "-12 hour")
vtime=$(grep '192.' u_ex240805.log | awk '{print $2}')
brd='------------------------------------------------------------------------'
IFS=$'\n'
for i in $vtime 
  do
    if [[ "$i" < "$vdate" ]]
      then
        array+=( $(cat u_exl240805.log | grep "$i") )
    fi
  done
smail=$(
echo "$brd";
echo "Топ 10 активных обращениях к веб серверу за последний час, начиная с $vdate";
echo "$brd";
echo ' Кол-во IP-адрес';
echo "${array[*]}" | grep -v "::1" | awk '{print $9}' | sort -g | uniq -c -d | sort -gr | head -n 10;
echo "$brd";
echo "Топ 10 запрошенных URL-адресов за последний час, начиная с $vdate" ;
echo "$brd";
echo ' Кол-во URL-адрес';
echo "${array[*]}" | grep -v "::1" | awk '{print $5,$9}' | sort -g | uniq -c -d | sort -gr | head -n 10;
echo "$brd";
echo "Топ 5 кодов ответов сервера за последний час, начиная с $vdate";
echo "$brd";
echo ' Кол-во Код ответа';
echo "${array[*]}" | grep -v "::1" | awk '{print $12}' | sort -g | uniq -c -d | sort -gr | head -n 5;
echo "$brd";
)
echo "$smail" | mail -r max@firma.com -s "Отчёт о работе веб сервера по состоянию на $(date +"%F %H:%M:%S")" noname@yandex.ru
exit 0

# echo "some text here to send it...." | mail -r max@akbars.ru -s "My_subject_is_here" muzaik@yandex.ru
