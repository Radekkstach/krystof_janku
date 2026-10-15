# Sestaví z index.html jeden samostatný soubor pro poslání e-mailem:
# texty z i18n.js a obrázky (logo, fotka, ikony) vloží přímo do HTML.
# Three.js a písma se dál načítají z internetu, příjemce musí být online.
#
# Spuštění (ve složce projektu):
#   powershell -ExecutionPolicy Bypass -File export-jeden-soubor.ps1
param([string]$Out = 'Dawell-DTI-16.html')

$root = $PSScriptRoot
$enc = New-Object Text.UTF8Encoding $false
$html = [IO.File]::ReadAllText((Join-Path $root 'index.html'), $enc)
$i18n = [IO.File]::ReadAllText((Join-Path $root 'i18n.js'), $enc)

# texty: <script src="i18n.js"> → vložený skript
$html = $html.Replace('<script src="i18n.js"></script>', "<script>`r`n" + $i18n + "`r`n</script>")
# náhled pro sociální sítě s lokální cestou nemá v příloze smysl (a zdvojil by velikost fotky)
$html = $html -replace '<meta property="og:image"[^>]*>\r?\n', ''

# obrázky → data URI
$mime = @{ '.webp' = 'image/webp'; '.png' = 'image/png' }
foreach ($f in 'logo-light.webp', 'logo-dark.webp', 'produkt.webp', 'foto-dilna.webp', 'foto-dilna-detail.webp', 'foto-celek.webp', 'foto-detail.webp', 'foto-bez-upinace.webp', 'favicon.png', 'apple-touch-icon.png') {
  $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $root $f)))
  $html = $html.Replace($f, 'data:' + $mime[[IO.Path]::GetExtension($f)] + ';base64,' + $b64)
}

$path = Join-Path $root $Out
[IO.File]::WriteAllText($path, $html, $enc)
'Hotovo: {0} ({1:N0} kB)' -f $path, ((Get-Item $path).Length / 1KB)
