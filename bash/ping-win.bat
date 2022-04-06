@setlocal enableextensions enabledelayedexpansion

@echo off
set COUNT=1000
set i=1
set ipaddr=%1
set oldstate=neither
set filename=%date:~0,10%.log
set filename=ping-%filename:/=-%
echo %filename%

echo "the ping starting" > ./%filename%
:loop
set state=down
for /f "tokens=9 delims= " %%a in ('ping -n 1 !ipaddr! ^| find "%%"') do (
    if "x%%a"=="x(0%%" set state=up
)
::echo.state is !state!

if not !state!==!oldstate! (
	echo !date!-!time! ping !ipaddr! link !oldstate! to !state!
	set /a i+=1
	echo %time% >> ./%filename%
    echo "ping !ipaddr! Link is !state!" >> ./%filename%
    set oldstate=!state!
	if !i! geq !COUNT! (exit 0)
)
ping -n 2 127.0.0.1 >nul: 2>nul:
goto :loop



endlocal