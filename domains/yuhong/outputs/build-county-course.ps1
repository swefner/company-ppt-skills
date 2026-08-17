# Build 14-page boss-mode county opportunity deck from branded executable components + template master.
# Content comes from build-content.json (UTF-8). Script body is ASCII-only.
param(
    [string]$ContentPath = ".\build-content.json"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$contentPathFull = [IO.Path]::GetFullPath((Join-Path $scriptRoot $ContentPath))

$json = Get-Content -Raw -Encoding UTF8 $contentPathFull | ConvertFrom-Json

$output = [IO.Path]::GetFullPath((Join-Path $scriptRoot $json.output))
$template = [IO.Path]::GetFullPath((Join-Path $scriptRoot $json.template))
$componentDeck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $json.componentDeck))

if (-not (Test-Path -LiteralPath $template)) { throw "Template not found: $template" }
if (-not (Test-Path -LiteralPath $componentDeck)) { throw "Component deck not found: $componentDeck" }
$outDir = Split-Path -Parent $output
if (-not (Test-Path -LiteralPath $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

$PT = 72.0   # points per inch
$CR = [string][char]13

# Color map (COM RGB = R + G*256 + B*65536)
$colors = @{
    "ink"  = 3811863   # 23,42,58   #172A3A
    "red"  = 2103238   # 198,23,32  #C61720
    "grey" = 8156262   # 102,116,124 #66747C
}
$alignMap = @{ "left" = 1; "center" = 2; "right" = 3 }

function Set-TextProps($textRange, $size, $bold, $colorInt, $align, $lineSpacing) {
    $textRange.Font.Size = $size
    $textRange.Font.Bold = $bold
    $textRange.Font.Name = "Microsoft YaHei"
    $textRange.Font.NameFarEast = "Microsoft YaHei"
    $textRange.Font.Color.RGB = $colorInt
    $textRange.ParagraphFormat.Alignment = $align
    if ($lineSpacing) { $textRange.ParagraphFormat.SpaceWithin = $lineSpacing }
}

function Add-ContentLine($slide, $line) {
    $left = [double]$line.x * $PT
    $top = [double]$line.y * $PT
    $width = [double]$line.w * $PT
    $height = [double]$line.h * $PT
    $box = $slide.Shapes.AddTextbox(1, $left, $top, $width, $height)
    $box.TextFrame.WordWrap = -1
    $box.TextFrame.AutoSize = 0
    $tr = $box.TextFrame.TextRange
    $text = ([string]$line.text).Replace("`n", $CR)
    $tr.Text = $text
    $colorInt = $colors[$line.color]
    if (-not $colorInt) { $colorInt = $colors["ink"] }
    $align = $alignMap[$line.align]
    if (-not $align) { $align = 1 }
    $ls = $null
    if ($line.lineSpacing) { $ls = [double]$line.lineSpacing }
    Set-TextProps $tr ([double]$line.size) ([bool]$line.bold) $colorInt $align $ls
}

function Set-Notes($slide, $notes) {
    if (-not $notes) { return }
    $textRange = $slide.NotesPage.Shapes.Item(2).TextFrame.TextRange
    $textRange.Text = ([string]$notes).Replace("`n", $CR)
    $textRange.Font.Size = 11
    $textRange.Font.Name = "Microsoft YaHei"
    $textRange.Font.NameFarEast = "Microsoft YaHei"
}

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($componentDeck, -1, 0, 0)

    # Import one template slide to bring its real master and layouts into the deck.
    $presentation.Slides.InsertFromFile($template, 0, 1, 1) | Out-Null
    $templateSlide = $presentation.Slides.Item(1)
    $templateLayout = $templateSlide.CustomLayout
    $templateSlide.Delete()

    # Deck now holds 6 component slides (1-6). Add the 6 leading new pages in reverse so P1 lands first.
    $slideRefs = @{}
    $pages = @($json.pages)
    for ($i = 5; $i -ge 0; $i--) {
        $page = $pages[$i]
        if ($page.type -ne "new") { throw "Expected pages 1-6 to be 'new' pages" }
        $slide = $presentation.Slides.AddSlide(1, $templateLayout)
        $slide.FollowMasterBackground = -1
        $slideRefs[[int]$page.idx] = $slide
    }

    # Add the two trailing new pages (P14 worksheet, P15 closing) at positions 14 and 15.
    $page13 = $pages[13]
    $page14 = $pages[14]
    if ($page13.type -ne "new" -or $page14.type -ne "new") { throw "Expected trailing pages to be 'new' pages" }
    $s13 = $presentation.Slides.AddSlide(14, $templateLayout)
    $s13.FollowMasterBackground = -1
    $slideRefs[[int]$page13.idx] = $s13
    $s14 = $presentation.Slides.AddSlide(15, $templateLayout)
    $s14.FollowMasterBackground = -1
    $slideRefs[[int]$page14.idx] = $s14

    # Fill new pages.
    foreach ($page in $pages) {
        if ($page.type -ne "new") { continue }
        $slide = $slideRefs[[int]$page.idx]
        foreach ($line in @($page.lines)) {
            Add-ContentLine $slide $line
        }
        Set-Notes $slide $page.notes
    }

    # Fill component pages: replace named slots, drop internal COMPONENT_ID badge, keep master background.
    foreach ($page in $pages) {
        if ($page.type -ne "component") { continue }
        # Six 'new' pages were inserted at positions 1-6, so source component slides 1-6 now sit at 7-12.
        $sourceSlideNumber = [int]$page.sourceSlide + 6
        $slide = $presentation.Slides.Item($sourceSlideNumber)
        $slide.FollowMasterBackground = -1
        foreach ($prop in $page.slots.PSObject.Properties) {
            $shape = $null
            try { $shape = $slide.Shapes.Item($prop.Name) } catch { }
            if ($null -ne $shape -and $shape.HasTextFrame) {
                $tr = $shape.TextFrame.TextRange
                $tr.Text = ([string]$prop.Value).Replace("`n", $CR)
            }
        }
        try { $slide.Shapes.Item("COMPONENT_ID").Delete() } catch { }
        Set-Notes $slide $page.notes
    }

    if (Test-Path -LiteralPath $output) { Remove-Item -LiteralPath $output -Force }
    $presentation.SaveAs($output, 24)   # ppSaveAsOpenXMLPresentation

    # Verification pass.
    $verify = $powerPoint.Presentations.Open($output, -1, 0, 0)
    Write-Output "SLIDE_COUNT=$($verify.Slides.Count)"
    foreach ($page in $pages) {
        $slide = $verify.Slides.Item([int]$page.idx)
        $firstText = ""
        foreach ($shape in $slide.Shapes) {
            if ($shape.HasTextFrame -and $shape.TextFrame.TextRange.Text.Length -gt 0) {
                $firstText = $shape.TextFrame.TextRange.Text
                break
            }
        }
        $hasBadge = $false
        try { $verify.Slides.Item([int]$page.idx).Shapes.Item("COMPONENT_ID") | Out-Null; $hasBadge = $true } catch { }
        $title = $firstText
        if ($title.Length -gt 40) { $title = $title.Substring(0, 40) + "..." }
        Write-Output ("P{0} type={1} shapes={2} firstText={3} badge={4}" -f $page.idx, $page.type, $slide.Shapes.Count, $title, $hasBadge)
    }
    $hash = (Get-FileHash -LiteralPath $output -Algorithm SHA256).Hash
    Write-Output "OUTPUT_HASH=$hash"
    Write-Output "OUTPUT_PATH=$output"
    $verify.Close()
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
