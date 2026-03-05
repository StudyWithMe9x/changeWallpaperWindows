$base = "https://athena.edu.vn/content/uploads/"
$file = Read-Host "Nhap ten file (vi du: image.jpg)"
$url = $base + $file
$path = "$env:USERPROFILE\Pictures\wallpaper.jpg"

# Kiểm tra và tạo thư mục Pictures
if (!(Test-Path "$env:USERPROFILE\Pictures")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\Pictures"
}

# Tải ảnh
Write-Host "Dang tai anh tu: $url" -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing

# Xóa cache cũ
Remove-Item "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" -ErrorAction SilentlyContinue

# Đổi wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $path
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10

# Refresh
Rundll32.exe user32.dll,UpdatePerUserSystemParameters

Write-Host "Da doi wallpaper thanh cong!" -ForegroundColor Green
