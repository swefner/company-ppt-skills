# Scan the cherry-red generic logic library into a UTF-8 TSV for indexing.
# Each row: slide number | first text (title) | shape count | picture count.
# Output next to this script: cherry-red-logic-scan.tsv
$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = Join-Path $scriptRoot "cherry-red-logic-components.pptx"
$out = Join-Path $scriptRoot "cherry-red-logic-scan.tsv"
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    $rows = New-Object System.Collections.Generic.List[string]
    $rows.Add("slide`tfirst_text`tshapes`tpictures")
    for ($i = 1; $i -le $presentation.Slides.Count; $i++) {
        $s = $presentation.Slides.Item($i)
        $first = ""
        foreach ($sh in $s.Shapes) {
            if ($sh.HasTextFrame) {
                $t = $sh.TextFrame.TextRange.Text
                if ($t.Length -gt 0) { $first = $t; break }
            }
        }
        $first = $first -replace "[\r\n\t]+", " " -replace "\s+", " "
        if ($first.Length -gt 60) { $first = $first.Substring(0, 60) }
        $pics = 0
        foreach ($sh in $s.Shapes) {
            if ($sh.Type -eq 13) { $pics++ }
        }
        $rows.Add("$i`t$first`t$($s.Shapes.Count)`t$pics")
    }
    [IO.File]::WriteAllLines($out, $rows, (New-Object System.Text.UTF8Encoding($false)))
    Write-Output "SCAN_OK rows=$($rows.Count - 1) out=$out"
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
