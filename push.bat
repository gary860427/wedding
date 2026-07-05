@echo off
cd /d "%~dp0"

if not exist assets (
    mkdir assets
)

for %%f in (original\*.jpg) do (
    magick "%%f" ^
    -resize "1600x1600>" ^
    -strip ^
    -interlace Plane ^
    -quality 82 ^
    "assets\%%~nxf"
)

echo.
echo ==========================
echo finish
echo ==========================
pause