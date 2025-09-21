# Main script for Chill Ink Tattoo website setup
Write-Host "Chill Ink Tattoo - Website Setup" -ForegroundColor Magenta
Write-Host "=================================" -ForegroundColor Magenta

# Menu function
function Show-Menu {
    Write-Host "`nChoose an action:" -ForegroundColor Yellow
    Write-Host "1. Add new master" -ForegroundColor White
    Write-Host "2. Add multiple masters" -ForegroundColor White
    Write-Host "3. Optimize images" -ForegroundColor White
    Write-Host "4. Add SEO optimization" -ForegroundColor White
    Write-Host "5. Setup analytics" -ForegroundColor White
    Write-Host "6. Update existing galleries" -ForegroundColor White
    Write-Host "7. Create backup" -ForegroundColor White
    Write-Host "8. Full website setup" -ForegroundColor White
    Write-Host "9. Exit" -ForegroundColor White
    Write-Host "`nEnter number (1-9): " -ForegroundColor Cyan -NoNewline
}

# Add new master function
function Add-NewMaster {
    Write-Host "`nAdding new master" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    
    $masterName = Read-Host "Enter master name"
    $masterFolder = Read-Host "Enter master folder (latin, no spaces)"
    $masterPhoto = Read-Host "Enter path to master photo"
    $experience = Read-Host "Enter experience (e.g. 5+ years)"
    $style = Read-Host "Enter master style"
    $specialization = Read-Host "Enter specialization"
    
    Write-Host "`nEnter master skills (comma separated):" -ForegroundColor Yellow
    $skillsInput = Read-Host "Skills"
    $skills = $skillsInput -split ',' | ForEach-Object { $_.Trim() }
    
    Write-Host "`nStarting master addition..." -ForegroundColor Green
    & ".\add_new_master.ps1" -MasterName $masterName -MasterFolder $masterFolder -MasterPhoto $masterPhoto -Experience $experience -Style $style -Specialization $specialization -Skills $skills
}

# Add multiple masters function
function Add-MultipleMasters {
    Write-Host "`nAdding multiple masters" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    
    Write-Host "Creating folder structure for new masters..." -ForegroundColor Yellow
    & ".\add_multiple_masters.ps1"
}

# Optimize images function
function Optimize-Images {
    Write-Host "`nImage optimization" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    
    Write-Host "Starting optimization..." -ForegroundColor Yellow
    & ".\optimize_images.ps1"
}

# Add SEO function
function Add-SEO {
    Write-Host "`nSEO optimization" -ForegroundColor Cyan
    Write-Host "================" -ForegroundColor Cyan
    
    Write-Host "Adding SEO meta tags and structured data..." -ForegroundColor Yellow
    & ".\add_seo.ps1"
}

# Setup analytics function
function Setup-Analytics {
    Write-Host "`nAnalytics setup" -ForegroundColor Cyan
    Write-Host "===============" -ForegroundColor Cyan
    
    Write-Host "Adding Google Analytics, Yandex Metrica and other tools..." -ForegroundColor Yellow
    & ".\setup_analytics.ps1"
}

# Update galleries function
function Update-Galleries {
    Write-Host "`nUpdating existing galleries" -ForegroundColor Cyan
    Write-Host "============================" -ForegroundColor Cyan
    
    Write-Host "Updating Alexey Renoit and Bulat Rocket galleries..." -ForegroundColor Yellow
    & ".\add_more_works.ps1"
}

# Create backup function
function Create-Backup {
    Write-Host "`nCreating backup" -ForegroundColor Cyan
    Write-Host "===============" -ForegroundColor Cyan
    
    $backupName = "backup_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')"
    $backupPath = "..\$backupName"
    
    Write-Host "Creating backup in: $backupPath" -ForegroundColor Yellow
    
    try {
        Copy-Item -Path "." -Destination $backupPath -Recurse -Exclude "backup_*"
        Write-Host "Backup created successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Error creating backup: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Full website setup function
function Setup-FullWebsite {
    Write-Host "`nFull website setup" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    
    Write-Host "Performing full website setup..." -ForegroundColor Yellow
    
    # Create backup
    Write-Host "`n1. Creating backup..." -ForegroundColor White
    Create-Backup
    
    # Update galleries
    Write-Host "`n2. Updating existing galleries..." -ForegroundColor White
    Update-Galleries
    
    # Optimize images
    Write-Host "`n3. Optimizing images..." -ForegroundColor White
    Optimize-Images
    
    # Add SEO
    Write-Host "`n4. Adding SEO optimization..." -ForegroundColor White
    Add-SEO
    
    # Setup analytics
    Write-Host "`n5. Setting up analytics..." -ForegroundColor White
    Setup-Analytics
    
    Write-Host "`nFull website setup completed!" -ForegroundColor Magenta
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Add photos and works for new masters" -ForegroundColor White
    Write-Host "2. Replace analytics IDs with real ones" -ForegroundColor White
    Write-Host "3. Test the website" -ForegroundColor White
    Write-Host "4. Upload to hosting" -ForegroundColor White
}

# Main program loop
do {
    Show-Menu
    $choice = Read-Host
    
    switch ($choice) {
        "1" { Add-NewMaster }
        "2" { Add-MultipleMasters }
        "3" { Optimize-Images }
        "4" { Add-SEO }
        "5" { Setup-Analytics }
        "6" { Update-Galleries }
        "7" { Create-Backup }
        "8" { Setup-FullWebsite }
        "9" { 
            Write-Host "`nGoodbye! Good luck with your website!" -ForegroundColor Magenta
            break 
        }
        default { 
            Write-Host "`nInvalid choice. Try again." -ForegroundColor Red
        }
    }
    
    if ($choice -ne "9") {
        Write-Host "`nPress any key to continue..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    
} while ($choice -ne "9")

Write-Host "`nThank you for using Chill Ink Tattoo Website Setup!" -ForegroundColor Magenta
