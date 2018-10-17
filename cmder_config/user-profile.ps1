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

    if ($s -ne $null) {  # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    if ($j -ne $null) {  # job notify
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

