$assetsFolder = Join-Path $PSScriptRoot "assets"

$files = Get-ChildItem -Path $assetsFolder -File |
  Where-Object { $_.Extension.ToLower() -in @(".jpg",".jpeg",".png",".webp",".gif",".avif") } |
  Sort-Object @{
    Expression = {
      if ($_.BaseName -match '\d+') { [int]$matches[0] } else { 999999 }
    }
  }, Name

$count = 1

foreach ($file in $files) {
  $newName = "{0:D3}{1}" -f $count, $file.Extension.ToLower()
  Rename-Item -Path $file.FullName -NewName $newName
  $count++
}

Write-Host ""
Write-Host "================================="
Write-Host "Rename Complete!"
Write-Host "Total Files: $($files.Count)"
Write-Host "================================="
pause