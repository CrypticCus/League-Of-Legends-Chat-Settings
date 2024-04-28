:: Starting Parameters
@echo off & color a & chcp 1254 & mode con: cols=55 lines=11 & title League Of Legends Chat Settings & setlocal enabledelayedexpansion & cls
SET "T_Reset=[0m" & SET "T_Bold=[1m"&SET "T_UnderLine=[4m"&SET "T_Inverse=[7m"&SET "C_Red=[91;40m"&SET "C_Green=[92;40m"&SET "C_Yellow=[93;40m"&SET "C_Blue=[94;40m"&SET "C_Magenta=[95;40m"&SET "C_Cyan=[96;40m"&SET "C_White=[97;40m"

:: Run As Administrator
>nul reg add hkcu\software\classes\.Admin\shell\runas\command /f /ve /d "cmd /x /d /r set \"f0=%%2\" &call \"%%2\" %%3" &set _= %*
>nul fltmc || if "%f0%" neq "%~f0" ( cd.>"%tmp%\runas.Admin" &start "%~n0" /high "%tmp%\runas.Admin" "%~f0" "%_:"=""%" &exit /b )

:: Start From Here
:begin
cls

echo  %C_Red%_____________________________________________________%C_Green%
echo.
echo                   %C_Red%LoL Chat Settings%C_Green%
echo       %C_Red%Please Run As Administrator And Disable UAC%C_Green%
echo  %C_Red%_____________________________________________________%C_Green%
echo.
echo  League Of Legends Chat Settings
echo  1) %C_Red%Chat Allowed%C_Green%
echo  2) %C_Red%Chat Blocked%C_Green%
echo.

SET INPUT=
SET /P INPUT= Type Your Decision:

IF /I '%INPUT%'=='1' GOTO unblock
IF /I '%INPUT%'=='2' GOTO block
IF /I '%INPUT%'=='exit' GOTO exit
IF /I '%INPUT%'=='close' GOTO exit
GoTo Begin 

:unblock
netsh advfirewall firewall delete rule name="LOLChatAllowed" >Nul 2>&1
netsh advfirewall firewall delete rule name="LOLChatBlocked" >Nul 2>&1
netsh advfirewall firewall add rule name="LOLChatAllowed" dir=out remoteport=5223 protocol=TCP action=allow profile=any >Nul 2>&1
netsh advfirewall firewall add rule name="LOLChatAllowed" dir=in remoteport=5223 protocol=TCP action=allow profile=any >Nul 2>&1
GoTo begin

:block
netsh advfirewall firewall delete rule name="LOLChatAllowed" >Nul 2>&1
netsh advfirewall firewall delete rule name="LOLChatBlocked" >Nul 2>&1
netsh advfirewall firewall add rule name="LOLChatBlocked" dir=out remoteport=5223 protocol=TCP action=block profile=any >Nul 2>&1
netsh advfirewall firewall add rule name="LOLChatBlocked" dir=in remoteport=5223 protocol=TCP action=block profile=any >Nul 2>&1
GoTo begin

:exit
cls & exit