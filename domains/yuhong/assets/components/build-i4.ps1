# Build I4 (Click-To-Diagnose Matrix) as slide 13 of the executable component deck.
# Interactive family: matrix with dimension rows; instructor reveals read/next per row.
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "i4-content.json") | ConvertFrom-Json
$PT = 72.0
# Template theme1 token colors (COM RGB = R + G*256 + B*65536), see shared/ppt-design-spec.md layer 2.
$INK = 4608080    # 80,80,70    #505046 (template dk2, ink)
$GREY = 6975343   # 111,111,106 #6F6F6A (grey)
$RED = 9906       # 178,38,0    #B22600 (template accent6, deep red - text)
$LIGHT = 16316407 # 247,247,248 #F7F7F8 (background)
$CREAM = 16777215 # 255,255,255 #FFFFFF (white)
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
    $slide = $presentation.Slides.AddSlide(13, $layout)
    $slide.FollowMasterBackground = -1

    Add-Txt $slide "TITLE" 0.6 0.42 11.8 0.7 $content.title 25 $true $INK 1
    Add-Txt $slide "SUBTITLE" 0.6 1.05 11.8 0.4 $content.subtitle 14 $false $GREY 1

    # Column headers
    $colX = @(0.6, 3.1, 6.0, 8.9)
    $colW = @(2.4, 2.8, 2.8, 3.8)
    $hdrY = 1.6
    for ($c = 0; $c -lt 4; $c++) {
        Add-Txt $slide ("HDR_" + ($c + 1)) $colX[$c] $hdrY $colW[$c] 0.4 $content.headers[$c] 13 $true $RED 1
    }

    # Dimension rows
    $rowY = @(2.1, 2.75, 3.4, 4.05)
    for ($r = 0; $r -lt 4; $r++) {
        $fill = if (($r % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("ROW_BAND_" + ($r + 1)) 0.6 $rowY[$r] 12.1 0.55 $fill $GREY
        # NOTE: PS 5.1 flattens nested @(...) arrays; call Add-Txt per cell directly.
        Add-Txt $slide ("DIM_" + ($r + 1) + "_NAME") ($colX[0] + 0.15) ($rowY[$r] + 0.08) ($colW[0] - 0.3) 0.4 $content.rows[$r].name 13 $true $INK 1
        Add-Txt $slide ("DIM_" + ($r + 1) + "_SYMPTOM") ($colX[1] + 0.15) ($rowY[$r] + 0.08) ($colW[1] - 0.3) 0.4 $content.rows[$r].symptom 12 $false $INK 1
        Add-Txt $slide ("DIM_" + ($r + 1) + "_READ") ($colX[2] + 0.15) ($rowY[$r] + 0.08) ($colW[2] - 0.3) 0.4 $content.rows[$r].read 12 $false $RED 1
        Add-Txt $slide ("DIM_" + ($r + 1) + "_NEXT") ($colX[3] + 0.15) ($rowY[$r] + 0.08) ($colW[3] - 0.3) 0.4 $content.rows[$r].next 12 $false $INK 1
    }

    Add-Txt $slide "DEBRIEF_CUE" 0.6 4.95 11.8 0.35 $content.debrief_cue 13 $false $GREY 1
    Add-Txt $slide "TEACHING_CUE" 0.6 5.45 11.8 0.4 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "I4_SLIDE_13_OK slides=$slideCount"
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
