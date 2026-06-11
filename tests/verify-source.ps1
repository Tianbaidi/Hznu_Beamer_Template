$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$texPath = Join-Path $root 'HZNU_BeamerTemplate.tex'
$stylePath = Join-Path $root 'hznu.sty'

$tex = Get-Content -Raw -Encoding UTF8 $texPath
$style = Get-Content -Raw -Encoding UTF8 $stylePath

function Assert-Match {
    param(
        [string]$Content,
        [string]$Pattern,
        [string]$Message
    )

    if ($Content -notmatch $Pattern) {
        throw $Message
    }
}

function Assert-NotMatch {
    param(
        [string]$Content,
        [string]$Pattern,
        [string]$Message
    )

    if ($Content -match $Pattern) {
        throw $Message
    }
}

$frameCount = ([regex]::Matches($tex, '\\begin\{frame\}')).Count
if ($frameCount -ne 7) {
    throw "Expected 7 frames, found $frameCount."
}

Assert-Match $tex '\\titlepage' 'The title page example is missing.'
Assert-Match $tex '\\tableofcontents' 'The table of contents example is missing.'
Assert-Match $tex '\\begin\{itemize\}' 'The itemize example is missing.'
Assert-Match $tex '\\begin\{enumerate\}' 'The enumerate example is missing.'
Assert-Match $tex '\\begin\{block\}' 'The block example is missing.'
Assert-Match $tex '\\begin\{equation\}' 'The equation example is missing.'
Assert-Match $tex '\\begin\{thebibliography\}' 'The bibliography example is missing.'
Assert-Match $tex '\\usefonttheme\[onlymath\]\{serif\}' `
    'The example must use the current Beamer serif math font setting.'
Assert-Match $tex '\\author\[Yeung Zhaam\]\{%\s*\\texorpdfstring' `
    'The formatted author must provide a plain-text PDF metadata fallback.'
Assert-NotMatch $tex 'mathserif' `
    'The obsolete Beamer mathserif class option must not be used.'
Assert-NotMatch $tex '\\catcode' `
    'The example must not make Chinese punctuation globally active.'
Assert-NotMatch $tex '\\setbeamertemplate\{items\}\[ball\]' `
    'The modern example must not re-enable the old ball item style.'

Assert-Match $style '\\NeedsTeXFormat\{LaTeX2e\}' 'hznu.sty must declare its LaTeX requirement.'
Assert-Match $style '\\ProvidesPackage\{hznu\}' 'hznu.sty must identify itself as a package.'
Assert-Match $style '\\defbeamertemplate\*\{headline\}\{hznu theme\}' 'The custom headline is missing.'
Assert-Match $style '\\defbeamertemplate\*\{footline\}\{hznu theme\}' 'The custom footline is missing.'
Assert-Match $style '\\defbeamertemplate\*\{frametitle\}\{hznu theme\}' 'The custom frame title is missing.'
Assert-Match $style '\\defbeamertemplate\*\{title page\}\{hznu theme\}' 'The custom title page is missing.'
Assert-Match $style '\\insertframenumber\{\}\s*/\s*\\inserttotalframenumber' 'Frame numbering is missing.'
Assert-Match $style '\\setbeamertemplate\{itemize items\}\[circle\]' `
    'The theme default itemize style changed.'
Assert-Match $style '\\setbeamertemplate\{enumerate items\}\[circle\]' `
    'The theme default enumerate style changed.'
foreach ($assetPath in
    'res/hznu_background.png',
    'res/hznu_logo.png',
    'res/hznu_title.png'
) {
    Assert-Match $style ([regex]::Escape($assetPath)) `
        "The theme must pass the literal asset path to PGF: $assetPath"
}

Assert-NotMatch $style '\\hznu@asset' `
    'Asset file names must not be passed to PGF through a macro.'
Assert-Match $style '\\definecolor\{hznuNavy\}' 'The modern navy brand color is missing.'
Assert-Match $style '\\definecolor\{hznuGold\}' 'The restrained gold accent color is missing.'
Assert-Match $style '\\setbeamertemplate\{blocks\}\[rounded\]\[shadow=false\]' `
    'Blocks must use the modern shadow-free style.'
Assert-NotMatch $style 'pgfdeclarehorizontalshading|beamer@frametitleshade' `
    'The old gradient frame title must be removed.'
Assert-Match $style '\\AddToHook\{shipout/foreground\}' `
    'The watermark must be rendered in the foreground layer.'
Assert-Match $style 'blend mode=multiply' `
    'The foreground watermark must use multiply blending.'
Assert-NotMatch $style '\\setbeamertemplate\{background\}\{\\pgfuseimage\{hznu-background\}\}' `
    'The watermark must not remain only in the background layer.'
Assert-Match $tex '\\begin\{frame\}\[plain\]' `
    'The title page must use a plain frame.'

$imageDeclarationCount = ([regex]::Matches($style, '\\pgfdeclareimage')).Count
if ($imageDeclarationCount -ne 3) {
    throw "Expected 3 image declarations, found $imageDeclarationCount."
}

foreach ($asset in 'hznu_background.png', 'hznu_logo.png', 'hznu_title.png') {
    if (-not (Test-Path (Join-Path $root "res\$asset"))) {
        throw "Missing required asset: res\$asset"
    }
}

Assert-NotMatch $tex '\\usepackage\{(?:color|graphicx|hyperref|url|fontspec|xeCJK)\}' `
    'The example loads a package already provided by Beamer or ctex.'

Write-Host 'Source checks passed.'
