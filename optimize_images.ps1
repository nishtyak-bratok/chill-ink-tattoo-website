# Скрипт для оптимизации изображений
Write-Host "🖼️ Оптимизируем изображения для быстрой загрузки..." -ForegroundColor Green

# Проверяем наличие ImageMagick
$magickPath = Get-Command magick -ErrorAction SilentlyContinue
if (-not $magickPath) {
    Write-Host "⚠️ ImageMagick не найден. Устанавливаем через Chocolatey..." -ForegroundColor Yellow
    try {
        choco install imagemagick -y
        Write-Host "✅ ImageMagick установлен!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Не удалось установить ImageMagick. Пожалуйста, установите его вручную." -ForegroundColor Red
        Write-Host "Скачайте с: https://imagemagick.org/script/download.php" -ForegroundColor White
        exit 1
    }
}

# Функция для оптимизации изображения
function Optimize-Image {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [int]$Quality = 85,
        [int]$MaxWidth = 1200
    )
    
    try {
        # Оптимизируем изображение
        magick $InputPath -resize "${MaxWidth}x>" -quality $Quality -strip $OutputPath
        Write-Host "  ✅ Оптимизировано: $InputPath" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "  ❌ Ошибка при оптимизации: $InputPath" -ForegroundColor Red
        return $false
    }
}

# Создаем папку для оптимизированных изображений
$optimizedPath = "optimized"
if (!(Test-Path $optimizedPath)) {
    New-Item -ItemType Directory -Path $optimizedPath -Force
    Write-Host "📁 Создана папка для оптимизированных изображений" -ForegroundColor Cyan
}

# Оптимизируем изображения мастеров
Write-Host "`n👨‍🎨 Оптимизируем изображения мастеров..." -ForegroundColor Cyan

$masters = @("renoit", "rocket")
foreach ($master in $masters) {
    $galleryPath = "gallery\$master"
    $optimizedMasterPath = "$optimizedPath\$master"
    
    if (!(Test-Path $optimizedMasterPath)) {
        New-Item -ItemType Directory -Path $optimizedMasterPath -Force
    }
    
    if (Test-Path $galleryPath) {
        $images = Get-ChildItem "$galleryPath\*.jpg" | Sort-Object Name
        foreach ($image in $images) {
            $outputPath = "$optimizedMasterPath\$($image.Name)"
            Optimize-Image -InputPath $image.FullName -OutputPath $outputPath
        }
    }
}

# Оптимизируем портфолио изображения
Write-Host "`n🎨 Оптимизируем портфолио..." -ForegroundColor Cyan

$portfolioImages = Get-ChildItem "portfolio-*.jpg" | Sort-Object Name
foreach ($image in $portfolioImages) {
    $outputPath = "$optimizedPath\$($image.Name)"
    Optimize-Image -InputPath $image.FullName -OutputPath $outputPath
}

# Оптимизируем логотип
Write-Host "`n🏷️ Оптимизируем логотип..." -ForegroundColor Cyan
if (Test-Path "logo.png") {
    Optimize-Image -InputPath "logo.png" -OutputPath "$optimizedPath\logo.png" -Quality 90
}

# Создаем WebP версии для лучшей совместимости
Write-Host "`n🌐 Создаем WebP версии..." -ForegroundColor Cyan

function Convert-ToWebP {
    param(
        [string]$InputPath,
        [string]$OutputPath
    )
    
    try {
        magick $InputPath -quality 85 -define webp:lossless=false $OutputPath
        Write-Host "  ✅ WebP создан: $OutputPath" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "  ❌ Ошибка при создании WebP: $InputPath" -ForegroundColor Red
        return $false
    }
}

# Конвертируем в WebP
Get-ChildItem "$optimizedPath\**\*.jpg" | ForEach-Object {
    $webpPath = $_.FullName -replace '\.jpg$', '.webp'
    Convert-ToWebP -InputPath $_.FullName -OutputPath $webpPath
}

# Создаем отчет об оптимизации
$report = @"
# Отчет об оптимизации изображений

## Статистика оптимизации

### Исходные изображения:
"@

$totalOriginalSize = 0
$totalOptimizedSize = 0

# Подсчитываем размеры
Get-ChildItem "gallery\**\*.jpg", "portfolio-*.jpg", "logo.png" | ForEach-Object {
    $totalOriginalSize += $_.Length
}

Get-ChildItem "$optimizedPath\**\*" | ForEach-Object {
    $totalOptimizedSize += $_.Length
}

$savings = $totalOriginalSize - $totalOptimizedSize
$savingsPercent = [math]::Round(($savings / $totalOriginalSize) * 100, 2)

$report += @"

- Общий размер исходных изображений: $([math]::Round($totalOriginalSize / 1MB, 2)) MB
- Общий размер оптимизированных изображений: $([math]::Round($totalOptimizedSize / 1MB, 2)) MB
- Экономия места: $([math]::Round($savings / 1MB, 2)) MB ($savingsPercent%)

## Рекомендации

1. Замените исходные изображения на оптимизированные версии
2. Используйте WebP формат для современных браузеров
3. Рассмотрите возможность использования lazy loading для изображений

## Файлы готовы к использованию

Все оптимизированные изображения находятся в папке: $optimizedPath
"@

$report | Out-File "optimization_report.md" -Encoding UTF8

Write-Host "`n📊 Отчет об оптимизации создан: optimization_report.md" -ForegroundColor Magenta
Write-Host "💾 Экономия места: $([math]::Round($savings / 1MB, 2)) MB ($savingsPercent%)" -ForegroundColor Green
Write-Host "🎉 Оптимизация завершена!" -ForegroundColor Magenta
