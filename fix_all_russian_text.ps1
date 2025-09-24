# Fix all Russian text encoding issues
Write-Host "Fixing Russian text encoding..." -ForegroundColor Cyan

# Read the file
$content = Get-Content -Path "index.html" -Raw

# Define all the replacements needed
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
    'РџСЂРѕС„РµСЃСЃРёРѕРЅР°Р»СЊРЅС‹Рµ' = 'Профессиональные'
    'Р°С‚РјРѕСЃС„РµСЂРµ' = 'атмосфере'
    'РєРѕРјС„РѕСЂС‚Р°' = 'комфорта'
    'С‚РІРѕСЂС‡РµСЃС‚РІР°' = 'творчества'
    'Р'РѕРїР»РѕС‰Р°РµРј' = 'Воплощаем'
    'РёРґРµРё' = 'идеи'
    'РёСЃРєСѓСЃСЃС‚РІРѕ' = 'искусство'
    'РєРѕР¶Рµ' = 'коже'
    'Р»РµС‚ РѕРїС‹С‚Р°' = 'лет опыта'
    'СЂР°Р±РѕС‚' = 'работ'
}

# Apply all replacements
foreach ($damaged in $replacements.Keys) {
    $correct = $replacements[$damaged]
    $content = $content -replace [regex]::Escape($damaged), $correct
    Write-Host "Fixed: $damaged -> $correct" -ForegroundColor Green
}

# Save the corrected file
$content | Out-File -FilePath "index.html" -Encoding UTF8 -NoNewline

Write-Host "All Russian text fixed!" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
