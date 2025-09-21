# Скрипт для добавления дополнительных работ мастеров
Write-Host "🎨 Добавляем дополнительные работы мастеров..." -ForegroundColor Green

# Получаем текущее количество работ
$currentRenoitCount = (Get-ChildItem "gallery\renoit\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count
$currentRocketCount = (Get-ChildItem "gallery\rocket\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count

Write-Host "📊 Текущее количество работ:" -ForegroundColor Yellow
Write-Host "  Алексей Renoit: $currentRenoitCount работ" -ForegroundColor White
Write-Host "  Булат Rocket: $currentRocketCount работ" -ForegroundColor White

# Добавляем дополнительные работы Алексея Renoit
Write-Host "`n👨‍🎨 Добавляем дополнительные работы Алексея Renoit..." -ForegroundColor Cyan
$additionalRenoitFiles = Get-ChildItem "masters\renoit\*.JPG", "masters\renoit\*.jpg" | Where-Object { $_.Name -notlike "IMG_5528*" } | Sort-Object Name
$counter = $currentRenoitCount + 1

foreach ($file in $additionalRenoitFiles) {
    $newName = "renoit-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\renoit\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Добавляем дополнительные работы Булата Rocket
Write-Host "`n👨‍🎨 Добавляем дополнительные работы Булата Rocket..." -ForegroundColor Cyan
$additionalRocketFiles = Get-ChildItem "masters\rocket\*.JPG", "masters\rocket\*.jpg" | Where-Object { $_.Name -notlike "IMG_6637*" } | Sort-Object Name
$counter = $currentRocketCount + 1

foreach ($file in $additionalRocketFiles) {
    $newName = "rocket-work-$counter.jpg"
    Copy-Item $file.FullName "gallery\rocket\$newName" -Force
    Write-Host "  ✅ $($file.Name) → $newName" -ForegroundColor Green
    $counter++
}

# Подсчитываем новое количество работ
$newRenoitCount = (Get-ChildItem "gallery\renoit\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count
$newRocketCount = (Get-ChildItem "gallery\rocket\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count

Write-Host "`n📊 Новое количество работ:" -ForegroundColor Magenta
Write-Host "  Алексей Renoit: $newRenoitCount работ (+$($newRenoitCount - $currentRenoitCount))" -ForegroundColor White
Write-Host "  Булат Rocket: $newRocketCount работ (+$($newRocketCount - $currentRocketCount))" -ForegroundColor White

Write-Host "`n🔄 Обновляем HTML с новыми галереями..." -ForegroundColor Yellow

# Создаем HTML для галереи Алексея Renoit
$renoitGalleryHTML = @"
    <!-- Алексей Renoit Gallery -->
    <div id="renoit-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>Алексей Renoit - Галерея работ ($newRenoitCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $newRenoitCount; $i++) {
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
                <h2>Булат Rocket - Галерея работ ($newRocketCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $newRocketCount; $i++) {
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

Write-Host "✅ HTML обновлен с расширенными галереями!" -ForegroundColor Green
Write-Host "🎉 Готово! Теперь у каждого мастера максимальное количество работ." -ForegroundColor Magenta
