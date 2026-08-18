# Build DC-06 (Product Battle Growth Board) as slide 11 of the executable component deck.
# Visual DNA: same driver-board family as DC-05 (three levers + core contradiction + strategy band).
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "dc06-content.json") | ConvertFrom-Json
$PT = 72.0
# Template theme1 token colors (COM RGB = R + G*256 + B*65536), see shared/ppt-design-spec.md layer 2.
$INK = 4608080    # 80,80,70    #505046 (template dk2, ink)
$GREY = 6975343   # 111,111,106 #6F6F6A (grey)
$RED = 2247912    # 232,76,34   #E84C22 (template accent1, brand red)
$LIGHT = 16316407 # 247,247,248 #F7F7F8 (background)
$CREAM = 14806254 # 238,236,225 #EEECE1 (template lt2)
$WHITE = 16777215 # 255,255,255

function Add-Txt($slide, $name, $x, $y, $w, $h, $text, $size, $bold, $color, $align) {
    $box = $slide.Shapes.AddTextbox(1, [double]$x*$PT, [double]$y*$PT, [double]$w*$PT, [double]$h*$PT)
    $box.Name = $name
    $box.TextFrame.WordWrap = -1
    $box.TextFrame.AutoSize = 0
    $tr = $box.TextFrame.TextRange
    $tr.Text = $text
    $tr.Font.Size = $size
    $tr.Font.Bold = $bold
    $tr.Font.Name = "Microsoft YaHei"
    $tr.Font.NameFarEast = "Microsoft YaHei"
    $tr.Font.Color.RGB = $color
    $tr.ParagraphFormat.Alignment = $align
    return $box
}

function Add-Rect($slide, $name, $x, $y, $w, $h, $fillInt, $lineInt) {
    $shape = $slide.Shapes.AddShape(1, [double]$x*$PT, [double]$y*$PT, [double]$w*$PT, [double]$h*$PT)
    $shape.Name = $name
    $shape.Fill.ForeColor.RGB = $fillInt
    $shape.Line.ForeColor.RGB = $lineInt
    $shape.Line.Weight = 0.75
    $shape.Shadow.Visible = 0
    return $shape
}

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    $layout = $presentation.Slides.Item(1).CustomLayout
    $slide = $presentation.Slides.AddSlide(11, $layout)
    $slide.FollowMasterBackground = -1

    Add-Txt $slide "TITLE" 0.6 0.42 11.8 0.75 $content.title 26 $true $INK 1
    Add-Txt $slide "SUBTITLE" 0.6 1.08 11.8 0.5 $content.subtitle 14 $false $GREY 1

    # Three lever blocks
    $leverX = @(0.6, 4.7, 8.8)
    $leverW = 3.8
    for ($i = 0; $i -lt 3; $i++) {
        $l = $content.levers[$i]
        $x = $leverX[$i]
        $fill = if (($i % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("LEVER_BAND_" + ($i + 1)) $x 1.75 $leverW 2.35 $fill $GREY
        Add-Txt $slide ("L" + ($i + 1) + "_NAME") ($x + 0.25) 1.95 ($leverW - 0.5) 0.5 $l.name 15 $true $RED 1
        Add-Txt $slide ("L" + ($i + 1) + "_QUESTION") ($x + 0.25) 2.5 ($leverW - 0.5) 0.5 $l.question 13 $true $INK 1
        Add-Txt $slide ("L" + ($i + 1) + "_VALUE") ($x + 0.25) 3.15 ($leverW - 0.5) 0.8 $l.value 12 $false $INK 1
        if ($i -lt 2) {
            Add-Txt $slide ("MULT_" + ($i + 1)) ($x + $leverW + 0.02) 2.6 0.3 0.6 "x" 20 $true $RED 2
        }
    }

    # Core contradiction finding
    Add-Rect $slide "CORE_BAND" 0.6 4.4 12.1 1.25 $INK $INK
    Add-Txt $slide "CORE_TITLE" 0.85 4.58 2.6 0.5 $content.core_title 15 $true $WHITE 1
    Add-Txt $slide "CORE_FINDING" 3.6 4.62 8.9 0.9 $content.core_finding 15 $false $WHITE 1

    # SKU strategy band (守/扩/育/淘汰)
    Add-Txt $slide "SKU_TITLE" 0.6 5.9 2.4 0.5 $content.sku_title 15 $true $RED 1
    $skuX = @(0.6, 3.6, 6.6, 9.6)
    for ($i = 0; $i -lt 4; $i++) {
        $fill = if (($i % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("SKU_BAND_" + ($i + 1)) $skuX[$i] 5.9 2.7 1.0 $fill $GREY
        Add-Txt $slide ("SKU_" + ($i + 1) + "_LABEL") ($skuX[$i] + 0.15) 5.95 1.0 0.35 $content.skus[$i].label 13 $true $RED 1
        Add-Txt $slide ("SKU_" + ($i + 1) + "_TEXT") ($skuX[$i] + 0.15) 6.35 2.4 0.5 $content.skus[$i].text 11 $false $INK 1
    }

    Add-Txt $slide "TEACHING_CUE" 0.6 7.0 12.1 0.4 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "DC06_SLIDE_11_OK slides=$slideCount"
}
catch {
    Write-Output ("ERROR: " + $_.Exception.Message)
    if ($_.InvocationInfo) { Write-Output ("AT: " + $_.InvocationInfo.PositionMessage) }
    throw
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
