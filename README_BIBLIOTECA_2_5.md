# CheckObra 2.5 — Biblioteca por partida

## Qué funciona
- Buscador por pregunta en lenguaje cotidiano, accesible desde Biblioteca.
- Índice local de texto extraído del PDF CDT de 69 páginas, consultable sin clave de IA.
- Para **cerámicos**, respuesta estructurada y revisada contra capítulo 10: tolerancias, métodos de verificación, defectos y enlaces directos a páginas 30–31 del PDF.
- Para las demás partidas, búsqueda de pasajes y acceso directo a páginas: **son extractos documentales, no respuestas generadas por IA ni valores validados individualmente**.
- Mantiene las preguntas para revisión por Calidad/Oficina Técnica y los artículos publicados en 2.4.

## Limitaciones honestas
- No integra aún un modelo de IA generativa. La búsqueda es local y por coincidencia de términos; no interpreta con precisión todas las tablas, imágenes ni excepciones.
- Las tolerancias CDT son referenciales, no sustituyen EETT del proyecto, reglamentación vigente ni validación técnica.
- No hay actualización automática del manual ni de normas.
- Revisar permisos de redistribución del PDF antes de desplegarlo públicamente.

## Instalación (sobre versión 2.4 con migración ejecutada)
1. Respaldar. Crear rama de prueba en GitHub.
2. Copiar `public/app.js`, `public/index.html`, y **todo** `public/biblioteca/` del ZIP; mantener `public/config.js` actual.
3. No ejecutar nueva migración SQL: usa las tablas de 2.4.
4. Esperar Vercel Preview y probar consultas: `tolerancias de cerámicos`, `cómo revisar cerámicos`, `tabiques`, `ventanas`.
5. Comprobar que cada enlace abre la página correcta del manual y que las preguntas manuales se siguen registrando.
6. Si la PWA mantiene versión anterior, actualizar el service worker/caché y volver a cargar.

## Evolución a IA real
Para responder libremente con IA de todas las partidas se requiere backend autenticado, recuperación semántica por páginas, citas, control de fuentes y pruebas de exactitud; **no se incluye en este ZIP**.
