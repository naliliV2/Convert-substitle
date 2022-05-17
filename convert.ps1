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

function New-TemporaryDirectory() { 
    <#
        .DESCRIPTION
        Create a temp dir 
    #>
    
    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

function treatement_video($input_dir, $output_dir) {
    <#
        .DESCRIPTION
        processes the MKV
        .PARAMETER input_dir
        Todo 
        .PARAMETER output_dir
        Todo
    #>

    $TempDir = New-TemporaryDirectory #Create temp dir

    src/clean_mkv.ps1 -dir $input_dir -output $TempDir #Clean the MKV for take less stockage
    src/extract_sub.ps1 -dir $TempDir -output $TempDir #Extract sub in the mkv

    py ./src/exctract_sub_ass/main.py $TempDir #Start the conversion
    
    src/merge_mkv.ps1 -dir $TempDir -output $output_dir #Merge the convertion in the video 
    
    Remove-Item $TempDir -Recurse -Force #Remove temp dir 
}

function main() {

    #Verify if $output is empty, set it to $input (directory where the files are)
    if ($null -eq $output_dir)
    {
        $title = 'Overwrite the video'; $question = 'Are you sure you want to proceed?'; $choices = '&Yes', '&No'

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1) #Ask to the user if he is sure to choose input_dir to output_dir 
        if ($decision -eq 0) {$output_dir = $input_dir} 
        else {Write-Error "Cancellation of video processing"; exit}
    }


    if($one_by_one -eq $false -or $one_by_one -eq $null) 
    {
        treatement_video($input_dir, $output_dir)
    }
    elseif ($one_by_one -eq $true)
    {
        $files = Get-ChildItem -Path $input_dir -Recurse -Filter "*.mkv"   
        foreach ($file in $files)
        {
            treatement_video($file, $output_dir)
        }
    }
}

main()
Write-output "Completed"