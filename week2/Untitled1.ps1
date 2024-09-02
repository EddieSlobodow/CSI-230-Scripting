#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).IPAddress

#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).PrefixLength

#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders

#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).ServerAddresses[0]

#cd $PSScriptRoot

#$files=(Get-ChildItem)
#for ($j=0; $j -le $files.length; $j++){
    #if ($files[$j].Name -ilike "*ps1"){
        #Write-Host $files[$j].Name
    #}
#}

#$folderpath="$PSScriptRoot\outfolder"
#if (Test-Path $folderpath){
    #Write-Host "Folder Already Exists"
#}
#else{
    #New-Item -ItemType Directory -Path $folderpath
#}

cd $PSScriptRoot
$files =(Get-ChildItem)

$folderPath = "PSScriptRoot/outfolder/"
$filePath = 