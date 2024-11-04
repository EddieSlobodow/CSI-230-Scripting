# List all the ips in the given network prefix
#/24 only

#Usage: bash IPList.bash 10.0.17
[ "$#" -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1
#$0 always represents the name of the file

# Prefix is the first input taken
Prefix="$1"
# $1 is the first argument that you can pass when calling the file

# Verify input length
[ "${#Prefix}" -le 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1
for i in {1..254}
do
	ping -c 1 "$Prefix.$i" | grep "64 bytes from" | \
	grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
# -o gets rid of extraneous text and -E allows a regex to be used
done
