# Count number of visits each page has
file="/var/log/apache2/access.log"

allLogs=$(cat "$file" | cut -d' ' -f 7| sort | uniq -c)

echo "$allLogs"
