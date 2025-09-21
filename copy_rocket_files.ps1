# Скрипт для быстрого копирования файлов мастера Rocket
Write-Host "Копируем файлы мастера Булата Rocket..." -ForegroundColor Green

# Копируем работы мастера
Copy-Item "masters\rocket\IMG_1113.jpg" "portfolio-rocket-1.jpg" -Force
Copy-Item "masters\rocket\IMG_3487.JPG" "portfolio-rocket-2.jpg" -Force
Copy-Item "masters\rocket\IMG_4625.jpg" "portfolio-rocket-3.jpg" -Force
Copy-Item "masters\rocket\IMG_5806.jpg" "portfolio-rocket-4.jpg" -Force
Copy-Item "masters\rocket\IMG_6301.JPG" "portfolio-rocket-5.jpg" -Force
Copy-Item "masters\rocket\IMG_6624.jpg" "portfolio-rocket-6.jpg" -Force

Write-Host "Готово! Все файлы скопированы." -ForegroundColor Green
Write-Host "Теперь обновляем HTML..." -ForegroundColor Yellow
