# Финальный скрипт для создания галерей без дубликатов
Write-Host "🎨 Создаем финальные галереи без дубликатов..." -ForegroundColor Green

# Очищаем папки галерей
Write-Host "🧹 Очищаем папки галерей..." -ForegroundColor Yellow
Remove-Item "gallery\renoit\*" -Force -ErrorAction SilentlyContinue
Remove-Item "gallery\rocket\*" -Force -ErrorAction SilentlyContinue

# Копируем ВСЕ работы Алексея Renoit (уникальные файлы)
Write-Host "👨‍🎨 Копируем ВСЕ работы Алексея Renoit..." -ForegroundColor Cyan
$renoitFiles = Get-ChildItem "masters\renoit\*.JPG", "masters\renoit\*.jpg" | Sort-Object Name | Get-Unique -AsString
$counter = 1
foreach ($file in $renoitFiles) {
    $newName = "renoit-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\renoit\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Копируем ВСЕ работы Булата Rocket (уникальные файлы)
Write-Host "👨‍🎨 Копируем ВСЕ работы Булата Rocket..." -ForegroundColor Cyan
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

# Подсчитываем финальное количество работ
$finalRenoitCount = (Get-ChildItem "gallery\renoit\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count
$finalRocketCount = (Get-ChildItem "gallery\rocket\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count

Write-Host "`n📊 Финальное количество работ:" -ForegroundColor Magenta
Write-Host "  Алексей Renoit: $finalRenoitCount работ" -ForegroundColor White
Write-Host "  Булат Rocket: $finalRocketCount работ" -ForegroundColor White

Write-Host "`n🔄 Обновляем HTML с финальными галереями..." -ForegroundColor Yellow

# Создаем HTML для галереи Алексея Renoit
$renoitGalleryHTML = @"
    <!-- Алексей Renoit Gallery -->
    <div id="renoit-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>Алексей Renoit - Галерея работ ($finalRenoitCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $finalRenoitCount; $i++) {
    $renoitGalleryHTML += @"
                <div class="gallery-item">
                    <img src="gallery/renoit/renoit-work-$i.jpg" alt="Работа Алексея Renoit $i" class="gallery-img">
                </div>
"@
}

$renoitGalleryHTML += @"
            </div>
        </div>
    </div>
"@

# Создаем HTML для галереи Булата Rocket
$rocketGalleryHTML = @"
    <!-- Булат Rocket Gallery -->
    <div id="rocket-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>Булат Rocket - Галерея работ ($finalRocketCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $finalRocketCount; $i++) {
    $rocketGalleryHTML += @"
                <div class="gallery-item">
                    <img src="gallery/rocket/rocket-work-$i.jpg" alt="Работа Булата Rocket $i" class="gallery-img">
                </div>
"@
}

$rocketGalleryHTML += @"
            </div>
        </div>
    </div>
"@

# Читаем текущий HTML
$htmlContent = Get-Content "index.html" -Raw

# Заменяем старые галереи на новые
$oldGalleryPattern = '<!-- Master Gallery Modals -->.*?</div>\s*</div>\s*<script src="script\.js"></script>'
$newGalleryContent = "<!-- Master Gallery Modals -->`n$renoitGalleryHTML`n`n$rocketGalleryHTML`n`n    <script src=`"script.js`"></script>"

$htmlContent = $htmlContent -replace $oldGalleryPattern, $newGalleryContent

# Сохраняем обновленный HTML
$htmlContent | Out-File "index.html" -Encoding UTF8

Write-Host "✅ HTML обновлен с финальными галереями!" -ForegroundColor Green
Write-Host "🎉 Готово! Теперь у каждого мастера максимальное количество уникальных работ." -ForegroundColor Magenta
