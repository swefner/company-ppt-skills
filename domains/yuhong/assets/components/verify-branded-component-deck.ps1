param(
    [string]$DeckPath = ".\yuhong-county-course-components-branded.pptx",
    [string]$ExpectedSha256 = "881F78A9210D46349D0B93DCC98A0B13683C23DF2C593B01E2A6BC3A9172DB2A"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$deck = if ([IO.Path]::IsPathRooted($DeckPath)) {
    [IO.Path]::GetFullPath($DeckPath)
} else {
    [IO.Path]::GetFullPath((Join-Path $scriptRoot $DeckPath))
}

if (-not (Test-Path -LiteralPath $deck)) { throw "Branded component deck not found: $deck" }
$actualHash = (Get-FileHash -LiteralPath $deck -Algorithm SHA256).Hash
if ($actualHash -ne $ExpectedSha256) { throw "Branded component deck hash mismatch: $actualHash" }

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null

try {
    $presentation = $powerPoint.Presentations.Open($deck, -1, 0, 0)
    if ($presentation.Slides.Count -ne 6) { throw "Expected 6 component slides." }
    if ($presentation.Designs.Count -ne 1) { throw "Expected one inherited Yuhong design." }
    $expectedLayoutName = $presentation.Slides.Item(1).CustomLayout.Name

    for ($index = 1; $index -le $presentation.Slides.Count; $index++) {
        $slide = $presentation.Slides.Item($index)
        if ($slide.FollowMasterBackground -ne -1) {
            throw "Slide $index does not follow the inherited master background."
        }
        $layoutShapeNames = @()
        foreach ($layoutShape in $slide.CustomLayout.Shapes) { $layoutShapeNames += $layoutShape.Name }
        if ($slide.CustomLayout.Name -ne $expectedLayoutName -or
            $slide.CustomLayout.Shapes.Count -ne 2 -or
            $layoutShapeNames -notcontains "Picture 7" -or
            $layoutShapeNames -notcontains "Picture 1") {
            throw "Slide $index is not attached to the expected Yuhong template layout."
        }
        $shapeNames = @()
        foreach ($shape in $slide.Shapes) { $shapeNames += $shape.Name }
        foreach ($forbiddenShape in @("BRAND_RED_RAIL", "BRAND_MARK")) {
            if ($shapeNames -contains $forbiddenShape) {
                throw "Slide $index still contains $forbiddenShape."
            }
        }
    }

}
finally {
    if ($null -ne $presentation) { $presentation.Close() }
    $powerPoint.Quit()
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}

Write-Output "Branded component deck verified: $actualHash"
