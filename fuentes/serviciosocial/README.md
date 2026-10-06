# Video del Servicio Social

Cómo se genera `Servicio_Social_FIT.mp4` (1920x1080, 30 fps, voz en español con subtítulos).

1. `narracion.json`: texto de la narración por escena, en trato de usted.
2. `python3 fuentes/serviciosocial/narrar.py modelos/kokoro-v1.0.onnx modelos/voices-v1.0.bin` (modelos: `bash fuentes/comun/instalar_modelos.sh`): genera la voz (Kokoro-82M, voz `ef_dora`, español latino) en `audio/narracion.wav` y los tiempos en `tiempos.json`.
3. `python3 fuentes/serviciosocial/construir_render.py`: arma `render.html` a partir de `escenas.html` y le agrega la cortinilla de entrada.
4. `node fuentes/serviciosocial/grabar.mjs` (sin argumentos guarda en `docs/serviciosocial/Servicio_Social_FIT.mp4`): graba `render.html` cuadro por cuadro con Playwright y une el video con la narración usando ffmpeg.

Para revisar algunos cuadros sueltos sin grabar todo: `node fuentes/serviciosocial/grabar.mjs --prueba 1.5,20,60`.

Notas:
- Los formatos de ejemplo (`img/d1.jpg`–`d4.jpg` y `kit/12_…`–`15_…`) tienen la firma y los folios difuminados. No los reemplace por los originales.
- Para volver a grabar solo la imagen conservando la voz aprobada: extraiga el audio del MP4 publicado
  (`ffmpeg -i docs/serviciosocial/Servicio_Social_FIT.mp4 -vn -ac 1 -ar 24000 fuentes/serviciosocial/audio/narracion.wav`) y corra el paso 4.
- Si `node grabar.mjs` no encuentra Chromium, indíquelo con la variable `CHROMIUM` (p. ej. `CHROMIUM=/opt/pw-browsers/chromium-1194/chrome-linux/chrome`).
