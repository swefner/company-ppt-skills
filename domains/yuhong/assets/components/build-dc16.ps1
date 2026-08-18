# Build DC-16 (Township And Outlet Opportunity Prioritization) as slide 10 of the executable component deck.
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "dc16-content.json") | ConvertFrom-Json
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
    $slide = $presentation.Slides.AddSlide(10, $layout)
    $slide.FollowMasterBackground = -1

    # Title + subtitle
    Add-Txt $slide "TITLE" 0.6 0.42 11.8 0.7 $content.title 26 $true $INK 1
    Add-Txt $slide "SUBTITLE" 0.6 1.05 11.8 0.45 $content.subtitle 14 $false $GREY 1

    # Left: candidate evidence cards
    Add-Txt $slide "CAN_TITLE" 0.6 1.6 5.0 0.4 $content.can_title 15 $true $RED 1
    $canY = @(2.1, 2.85, 3.6)
    for ($i = 0; $i -lt 3; $i++) {
        $fill = if (($i % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("CAN_BAND_" + ($i + 1)) 0.6 $canY[$i] 4.3 0.6 $fill $GREY
        Add-Txt $slide ("CAN_" + ($i + 1) + "_NAME") 0.8 $canY[$i] 3.9 0.3 $content.candidates[$i].name 13 $true $INK 1
        Add-Txt $slide ("CAN_" + ($i + 1) + "_EVIDENCE") 0.8 ($canY[$i] + 0.3) 3.9 0.28 $content.candidates[$i].evidence 11 $false $GREY 1
    }

    # Right: value x difficulty matrix (2x2 quadrants)
    Add-Txt $slide "MATRIX_TITLE" 5.2 1.6 6.0 0.4 $content.matrix_title 15 $true $RED 1
    $qX = @(5.2, 8.9)
    $qY = @(2.1, 3.6)
    $qW = 3.5
    $qH = 1.4
    $qLabels = @("Q1", "Q2", "Q3", "Q4")
    for ($r = 0; $r -lt 2; $r++) {
        for ($c = 0; $c -lt 2; $c++) {
            $qi = $r * 2 + $c
            $fill = if (($qi % 2) -eq 0) { $LIGHT } else { $CREAM }
            Add-Rect $slide ("QUAD_" + $qLabels[$qi]) $qX[$c] $qY[$r] $qW $qH $fill $GREY
            Add-Txt $slide ("QUAD_" + $qLabels[$qi] + "_LABEL") ($qX[$c] + 0.15) ($qY[$r] + 0.1) ($qW - 0.3) 0.35 $content.quadrants[$qi].label 13 $true $RED 1
            Add-Txt $slide ("QUAD_" + $qLabels[$qi] + "_HINT") ($qX[$c] + 0.15) ($qY[$r] + 0.5) ($qW - 0.3) 0.3 $content.quadrants[$qi].hint 11 $false $GREY 1
            Add-Txt $slide ("QUAD_" + $qLabels[$qi] + "_FILL") ($qX[$c] + 0.15) ($qY[$r] + 0.9) ($qW - 0.3) 0.35 "____" 12 $false $INK 1
        }
    }

    # Bottom: resource bet area (three lanes)
    Add-Rect $slide "BET_BAND" 0.6 5.35 12.1 1.25 $INK $INK
    Add-Txt $slide "BET_TITLE" 0.85 5.5 2.0 0.4 $content.bet_title 15 $true $WHITE 1
    $betX = @(3.0, 6.0, 9.0)
    for ($i = 0; $i -lt 3; $i++) {
        Add-Txt $slide ("BET_" + ($i + 1) + "_LABEL") $betX[$i] 5.5 1.8 0.35 $content.bets[$i].label 13 $true $WHITE 1
        Add-Txt $slide ("BET_" + ($i + 1) + "_TARGET") $betX[$i] 5.95 2.6 0.4 $content.bets[$i].target 12 $false $WHITE 1
    }

    Add-Txt $slide "TEACHING_CUE" 0.6 6.85 12.1 0.4 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "DC16_SLIDE_10_OK slides=$slideCount"
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
