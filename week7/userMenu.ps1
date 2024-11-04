. C:\Users\champuser\CSI-230-Scripting\week5\Untitled5.ps1
. C:\Users\champuser\CSI-230-Scripting\week7\Event-Logs.ps1

function displayMenu() {
Write-Host "-- User Menu --"
Write-Host "1. Display last 10 apache logs"
Write-Host "2. Display last 10 failed logins for all users"
Write-Host "3. Display at risk users"
Write-Host "4. Start chrome web browser and navigate it to champlain.edu"
Write-Host "5. Exit"
}

$exit = $false
while (-not $exit) {
    displayMenu
    $selection = Read-Host "Enter a number"

    switch ($selection) {
        1 { ApacheLogs1 | Select-Object -First 10 | Format-Table -AutoSize -Wrap }

        2 { getFailedLogins }

        3 { }

        4 { }

        5 { $exit = $true }
    }
}

Write-Host "Menu Exited"


