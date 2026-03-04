$url = Read-Host "Nhap link anh wallpaper"
$path = "$env:USERPROFILE\Pictures\wallpaper.jpg"
Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
Remove-Item "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $path
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10
Rundll32.exe user32.dll,UpdatePerUserSystemParameters
Write-Host "Da doi wallpaper thanh cong!" -ForegroundColor Green