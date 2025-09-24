# Add missing masters to index.html
Write-Host "Adding missing masters..." -ForegroundColor Cyan

# Read the current file
$content = Get-Content -Path "index.html" -Raw

# Define the missing masters with proper Russian encoding
$sergeiMaster = @"
                
                <!-- Sergei -->
                <div class="bg-white p-6 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-stone-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery('sergei')">
                    <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-stone-500 to-gray-500"></div>
                    <div class="text-center">
                        <div class="relative w-20 h-20 mx-auto mb-2 rounded-full overflow-hidden border-2 border-white shadow-lg cursor-pointer" onclick="event.stopPropagation(); openLightbox('gallery/sergei/master-photo.jpg', 'Сергей', 'Сергей', 'Мастер татуировки с 10+ летним опытом')">
                            <img src="gallery/sergei/master-photo.jpg" alt="Сергей" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-stone-500/80 to-gray-500/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <div class="text-white text-center">
                                    <div class="text-xs font-bold">10+ лет</div>
                                    <div class="text-xs">Татуировки</div>
                                </div>
                            </div>
                            <div class="absolute inset-0 bg-black/20 opacity-0 hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                <i class="fas fa-search-plus text-white text-xs"></i>
                            </div>
                        </div>
                        <h3 class="text-xl font-bold mb-1 text-gray-800">Сергей</h3>
                        <div class="text-center mb-3">
                            <p class="text-stone-600 font-medium text-sm mb-1">Специализация: Татуировки</p>
                            <p class="text-gray-600 text-sm mb-1">Опыт: 10+ лет</p>
                            <p class="text-stone-600 font-medium text-sm">Постоянный мастер</p>
                        </div>
                        
                        <!-- Works Preview -->
                        <div class="mb-3">
                            <div class="grid grid-cols-2 gap-2 mb-2" style="max-width: 240px; margin: 0 auto;">
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('sergei'); setTimeout(() => highlightWorkInGallery('sergei', 1), 500);">
                                    <img src="gallery/sergei/sergei-work-1.jpg" alt="Работа 1" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('sergei'); setTimeout(() => highlightWorkInGallery('sergei', 2), 500);">
                                    <img src="gallery/sergei/sergei-work-2.jpg" alt="Работа 2" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <div class="aspect-square rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity" onclick="event.stopPropagation(); openMasterGallery('sergei'); setTimeout(() => highlightWorkInGallery('sergei', 3), 500);">
                                    <img src="gallery/sergei/sergei-work-3.jpg" alt="Работа 3" class="w-full h-full object-cover" loading="lazy" decoding="async">
                                </div>
                                <button onclick="event.stopPropagation(); openMasterGallery('sergei')" class="aspect-square bg-gradient-to-br from-stone-500 to-gray-500 text-white rounded-lg flex flex-col items-center justify-center hover:from-stone-600 hover:to-gray-600 transition-all duration-200">
                                    <i class="fas fa-images text-sm mb-1"></i>
                                    <span class="text-sm font-medium">Показать больше</span>
                                </button>
                            </div>
                        </div>
                        <button onclick="openBookingModal('Сергей')" class="w-full bg-gradient-to-r from-stone-500 to-gray-500 text-white px-4 py-2 rounded-lg hover:from-stone-600 hover:to-gray-600 transition-all duration-200 transform hover:scale-105 text-sm">
                            Записаться
                        </button>
                    </div>
                </div>
"@

# Insert Sergei before the closing div
$content = $content -replace '(\s+</div>\s+</div>\s+</section>)', "$sergeiMaster`n`$1"

# Save the file
$content | Out-File -FilePath "index.html" -Encoding UTF8 -NoNewline

Write-Host "Sergei master added!" -ForegroundColor Green
Write-Host "Done!" -ForegroundColor Cyan
