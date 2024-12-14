--TRIGGERS PARA MANEJO DE CONTRATOS.

-- Crear el trigger que llama a la función validar antes de insertar o actualizar porcentaje de un contrato
--PROBADO Y APROBADO.
CREATE OR REPLACE TRIGGER trg_validar_porcentaje
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_porcentaje_total();

--Crear el trigger que llama a la funcion validar_contrato_unico al insertar o actualizar clasificacion de un contrato
--PROBADO Y APROBADO
CREATE TRIGGER validar_contrato_unico
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_unico_contrato();

--Crear el trigger que llama a la funcion validar_clasificacion_KA al insertar o actualizar clasificacion de un contrato KA para que sea un productor holandes
--PROBADO Y APROBADO
CREATE TRIGGER validar_clasificacion_KA
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_clasificacion_KA();

--Crear el trigger para validar renovaciones de contrato
--PROBADO Y APROBADO
CREATE TRIGGER trg_validar_renovacion
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW
WHEN (NEW.id_contrato_padre IS NOT NULL)  -- Solo aplicar si hay un contrato padre
EXECUTE FUNCTION validar_renovacion_contrato();


--TRIGGERS PARA CONTROL DE PAGOS Y COMISIONES.

--Trigger para validar que la fecha de pago concuerde con un contrato
--PROBADO Y APROBADO
CREATE TRIGGER validar_fecha_pago_trigger
BEFORE INSERT ON pagos_multas
FOR EACH ROW EXECUTE FUNCTION validar_fecha_pago();


--Crear el trigger que llama a la funcion verificar_monto_mem al insertar o actualizar un pago del tipo MEM, monto tiene que ser igual a 500.00
--PROBADO Y APROBADO
CREATE TRIGGER trg_establecer_monto_membresia
BEFORE INSERT OR UPDATE ON pagos_multas
FOR EACH ROW EXECUTE FUNCTION establecer_monto_mem();

--Crear el trigger que llama a la funcion trg_calcular_comision() al insertar un pago del tipo COM, calula el monto de la comision al insertar el pago
--Monto tiene ser calculado a partir de unos porcentajes y las ventas mensuales de la productora
--PROBADO Y APROBADO
CREATE TRIGGER trg_calcular_comision
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'COM')
EXECUTE FUNCTION trg_calcular_comision();

--Triggers para validar que MUL corresponde a una comision atrasada, insert manual
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_pago_mul
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'MUL') 
EXECUTE FUNCTION validar_pago_mul();

--Trigger para calcular monto una vez se inserta un pago de tipo MUL
CREATE TRIGGER trigger_calcular_multa
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'MUL') 
EXECUTE FUNCTION trg_calcular_multa();

--Trigger para validar que una factura de una subasta sea en un dia laborar y este entre las 8:00 y las 16:00
CREATE TRIGGER check_fecha_factura
BEFORE INSERT OR UPDATE ON facturas_subastas
FOR EACH ROW EXECUTE FUNCTION validar_fecha_factura();

--Trigger para validar que una fecha final sea mayor que una fecha inicial en el historico de precios 
CREATE TRIGGER check_fecha_historicos_precio
BEFORE INSERT OR UPDATE ON historicos_precio
FOR EACH ROW EXECUTE FUNCTION validar_fechas_historicos_precio();

