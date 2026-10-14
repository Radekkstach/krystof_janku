param([string]$Project, [string]$OutDir)
# Builds the claude.ai artifact version of the page from the single-file export:
# the artifact host adds its own doctype/html/head/body skeleton, so strip ours.
$enc = New-Object Text.UTF8Encoding $false
New-Item -ItemType Directory -Force $OutDir | Out-Null
$html = [IO.File]::ReadAllText((Join-Path $Project 'Dawell-DTI-16.html'), $enc)
$html = $html -replace '(?mi)^<!doctype html>\r?\n', ''
$html = $html -replace '(?m)^<html[^>]*>\r?\n', ''
$html = $html -replace '(?m)^</?head>\r?\n', ''
$html = $html -replace '(?m)^<body>\r?\n', ''
$html = $html -replace '(?m)^</body>\r?\n', ''
$html = $html -replace '(?m)^</html>\s*$', ''
$html = $html -replace '(?m)^<meta charset="utf-8">\r?\n', ''
$html = $html -replace '(?m)^<meta name="viewport"[^>]*>\r?\n', ''
# the outdated 2D page is not published with the link: drop the "or use the 2D version" part (CS/EN/DE)
$html = $html -replace ',? (?:nebo \S+|or use the|oder nutzen Sie die) <a href=\\?"verze-2d\.html\\?">[^<]*</a>', ''
[IO.File]::WriteAllText((Join-Path $OutDir 'dawell-dti-16.html'), $html, $enc)
'--- verze-2d refs left: ' + ([regex]::Matches($html, 'verze-2d')).Count
Get-ChildItem $OutDir | Select-Object Name, Length
'--- first lines ---'
($html -split "`n" | Select-Object -First 4) -join "`n"
'--- wrapper tags left: ' + ([regex]::Matches($html, '(?m)^</?(html|head|body)\b')).Count
