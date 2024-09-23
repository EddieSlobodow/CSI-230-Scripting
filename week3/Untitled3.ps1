. (Join-Path $PSScriptRoot "Untitled2.ps1")

clear

$loginoutsTable = getUserLoginInfo(15)
$loginoutsTable

$shutdownsTable = getBootTimes($true)
$shutdownsTable

$startupsTable = getBootTimes($false)
$startupsTable

