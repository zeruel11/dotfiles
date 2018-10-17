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

$sdkmandir="C:\_SDK\.sdkman\candidates"
if (Test-Path "$sdkmandir\grails\") {
    $env:Path += ";$sdkmandir\grails\current\bin"
}
if (Test-Path "$sdkmandir\maven\") {
    $env:Path += ";$sdkmandir\maven\current\bin"
}
if (Test-Path "$sdkmandir\springboot\") {
    $env:Path += ";$sdkmandir\springboot\current\bin"
}
if (Test-Path "$sdkmandir\gradle\") {
    $env:Path += ";$sdkmandir\gradle\current\bin"
}