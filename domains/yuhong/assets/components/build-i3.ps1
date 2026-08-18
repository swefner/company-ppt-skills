# Build I3 (Dealer Scenario Choice) as slide 12 of the executable component deck.
# Interactive family: scenario -> choices -> debrief cue (static, instructor-paced).
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "i3-content.json") | ConvertFrom-Json
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
    $slide = $presentation.Slides.AddSlide(12, $layout)
    $slide.FollowMasterBackground = -1

    Add-Txt $slide "TITLE" 0.6 0.42 11.8 0.7 $content.title 26 $true $INK 1

    # Scenario card
    Add-Rect $slide "SCENARIO_BAND" 0.6 1.25 12.1 1.55 $LIGHT $GREY
    Add-Txt $slide "SCENARIO_TITLE" 0.85 1.4 4.0 0.4 $content.scenario_title 14 $true $RED 1
    Add-Txt $slide "SCENARIO_TEXT" 0.85 1.85 11.6 0.85 $content.scenario_text 13 $false $INK 1

    # Choice prompt
    Add-Txt $slide "CHOICE_TITLE" 0.6 3.05 8.0 0.5 $content.choice_title 16 $true $RED 1

    # Four choice bands
    $choiceY = @(3.65, 4.3, 4.95, 5.6)
    for ($i = 0; $i -lt 4; $i++) {
        $fill = if (($i % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("CHOICE_BAND_" + ($i + 1)) 0.6 $choiceY[$i] 12.1 0.55 $fill $GREY
        Add-Txt $slide ("CHOICE_" + ($i + 1) + "_TEXT") 0.95 $choiceY[$i] 11.4 0.42 $content.choices[$i] 14 $false $INK 1
    }

    # Debrief cue (learner-visible light hint)
    Add-Txt $slide "DEBRIEF_CUE" 0.6 6.35 11.8 0.35 $content.debrief_cue 13 $false $GREY 1

    # Teaching cue
    Add-Txt $slide "TEACHING_CUE" 0.6 6.8 11.8 0.4 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "I3_SLIDE_12_OK slides=$slideCount"
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
