

#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#$A = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'

#$A[-5..-1]

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

#$ipsUnorganized

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips | Where-Object { $_.IP -ilike "10.*" }