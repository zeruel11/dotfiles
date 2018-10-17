# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

Set-Alias ll Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

Set-Alias -name "vim" -value "C:\Program Files\Git\usr\bin\vim.exe"

function gdg {
    git difftool -g $args[0] $args[1]
}

function gd {
    git difftool $args[0] $args[1]
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

Set-Alias -Name "pwsh" -Value "pwsh-preview"