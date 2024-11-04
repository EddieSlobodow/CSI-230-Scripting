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

        2 { getFailedLogins(999) | Select-Object -First 10 | Format-Table -AutoSize -Wrap }

        3 { 
            $days = Read-Host -Prompt "Enter the number of days to check the logs for"
            $userLogins = getFailedLogins $days
            $failedUser = @()
            $hashMap = @{}
            for ($i = 0; $i -lt $userLogins.count; $i++){
                if ($hashMap.ContainsKey($userLogins[$i].User)) {$hashMap[$userLogins[$i].User] += 1}
                else {$hashMap[$userLogins[$i].User] = 1}
            }
            foreach ($key in $hashMap.Keys) {
                if ($hashMap[$key] -ge 10) {failedUser += $key}
            }

             Write-Host $failedUser
            }

        4 { Start-Process -FilePath "chrome" '-ArgumentList --start-fullscreen "http://www.champlain.edu"'}

        5 { $exit = $true }

        Default { Write-Host "Enter a number 1-5" }
    }
}

Write-Host "Menu Exited"


