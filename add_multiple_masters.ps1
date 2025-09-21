# Скрипт для добавления нескольких мастеров одновременно
Write-Host "🎨 Добавляем нескольких новых мастеров..." -ForegroundColor Green

# Определяем мастеров для добавления
$masters = @(
    @{
        Name = "Анна Соколова"
        Folder = "sokolova"
        Photo = "masters/sokolova/master-photo.jpg"
        Experience = "8+ лет"
        Style = "Реализм"
        Specialization = "Портреты и реализм"
        Skills = @("Портреты", "Реализм", "Черно-белое", "Цветные тату")
    },
    @{
        Name = "Дмитрий Волков"
        Folder = "volkov"
        Photo = "masters/volkov/master-photo.jpg"
        Experience = "12+ лет"
        Style = "Японская традиция"
        Specialization = "Японские татуировки"
        Skills = @("Японская традиция", "Драконы", "Кои", "Сакэ")
    },
    @{
        Name = "Елена Морозова"
        Folder = "morozova"
        Photo = "masters/morozova/master-photo.jpg"
        Experience = "6+ лет"
        Style = "Минимализм"
        Specialization = "Минималистичные татуировки"
        Skills = @("Минимализм", "Геометрия", "Линейные", "Тонкие линии")
    },
    @{
        Name = "Сергей Козлов"
        Folder = "kozlov"
        Photo = "masters/kozlov/master-photo.jpg"
        Experience = "15+ лет"
        Style = "Олдскул"
        Specialization = "Классические татуировки"
        Skills = @("Олдскул", "Традиционные", "Якоря", "Розы")
    },
    @{
        Name = "Мария Петрова"
        Folder = "petrova"
        Photo = "masters/petrova/master-photo.jpg"
        Experience = "7+ лет"
        Style = "Акварель"
        Specialization = "Акварельные татуировки"
        Skills = @("Акварель", "Цветные", "Абстракция", "Природа")
    }
)

# Создаем папки для мастеров
foreach ($master in $masters) {
    $mastersPath = "masters\$($master.Folder)"
    $galleryPath = "gallery\$($master.Folder)"
    
    if (!(Test-Path $mastersPath)) {
        New-Item -ItemType Directory -Path $mastersPath -Force
        Write-Host "📁 Создана папка для мастера: $mastersPath" -ForegroundColor Cyan
    }
    
    if (!(Test-Path $galleryPath)) {
        New-Item -ItemType Directory -Path $galleryPath -Force
        Write-Host "📁 Создана галерея: $galleryPath" -ForegroundColor Cyan
    }
}

Write-Host "`n📋 Инструкции по добавлению мастеров:" -ForegroundColor Yellow
Write-Host "1. Поместите фото мастера в папку masters/[имя_папки]/master-photo.jpg" -ForegroundColor White
Write-Host "2. Поместите работы мастера в папку masters/[имя_папки]/" -ForegroundColor White
Write-Host "3. Запустите скрипт add_new_master.ps1 для каждого мастера" -ForegroundColor White

Write-Host "`n📝 Примеры команд:" -ForegroundColor Magenta
foreach ($master in $masters) {
    $skillsString = $master.Skills -join '", "'
    Write-Host ".\add_new_master.ps1 -MasterName `"$($master.Name)`" -MasterFolder `"$($master.Folder)`" -MasterPhoto `"$($master.Photo)`" -Experience `"$($master.Experience)`" -Style `"$($master.Style)`" -Specialization `"$($master.Specialization)`" -Skills @(`"$skillsString`")" -ForegroundColor White
}

Write-Host "`n🎯 Готово! Теперь добавьте фото и работы мастеров в соответствующие папки." -ForegroundColor Green
