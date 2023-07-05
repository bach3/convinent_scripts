@echo off
setlocal enabledelayedexpansion

set "target_directory=C:\path\to\folder"
set "current_date=%date:~0,10%"
set "counter=1"

for %%F in ("%target_directory%\*.jpg") do (
    set "file_name=%%~nF"
    set "file_extension=%%~xF"

    set "new_file_name=!file_name!-!counter!!file_extension!"
    ren "%%F" "!new_file_name!"
    
    set /a "counter+=1"
)
