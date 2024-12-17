DROP TABLE IF EXISTS det_facturas_floristerias CASCADE;
DROP TABLE IF EXISTS facturas_floristerias CASCADE;
DROP TABLE IF EXISTS clientes_compania_floristerias CASCADE;
DROP TABLE IF EXISTS clientes_natural_floristerias CASCADE;
DROP TABLE IF EXISTS bouquets CASCADE;
DROP TABLE IF EXISTS historicos_precio CASCADE;
DROP TABLE IF EXISTS catalogos_floristerias CASCADE;
DROP TABLE IF EXISTS lotes_flor CASCADE;
DROP TABLE IF EXISTS facturas_subastas CASCADE;
DROP TABLE IF EXISTS det_contratos CASCADE;
DROP TABLE IF EXISTS catalogos_productores CASCADE;
DROP TABLE IF EXISTS enlaces CASCADE;
DROP TABLE IF EXISTS contactos_empleados CASCADE;
DROP TABLE IF EXISTS afiliacion CASCADE;
DROP TABLE IF EXISTS pagos_multas CASCADE;
DROP TABLE IF EXISTS contratos CASCADE;
DROP TABLE IF EXISTS floristerias CASCADE;
DROP TABLE IF EXISTS productores CASCADE;
DROP TABLE IF EXISTS subastadoras CASCADE;
DROP TABLE IF EXISTS significados CASCADE;
DROP TABLE IF EXISTS colores CASCADE;
DROP TABLE IF EXISTS flores_corte CASCADE;
DROP TABLE IF EXISTS paises CASCADE;


DROP TYPE IF EXISTS lote_flor;
DROP TYPE IF EXISTS flor;


DROP FUNCTION IF EXISTS crear_factura(VARCHAR, VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS crear_lote_factura(VARCHAR, VARCHAR, VARCHAR, INT, FLOAT, FLOAT, FLOAT, NUMERIC);
DROP FUNCTION IF EXISTS generar_factura_subasta(VARCHAR, VARCHAR, VARCHAR, lote_flor[]);
DROP FUNCTION IF EXISTS recomendar_flores(VARCHAR, VARCHAR[], VARCHAR[]);
DROP FUNCTION IF EXISTS estatus_productor_multas(VARCHAR, VARCHAR, DATE);
DROP FUNCTION IF EXISTS estatus_general_productor(VARCHAR, VARCHAR, DATE);
DROP PROCEDURE IF EXISTS consultar_ventas_mensuales(VARCHAR, VARCHAR, INT, INT);
DROP FUNCTION IF EXISTS analizar_ventas_mensuales(INT, DATE);
DROP FUNCTION IF EXISTS estatus_productor_comisiones(VARCHAR, VARCHAR, DATE);
DROP PROCEDURE IF EXISTS registrar_comision(VARCHAR, VARCHAR, DATE);
DROP FUNCTION IF EXISTS calcular_multa(INT, INT, INT, DATE);
DROP FUNCTION IF EXISTS trg_calcular_multa();
DROP TRIGGER IF EXISTS trigger_calcular_multa ON pagos_multas;
DROP FUNCTION IF EXISTS trg_validar_lote_no_comprado();
DROP TRIGGER IF EXISTS trigger_validar_lote_no_comprado ON lotes_flor;
DROP PROCEDURE IF EXISTS registrar_multa(VARCHAR, VARCHAR, DATE);
DROP FUNCTION IF EXISTS calcular_comision(INT, INT, INT, DATE);
DROP FUNCTION IF EXISTS trg_calcular_comision();
DROP TRIGGER IF EXISTS trigger_calcular_comision ON pagos_multas;
DROP FUNCTION IF EXISTS validar_fechas_historicos_precio();
DROP TRIGGER IF EXISTS check_fecha_historicos_precio ON historicos_precio;
DROP FUNCTION IF EXISTS validar_fecha_factura_no_futura();
DROP TRIGGER IF EXISTS check_fecha_factura_no_futura ON facturas_subastas;
DROP FUNCTION IF EXISTS validar_fecha_pago();
DROP TRIGGER IF EXISTS trigger_validar_fecha_pago ON pagos_multas;
DROP FUNCTION IF EXISTS crear_pago_mem();
DROP TRIGGER IF EXISTS trigger_pago_membresia_contrato ON contratos;
DROP FUNCTION IF EXISTS calcular_ventas_mensuales(INT, INT, INT, DATE);
DROP FUNCTION IF EXISTS obtener_contratos_activos();
DROP FUNCTION IF EXISTS obtener_contratos_vencidos();
DROP FUNCTION IF EXISTS contratos_por_vencer(INT);
DROP PROCEDURE IF EXISTS renovar_contrato_nuevos_datos(VARCHAR, VARCHAR, VARCHAR, NUMERIC);
DROP PROCEDURE IF EXISTS renovar_contrato_manteniendo_datos(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS cancelar_contrato(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS verificar_contrato_padre(INT, INT, INT);
DROP FUNCTION IF EXISTS validar_fecha_renovacion(DATE, DATE);
DROP FUNCTION IF EXISTS validar_renovacion_contrato();
DROP PROCEDURE IF EXISTS crear_contrato(VARCHAR, VARCHAR, DATE, VARCHAR, NUMERIC);
DROP TRIGGER IF EXISTS trigger_validar_renovacion ON contratos;
DROP FUNCTION IF EXISTS validar_porcentaje_total_CG();
DROP TRIGGER IF EXISTS trigger_validar_porcentaje_total_CG ON contratos;
DROP FUNCTION IF EXISTS validar_unico_contrato_CG();
DROP TRIGGER IF EXISTS trigger_validar_unico_contrato_CG ON contratos;
DROP FUNCTION IF EXISTS validar_contrato_CG();
DROP TRIGGER IF EXISTS trg_validar_contrato_CG ON contratos;
DROP FUNCTION IF EXISTS obtener_ids(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS validar_contrato_activo();
DROP TRIGGER IF EXISTS trigger_validar_contrato_activo ON contratos;
DROP FUNCTION IF EXISTS validar_clasificacion_KA();
DROP TRIGGER IF EXISTS trigger_validar_clasificacion_KA ON contratos;
DROP FUNCTION IF EXISTS validar_porcentaje_total();
DROP TRIGGER IF EXISTS trigger_validar_porcentaje_total ON contratos;

