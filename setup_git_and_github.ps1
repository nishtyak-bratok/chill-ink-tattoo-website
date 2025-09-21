# Скрипт для установки Git и настройки GitHub репозитория
# Автор: Chill Ink Tattoo Website Setup

Write-Host "=== Настройка Git и GitHub для Chill Ink Tattoo Website ===" -ForegroundColor Green

# Проверяем, установлен ли Git
try {
    $gitVersion = git --version 2>$null
    if ($gitVersion) {
        Write-Host "Git уже установлен: $gitVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "Git не найден. Устанавливаем..." -ForegroundColor Yellow
    
    # Скачиваем Git
    $gitUrl = "https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0.2-64-bit.exe"
    $gitInstaller = "$env:TEMP\Git-installer.exe"
    
    Write-Host "Скачиваем Git..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller
    
    Write-Host "Устанавливаем Git..." -ForegroundColor Yellow
    Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT", "/NORESTART" -Wait
    
    # Добавляем Git в PATH для текущей сессии
    $env:PATH += ";C:\Program Files\Git\bin"
    
    Write-Host "Git установлен успешно!" -ForegroundColor Green
}

# Проверяем настройки Git
Write-Host "Проверяем настройки Git..." -ForegroundColor Yellow

# Инициализируем репозиторий если его нет
if (-not (Test-Path ".git")) {
    Write-Host "Инициализируем Git репозиторий..." -ForegroundColor Yellow
    git init
}

# Добавляем все файлы
Write-Host "Добавляем файлы в репозиторий..." -ForegroundColor Yellow
git add .

# Делаем коммит
Write-Host "Создаем коммит..." -ForegroundColor Yellow
git commit -m "Update: Chill Ink Tattoo Website - All 7 artists with portfolios and booking system"

# Настраиваем удаленный репозиторий
$repoUrl = "https://github.com/nishtyak-bratok/chill-ink-tattoo-website.git"
Write-Host "Настраиваем удаленный репозиторий: $repoUrl" -ForegroundColor Yellow

# Удаляем старый origin если есть
git remote remove origin 2>$null

# Добавляем новый origin
git remote add origin $repoUrl

# Отправляем изменения
Write-Host "Отправляем изменения в GitHub..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

Write-Host "=== Настройка завершена! ===" -ForegroundColor Green
Write-Host "Ваш сайт доступен по адресу: https://nishtyak-bratok.github.io/chill-ink-tattoo-website/" -ForegroundColor Cyan
Write-Host "GitHub репозиторий: https://github.com/nishtyak-bratok/chill-ink-tattoo-website" -ForegroundColor Cyan

Write-Host "`nДля включения GitHub Pages:" -ForegroundColor Yellow
Write-Host "1. Перейдите в настройки репозитория на GitHub" -ForegroundColor White
Write-Host "2. Найдите раздел 'Pages' в левом меню" -ForegroundColor White
Write-Host "3. Выберите 'Deploy from a branch'" -ForegroundColor White
Write-Host "4. Выберите ветку 'main' и папку '/ (root)'" -ForegroundColor White
Write-Host "5. Нажмите 'Save'" -ForegroundColor White
