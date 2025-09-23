# PowerShell script to unify all master cards to Alexey's layout
Write-Host "🎨 Unifying all master cards to Alexey's layout..." -ForegroundColor Yellow

# Read the current index.html file
$content = Get-Content "index.html" -Raw

# Function to convert a card to Alexey's layout
function Convert-ToAlexeyLayout {
    param(
        [string]$MasterId,
        [string]$MasterName,
        [string]$BorderColor,
        [string]$GradientColor,
        [string]$TextColor,
        [string]$Specialization,
        [string]$Experience,
        [string]$Status,
        [string]$WorkExtension = ".jpg"
    )
    
    # Pattern for compact layout (current state)
    $compactPattern = @"
                <div class="bg-white p-4 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-$BorderColor relative overflow-hidden cursor-pointer" onclick="openMasterGallery('$MasterId')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-$GradientColor"></div>
                    
                    <!-- Compact Layout: Photo and name on left, details on right -->
                    <div class="flex gap-4 mb-4">
                        <!-- Left side: Photo and name -->
                        <div class="flex-shrink-0">
                            <div class="relative w-20 h-20 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/$MasterId/master-photo.jpg', '$MasterName', '$MasterName', 'Мастер татуировки')">
                                <img src="gallery/$MasterId/master-photo.jpg" alt="$MasterName" class="w-full h-full object-cover">
                                <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                    <i class="fas fa-search-plus text-white text-sm"></i>
                                </div>
                            </div>
                            <h3 class="text-lg font-bold mt-2 text-center">$MasterName</h3>
                        </div>
                        
                        <!-- Right side: Details -->
                        <div class="flex-1 text-left">
                            <div class="space-y-1">
                                <p class="text-$TextColor font-medium text-xs">Специализация: $Specialization</p>
                                <p class="text-gray-600 text-xs">Опыт работы: $Experience</p>
                                <p class="text-$TextColor font-medium text-xs">$Status</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Works Preview -->
                    <div class="grid grid-cols-2 gap-2 mb-4" style="height: 120px;">
                        <div class="rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 1), 500);">
                            <img src="gallery/$MasterId/$MasterId-work-1$WorkExtension" alt="Работа 1" class="w-full h-full object-cover" loading="lazy">
                        </div>
                        <div class="rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 2), 500);">
                            <img src="gallery/$MasterId/$MasterId-work-2$WorkExtension" alt="Работа 2" class="w-full h-full object-cover" loading="lazy">
                        </div>
                        <div class="rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 3), 500);">
                            <img src="gallery/$MasterId/$MasterId-work-3$WorkExtension" alt="Работа 3" class="w-full h-full object-cover" loading="lazy">
                        </div>
                        <button onclick="event.stopPropagation(); openMasterGallery('$MasterId')" class="bg-gradient-to-br from-$GradientColor text-white rounded-lg flex flex-col items-center justify-center hover:from-$TextColor hover:to-$TextColor transition-all duration-200">
                            <i class="fas fa-images text-xl mb-1"></i>
                            <span class="text-xs font-medium">Показать больше</span>
                        </button>
                    </div>
                    
                    <button onclick="openBookingModal('$MasterName')" class="w-full bg-gradient-to-r from-$GradientColor text-white px-3 py-2 rounded-lg hover:from-$TextColor hover:to-$TextColor transition-all duration-200 transform hover:scale-105 text-sm">
                        Записаться
                    </button>
                </div>
"@

    # Pattern for Alexey's layout (target state)
    $alexeyPattern = @"
                <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-$BorderColor relative overflow-hidden cursor-pointer" onclick="openMasterGallery('$MasterId')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-$GradientColor"></div>
                    <div class="text-center">
                        <div class="relative w-32 h-32 mx-auto mb-6 rounded-full overflow-hidden border-4 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/$MasterId/master-photo.jpg', '$MasterName', '$MasterName', 'Мастер татуировки')">
                            <img src="gallery/$MasterId/master-photo.jpg" alt="$MasterName" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-$GradientColor opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-lg font-bold">$Experience</div>
                                    <div class="text-sm">$Specialization</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-2xl font-bold mb-2">$MasterName</h3>
                        <div class="text-center mb-4">
                            <p class="text-$TextColor font-medium text-sm mb-1">Специализация: $Specialization</p>
                            <p class="text-gray-600 text-xs mb-1">Опыт работы: $Experience</p>
                            <p class="text-$TextColor font-medium text-xs">$Status</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="grid grid-cols-2 gap-2 mb-4">
                            <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 1), 500);">
                                <img src="gallery/$MasterId/$MasterId-work-1$WorkExtension" alt="Работа 1" class="w-full h-full object-cover" loading="lazy">
                            </div>
                            <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 2), 500);">
                                <img src="gallery/$MasterId/$MasterId-work-2$WorkExtension" alt="Работа 2" class="w-full h-full object-cover" loading="lazy">
                            </div>
                            <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('$MasterId'); setTimeout(() => highlightWorkInGallery('$MasterId', 3), 500);">
                                <img src="gallery/$MasterId/$MasterId-work-3$WorkExtension" alt="Работа 3" class="w-full h-full object-cover" loading="lazy">
                            </div>
                            <button onclick="event.stopPropagation(); openMasterGallery('$MasterId')" class="aspect-square bg-gradient-to-br from-$GradientColor text-white rounded-lg flex flex-col items-center justify-center hover:from-$TextColor hover:to-$TextColor transition-all duration-200">
                                <i class="fas fa-images text-xl mb-1"></i>
                                <span class="text-xs font-medium">Показать больше</span>
                            </button>
                        </div>
                        <button onclick="openBookingModal('$MasterName')" class="w-full bg-gradient-to-r from-$GradientColor text-white px-4 py-2 rounded-lg hover:from-$TextColor hover:to-$TextColor transition-all duration-200 transform hover:scale-105">
                            Записаться
                        </button>
                    </div>
                </div>
"@

    return $content -replace [regex]::Escape($compactPattern), $alexeyPattern
}

# Convert each master card to Alexey's layout
Write-Host "Converting Булат's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "rocket" -MasterName "Булат" -BorderColor "orange-500" -GradientColor "orange-500 to-purple-500" -TextColor "orange-600" -Specialization "Графика" -Experience "10+ лет" -Status "🏛️ Резидент студии"

Write-Host "Converting Арсений's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "lozhkin" -MasterName "Арсений" -BorderColor "red-500" -GradientColor "red-500 to-pink-500" -TextColor "red-600" -Specialization "Японская татуировка" -Experience "8+ лет" -Status "🏛️ Резидент студии"

Write-Host "Converting Анастасия's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "nastasia" -MasterName "Анастасия" -BorderColor "pink-500" -GradientColor "pink-500 to-red-500" -TextColor "pink-600" -Specialization "Реализм, Чикано" -Experience "10+ лет" -Status "🏛️ Резидент студии"

Write-Host "Converting Дина's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "dina" -MasterName "Дина" -BorderColor "teal-500" -GradientColor "teal-500 to-cyan-500" -TextColor "teal-600" -Specialization "Акварельная, Ботаническая" -Experience "8 лет" -Status "🏛️ Резидент студии" -WorkExtension ".jpg"

Write-Host "Converting Михаил Б.'s card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "barabanov" -MasterName "Михаил Б." -BorderColor "indigo-500" -GradientColor "indigo-500 to-purple-500" -TextColor "indigo-600" -Specialization "Neotraditional" -Experience "10+ лет" -Status "🌍 Гостевой мастер" -WorkExtension ".JPG"

Write-Host "Converting Фларик's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "flo" -MasterName "Фларик" -BorderColor "emerald-500" -GradientColor "emerald-500 to-teal-500" -TextColor "emerald-600" -Specialization "Орнаментал, Полинезия, Борнео" -Experience "10+ лет" -Status "🏛️ Резидент студии"

Write-Host "Converting Михаил А.'s card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "atlasov" -MasterName "Михаил А." -BorderColor "gray-500" -GradientColor "gray-500 to-slate-500" -TextColor "gray-600" -Specialization "Минималистичная татуировка" -Experience "10+ лет" -Status "🏛️ Резидент студии"

Write-Host "Converting Лейла's card to Alexey's layout..." -ForegroundColor Yellow
$content = Convert-ToAlexeyLayout -MasterId "leyla" -MasterName "Лейла" -BorderColor "indigo-500" -GradientColor "indigo-500 to-purple-500" -TextColor "indigo-600" -Specialization "Орнаментальная татуировка" -Experience "5 лет" -Status "🏛️ Резидент студии"

# Save the unified content
$content | Out-File "index.html" -Encoding UTF8

Write-Host "✅ All master cards unified to Alexey's layout!" -ForegroundColor Green
Write-Host "📋 All cards now have:" -ForegroundColor Cyan
Write-Host "  - Padding: p-8" -ForegroundColor White
Write-Host "  - Avatar size: w-32 h-32" -ForegroundColor White
Write-Host "  - Center-aligned layout" -ForegroundColor White
Write-Host "  - Text sizes: text-2xl for name, text-sm for details" -ForegroundColor White
Write-Host "  - Aspect-square previews" -ForegroundColor White
Write-Host "  - Hover effects on avatar" -ForegroundColor White
Write-Host "  - Consistent button sizing" -ForegroundColor White

