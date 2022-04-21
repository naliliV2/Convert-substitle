#make a list of all mkv files in the todo directory
$list = @() # decalre the list
(Get-ChildItem -Path 'todo' ).BaseName | ForEach-Object{
    $list += $_ # fill the list for each gci output
}

foreach ($i in $list) {
    dep/mkclean.exe "todo\$($i).mkv" "temp\$($i)_clean.mkv"
}
