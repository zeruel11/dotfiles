;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
ll=ls --show-control-chars -F --color $* -l
la=ls --show-control-chars -F --color $* -la
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
unalias=alias /d $1
vi=vim $*
cmderr=cd /d "%CMDER_ROOT%"
...=cd ../../
.3=cd ../../../
.4=cd ../../../../
~=cd /d "C:\Users\zeruel11"

gf=git fetch
gc=git checkout $1
gm=git commit -am $*
gl=git log --oneline --all --graph --decorate  $*
g1=git log -1
gs=git status -uno

yp=mpv --no-video --shuffle $1

ikti.srv=ssh bambang_ebis@10.126.12.212 -i %home%\.ssh\iktisrv_id
ikti.sql=mssql-cli -S 10.126.12.212 -U SA -P 0052DSI-ikti
