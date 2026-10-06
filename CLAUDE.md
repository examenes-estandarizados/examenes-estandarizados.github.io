# Guías en video — Coordinación de Exámenes Estandarizados (FIT, UAT)

Sitio con tres guías en video para alumnos de la Facultad de Ingeniería Tampico. Coordinadora: Mtra. Paulina Fernández Izaguirre.
Quien hace los cambios es Williams (TI de la Facultad). Responda en español y con claridad.

## Estructura

| Carpeta | Qué contiene |
|---|---|
| `docs/` | **Lo que se publica** (GitHub Pages, rama `main`, carpeta `/docs`). |
| `docs/index.html` | Portada con las tres guías. Cada tarjeta muestra la duración del video (`span.dur`). |
| `docs/exani/` | Guía del EXANI-II (aspirantes): página, `registro-exani-ii.mp4`, `portada.jpg`. |
| `docs/serviciosocial/` | Guía del Servicio Social: página, `Servicio_Social_FIT.mp4`, `poster.jpg`, manual en PDF. |
| `docs/egel/` | Guía del EGEL Plus (egresados): página (generada), `EGEL_Plus_FIT.mp4`, `poster.jpg`. |
| `fuentes/<guía>/` | Código para regenerar cada video (escenas, narración, scripts). Cada una tiene su README. |
| `fuentes/comun/` | Voz y render del EGEL (`voz/render.py`), fuente Montserrat local, instalador de modelos. |
| `modelos/` | Modelos de voz. **No se suben** (pesan cientos de MB): `bash fuentes/comun/instalar_modelos.sh`. |
| `.trabajo/` | Salidas temporales de los scripts. **No se suben**. |

## Reglas acordadas con la Coordinación (no las cambie sin que lo pidan)

- **Trato de usted** en todo: página, subtítulos y voz. Nunca "tú" ("descargue", "su matrícula", "Su navegador…").
- **Cada guía es independiente.** La del EGEL Plus no menciona el EXANI-II, y viceversa. La portada sí lista las tres.
- **Sin fechas ni años** (cambian en cada convocatoria). El costo del EGEL ($1,750.00) va **solo en pantalla**, no en la voz.
- **Pronunciación en la voz** (mapa `SPEECH` en `fuentes/comun/voz/render.py`): UAT → "Guat"; EGEL → "Ejel";
  `cenevalfit@uat.edu.mx` → "ceneval fit, arroba, guat, punto edu, punto eme equis"; la CCT `28MSU0010B` se deletrea.
- **Voz:** Kokoro, voz `ef_dora`, español latino (`es-419`), natural y con entusiasmo. Servicio Social y EGEL ya la usan;
  el EXANI-II todavía usa Piper (pendiente cambiarlo para que las tres suenen igual).
- **Videos sin descarga:** `<video controls controlsList="nodownload noplaybackrate" disablepictureinpicture oncontextmenu="return false;">`.
  No poner enlaces directos al MP4.
- **Privacidad (repositorio público):** toda captura o documento se difumina antes de usarlo: nombres, CURP, matrícula, folios,
  referencias, códigos de barras, CLABE, convenios, fechas, firmas y datos de tickets. Revise con zoom que no quede nada legible.
  **Los documentos originales nunca se suben** (ver `.gitignore`); trabaje con ellos solo en `.trabajo/` o fuera del repositorio.
- **Identidad:** Montserrat; rojo `#ED1C24`, gris `#3A3A3A`, gris medio `#58585B`, gris claro `#E6E6E8`, rosa `#FCE9EA`.
  Páginas solo en modo claro. Encabezado con logos UAT + FIT, cortinilla de entrada y enlace "← Ver todas las guías".
- **Contacto:** EXANI-II y EGEL Plus: `cenevalfit@uat.edu.mx`, 833 218 4714 · 833 307 0112. Servicio Social: `pizaguirre@uat.edu.mx`.

### Datos fijos del EGEL Plus
- Ventanilla de Cobros del **Edificio Administrativo 2** (el edificio central). Se pide "su pase de examen".
- Paso 4: la ficha de pago con el comprobante **en la esquina superior izquierda**, escaneadas **en un solo PDF**.
- Programa/Carrera en el registro de CENEVAL, con el nombre exacto: `IC - INGENIERO CIVIL`, `ISC - INGENIERO EN SISTEMAS COMPUTACIONALES`,
  `IIS - INGENIERO INDUSTRIAL Y DE SISTEMAS`. Se muestran **cuando la voz dice elegir la carrera, antes de "Aceptar"**. No mencionar que hay nombres parecidos.
- La carta de terminación de estudios **no** es requisito: se envía posteriormente y por separado (nota en la escena del correo).
- Cierre: en pantalla "¡Mucho éxito en su Examen CENEVAL EGEL Plus!"; en la voz "¡Mucho éxito en su examen CENEVAL EGEL Plus!".

## Cómo hacer un cambio

1. **Solo texto de la página** (no del video):
   - EXANI-II y Servicio Social: edite `docs/<guía>/index.html` directamente.
   - EGEL Plus: la página se genera. Edite `fuentes/egel/page.html` (secciones) o `fuentes/egel/make_video_page.py` (encabezado/reproductor) y luego:
     `python3 fuentes/egel/make.py && python3 fuentes/egel/make_video_page.py`
2. **Algo que se ve o se oye en el video:** regenere el MP4 (abajo), revíselo y cópielo a `docs/<guía>/`.
   Después actualice la duración: en la página de la guía ("Duración m:ss"; en el EGEL es automática) y en `docs/index.html`.
3. **Revise antes de publicar:** cuadros clave del MP4 (`ffmpeg -ss <seg> -i video.mp4 -frames:v 1 cuadro.jpg`), la página en
   escritorio y en celular (390 px de ancho, sin desplazamiento horizontal) y que no haya "tú".
4. **Publique:** commit en `main` y push; GitHub Pages actualiza en 1–2 minutos. Si la sesión trabaja en una rama, abra un pull request
   para que Williams lo fusione.

## Regenerar videos

Primero, una vez por sesión: `bash fuentes/comun/instalar_modelos.sh` (dependencias de Python y modelos de voz en `modelos/`).

- **EGEL Plus** (≈ 9 min de render):
  ```sh
  python3 fuentes/egel/make.py                    # arma la animación en .trabajo/egel/index.html (narración en NARR)
  python3 fuentes/egel/shoot.py                   # opcional: capturas de cada escena en .trabajo/egel/shots/
  python3 fuentes/comun/voz/render.py egel        # voz + video → .trabajo/egel/EGEL_Plus_FIT.mp4
  cp .trabajo/egel/EGEL_Plus_FIT.mp4 docs/egel/
  python3 fuentes/egel/make_video_page.py         # página con la duración nueva
  ```
  Los elementos que aparecen justo cuando la voz dice una frase se definen en `overrides` de `render.py` (escena, selector, frase);
  si cambia esa frase en `NARR`, actualice también el override o el render se detiene con "frase no encontrada".
- **Servicio Social:** ver `fuentes/serviciosocial/README.md`.
- **EXANI-II:** ver `fuentes/exani/README.md`.

## Dominio

`docs/CNAME` contiene el dominio propio cuando ya está configurado. DNS en el registrador: `www` CNAME → `examenes-estandarizados.github.io`;
dominio raíz con registros A `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`.
El dominio está verificado en la organización de GitHub. "Enforce HTTPS" activado en Settings → Pages.

## Pendientes conocidos

- Cambiar la voz del EXANI-II a Kokoro `ef_dora` para que las tres guías suenen igual.
