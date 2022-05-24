#Justin Jans ID#009457058

Function Show-Menu{
    param (
        [string]$Title = 'Menu'
    )
    Clear-Host
    Write-Host "=================== $Title ====================="

    Write-Host "1: Press for this option"
    Write-Host "2: Press for this option"
    Write-Host "3: Press for this option"
    Write-Host "4: Press for this option"
    Write-Host "5: Press for this option"
}


do {
    Show-Menu
    $selection = Read-Host "Please Make a selection"
    switch ($selection)
    {
        '1' {
            'You chose option 1'
        }
        '2' {
            'You chose option 2'
        }
        '3' {
            'You chose option 3'
        }
        '4' {
            'You chose option1'
        }
    }
    pause
}
until ($selection -eq '5')