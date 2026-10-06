#!/usr/bin/env bash
# Instala las dependencias y descarga los modelos de voz en modelos/ (esa carpeta no se sube al repositorio).
# Uso (desde cualquier carpeta):  bash fuentes/comun/instalar_modelos.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
RAIZ=$(pwd)

echo "== Dependencias de Python"
pip install -q --break-system-packages sherpa-onnx soundfile numpy pillow playwright kokoro-onnx piper-tts 2>/dev/null \
  || pip install -q sherpa-onnx soundfile numpy pillow playwright kokoro-onnx piper-tts

echo "== Playwright para Node (grabación de Servicio Social y EXANI-II)"
[ -d fuentes/node_modules/playwright ] || npm install --silent --no-save --prefix fuentes playwright

command -v ffmpeg >/dev/null || { echo "Falta ffmpeg: instálelo (apt-get install -y ffmpeg)"; exit 1; }

echo "== Modelos de voz"
mkdir -p modelos && cd modelos
# Primero se intenta la copia guardada en este repositorio (release "modelos-v1"); si no está, la fuente original.
PROPIO=https://github.com/examenes-estandarizados/examenes-estandarizados.github.io/releases/download/modelos-v1
baja() {
  [ -s "$1" ] && return 0
  echo "   $1"
  curl -fsSL -o "$1" "$PROPIO/$1" 2>/dev/null || curl -fsSL -o "$1" "$2"
}
SHERPA=https://github.com/k2-fsa/sherpa-onnx/releases/download/tts-models
KOKORO=https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0

# EGEL Plus (render.py): Kokoro multilenguaje para sherpa-onnx, voz 28 = ef_dora
baja kokoro-multi-lang-v1_0.tar.bz2 "$SHERPA/kokoro-multi-lang-v1_0.tar.bz2"
[ -d kokoro-multi-lang-v1_0 ] || tar xjf kokoro-multi-lang-v1_0.tar.bz2

# Servicio Social (narrar.py): Kokoro para kokoro-onnx, voz ef_dora
baja kokoro-v1.0.onnx "$KOKORO/kokoro-v1.0.onnx"
baja voices-v1.0.bin "$KOKORO/voices-v1.0.bin"

# EXANI-II (narracion.py): Piper es_MX claude-high (mientras no se cambie a Kokoro)
baja vits-piper-es_MX-claude-high.tar.bz2 "$SHERPA/vits-piper-es_MX-claude-high.tar.bz2"
[ -d vits-piper-es_MX-claude-high ] || tar xjf vits-piper-es_MX-claude-high.tar.bz2

echo "Listo. Modelos en $RAIZ/modelos"
