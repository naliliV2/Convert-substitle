src/clean_mkv.ps1
src/extract_sub.ps1

Clear-Host

py src/clean_sub/main.py 

Clear-Host

src/merge_mkv.ps1

Clear-Host

Write-output "Completed"