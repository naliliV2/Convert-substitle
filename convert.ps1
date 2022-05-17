<#
.SYNOPSIS
This is a core of this project
.Description
This file allows you to manage everything
.PARAMETER input
This is the directory of input all .mkv for extract the subtitle
.PARAMETER output
This is the directory of output all .mkv merge with .srt
.PARAMETER Each
Todo

.NOTES
    Author:  nalili
    Version: Pre-Alpha 2.0
#>

Param(
    [Parameter(
        Mandatory,
        HelpMessage="Enter the folder you want to convert.")] 
    [Alias("input","i", "dir", "directory")]
    [string[]]
    $input_dir,

    [Parameter(
        HelpMessage="Enter the folder where the files will go.")] 
    [Alias("output", "o")] 
    [string[]]
    $output_dir,

    [Parameter(
        HelpMessage="Define if you want one by one or no (default is : not)"
    )]
    [Alias("each", "one")]
    [bool]
    $one_by_one = $false
)

#Verify if $output is empty, set it to $input (directory where the files are)
if ($null -eq $output_dir)
{
    $title = 'Overwrite the video'; $question = 'Are you sure you want to proceed?'; $choices = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
    if ($decision -eq 0) {$output_dir = $input_dir} 
    else {Write-Error "Cancellation of video processing"; exit}
}


if($one_by_one -eq $false -or $one_by_one -eq $null) 
{
    $TempDir = New-TemporaryDirectory

    src/clean_mkv.ps1 -dir $input_dir -output $TempDir
    src/extract_sub.ps1 -dir $TempDir -output $TempDir
    
    py ./src/exctract_sub_ass/main.py $TempDir 
    
    src/merge_mkv.ps1 -dir $TempDir -output $output_dir
    
    Remove-Item $TempDir -Recurse -Force
}
elseif ($one_by_one -eq $true)
{
    $files = Get-ChildItem -Path $input_dir -Recurse -Filter "*.mkv"   
    foreach ($file in $files)
    {
        $TempDir = New-TemporaryDirectory

        
        py ./src/exctract_sub_ass/main.py $TempDir 
        
        src/merge_mkv.ps1 -dir $TempDir -output $output_dir
        
        Remove-Item $TempDir -Recurse -Force
    }
}
else
{
    Write-Host "Error : $one_by_one is not a boolean"
}

Write-output "Completed"