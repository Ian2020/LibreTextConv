param([string]$docPath = "")

if([String]::IsNullOrEmpty($docPath)) {
    throw "No filename was provided!"
}

$ErrorActionPreference = "Stop"
#Note Dependency on 7zip
$7zipExe = "C:\Program Files\7-Zip\7z.exe"
$extractPath = $docPath.Replace(".ods", "")

if(-not (Test-Path $docPath)) {
    throw "File does not exist: $docPath"
}

#Convert it to filesystem object from string
$docPathItem = Get-Item $docPath

if(Test-Path $extractPath) {
    throw "Cannot unzip $docPath to $extractPath as folder already exists!"
}

try {
    & $7zipExe x $($docPathItem.FullName) "-o$extractPath" | Out-Null
    #TODO: Check for error after above command!

    if(-not (Test-Path $extractPath)) {
        throw "Document was not unzipped for some reason!"
    }

    #Convert it to filesystem object from string
    $extractPathItem = Get-Item $extractPath

    #TODO: Ignore images right now but we could MD5 hash them or something nice
    $docFiles = Get-ChildItem $extractPath -Recurse -File -Exclude *.png

    #TODO: Use StringBuilder, initialise to size of all items (no items * length of header per item)
    $flatDoc = ""
    foreach($docFile in $docFiles) {
        #TODO: This does not work!
        $relativePath = $docFile.FullName.Replace($extractPathItem.FullName, "")
        $flatDoc += "### Content of $relativePath follows ###" + [Environment]::NewLine
        $flatDoc += (Get-Content $docFile.FullName -Raw) + [Environment]::NewLine
    }

    Write-Host $flatDoc
} finally {
    if(Test-Path $extractPath) {
        Remove-Item $extractPath -Recurse -Force
    }
}