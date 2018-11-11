# use this file to run your own startup commands for msys2 bash'

# To add a new vendor to the path, do something like:
# export PATH=${CMDER_ROOT}/vendor/whatever:${PATH}

#!/usr/bin/bash 
# portabledevops.sh
# customized setting for msys2/cygwin64/mobaxterm
# By Robert Wang
# Oct 17, 2017

#
# Section - env setup
#

export PORTSYS=`uname|cut -d'_' -f1`

if [ $PORTSYS = 'MSYS' ] || [ $PORTSYS = 'MINGW32' ] || [ $PORTSYS = 'MINGW64' ]; then
    if [ ! -d /home/$USERNAME ]; then
        mkdir -p /home/$USERNAME
    fi
    HOME=/home/$USERNAME
    export USERPROFILE=$HOME
    export HOMEPATH=$HOME
fi 

cd $HOME

export PORTFOLDER=`cygpath -ml \`pwd\`|rev|cut -d'/' -f4-|rev|cut -d: -f2-`
export HOMEDRIVEL=`cygpath -m \`pwd\` |cut -d: -f1`
export HOMEDRIVE=$HOMEDRIVEL:

export PORTABLEPATH=/$HOMEDRIVEL$PORTFOLDER

#
# Section - portable application setup 
#
# portable production tool

# portable netsnmp
if [ -d $PORTABLEPATH/netsnmp ]; then
    export PATH=$PORTABLEPATH/netsnmp/usr/bin:$PATH
fi

# portable Lua
if [ -d $PORTABLEPATH/Lua ]; then
    export LUA_DEV=$PORTABLEPATH/Lua/5.1
    #export LUA_PATH=$PORTABLEPATH/Lua/5.1/lua/?.luac
    export PATH=$LUA_DEV:$LUA_DEV/clibs:$PATH
    alias lua=$LUA_DEV/lua.exe
fi

# portable mingw64 on msys2
if [ -d $PORTABLEPATH/msys64/mingw64 ];then
    export PATH=$PORTABLEPATH/msys64/mingw64/bin:$PATH
fi

# portable nginx 
if [ -d $PORTABLEPATH/nginx ]; then
    export PATH=$PORTABLEPATH/nginx:$PATH
    alias nginxstart='cd $PORTABLEPATH/nginx; start nginx'
    alias nginxstop='cd $PORTABLEPATH/nginx; nginx -s stop'
    alias nmpstart='source $PORTABLEPATH/nginx/nmp_start.sh'
    alias nmpstop='source $PORTABLEPATH/nginx/nmp_stop.sh'
fi

# setup msys ssh-agent
eval $(ssh-agent)
ssh-add
ssh-add /c/Users/zeruel11/.ssh/iktisrv_id

# welcome 
echo
echo "Welcome to portabledevops"
echo "Platform: "$PORTSYS
echo "Home: "$HOME
echo "Portable path: "$PORTFOLDER
echo "Driver: "$HOMEDRIVEL
echo "Shortcut: alias|grep "$PORTFOLDER
date
echo