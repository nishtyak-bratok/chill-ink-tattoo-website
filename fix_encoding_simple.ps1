# Simple encoding fix script
Write-Host "Fixing encoding in HTML files..." -ForegroundColor Cyan

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html"
$fixedCount = 0

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor White
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding Default
        
        # Replace UTF-8 with windows-1251
        $content = $content -replace '<meta charset="UTF-8">', '<meta charset="windows-1251">'
        $content = $content -replace '<meta charset="utf-8">', '<meta charset="windows-1251">'
        
        # Add HTTP header if not exists
        if ($content -notmatch '<meta http-equiv="Content-Type"') {
            $content = $content -replace '(<meta charset="windows-1251">)', '$1`n    <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">'
        }
        
        $content | Out-File -FilePath $file.FullName -Encoding Default -NoNewline
        Write-Host "  Fixed" -ForegroundColor Green
        $fixedCount++
        
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Fixed $fixedCount files" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
