Add-Type -AssemblyName System.Drawing

function Draw-SpacedText {
    param(
        [System.Drawing.Graphics]$gfx,
        [string]$text,
        [System.Drawing.Font]$font,
        [System.Drawing.Brush]$brush,
        [float]$x,
        [float]$y,
        [float]$tracking = 0,
        [string]$align = "Left"
    )
    $charWidths = @()
    $totalWidth = 0.0
    for ($i = 0; $i -lt $text.Length; $i++) {
        $ch = $text[$i].ToString()
        if ($ch -eq ' ') {
            $charW = [float]($font.SizeInPoints * 0.44)
        } else {
            $sz = $gfx.MeasureString($ch, $font, [System.Drawing.PointF]::new(0,0), [System.Drawing.StringFormat]::GenericTypographic)
            $charW = $sz.Width
        }
        $charWidths += $charW
        $totalWidth += $charW
        if ($i -lt $text.Length - 1) { $totalWidth += $tracking }
    }
    
    $startX = $x
    if ($align -eq "Center") {
        $startX = $x - ($totalWidth / 2.0)
    } elseif ($align -eq "Right") {
        $startX = $x - $totalWidth
    }
    
    $curX = $startX
    for ($i = 0; $i -lt $text.Length; $i++) {
        $ch = $text[$i].ToString()
        if ($ch -ne ' ') {
            $gfx.DrawString($ch, $font, $brush, [float]$curX, [float]$y, [System.Drawing.StringFormat]::GenericTypographic)
        }
        $curX += $charWidths[$i] + $tracking
    }
    return [PSCustomObject]@{ Left = $startX; Right = $startX + $totalWidth; Width = $totalWidth; Y = $y }
}

function Draw-RoundedRect {
    param(
        [System.Drawing.Graphics]$gfx,
        [float]$x, [float]$y, [float]$w, [float]$h, [float]$r,
        [System.Drawing.Brush]$fill,
        [System.Drawing.Pen]$border
    )
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddArc($x, $y, $r*2, $r*2, 180, 90)
    $path.AddArc($x + $w - $r*2, $y, $r*2, $r*2, 270, 90)
    $path.AddArc($x + $w - $r*2, $y + $h - $r*2, $r*2, $r*2, 0, 90)
    $path.AddArc($x, $y + $h - $r*2, $r*2, $r*2, 90, 90)
    $path.CloseFigure()
    if ($null -ne $fill) { $gfx.FillPath($fill, $path) }
    if ($null -ne $border) { $gfx.DrawPath($border, $path) }
    $path.Dispose()
}

$emblemDarkPath = "assets\covers\emblem-dark-transparent.png"
$emblemTransparentPath = "assets\covers\emblem-transparent.png"

# ==============================================================================
# 1. FACEBOOK COVER (DARK LUXURY) - 1640 x 624
# ==============================================================================
function Generate-FacebookCoverDark {
    $w = 1640; $h = 624
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $gfx.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

    # Rich dark obsidian gradient
    $rect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
    $brushBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(26, 29, 36), [System.Drawing.Color]::FromArgb(12, 14, 18), 45.0)
    $gfx.FillRectangle($brushBg, $rect)
    $brushBg.Dispose()

    # Subtle gold architectural grid
    $penGrid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(18, 197, 168, 128), 1.0)
    for ($gx = 60; $gx -lt $w; $gx += 120) { $gfx.DrawLine($penGrid, [float]$gx, 0.0, [float]$gx, [float]$h) }
    for ($gy = 40; $gy -lt $h; $gy += 80) { $gfx.DrawLine($penGrid, 0.0, [float]$gy, [float]$w, [float]$gy) }
    $penGrid.Dispose()

    # Outer border
    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(65, 197, 168, 128), 1.5)
    Draw-RoundedRect $gfx 20 20 ($w - 40) ($h - 40) 12 $null $penFrame
    $penFrame.Dispose()

    # LEFT SECTION: Logo
    if (Test-Path $emblemDarkPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemDarkPath)
        $gfx.DrawImage($emblem, 90, 85, 210, 240)
        $emblem.Dispose()
    }

    # Brand Title
    $fontJaipur = New-Object System.Drawing.Font("Georgia", 40, [System.Drawing.FontStyle]::Bold)
    $brushWhiteText = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 242, 236))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushWhiteText 330 110 6 "Left"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 30, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(213, 186, 142))
    Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold 330 175 4 "Left"

    # Accent underline
    $penGoldThick = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGoldThick, 330.0, 225.0, 780.0, 225.0)

    # Tagline
    $fontTag = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)
    $brushTag = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(170, 140, 95))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushTag 330 245 4 "Left"

    # Badges
    $brushPillBg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25, 255, 255, 255))
    $penPillBorder = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(80, 197, 168, 128), 1.0)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)

    Draw-RoundedRect $gfx 90 350 200 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 190 362 2 "Center"

    Draw-RoundedRect $gfx 310 350 210 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "RERA APPROVED" $fontPill $brushGold 415 362 2 "Center"

    Draw-RoundedRect $gfx 540 350 250 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "PRIME CORRIDORS" $fontPill $brushGold 665 362 2 "Center"

    # RIGHT SECTION: Feature Highlights Card
    $cardX = 850; $cardY = 85; $cardW = 710; $cardH = 450
    $brushCardBg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 255, 255, 255))
    $penCardBorder = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(90, 197, 168, 128), 1.5)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 16 $brushCardBg $penCardBorder

    $fontCardTitle = New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "JAIPUR'S TRUSTED PROPERTY PARTNER" $fontCardTitle $brushGold ($cardX + 35) ($cardY + 30) 2 "Left"

    $fontFeat = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Regular)
    $fontFeatBold = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)

    $by1 = $cardY + 85
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by1)
    $gfx.DrawString("Chart Knowledge Park & Chart Nexara Townships", $fontFeatBold, $brushWhiteText, ($cardX + 65), $by1)

    $by2 = $cardY + 135
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by2)
    $gfx.DrawString("Prime Connectivity: 250 Ft, 100 Ft & 60 Ft Wide Sector Roads", $fontFeat, $brushWhiteText, ($cardX + 65), $by2)

    $by3 = $cardY + 185
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by3)
    $gfx.DrawString("High Appreciation Potential - Mahindra World City, Ajmer Road", $fontFeat, $brushWhiteText, ($cardX + 65), $by3)

    $penCardDiv = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 255, 255, 255), 1.0)
    $gfx.DrawLine($penCardDiv, [float]($cardX + 35), [float]($cardY + 245), [float]($cardX + $cardW - 35), [float]($cardY + 245))

    # BOTTOM CTA: Contact Button
    $btnX = $cardX + 35; $btnY = $cardY + 270; $btnW = 440; $btnH = 58
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $btnY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(213, 186, 142),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $btnY $btnW $btnH 10 $brushBtn $null
    $brushBtn.Dispose()

    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    $brushBtnText = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 20, 24))
    Draw-SpacedText $gfx "CALL / WHATSAPP: +91 8824348273" $fontBtn $brushBtnText ($btnX + ($btnW / 2)) ($btnY + 18) 2 "Center"

    # Location Info
    $fontLoc = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushLoc = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(190, 185, 175))
    Draw-SpacedText $gfx "Location: Jaipur, Rajasthan  |  Verified Commercial Real Estate" $fontLoc $brushLoc ($cardX + 38) ($cardY + 355) 2 "Left"

    $fontWeb = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushWeb = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 160, 130))
    Draw-SpacedText $gfx "WWW.JAIPURPRIMEPROPERTY.COM" $fontWeb $brushWeb 95 480 3 "Left"

    $gfx.Flush(); $gfx.Dispose()

    $out1640 = "assets\covers\facebook-cover-dark-1640x624.jpg"
    $bmp.Save($out1640, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $bmp820 = New-Object System.Drawing.Bitmap(820, 312)
    $gfx820 = [System.Drawing.Graphics]::FromImage($bmp820)
    $gfx820.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gfx820.DrawImage($bmp, 0, 0, 820, 312)
    $gfx820.Dispose()
    $out820 = "assets\covers\facebook-cover-dark-820x312.jpg"
    $bmp820.Save($out820, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp820.Dispose()

    $bmp.Dispose()
    Write-Output "Generated Facebook Cover Dark: $out1640"
}

# ==============================================================================
# 2. FACEBOOK COVER (WHITE ARCHITECTURAL) - 1640 x 624
# ==============================================================================
function Generate-FacebookCoverWhite {
    $w = 1640; $h = 624
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $gfx.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $gfx.FillRectangle($brushWhite, 0, 0, $w, $h)

    $penGrid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(240, 235, 226), 1.0)
    for ($gx = 60; $gx -lt $w; $gx += 120) { $gfx.DrawLine($penGrid, [float]$gx, 0.0, [float]$gx, [float]$h) }
    for ($gy = 40; $gy -lt $h; $gy += 80) { $gfx.DrawLine($penGrid, 0.0, [float]$gy, [float]$w, [float]$gy) }
    $penGrid.Dispose()

    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 1.5)
    Draw-RoundedRect $gfx 20 20 ($w - 40) ($h - 40) 12 $null $penFrame
    $penFrame.Dispose()

    if (Test-Path $emblemTransparentPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemTransparentPath)
        $gfx.DrawImage($emblem, 90, 85, 210, 240)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 40, [System.Drawing.FontStyle]::Bold)
    $brushSlate = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(55, 65, 81))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushSlate 330 110 6 "Left"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 30, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 138, 70))
    Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold 330 175 4 "Left"

    $penGoldThick = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGoldThick, 330.0, 225.0, 780.0, 225.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)
    $brushCharcoal = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 100, 110))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushCharcoal 330 245 4 "Left"

    $brushPillBg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 247, 242))
    $penPillBorder = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 1.2)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)

    Draw-RoundedRect $gfx 90 350 200 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 190 362 2 "Center"

    Draw-RoundedRect $gfx 310 350 210 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "RERA APPROVED" $fontPill $brushGold 415 362 2 "Center"

    Draw-RoundedRect $gfx 540 350 250 40 8 $brushPillBg $penPillBorder
    Draw-SpacedText $gfx "PRIME CORRIDORS" $fontPill $brushGold 665 362 2 "Center"

    $cardX = 850; $cardY = 85; $cardW = 710; $cardH = 450
    $brushCardBg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(252, 250, 246))
    $penCardBorder = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 205, 185), 1.5)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 16 $brushCardBg $penCardBorder

    $fontCardTitle = New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "JAIPUR'S TRUSTED PROPERTY PARTNER" $fontCardTitle $brushGold ($cardX + 35) ($cardY + 30) 2 "Left"

    $fontFeat = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Regular)
    $fontFeatBold = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)

    $by1 = $cardY + 85
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by1)
    $gfx.DrawString("Chart Knowledge Park & Chart Nexara Townships", $fontFeatBold, $brushSlate, ($cardX + 65), $by1)

    $by2 = $cardY + 135
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by2)
    $gfx.DrawString("Prime Connectivity: 250 Ft, 100 Ft & 60 Ft Wide Sector Roads", $fontFeat, $brushSlate, ($cardX + 65), $by2)

    $by3 = $cardY + 185
    $gfx.DrawString("*", $fontFeatBold, $brushGold, ($cardX + 35), $by3)
    $gfx.DrawString("High Appreciation Potential - Mahindra World City, Ajmer Road", $fontFeat, $brushSlate, ($cardX + 65), $by3)

    $penCardDiv = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(230, 220, 205), 1.0)
    $gfx.DrawLine($penCardDiv, [float]($cardX + 35), [float]($cardY + 245), [float]($cardX + $cardW - 35), [float]($cardY + 245))

    $btnX = $cardX + 35; $btnY = $cardY + 270; $btnW = 440; $btnH = 58
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $btnY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(200, 160, 95),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $btnY $btnW $btnH 10 $brushBtn $null
    $brushBtn.Dispose()

    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    $brushBtnWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    Draw-SpacedText $gfx "CALL / WHATSAPP: +91 8824348273" $fontBtn $brushBtnWhite ($btnX + ($btnW / 2)) ($btnY + 18) 2 "Center"

    $fontLoc = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushLoc = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 100, 110))
    Draw-SpacedText $gfx "Location: Jaipur, Rajasthan  |  Verified Commercial Real Estate" $fontLoc $brushLoc ($cardX + 38) ($cardY + 355) 2 "Left"

    $fontWeb = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushWeb = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 130, 80))
    Draw-SpacedText $gfx "WWW.JAIPURPRIMEPROPERTY.COM" $fontWeb $brushWeb 95 480 3 "Left"

    $gfx.Flush(); $gfx.Dispose()

    $out1640 = "assets\covers\facebook-cover-white-1640x624.jpg"
    $bmp.Save($out1640, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $bmp820 = New-Object System.Drawing.Bitmap(820, 312)
    $gfx820 = [System.Drawing.Graphics]::FromImage($bmp820)
    $gfx820.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gfx820.DrawImage($bmp, 0, 0, 820, 312)
    $gfx820.Dispose()
    $out820 = "assets\covers\facebook-cover-white-820x312.jpg"
    $bmp820.Save($out820, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp820.Dispose()

    $bmp.Dispose()
    Write-Output "Generated Facebook Cover White: $out1640"
}

# ==============================================================================
# 3. WHATSAPP BUSINESS COVER (DARK & WHITE) - 1152 x 648
# ==============================================================================
function Generate-WhatsAppCoverDark {
    $w = 1152; $h = 648
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $rect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
    $brushBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(24, 27, 33), [System.Drawing.Color]::FromArgb(10, 12, 15), 45.0)
    $gfx.FillRectangle($brushBg, $rect)
    $brushBg.Dispose()

    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 197, 168, 128), 1.5)
    Draw-RoundedRect $gfx 18 18 ($w - 36) ($h - 36) 12 $null $penFrame

    if (Test-Path $emblemDarkPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemDarkPath)
        $emblemW = 160; $emblemH = 182
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 55.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 38, [System.Drawing.FontStyle]::Bold)
    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 242, 236))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushWhite ($w / 2) 250 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 28, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(213, 186, 142))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 308 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGold, [float]($resP.Left - 60), 322.0, [float]($resP.Left - 15), 322.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 15), 322.0, [float]($resP.Right + 60), 322.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)
    $brushTag = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(168, 136, 91))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushTag ($w / 2) 360 4 "Center"

    $brushPill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25, 255, 255, 255))
    $penPill = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(80, 197, 168, 128), 1.0)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 12, [System.Drawing.FontStyle]::Bold)

    $badgeBarY = 415
    Draw-RoundedRect $gfx 180 $badgeBarY 220 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 290 ($badgeBarY + 10) 2 "Center"

    Draw-RoundedRect $gfx 420 $badgeBarY 300 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "RERA APPROVED TOWNSHIPS" $fontPill $brushGold 570 ($badgeBarY + 10) 2 "Center"

    Draw-RoundedRect $gfx 740 $badgeBarY 230 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "PRIME CORRIDORS" $fontPill $brushGold 855 ($badgeBarY + 10) 2 "Center"

    $fontTown = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 185, 195))
    Draw-SpacedText $gfx "Chart Knowledge Park  -  Chart Nexara  -  Mahindra World City, Jaipur" $fontTown $brushMuted ($w / 2) 480 2 "Center"

    $ctaY = 535
    $btnW = 500; $btnH = 52; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(213, 186, 142),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 10 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)
    $brushDarkText = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 20, 24))
    Draw-SpacedText $gfx "WHATSAPP / DIRECT: +91 8824348273" $fontBtn $brushDarkText ($w / 2) ($ctaY + 17) 2 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\whatsapp-cover-dark-1152x648.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated WhatsApp Cover Dark: $outPath"
}

function Generate-WhatsAppCoverWhite {
    $w = 1152; $h = 648
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $gfx.FillRectangle($brushWhite, 0, 0, $w, $h)

    $penGrid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(240, 235, 226), 1.0)
    for ($gx = 60; $gx -lt $w; $gx += 120) { $gfx.DrawLine($penGrid, [float]$gx, 0.0, [float]$gx, [float]$h) }
    for ($gy = 40; $gy -lt $h; $gy += 80) { $gfx.DrawLine($penGrid, 0.0, [float]$gy, [float]$w, [float]$gy) }
    $penGrid.Dispose()

    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 1.5)
    Draw-RoundedRect $gfx 18 18 ($w - 36) ($h - 36) 12 $null $penFrame

    if (Test-Path $emblemTransparentPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemTransparentPath)
        $emblemW = 160; $emblemH = 182
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 55.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 38, [System.Drawing.FontStyle]::Bold)
    $brushSlate = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(55, 65, 81))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushSlate ($w / 2) 250 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 28, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 138, 70))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 308 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGold, [float]($resP.Left - 60), 322.0, [float]($resP.Left - 15), 322.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 15), 322.0, [float]($resP.Right + 60), 322.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)
    $brushCharcoal = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 100, 110))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushCharcoal ($w / 2) 360 4 "Center"

    $brushPill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 247, 242))
    $penPill = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 1.2)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 12, [System.Drawing.FontStyle]::Bold)

    $badgeBarY = 415
    Draw-RoundedRect $gfx 180 $badgeBarY 220 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 290 ($badgeBarY + 10) 2 "Center"

    Draw-RoundedRect $gfx 420 $badgeBarY 300 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "RERA APPROVED TOWNSHIPS" $fontPill $brushGold 570 ($badgeBarY + 10) 2 "Center"

    Draw-RoundedRect $gfx 740 $badgeBarY 230 36 6 $brushPill $penPill
    Draw-SpacedText $gfx "PRIME CORRIDORS" $fontPill $brushGold 855 ($badgeBarY + 10) 2 "Center"

    $fontTown = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(110, 115, 125))
    Draw-SpacedText $gfx "Chart Knowledge Park  -  Chart Nexara  -  Mahindra World City, Jaipur" $fontTown $brushMuted ($w / 2) 480 2 "Center"

    $ctaY = 535
    $btnW = 500; $btnH = 52; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(200, 160, 95),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 10 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)
    $brushBtnWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    Draw-SpacedText $gfx "WHATSAPP / DIRECT: +91 8824348273" $fontBtn $brushBtnWhite ($w / 2) ($ctaY + 17) 2 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\whatsapp-cover-white-1152x648.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated WhatsApp Cover White: $outPath"
}

# ==============================================================================
# 4. INSTAGRAM SQUARE POST / BRANDING COVER - 1080 x 1080
# ==============================================================================
function Generate-InstagramSquareDark {
    $w = 1080; $h = 1080
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $rect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
    $brushBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(24, 27, 33), [System.Drawing.Color]::FromArgb(10, 12, 15), 45.0)
    $gfx.FillRectangle($brushBg, $rect)
    $brushBg.Dispose()

    $penFrame1 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(70, 197, 168, 128), 2.0)
    Draw-RoundedRect $gfx 28 28 ($w - 56) ($h - 56) 16 $null $penFrame1
    $penFrame2 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(35, 197, 168, 128), 1.0)
    Draw-RoundedRect $gfx 40 40 ($w - 80) ($h - 80) 12 $null $penFrame2

    if (Test-Path $emblemDarkPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemDarkPath)
        $emblemW = 210; $emblemH = 240
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 90.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 42, [System.Drawing.FontStyle]::Bold)
    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 242, 236))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushWhite ($w / 2) 365 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 32, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(213, 186, 142))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 435 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGold, [float]($resP.Left - 60), 450.0, [float]($resP.Left - 15), 450.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 15), 450.0, [float]($resP.Right + 60), 450.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    $brushTag = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(168, 136, 91))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushTag ($w / 2) 495 4 "Center"

    $gfx.DrawLine($penGold, 200.0, 545.0, 880.0, 545.0)

    $cardX = 90; $cardY = 580; $cardW = 900; $cardH = 265
    $brushCard = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 255, 255, 255))
    $penCard = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(70, 197, 168, 128), 1.2)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 14 $brushCard $penCard

    $fontTownHeader = New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "FEATURED PREMIUM TOWNSHIPS" $fontTownHeader $brushGold ($w / 2) ($cardY + 28) 3 "Center"

    $fontTownName = New-Object System.Drawing.Font("Century Gothic", 18, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "CHART KNOWLEDGE PARK   -   CHART NEXARA" $fontTownName $brushWhite ($w / 2) ($cardY + 75) 2 "Center"

    $fontSub = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(190, 195, 205))
    Draw-SpacedText $gfx "JDA Approved  -  RERA Approved  -  200 Bigha Township" $fontSub $brushMuted ($w / 2) ($cardY + 120) 2 "Center"
    Draw-SpacedText $gfx "250 Ft, 100 Ft & 60 Ft Sector Roads  -  Mahindra World City, Jaipur" $fontSub $brushMuted ($w / 2) ($cardY + 155) 2 "Center"

    $fontRate = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "Residential Plots: Rs. 34,950 / sq.yd   |   Commercial Plots: Rs. 47,000 / sq.yd" $fontRate $brushGold ($w / 2) ($cardY + 205) 1 "Center"

    $ctaY = 885; $btnW = 640; $btnH = 65; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(213, 186, 142),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 12 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 19, [System.Drawing.FontStyle]::Bold)
    $brushDark = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 20, 24))
    Draw-SpacedText $gfx "BOOK SITE VISIT: +91 8824348273" $fontBtn $brushDark ($w / 2) ($ctaY + 22) 2 "Center"

    $fontFoot = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushFoot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 150, 135))
    Draw-SpacedText $gfx "LOCATION: JAIPUR, RAJASTHAN   -   WWW.JAIPURPRIMEPROPERTY.COM" $fontFoot $brushFoot ($w / 2) 990 3 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\instagram-post-dark-1080x1080.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated Instagram Post Dark: $outPath"
}

function Generate-InstagramSquareWhite {
    $w = 1080; $h = 1080
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $gfx.FillRectangle($brushWhite, 0, 0, $w, $h)

    $penGrid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(242, 237, 230), 1.0)
    for ($gx = 60; $gx -lt $w; $gx += 120) { $gfx.DrawLine($penGrid, [float]$gx, 0.0, [float]$gx, [float]$h) }
    for ($gy = 40; $gy -lt $h; $gy += 80) { $gfx.DrawLine($penGrid, 0.0, [float]$gy, [float]$w, [float]$gy) }
    $penGrid.Dispose()

    $penFrame1 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 2.0)
    Draw-RoundedRect $gfx 28 28 ($w - 56) ($h - 56) 16 $null $penFrame1
    $penFrame2 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 205, 185), 1.0)
    Draw-RoundedRect $gfx 40 40 ($w - 80) ($h - 80) 12 $null $penFrame2

    if (Test-Path $emblemTransparentPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemTransparentPath)
        $emblemW = 210; $emblemH = 240
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 90.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 42, [System.Drawing.FontStyle]::Bold)
    $brushSlate = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(55, 65, 81))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushSlate ($w / 2) 365 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 32, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 138, 70))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 435 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.0)
    $gfx.DrawLine($penGold, [float]($resP.Left - 60), 450.0, [float]($resP.Left - 15), 450.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 15), 450.0, [float]($resP.Right + 60), 450.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    $brushCharcoal = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 100, 110))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushCharcoal ($w / 2) 495 4 "Center"

    $gfx.DrawLine($penGold, 200.0, 545.0, 880.0, 545.0)

    $cardX = 90; $cardY = 580; $cardW = 900; $cardH = 265
    $brushCard = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(252, 250, 246))
    $penCard = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(215, 195, 170), 1.2)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 14 $brushCard $penCard

    $fontTownHeader = New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "FEATURED PREMIUM TOWNSHIPS" $fontTownHeader $brushGold ($w / 2) ($cardY + 28) 3 "Center"

    $fontTownName = New-Object System.Drawing.Font("Century Gothic", 18, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "CHART KNOWLEDGE PARK   -   CHART NEXARA" $fontTownName $brushSlate ($w / 2) ($cardY + 75) 2 "Center"

    $fontSub = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 110, 120))
    Draw-SpacedText $gfx "JDA Approved  -  RERA Approved  -  200 Bigha Township" $fontSub $brushMuted ($w / 2) ($cardY + 120) 2 "Center"
    Draw-SpacedText $gfx "250 Ft, 100 Ft & 60 Ft Sector Roads  -  Mahindra World City, Jaipur" $fontSub $brushMuted ($w / 2) ($cardY + 155) 2 "Center"

    $fontRate = New-Object System.Drawing.Font("Century Gothic", 14, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "Residential Plots: Rs. 34,950 / sq.yd   |   Commercial Plots: Rs. 47,000 / sq.yd" $fontRate $brushGold ($w / 2) ($cardY + 205) 1 "Center"

    $ctaY = 885; $btnW = 640; $btnH = 65; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(200, 160, 95),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 12 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 19, [System.Drawing.FontStyle]::Bold)
    $brushBtnWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    Draw-SpacedText $gfx "BOOK SITE VISIT: +91 8824348273" $fontBtn $brushBtnWhite ($w / 2) ($ctaY + 22) 2 "Center"

    $fontFoot = New-Object System.Drawing.Font("Century Gothic", 13, [System.Drawing.FontStyle]::Bold)
    $brushFoot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(140, 125, 105))
    Draw-SpacedText $gfx "LOCATION: JAIPUR, RAJASTHAN   -   WWW.JAIPURPRIMEPROPERTY.COM" $fontFoot $brushFoot ($w / 2) 990 3 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\instagram-post-white-1080x1080.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated Instagram Post White: $outPath"
}

# ==============================================================================
# 5. INSTAGRAM STORY / HIGHLIGHT (DARK & WHITE) - 1080 x 1920
# ==============================================================================
function Generate-InstagramStoryDark {
    $w = 1080; $h = 1920
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $rect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
    $brushBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(24, 27, 33), [System.Drawing.Color]::FromArgb(10, 12, 15), 45.0)
    $gfx.FillRectangle($brushBg, $rect)
    $brushBg.Dispose()

    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 197, 168, 128), 2.0)
    Draw-RoundedRect $gfx 35 45 ($w - 70) ($h - 90) 20 $null $penFrame

    if (Test-Path $emblemDarkPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemDarkPath)
        $emblemW = 280; $emblemH = 320
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 220.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 50, [System.Drawing.FontStyle]::Bold)
    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 242, 236))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushWhite ($w / 2) 580 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 38, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(213, 186, 142))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 660 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.5)
    $gfx.DrawLine($penGold, [float]($resP.Left - 70), 680.0, [float]($resP.Left - 18), 680.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 18), 680.0, [float]($resP.Right + 70), 680.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 20, [System.Drawing.FontStyle]::Bold)
    $brushTag = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(168, 136, 91))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushTag ($w / 2) 735 5 "Center"

    $badgeY = 820
    $brushPill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25, 255, 255, 255))
    $penPill = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(80, 197, 168, 128), 1.2)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)

    Draw-RoundedRect $gfx 130 $badgeY 250 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 255 ($badgeY + 14) 2 "Center"

    Draw-RoundedRect $gfx 400 $badgeY 280 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "RERA REGISTERED" $fontPill $brushGold 540 ($badgeY + 14) 2 "Center"

    Draw-RoundedRect $gfx 700 $badgeY 250 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "JAIPUR PLOTS" $fontPill $brushGold 825 ($badgeY + 14) 2 "Center"

    $cardX = 90; $cardY = 920; $cardW = 900; $cardH = 460
    $brushCard = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 255, 255, 255))
    $penCard = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(75, 197, 168, 128), 1.5)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 16 $brushCard $penCard

    $fontCardHead = New-Object System.Drawing.Font("Georgia", 26, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "PREMIUM COMMERCIAL & RESIDENTIAL" $fontCardHead $brushGold ($w / 2) ($cardY + 38) 3 "Center"

    $fontTown = New-Object System.Drawing.Font("Century Gothic", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "CHART KNOWLEDGE PARK" $fontTown $brushWhite ($w / 2) ($cardY + 100) 2 "Center"
    Draw-SpacedText $gfx "&   CHART NEXARA TOWNSHIP" $fontTown $brushWhite ($w / 2) ($cardY + 145) 2 "Center"

    $fontFeat = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(190, 195, 205))
    Draw-SpacedText $gfx "200 Bigha Township  -  Mahindra World City, Ajmer Road" $fontFeat $brushMuted ($w / 2) ($cardY + 215) 2 "Center"
    Draw-SpacedText $gfx "250 Ft, 100 Ft, 60 Ft Wide Connected Sector Roads" $fontFeat $brushMuted ($w / 2) ($cardY + 260) 2 "Center"
    Draw-SpacedText $gfx "World-Class Amenities: Grand Club House, Parks, Gym" $fontFeat $brushMuted ($w / 2) ($cardY + 305) 2 "Center"

    $penDiv = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 255, 255, 255), 1.0)
    $gfx.DrawLine($penDiv, [float]($cardX + 40), [float]($cardY + 360), [float]($cardX + $cardW - 40), [float]($cardY + 360))

    $fontRate = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "Residential: Rs. 34,950 / sq.yd   |   Commercial: Rs. 47,000 / sq.yd" $fontRate $brushGold ($w / 2) ($cardY + 395) 2 "Center"

    $ctaY = 1460; $btnW = 750; $btnH = 80; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(213, 186, 142),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 16 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 22, [System.Drawing.FontStyle]::Bold)
    $brushDark = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 20, 24))
    Draw-SpacedText $gfx "CALL / WHATSAPP: +91 8824348273" $fontBtn $brushDark ($w / 2) ($ctaY + 28) 2 "Center"

    $fontFoot = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)
    $brushFoot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(170, 160, 145))
    Draw-SpacedText $gfx "Location: Mahindra World City, Ajmer Road, Jaipur" $fontFoot $brushFoot ($w / 2) 1590 2 "Center"
    Draw-SpacedText $gfx "WWW.JAIPURPRIMEPROPERTY.COM" $fontFoot $brushGold ($w / 2) 1640 4 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\instagram-story-dark-1080x1920.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated Instagram Story Dark: $outPath"
}

function Generate-InstagramStoryWhite {
    $w = 1080; $h = 1920
    $bmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $gfx.FillRectangle($brushWhite, 0, 0, $w, $h)

    $penGrid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(242, 237, 230), 1.0)
    for ($gx = 60; $gx -lt $w; $gx += 120) { $gfx.DrawLine($penGrid, [float]$gx, 0.0, [float]$gx, [float]$h) }
    for ($gy = 40; $gy -lt $h; $gy += 80) { $gfx.DrawLine($penGrid, 0.0, [float]$gy, [float]$w, [float]$gy) }
    $penGrid.Dispose()

    $penFrame = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 2.0)
    Draw-RoundedRect $gfx 35 45 ($w - 70) ($h - 90) 20 $null $penFrame

    if (Test-Path $emblemTransparentPath) {
        $emblem = [System.Drawing.Bitmap]::FromFile($emblemTransparentPath)
        $emblemW = 280; $emblemH = 320
        $emblemX = ($w - $emblemW) / 2
        $gfx.DrawImage($emblem, [float]$emblemX, 220.0, [float]$emblemW, [float]$emblemH)
        $emblem.Dispose()
    }

    $fontJaipur = New-Object System.Drawing.Font("Georgia", 50, [System.Drawing.FontStyle]::Bold)
    $brushSlate = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(55, 65, 81))
    Draw-SpacedText $gfx "JAIPUR" $fontJaipur $brushSlate ($w / 2) 580 8 "Center"

    $fontPrime = New-Object System.Drawing.Font("Century Gothic", 38, [System.Drawing.FontStyle]::Bold)
    $brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 138, 70))
    $resP = Draw-SpacedText $gfx "PRIME PROPERTY" $fontPrime $brushGold ($w / 2) 660 6 "Center"

    $penGold = New-Object System.Drawing.Pen($brushGold, 2.5)
    $gfx.DrawLine($penGold, [float]($resP.Left - 70), 680.0, [float]($resP.Left - 18), 680.0)
    $gfx.DrawLine($penGold, [float]($resP.Right + 18), 680.0, [float]($resP.Right + 70), 680.0)

    $fontTag = New-Object System.Drawing.Font("Century Gothic", 20, [System.Drawing.FontStyle]::Bold)
    $brushCharcoal = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 100, 110))
    Draw-SpacedText $gfx "KPP   |   INVEST  -  OWN  -  PROSPER" $fontTag $brushCharcoal ($w / 2) 735 5 "Center"

    $badgeY = 820
    $brushPill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 247, 242))
    $penPill = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(197, 168, 128), 1.2)
    $fontPill = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Bold)

    Draw-RoundedRect $gfx 130 $badgeY 250 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "JDA APPROVED" $fontPill $brushGold 255 ($badgeY + 14) 2 "Center"

    Draw-RoundedRect $gfx 400 $badgeY 280 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "RERA REGISTERED" $fontPill $brushGold 540 ($badgeY + 14) 2 "Center"

    Draw-RoundedRect $gfx 700 $badgeY 250 48 8 $brushPill $penPill
    Draw-SpacedText $gfx "JAIPUR PLOTS" $fontPill $brushGold 825 ($badgeY + 14) 2 "Center"

    $cardX = 90; $cardY = 920; $cardW = 900; $cardH = 460
    $brushCard = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(252, 250, 246))
    $penCard = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 205, 185), 1.5)
    Draw-RoundedRect $gfx $cardX $cardY $cardW $cardH 16 $brushCard $penCard

    $fontCardHead = New-Object System.Drawing.Font("Georgia", 26, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "PREMIUM COMMERCIAL & RESIDENTIAL" $fontCardHead $brushGold ($w / 2) ($cardY + 38) 3 "Center"

    $fontTown = New-Object System.Drawing.Font("Century Gothic", 22, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "CHART KNOWLEDGE PARK" $fontTown $brushSlate ($w / 2) ($cardY + 100) 2 "Center"
    Draw-SpacedText $gfx "&   CHART NEXARA TOWNSHIP" $fontTown $brushSlate ($w / 2) ($cardY + 145) 2 "Center"

    $fontFeat = New-Object System.Drawing.Font("Century Gothic", 16, [System.Drawing.FontStyle]::Regular)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 110, 120))
    Draw-SpacedText $gfx "200 Bigha Township  -  Mahindra World City, Ajmer Road" $fontFeat $brushMuted ($w / 2) ($cardY + 215) 2 "Center"
    Draw-SpacedText $gfx "250 Ft, 100 Ft, 60 Ft Wide Connected Sector Roads" $fontFeat $brushMuted ($w / 2) ($cardY + 260) 2 "Center"
    Draw-SpacedText $gfx "World-Class Amenities: Grand Club House, Parks, Gym" $fontFeat $brushMuted ($w / 2) ($cardY + 305) 2 "Center"

    $penDiv = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(230, 220, 205), 1.0)
    $gfx.DrawLine($penDiv, [float]($cardX + 40), [float]($cardY + 360), [float]($cardX + $cardW - 40), [float]($cardY + 360))

    $fontRate = New-Object System.Drawing.Font("Century Gothic", 17, [System.Drawing.FontStyle]::Bold)
    Draw-SpacedText $gfx "Residential: Rs. 34,950 / sq.yd   |   Commercial: Rs. 47,000 / sq.yd" $fontRate $brushGold ($w / 2) ($cardY + 395) 2 "Center"

    $ctaY = 1460; $btnW = 750; $btnH = 80; $btnX = ($w - $btnW) / 2
    $brushBtn = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Rectangle($btnX, $ctaY, $btnW, $btnH)),
        [System.Drawing.Color]::FromArgb(200, 160, 95),
        [System.Drawing.Color]::FromArgb(168, 136, 91),
        0.0
    )
    Draw-RoundedRect $gfx $btnX $ctaY $btnW $btnH 16 $brushBtn $null
    $fontBtn = New-Object System.Drawing.Font("Century Gothic", 22, [System.Drawing.FontStyle]::Bold)
    $brushBtnWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    Draw-SpacedText $gfx "CALL / WHATSAPP: +91 8824348273" $fontBtn $brushBtnWhite ($w / 2) ($ctaY + 28) 2 "Center"

    $fontFoot = New-Object System.Drawing.Font("Century Gothic", 15, [System.Drawing.FontStyle]::Bold)
    $brushFoot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 125, 135))
    Draw-SpacedText $gfx "Location: Mahindra World City, Ajmer Road, Jaipur" $fontFoot $brushFoot ($w / 2) 1590 2 "Center"
    Draw-SpacedText $gfx "WWW.JAIPURPRIMEPROPERTY.COM" $fontFoot $brushGold ($w / 2) 1640 4 "Center"

    $gfx.Flush(); $gfx.Dispose()
    $outPath = "assets\covers\instagram-story-white-1080x1920.jpg"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Output "Generated Instagram Story White: $outPath"
}

# Run all generators
Generate-FacebookCoverDark
Generate-FacebookCoverWhite
Generate-WhatsAppCoverDark
Generate-WhatsAppCoverWhite
Generate-InstagramSquareDark
Generate-InstagramSquareWhite
Generate-InstagramStoryDark
Generate-InstagramStoryWhite
Write-Output "ALL COVERS RE-GENERATED SUCCESSFULLY!"
