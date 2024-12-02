
page=$(curl -sL "10.0.17.6/Assignment.html")

temprature=$(echo "$page" | xmlstarlet sel -t -m "//html//body//table[@id='temp']//tr//td" -v . -n)
pressure=$(echo "$page" | xmlstarlet sel -t -m "//html//body//table[@id='press']//tr//td" -v . -n)

listCount=$(echo "$temprature" | wc -w)

for ((i=1; i<="$listCount"; i+=2)); do
	first=$(echo -n "$pressure" | sed -n "${i}p")
	second=$(echo -n "$temprature" | sed -n "${i}p")
	timeIndex=$((i+1))
	third=$(echo -n "$pressure" | sed -n "${timeIndex}p")
	echo "$first $second $third"
	
done
