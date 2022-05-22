<#
.SYNOPSIS
Merge .srt file into .mkv file
.Description
Merge .srt file into .mkv file and save it as .mkv file
.PARAMETER input
The folder containing all .mkv and .srt files in alphabetical order 
.PARAMETER output
The folder where the merged .mkv files will be saved
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
$list_sub = @() # decalre the list
(Get-ChildItem -Path $input_dir\* -Include *.srt).Name | ForEach-Object{
    $list_sub += $_ # fill the list for each gci output
}

$list_video = @() # decalre the list
(Get-ChildItem -Path $input_dir\* -Include *.mkv).Name | ForEach-Object{
    $list_video += $_ # fill the list for each gci output
}

for ($i = 0; $i -lt $list_video.Count; $i++) {
    #make a percent and round it to 2 decimals
    $percent = [Math]::round(($i/$list_video.Count)*100,2)

    Write-Progress -Activity "Merge .SRT in .MKV" -Status "$percent% Complete" -PercentComplete $percent 

    .\dep\mkvmerge.exe -o $output_dir\$($list_video[$i]) $input_dir\$($list_video[$i]) $input_dir\$($list_sub[$i]) >$null 2>&1
}