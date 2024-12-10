
BEGIN;

-- 1. Eliminar detalles de facturas de floristerías
DELETE FROM det_facturas_floristerias WHERE id_floristeria = ? AND num_factura = ?;

-- 2. Eliminar facturas de floristerías
DELETE FROM facturas_floristerias WHERE id_floristeria = ? AND num_factura = ?;

-- 3. Eliminar bouquets
DELETE FROM bouquets WHERE id_floristeria = ? AND id_catalogo = ? AND id_bouquet = ?;

-- 4. Eliminar históricos de precios
DELETE FROM historicos_precio WHERE id_floristeria = ? AND id_catalogo = ?;

-- 5. Eliminar catálogos de floristerías
DELETE FROM catalogos_floristerias WHERE id_floristeria = ? AND id_catalogo = ?;

-- 6. Eliminar lotes de flores
DELETE FROM lotes_flor WHERE id_sub = ? AND id_prod = ? AND id_contrato = ? AND vbn = ?;

-- 7. Eliminar facturas de subastas
DELETE FROM facturas_subastas WHERE num_factura = ?;

-- 8. Eliminar detalles de contratos
DELETE FROM det_contratos WHERE id_sub = ? AND id_prod = ? AND id_contrato = ? AND vbn = ?;

-- 9. Eliminar catálogos de productores
DELETE FROM catalogos_productores WHERE id_productor = ? AND vbn = ?;

-- 10. Eliminar enlaces
DELETE FROM enlaces WHERE id_significado = ?;

-- 11. Eliminar contactos empleados
DELETE FROM contactos_empleados WHERE id_floristeria = ?;

-- 12. Eliminar afiliaciones
DELETE FROM afiliacion WHERE id_sub = ? AND id_floristeria = ?;

-- 13. Eliminar pagos y multas
DELETE FROM pagos_multas WHERE id_sub = ? AND id_prod = ? AND id_contrato = ?;

-- 14. Eliminar contratos
DELETE FROM contratos WHERE id_sub = ? AND id_prod = ?;

-- 15. Eliminar floristerías
DELETE FROM floristerias WHERE id_floristeria = ?;

-- 16. Eliminar productores
DELETE FROM productores WHERE id_prod = ?;

-- 17. Eliminar subastadoras
DELETE FROM subastadoras WHERE id_sub = ?;

-- Opcional: eliminar colores (asegúrate que no haya referencias en otras tablas)
DELETE FROM colores WHERE codigo_color = '?';

-- Opcional: eliminar significados (asegúrate que no haya referencias en otras tablas)
DELETE FROM significados WHERE id_significado = '?';

-- Opcional: eliminar flores de corte (asegúrate que no haya referencias en otras tablas)
DELETE FROM flores_corte WHERE id_flor_corte = '?';

-- Opcional: eliminar países (asegúrate que no haya referencias en otras tablas)
DELETE FROM paises WHERE id_pais = '?';

COMMIT;