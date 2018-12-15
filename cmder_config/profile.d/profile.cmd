:: use this file to run your own startup commands
:: use  in front of the command to prevent printing the command

REM call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd"
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"
@echo off

:: Setup win 10 default OpenSSH
C:\Windows\System32\OpenSSH\ssh-agent.exe
Set "MYKEY="
For /F "Tokens=5" %%A In ('C:\Windows\System32\OpenSSH\ssh-add -L 2^>^&1') Do If Not Defined MYKEY Set "MYKEY=%%~A"
If /I "%MYKEY%"=="identities." (
	Echo Adding zeruel's key...
    C:\Windows\System32\OpenSSH\ssh-add.exe
) 
set "MYKEY="

REM set "HOME=%DRIVE_LETTER%/Documents"

:: set vendor path
set "PATH=%CMDER_ROOT%\vendor\aria2;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\far_manager\;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\PSTools;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\phantomjs\bin;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\phantomjs\examples;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\graphviz\bin;%PATH%"
set "PATH=%CMDER_ROOT%\vendor\SysinternalsSuite;%PATH%"

:: set xampp env var
rem "E:\xampp\xampp_shell.bat" setenv
