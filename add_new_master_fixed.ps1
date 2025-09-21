# Script for adding new masters
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

Write-Host "Adding new master: $MasterName" -ForegroundColor Green

# Create master folder in gallery
$galleryPath = "gallery\$MasterFolder"
if (!(Test-Path $galleryPath)) {
    New-Item -ItemType Directory -Path $galleryPath -Force
    Write-Host "Created folder: $galleryPath" -ForegroundColor Green
}

# Copy master photo
$masterPhotoPath = "gallery\$MasterFolder\master-photo.jpg"
if (Test-Path $MasterPhoto) {
    Copy-Item $MasterPhoto $masterPhotoPath -Force
    Write-Host "Copied master photo: $masterPhotoPath" -ForegroundColor Green
} else {
    Write-Host "Master photo not found: $MasterPhoto" -ForegroundColor Yellow
}

# Copy master works
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
    Write-Host "Added works: $workCount" -ForegroundColor Cyan
} else {
    Write-Host "Works folder not found: $worksPath" -ForegroundColor Yellow
    $workCount = 0
}

# Create HTML for master card
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
                    <p class="master-specialization">Specialization: $Specialization</p>
                    <p class="master-experience-text">Experience: $Experience</p>
                    <div class="master-skills">
"@

# Add skills
foreach ($skill in $Skills) {
    $masterCardHTML += "`n                        <span class=`"skill-tag`">$skill</span>"
}

$masterCardHTML += @"
                    </div>
                </div>
"@

# Create HTML for master gallery
$masterGalleryHTML = @"
    <!-- $MasterName Gallery -->
    <div id="$MasterFolder-gallery" class="gallery-modal">
        <div class="gallery-content">
            <div class="gallery-header">
                <h2>$MasterName - Works Gallery ($workCount works)</h2>
                <span class="gallery-close">&times;</span>
            </div>
            <div class="gallery-grid">
"@

for ($i = 1; $i -le $workCount; $i++) {
    $masterGalleryHTML += @"
                <div class="gallery-item">
                    <img src="gallery/$MasterFolder/$MasterFolder-work-$i.jpg" alt="Work $MasterName $i" class="gallery-img">
                </div>
"@
}

$masterGalleryHTML += @"
            </div>
        </div>
    </div>
"@

# Read current HTML
$htmlContent = Get-Content "index.html" -Raw

# Add master card to masters section
$mastersSectionPattern = '(<div class="masters-grid">.*?)(<div class="master-card">.*?<div class="master-placeholder">)'
$mastersReplacement = "`$1$masterCardHTML`n                `$2"

$htmlContent = $htmlContent -replace $mastersSectionPattern, $mastersReplacement

# Add master gallery before closing script tag
$scriptPattern = '(\s*<script src="script\.js"></script>)'
$scriptReplacement = "`n$masterGalleryHTML`n`n    `$1"

$htmlContent = $htmlContent -replace $scriptPattern, $scriptReplacement

# Save updated HTML
$htmlContent | Out-File "index.html" -Encoding UTF8

Write-Host "HTML updated with new master!" -ForegroundColor Green
Write-Host "Master $MasterName successfully added!" -ForegroundColor Magenta
Write-Host "Statistics:" -ForegroundColor Yellow
Write-Host "  - Name: $MasterName" -ForegroundColor White
Write-Host "  - Folder: $MasterFolder" -ForegroundColor White
Write-Host "  - Experience: $Experience" -ForegroundColor White
Write-Host "  - Style: $Style" -ForegroundColor White
Write-Host "  - Works: $workCount" -ForegroundColor White
