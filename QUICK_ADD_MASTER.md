# 🚀 Быстрая шпаргалка: Добавление мастера

## 📝 Шаблон данных мастера
```
Имя: [Имя Мастера]
Папка: [имя_мастера] (в нижнем регистре)
Стаж: [X+ лет]
Стиль: [Стиль татуировки]
Количество работ: [N]
Цвет: [purple/orange/red/pink/teal/indigo/emerald/gray]
Навыки: [Навык1, Навык2, Навык3, Навык4]
```

## ⚡ Быстрые команды PowerShell

### 1. Создание папки и копирование файлов
```powershell
# Создать папку
New-Item -ItemType Directory -Path "gallery\имя_мастера" -Force

# Копировать аватарку
Copy-Item "masters\ИмяМастера\avatrar.JPG" "gallery\имя_мастера\master-photo.jpg" -Force

# Копировать работы
$workPhotos = Get-ChildItem "masters\ИмяМастера\*.jpg", "masters\ИмяМастера\*.JPG" | Where-Object { $_.Name -ne "avatrar.JPG" } | Sort-Object Name
$counter = 1
foreach ($photo in $workPhotos) {
    $newName = "имя_мастера-work-$counter.jpg"
    Copy-Item $photo.FullName "gallery\имя_мастера\$newName" -Force
    $counter++
}
```

## 🎯 Что добавить в HTML

### 1. Карточка мастера (в секции Artists)
```html
<div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-ЦВЕТ-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('имя_мастера')">
    <!-- Содержимое карточки -->
</div>
```

### 2. Галерея мастера (перед Booking Modal)
```html
<div id="имя_мастера-gallery" class="gallery-modal fixed inset-0 bg-black/95 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
    <!-- Содержимое галереи -->
</div>
```

## 🔧 JavaScript конфигурация

### 1. В объект masters добавить:
```javascript
имя_мастера: {
    name: 'Имя Мастера',
    works: N, // количество работ
    worksPerPage: 9,
    style: 'СТИЛЬ',
    works: Array.from({length: N}, (_, i) => i + 1)
        .map((id, index) => ({
            id: id,
            src: `gallery/имя_мастера/имя_мастера-work-${id}.jpg`,
            title: `Работа ${id}`,
            style: 'СТИЛЬ • Имя Мастера'
        }))
}
```

### 2. В объект galleryState добавить:
```javascript
имя_мастера: { currentPage: 1 }
```

## 🎨 Цветовые схемы
- **purple** - фиолетовый (основные мастера)
- **orange** - оранжевый
- **red** - красный (японская татуировка)
- **pink** - розовый (реализм)
- **teal** - бирюзовый (акварель)
- **indigo** - индиго (гостевые мастера)
- **emerald** - изумрудный (традиционные стили)
- **gray** - серый (минимализм)

## ✅ Чек-лист
- [ ] Создана папка `gallery/имя_мастера`
- [ ] Скопирована аватарка как `master-photo.jpg`
- [ ] Скопированы работы как `имя_мастера-work-*.jpg`
- [ ] Добавлена HTML карточка в секцию Artists
- [ ] Добавлена HTML галерея перед Booking Modal
- [ ] Добавлена конфигурация в объект masters
- [ ] Добавлено состояние в galleryState
- [ ] Проверена работа галереи

---
**Время выполнения:** ~15-20 минут
**Сложность:** Средняя

