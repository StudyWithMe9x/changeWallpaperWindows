$base = "https://athena.edu.vn/content/uploads/"
$file = Read-Host "Nhap ten file (vi du: image.jpg)"
$url = $base + $file
$path = "$env:USERPROFILE\Pictures\wallpaper.jpg"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path "$env:USERPROFILE\Pictures")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\Pictures" -Force
}

# Tải ảnh
Write-Host "Dang tai anh..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing -ErrorAction Stop
    Write-Host "Tai anh thanh cong!" -ForegroundColor Green
} catch {
    Write-Host "Loi tai anh: $_" -ForegroundColor Red
    exit
}

# Xóa cache cũ
Remove-Item "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\Themes\slideshow.ini" -ErrorAction SilentlyContinue

# Set registry
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $path
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -Value 0

# Force refresh bằng cách call SystemParametersInfo
$signature = @'
[DllImport("user32.dll", SetLastError = true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, string pvParam, uint fWinIni);
'@
$user32 = Add-Type -MemberDefinition $signature -Name "User32" -Namespace "Win32" -PassThru
$user32::SystemParametersInfo(0x0014, 0, $path, 0x01 -bor 0x02)

Write-Host "Da doi wallpaper! Neu van khong thay doi, hay thu logout va login lai." -ForegroundColor Yellow

# Thêm vào cuối script:
Stop-Process -Name explorer -Force
Start-Process explorer

