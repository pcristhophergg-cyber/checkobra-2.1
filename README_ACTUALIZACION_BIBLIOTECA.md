# CheckObra 2.5.1 — Nombre del módulo: Biblioteca

Esta actualización cambia las referencias visibles de **Biblioteca del Saber** a **Biblioteca** en navegación, accesos rápidos, encabezados y documentación. No modifica esquemas SQL, tablas, permisos ni la lógica de consulta técnica de 2.5.

## Instalación segura
1. Crear una rama de prueba en GitHub antes de sustituir archivos.
2. Cargar el contenido del ZIP respetando las carpetas.
3. Conservar la configuración de Supabase (`public/config.js`) de tu despliegue.
4. Abrir el Preview de Vercel, comprobar Inicio > Biblioteca y las consultas del Manual CDT.
5. Validar en celular que el cambio de nombre se ve correctamente; si aparece la versión antigua, cerrar y reabrir la PWA o limpiar su caché.
6. Publicar en producción solo después de las pruebas.

**Sin migración SQL adicional.**

## Próxima etapa 2.6 (NO incluida en este paquete)
- Inicio diferenciado para Supervisor, Calidad y Jefatura.
- Checklists por partida y recinto.
- Observaciones de Calidad con fotografía original y fotografía marcada.
- Corrección, reinspección e historial de aprobación/objeción.
- Acceso a Oficina Técnica con control de revisión vigente.
- Biblioteca ampliada y conectada a los checklists, con referencias documentales.

La Biblioteca actual sigue siendo un buscador documental, no un asistente de IA generativa completo.
