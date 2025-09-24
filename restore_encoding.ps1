# Restore proper encoding for Russian text
Write-Host "Restoring proper encoding..." -ForegroundColor Cyan

# Read the damaged file
$content = Get-Content -Path "index.html" -Raw -Encoding UTF8

# Fix the most common encoding issues
$replacements = @{
    'РҐСѓРґРѕР¶РµСЃС‚РІРµРЅРЅР°СЏ' = 'Художественная'
    'С‚Р°С‚СѓРёСЂРѕРІРєР°' = 'татуировка'
    'РІ РљР°Р·Р°РЅРё' = 'в Казани'
    'Р"Р»Р°РІРЅР°СЏ' = 'Главная'
    'Рћ РЅР°СЃ' = 'О нас'
    'РЈСЃР»СѓРіРё' = 'Услуги'
    'РџРѕСЂС‚С„РѕР»РёРѕ' = 'Портфолио'
    'РњР°СЃС‚РµСЂР°' = 'Мастера'
    'РљРѕРЅС‚Р°РєС‚С‹' = 'Контакты'
    'Р—Р°РїРёСЃР°С‚СЊСЃСЏ' = 'Записаться'
    'РЅР° РєРѕРЅСЃСѓР»СЊС‚Р°С†РёСЋ' = 'на консультацию'
}

foreach ($damaged in $replacements.Keys) {
    $correct = $replacements[$damaged]
    $content = $content -replace [regex]::Escape($damaged), $correct
    Write-Host "Fixed: $damaged -> $correct" -ForegroundColor Green
}

# Save the corrected file
$content | Out-File -FilePath "index_restored.html" -Encoding UTF8 -NoNewline

Write-Host "Restored file saved as index_restored.html" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
