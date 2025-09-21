# Скрипт для настройки галерей мастеров
Write-Host "🎨 Настройка галерей мастеров..." -ForegroundColor Green

# Создаем структуру папок
Write-Host "📁 Создаем структуру папок..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "gallery\renoit" -Force | Out-Null
New-Item -ItemType Directory -Path "gallery\rocket" -Force | Out-Null

# Копируем все работы Алексея Renoit
Write-Host "👨‍🎨 Копируем работы Алексея Renoit..." -ForegroundColor Cyan
$renoitFiles = Get-ChildItem "masters\renoit\*.JPG", "masters\renoit\*.jpg" | Sort-Object Name
$counter = 1
foreach ($file in $renoitFiles) {
    $newName = "renoit-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\renoit\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Копируем все работы Булата Rocket
Write-Host "👨‍🎨 Копируем работы Булата Rocket..." -ForegroundColor Cyan
$rocketFiles = Get-ChildItem "masters\rocket\*.JPG", "masters\rocket\*.jpg" | Sort-Object Name
$counter = 1
foreach ($file in $rocketFiles) {
    $newName = "rocket-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\rocket\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Копируем фото мастеров
Write-Host "📸 Копируем фото мастеров..." -ForegroundColor Cyan
Copy-Item "masters\renoit\IMG_5528.JPG" "gallery\renoit\master-photo.jpg" -Force
Copy-Item "masters\rocket\IMG_6637.JPG" "gallery\rocket\master-photo.jpg" -Force
Write-Host "  ✅ Фото мастеров скопированы" -ForegroundColor Green

# Подсчитываем количество работ
$renoitCount = (Get-ChildItem "gallery\renoit\*.jpg").Count
$rocketCount = (Get-ChildItem "gallery\rocket\*.jpg").Count

Write-Host "`n📊 Результат:" -ForegroundColor Magenta
Write-Host "  Алексей Renoit: $renoitCount работ" -ForegroundColor White
Write-Host "  Булат Rocket: $rocketCount работ" -ForegroundColor White

Write-Host "`n🎉 Готово! Все файлы перенесены в удобную структуру." -ForegroundColor Green
Write-Host "📁 Структура:" -ForegroundColor Yellow
Write-Host "  gallery/renoit/ - работы Алексея Renoit" -ForegroundColor White
Write-Host "  gallery/rocket/ - работы Булата Rocket" -ForegroundColor White
