# Build DC-08 (Thirty-Day Action Commitment Board) as slide 7 of the executable component deck.
# Operates on a WORK COPY; the official deck is replaced only after structural verification.
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$content = Get-Content -Raw -Encoding UTF8 (Join-Path $scriptRoot "dc08-content.json") | ConvertFrom-Json
$PT = 72.0
$INK = 3811863    # 23,42,58   #172A3A
$GREY = 8156262   # 102,116,124 #66747C
$RED = 2103238    # 198,23,32  #C61720
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
    $layout = $presentation.Slides.Item(1).CustomLayout   # template master already inside the deck
    $slide = $presentation.Slides.AddSlide(7, $layout)
    $slide.FollowMasterBackground = -1
    Write-Output "STEP: slide created"

    Write-Output "STEP: title"
    Add-Txt $slide "TITLE" 0.6 0.42 11.6 0.75 $content.title 26 $true $INK 1
    Add-Txt $slide "SUBTITLE" 0.6 1.08 11.6 0.5 $content.subtitle 14 $false $GREY 1

    # Column headers
    $cols = @(@("COL_OBJECT", 0.8, 1.9), @("COL_ACTION", 2.85, 4.2), @("COL_OWNER", 7.2, 1.7), @("COL_DATE", 9.0, 1.7), @("COL_METRIC", 10.85, 2.2))
    for ($i = 0; $i -lt 5; $i++) {
        $c = $cols[$i]
        Add-Txt $slide $c[0] $c[1] 1.6 $c[2] 0.45 $content.columns[$i] 13 $true $RED 1
    }

    # Four action rows with alternating fill bands
    $rows = @(2.15, 3.1, 4.05, 5.0)
    for ($r = 0; $r -lt 4; $r++) {
        $fillHex = $content.row_fills[$r % 2]
        $fillInt = [Convert]::ToInt32($fillHex.TrimStart('#'), 16)
        $fillInt = (($fillInt -band 0xFF) -shl 16) -bor ($fillInt -band 0xFF00) -bor (($fillInt -shr 16) -band 0xFF)
        Write-Output "STEP: row band $($r + 1)"
        Add-Rect $slide ("ROW_BAND_" + ($r + 1)) 0.65 $rows[$r] 12.2 0.9 $fillInt $GREY
        for ($c = 0; $c -lt 5; $c++) {
            $col = $cols[$c]
            $suffix = @("OBJECT","ACTION","OWNER","DATE","METRIC")[$c]
            Add-Txt $slide ("ACT_{0:D2}_{1}" -f ($r+1), $suffix) $col[1] ($rows[$r] + 0.22) $col[2] 0.5 $content.placeholder 13 $false $INK 1
        }
    }

    Add-Txt $slide "TEACHING_CUE" 0.6 6.35 12.1 0.65 $content.cue 12 $false $GREY 1

    Write-Output "STEP: saving"
    # Save to a temp path first: PowerPoint locks the file it has open, so saving
    # over the same path fails. Replace after closing.
    $tmp = $deck + ".new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    $presentation.SaveAs($tmp, 24)
    $slideCount = $presentation.Slides.Count
    $presentation.Close()
    $presentation = $null
    if (Test-Path -LiteralPath $deck) { Remove-Item -LiteralPath $deck -Force }
    Move-Item -LiteralPath $tmp -Destination $deck -Force
    Write-Output "DC08_SLIDE_7_OK slides=$slideCount"
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
