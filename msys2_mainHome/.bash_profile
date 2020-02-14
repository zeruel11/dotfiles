#!/usr/bin/bash
# portabledevops.sh
# customized setting for msys2/cygwin64/mobaxterm
# By Robert Wang
# Oct 17, 2017

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi

# SSH Agent functions
#----------------------------

SSH_ENV="$HOME/.ssh/environment"

run_ssh_env() {
    . "${SSH_ENV}" >/dev/null
}

start_ssh_agent() {
    echo "Initializing new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
    echo -e "\e[32msucceeded\e[0m"
    chmod 600 "${SSH_ENV}"

    run_ssh_env

    ssh-add
    if [[ $(ssh-add -L) != *"$USERNAME/.ssh/git_rsa"* ]]; then
        if [ -f ~/.ssh/git_rsa ]; then
            echo -e "\e[33m"
            ssh-add ~/.ssh/git_rsa || echo "Key ignored"
            echo -e "\e[0m"
        elif [ ! -f ~/.ssh/git_rsa ] && [ -f $USERPROFILE/.ssh/git_rsa ]; then
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

ssh_check() {
    if [ -f "${SSH_ENV}" ]; then
        run_ssh_env
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
            start_ssh_agent
        }
    else
        start_ssh_agent
    fi
}

if [ ! -z $MSYS2_PATH_TYPE ]; then # check if MSYS2 or Git bash

    #
    # Section - env setup
    #

    # Paths setup
    export PORTSYS=$(uname | cut -d'_' -f1)

    if [ $PORTSYS = 'MSYS' ] || [ $PORTSYS = 'MINGW32' ] || [ $PORTSYS = 'MINGW64' ]; then
        if [ ! -d /home/$USERNAME ]; then
            mkdir -p /home/$USERNAME
        fi
        HOME=/home/$USERNAME
        export USERPROFILE=$HOME
        export HOMEPATH=$HOME
    fi

    cd $HOME

    export PORTFOLDER=$(cygpath -ml $(pwd) | rev | cut -d'/' -f4- | rev | cut -d: -f2-)
    export HOMEDRIVEL=$(cygpath -m $(pwd) | cut -d: -f1)
    export HOMEDRIVE=$HOMEDRIVEL:

    export PORTABLEPATH=/$HOMEDRIVEL$PORTFOLDER

    #
    # Section - portable application setup
    #

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
    if [ -d $PORTABLEPATH/msys64/mingw64 ]; then
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

    # ssh config setup
    if [ -f "$(cygpath $USERPROFILE)/.ssh/config" ] && [ -f "$HOME/.ssh/config" ]; then
        cmp -s "$HOME/.ssh/config" "$(cygpath $USERPROFILE)/.ssh/config" >/dev/null
        if [ $? -eq 1 ]; then
            echo -e "\e[34mSSH config differ, copying from main profile...\e[0m"
            cp -v "$(cygpath $USERPROFILE)/.ssh/config" "$HOME/.ssh/"
        fi
        echo -e "\e[34mSSH config loaded\e[0m"
    elif [ -f "$(cygpath $USERPROFILE)/.ssh/config" ] && [ ! -f "$HOME/.ssh/config" ]; then
        echo -e "\e[34mSSH config found on $(cygpath $USERPROFILE), copying...\e[0m"
        cp -v "$(cygpath $USERPROFILE)/.ssh/config" "$HOME/.ssh/"
    elif [ ! -f "$(cygpath $USERPROFILE)/.ssh/config" ] && [ -f "$HOME/.ssh/config" ]; then
        echo -e "\e[34mSSH config not found on main profile, using local. Not this may be out-of-date, consider checking.\e[0m"
    else
        echo -e "\e[31mSSH config missing\e[0m"
    fi

    # check vimrc
    if [ -f "$(cygpath $USERPROFILE)/.vimrc" ] && [ -f "$HOME/.vimrc" ]; then
        cmp -s "$HOME/.vimrc" "$(cygpath $USERPROFILE)/.vimrc" >/dev/null
        if [ $? -eq 1 ]; then
            echo -e "\e[34m.vimrc differ, copying from main profile...\e[0m"
            cp -v "$(cygpath $USERPROFILE)/.vimrc" "$HOME/"
        fi
    elif [ -f "$(cygpath $USERPROFILE)/.vimrc" ] && [ ! -f "$HOME/.vimrc" ]; then
        echo -e "\e[34m.vimrc found on $(cygpath $USERPROFILE), copying...\e[0m"
        cp -v "$(cygpath $USERPROFILE)/.vimrc" "$HOME/.ssh/"
    elif [ ! -f "$(cygpath $USERPROFILE)/.vimrc" ] && [ -f "$HOME/.vimrc" ]; then
        echo -e "\e[34m.vimrc found on local filesystem. Not this may be out-of-date, consider checking main profile.\e[0m"
    else
        echo -e "\e[31m.vimrc not found\e[0m"
    fi

    ssh_check # run ssh

    #
    # welcome message
    #
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
    ssh_check #run ssh

    echo -e "\e[34;102mGit Bash\e[0m"
fi
