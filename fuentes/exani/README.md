# Guía del EXANI-II (fuentes)

Guía en video para el registro en línea al EXANI-II (Facultad de Ingeniería Tampico, UAT).
La página publicada es `docs/exani/index.html`; el video es `docs/exani/registro-exani-ii.mp4`.

## Cómo volver a generar el video

`fuentes/exani/fuente.html` es la versión animada del video (escenas, textos en pantalla y narración en `NARR`).
Si cambia algún texto ahí, regenere el MP4:

```sh
bash fuentes/comun/instalar_modelos.sh   # dependencias y modelos de voz
python3 fuentes/exani/narracion.py fuentes/exani/fuente.html modelos/vits-piper-es_MX-claude-high/es_MX-claude-high.onnx .trabajo/exani/audio
python3 fuentes/exani/linea_de_tiempo.py .trabajo/exani/audio
node fuentes/exani/render.js fuentes/exani/fuente.html .trabajo/exani/audio/timeline.json .trabajo/exani/audio/voz.wav docs/exani/registro-exani-ii.mp4
```

`render.js` necesita Playwright con Chromium y `ffmpeg`. La portada (`docs/exani/portada.jpg`) es un cuadro de la escena inicial sin subtítulo:
use el mismo `render.js` con un último argumento de segundos (p. ej. `4`) y una línea de tiempo con los textos de la escena 0 vacíos.
