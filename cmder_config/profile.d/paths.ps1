$env:PATH += "$env:CMDER_ROOT\bin"

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