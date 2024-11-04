. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get at risk users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"

        if (checkUser($name)) {
            Write-Host $name " already exists" | Out-String
        }
        else {
            $password = Read-Host -Prompt "Please enter the password for the new user"
            Write-Host $password
            if (checkPassword($password)) {
            $password = ConvertTo-SecureString $password -AsPlainText -Force #I had to remove inputing the string as a secure string
                createAUser $name $password # and use this instead because the password was being properly recieved
                Write-Host "User: $name is created." | Out-String
            }
            else { Write-Host "Password must be 6 or more characters and contain a number, a letter, and a special character" }
        }

        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        # done

        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        # done

        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # done

        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
        # done

    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if (-not (checkUser($name))) {Write-Host "User does not exist"}
        else {
            removeAUser $name

            Write-Host "User: $name Removed." | Out-String
        }

        # TODO: Check the given username with the checkUser function.
        # done
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (-not (checkUser($name))) {Write-Host "User does not exist"}
        else {
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }

        # TODO: Check the given username with the checkUser function.
        # done

    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (-not (checkUser($name))) {Write-Host "User does not exist"}
        else {
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }

        # TODO: Check the given username with the checkUser function.
        # done

    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        # done

        if (-not (checkUser($name))) {Write-Host "User does not exist"}
        else {
            $days = Read-Host -Prompt "Enter the number of days to check the logs for"
            $userLogins = getLogInAndOffs $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }

        # TODO: Change the above line in a way that, the days 90 should be taken from the user
        # done

    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if (-not (checkUser($name))) {Write-Host "User does not exist"}
        else {
            $days = Read-Host -Prompt "Enter the number of days to check the logs for"
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }

        # TODO: Check the given username with the checkUser function.
        # done

        # TODO: Change the above line in a way that, the days 90 should be taken from the user
        # done

    }

    elseif($choice -eq 9){

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

    else { Write-Host "Enter a number 1 through 10" }

    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    # done
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    # done
    

}




