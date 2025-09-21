# Исправленный скрипт для настройки галерей
Write-Host "🔧 Исправляем структуру галерей..." -ForegroundColor Green

# Очищаем папки
Write-Host "🧹 Очищаем папки..." -ForegroundColor Yellow
Remove-Item "gallery\renoit\*" -Force -ErrorAction SilentlyContinue
Remove-Item "gallery\rocket\*" -Force -ErrorAction SilentlyContinue

# Копируем работы Алексея Renoit (уникальные файлы)
Write-Host "👨‍🎨 Копируем работы Алексея Renoit..." -ForegroundColor Cyan
$renoitFiles = Get-ChildItem "masters\renoit\*.JPG", "masters\renoit\*.jpg" | Sort-Object Name | Get-Unique -AsString
$counter = 1
foreach ($file in $renoitFiles) {
    $newName = "renoit-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\renoit\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Копируем работы Булата Rocket (уникальные файлы)
Write-Host "👨‍🎨 Копируем работы Булата Rocket..." -ForegroundColor Cyan
$rocketFiles = Get-ChildItem "masters\rocket\*.JPG", "masters\rocket\*.jpg" | Sort-Object Name | Get-Unique -AsString
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
$renoitCount = (Get-ChildItem "gallery\renoit\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count
$rocketCount = (Get-ChildItem "gallery\rocket\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count

Write-Host "`n📊 Результат:" -ForegroundColor Magenta
Write-Host "  Алексей Renoit: $renoitCount работ" -ForegroundColor White
Write-Host "  Булат Rocket: $rocketCount работ" -ForegroundColor White

Write-Host "`n🎉 Готово! Структура исправлена." -ForegroundColor Green
