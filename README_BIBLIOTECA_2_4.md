# CheckObra 2.4 — Biblioteca

## Qué hace
- Búsqueda de artículos técnicos validados y documentos de Oficina Técnica.
- Preguntas técnicas de cualquier usuario autenticado.
- Respuestas de Calidad, Oficina Técnica o Jefatura con fuente obligatoria.
- Publicación de procedimientos y criterios respaldados por un documento y versión.

## Importante
**No es aún un asistente de IA que responda automáticamente.** No interpreta PDFs ni inventa tolerancias; para incorporar respuestas automáticas con IA se necesitará un servicio backend seguro con recuperación de documentos, control de versiones, citas y revisión.

## Instalación
1. Respaldar la base de datos y ejecutar `MIGRACION_2_4_BIBLIOTECA.sql` en Supabase SQL Editor.
2. En la rama `prueba-checkobra-2-2` de GitHub, reemplazar solamente `public/app.js`, `public/styles.css` y `public/index.html`. Conservar `public/config.js`.
3. Abrir el nuevo Preview en Vercel. Probar como supervisor: enviar pregunta. Probar como Calidad/OT/Jefatura: responder con fuente y publicar un artículo. Probar búsqueda y apertura de documentos.
4. Si `reload()` muestra un error de permisos, no publicar a producción; revisar la política y el rol.

No es necesario repetir migraciones 2.2 o 2.3.

## Primer manual incorporado
- `public/biblioteca/CDT_Manual_Tolerancias_Edificaciones_3ed_2018.pdf` (69 páginas).
- Se presenta en Biblioteca como fuente externa de consulta con acceso directo al PDF.
- **No** se ha implementado lectura semántica del PDF ni respuestas automáticas. El buscador solo reconoce título y materias de la ficha.
- La ficha lo distingue de las EETT vigentes del proyecto. Verificar condiciones de reproducción/distribución y permisos antes de publicar fuera del entorno autorizado.
- Para actualizar esta versión en GitHub, subir también el nuevo PDF en `public/biblioteca/`.
