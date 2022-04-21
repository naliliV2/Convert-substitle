#make a list of all mkv files in the todo directory
$list = @() # decalre the list
(Get-ChildItem -Path 'temp').BaseName | ForEach-Object{
    $list += $_ # fill the list for each gci output
}

#Start list
foreach($i in $list) {
    dep/mkvextract.exe temp/$($i).mkv tracks -c utf-8 2:temp/$($i)_sub.txt
}