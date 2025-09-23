# 🎨 Алгоритм добавления нового мастера на сайт Chill Ink Tattoo

## 📋 Полный пошаговый алгоритм

### 1️⃣ Подготовка файлов мастера

#### 1.1 Создание папки галереи
```powershell
# Создать папку в gallery с именем мастера (в нижнем регистре)
New-Item -ItemType Directory -Path "gallery\имя_мастера" -Force
```

#### 1.2 Копирование аватарки
```powershell
# Скопировать аватарку как master-photo.jpg
Copy-Item "masters\ИмяМастера\avatrar.JPG" "gallery\имя_мастера\master-photo.jpg" -Force
```

#### 1.3 Копирование фото работ
```powershell
# Получить все фото работ (исключая аватарку)
$workPhotos = Get-ChildItem "masters\ИмяМастера\*.jpg", "masters\ИмяМастера\*.JPG" | Where-Object { $_.Name -ne "avatrar.JPG" } | Sort-Object Name

# Скопировать с правильными именами
$counter = 1
foreach ($photo in $workPhotos) {
    $newName = "имя_мастера-work-$counter.jpg"
    Copy-Item $photo.FullName "gallery\имя_мастера\$newName" -Force
    Write-Host "Copied: $($photo.Name) -> $newName"
    $counter++
}
```

#### 1.4 Удаление дубликатов (если нужно)
```powershell
# Найти файлы одинакового размера
$files = Get-ChildItem "gallery\имя_мастера\имя_мастера-work-*.jpg" | Group-Object Length

# Удалить дубликаты
$files | Where-Object { $_.Count -gt 1 } | ForEach-Object { 
    $filesToDelete = $_.Group | Select-Object -Skip 1
    $filesToDelete | ForEach-Object { 
        Remove-Item $_.FullName -Force
        Write-Host "Deleted duplicate: $($_.Name)"
    }
}
```

#### 1.5 Переименование в правильную последовательность
```powershell
# Создать временную папку
New-Item -ItemType Directory -Path "gallery\имя_мастера\temp" -Force

# Переместить все work файлы во временную папку
Get-ChildItem "gallery\имя_мастера\имя_мастера-work-*.jpg" | Move-Item -Destination "gallery\имя_мастера\temp\"

# Переименовать в правильную последовательность
$tempFiles = Get-ChildItem "gallery\имя_мастера\temp\*.jpg" | Sort-Object Name
$counter = 1
foreach ($file in $tempFiles) {
    $newName = "имя_мастера-work-$counter.jpg"
    Move-Item $file.FullName "gallery\имя_мастера\$newName"
    Write-Host "Renamed: $($file.Name) -> $newName"
    $counter++
}

# Удалить временную папку
Remove-Item "gallery\имя_мастера\temp" -Force
```

### 2️⃣ Добавление HTML карточки мастера

#### 2.1 Найти место для карточки
- Открыть `index.html`
- Найти секцию `<!-- Artists Section -->`
- Найти `<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">`
- Добавить карточку перед закрывающим `</div>`

#### 2.2 Создать HTML карточку
```html
<div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-ЦВЕТ-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('имя_мастера')">
    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500"></div>
    <div class="text-center">
        <div class="relative w-32 h-32 mx-auto mb-6 rounded-full overflow-hidden border-4 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/имя_мастера/master-photo.jpg', 'Имя Мастера', 'Имя Мастера', 'Описание мастера')">
            <img src="gallery/имя_мастера/master-photo.jpg" alt="Имя Мастера" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
            <div class="absolute inset-0 bg-gradient-to-t from-ЦВЕТ-500/80 to-ЦВЕТ-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                <div class="text-white text-center">
                    <div class="text-lg font-bold">СТАЖ</div>
                    <div class="text-sm">СТИЛЬ</div>
                </div>
            </div>
            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                <i class="fas fa-search-plus text-white text-2xl"></i>
            </div>
        </div>
        <h3 class="text-2xl font-bold mb-2">Имя Мастера</h3>
        <p class="text-ЦВЕТ-600 font-semibold mb-2">Специализация: СТИЛЬ</p>
        <p class="text-gray-600 mb-2">Опыт работы: СТАЖ</p>
        <p class="text-ЦВЕТ-600 font-bold mb-4">🏛️ Резидент студии</p>
        <div class="flex flex-wrap justify-center gap-2 mb-4">
            <span class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-3 py-1 rounded-full text-sm">НАВЫК1</span>
            <span class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-3 py-1 rounded-full text-sm">НАВЫК2</span>
            <span class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-3 py-1 rounded-full text-sm">НАВЫК3</span>
            <span class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-3 py-1 rounded-full text-sm">НАВЫК4</span>
        </div>
        <button onclick="openBookingModal('Имя Мастера')" class="w-full bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-4 py-2 rounded-lg hover:from-ЦВЕТ-600 hover:to-ЦВЕТ-600 transition-all duration-200 transform hover:scale-105">
            Записаться
        </button>
    </div>
</div>
```

### 3️⃣ Добавление HTML галереи

#### 3.1 Найти место для галереи
- Найти `<!-- Booking Modal -->` в HTML
- Добавить галерею перед этим блоком

#### 3.2 Создать HTML галерею
```html
<!-- Имя Мастера Gallery -->
<div id="имя_мастера-gallery" class="gallery-modal fixed inset-0 bg-black/95 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl max-w-5xl w-full max-h-[85vh] overflow-hidden">
        <div class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white p-6 flex justify-between items-center">
            <h2 class="text-xl font-bold">Имя Мастера - Описание мастера</h2>
            <button onclick="closeMasterGallery('имя_мастера')" class="text-white hover:text-gray-300 text-3xl font-bold">&times;</button>
        </div>
        
        <!-- Main Content Layout -->
        <div class="flex flex-col lg:flex-row h-full">
            <!-- Master Info Section - Left Side -->
            <div class="lg:w-1/3 bg-gray-50 p-4 border-r">
                <div class="text-center mb-4">
                    <div class="w-24 h-24 mx-auto mb-3 rounded-full overflow-hidden border-4 border-white shadow-lg">
                        <img src="gallery/имя_мастера/master-photo.jpg" alt="Имя Мастера" class="w-full h-full object-cover">
                    </div>
                    <h3 class="text-lg font-bold text-gray-800">Имя Мастера</h3>
                    <p class="text-ЦВЕТ-600 font-semibold text-sm">СТИЛЬ</p>
                    <p class="text-gray-600 text-sm">СТАЖ</p>
                    <span class="bg-gradient-to-r from-ЦВЕТ-500 to-ЦВЕТ-500 text-white px-3 py-1 rounded-full text-xs font-semibold">🏛️ Резидент студии</span>
                </div>
                
                <div class="text-sm text-gray-700 space-y-3">
                    <p><strong>Специализация:</strong> СТИЛЬ</p>
                    <p><strong>Опыт работы:</strong> СТАЖ</p>
                    <p><strong>Стили:</strong> НАВЫКИ</p>
                    
                    <div class="mt-4">
                        <h4 class="font-semibold text-gray-800 mb-2">О мастере:</h4>
                        <p class="text-gray-600 text-xs leading-relaxed">
                            ОПИСАНИЕ МАСТЕРА
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Gallery Section - Right Side -->
            <div class="lg:w-2/3 flex flex-col">
                <!-- Gallery Controls -->
                <div class="bg-white p-3 border-b flex justify-between items-center">
                    <div class="flex items-center gap-4">
                        <span class="text-gray-600">Работы:</span>
                        <span id="имя_мастера-current-page" class="font-bold text-ЦВЕТ-600">1</span>
                        <span class="text-gray-400">из</span>
                        <span id="имя_мастера-total-pages" class="font-bold text-gray-600">1</span>
                    </div>
                    <div class="flex gap-2">
                        <button onclick="previousPage('имя_мастера')" class="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors text-sm">
                            <i class="fas fa-chevron-left"></i> Назад
                        </button>
                        <button onclick="nextPage('имя_мастера')" class="px-3 py-1 bg-ЦВЕТ-500 hover:bg-ЦВЕТ-600 text-white rounded-lg transition-colors text-sm">
                            Вперед <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Gallery Grid -->
                <div class="p-4 flex-1 overflow-y-auto">
                    <div id="имя_мастера-gallery-grid" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                        <!-- Works will be loaded dynamically -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
```

### 4️⃣ Добавление JavaScript конфигурации

#### 4.1 Найти конфигурацию мастеров
- Найти объект `const masters = {` в HTML
- Добавить конфигурацию нового мастера

#### 4.2 Добавить конфигурацию мастера
```javascript
имя_мастера: {
    name: 'Имя Мастера',
    works: КОЛИЧЕСТВО_РАБОТ, // количество работ + 1 аватар
    worksPerPage: 9,
    style: 'СТИЛЬ',
    works: Array.from({length: КОЛИЧЕСТВО_РАБОТ}, (_, i) => i + 1)
        .map((id, index) => ({
            id: id,
            src: `gallery/имя_мастера/имя_мастера-work-${id}.jpg`,
            title: `Работа ${id}`,
            style: 'СТИЛЬ • Имя Мастера'
        }))
}
```

#### 4.3 Добавить состояние пагинации
```javascript
// В объекте galleryState добавить:
имя_мастера: { currentPage: 1 }
```

### 5️⃣ Проверка функций JavaScript

#### 5.1 Проверить наличие функций
- `openMasterGallery()` - должна быть в script.js
- `closeMasterGallery()` - должна быть в script.js

#### 5.2 Если функций нет, добавить в script.js
```javascript
// Alias function for backward compatibility
function openMasterGallery(masterName) {
    openGallery(masterName);
}

// Close master gallery function
function closeMasterGallery(masterName) {
    closeGallery(masterName);
}
```

## 🎨 Пример использования (Михаил Атласов)

### Замените:
- `имя_мастера` → `atlasov`
- `Имя Мастера` → `Михаил Атласов`
- `ЦВЕТ` → `gray` (или другой цвет)
- `СТАЖ` → `10+ лет`
- `СТИЛЬ` → `Минималистичная татуировка`
- `КОЛИЧЕСТВО_РАБОТ` → `43`
- `НАВЫКИ` → `Минимализм, Геометрия, Линейная графика, Черно-белое`
- `ОПИСАНИЕ МАСТЕРА` → описание мастера

## ✅ Финальная проверка

1. **Файлы**: Все фото скопированы в `gallery/имя_мастера/`
2. **HTML карточка**: Добавлена в секцию Artists
3. **HTML галерея**: Добавлена перед Booking Modal
4. **JavaScript конфигурация**: Добавлена в объект masters
5. **Состояние пагинации**: Добавлено в galleryState
6. **Функции**: openMasterGallery и closeMasterGallery существуют

## 🚀 Результат

После выполнения всех шагов:
- Карточка мастера отображается в секции "Наши мастера"
- При клике открывается галерея с работами
- Работает пагинация и навигация
- Работает lightbox для увеличения фотографий

---

**Создано:** 2024
**Для проекта:** Chill Ink Tattoo Website
**Автор:** AI Assistant

