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
    [void]$Menu.AppendLine("1. Get List of all Log Files")
    [void]$Menu.AppendLine("2. Get List of all Files in Folder")
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
                #Append Date File is created
                Get-Date | Out-file -FilePath $PSScriptroot\DailyLog.txt -Append
                #List log files and append to DailyLog.txt
                Get-ChildItem -Path $PSScriptRoot -Filter *.log | Out-File -FilePath $PSScriptRoot\DailyLog.txt -Append
                
            }
            2 #User chose option 2
            {
                #List of all files in folder in Tabular format and sorted in Ascending alpahabet into C916contects.txt
                Get-ChildItem "$PSScriptRoot" | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-File -FilePath "$PSScriptRoot\C916contents.txt"
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
                #Get running process and sort them and output to Grid format
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