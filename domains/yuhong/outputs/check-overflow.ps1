# Real-render overflow check: compare TextRange2.BoundHeight against shape usable height.
param(
    [string]$DeckPath
)

$ErrorActionPreference = "Stop"
$deck = [IO.Path]::GetFullPath($DeckPath)
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    $slotNames = @("TITLE","SUBTITLE","J01_LABEL","J01_FROM","J01_TO","J02_LABEL","J02_FROM","J02_TO","J03_LABEL","J03_FROM","J03_TO","TEACHING_CUE",
                   "COUNTY_NAME","COUNTY_EVIDENCE","TOWN_01_LABEL","TOWN_01_ACTION","TOWN_02_LABEL","TOWN_02_ACTION","TOWN_03_LABEL","TOWN_03_ACTION","TOWN_04_LABEL","TOWN_04_ACTION",
                   "CORE_PROBLEM","BRAND_QUESTION","BRAND_EVIDENCE","CHANNEL_QUESTION","CHANNEL_EVIDENCE","SCENE_QUESTION","SCENE_EVIDENCE","PRODUCT_QUESTION","PRODUCT_EVIDENCE",
                   "STAGE_RULE","S1_RESULT","S1_TASK","S2_RESULT","S2_TASK","S3_RESULT","S3_TASK","S4_RESULT","S4_TASK",
                   "SYMPTOM_01_TEXT","SYMPTOM_02_TEXT","SYMPTOM_03_TEXT","SYMPTOM_04_TEXT","SYMPTOM_05_TEXT","SYMPTOM_06_TEXT","SYMPTOM_07_TEXT","SYMPTOM_08_TEXT",
                   "C1_LABEL","C1_DESC","C2_LABEL","C2_DESC","C3_LABEL","C3_DESC","C4_LABEL","C4_DESC",
                   "CASE_PROMPT","STEP_1_QUESTION","STEP_1_OUTPUT","STEP_2_QUESTION","STEP_2_OUTPUT","STEP_3_QUESTION","STEP_3_OUTPUT","STEP_4_QUESTION","STEP_4_OUTPUT","STEP_5_QUESTION","STEP_5_OUTPUT")
    $issues = 0
    for ($i = 7; $i -le 12; $i++) {
        $slide = $presentation.Slides.Item($i)
        foreach ($shape in $slide.Shapes) {
            if (-not $shape.HasTextFrame) { continue }
            $name = $shape.Name
            if ($slotNames -notcontains $name) { continue }
            $tr2 = $shape.TextFrame2
            $boundHeight = 0.0
            try { $boundHeight = $tr2.TextRange.BoundHeight } catch { }
            $usable = $shape.Height - $tr2.MarginTop - $tr2.MarginBottom
            $ratio = if ($usable -gt 0) { $boundHeight / $usable } else { 999 }
            if ($boundHeight -gt 0 -and $ratio -gt 1.05) {
                $issues++
                $txt = $shape.TextFrame2.TextRange.Text
                if ($txt.Length -gt 24) { $txt = $txt.Substring(0, 24) + "..." }
                Write-Output ("OVERFLOW P{0} {1}: textH={2:N0}pt usable={3:N0}pt x{4:N2} text={5}" -f $i, $name, $boundHeight, $usable, $ratio, $txt)
            }
        }
    }
    Write-Output "CHECK_DONE issues=$issues"
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
