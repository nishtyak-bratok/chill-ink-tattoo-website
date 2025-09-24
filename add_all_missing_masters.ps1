# Add all missing masters to index.html
Write-Host "Adding all missing masters..." -ForegroundColor Cyan

# Read the current file
$content = Get-Content -Path "index.html" -Raw

# Define all missing masters with proper Russian encoding
$nesMaster = @"
                
                <!-- Nes -->
                <div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-sky-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('nes')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-sky-500 to-blue-500"></div>
                    <div class="text-center">
                        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/nes/master-photo.jpg', 'Нияз', 'Нияз', 'Мастер орнамента и авторского стиля с 10+ летним опытом')">
                            <img src="gallery/nes/master-photo.jpg" alt="Нияз" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-sky-500/80 to-blue-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-xs font-bold">10+ лет</div>
                                    <div class="text-xs">Орнаменты</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-xs"></i>
                            </div>
                        </div>
                        <h3 class="text-xl font-bold mb-1 text-gray-800">Нияз</h3>
                        <div class="text-center mb-3">
                            <p class="text-sky-600 font-medium text-sm mb-1">Специализация: Орнаменты, Авторский стиль</p>
                            <p class="text-gray-600 text-sm mb-1">Опыт: 10+ лет</p>
                            <p class="text-sky-600 font-medium text-sm">Постоянный мастер</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="mb-3">
                            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('nes'); setTimeout(() => highlightWorkInGallery('nes', 1), 500);">
                                    <img src="gallery/nes/nes-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('nes'); setTimeout(() => highlightWorkInGallery('nes', 2), 500);">
                                    <img src="gallery/nes/nes-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('nes'); setTimeout(() => highlightWorkInGallery('nes', 3), 500);">
                                    <img src="gallery/nes/nes-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <button onclick="event.stopPropagation(); openMasterGallery('nes')" class="aspect-square bg-gradient-to-br from-sky-500 to-blue-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-sky-600 hover:to-blue-600 transition-all duration-200">
                                    <i class="fas fa-images text-sm mb-1"></i>
                                    <span class="text-sm font-medium">Показать больше</span>
                                </button>
                            </div>
                        </div>
                        <button onclick="openBookingModal('Нияз')" class="w-full bg-gradient-to-r from-sky-500 to-blue-500 text-white px-4 py-2 rounded-lg hover:from-sky-600 hover:to-blue-600 transition-all duration-200 transform hover:scale-105 text-sm">
                            Записаться
                        </button>
                    </div>
                </div>
"@

$chernozzemMaster = @"
                
                <!-- Chernozzem -->
                <div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-lime-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('chernozzem')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-lime-500 to-green-500"></div>
                    <div class="text-center">
                        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/chernozzem/master-photo.jpg', 'Чернозём', 'Чернозём', 'Мастер реализма с 8+ летним опытом')">
                            <img src="gallery/chernozzem/master-photo.jpg" alt="Чернозём" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-lime-500/80 to-green-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-xs font-bold">8+ лет</div>
                                    <div class="text-xs">Реализм</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-xs"></i>
                            </div>
                        </div>
                        <h3 class="text-xl font-bold mb-1 text-gray-800">Чернозём</h3>
                        <div class="text-center mb-3">
                            <p class="text-lime-600 font-medium text-sm mb-1">Специализация: Реализм</p>
                            <p class="text-gray-600 text-sm mb-1">Опыт: 8+ лет</p>
                            <p class="text-lime-600 font-medium text-sm">Постоянный мастер</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="mb-3">
                            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('chernozzem'); setTimeout(() => highlightWorkInGallery('chernozzem', 1), 500);">
                                    <img src="gallery/chernozzem/chernozzem-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('chernozzem'); setTimeout(() => highlightWorkInGallery('chernozzem', 2), 500);">
                                    <img src="gallery/chernozzem/chernozzem-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('chernozzem'); setTimeout(() => highlightWorkInGallery('chernozzem', 3), 500);">
                                    <img src="gallery/chernozzem/chernozzem-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <button onclick="event.stopPropagation(); openMasterGallery('chernozzem')" class="aspect-square bg-gradient-to-br from-lime-500 to-green-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-lime-600 hover:to-green-600 transition-all duration-200">
                                    <i class="fas fa-images text-sm mb-1"></i>
                                    <span class="text-sm font-medium">Показать больше</span>
                                </button>
                            </div>
                        </div>
                        <button onclick="openBookingModal('Чернозём')" class="w-full bg-gradient-to-r from-lime-500 to-green-500 text-white px-4 py-2 rounded-lg hover:from-lime-600 hover:to-green-600 transition-all duration-200 transform hover:scale-105 text-sm">
                            Записаться
                        </button>
                    </div>
                </div>
"@

$arturMaster = @"
                
                <!-- Artur -->
                <div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-slate-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('artur')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-slate-500 to-gray-500"></div>
                    <div class="text-center">
                        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/artur/master-photo.jpg', 'Артур', 'Артур', 'Мастер графической татуировки с 7+ летним опытом')">
                            <img src="gallery/artur/master-photo.jpg" alt="Артур" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-slate-500/80 to-gray-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-xs font-bold">7+ лет</div>
                                    <div class="text-xs">Графика</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-xs"></i>
                            </div>
                        </div>
                        <h3 class="text-xl font-bold mb-1 text-gray-800">Артур</h3>
                        <div class="text-center mb-3">
                            <p class="text-slate-600 font-medium text-sm mb-1">Специализация: Графическая татуировка</p>
                            <p class="text-gray-600 text-sm mb-1">Опыт: 7+ лет</p>
                            <p class="text-slate-600 font-medium text-sm">Постоянный мастер</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="mb-3">
                            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('artur'); setTimeout(() => highlightWorkInGallery('artur', 1), 500);">
                                    <img src="gallery/artur/artur-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('artur'); setTimeout(() => highlightWorkInGallery('artur', 2), 500);">
                                    <img src="gallery/artur/artur-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('artur'); setTimeout(() => highlightWorkInGallery('artur', 3), 500);">
                                    <img src="gallery/artur/artur-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <button onclick="event.stopPropagation(); openMasterGallery('artur')" class="aspect-square bg-gradient-to-br from-slate-500 to-gray-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-slate-600 hover:to-gray-600 transition-all duration-200">
                                    <i class="fas fa-images text-sm mb-1"></i>
                                    <span class="text-sm font-medium">Показать больше</span>
                                </button>
                            </div>
                        </div>
                        <button onclick="openBookingModal('Артур')" class="w-full bg-gradient-to-r from-slate-500 to-gray-500 text-white px-4 py-2 rounded-lg hover:from-slate-600 hover:to-gray-600 transition-all duration-200 transform hover:scale-105 text-sm">
                            Записаться
                        </button>
                    </div>
                </div>
"@

$sodaMaster = @"
                
                <!-- Soda -->
                <div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-fuchsia-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('soda')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-fuchsia-500 to-pink-500"></div>
                    <div class="text-center">
                        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/soda/master-photo.jpg', 'Сода', 'Сода', 'Мастер акварельной татуировки с 6+ летним опытом')">
                            <img src="gallery/soda/master-photo.jpg" alt="Сода" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-fuchsia-500/80 to-pink-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-xs font-bold">6+ лет</div>
                                    <div class="text-xs">Акварель</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-xs"></i>
                            </div>
                        </div>
                        <h3 class="text-xl font-bold mb-1 text-gray-800">Сода</h3>
                        <div class="text-center mb-3">
                            <p class="text-fuchsia-600 font-medium text-sm mb-1">Специализация: Акварельная татуировка</p>
                            <p class="text-gray-600 text-sm mb-1">Опыт: 6+ лет</p>
                            <p class="text-fuchsia-600 font-medium text-sm">Постоянный мастер</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="mb-3">
                            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('soda'); setTimeout(() => highlightWorkInGallery('soda', 1), 500);">
                                    <img src="gallery/soda/soda-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('soda'); setTimeout(() => highlightWorkInGallery('soda', 2), 500);">
                                    <img src="gallery/soda/soda-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('soda'); setTimeout(() => highlightWorkInGallery('soda', 3), 500);">
                                    <img src="gallery/soda/soda-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <button onclick="event.stopPropagation(); openMasterGallery('soda')" class="aspect-square bg-gradient-to-br from-fuchsia-500 to-pink-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-fuchsia-600 hover:to-pink-600 transition-all duration-200">
                                    <i class="fas fa-images text-sm mb-1"></i>
                                    <span class="text-sm font-medium">Показать больше</span>
                                </button>
                            </div>
                        </div>
                        <button onclick="openBookingModal('Сода')" class="w-full bg-gradient-to-r from-fuchsia-500 to-pink-500 text-white px-4 py-2 rounded-lg hover:from-fuchsia-600 hover:to-pink-600 transition-all duration-200 transform hover:scale-105 text-sm">
                            Записаться
                        </button>
                    </div>
                </div>
"@

# Insert all masters before the closing div
$allMasters = $nesMaster + $chernozzemMaster + $arturMaster + $sodaMaster
$content = $content -replace '(\s+</div>\s+</div>\s+</section>)', "$allMasters`n`$1"

# Save the file
$content | Out-File -FilePath "index.html" -Encoding UTF8 -NoNewline

Write-Host "All missing masters added!" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
