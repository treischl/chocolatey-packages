﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-developer/73.0.3834.0/win/Opera_Developer_73.0.3834.0_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-developer/73.0.3834.0/win/Opera_Developer_73.0.3834.0_Setup_x64.exe'
  checksum       = '5e0b70d2914b2940db17dea8240967d0fe0ba758915800906069974e7a3183bc'
  checksum64     = '9d9a8e93cc0b580ebe630c9741c4a50c50229cd2a0c8d9d2760cbf13b5964447'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '73.0.3834.0'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
