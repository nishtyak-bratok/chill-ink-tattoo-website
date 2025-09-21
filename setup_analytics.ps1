# Скрипт для настройки аналитики
Write-Host "📊 Настраиваем аналитику для сайта..." -ForegroundColor Green

# Читаем текущий HTML
$htmlContent = Get-Content "index.html" -Raw

# Google Analytics 4
$googleAnalytics = @"
    <!-- Google Analytics 4 -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'GA_MEASUREMENT_ID', {
            page_title: 'Chill Ink Tattoo - Профессиональная тату-студия в Казани',
            page_location: window.location.href,
            custom_map: {
                'custom_parameter_1': 'master_name',
                'custom_parameter_2': 'service_type'
            }
        });
        
        // Отслеживание кликов по кнопкам
        document.addEventListener('DOMContentLoaded', function() {
            // Отслеживание кнопки "Записаться"
            const bookButton = document.querySelector('a[href="#contact"]');
            if (bookButton) {
                bookButton.addEventListener('click', function() {
                    gtag('event', 'click', {
                        event_category: 'engagement',
                        event_label: 'book_appointment',
                        value: 1
                    });
                });
            }
            
            // Отслеживание кнопки "Портфолио"
            const portfolioButton = document.querySelector('a[href="#portfolio"]');
            if (portfolioButton) {
                portfolioButton.addEventListener('click', function() {
                    gtag('event', 'click', {
                        event_category: 'engagement',
                        event_label: 'view_portfolio',
                        value: 1
                    });
                });
            }
            
            // Отслеживание кликов по мастерам
            document.querySelectorAll('.master-card').forEach(card => {
                card.addEventListener('click', function() {
                    const masterName = this.querySelector('h3').textContent;
                    gtag('event', 'click', {
                        event_category: 'master',
                        event_label: masterName,
                        value: 1
                    });
                });
            });
            
            // Отслеживание отправки формы
            const contactForm = document.querySelector('.contact-form form');
            if (contactForm) {
                contactForm.addEventListener('submit', function() {
                    gtag('event', 'form_submit', {
                        event_category: 'engagement',
                        event_label: 'contact_form',
                        value: 1
                    });
                });
            }
            
            // Отслеживание просмотра галерей
            document.querySelectorAll('.gallery-modal').forEach(modal => {
                const observer = new MutationObserver(function(mutations) {
                    mutations.forEach(function(mutation) {
                        if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
                            if (modal.classList.contains('active')) {
                                const masterName = modal.querySelector('h2').textContent;
                                gtag('event', 'view_gallery', {
                                    event_category: 'gallery',
                                    event_label: masterName,
                                    value: 1
                                });
                            }
                        }
                    });
                });
                observer.observe(modal, { attributes: true });
            });
        });
    </script>
"@

# Яндекс.Метрика
$yandexMetrika = @"
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
        m[i].l=1*new Date();k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
        (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym(YANDEX_METRIKA_ID, "init", {
            clickmap:true,
            trackLinks:true,
            accurateTrackBounce:true,
            webvisor:true,
            ecommerce:"dataLayer"
        });
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/YANDEX_METRIKA_ID" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->
"@

# Facebook Pixel
$facebookPixel = @"
    <!-- Facebook Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s)
        {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
        n.callMethod.apply(n,arguments):n.queue.push(arguments)};
        if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
        n.queue=[];t=b.createElement(e);t.async=!0;
        t.src=v;s=b.getElementsByTagName(e)[0];
        s.parentNode.insertBefore(t,s)}(window, document,'script',
        'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', 'FACEBOOK_PIXEL_ID');
        fbq('track', 'PageView');
        
        // Отслеживание конверсий
        document.addEventListener('DOMContentLoaded', function() {
            const contactForm = document.querySelector('.contact-form form');
            if (contactForm) {
                contactForm.addEventListener('submit', function() {
                    fbq('track', 'Lead');
                });
            }
        });
    </script>
    <noscript><img height="1" width="1" style="display:none"
    src="https://www.facebook.com/tr?id=FACEBOOK_PIXEL_ID&ev=PageView&noscript=1"
    /></noscript>
    <!-- End Facebook Pixel Code -->
"@

# Hotjar для анализа поведения пользователей
$hotjar = @"
    <!-- Hotjar Tracking Code -->
    <script>
        (function(h,o,t,j,a,r){
            h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
            h._hjSettings={hjid:HOTJAR_ID,hjsv:6};
            a=o.getElementsByTagName('head')[0];
            r=o.createElement('script');r.async=1;
            r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
            a.appendChild(r);
        })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
    </script>
"@

# Создаем конфигурационный файл для аналитики
$analyticsConfig = @"
# Конфигурация аналитики для Chill Ink Tattoo

## Google Analytics 4
1. Перейдите в https://analytics.google.com/
2. Создайте новое свойство для сайта
3. Получите Measurement ID (формат: G-XXXXXXXXXX)
4. Замените GA_MEASUREMENT_ID в коде на ваш ID

## Яндекс.Метрика
1. Перейдите в https://metrika.yandex.ru/
2. Добавьте новый счетчик для сайта
3. Получите ID счетчика (число)
4. Замените YANDEX_METRIKA_ID в коде на ваш ID

## Facebook Pixel
1. Перейдите в https://business.facebook.com/
2. Создайте новый пиксель
3. Получите Pixel ID (число)
4. Замените FACEBOOK_PIXEL_ID в коде на ваш ID

## Hotjar
1. Перейдите в https://www.hotjar.com/
2. Создайте новый сайт
3. Получите Site ID (число)
4. Замените HOTJAR_ID в коде на ваш ID

## Рекомендуемые события для отслеживания:
- Просмотр галерей мастеров
- Отправка контактной формы
- Клики по кнопкам "Записаться" и "Портфолио"
- Время на странице
- Глубина прокрутки
- Клики по контактной информации

## Настройка целей:
1. Google Analytics: Администратор > Цели > Создать цель
2. Яндекс.Метрика: Настройки > Цели > Добавить цель
3. Facebook: События > Настроить события

## Полезные метрики для тату-студии:
- Количество просмотров портфолио
- Популярность мастеров
- Конверсия из просмотра в заявку
- Источники трафика
- География посетителей
- Время на сайте
"@

$analyticsConfig | Out-File "analytics_config.md" -Encoding UTF8

# Добавляем аналитику в HTML
$analyticsCode = "$googleAnalytics`n`n$yandexMetrika`n`n$facebookPixel`n`n$hotjar"

# Добавляем аналитику перед закрывающим тегом head
$htmlContent = $htmlContent -replace '</head>', "$analyticsCode`n</head>"

# Сохраняем обновленный HTML
$htmlContent | Out-File "index.html" -Encoding UTF8

Write-Host "✅ Google Analytics 4 добавлен!" -ForegroundColor Green
Write-Host "✅ Яндекс.Метрика добавлена!" -ForegroundColor Green
Write-Host "✅ Facebook Pixel добавлен!" -ForegroundColor Green
Write-Host "✅ Hotjar добавлен!" -ForegroundColor Green
Write-Host "✅ Конфигурационный файл создан: analytics_config.md" -ForegroundColor Green
Write-Host "🎉 Аналитика настроена!" -ForegroundColor Magenta

Write-Host "`n📋 Следующие шаги:" -ForegroundColor Yellow
Write-Host "1. Замените ID в коде на реальные ID из ваших аккаунтов" -ForegroundColor White
Write-Host "2. Протестируйте отслеживание событий" -ForegroundColor White
Write-Host "3. Настройте цели и конверсии" -ForegroundColor White
Write-Host "4. Регулярно анализируйте данные" -ForegroundColor White
