# install.ps1 -- Install the git config files

# Mike Barker <mike@thebarkers.com>
# July 23rd, 2018

##
# History
# 2023-12-26 MRB:
# Create a Junction instead of a SymbolicLink when dealing with folders

##
# Code

# New-SymbolicLink
Function New-SymbolicLink([string]$link, [string]$target) {
    New-Item -ItemType SymbolicLink -Path $link -Value $target -Force
}

# New-Junction
Function New-Junction([string]$link, [string]$target) {
    New-Item -ItemType Junction -Path $link -Value $target -Force
}

# Test-Elevated - Test if the current powershell session is being run with elevated permisions
Function Test-Elevated() {
    return [Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544'
}

# Test-SymbolicLink
Function Test-SymbolicLink([string]$path) {
    $file = Get-Item $path -Force -ErrorAction SilentlyContinue
    Return [bool]($file.LinkType -eq "SymbolicLink")
}

# Test-Junction
Function Test-Junction([string]$path) {
    $file = Get-Item $path -Force -ErrorAction SilentlyContinue
    Return [bool]($file.LinkType -eq "Junction")
}

# Test-IsWindows10
Function Test-IsWindows10 {
    $caption = $(Get-CimInstance Win32_Operatingsystem).Caption
    Return [bool]$caption -Match "Windows 10"
}

# Test-IsWindows11
Function Test-IsWindows11 {
    $caption = $(Get-CimInstance Win32_Operatingsystem).Caption
    Return [bool]$caption -Match "Windows 11"
}

# If running Windows 10 make sure your elevated
if ((Test-IsWindows10) -And (-Not (Test-Elevated))) {
    WriteError "You must run this scripted elevated on Windows 10"
    Exit
}

# Set the target and the link
$target = "$PSScriptRoot\home\.emacs.d"
$link = "$($env:userprofile)\.emacs.d"

# Backup the $link file/folder if it exists and is not a symboliclink or a junction
if ((Test-Path $link) -And (-Not ((Test-SymbolicLink $link) -Or (Test-Junction $link)))) {
    # backup the file/folder
    $backup = "$link.{0:yyyy}{0:MM}{0:dd}T{0:HH}{0:mm}{0:ss}TZ{0:zz}" -f (Get-Date)
    Write-Warning "Backup $link $backup"
    Move-Item -Path $link -Destination "$backup"
}

# Create the $link file/folder if it does not exist
if (-Not (Test-Path $link)) {
   Write-Output "Linking: $($link) to $($target)"
   New-Junction $link $target | Out-Null
}
