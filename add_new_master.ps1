# Скрипт для добавления новых мастеров
param(
    [Parameter(Mandatory=$true)]
    [string]$MasterName,
    [Parameter(Mandatory=$true)]
    [string]$MasterFolder,
    [Parameter(Mandatory=$true)]
    [string]$MasterPhoto,
    [Parameter(Mandatory=$true)]
    [string]$Experience,
    [Parameter(Mandatory=$true)]
    [string]$Style,
    [Parameter(Mandatory=$true)]
    [string]$Specialization,
    [Parameter(Mandatory=$false)]
    [string[]]$Skills = @()
)

Write-Host "Добавляем нового мастера: $MasterName" -ForegroundColor Green

# Создаем папку для мастера в gallery
$galleryPath = "gallery\$MasterFolder"
if (!(Test-Path $galleryPath)) {
    New-Item -ItemType Directory -Path $galleryPath -Force
    Write-Host "Создана папка: $galleryPath" -ForegroundColor Green
}

# Копируем фото мастера
$masterPhotoPath = "gallery\$MasterFolder\master-photo.jpg"
if (Test-Path $MasterPhoto) {
    Copy-Item $MasterPhoto $masterPhotoPath -Force
    Write-Host "Скопировано фото мастера: $masterPhotoPath" -ForegroundColor Green
} else {
    Write-Host "Фото мастера не найдено: $MasterPhoto" -ForegroundColor Yellow
}

# Копируем работы мастера
$worksPath = "masters\$MasterFolder"
if (Test-Path $worksPath) {
    $workFiles = Get-ChildItem "$worksPath\*.JPG", "$worksPath\*.jpg" | Where-Object { $_.Name -notlike "*master*" } | Sort-Object Name
    $counter = 1
    
    foreach ($file in $workFiles) {
        $newName = "$MasterFolder-work-$counter.jpg"
        Copy-Item $file.FullName "gallery\$MasterFolder\$newName" -Force
        Write-Host "  $($file.Name) -> $newName" -ForegroundColor Green
        $counter++
    }
    
    $workCount = $workFiles.Count
    Write-Host "Добавлено работ: $workCount" -ForegroundColor Cyan
} else {
    Write-Host "Папка с работами не найдена: $worksPath" -ForegroundColor Yellow
    $workCount = 0
}

# Создаем HTML для карточки мастера
$masterCardHTML = @"
                <div class="master-card featured-master">
                    <div class="master-photo">
                        <img src="gallery/$MasterFolder/master-photo.jpg" alt="$MasterName" class="master-img">
                        <div class="master-overlay">
                            <div class="master-stats">
                                <span class="master-experience">$Experience</span>
                                <span class="master-style">$Style</span>
                            </div>
                        </div>
                    </div>
                    <h3>$MasterName</h3>
                    <p class="master-specialization">Специализация: $Specialization</p>
                    <p class="master-experience-text">Опыт работы: $Experience</p>
                    <div class="master-skills">
"@

# Добавляем навыки
foreach ($skill in $Skills) {
    $masterCardHTML += "`n                        <span class=`"skill-tag`">$skill</span>"
}

$masterCardHTML += @"
                    </div>
                </div>
"@

# Создаем HTML для галереи мастера
$masterGalleryHTML = @"
    <!-- $MasterName Gallery -->
    <div id="$MasterFolder-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>$MasterName - Галерея работ ($workCount работ)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $workCount; $i++) {
    $masterGalleryHTML += @"
                <div class="gallery-item">
                    <img src="gallery/$MasterFolder/$MasterFolder-work-$i.jpg" alt="Работа $MasterName $i" class="gallery-img">
                </div>
"@
}

$masterGalleryHTML += @"
            </div>
        </div>
    </div>
"@

# Читаем текущий HTML
$htmlContent = Get-Content "index.html" -Raw

# Добавляем карточку мастера в секцию masters
$mastersSectionPattern = '(<div class="masters-grid">.*?)(<div class="master-card">.*?<div class="master-placeholder">)'
$mastersReplacement = "`$1$masterCardHTML`n                `$2"

$htmlContent = $htmlContent -replace $mastersSectionPattern, $mastersReplacement

# Добавляем галерею мастера перед закрывающим тегом script
$scriptPattern = '(\s*<script src="script\.js"></script>)'
$scriptReplacement = "`n$masterGalleryHTML`n`n    `$1"

$htmlContent = $htmlContent -replace $scriptPattern, $scriptReplacement

# Сохраняем обновленный HTML
$htmlContent | Out-File "index.html" -Encoding UTF8

Write-Host "HTML обновлен с новым мастером!" -ForegroundColor Green
Write-Host "Мастер $MasterName успешно добавлен!" -ForegroundColor Magenta
Write-Host "Статистика:" -ForegroundColor Yellow
Write-Host "  - Имя: $MasterName" -ForegroundColor White
Write-Host "  - Папка: $MasterFolder" -ForegroundColor White
Write-Host "  - Опыт: $Experience" -ForegroundColor White
Write-Host "  - Стиль: $Style" -ForegroundColor White
Write-Host "  - Работ: $workCount" -ForegroundColor White