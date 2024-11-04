# list count of curl accesses for each IP address

file="/var/log/apache2/access.log"

function countingCurlAccess() {
trimmed=$(cat "$file" | grep "curl" | cut -d' ' -f1,12)
}

countingCurlAccess

echo "$trimmed" > curlFile.txt

echo $(sort curlFile.txt | uniq -c)

