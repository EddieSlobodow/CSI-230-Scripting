#! /bin/bash

url="10.0.17.6/IOC.html"
page=$(curl -sL "$url")
curled=$(echo "$page" | \
xmlstarlet select --template --value-of \
"//html//body//table//tr")

echo "$curled" | sed 's/<\/tr>/\n/g' | \
		     sed -e 's/&amp;//g' | \
		     sed -e 's/<tr>//g' | \
	   	     sed -e 's/<td[^>]*>//g' | \
		     sed -e 's/<\/td>/;/g' | \
		     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
		     sed -e 's/<[/\]\{0,1\}nobr>//g' \
		      > temp.txt

sed -i '/^\s*$/d' temp.txt
awk 'NR % 2 {print} !(NR % 2) && /pattern/ {print}' temp.txt | sed 's/\t\t*//g' | sed '1d' > IOC.txt
