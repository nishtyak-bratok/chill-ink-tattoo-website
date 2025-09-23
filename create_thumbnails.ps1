# PowerShell script to create thumbnails for all master works
# This will create smaller, optimized versions of images for faster loading

Write-Host "Creating thumbnails for all master works..." -ForegroundColor Green

# Function to create thumbnail
function Create-Thumbnail {
    param(
        [string]$SourcePath,
        [string]$DestPath,
        [int]$Width = 200,
        [int]$Height = 200
    )
    
    try {
        # Load image
        $image = [System.Drawing.Image]::FromFile($SourcePath)
        
        # Calculate new dimensions maintaining aspect ratio
        $ratio = [Math]::Min($Width / $image.Width, $Height / $image.Height)
        $newWidth = [int]($image.Width * $ratio)
        $newHeight = [int]($image.Height * $ratio)
        
        # Create thumbnail with smaller size for faster loading
        $thumbnail = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($thumbnail)
        
        # Set optimized settings for smaller file size
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::LowQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::None
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighSpeed
        
        # Draw thumbnail
        $graphics.DrawImage($image, 0, 0, $newWidth, $newHeight)
        
        # Save thumbnail with compression
        $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatID -eq [System.Drawing.Imaging.ImageFormat]::Jpeg.Guid }
        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 70) # 70% quality for smaller file
        $thumbnail.Save($DestPath, $jpegCodec, $encoderParams)
        
        # Cleanup
        $graphics.Dispose()
        $thumbnail.Dispose()
        $image.Dispose()
        
        Write-Host "Created thumbnail: $DestPath" -ForegroundColor Yellow
        return $true
    }
    catch {
        Write-Host "Error creating thumbnail for $SourcePath : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Create thumbnails directory structure
$masters = @('renoit', 'rocket', 'lozhkin', 'nastasia', 'dina', 'barabanov', 'flo', 'atlasov', 'leyla')

foreach ($master in $masters) {
    $galleryPath = "gallery\$master"
    $thumbnailsPath = "gallery\$master\thumbnails"
    
    if (Test-Path $galleryPath) {
        # Create thumbnails directory
        if (!(Test-Path $thumbnailsPath)) {
            New-Item -ItemType Directory -Path $thumbnailsPath -Force
            Write-Host "Created thumbnails directory: $thumbnailsPath" -ForegroundColor Cyan
        }
        
        # Get all work images
        $workImages = Get-ChildItem -Path $galleryPath -Filter "*-work-*" | Where-Object { $_.Name -notlike "*master-photo*" }
        
        foreach ($image in $workImages) {
            $thumbnailName = $image.Name -replace '\.(jpg|jpeg|png|JPG|JPEG|PNG)$', '_thumb.jpg'
            $thumbnailPath = Join-Path $thumbnailsPath $thumbnailName
            
            # Only create thumbnail if it doesn't exist
            if (!(Test-Path $thumbnailPath)) {
                Create-Thumbnail -SourcePath $image.FullName -DestPath $thumbnailPath -Width 150 -Height 150
            }
        }
    }
}

Write-Host "Thumbnail creation completed!" -ForegroundColor Green
Write-Host "You can now use the optimized thumbnails for faster loading." -ForegroundColor Cyan
