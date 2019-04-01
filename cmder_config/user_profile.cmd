:: use this file to run your own startup commands
:: use  in front of the command to prevent printing the command

:: uncomment this to have the ssh agent load when cmder starts
call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd"

:: uncomment this next two lines to use pageant as the ssh authentication agent
:: SET SSH_AUTH_SOCK=/tmp/.ssh-pageant-auth-sock
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-pageant.cmd"

:: you can add your plugins to the cmder path like so
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"

@echo off

:: Setup Git for Windows OpenSSH
REM ssh-agent.exe
Set "MYKEY="
For /F "Tokens=5" %%A In ('ssh-add -L 2^>^&1') Do If Not Defined MYKEY Set "MYKEY=%%~A"
If /I "%MYKEY%"=="identities." (
	IF EXIST "%userprofile%\.ssh\id_rsa" (
        ECHO Adding zeruel's key...
        ssh-add.exe
    )
    IF EXIST "%userprofile%\.ssh\git_rsa" (
        ECHO Adding Git key...
        ssh-add.exe %userprofile%\.ssh\git_rsa
    )
    IF EXIST "%userprofile%\.ssh\iktisrv_rsa" (
        ECHO Adding IKTI server key...
        ssh-add.exe %userprofile%\.ssh\iktisrv_rsa
    )
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