#!bin/bash

file="/var/log/apache2/access.log"

cat "$file" | while IFS= read -r line; do

ipAddr=$(echo "$line" | grep "GET /page2.html" | cut -d' ' -f 1)

page=$(echo "$line" | grep "GET /page2.html" | cut -d' ' -f 7 | tr -d "/")

if [ -n "$page" ]; then
echo -n "$ipAddr"
echo -n " "
echo  "$page"
fi

done
