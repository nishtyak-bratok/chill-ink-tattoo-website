# Convert files from Windows-1251 to UTF-8
Write-Host "Converting files from Windows-1251 to UTF-8..." -ForegroundColor Cyan

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html"
$convertedCount = 0

foreach ($file in $htmlFiles) {
    Write-Host "Converting: $($file.Name)" -ForegroundColor White
    
    try {
        # Read file as Windows-1251
        $content = Get-Content -Path $file.FullName -Raw -Encoding Default
        
        # Change charset declaration to UTF-8
        $content = $content -replace '<meta charset="windows-1251">', '<meta charset="UTF-8">'
        $content = $content -replace '<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">', '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
        
        # Save as UTF-8 with BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        
        Write-Host "  Converted to UTF-8" -ForegroundColor Green
        $convertedCount++
        
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Converted $convertedCount files to UTF-8" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
