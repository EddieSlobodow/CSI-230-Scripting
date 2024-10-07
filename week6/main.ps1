. C:\Users\champuser\CSI-230-Scripting\week6\scrapingChamplain.ps1

$FullTable = daysTranslator(gatherClasses)

# List all the classes of Instructor Furkan Paligu
$FullTable | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             where { $_."Instructor" -ilike "Furkan Paligu" } | `
             Format-Table "Class Code", Instructor, Location, Days, "Time Start", "Time End"

# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Monday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code" | `
             Format-Table "Time Start", "Time End", "Class Code"

# Make a list of all ITS Instructors
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                             ($_."Class Code" -ilike "NET*") -or `
                                             ($_."Class Code" -ilike "SEC*") -or `
                                             ($_."Class Code" -ilike "FOR*") -or `
                                             ($_."Class Code" -ilike "CSI*") -or `
                                             ($_."Class Code" -ilike "DAT*") } `
                             | Sort-Object "Instructor" `
                             | select "Instructor" -Unique
$ITSInstructors | Format-Table "Instructor"

# Group all the instructors by the number of classes they are teaching
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending