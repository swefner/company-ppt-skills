param(
    [string]$TemplatePath = "..\reference-decks\yuhong-template.pptx",
    [string]$ComponentPath = ".\legacy\yuhong-county-course-components.pptx",
    [string]$OutputPath = ".\yuhong-county-course-components-branded.pptx"
)

$ErrorActionPreference = "Stop"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Resolve-AssetPath([string]$pathValue) {
    if ([IO.Path]::IsPathRooted($pathValue)) {
        return [IO.Path]::GetFullPath($pathValue)
    }
    return [IO.Path]::GetFullPath((Join-Path $scriptRoot $pathValue))
}

$template = Resolve-AssetPath $TemplatePath
$component = Resolve-AssetPath $ComponentPath
$output = Resolve-AssetPath $OutputPath

if (-not (Test-Path -LiteralPath $template)) { throw "Template not found: $template" }
if (-not (Test-Path -LiteralPath $component)) { throw "Component deck not found: $component" }

$powerPoint = New-Object -ComObject PowerPoint.Application
$presentation = $null

try {
    $presentation = $powerPoint.Presentations.Open($component, -1, 0, 0)

    # Import one template slide to bring its real master and layouts into the deck.
    $presentation.Slides.InsertFromFile($template, 0, 1, 1) | Out-Null
    $templateSlide = $presentation.Slides.Item(1)
    $templateLayout = $templateSlide.CustomLayout

    for ($index = 2; $index -le $presentation.Slides.Count; $index++) {
        $slide = $presentation.Slides.Item($index)
        $slide.CustomLayout = $templateLayout
        $slide.FollowMasterBackground = -1

        foreach ($shapeName in @("BRAND_RED_RAIL", "BRAND_MARK")) {
            try { $slide.Shapes.Item($shapeName).Delete() } catch { }
        }
    }

    $templateSlide.Delete()
    if (Test-Path -LiteralPath $output) { Remove-Item -LiteralPath $output -Force }
    $presentation.SaveAs($output)
}
finally {
    if ($null -ne $presentation) { $presentation.Close() }
    $powerPoint.Quit()
    [Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
}

Write-Output $output
