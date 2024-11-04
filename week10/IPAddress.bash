# Finding IP Address

ip="$(ip addr | grep "scope global dynamic" | grep -E -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")"
echo "$ip" | head -n 1
