;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
ls=ls --show-control-chars -F --color $*
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
~=cd /d "%home%"

gf=git fetch
gc=git checkout $1
gm=git commit -am $1
gl=git log --oneline --all --graph --decorate  $*
g1=git log -1 $*
gs=git status -uno

yp=mpv --profile=utube $*
ypr=mpv --profile=utube --no-resume-playback $*

ikti.srv=ssh bambang_ebis@10.126.12.212 -i %home%\.ssh\iktisrv_rsa
ikti.sql=mssql-cli -S 10.126.12.212 -U SA -P 0052DSI-ikti
ikti.tun.kambink=ssh -L 6800:10.107.1.252:6800 bambang_ebis@25.12.48.48
ikti.tun.omv=ssh -L 8888:10.126.12.75:80 bambang_ebis@25.12.48.48
