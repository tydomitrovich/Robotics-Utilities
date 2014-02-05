@echo off
title 3663 IP Switch
Color B

::----Thank You---http://www.cammckenzie.com/-----For Your Code-----------------------------------------------------------------------------
::REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

::REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
::------------------------------------------------------------------------------------------------------

if exist "C:\IpSwitchTemp.txt" goto :start 
goto :NetName 

:NetName
	
	set /p NetName="Please enter the name of the network adapter you wish to edit:"
	echo %NetName% > C:\IpSwitchTemp.txt
	
:start
	cls
	FOR /f "tokens=14 delims= " %%a IN ('IPCONFIG ^| FINDSTR IPv4') DO (
	SET ip=%%a
	)
	set /p NetName=<C:\IpSwitchTemp.txt
	cls
	echo ////////////////////////////////////////////
	echo *           TEAM 3663 IP SWITCH            *
	echo *                   BY:                    *
	echo *            TYLER DOMITROVICH             *
	echo ////////////////////////////////////////////
	echo *------------------------------------------*
	echo *-----------Your-Current-IP-Is:------------*
    echo *               %ip% 
	echo *               %NetName%
	echo *------------------------------------------*
	echo *------------------MENU--------------------*
	echo *------------1-Set Static IP---------------*
	echo *------------2-Reset to DHCP---------------*
	echo *------------3-Set Network Connection Name-*
	echo *------------4-Exit------------------------*
	echo *------------------------------------------*
	
	
	set /p Choice=Make Selection: 
	if %Choice%==1 goto SetStaticIP
	if %Choice%==2 goto SetDHCP
	if %Choice%==3 goto SetNetName
	if %Choice%==4 EXIT
	cls
	echo Invalid Selection. Please Choose One Of The Listed Options
	pause
	goto start
	
:SetStaticIP
	cls
	set ip=
	echo Please Enter a Number Between 5 and 100 That Nobody Else Has Chosen:
	set /P NUM="" 
	set STATIC_IP=10.36.63.%NUM%
	netsh interface ip set address name="Wireless Network Connection" static %STATIC_IP% 255.0.0.0 10.36.63.1
	::echo %NetName%
	if errorlevel 0 (echo Your IP is now ^set to %STATIC_IP%)
	if errorlevel 2 (goto ERROR)
	set ip=%STATIC_IP%
	pause
	goto start
	
:SetDHCP
	cls
	set ip=
	netsh interface ip set address name="Wireless Network Connection" source=dhcp
	if errorlevel 0 (echo You Are Now Using DHCP!)
	if errorlevel 2 (goto ERROR)
	pause
	goto start
:SetNetName
	cls
	echo Please Enter the Name of Your Network Connection
	set /p NetworkName=
	echo Network Name Saved
	pause
	goto start
	
:ERROR
	cls
	echo An error occured. Try running this as admin and check the name of your network connnection.
	echo This program will now close. Peace Out!
	echo --------------------------------------------------------------------------------
	echo 		."".    ."",
	echo 		^|  ^|   /  /
	echo 		^|  ^|  /  /
	echo 		^|  ^| /  /
	echo 		^|  ^|/  ;-._ 
	echo 		}  ` _/  / ;
	echo 		^|  /` ) /  /
	echo 		^| /  /_/\_/\
	echo 		^|/  /      ^|
	echo 		(  ' \ '-  ^|
	echo 	 	\    `.  /
	echo 	 	 ^|      ^|
	echo 	 	 ^|      ^|
	echo -------------------------------------------------------------------------------
	pause
	Exit
	
