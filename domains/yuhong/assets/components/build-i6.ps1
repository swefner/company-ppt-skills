# Build I6 (Group Voting Page) as slide 14 of the executable component deck.
# Interactive family: prompt + equal choices + vote tally boxes + debrief rule.
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
# NOTE: keep this script pure ASCII (PS 5.1 reads non-BOM UTF-8 as ANSI); Chinese lives in the JSON.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "i6-content.json") | ConvertFrom-Json
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
    $slide = $presentation.Slides.AddSlide(14, $layout)
    $slide.FollowMasterBackground = -1

    Add-Txt $slide "TITLE" 0.6 0.42 11.8 0.7 $content.title 26 $true $INK 1
    Add-Txt $slide "VOTE_PROMPT" 0.6 1.2 11.8 0.45 $content.vote_prompt 15 $true $RED 1

    # Four choice rows: option band (left) + vote tally box (right)
    $rowY = @(1.85, 2.5, 3.15, 3.8)
    for ($i = 0; $i -lt 4; $i++) {
        $fill = if (($i % 2) -eq 0) { $LIGHT } else { $CREAM }
        Add-Rect $slide ("CHOICE_BAND_" + ($i + 1)) 0.6 $rowY[$i] 9.5 0.55 $fill $GREY
        Add-Txt $slide ("CHOICE_" + ($i + 1) + "_TEXT") 0.9 $rowY[$i] 8.9 0.42 $content.choices[$i] 14 $false $INK 1
        Add-Rect $slide ("VOTE_BOX_" + ($i + 1)) 10.25 $rowY[$i] 2.45 0.55 $WHITE $GREY
        Add-Txt $slide ("VOTE_" + ($i + 1)) 10.4 $rowY[$i] 2.15 0.42 $content.vote_suffix 14 $true $RED 2
    }

    Add-Txt $slide "METHOD_CUE" 0.6 4.65 11.8 0.35 $content.method_cue 13 $false $GREY 1
    Add-Txt $slide "DEBRIEF_CUE" 0.6 5.15 11.8 0.35 $content.debrief_cue 13 $false $GREY 1
    Add-Txt $slide "TEACHING_CUE" 0.6 5.65 11.8 0.4 $content.cue 12 $false $GREY 1

    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "I6_SLIDE_14_OK slides=$slideCount"
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
