# Get login and logoff records from Windows Events
#Get-EventLog system -source Microsoft-Windows-winlogon

# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days
function getUserLoginInfo($numDays){
$loginouts = Get-EventLog system -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$numDays)
$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
$securityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($user)
$ntAccount = $securityIdentifier.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{ ` 
"Time" = $loginouts[$i].TimeGenerated
"Id" = $loginouts[$i].Index
"Event" = $event;
"User" = $ntAccount.Value; }

}
return $loginoutsTable
}

function getBootTimes($isShutDown){
$startup = Get-EventLog -LogName "System" | Where-Object { $_.EventId -eq 6005 } | Select-Object -First 10
$shutdown = Get-EventLog -LogName "System" | Where-Object { $_.EventId -eq 6006 } | Select-Object -First 10
$loginoutsTable = @()

if ($isShutDown -eq $false){
for ($i=0; $i -lt $startup.Count; $i++){
$event="System Started"

$loginoutsTable += [pscustomobject]@{ ` 
"Time" = $startup[$i].TimeGenerated
"Id" = $startup[$i].InstanceID
"Event" = $event
"User" = "System"; }
}
}
if ($isShutDown -eq $true){
for ($i=0; $i -lt $shutdown.Count; $i++){
$event="System Shut Down"

$loginoutsTable += [pscustomobject]@{ ` 
"Time" = $shutdown[$i].TimeGenerated
"Id" = $shutdown[$i].InstanceID
"Event" = $event
"User" = "System"; }
}
}
return $loginoutsTable
}

#getBootTimes($true)
#getUserLoginInfo(14)



