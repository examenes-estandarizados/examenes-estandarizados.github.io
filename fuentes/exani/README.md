# Guía del EXANI-II (fuentes)

Guía en video para el registro en línea al EXANI-II (Facultad de Ingeniería Tampico, UAT).
La página publicada es `docs/exani/index.html`; el video es `docs/exani/registro-exani-ii.mp4`.

## Cómo volver a generar el video

`fuentes/exani/fuente.html` es la versión animada del video (escenas, textos en pantalla y narración en `NARR`).
La voz es Kokoro `ef_dora` (la misma del EGEL Plus y del Servicio Social) y el render lo hace `fuentes/comun/voz/render.py`
(config `exani`). Si cambia algún texto de `fuente.html`, regenere el MP4 (≈ 6 min):

```sh
bash fuentes/comun/instalar_modelos.sh                 # una vez por sesión: dependencias y modelos
python3 fuentes/comun/voz/render.py exani              # → .trabajo/exani/registro-exani-ii.mp4
cp .trabajo/exani/registro-exani-ii.mp4 docs/exani/
```

Después actualice la duración ("Duración m:ss") en `docs/exani/index.html` y en `docs/index.html`.

Los elementos que aparecen justo cuando la voz dice una frase se definen en `overrides` de la config `exani` en `render.py`
(escena, selector, frase; con un cuarto valor `'--h'` se define cuándo se oculta). Si cambia esa frase en `NARR`,
actualice también el override o el render se detiene con "frase no encontrada". Este video no lleva cortinilla de entrada (`intro=0`).

La portada (`docs/exani/portada.jpg`) es un cuadro de la escena inicial sin subtítulo: no cambia mientras no cambie esa escena.
