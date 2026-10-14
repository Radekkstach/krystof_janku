# Dawell CZ · Indukční shrink‑fit ohřívač – prezentace

Statická prezentační stránka s 3D animací procesu tepelného (shrink‑fit) upínání nástrojů.

- `index.html` – hlavní stránka s 3D animací (Three.js r147 přes CDN)
- `i18n.js` – překlady CS / EN / DE (přepínač v hlavičce, volba se ukládá; odkaz s `?lang=en` nebo `?lang=de` otevře stránku rovnou v daném jazyce)
- `verze-2d.html` – záložní 2D verze animace (SVG), bez WebGL
- `produkt.webp` – produktová fotografie
- `vercel.json` – konfigurace pro Vercel (čisté URL, cache fotky)

## Úpravy obsahu

Texty parametrů a kontakt jsou v bloku `PRODUCT` na začátku skriptu v `index.html`.
Položky označené `todo: true` se na stránce zobrazí oranžově podtržené – doplňte je před prezentací.

## Nasazení

Web nemá žádný build krok. Na Vercelu stačí importovat tento repozitář (Framework Preset: *Other*) a nasadit.

## Ovládání animace

mezerník = přehrát/pauza · ← → = kroky · R = od začátku · C = automatická kamera · F = celá obrazovka


## Pozor – archiv z e‑mailu

Soubor `i18n.js` je v tomto archivu přejmenovaný na `i18n.js.txt`, protože Gmail blokuje přílohy s `.js`.
Před prvním spuštěním ho přejmenuj zpět na `i18n.js` (stránka ho načítá přes `<script src="i18n.js">`).
