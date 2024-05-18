@echo off
cls
ping localhost -n 3 >nul

:bootloader
if exist "%userprofile%\desktop\CommandPower\CommandPower.bat" (
    goto restartcp
) else (
    echo You Don't Have Any OS
    pause
    exit
)

:restartcp
for /f "usebackq delims=" %%a in ("c:\CommandPower\Sys32\STOP.txt") do (
    if /i "true"=="%%a" (
        rmdir /s /q "c:\CommandPower"
        goto startcp
    )
)
goto startcp

:startcp
mkdir "c:\CommandPower"
mkdir "c:\CommandPower\user"
mkdir "c:\CommandPower\home"
mkdir "c:\CommandPower\Sys32"
mkdir "c:\CommandPower\SecSys32"
mkdir "c:\CommandPower\SecSys32\CommandsLock"
echo ARTIK> "c:\CommandPower\SecSys32\CommandsLock\CommandLock1.txt"
echo false> "c:\CommandPower\Sys32\STOP.txt"
set sourceFolder=%userprofile%\Desktop\CommandPower
set destinationFolder=c:\CommandPower\Sys32
robocopy "%sourceFolder%" "%destinationFolder%" /e
cls
goto bootcp

:bootcp
set "cp_file=c:\CommandPower\Sys32\CommandPower.bat"
if not exist "%cp_file%" (
    echo Error: %cp_file% not found.
    goto home
)

echo.
echo 1. CommandPower
set /p inp="Enter Number: "
if /i "%inp%"=="1" goto bootcp_commandpower
goto home

:bootcp_commandpower
start "CommandPower" "c:\CommandPower\Sys32\CommandPower.bat"
exit

:home
pause
exit
