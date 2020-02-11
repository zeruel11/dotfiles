# Use this file to run your own startup commands

## Prompt Customization
<#
.SYNTAX
    <PrePrompt><CMDER DEFAULT>
    λ <PostPrompt> <repl input>
    <PrePrompt>N:\Documents\src\cmder [master]
    λ <PostPrompt> |
#>

[ScriptBlock]$PrePrompt = {
    Write-VcsStatus

    if (Test-Administrator) {
        # if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

    if ($s -ne $null) {
        # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    if ($j -ne $null) {
        # job notify
        Write-Host " (`$j::" -NoNewline -ForegroundColor DarkGray
        Write-Host "$($j.Name): " -NoNewline -ForegroundColor Yellow
        Write-Host "$($j.State)" -NoNewline -ForegroundColor Blue
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    Write-Host " | " -NoNewline -ForegroundColor DarkGray
}

# Replace the cmder prompt entirely with this.
[ScriptBlock]$CmderPrompt = {
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower())) {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewline -ForegroundColor Red
    Write-Host " | " -NoNewline -ForegroundColor DarkGray
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
}

[ScriptBlock]$PostPrompt = {
    Write-Host '[' -NoNewline -ForegroundColor $b
    Write-Host $(Get-History).Count -NoNewline -ForegroundColor $h
    Write-Host ']' -NoNewline -ForegroundColor $b
    "$('>' * ($nestedPromptLevel + 1)) "
}

[ScriptBlock]$Prompt = {
    $realLASTEXITCODE = $LASTEXITCODE
    $host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
    PrePrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    CmderPrompt
    Microsoft.PowerShell.Utility\Write-Host "`nλ " -NoNewLine -ForegroundColor "DarkGray"
    PostPrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}

# Once Created these code blocks cannot be overwritten
Set-Item -Path function:\PrePrompt   -Value $PrePrompt   -Options Constant
Set-Item -Path function:\CmderPrompt -Value $CmderPrompt -Options Constant
Set-Item -Path function:\PostPrompt  -Value $PostPrompt  -Options Constant

# Functions can be made constant only at creation time
# ReadOnly at least requires `-force` to be overwritten
Set-Item -Path function:\prompt  -Value $Prompt  -Options ReadOnly

## <Continue to add your own>

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

Set-PSReadLineKeyHandler -Key Ctrl+Delete       -Function KillWord
Set-PSReadLineKeyHandler -Key Ctrl+Backspace    -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Shift+Backspace   -Function BackwardKillWord

# history substring search
Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion
Set-PSReadLineKeyHandler -Key   Tab         -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Shift+Tab' -Function Complete

$Host.PrivateData.ErrorBackgroundColor = $Host.UI.RawUI.BackgroundColor
$Host.PrivateData.WarningBackgroundColor = $Host.UI.RawUI.BackgroundColor
$Host.PrivateData.VerboseBackgroundColor = $Host.UI.RawUI.BackgroundColor

Import-Module Get-ChildItemColor
Import-Module posh-git

$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText = '] '

if (Get-Module PSReadline -ErrorAction "SilentlyContinue") {
    Set-PSReadlineOption -ExtraPromptLineCount 1
}

# Import-Module DockerCompletion
# Import-Module posh-docker

# setup win10 OpenSSH
# workaround for posh-git with win10 OpenSSH
# if ($env:SSH_AGENT_PID){
#     Remove-Item env:\SSH_AGENT_PID
# }
# if ($env:SSH_AUTH_SOCK){
#     Remove-Item env:\SSH_AUTH_SOCK
# }

# start win10 OpenSSH
# if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue | Where-Object {$_.Status -match 'Stopped'}) {
#     Write-Host Starting ssh-agent...
#     Start-Service ssh-agent
#     } else {
#         Write-Host "SSH-agent service already started"
#     }

# start Git for Windows OpenSSH
Start-SshAgent
$TestSSHmykey = ssh-add.exe -L
switch -Wildcard ($TestSSHmykey) {
    ( { -Not ( $TestSSHmykey -Like "*$env:USERPROFILE\.ssh\git_rsa*") }) {
        if (Test-Path -Path "$env:USERPROFILE\.ssh\git_rsa") {
            Write-Host "Adding zeruel Git identity..."
            Add-SshKey (Resolve-Path ~\.ssh\git_rsa)
        } else {
            Write-Host "Git ssh key not found"
        }
    }

    ( { -Not ($TestSSHmykey -like "*$env:USERNAME\.ssh\iktisrv_rsa*") }) {
        if (Test-Path -Path "$env:USERPROFILE\.ssh\git_rsa") {
            Write-Host "Adding IKTI server keys..."
            Add-SshKey (Resolve-Path ~\.ssh\iktisrv_rsa)
        } else {
            Write-Host "IKTI server keys not found"
        }
    }

    default {
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

function U
{
    param
    (
	    [int] $Code
	)

	if ((0 -le $Code) -and ($Code -le 0xFFFF))
	{
		return [char] $Code
	}

	if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
	{
		return [char]::ConvertFromUtf32($Code)
	}

	throw "Invalid character code $Code"
}

function cddash {
    if ($args[0] -eq '-') {
        $pwd = $OLDPWD;
    }
    else {
        $pwd = $args[0];
    }
    # check whether path contains character needs escaping
    $tmp = $(Get-Location) -replace '\[', '`[' `
        -replace '\]', '`]';

    if ($pwd) {
        Set-Location $pwd;
    }
    Set-Variable -Name OLDPWD -Value $tmp -Scope global;
}

Set-Alias -Name cd -value cddash -Option AllScope

# Enhance with MEGAcmd
if (Test-Path "$env:LOCALAPPDATA\MEGAcmd") {
    $env:PATH += ";$env:LOCALAPPDATA\MEGAcmd"
}


# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

Set-Alias ll Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

Set-Alias -name "vim" -value "C:\Program Files\Git\usr\bin\vim.exe"

###scoops
function sst {
    scoop.ps1 status
}
function sup {
    scoop.ps1 update
}
function s8 {
    scoop.ps1 update *
}
function ss {
    scoop.ps1 search $args[0]
}

###gits
function gdg {
    git.exe difftool -g --dir-diff $args[0] $args[1]
}
function gd {
    git.exe difftool $args[0] $args[1]
}
function gf {
    git.exe fetch
}
function gs {
    git.exe status -uno
}
function gr {
    param([string]$ResetPath = ".")
    git.exe reset HEAD $ResetPath
}
function g. {
    param([string]$AddPath = ".")
    git.exe add $AddPath
}
function g1 {
    git.exe log -1
}
function glog {
    git.exe log --oneline --all --graph --decorate $args
}
function gce {
    git.exe checkout $args[0]
}
function gmt {
    param([string]$CommitMessage = "placeholder")
    git.exe commit -am $CommitMessage
}

###docker
function dps {
    docker container ls -a
}
function dst {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$ContainerName = $args
    )
    foreach ($i in $ContainerName) {
        if ((docker container ls -a | grep -w $i) -ne $null) {
            if ((docker exec $i id) -eq $null) {
                Write-Host "Container $i not running. Starting..."; docker start $i
            }
            else {
                Write-Host "Container $i already running. Stopping..."; docker stop $i
            }
        }
        else {
            Write-Warning "Container $i doesn't exist"
        }
    }
}

###server connect
function ikti.sql {
    mssql-cli.bat -S 10.126.12.212 -U SA -P 0052DSI-ikti
}
function ikti.srv {
    ssh.exe bambang_ebis@10.126.12.212 -i (Resolve-Path ~\.ssh\iktisrv_rsa)
}

# function ikti.con {
#     New-PSSession -Name ikti.pwsh -HostName 10.126.12.212 -UserName bambang_ebis -KeyFilePath C:\Users\zeruel11\.ssh\iktisrv_id -SSHTransport
#     Set-Variable -Name s -Value (Get-PSSession -Name ikti.pwsh)
# }

# function ikti.cls {
#     Remove-PSSession -Name ikti.pwsh
#     Remove-Variable s
# }

###video help
function subit {
    subliminal download -v -l en -hi $args[0]
}
function gup {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FileToUpload = $args[0],
        [string]$DriveDir
    )
    foreach ($f in Get-ChildItem -LiteralPath $FileToUpload -Filter *.mkv) {
        if (!$DriveDir) {
            gdrive upload $f
        }
        else {
            gdrive upload -p $DriveDir $f
        }
    }
}

###misc
function mag2tor {
    aria2c.ps1 --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 $args[0]
}

Set-Alias -Name "pwsh" -Value "pwsh-preview"
