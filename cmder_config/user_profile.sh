#!/usr/bin/bash 
# portabledevops.sh
# customized setting for msys2/cygwin64/mobaxterm
# By Robert Wang
# Oct 17, 2017

#
# Section - env setup
#

if [ ! -z $MSYS2_PATH_TYPE ]; then

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
    # if ps -p $SSH_AGENT_PID > /dev/null;then
    #     echo "ssh-agent is already running"
        # Do something knowing the pid exists, i.e. the process with $PID is running
    # else
    #     eval `ssh-agent -s`
    # fi

    # if ssh-add -l | grep "SHA256:MXHtgmmVu2R86ETctjMynhamGFzwk5hJBXD+Px/iht4";then
    #     echo "private key exist"
    # else
    #     ssh-add
    # fi
    # if ssh-add -l | grep "SHA256:OrziisUbHqke9uXNTKVPQyS9eTSootRp/q0vq9tSwwo";then
    #     echo "server key exist"
    # else
    #     ssh-add /c/Users/zeruel11/.ssh/iktisrv_id
    # fi

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
else
    echo -e "\e[34;102mGit Bash\e[0m"
fi

# Start SSH Agent
#----------------------------

SSH_ENV="$HOME/.ssh/environment"

function run_ssh_env {
    . "${SSH_ENV}" > /dev/null
}

function start_ssh_agent {
    echo "Initializing new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo -e "\e[32msucceeded\e[0m"
    chmod 600 "${SSH_ENV}"

    run_ssh_env;

    # ssh-add
    if [[ $(ssh-add -L) != *"$USERPROFILE/.ssh/git_rsa"* ]]; then
        if [ -f ~/.ssh/git_rsa ]; then
            echo -e "\e[33m"
            ssh-add ~/.ssh/git_rsa || echo "Key ignored"
            echo -e "\e[0m"
        elif [ -f $USERPROFILE/.ssh/git_rsa ]; then
            echo -e "\e[33m"
            ssh-add $USERPROFILE/.ssh/git_rsa || echo "Key ignored"
            echo -e "\e[0m"
        fi
    fi
    if [[ $(ssh-add -L) != *"$USERPROFILE/.ssh/iktisrv_rsa"* ]] && [ ! -z $MSYS2_PATH_TYPE ]; then
        if [ -f ~/.ssh/iktisrv_rsa ]; then
            echo -e "\e[33m"
            ssh-add ~/.ssh/iktisrv_rsa || echo "Key ignored"
            echo -e "\e[0m"
        elif [ -f $USERPROFILE/.ssh/iktisrv_rsa ]; then
            echo -e "\e[33m"
            ssh-add $USERPROFILE/.ssh/iktisrv_rsa || echo "Key ignored"
            echo -e "\e[0m"
        fi
    fi
}

if [ -f "${SSH_ENV}" ]; then
    run_ssh_env;
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_ssh_agent;
    }
else
    start_ssh_agent;
fi