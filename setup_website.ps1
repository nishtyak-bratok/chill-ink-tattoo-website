# Главный скрипт для настройки и обновления сайта Chill Ink Tattoo
Write-Host "Chill Ink Tattoo - Настройка сайта" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta

# Меню выбора действий
function Show-Menu {
    Write-Host "`nВыберите действие:" -ForegroundColor Yellow
    Write-Host "1. Добавить нового мастера" -ForegroundColor White
    Write-Host "2. Добавить несколько мастеров" -ForegroundColor White
    Write-Host "3. Оптимизировать изображения" -ForegroundColor White
    Write-Host "4. Добавить SEO оптимизацию" -ForegroundColor White
    Write-Host "5. Настроить аналитику" -ForegroundColor White
    Write-Host "6. Обновить существующие галереи" -ForegroundColor White
    Write-Host "7. Создать резервную копию" -ForegroundColor White
    Write-Host "8. Полная настройка сайта" -ForegroundColor White
    Write-Host "9. Выход" -ForegroundColor White
    Write-Host "`nВведите номер (1-9): " -ForegroundColor Cyan -NoNewline
}

# Функция для добавления нового мастера
function Add-NewMaster {
    Write-Host "`nДобавление нового мастера" -ForegroundColor Cyan
    Write-Host "=============================" -ForegroundColor Cyan
    
    $masterName = Read-Host "Введите имя мастера"
    $masterFolder = Read-Host "Введите папку мастера (латиницей, без пробелов)"
    $masterPhoto = Read-Host "Введите путь к фото мастера"
    $experience = Read-Host "Введите опыт работы (например: 5+ лет)"
    $style = Read-Host "Введите стиль мастера"
    $specialization = Read-Host "Введите специализацию"
    
    Write-Host "`nВведите навыки мастера (через запятую):" -ForegroundColor Yellow
    $skillsInput = Read-Host "Навыки"
    $skills = $skillsInput -split ',' | ForEach-Object { $_.Trim() }
    
    Write-Host "`nЗапускаем добавление мастера..." -ForegroundColor Green
    & ".\add_new_master.ps1" -MasterName $masterName -MasterFolder $masterFolder -MasterPhoto $masterPhoto -Experience $experience -Style $style -Specialization $specialization -Skills $skills
}

# Функция для добавления нескольких мастеров
function Add-MultipleMasters {
    Write-Host "`nДобавление нескольких мастеров" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    
    Write-Host "Создаем структуру папок для новых мастеров..." -ForegroundColor Yellow
    & ".\add_multiple_masters.ps1"
}

# Функция для оптимизации изображений
function Optimize-Images {
    Write-Host "`nОптимизация изображений" -ForegroundColor Cyan
    Write-Host "=========================" -ForegroundColor Cyan
    
    Write-Host "Запускаем оптимизацию..." -ForegroundColor Yellow
    & ".\optimize_images.ps1"
}

# Функция для SEO оптимизации
function Add-SEO {
    Write-Host "`nSEO оптимизация" -ForegroundColor Cyan
    Write-Host "=================" -ForegroundColor Cyan
    
    Write-Host "Добавляем SEO мета-теги и структурированные данные..." -ForegroundColor Yellow
    & ".\add_seo.ps1"
}

# Функция для настройки аналитики
function Setup-Analytics {
    Write-Host "`nНастройка аналитики" -ForegroundColor Cyan
    Write-Host "=====================" -ForegroundColor Cyan
    
    Write-Host "Добавляем Google Analytics, Яндекс.Метрику и другие инструменты..." -ForegroundColor Yellow
    & ".\setup_analytics.ps1"
}

# Функция для обновления существующих галерей
function Update-Galleries {
    Write-Host "`nОбновление существующих галерей" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    
    Write-Host "Обновляем галереи Алексея Renoit и Булата Rocket..." -ForegroundColor Yellow
    & ".\add_more_works.ps1"
}

# Функция для создания резервной копии
function Create-Backup {
    Write-Host "`nСоздание резервной копии" -ForegroundColor Cyan
    Write-Host "==========================" -ForegroundColor Cyan
    
    $backupName = "backup_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')"
    $backupPath = "..\$backupName"
    
    Write-Host "Создаем резервную копию в: $backupPath" -ForegroundColor Yellow
    
    try {
        Copy-Item -Path "." -Destination $backupPath -Recurse -Exclude "backup_*"
        Write-Host "Резервная копия создана успешно!" -ForegroundColor Green
    } catch {
        Write-Host "Ошибка при создании резервной копии: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Функция для полной настройки сайта
function Setup-FullWebsite {
    Write-Host "`nПолная настройка сайта" -ForegroundColor Cyan
    Write-Host "=========================" -ForegroundColor Cyan
    
    Write-Host "Выполняем полную настройку сайта..." -ForegroundColor Yellow
    
    # Создаем резервную копию
    Write-Host "`n1. Создаем резервную копию..." -ForegroundColor White
    Create-Backup
    
    # Обновляем галереи
    Write-Host "`n2. Обновляем существующие галереи..." -ForegroundColor White
    Update-Galleries
    
    # Оптимизируем изображения
    Write-Host "`n3. Оптимизируем изображения..." -ForegroundColor White
    Optimize-Images
    
    # Добавляем SEO
    Write-Host "`n4. Добавляем SEO оптимизацию..." -ForegroundColor White
    Add-SEO
    
    # Настраиваем аналитику
    Write-Host "`n5. Настраиваем аналитику..." -ForegroundColor White
    Setup-Analytics
    
    Write-Host "`nПолная настройка сайта завершена!" -ForegroundColor Magenta
    Write-Host "Следующие шаги:" -ForegroundColor Yellow
    Write-Host "1. Добавьте фото и работы новых мастеров" -ForegroundColor White
    Write-Host "2. Замените ID аналитики на реальные" -ForegroundColor White
    Write-Host "3. Протестируйте сайт" -ForegroundColor White
    Write-Host "4. Загрузите на хостинг" -ForegroundColor White
}

# Основной цикл программы
do {
    Show-Menu
    $choice = Read-Host
    
    switch ($choice) {
        "1" { Add-NewMaster }
        "2" { Add-MultipleMasters }
        "3" { Optimize-Images }
        "4" { Add-SEO }
        "5" { Setup-Analytics }
        "6" { Update-Galleries }
        "7" { Create-Backup }
        "8" { Setup-FullWebsite }
        "9" { 
            Write-Host "`nДо свидания! Удачи с вашим сайтом!" -ForegroundColor Magenta
            break 
        }
        default { 
            Write-Host "`nНеверный выбор. Попробуйте снова." -ForegroundColor Red
        }
    }
    
    if ($choice -ne "9") {
        Write-Host "`nНажмите любую клавишу для продолжения..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    
} while ($choice -ne "9")

Write-Host "`nСпасибо за использование Chill Ink Tattoo Website Setup!" -ForegroundColor Magenta