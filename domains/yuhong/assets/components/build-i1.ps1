# Build I1 (Ask-Then-Reveal Concept Page) as slide 9 of the executable component deck.
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "i1-content.json") | ConvertFrom-Json
$PT = 72.0
# Template theme1 token colors (COM RGB = R + G*256 + B*65536), see shared/ppt-design-spec.md layer 2.
$INK = 4608080    # 80,80,70    #505046 (template dk2, ink)
$GREY = 6975343   # 111,111,106 #6F6F6A (grey)
$RED = 9906       # 178,38,0    #B22600 (template accent6, deep red - text)
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
    $slide = $presentation.Slides.AddSlide(9, $layout)
    $slide.FollowMasterBackground = -1

    # Title (the question) - top, large ink
    Add-Txt $slide "TITLE" 0.6 0.42 11.8 1.0 $content.title 28 $true $INK 1

    # Ask zone - middle: prompt + three equal choice bands (alternating light fills)
    Add-Txt $slide "ASK_PROMPT" 0.6 1.7 11.8 0.5 $content.ask_prompt 16 $true $RED 1
    $optY = @(2.35, 3.15, 3.95)
    $optX = 0.6
    $optW = 11.8
    for ($i = 0; $i -lt 3; $i++) {
        $fill = if (($i % 2) -eq 0) { 16316407 } else { 14806254 }  # #F7F7F8 / #EEECE1 (COM BGR)
        Add-Rect $slide ("OPT_BAND_" + ($i + 1)) $optX $optY[$i] $optW 0.62 $fill $GREY
        Add-Txt $slide ("OPT_" + ($i + 1) + "_TEXT") ($optX + 0.3) ($optY[$i] + 0.1) ($optW - 0.6) 0.45 $content.("opt_" + ($i + 1)) 14 $false $INK 1
    }

    # Reveal zone - bottom: deep ink band with white reveal text
    Add-Rect $slide "REVEAL_BAND" 0.6 4.95 12.1 1.6 $INK $INK
    Add-Txt $slide "REVEAL_TITLE" 0.85 5.15 11.0 0.5 $content.reveal_title 16 $true $WHITE 1
    Add-Txt $slide "REVEAL_TEXT" 0.85 5.7 11.0 0.7 $content.reveal_text 13 $false $WHITE 1

    # Teaching cue - bottom line
    Add-Txt $slide "TEACHING_CUE" 0.6 6.8 12.1 0.5 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "I1_SLIDE_9_OK slides=$slideCount"
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
