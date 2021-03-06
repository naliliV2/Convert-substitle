<#
.SYNOPSIS
Clean MKV
.Description
tool to clean and optimize Matroska
.PARAMETER input
This is the directory of input all .mkv for cleaning
.PARAMETER output
This is the directory of output all .mkv clean
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
    $output_dir,

    [parameter(
        HelpMessage="Set True if input is a file, False or null if input is a directory.")]
    [Alias("each", "e")]
    [bool]
    $one_file = $False
)

#make a list of all mkv files in the $input_dir
if ($one_file -eq $False -or $one_file -eq $null) {
    $list_video = @() # decalre the list
    (Get-ChildItem -Path $input_dir ).BaseName | ForEach-Object{
        $list_video += $_ # fill the list for each gci output
    }

    $nb = 0
    foreach ($i in $list_video) {
        #make a percent and round it to 2 decimals
        $percent = [Math]::round(($nb/$list_video.Count)*100,2)

        Write-Progress -Activity "Cleaning the video" -Status "$percent% Complete" -PercentComplete $percent 
        dep/mkclean.exe "$($input_dir)\$($i).mkv" "$($output_dir)\$($i)_clean.mkv" >$null 2>&1
        $nb++
    }
}

elseif ($one_file -eq $True) {
    dep/mkclean.exe "$($input_dir)" "$($output_dir)\$((Get-ChildItem -File $input_dir).BaseName)_clean.mkv" >$null 2>&1
}
else {
    Write-Error "The parameter 'one file' is not a boolean."
}