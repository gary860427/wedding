$assetsFolder = Join-Path $PSScriptRoot "assets"
$outputFile = Join-Path $assetsFolder "images.js"

if (!(Test-Path $assetsFolder)) {
    Write-Host "can't find"
    pause
    exit
}

$files = Get-ChildItem -Path $assetsFolder -File |
    Where-Object { $_.Extension.ToLower() -in @(".jpg",".jpeg",".png",".webp",".gif",".avif") } |
    Sort-Object @{
        Expression = {
            if ($_.BaseName -match '\d+') { [int]$matches[0] } else { 999999 }
        }
    }, Name

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("window.images = [")

foreach ($file in $files) {
    $safeName = $file.Name.Replace("\", "/").Replace("'", "\'")
    $lines.Add("  'assets/$safeName',")
}

if ($files.Count -gt 0) {
    $lastIndex = $lines.Count - 1
    $lines[$lastIndex] = $lines[$lastIndex].TrimEnd(",")
}

$lines.Add("];")

[System.IO.File]::WriteAllLines($outputFile, $lines, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "==============================="
Write-Host "pass"
Write-Host "find $($files.Count) pic"
Write-Host "creat：assets/images.js"
Write-Host "==============================="
pause