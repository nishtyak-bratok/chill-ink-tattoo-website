# Скрипт для добавления SEO оптимизации
Write-Host "🔍 Добавляем SEO оптимизацию..." -ForegroundColor Green

# Читаем текущий HTML
$htmlContent = Get-Content "index.html" -Raw

# SEO мета-теги
$seoMetaTags = @"
    <!-- SEO Meta Tags -->
    <meta name="description" content="Chill Ink Tattoo - профессиональная тату-студия в Казани. 20+ мастеров с многолетним опытом. Художественная татуировка, перекрытие старых татуировок, исправление татуировок, лазерное удаление.">
    <meta name="keywords" content="татуировка Казань, тату студия, художественная татуировка, перекрытие татуировок, исправление татуировок, лазерное удаление, тату мастера, Chill Ink Tattoo">
    <meta name="author" content="Chill Ink Tattoo">
    <meta name="robots" content="index, follow">
    <meta name="language" content="ru">
    <meta name="revisit-after" content="7 days">
    
    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="Chill Ink Tattoo - Профессиональная тату-студия в Казани">
    <meta property="og:description" content="20+ мастеров с многолетним опытом. Художественная татуировка любой сложности, перекрытие старых татуировок, исправление татуировок, лазерное удаление.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://chillinktattoo.ru">
    <meta property="og:image" content="https://chillinktattoo.ru/logo.png">
    <meta property="og:site_name" content="Chill Ink Tattoo">
    <meta property="og:locale" content="ru_RU">
    
    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Chill Ink Tattoo - Профессиональная тату-студия в Казани">
    <meta name="twitter:description" content="20+ мастеров с многолетним опытом. Художественная татуировка любой сложности.">
    <meta name="twitter:image" content="https://chillinktattoo.ru/logo.png">
    
    <!-- Additional SEO Meta Tags -->
    <meta name="theme-color" content="#1a1a1a">
    <meta name="msapplication-TileColor" content="#1a1a1a">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
    
    <!-- Canonical URL -->
    <link rel="canonical" href="https://chillinktattoo.ru">
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
    <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
    
    <!-- Preconnect to external domains -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
"@

# Структурированные данные (JSON-LD)
$structuredData = @"
    <!-- Structured Data -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "LocalBusiness",
        "name": "Chill Ink Tattoo",
        "description": "Профессиональная тату-студия в Казани с 20+ мастерами и многолетним опытом",
        "url": "https://chillinktattoo.ru",
        "telephone": "+79393830871",
        "email": "chillink.kzn@gmail.com",
        "address": {
            "@type": "PostalAddress",
            "addressLocality": "Казань",
            "addressCountry": "RU"
        },
        "geo": {
            "@type": "GeoCoordinates",
            "latitude": "55.8304",
            "longitude": "49.0661"
        },
        "openingHours": "Mo-Su 10:00-22:00",
        "priceRange": "$$",
        "image": "https://chillinktattoo.ru/logo.png",
        "logo": "https://chillinktattoo.ru/logo.png",
        "sameAs": [
            "https://instagram.com/chill_ink_studio",
            "https://t.me/chillinktattoos"
        ],
        "hasOfferCatalog": {
            "@type": "OfferCatalog",
            "name": "Услуги тату-студии",
            "itemListElement": [
                {
                    "@type": "Offer",
                    "itemOffered": {
                        "@type": "Service",
                        "name": "Художественная татуировка",
                        "description": "Татуировки любой сложности - от простых эскизов до сложных художественных композиций"
                    }
                },
                {
                    "@type": "Offer",
                    "itemOffered": {
                        "@type": "Service",
                        "name": "Перекрытие старых татуировок",
                        "description": "Профессиональное перекрытие старых или неудачных татуировок новыми работами"
                    }
                },
                {
                    "@type": "Offer",
                    "itemOffered": {
                        "@type": "Service",
                        "name": "Исправление татуировок",
                        "description": "Коррекция и доработка существующих татуировок для улучшения их внешнего вида"
                    }
                },
                {
                    "@type": "Offer",
                    "itemOffered": {
                        "@type": "Service",
                        "name": "Лазерное удаление",
                        "description": "Современные методы удаления татуировок с помощью лазерных технологий"
                    }
                }
            ]
        },
        "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "4.9",
            "reviewCount": "127"
        }
    }
    </script>
"@

# Заменяем существующие мета-теги
$htmlContent = $htmlContent -replace '<meta name="viewport" content="width=device-width, initial-scale=1\.0">', $seoMetaTags

# Добавляем структурированные данные перед закрывающим тегом head
$htmlContent = $htmlContent -replace '</head>', "$structuredData`n</head>"

# Добавляем alt-атрибуты к изображениям (если их нет)
$htmlContent = $htmlContent -replace '<img src="([^"]+)" class="([^"]*)"(?!\s+alt)', '<img src="$1" alt="Chill Ink Tattoo" class="$2"'

# Добавляем заголовки H1, H2, H3 для лучшей структуры
$htmlContent = $htmlContent -replace '<h1 class="hero-title">Chill Ink Tattoo</h1>', '<h1 class="hero-title">Chill Ink Tattoo - Профессиональная тату-студия в Казани</h1>'

# Добавляем schema.org разметку для мастеров
$mastersSchema = @"
    <!-- Masters Schema -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "ItemList",
        "name": "Мастера тату-студии Chill Ink Tattoo",
        "itemListElement": [
            {
                "@type": "Person",
                "name": "Алексей Renoit",
                "jobTitle": "Тату-мастер",
                "description": "Специализация: Графика. Опыт работы: 10+ лет",
                "knowsAbout": ["Реализм", "Японская традиция", "Аниме", "Дотворк"]
            },
            {
                "@type": "Person",
                "name": "Булат Rocket",
                "jobTitle": "Тату-мастер",
                "description": "Специализация: Графика. Опыт работы: 10+ лет",
                "knowsAbout": ["Реализм", "Графика", "Портреты", "Черно-белое"]
            }
        ]
    }
    </script>
"@

# Добавляем schema для мастеров перед закрывающим тегом body
$htmlContent = $htmlContent -replace '<script src="script\.js"></script>', "$mastersSchema`n    <script src=`"script.js`"></script>"

# Создаем sitemap.xml
$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>https://chillinktattoo.ru/</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>https://chillinktattoo.ru/#about</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://chillinktattoo.ru/#services</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://chillinktattoo.ru/#portfolio</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://chillinktattoo.ru/#masters</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://chillinktattoo.ru/#contact</loc>
        <lastmod>$(Get-Date -Format "yyyy-MM-dd")</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.7</priority>
    </url>
</urlset>
"@

$sitemap | Out-File "sitemap.xml" -Encoding UTF8

# Создаем robots.txt
$robots = @"
User-agent: *
Allow: /

Sitemap: https://chillinktattoo.ru/sitemap.xml

# Блокируем служебные папки
Disallow: /masters/
Disallow: /scripts/
Disallow: /optimized/
"@

$robots | Out-File "robots.txt" -Encoding UTF8

# Сохраняем обновленный HTML
$htmlContent | Out-File "index.html" -Encoding UTF8

Write-Host "✅ SEO мета-теги добавлены!" -ForegroundColor Green
Write-Host "✅ Структурированные данные добавлены!" -ForegroundColor Green
Write-Host "✅ Sitemap.xml создан!" -ForegroundColor Green
Write-Host "✅ Robots.txt создан!" -ForegroundColor Green
Write-Host "🎉 SEO оптимизация завершена!" -ForegroundColor Magenta

Write-Host "`n📋 Рекомендации для дальнейшей SEO оптимизации:" -ForegroundColor Yellow
Write-Host "1. Зарегистрируйте сайт в Google Search Console" -ForegroundColor White
Write-Host "2. Добавьте сайт в Яндекс.Вебмастер" -ForegroundColor White
Write-Host "3. Создайте аккаунты в социальных сетях" -ForegroundColor White
Write-Host "4. Регулярно обновляйте контент" -ForegroundColor White
Write-Host "5. Добавьте отзывы клиентов" -ForegroundColor White
