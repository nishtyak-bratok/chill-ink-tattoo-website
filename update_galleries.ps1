# Скрипт для обновления HTML с динамическими галереями
Write-Host "🔄 Обновляем HTML с галереями..." -ForegroundColor Green

# Получаем количество работ для каждого мастера
$renoitCount = (Get-ChildItem "gallery\renoit\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count
$rocketCount = (Get-ChildItem "gallery\rocket\*.jpg" | Where-Object { $_.Name -ne "master-photo.jpg" }).Count

Write-Host "📊 Найдено работ:" -ForegroundColor Yellow
Write-Host "  Алексей Renoit: $renoitCount работ" -ForegroundColor White
Write-Host "  Булат Rocket: $rocketCount работ" -ForegroundColor White

# Создаем HTML для галереи Алексея Renoit
$renoitGalleryHTML = @"
    <!-- Алексей Renoit Gallery -->
    <div id="renoit-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>Алексей Renoit - Галерея работ ($renoitCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $renoitCount; $i++) {
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
                <h2>Булат Rocket - Галерея работ ($rocketCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $rocketCount; $i++) {
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

Write-Host "✅ HTML обновлен с динамическими галереями!" -ForegroundColor Green
Write-Host "🎉 Готово! Теперь у каждого мастера своя полная галерея." -ForegroundColor Magenta
