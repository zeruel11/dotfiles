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

if ((Get-Module -ListAvailable posh-git) -ne $null) {
    Import-Module posh-git

    $global:GitPromptSettings.BeforeText = '['
    $global:GitPromptSettings.AfterText = '] '
} else {
    Write-Warning "posh-git module not found"
}

if ((Get-Module -ListAvailable DockerCompletion) -ne $null) {
    Import-Module DockerCompletion
} else {
    Write-Warning "DockerCompletion module not found"
}

#Scoop Completion - check scoop installation
if (!(Test-Path -Path "$env:SCOOP")) { $env:SCOOP = "$env:USERPROFILE\scoop" }
#enable scoop completion
Import-Module "$env:USERPROFILE\.scoopy\modules\scoop-completion"

# PowerShell parameter completion shim for the dotnet CLI 
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
      param($commandName, $wordToComplete, $cursorPosition)
               dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
                           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
               }
}

# setup win10 OpenSSH
# workaround for posh-git with win10 OpenSSH
if ($env:SSH_AGENT_PID){
    Remove-Item env:\SSH_AGENT_PID
}
if ($env:SSH_AUTH_SOCK){
    Remove-Item env:\SSH_AUTH_SOCK
}

# start win10 OpenSSH
if ((Get-Service -Name ssh-agent -ErrorAction SilentlyContinue).Status -eq [System.ServiceProcess.ServiceControllerStatus]::Stopped) {
    Write-Host "Starting ssh-agent..."
    Start-Service ssh-agent
    } elseif ((Get-Service -Name ssh-agent -ErrorAction SilentlyContinue).Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {
        Write-Host "SSH-agent service already started"
    } else {
        Write-Warning "SSH-agent service is not found or cannot be started. Please check if you have already installed windows OpenSSH or if it is capable of running"
    }

# start Git for Windows OpenSSH
# Start-SshAgent
$TestSSHmykey = ssh-add -L
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
        if (Test-Path -Path "$env:USERPROFILE\.ssh\iktisrv_rsa") {
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
