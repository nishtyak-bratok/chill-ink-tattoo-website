# 🎨 Полное руководство по добавлению мастеров на сайт Chill Ink

## 📋 Содержание
1. [Быстрый алгоритм](#быстрый-алгоритм)
2. [Пошаговая инструкция](#пошаговая-инструкция)
3. [Цветовые схемы](#цветовые-схемы)
4. [Критические исправления](#критические-исправления)
5. [Чек-лист проверки](#чек-лист-проверки)
6. [Примеры команд](#примеры-команд)
7. [Устранение проблем](#устранение-проблем)

---

## 🚀 Быстрый алгоритм

### 1. Анализ файлов
```bash
list_dir "masters/[имя-папки-мастера]"
```

### 2. Создание галереи
```bash
New-Item -ItemType Directory -Path "gallery/[имя-мастера]" -Force
Copy-Item "masters/[имя-папки-мастера]/[файл-аватара]" "gallery/[имя-мастера]/master-photo.jpg"
```

### 3. Копирование работ БЕЗ ДУБЛИКАТОВ ⚠️
```bash
$uniqueFiles = Get-ChildItem "masters/[имя-папки-мастера]/*.JPG", "masters/[имя-папки-мастера]/*.jpg" | Where-Object { $_.Name -ne "[файл-аватара]" } | Sort-Object Name | Get-Unique -AsString; for($i=0; $i -lt $uniqueFiles.Count; $i++) { $workNum = $i + 1; Copy-Item $uniqueFiles[$i].FullName "gallery/[имя-мастера]/[имя-мастера]-work-$workNum.jpg" }
```

### 4. Добавление в HTML
- Карточка мастера
- Данные в `masterWorksRotation`
- Данные в `masterData`
- Состояние в `galleryState`
- Модальное окно галереи

---

## 📝 Пошаговая инструкция

### Шаг 1: Подготовка фотографий мастера

#### 1.1 Анализ исходных файлов
```bash
# Проверить содержимое папки мастера
list_dir "masters/[имя-папки-мастера]"
```

#### 1.2 Создание папки галереи
```bash
# Создать папку для галереи мастера
New-Item -ItemType Directory -Path "gallery/[имя-мастера]" -Force
```

#### 1.3 Копирование аватара
```bash
# Скопировать аватар (заменить на реальное имя файла)
Copy-Item "masters/[имя-папки-мастера]/[файл-аватара]" "gallery/[имя-мастера]/master-photo.jpg"
```

#### 1.4 Копирование работ (КРИТИЧЕСКИ ВАЖНО - БЕЗ ДУБЛИКАТОВ)
```bash
# Правильный способ копирования без дубликатов
$uniqueFiles = Get-ChildItem "masters/[имя-папки-мастера]/*.JPG", "masters/[имя-папки-мастера]/*.jpg" | Where-Object { $_.Name -ne "[файл-аватара]" } | Sort-Object Name | Get-Unique -AsString
for($i=0; $i -lt $uniqueFiles.Count; $i++) { 
    $workNum = $i + 1
    Copy-Item $uniqueFiles[$i].FullName "gallery/[имя-мастера]/[имя-мастера]-work-$workNum.jpg" 
}
```

#### 1.5 Проверка количества файлов
```bash
# Проверить количество созданных файлов
Get-ChildItem "gallery/[имя-мастера]/[имя-мастера]-work-*.jpg" | Measure-Object | Select-Object Count
```

### Шаг 2: Добавление карточки мастера в HTML

#### 2.1 Найти место для вставки
```bash
# Найти последнюю карточку мастера (например, julia)
grep -n "openMasterGallery('julia')" index.html
```

#### 2.2 Шаблон карточки мастера
```html
<!-- [Имя мастера] -->
<div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-[цвет]-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('[имя-мастера]')">
    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-[цвет]-500 to-[цвет2]-500"></div>
    <div class="text-center">
        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/[имя-мастера]/master-photo.jpg', '[Имя мастера]', '[Имя мастера]', '[Описание мастера]')">
            <img src="gallery/[имя-мастера]/master-photo.jpg" alt="[Имя мастера]" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
            <div class="absolute inset-0 bg-gradient-to-t from-[цвет]-500/80 to-[цвет2]-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                <div class="text-white text-center">
                    <div class="text-xs font-bold">[стаж] лет</div>
                    <div class="text-xs">[специализация]</div>
                </div>
            </div>
            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                <i class="fas fa-search-plus text-white text-xs"></i>
            </div>
        </div>
        <h3 class="text-xl font-bold mb-1 text-gray-800">[Имя мастера]</h3>
        <div class="text-center mb-3">
            <p class="text-[цвет]-600 font-medium text-sm mb-1">Специализация: [Специализация]</p>
            <p class="text-gray-600 text-sm mb-1">Опыт работы: [стаж] лет</p>
            <p class="text-[цвет]-600 font-medium text-sm">[статус]</p>
        </div>
        
        <!-- Works Preview -->
        <div class="mb-3">
            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('[имя-мастера]'); setTimeout(() => highlightWorkInGallery('[имя-мастера]', 1), 500);">
                    <img src="gallery/[имя-мастера]/[имя-мастера]-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                </div>
                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('[имя-мастера]'); setTimeout(() => highlightWorkInGallery('[имя-мастера]', 2), 500);">
                    <img src="gallery/[имя-мастера]/[имя-мастера]-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                </div>
                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('[имя-мастера]'); setTimeout(() => highlightWorkInGallery('[имя-мастера]', 3), 500);">
                    <img src="gallery/[имя-мастера]/[имя-мастера]-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                </div>
                <button onclick="event.stopPropagation(); openMasterGallery('[имя-мастера]')" class="aspect-square bg-gradient-to-br from-[цвет]-500 to-[цвет2]-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-[цвет]-600 hover:to-[цвет2]-600 transition-all duration-200">
                    <i class="fas fa-images text-sm mb-1"></i>
                    <span class="text-sm font-medium">Показать больше</span>
                </button>
            </div>
        </div>
        <button onclick="openBookingModal('[Имя мастера]')" class="w-full bg-gradient-to-r from-[цвет]-500 to-[цвет2]-500 text-white px-4 py-2 rounded-lg hover:from-[цвет]-600 hover:to-[цвет2]-600 transition-all duration-200 transform hover:scale-105 text-sm">
            Записаться
        </button>
    </div>
</div>
```

### Шаг 3: Обновление данных для ротации

#### 3.1 Добавление в masterWorksRotation
```javascript
// Найти const masterWorksRotation и добавить:
[имя-мастера]: {
    totalWorks: [количество-работ],
    currentIndex: 0
}
```

#### 3.2 Добавление в masterData
```javascript
// Найти const masterData и добавить:
[имя-мастера]: {
    name: '[Имя мастера]',
    works: [количество-работ], // количество работ + 1 аватар
    worksPerPage: 9,
    style: '[Специализация]',
    works: Array.from({length: [количество-работ]}, (_, i) => i + 1)
        .map((id, index) => ({
            id: id,
            src: `gallery/[имя-мастера]/[имя-мастера]-work-${id}.jpg`,
            title: `Работа ${id}`,
            style: '[Специализация] • [Имя мастера]'
        }))
}
```

#### 3.3 Добавление в galleryState
```javascript
// Найти const galleryState и добавить:
[имя-мастера]: { currentPage: 1 }
```

### Шаг 4: Добавление модального окна галереи

#### 4.1 Найти место для вставки
```bash
# Найти конец файла перед </body>
grep -n "</body>" index.html
```

#### 4.2 Шаблон модального окна
```html
<!-- [Имя мастера] Gallery -->
<div id="[имя-мастера]-gallery" class="gallery-modal fixed inset-0 bg-black/95 backdrop-blur-md z-[60] hidden flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl max-w-5xl w-full max-h-[85vh] overflow-hidden">
        <div class="bg-gradient-to-r from-[цвет]-500 to-[цвет2]-500 text-white p-6 flex justify-between items-center">
            <h2 class="text-xl font-bold">[Имя мастера] - [Специализация]</h2>
            <button onclick="closeMasterGallery('[имя-мастера]')" class="text-white hover:text-gray-300 text-3xl font-bold">&times;</button>
        </div>
        
        <!-- Main Content Layout -->
        <div class="flex flex-col lg:flex-row h-full">
            <!-- Master Info Section - Left Side -->
            <div class="lg:w-1/3 bg-gray-50 p-4 border-r">
                <div class="text-center mb-4">
                    <div class="w-24 h-24 mx-auto mb-3 rounded-full overflow-hidden border-4 border-white shadow-lg">
                        <img src="gallery/[имя-мастера]/master-photo.jpg" alt="[Имя мастера]" class="w-full h-full object-cover">
                    </div>
                    <h3 class="text-lg font-bold text-gray-800">[Имя мастера]</h3>
                    <p class="text-[цвет]-600 font-semibold text-sm">[Специализация]</p>
                    <p class="text-gray-600 text-sm">[стаж] лет опыта</p>
                    <span class="bg-gradient-to-r from-[цвет]-500 to-[цвет2]-500 text-white px-3 py-1 rounded-full text-xs font-semibold">[статус]</span>
                </div>
                
                <div class="text-sm text-gray-700 space-y-3">
                    <p><strong>Специализация:</strong> [Специализация]</p>
                    <p><strong>Опыт работы:</strong> [стаж] лет</p>
                    <p><strong>Стили:</strong> [Список стилей]</p>
                    
                    <div class="mt-4">
                        <h4 class="font-semibold text-gray-800 mb-2">О мастере:</h4>
                        <p class="text-gray-600 text-xs leading-relaxed">
                            [Подробное описание мастера]
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Gallery Section - Right Side -->
            <div class="lg:w-2/3 flex flex-col">
                <!-- Gallery Controls -->
                <div class="bg-white p-3 border-b flex justify-between items-center relative z-[65]">
                    <div class="flex items-center gap-4">
                        <span class="text-gray-600">Работы:</span>
                        <span id="[имя-мастера]-current-page" class="font-bold text-[цвет]-600">1</span>
                        <span class="text-gray-400">из</span>
                        <span id="[имя-мастера]-total-pages" class="font-bold text-gray-600">1</span>
                    </div>
                    <div class="flex gap-2">
                        <button onclick="previousPage('[имя-мастера]')" class="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors text-sm relative z-[66]">
                            <i class="fas fa-chevron-left"></i> Назад
                        </button>
                        <button onclick="nextPage('[имя-мастера]')" class="px-3 py-1 bg-[цвет]-500 hover:bg-[цвет]-600 text-white rounded-lg transition-colors text-sm relative z-[66]">
                            Вперед <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Gallery Grid -->
                <div class="flex-1 p-4 overflow-y-auto relative z-[65]">
                    <div id="[имя-мастера]-gallery-grid" class="grid grid-cols-2 md:grid-cols-3 gap-4 relative z-[65]">
                        <!-- Gallery items will be loaded here -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
```

---

## 🎨 Цветовые схемы

### Используемые цветовые комбинации:
- **renoit**: `purple-500` → `orange-500`
- **rocket**: `blue-500` → `cyan-500`
- **lozhkin**: `red-500` → `pink-500`
- **nastasia**: `pink-500` → `rose-500`
- **dina**: `emerald-500` → `teal-500`
- **barabanov**: `amber-500` → `yellow-500`
- **flo**: `violet-500` → `purple-500`
- **atlasov**: `indigo-500` → `blue-500`
- **leyla**: `indigo-500` → `purple-500`
- **aleksands**: `green-500` → `teal-500`
- **artur**: `slate-500` → `gray-500`
- **chernozzem**: `lime-500` → `green-500`
- **nes**: `sky-500` → `blue-500`
- **sergei**: `stone-500` → `gray-500`
- **julia**: `zinc-500` → `neutral-500`

### Доступные цветовые схемы:
- `fuchsia-500` → `pink-500`

### Статусы мастеров:
- 🏛️ **Резидент студии** - постоянные мастера
- 🌍 **Гостевой мастер** - приглашенные мастера

---

## 🔧 Критические исправления z-index

### Структура z-index (от низшего к высшему):
- **z-50**: существующие модальные окна галерей (9 мастеров)
- **z-[60]**: новые модальные окна галерей (5 мастеров)
- **z-[65]**: элементы навигации в новых галереях
- **z-[66]**: кнопки навигации в новых галереях
- **z-[70]**: lightbox-modal (открытие полных фотографий)
- **z-[75]**: элементы управления lightbox

### Применение z-index в модальных окнах:
```html
<!-- Модальное окно -->
<div id="[имя-мастера]-gallery" class="gallery-modal fixed inset-0 bg-black/95 backdrop-blur-md z-[60] hidden flex items-center justify-center p-4">

<!-- Gallery Controls -->
<div class="bg-white p-3 border-b flex justify-between items-center relative z-[65]">

<!-- Кнопки навигации -->
<button onclick="previousPage('[имя-мастера]')" class="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors text-sm relative z-[66]">

<!-- Gallery Grid -->
<div class="flex-1 p-4 overflow-y-auto relative z-[65]">
    <div id="[имя-мастера]-gallery-grid" class="grid grid-cols-2 md:grid-cols-3 gap-4 relative z-[65]">
```

---

## ✅ Чек-лист проверки

### После добавления мастера проверить:
- [ ] Фотографии скопированы в `gallery/[имя-мастера]/`
- [ ] Аватар переименован в `master-photo.jpg`
- [ ] Работы переименованы в `[имя-мастера]-work-1.jpg`, `[имя-мастера]-work-2.jpg`, и т.д.
- [ ] Карточка добавлена в HTML
- [ ] Данные добавлены в `masterWorksRotation`
- [ ] Данные добавлены в `masterData`
- [ ] Состояние добавлено в `galleryState`
- [ ] Модальное окно добавлено
- [ ] Кнопки навигации используют правильные функции (`previousPage`/`nextPage`)
- [ ] Цветовая схема уникальна
- [ ] Все ссылки и ID используют `[имя-мастера]`
- [ ] Z-index настроен правильно (z-[60] для модального окна)
- [ ] Lightbox работает на переднем плане (z-[70])

---

## 💻 Примеры команд

### Для мастера "Иван К.":
```bash
# Создание папки
New-Item -ItemType Directory -Path "gallery/ivan-k" -Force

# Копирование аватара
Copy-Item "masters/ivan-k/avatar.jpg" "gallery/ivan-k/master-photo.jpg"

# Копирование работ
$uniqueFiles = Get-ChildItem "masters/ivan-k/*.JPG", "masters/ivan-k/*.jpg" | Where-Object { $_.Name -ne "avatar.jpg" } | Sort-Object Name | Get-Unique -AsString
for($i=0; $i -lt $uniqueFiles.Count; $i++) { 
    $workNum = $i + 1
    Copy-Item $uniqueFiles[$i].FullName "gallery/ivan-k/ivan-k-work-$workNum.jpg" 
}

# Проверка
Get-ChildItem "gallery/ivan-k" | Measure-Object | Select-Object Count
```

### Параметры для мастера "Иван К.":
- **имя-мастера**: `ivan-k`
- **Имя мастера**: `Иван К.`
- **стаж**: `3`
- **специализация**: `Минимализм`
- **цвет**: `fuchsia-500`
- **цвет2**: `pink-500`
- **количество-работ**: `12`

---

## 🚨 Устранение проблем

### Проблема: Дублирующиеся файлы
**Причина**: Зависание процесса копирования
**Решение**: 
```bash
# Удалить все файлы
Remove-Item "gallery/[имя-мастера]/*" -Force

# Скопировать аватар
Copy-Item "masters/[имя-папки]/[файл-аватара]" "gallery/[имя-мастера]/master-photo.jpg"

# Скопировать работы с Get-Unique
$uniqueFiles = Get-ChildItem "masters/[имя-папки]/*.JPG", "masters/[имя-папки]/*.jpg" | Where-Object { $_.Name -ne "[файл-аватара]" } | Sort-Object Name | Get-Unique -AsString
for($i=0; $i -lt $uniqueFiles.Count; $i++) { 
    $workNum = $i + 1
    Copy-Item $uniqueFiles[$i].FullName "gallery/[имя-мастера]/[имя-мастера]-work-$workNum.jpg" 
}
```

### Проблема: Модальные окна открываются на заднем плане
**Причина**: Неправильный z-index
**Решение**: 
- Модальные окна новых мастеров: `z-[60]`
- Элементы навигации: `relative z-[65]`
- Кнопки навигации: `relative z-[66]`

### Проблема: Lightbox не работает у новых мастеров
**Причина**: Z-index lightbox ниже чем у галерей
**Решение**: 
- lightbox-modal: `z-[70]`
- Элементы управления lightbox: `z-[75]`

---

## 📝 Команды для фиксации изменений

```bash
# Добавить все изменения
git add .

# Зафиксировать с описанием
git commit -m "Добавлен новый мастер [Имя мастера]

✅ Создана галерея: [количество] работ + аватар
✅ Добавлена карточка мастера с [специализация]
✅ Обновлены данные для ротации
✅ Добавлено модальное окно галереи
✅ Интеграция с системой ротации
✅ Настроен правильный z-index"
```

---

## 🎯 Важные моменты

1. **Использовать `Get-Unique -AsString`** для избежания дубликатов файлов
2. **Правильный z-index** для всех модальных элементов
3. **Уникальная цветовая схема** для каждого мастера
4. **Проверка количества файлов** перед указанием в данных
5. **Все ссылки используют `[имя-мастера]`** в нижнем регистре
6. **Статус мастера** (🏛️ Резидент студии / 🌍 Гостевой мастер)
7. **Lightbox должен работать** на переднем плане для всех мастеров

---

**Последнее обновление**: 24 сентября 2025
**Версия**: 2.0
**Статус**: Готов к использованию ✅
