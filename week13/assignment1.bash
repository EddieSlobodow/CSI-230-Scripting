#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayCoursesofRoom(){
	echo -n "Input room name: "
	read roomName
	echo ""
	echo "Courses of $roomName :"
	cat "$courseFile" | grep "$roomName" | cut -d';' -f1,2,5,6,7 | \
	sed 's/;/ | /g'
	echo ""

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canva

function displayCourseAvailability {
	echo -n "Input subject name: "
	read subjectName
	echo ""
	echo "$subjectName available courses: "
	local subjectClasses=$(cat "$courseFile" | grep "$subjectName")
	:> temp.txt
	echo "$subjectClasses" | whle read -r line;
	do
		local number=$(echo "$line" | cut -d ";" -f1)
		local title=$(echo "$line" | cut -d ";" -f2)
		local credit=$(echo "$line" | cut -d ";" -f3)
		local seats=$(echo "$line" | cut -d ";" -f4)
		local day=$(echo "$line" | cut -d ";" -f5)
		local times=$(echo "$line" | cut -d ";" -f6)
		local instructor=$(echo "$line" | cut -d ";" -f7)
		local dates=$(echo "$line" | cut -d ";" -f8)
		local prereq=$(echo "$line" | cut -d ";" -f9)
		local location=$(echo "$line" | cut -d ";" -f10)
		if [["${seats]" -ge "1"]];
		then
			echo "$number | $title | $credit | $seats | $day | $times | $instructor | $dates | $prereq | $location >> temp.txt
		fi
	done
	cat "temp.txt"
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a room"
	echo "[4] Display course availability"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesofRoom

	elif [[ "$userInput" == "4" ]]; then
		displayCourseAvailability

	else echo "Enter a valid number" 
	# TODO - 3 Display a message, if an invalid input is given
	fi
done
