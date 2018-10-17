# Use this file to run your own startup commands

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# function Notify-Job {
#     Register-ObjectEvent $j StateChanged -Action {
#         [Console]::Beep(1000,500)
#         Write-Host ('Job #{0} ({1}) complete.' -f $sender.Id, $sender.Name) -Fore White -Back Red
#         Write-Host 'Use this command to retrieve the results:'
#         Write-Host (prompt) -noNewLine
#         Write-Host ('Receive-Job -ID {0}; Remove-Job -ID {0}' -f $sender.Id)
#         Write-Host (prompt) -noNewLine
#         $eventSubscriber | Unregister-Event
#         $eventSubscriber.Action | Remove-Job
#     } | Out-Null
# }

###############################################################################
# psreadline
# Adapted from https://dl.dropboxusercontent.com/u/41823/psh/Profile.txt
# http://www.reddit.com/r/sysadmin/comments/1rit4l/what_do_you_get_when_you_cross_bash_with_cmdexe/cdo3djk
###############################################################################
Import-Module PSReadline

Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -MaximumHistoryCount 100

Set-PSReadlineKeyHandler -Key Ctrl+Delete       -Function KillWord
Set-PSReadlineKeyHandler -Key Ctrl+Backspace    -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key Shift+Backspace   -Function BackwardKillWord

# history substring search
Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion
Set-PSReadlineKeyHandler -Key   Tab         -Function MenuComplete
Set-PSReadlineKeyHandler -Chord 'Shift+Tab' -Function Complete

$Host.PrivateData.ErrorBackgroundColor      = $Host.UI.RawUI.BackgroundColor
$Host.PrivateData.WarningBackgroundColor    = $Host.UI.RawUI.BackgroundColor
$Host.PrivateData.VerboseBackgroundColor    = $Host.UI.RawUI.BackgroundColor

Import-Module Get-ChildItemColor
Import-Module posh-git

$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText = '] '

# workaround for posh-git with win10 OpenSSH
if ($env:SSH_AGENT_PID){
    Remove-Item env:\SSH_AGENT_PID
}
if ($env:SSH_AUTH_SOCK){
    Remove-Item env:\SSH_AUTH_SOCK
}

# Import-Module DockerCompletion
Import-Module posh-docker

# setup win10 OpenSSH
if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue | Where-Object {$_.Status -match 'Stopped'}) {
    Write-Host Starting ssh-agent...
    Start-Service ssh-agent
    } else {
        Write-Host "SSH-agent service already started"
    }
$TestSSHmykey = C:\WINDOWS\System32\OpenSSH\ssh-add.exe -L
switch -Wildcard ($TestSSHmykey) {
    ({-Not ( $TestSSHmykey -like '*zeruel11/.ssh/id_rsa*')})
    {
        Write-Host "Adding zeruel's identity..."
        ssh-add
    }

    ({-Not ($TestSSHmykey -like '*zeruel11\.ssh\iktisrv_id*')})
    {
        Write-Host "Adding server keys..."
        ssh-add C:\Users\zeruel11\.ssh\iktisrv_id
    }

    default
    {
        Write-Host 'identities loaded'
    }
}
# if( -Not ($TestSSHmykey -like '*zeruel11/.ssh/id_rsa*') ) {
#     # Write-Host found
#     C:\WINDOWS\System32\OpenSSH\ssh-add.exe
# } else {
#     Write-Host 'my-ssh-key already loaded'
# }
Remove-Variable TestSSHmykey

# set color
# $l = [ConsoleColor]::DarkCyan
$c = [ConsoleColor]::Cyan
$b = [ConsoleColor]::Gray
$h = [ConsoleColor]::DarkGray
###############################################################################