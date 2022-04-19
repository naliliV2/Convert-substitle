@echo off
setlocal enabledelayedexpansion

::Create a list
 
set increment = 0
for %%i in (todo/*) do (
    set list[!increment!]=%%i
    echo %%i

    set /a increment=!increment! + 1
)

for /L %%i in (0, 1, !increment!+1) do (
    "dep/mkclean.exe" "todo/!list[%%i]!" "temp/!list[%%i]!_clean.mkv"
)