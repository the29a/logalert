#!/bin/bash

#VARs
TOKEN=""
CHAT_ID=""
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
ALLOK="Code green. All systems online."
ERRORFILE="/tmp/logs.txt"
ERROR="$(less $ERRORFILE)"

# Хотел сделать так, но не получилось
#CODEGREEN="$(curl -s -X POST "$URL" -d chat_id="$CHAT_ID" -d text="$ALLOK")"
#CODERED="$(curl -s -X POST "$URL" -d chat_id="$CHAT_ID" -d text="$ERROR")"


echo "ATTENTION: Errors are found in /var/log/messages." >> $ERRORFILE
echo  "Hostname: `hostname`" >> $ERRORFILE
echo -e "\n" >> $ERRORFILE
echo "+-------------------------------------+" 	>> $ERRORFILE
echo "Error messages in the log file"		>> $ERRORFILE
echo "+-------------------------------------+"  >> $ERRORFILE
grep -i "`date --date='yesterday' '+%b %e'`" /var/log/messages | awk '{ $3=""; print}' | egrep -wi 'warning|error|critical' >>  $ERRORFILE

prev_count=0
count=$(grep -i "`date --date='yesterday' '+%b %e'`" /var/log/messages | egrep -wi 'warning|error|critical' | wc -l)
if [ "$prev_count" = "$count" ] ;
then
curl -s -X POST "$URL" -d chat_id="$CHAT_ID" -d text="$ALLOK"
elif [ "$prev_count" -lt "$count" ] ;
then
curl -s -X POST "$URL" -d chat_id="$CHAT_ID" -d text="$ERROR"

fi
