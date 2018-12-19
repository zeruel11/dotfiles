# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

Set-Alias ll Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

Set-Alias -name "vim" -value "C:\Program Files\Git\usr\bin\vim.exe"

function gdg {
    git difftool -g --dir-diff $args[0] $args[1]
}

function gd {
    git difftool $args[0] $args[1]
}

function gf {
    git fetch
}

function gs {
    git status -uno
}

function g1 {
    git log -1
}

function glog {
    git log --oneline --all --graph --decorate $args
}

function gc {
    git checkout $args[0]
}

function gmt {
    param([string]$msg="placeholder")
    git commit -am $msg
}

function ikti.sql {
    mssql-cli.bat -S 10.126.12.212 -U SA -P 0052DSI-ikti
}

function ikti.srv {
    ssh bambang_ebis@10.126.12.212 -i ~\.ssh\iktisrv_id
}

# function ikti.con {
#     New-PSSession -Name ikti.pwsh -HostName 10.126.12.212 -UserName bambang_ebis -KeyFilePath C:\Users\zeruel11\.ssh\iktisrv_id -SSHTransport
#     Set-Variable -Name s -Value (Get-PSSession -Name ikti.pwsh)
# }

# function ikti.cls {
#     Remove-PSSession -Name ikti.pwsh
#     Remove-Variable s
# }

function mag2tor {
    aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 $args[0]
}

Set-Alias -Name "pwsh" -Value "pwsh-preview"