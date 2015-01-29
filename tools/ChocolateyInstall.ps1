$packageName = "LibreTextConv"
$psFileFullPath = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) "LibreTextConv.ps1"
Install-ChocolateyPowershellCommand $packageName $psFileFullPath
