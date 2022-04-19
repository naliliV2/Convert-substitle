#make a list of all mkv files in the todo directory
$list = @() # decalre the list
(Get-ChildItem -Path 'todo' ).Name | ForEach-Object{
    $list += $_ # fill the list for each gci output
}

#Start list
foreach ($i in $list) {
    dep/mkclean.exe "todo\$i" ".\temp\$($i)_clean.mkv"
}
