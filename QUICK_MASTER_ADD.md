# Быстрое добавление мастера - Краткая инструкция

## 🚀 Быстрый старт

### 1. Подготовка файлов
```bash
# Создать папку
New-Item -ItemType Directory -Path "gallery\[имя-мастера]" -Force

# Скопировать аватар
Copy-Item "masters\[папка-мастера]\[аватар]" "gallery\[имя-мастера]\master-photo.jpg"

# Скопировать работы
$files = Get-ChildItem "masters\[папка-мастера]\*.JPG", "masters\[папка-мастера]\*.jpg" | Where-Object { $_.Name -ne "[аватар]" }
for($i=0; $i -lt $files.Length; $i++) { 
    $workNum = $i + 1
    Copy-Item $files[$i].FullName "gallery\[имя-мастера]\[имя-мастера]-work-$workNum.jpg" 
}
```

### 2. Обновить данные в index.html

#### masterWorksRotation:
```javascript
[имя-мастера]: {
    totalWorks: [количество-работ],
    currentIndex: 0
}
```

#### masterData:
```javascript
[имя-мастера]: {
    name: '[Имя мастера]',
    works: [количество-работ],
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

#### galleryState:
```javascript
[имя-мастера]: { currentPage: 1 }
```

### 3. Добавить карточку в HTML
Вставить после последней карточки мастера (найти `openMasterGallery('leyla')`)

### 4. Добавить модальное окно
Вставить перед `</body>`

## 🎨 Цветовые схемы
- `slate-500` → `gray-500`
- `lime-500` → `green-500` 
- `sky-500` → `blue-500`
- `fuchsia-500` → `pink-500`
- `amber-500` → `yellow-500`

## ✅ Чек-лист
- [ ] Файлы скопированы
- [ ] Данные обновлены
- [ ] Карточка добавлена
- [ ] Модальное окно добавлено
- [ ] Кнопки используют `previousPage`/`nextPage`
- [ ] Уникальная цветовая схема

## 📝 Пример
**Мастер**: Иван К., 3 года, Минимализм, 12 работ
- **имя-мастера**: `ivan-k`
- **цвет**: `slate-500`
- **количество-работ**: `12`
