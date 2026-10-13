# CheckObra 2.3 — Actualización de terreno y liberación A+B+C

1. Respalda la base de datos de Supabase.
2. Ejecuta `MIGRACION_2_3_TERRENO.sql` en SQL Editor. Es una transacción: crea `field_status` y `front_status`, carga correcciones confirmadas y hitos de cubierta. No modifica `excel_status`.
3. En la rama `prueba-checkobra-2-2` de GitHub reemplaza SOLO `public/app.js` y `public/styles.css`. Conserva `public/config.js`.
4. Abre la Preview en Vercel, inicia sesión, entra a Obra / Avance y prueba A/B/C. Prueba Fachada / Cubierta. No fusiones a main antes de verificar.

## Confirmaciones de terreno
- Shaft y vigones: piso 15; preparación superficie: piso 8; cocina base, interior clóset, piernas clóset: piso 7; cerámico terrazas: piso 12; cornisas: piso 11.
- Se registran todos los departamentos de pisos 2 hasta el piso indicado, inclusive, como ejecutados.
- Cubierta: tramo 1 cerchas ejecutadas; tramo 3 Igol Denso ejecutado; tramo 2 impermeabilización y cerámicos pendientes. No se infiere el estado de otras actividades.
- Fachada: se habilita el registro por orientación/zona y actividad; **no se importaron automáticamente los colores de las hojas complementarias**. Requieren validación adicional.

## Límites
- No se ha probado contra la cuenta real ni Supabase Storage.
- La edición A/B/C usa `field_status`, independiente del porcentaje cuantitativo de `progress` y de Calidad.
- La liberación por recinto se registra, pero no incrementa automáticamente la ejecución del departamento completo.
- El rol supervisor requiere estar vinculado a `trades.owner_id` para escribir; jefatura puede hacerlo siempre.
