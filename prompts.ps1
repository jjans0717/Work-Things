#Justin Jans ID#009457058

#defines Menu Funtion
Function Show-Menu{
    <#
    .SYNOPSIS
        Fucntion to display menu and collect input
    #>

    $Menu = New-Object -TypeName System.Text.StringBuilder
    [void]$Menu.AppendLine("...Menu Options....")
    [void]$Menu.AppendLine("-------------------")
    [void]$Menu.AppendLine("1. Option 1")
    [void]$Menu.AppendLine("2. Option 2")
    [void]$Menu.AppendLine("3. List Current CPU and Memory Usage")
    [void]$Menu.AppendLine("4. Get Running Processes")
    [void]$Menu.AppendLine("5. Exit")
    [void]$Menu.AppendLine("-------------------")
    Write-Host -ForegroundColor Cyan $Menu.ToString()
    return $(Write-Host -ForegroundColor Cyan ">> Select a command (1-5)"; Read-Host)
}

#loop that calls menu and executes user options
$UserInput = 1
Try {
    While ($UserInput -ne 5)
    {
        $UserInput = Show-Menu
        switch ($UserInput)
        {
            1 #User chose option 1 
            {
                Write-Host 'You chose option 1'
            }
            2 #User chose option 2
            {
                'You chose option 2'
            }
            3 #List CPU and Memory usage
            {
                #variable that defines what we are looking for
                $CounterList = "\Processor(_Total)\% Processor Time","\Memory\Committed Bytes"
                #Get counters Interval 5 and Samples 4
                Get-Counter $CounterList -SampleInterval 5 -MaxSamples 4
            }
            4 #Get running processes
            {
                Get-Process | Select-Object ID, Name, VM | Sort-Object Name | Out-GridView
            }
        }
    }
}

#Out of Memory Error Handline
Catch [System.OutOfMemoryException]
{
    Write-Host -ForegroundColor REd "System out of memory"
}
#Any other errors
Catch
{
   Write-Host -ForegroundColor Red "Something Broke, sorry!"
}
Finally
{

}