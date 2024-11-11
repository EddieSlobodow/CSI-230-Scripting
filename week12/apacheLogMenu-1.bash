#! /bin/bash

logFile="/var/log/apache2/access.log"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

# function: displayOnlyPages:

function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
}
# like displayOnlyIPs - but only pages

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors: 

function frequentVisitors(){
	visits=$(histogram) #gets historgram
	for i in $(seq 1 $(echo "$visits" | awk 'END {print NR}')); do #loops based on how many lines are in historgram
		curr=$(echo "$visits" | awk -v line="$i" 'NR==line') #gets the current line
		cleanedString=$(echo "$curr" | awk '{$1=$1; print}') #cleans the string of blank starting spaces
		freq=$(echo "$cleanedString" | cut -d ' ' -f 1) #gets the frequency of visits
		if [[ "$freq" -ge 10 ]]; then #checks if the frequency is 10 or greater
			echo "$curr" #prints the current line
		fi
	done
}
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 

# function: suspiciousVisitors
function suspiciousVisitors(){
	cat "$logFile" | egrep -i -f ioc.txt | cut -d ' ' -f 1 | sort -n | uniq -c
}
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides

# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "Please select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	echo "[5] Frequent Visitors"
	echo "[6] Suspicious Visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
		echo "Frequent Visitors:"
		frequentVisitors
	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious Visitors:"
		suspiciousVisitors
	else echo "Please enter a valid number" 
        # Display frequent visitors
	# Display suspicious visitors
	# Display a message, if an invalid input is given
	fi
done
