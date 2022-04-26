#make a list of all mkv files in the todo directory
$list_sub = @() # decalre the list
(Get-ChildItem -Path temp\* -Include *.srt).Name | ForEach-Object{
    $list_sub += $_ # fill the list for each gci output
}

$list_video = @() # decalre the list
(Get-ChildItem -Path temp\* -Include *.mkv).Name | ForEach-Object{
    $list_video += $_ # fill the list for each gci output
}

for ($i = 0; $i -lt $list_video.Count; $i++) {
    .\dep\mkvmerge.exe -o finish/$($list_video[$i]) ./temp/$($list_video[$i]) ./temp/$($list_sub[$i])
}

Remove-Item temp/**