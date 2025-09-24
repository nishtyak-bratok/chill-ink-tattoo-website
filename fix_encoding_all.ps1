# Скрипт для исправления кодировки во всех HTML файлах
# Автор: Chill Ink Tattoo Website
# Описание: Добавляет правильные мета-теги для кодировки Windows-1251

Write-Host "🔧 Исправление кодировки в HTML файлах..." -ForegroundColor Cyan

# Получаем все HTML файлы в текущей директории
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

$fixedCount = 0
$totalCount = $htmlFiles.Count

Write-Host "📁 Найдено HTML файлов: $totalCount" -ForegroundColor Yellow

foreach ($file in $htmlFiles) {
    Write-Host "📄 Обрабатываем: $($file.Name)" -ForegroundColor White
    
    try {
        # Читаем содержимое файла
        $content = Get-Content -Path $file.FullName -Raw -Encoding Default
        
        # Проверяем, есть ли уже правильные мета-теги
        if ($content -match '<meta charset="windows-1251">' -and $content -match '<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">') {
            Write-Host "   ✅ Уже исправлено" -ForegroundColor Green
            continue
        }
        
        # Заменяем старые мета-теги charset
        $content = $content -replace '<meta charset="UTF-8">', '<meta charset="windows-1251">'
        $content = $content -replace '<meta charset="utf-8">', '<meta charset="windows-1251">'
        
        # Добавляем HTTP заголовок, если его нет
        if ($content -notmatch '<meta http-equiv="Content-Type"') {
            $content = $content -replace '(<meta charset="windows-1251">)', '$1`n    <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">'
        }
        
        # Сохраняем файл
        $content | Out-File -FilePath $file.FullName -Encoding Default -NoNewline
        
        Write-Host "   ✅ Исправлено" -ForegroundColor Green
        $fixedCount++
        
    } catch {
        Write-Host "   ❌ Ошибка при обработке: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n🎉 Готово!" -ForegroundColor Green
Write-Host "📊 Исправлено файлов: $fixedCount из $totalCount" -ForegroundColor Cyan

if ($fixedCount -gt 0) {
    Write-Host "`n📋 Что было сделано:" -ForegroundColor Yellow
    Write-Host "   • Изменен charset с UTF-8 на windows-1251" -ForegroundColor White
    Write-Host "   • Добавлен HTTP заголовок Content-Type" -ForegroundColor White
    Write-Host "   • Все файлы сохранены в правильной кодировке" -ForegroundColor White
}

Write-Host "`n🔍 Для тестирования откройте:" -ForegroundColor Yellow
Write-Host "   • encoding_debug.html - для диагностики" -ForegroundColor White
Write-Host "   • encoding_test.html - для быстрой проверки" -ForegroundColor White
Write-Host "   • index.html - основной сайт" -ForegroundColor White

Write-Host "`n💡 Если проблемы остались:" -ForegroundColor Magenta
Write-Host "   • Проверьте настройки браузера" -ForegroundColor White
Write-Host "   • Убедитесь, что .htaccess файл загружен на сервер" -ForegroundColor White
Write-Host "   • Попробуйте очистить кэш браузера (Ctrl+F5)" -ForegroundColor White

Read-Host "Press Enter to exit"
