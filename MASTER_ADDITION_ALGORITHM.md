# Алгоритм добавления нового мастера на сайт

## 📋 Пошаговая инструкция

### 1. Подготовка фотографий мастера

#### 1.1 Анализ исходных файлов
```bash
# Проверить содержимое папки мастера
list_dir "masters/[имя-папки-мастера]"
```

#### 1.2 Создание папки галереи
```bash
# Создать папку для галереи мастера
New-Item -ItemType Directory -Path "gallery\[имя-мастера]" -Force
```

#### 1.3 Копирование аватара
```bash
# Скопировать аватар (заменить на реальное имя файла)
Copy-Item "masters\[имя-папки-мастера]\[файл-аватара]" "gallery\[имя-мастера]\master-photo.jpg"
```

#### 1.4 Копирование работ
```bash
# Скопировать все работы и переименовать
$files = Get-ChildItem "masters\[имя-папки-мастера]\*.JPG", "masters\[имя-папки-мастера]\*.jpg" | Where-Object { $_.Name -ne "[файл-аватара]" }
for($i=0; $i -lt $files.Length; $i++) { 
    $workNum = $i + 1
    Copy-Item $files[$i].FullName "gallery\[имя-мастера]\[имя-мастера]-work-$workNum.jpg" 
}
```

#### 1.5 Проверка количества файлов
```bash
# Проверить количество созданных файлов
Get-ChildItem "gallery\[имя-мастера]\[имя-мастера]-work-*.jpg" | Measure-Object | Select-Object Count
```

### 2. Добавление карточки мастера в HTML

#### 2.1 Найти место для вставки
```bash
# Найти последнюю карточку мастера (например, leyla)
grep -n "openMasterGallery('leyla')" index.html
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
            <p class="text-[цвет]-600 font-medium text-sm">🏛️ Резидент студии</p>
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

### 3. Обновление данных для ротации

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

### 4. Добавление модального окна галереи

#### 4.1 Найти место для вставки
```bash
# Найти конец файла перед </body>
grep -n "</body>" index.html
```

#### 4.2 Шаблон модального окна
```html
<!-- [Имя мастера] Gallery -->
<div id="[имя-мастера]-gallery" class="gallery-modal fixed inset-0 bg-black/95 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
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
                    <span class="bg-gradient-to-r from-[цвет]-500 to-[цвет2]-500 text-white px-3 py-1 rounded-full text-xs font-semibold">🏛️ Резидент студии</span>
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
                <div class="bg-white p-3 border-b flex justify-between items-center">
                    <div class="flex items-center gap-4">
                        <span class="text-gray-600">Работы:</span>
                        <span id="[имя-мастера]-current-page" class="font-bold text-[цвет]-600">1</span>
                        <span class="text-gray-400">из</span>
                        <span id="[имя-мастера]-total-pages" class="font-bold text-gray-600">1</span>
                    </div>
                    <div class="flex gap-2">
                        <button onclick="previousPage('[имя-мастера]')" class="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors text-sm">
                            <i class="fas fa-chevron-left"></i> Назад
                        </button>
                        <button onclick="nextPage('[имя-мастера]')" class="px-3 py-1 bg-[цвет]-500 hover:bg-[цвет]-600 text-white rounded-lg transition-colors text-sm">
                            Вперед <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Gallery Grid -->
                <div class="flex-1 p-4 overflow-y-auto">
                    <div id="[имя-мастера]-gallery-grid" class="grid grid-cols-2 md:grid-cols-3 gap-4">
                        <!-- Gallery items will be loaded here -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
```

## 🎨 Цветовые схемы для мастеров

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

### Доступные цветовые схемы:
- `slate-500` → `gray-500`
- `zinc-500` → `neutral-500`
- `stone-500` → `gray-500`
- `lime-500` → `green-500`
- `sky-500` → `blue-500`
- `fuchsia-500` → `pink-500`

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

## 🚀 Команды для фиксации изменений

```bash
# Добавить все изменения
git add .

# Зафиксировать с описанием
git commit -m "Добавлен новый мастер [Имя мастера]

✅ Создана галерея: [количество] работ + аватар
✅ Добавлена карточка мастера с [специализация]
✅ Обновлены данные для ротации
✅ Добавлено модальное окно галереи
✅ Интеграция с системой ротации"
```

## 📝 Примеры заполнения

### Для мастера "Иван К.":
- **имя-мастера**: `ivan-k`
- **Имя мастера**: `Иван К.`
- **стаж**: `3`
- **специализация**: `Минимализм`
- **цвет**: `slate-500`
- **цвет2**: `gray-500`
- **количество-работ**: `12`

### Для мастера "Мария Л.":
- **имя-мастера**: `maria-l`
- **Имя мастера**: `Мария Л.`
- **стаж**: `7`
- **специализация**: `Портретная татуировка`
- **цвет**: `fuchsia-500`
- **цвет2**: `pink-500`
- **количество-работ**: `25`

---

**Важно**: Всегда проверяйте количество реальных файлов перед указанием в данных!
