# Quick script to fix remaining cards
Write-Host "🔧 Fixing remaining cards to Alexey's layout..." -ForegroundColor Yellow

# Read the file
$content = Get-Content "index.html" -Raw

# Fix Flarik's card
$content = $content -replace 'class="bg-white p-4 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-emerald-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery\(''flo''\)"', 'class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-emerald-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery(''flo'')"'

# Fix Mikhail A.'s card  
$content = $content -replace 'class="bg-white p-4 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-gray-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery\(''atlasov''\)"', 'class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-gray-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery(''atlasov'')"'

# Fix Leyla's card
$content = $content -replace 'class="bg-white p-4 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-indigo-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery\(''leyla''\)"', 'class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border-2 border-indigo-500 relative overflow-hidden cursor-pointer" onclick="openMasterGallery(''leyla'')"'

# Save the file
$content | Out-File "index.html" -Encoding UTF8

Write-Host "✅ Remaining cards updated!" -ForegroundColor Green
Write-Host "📋 All cards now have p-8 padding like Alexey's card" -ForegroundColor Cyan

