// Mobile Navigation Toggle
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-link').forEach(n => n.addEventListener('click', () => {
    hamburger.classList.remove('active');
    navMenu.classList.remove('active');
}));

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Header background change on scroll
window.addEventListener('scroll', () => {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(0, 0, 0, 0.98)';
    } else {
        header.style.background = 'rgba(0, 0, 0, 0.95)';
    }
});

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('fade-in-up');
        }
    });
}, observerOptions);

// Observe elements for animation
document.querySelectorAll('.service-card, .portfolio-item, .master-card, .contact-item').forEach(el => {
    observer.observe(el);
});

// Form submission
const contactForm = document.querySelector('.contact-form form');
if (contactForm) {
    contactForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Get form data
        const formData = new FormData(this);
        const name = this.querySelector('input[type="text"]').value;
        const phone = this.querySelector('input[type="tel"]').value;
        const message = this.querySelector('textarea').value;
        
        // Simple validation
        if (!name || !phone) {
            alert('Пожалуйста, заполните все обязательные поля');
            return;
        }
        
        // Create WhatsApp/Telegram message
        const messageText = `Новая заявка с сайта Chill Ink Tattoo:\n\nИмя: ${name}\nТелефон: ${phone}\nСообщение: ${message}`;
        
        // Try to open Telegram
        const telegramUrl = `https://t.me/chillinktattoos?text=${encodeURIComponent(messageText)}`;
        window.open(telegramUrl, '_blank');
        
        // Show success message
        alert('Спасибо за заявку! Мы свяжемся с вами в ближайшее время.');
        
        // Reset form
        this.reset();
    });
}

// Portfolio item click handler
document.querySelectorAll('.portfolio-item').forEach(item => {
    item.addEventListener('click', function() {
        // Add placeholder for future lightbox functionality
        console.log('Portfolio item clicked - placeholder for lightbox');
    });
});

// Service card hover effects
document.querySelectorAll('.service-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-10px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
});

// Master card hover effects
document.querySelectorAll('.master-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-10px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
});

// Parallax effect for hero section
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const hero = document.querySelector('.hero');
    if (hero) {
        const rate = scrolled * -0.5;
        hero.style.transform = `translateY(${rate}px)`;
    }
});

// Loading animation
window.addEventListener('load', () => {
    document.body.classList.add('loaded');
    
    // Animate hero elements
    const heroTitle = document.querySelector('.hero-title');
    const heroSubtitle = document.querySelector('.hero-subtitle');
    const heroDescription = document.querySelector('.hero-description');
    const heroButtons = document.querySelector('.hero-buttons');
    
    if (heroTitle) {
        setTimeout(() => heroTitle.classList.add('fade-in-up'), 200);
    }
    if (heroSubtitle) {
        setTimeout(() => heroSubtitle.classList.add('fade-in-up'), 400);
    }
    if (heroDescription) {
        setTimeout(() => heroDescription.classList.add('fade-in-up'), 600);
    }
    if (heroButtons) {
        setTimeout(() => heroButtons.classList.add('fade-in-up'), 800);
    }
});

// Contact info click handlers
document.querySelectorAll('.contact-item').forEach(item => {
    item.addEventListener('click', function() {
        const text = this.querySelector('p').textContent;
        
        // Copy to clipboard
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(() => {
                // Show temporary feedback
                const originalText = this.querySelector('p').textContent;
                this.querySelector('p').textContent = 'Скопировано!';
                setTimeout(() => {
                    this.querySelector('p').textContent = originalText;
                }, 2000);
            });
        }
    });
});

// Stats counter animation
const animateCounter = (element, target, duration = 2000) => {
    let start = 0;
    const increment = target / (duration / 16);
    
    const timer = setInterval(() => {
        start += increment;
        element.textContent = Math.floor(start) + '+';
        
        if (start >= target) {
            element.textContent = target + '+';
            clearInterval(timer);
        }
    }, 16);
};

// Observe stats for counter animation
const statsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const statNumbers = entry.target.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const target = parseInt(stat.textContent);
                animateCounter(stat, target);
            });
            statsObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

const statsSection = document.querySelector('.stats');
if (statsSection) {
    statsObserver.observe(statsSection);
}

// Add loading states to buttons
document.querySelectorAll('.btn').forEach(btn => {
    btn.addEventListener('click', function() {
        if (this.classList.contains('btn-primary')) {
            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            
            const ripple = document.createElement('span');
            ripple.style.position = 'absolute';
            ripple.style.borderRadius = '50%';
            ripple.style.background = 'rgba(255, 255, 255, 0.3)';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'ripple 0.6s linear';
            ripple.style.left = '50%';
            ripple.style.top = '50%';
            ripple.style.width = '20px';
            ripple.style.height = '20px';
            ripple.style.marginLeft = '-10px';
            ripple.style.marginTop = '-10px';
            
            this.appendChild(ripple);
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        }
    });
});

// Add ripple animation CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Lazy loading for images (when you add real images)
const lazyImages = document.querySelectorAll('img[data-src]');
const imageObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove('lazy');
            imageObserver.unobserve(img);
        }
    });
});

lazyImages.forEach(img => imageObserver.observe(img));

// Console welcome message
console.log(`
🎨 Chill Ink Tattoo Website
✨ Сайт создан с любовью для вашей тату-студии
📧 Свяжитесь с нами: chillink.kzn@gmail.com
📱 Telegram: @chillinktattoos
📸 Instagram: @chill_ink_studio
`);

// Performance optimization: Debounce scroll events
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Apply debouncing to scroll events
const debouncedScrollHandler = debounce(() => {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(0, 0, 0, 0.98)';
    } else {
        header.style.background = 'rgba(0, 0, 0, 0.95)';
    }
}, 10);

window.addEventListener('scroll', debouncedScrollHandler);

// Gallery Modal Functionality - Dynamic support for all masters
function initializeGalleryModals() {
    // Find all gallery modals dynamically
    const galleryModals = {};
    document.querySelectorAll('.gallery-modal').forEach(modal => {
        const masterId = modal.id.replace('-gallery', '');
        galleryModals[masterId] = modal;
    });

    // Open gallery when master card is clicked
    document.querySelectorAll('.master-card').forEach((card, index) => {
        card.addEventListener('click', function() {
            // Get master name from the card
            const masterName = this.querySelector('h3').textContent;
            
            // Find corresponding gallery by checking master name in gallery headers
            let masterId = null;
            Object.keys(galleryModals).forEach(id => {
                const galleryHeader = galleryModals[id].querySelector('.gallery-header h2');
                if (galleryHeader && galleryHeader.textContent.includes(masterName)) {
                    masterId = id;
                }
            });
            
            if (masterId) {
                openGallery(masterId);
            }
        });
    });

    return galleryModals;
}

// Initialize gallery modals
const galleryModals = initializeGalleryModals();

// Open gallery function
function openGallery(masterName) {
    const modal = galleryModals[masterName];
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }
}

// Close gallery function
function closeGallery(masterName) {
    const modal = galleryModals[masterName];
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = 'auto'; // Restore scrolling
    }
}

// Close gallery when clicking close button
document.querySelectorAll('.gallery-close').forEach(closeBtn => {
    closeBtn.addEventListener('click', function() {
        const modal = this.closest('.gallery-modal');
        const masterName = modal.id.replace('-gallery', '');
        closeGallery(masterName);
    });
});

// Close gallery when clicking outside
document.querySelectorAll('.gallery-modal').forEach(modal => {
    modal.addEventListener('click', function(e) {
        if (e.target === this) {
            const masterName = this.id.replace('-gallery', '');
            closeGallery(masterName);
        }
    });
});

// Close gallery with Escape key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        Object.keys(galleryModals).forEach(masterName => {
            closeGallery(masterName);
        });
    }
});

// Alias function for backward compatibility
function openMasterGallery(masterName) {
    openGallery(masterName);
}

// Close master gallery function
function closeMasterGallery(masterName) {
    closeGallery(masterName);
}

// Gallery image click handler for lightbox effect
document.querySelectorAll('.gallery-img').forEach(img => {
    img.addEventListener('click', function() {
        // Create lightbox
        const lightbox = document.createElement('div');
        lightbox.className = 'lightbox';
        lightbox.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.95);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 3000;
            cursor: pointer;
        `;
        
        const lightboxImg = document.createElement('img');
        lightboxImg.src = this.src;
        lightboxImg.style.cssText = `
            max-width: 90vw;
            max-height: 90vh;
            object-fit: contain;
            border-radius: 10px;
        `;
        
        lightbox.appendChild(lightboxImg);
        document.body.appendChild(lightbox);
        
        // Close lightbox
        lightbox.addEventListener('click', function() {
            document.body.removeChild(lightbox);
        });
        
        // Close with Escape
        const closeLightbox = (e) => {
            if (e.key === 'Escape') {
                document.body.removeChild(lightbox);
                document.removeEventListener('keydown', closeLightbox);
            }
        };
        document.addEventListener('keydown', closeLightbox);
    });
});

// FAQ Toggle Functionality
function initFAQ() {
    const faqItems = document.querySelectorAll('.faq-item');
    console.log('FAQ items found:', faqItems.length);
    
    faqItems.forEach((item, index) => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');
        const icon = item.querySelector('.faq-icon');
        
        if (question && answer && icon) {
            console.log(`FAQ item ${index + 1} initialized`);
            
            question.addEventListener('click', (e) => {
                e.preventDefault();
                console.log(`FAQ item ${index + 1} clicked`);
                
                const isOpen = !answer.classList.contains('hidden');
                
                // Close all other FAQ items
                faqItems.forEach((otherItem, otherIndex) => {
                    if (otherItem !== item) {
                        const otherAnswer = otherItem.querySelector('.faq-answer');
                        const otherIcon = otherItem.querySelector('.faq-icon');
                        if (otherAnswer && otherIcon) {
                            otherAnswer.classList.add('hidden');
                            otherIcon.style.transform = 'rotate(0deg)';
                        }
                    }
                });
                
                // Toggle current item
                if (isOpen) {
                    answer.classList.add('hidden');
                    icon.style.transform = 'rotate(0deg)';
                    console.log(`FAQ item ${index + 1} closed`);
                } else {
                    answer.classList.remove('hidden');
                    icon.style.transform = 'rotate(180deg)';
                    console.log(`FAQ item ${index + 1} opened`);
                }
            });
        } else {
            console.error(`FAQ item ${index + 1} missing elements:`, { question, answer, icon });
        }
    });
}

// Initialize FAQ when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initFAQ);
} else {
    initFAQ();
}