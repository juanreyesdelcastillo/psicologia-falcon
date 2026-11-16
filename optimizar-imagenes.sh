#!/usr/bin/env bash
# Genera versiones web de las fotos y logos originales en assets/.
# Uso: tools/optimizar-imagenes.sh "/ruta/a/Archivos WEB PF"
set -euo pipefail
SRC="${1:?Indica la carpeta con los archivos originales}"
cd "$(dirname "$0")/.."
mkdir -p assets/equipo assets/pachuca assets/merida assets/logo

opt() { magick "$1" -auto-orient -resize "$3x$3>" -strip -interlace Plane -sampling-factor 4:2:0 -quality 78 "$2"; }

opt "$SRC/Psicologas/Doc. Linda.jpg" assets/equipo/linda.jpg 1200
opt "$SRC/Psicologas/Nao.jpg"        assets/equipo/naomi.jpg 1200
opt "$SRC/Psicologas/Karen.jpg"      assets/equipo/karen.jpg 1200
opt "$SRC/Psicologas/Karla.jpg"      assets/equipo/karla.jpg 1200
opt "$SRC/Psicologas/IMG_3511.jpg"   assets/equipo/equipo.jpg 2000

opt "$SRC/Pachuca/IMG_3658.jpg" assets/pachuca/sala.jpg 1600
opt "$SRC/Pachuca/IMG_0717.jpg" assets/pachuca/meditacion.jpg 2000
opt "$SRC/Pachuca/IMG_5867.jpg" assets/pachuca/planta.jpg 1600
opt "$SRC/Pachuca/IMG_6094.jpg" assets/pachuca/sillon.jpg 1600

i=1
for f in "$SRC"/M*rida/*.jpg; do
  echo "merida/m$i.jpg <- $(basename "$f")"
  opt "$f" "assets/merida/m$i.jpg" 1448
  i=$((i + 1))
done

L="$SRC/Logo Psi.Fal."
logo() { magick "$1" -trim +repage -resize '900x900>' -strip "$2"; }
logo "$L/17.png" assets/logo/logo-negro.png
logo "$L/18.png" assets/logo/logo-blanco.png
logo "$L/9.png" assets/logo/pf-blanco.png
logo "$L/Logo Psi.Fal..png" assets/logo/pf-negro.png
magick assets/logo/pf-negro.png -resize 60x60 -gravity center -background none -extent 64x64 assets/logo/favicon.png
