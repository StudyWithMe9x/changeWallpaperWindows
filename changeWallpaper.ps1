$url = Read-Host "Nhap link anh wallpaper"
$username = $env:USERNAME
$path = "C:\Users\$username\Pictures\wallpaper.jpg"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path "C:\Users\$username\Pictures")) {
    New-Item -ItemType Directory -Path "C:\Users\$username\Pictures" -Force
}

# Tải ảnh
Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing

# Xóa cache wallpaper cũ
Remove-Item "C:\Users\$username\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper" -ErrorAction SilentlyContinue

# Set wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $path
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10

# Refresh desktop
Rundll32.exe user32.dll,UpdatePerUserSystemParameters

Write-Host "Da doi wallpaper thanh cong!" -ForegroundColor Green
