# Render every executable component source slide to PNG previews + fingerprint manifest.
# Run whenever the component source deck or its master changes, so previews never go stale.
# Outputs:
#   previews/component-01.png ... component-06.png  (1280x720 PNG, one per source slide)
#   previews/component-render-manifest.json          (source deck sha256 + per-slide png sha256)
param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx",
    [string]$PreviewDir = ".\previews"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Resolve-AssetPath([string]$pathValue) {
    if ([IO.Path]::IsPathRooted($pathValue)) {
        return [IO.Path]::GetFullPath($pathValue)
    }
    return [IO.Path]::GetFullPath((Join-Path $scriptRoot $pathValue))
}

$deck = Resolve-AssetPath $DeckPath
$previewDir = Resolve-AssetPath $PreviewDir
if (-not (Test-Path -LiteralPath $deck)) { throw "Component deck not found: $deck" }
if (-not (Test-Path -LiteralPath $previewDir)) { New-Item -ItemType Directory -Path $previewDir | Out-Null }

$deckHash = (Get-FileHash -LiteralPath $deck -Algorithm SHA256).Hash

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null
try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    $entries = @()
    for ($i = 1; $i -le $presentation.Slides.Count; $i++) {
        $name = "component-{0:D2}.png" -f $i
        $path = Join-Path $previewDir $name
        $presentation.Slides.Item($i).Export($path, "PNG", 1280, 720)
        $pngHash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        $entries += [ordered]@{
            slide = $i
            file  = $name
            sha256 = $pngHash
        }
    }
    $manifest = [ordered]@{
        source_deck = (Split-Path -Leaf $deck)
        source_deck_sha256 = $deckHash
        render_note = "Re-run tools/render-component-previews.ps1 (assets/components) after any change to the component source deck or its template master."
        pages = $entries
    }
    $manifestPath = Join-Path $previewDir "component-render-manifest.json"
    $manifest | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $manifestPath -Encoding UTF8
    Write-Output "RENDERED=$($entries.Count) pages, deck=$deckHash"
    Write-Output "MANIFEST=$manifestPath"
}
finally {
    try { if ($null -ne $presentation) { $presentation.Close() } } catch { }
    try { $powerPoint.Quit() } catch { }
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}
