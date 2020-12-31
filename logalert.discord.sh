#!/bin/bash

# -X POST - use POST method.
# -H "Content-Type: application/json" - header tells server you're sending JSON data.
# -d '{"username": "test", "content": "hello"}' - sets request data.
#curl -X POST -H "Content-Type: application/json" -d '{"username": "test", "content": "hello"}' "https://discordapp.com/api/webhooks/793295246384562227/JypeWovu0HeVzveC1Ru-Njb0VWtlIXPGKTScGTOgQ0GPobfGKPhV9Eg95UHGTunYPw9i"

# To make command more readable you can split it to multiple lines using backslash `\`
# and set webhook url as variable, so you don't need to paste it over and over again.
# Also you can add the variable to your `.*rc` file, so it persists on console reloads.
#VARs
WEBHOOK_URL=""
AVATAR_URL="https://i.imgur.com/oBPXx0D.png"
USERNAME="Satans Litte Helper"
HEADER="Content-Type: application/json"
ALLOK="Code green. All systems online."
ERRORFILE="/tmp/logs.txt"
ERROR="$(head -n 3 $ERRORFILE)"

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
curl -s -H $HEADER  -X POST "$WEBHOOK_URL" -d avatar="$AVATAR_URL" -d content="$ALLOK"
elif [ "$prev_count" -lt "$count" ] ;
then
curl -s -X POST "$WEBHOOK_URL" -d avatar="$AVATAR_URL" -d content="$ERROR"

fi
