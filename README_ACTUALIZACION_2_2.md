# CheckObra 2.2 — Actualización sobre el proyecto existente

## Recomendación
Esta versión es una **copia actualizada del código existente**, no una aplicación ni una base de datos nueva. Mantén la versión publicada como respaldo hasta probarla.

## Orden obligatorio
1. En Supabase > SQL Editor, ejecutar **MIGRACION_Y_CARGA_2_2.sql** completo con permisos de administrador. Es idempotente: no borra registros ni sobrescribe avances ya cargados.
2. Confirmar con: `select status,count(*) from public.excel_status group by status;` y `select count(*) from public.units;`.
3. Subir el contenido de `public/` y `vercel.json` al repositorio GitHub **existente** (preferiblemente primero en una rama de prueba), manteniendo la configuración actual de Vercel.
4. Abrir la aplicación, iniciar sesión, revisar Administración > Estado de catálogos, Obra / Avance, observaciones y asignación de responsables.
5. Oficina Técnica: iniciar sesión con un usuario **rol oficina_tecnica**, subir un PDF pequeño, comprobar su aparición en la tabla y pulsar Abrir. Sin credenciales de ese rol no es posible confirmar de extremo a extremo.

## Alcance y límites
- Importación de estados de **la hoja principal** `PROGRAMA GENERAL TERMINACIONES` de `PROGRAMA GENERAL(3).xlsx`. Verde=Ejecutado, amarillo=Con observaciones, celeste=En proceso. No se consideran como terminadas las celdas con fecha sin estado de color.
- Las otras hojas (fachada, cubierta, R1, etc.) **no se fusionan automáticamente** para evitar duplicaciones o confundir fechas programadas con ejecución.
- Se precargan responsables en `staff_directory` aunque no tengan cuenta. La asignación nominal funciona antes del inicio de sesión. Cuando se cree su cuenta, hay que vincularla a `profiles` para que pueda operar como propietario de tareas.
- El SQL agrega tablas y políticas; no modifica el esquema original de tareas, documentos o inspecciones.
- Los permisos de Supabase Storage siguen dependiendo de que exista el bucket privado `checkobra-files` y sus políticas. Revisar el esquema SQL de instalación si falla la carga.
- No se ha ejecutado contra el Supabase de producción; la validación en línea es un paso necesario.
