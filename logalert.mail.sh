#!/bin/bash

#Det som en gang VAR
# Тема письма
SUBJECT="WARNING: Errors found in log on "`date --date='yesterday' '+%b %e'`""
# Временный файл с текстом
MESSAGE="/tmp/logs.txt"
# Почтовый ящик получателя
TO="typeyour@mail.com"

prev_count=0
count=$(grep -i "`date --date='yesterday' '+%b %e'`" /var/log/messages | egrep -wi 'warning|error|critical' | wc -l)
if [ "$prev_count" = "$count" ] ; then
echo "No warning on "`date --date='yesterday' '+%b %e'`"" | mail -s "Lock and load" "$TO" 
elif [ "$prev_count" -lt "$count" ] ; then

# Кривая магия (ノ*゜▽゜*)
echo "ATTENTION: Errors are found in /var/log/messages." >> $MESSAGE
echo  "Hostname: `hostname`" >> $MESSAGE
echo -e "\n" >> $MESSAGE
echo "+-------------------------------------+" 	>> $MESSAGE
echo "Error messages in the log file"		>> $MESSAGE
echo "+-------------------------------------+"  >> $MESSAGE
grep -i "`date --date='yesterday' '+%b %e'`" /var/log/messages | awk '{ $3=""; print}' | egrep -wi 'warning|error|critical' >>  $MESSAGE

# Можно присылать и сам файл с логом
# mail -A /tmp/logs.txt mail -s "$SUBJECT" "$TO"

# Или так
mail -s "$SUBJECT" "$TO" < $MESSAGE

fi

