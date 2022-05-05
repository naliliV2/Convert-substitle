<#
.SYNOPSIS
Extract subtitle from .mkv file
.Description
Extract all subtitle from .mkv file in the directory designated by user
.PARAMETER input
This is the directory of input all .mkv for extract the subtitle
.PARAMETER output
This is the directory of output all sub extracted
.NOTES
    Author:  nalili
    Version: Pre-Alpha 2.0
#>

Param(
    [Parameter(
        Mandatory,
        HelpMessage="Enter the folder you want to convert.")] 
    [Alias("input", "i", "dir", "directory")]
    [string[]]
    $input_dir,

    [Parameter(
        Mandatory,
        HelpMessage="Enter the folder where the files will go.")] 
    [Alias("output", "o")] 
    [string[]]
    $output_dir
)

#make a list of all mkv files in the todo directory
$list = @() # decalre the list
(Get-ChildItem -Path $output_dir).BaseName | ForEach-Object{
    $list += $_ # fill the list for each gci output
}

$nb = 0
#Start list
foreach($i in $list) {
    #make a percent and round it to 2 decimals
    $percent = [Math]::round(($nb/$list.Count)*100,2)

    Write-Progress -Activity "Extract sub video" -Status "$percent% Complete" -PercentComplete $percent 
    dep/mkvextract.exe $output_dir/$($i).mkv tracks -c utf-8 2:$output_dir/$($i)_sub.ass  >$null 2>&1
    $nb++
}
