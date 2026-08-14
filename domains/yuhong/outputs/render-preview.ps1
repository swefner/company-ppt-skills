# Export all slides of the built deck to PNG previews for visual acceptance.
param(
    [string]$DeckPath,
    [string]$OutDir
)

$ErrorActionPreference = "Stop"
$deck = [IO.Path]::GetFullPath($DeckPath)
$OutDir = [IO.Path]::GetFullPath($OutDir)
if (-not (Test-Path -LiteralPath $deck)) { throw "Deck not found: $deck" }
if (-not (Test-Path -LiteralPath $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    for ($i = 1; $i -le $presentation.Slides.Count; $i++) {
        $name = "P{0:D2}.png" -f $i
        $path = Join-Path $OutDir $name
        $presentation.Slides.Item($i).Export($path, "PNG", 1280, 720)
    }
    Write-Output "EXPORTED=$($presentation.Slides.Count) files to $OutDir"
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
