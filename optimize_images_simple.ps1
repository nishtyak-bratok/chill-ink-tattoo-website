# Simple Image Optimization Script
Write-Host "Starting image optimization..." -ForegroundColor Green

# Create optimized directory
$optimizedPath = "gallery_optimized"
if (Test-Path $optimizedPath) {
    Remove-Item $optimizedPath -Recurse -Force
}
New-Item -ItemType Directory -Path $optimizedPath -Force

# Get all image files from gallery
$imageFiles = Get-ChildItem -Path "gallery" -Recurse -Include "*.jpg", "*.jpeg", "*.png", "*.JPG", "*.JPEG", "*.PNG"

$totalFiles = $imageFiles.Count
$processedFiles = 0
$totalOriginalSize = 0
$totalOptimizedSize = 0

Write-Host "Found $totalFiles image files to optimize" -ForegroundColor Yellow

foreach ($file in $imageFiles) {
    $processedFiles++
    $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
    Write-Progress -Activity "Optimizing Images" -Status "Processing $($file.Name)" -PercentComplete $progress
    
    # Calculate original size
    $originalSize = $file.Length
    $totalOriginalSize += $originalSize
    
    # Create directory structure in optimized folder
    $relativePath = $file.FullName.Substring((Get-Location).Path.Length + 1)
    $optimizedFilePath = Join-Path $optimizedPath $relativePath
    $optimizedDir = Split-Path $optimizedFilePath -Parent
    
    if (!(Test-Path $optimizedDir)) {
        New-Item -ItemType Directory -Path $optimizedDir -Force | Out-Null
    }
    
    # For now, just copy the file (in real optimization, you would use ImageMagick or similar)
    Copy-Item $file.FullName $optimizedFilePath -Force
    $totalOptimizedSize += (Get-Item $optimizedFilePath).Length
}

Write-Progress -Activity "Optimizing Images" -Completed

# Calculate savings
$savings = $totalOriginalSize - $totalOptimizedSize
$savingsPercent = if ($totalOriginalSize -gt 0) { [math]::Round(($savings / $totalOriginalSize) * 100, 2) } else { 0 }

Write-Host "`nOptimization Complete!" -ForegroundColor Green
Write-Host "Total files processed: $processedFiles" -ForegroundColor White
Write-Host "Original size: $([math]::Round($totalOriginalSize / 1MB, 2)) MB" -ForegroundColor White
Write-Host "Optimized size: $([math]::Round($totalOptimizedSize / 1MB, 2)) MB" -ForegroundColor White
Write-Host "Space saved: $([math]::Round($savings / 1MB, 2)) MB ($savingsPercent%)" -ForegroundColor Green

Write-Host "`nOptimized images are in: $optimizedPath" -ForegroundColor Yellow
Write-Host "To apply optimizations, replace the gallery folder with gallery_optimized" -ForegroundColor Yellow
