--DESDE 0. DESPUES DEL AVANCE.

--                                                                    MANEJO DE CONTRATOS. VALIDACIONNES DE CLASIFICACIONES Y PORCENTAJES.

CREATE OR REPLACE PROCEDURE crear_contrato(
    p_id_sub INT,
    p_id_prod INT,
    p_fecha_contrato DATE,
    p_clasificacion VARCHAR(2),
    p_porcentaje NUMERIC(5,2),
    p_cancelado VARCHAR(2)
)
AS $$
DECLARE
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN
    -- Recupera los nombres del productor y la subastadora
    SELECT p.nombre_prod, s.nombre_sub
    INTO v_nombre_prod, v_nombre_sub
    FROM productores p
    JOIN subastadoras s ON s.id_sub = p_id_sub
    WHERE p.id_prod = p_id_prod;

    -- Intenta insertar el nuevo contrato
    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado)
    VALUES (p_id_sub, p_id_prod, p_fecha_contrato, p_clasificacion, p_porcentaje, p_cancelado);

    RAISE NOTICE 'Se creó un nuevo contrato para el productor % en la subastadora %.', v_nombre_prod, v_nombre_sub;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'No se pudo crear el contrato. Puede que ya exista uno activo para el productor %.', v_nombre_prod;
END;
$$ LANGUAGE plpgsql;



--Funcion para validar que una productora no tenga más de un contrato activo si la clasificacion es CA, CB, CC, KA
--PROBADO Y ABPROBADO
CREATE OR REPLACE FUNCTION validar_contrato_activo()
RETURNS TRIGGER AS $$
DECLARE
    contrato_activo RECORD;
BEGIN
    -- Cuenta contratos activos para el productor en las categorías especificadas
SELECT id_prod, clasificacion, id_contrato
    INTO contrato_activo
    FROM contratos
        WHERE id_prod = NEW.id_prod
             AND clasificacion IN ('CA', 'CB', 'CC', 'KA')
             AND cancelado = 'NO'
             AND NEW.fecha_contrato BETWEEN fecha_contrato AND (fecha_contrato + INTERVAL '1 year')
LIMIT 1; 
IF FOUND THEN
        RAISE EXCEPTION 'El productor ya tiene un contrato activo de categoría %.', 
        contrato_activo.clasificacion;
END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Crear el trigger que llama a la funcion validar_contrato_activo al insertar o actualizar clasificacion de un contrato
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_contrato_activo
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_contrato_activo();



--Funcion para validar que si en un contrato la categoria esta clasificada como KA, que sea holandesa
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_clasificacion_KA()
RETURNS TRIGGER AS $$
DECLARE
    pais_holanda_id INT;
BEGIN
    SELECT id_pais INTO pais_holanda_id
    FROM paises
    WHERE nombre_pais = 'Holanda';
    IF NEW.clasificacion = 'KA' THEN
        IF NOT EXISTS (
            SELECT 1 
            FROM productores 
            WHERE id_prod = NEW.id_prod 
              AND id_pais = pais_holanda_id
        ) THEN
            RAISE EXCEPTION 'El productor debe ser de Holanda para clasificaciones KA.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;
--Crear el trigger que llama a la funcion validar_clasificacion_KA al insertar o actualizar clasificacion de un contrato KA para que sea un productor holandes
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_clasificacion_KA
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_clasificacion_KA();



--Funcion para validar el porcentaje total ofrecido en un contrato
--PROBADO Y APROBADO.
CREATE OR REPLACE FUNCTION validar_porcentaje_total()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.clasificacion = 'CA' AND NEW.porc_total_prod < 50.00 THEN
        RAISE EXCEPTION 'El porcentaje total ofrecido para CA debe ser mayor al 50%%';
    ELSIF NEW.clasificacion = 'CB' AND (NEW.porc_total_prod < 20.00 OR NEW.porc_total_prod > 49.00) THEN
        RAISE EXCEPTION 'El porcentaje total ofrecido para CB debe estar entre 20%% y 49%%';
    ELSIF NEW.clasificacion = 'CC' AND NEW.porc_total_prod >= 20.00 THEN
        RAISE EXCEPTION 'El porcentaje total ofrecido para CC debe ser menor al 20%%';
    ELSIF NEW.clasificacion = 'KA' AND NEW.porc_total_prod <> 100.00 THEN
        RAISE EXCEPTION 'El porcentaje total ofrecido para KA debe ser exactamente 100%%';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Crear el trigger que llama a la función validar antes de insertar o actualizar porcentaje de un contrato
--PROBADO Y APROBADO.
CREATE OR REPLACE TRIGGER trigger_validar_porcentaje_total
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_porcentaje_total();



--Funcion para validar que la suma de los porcentajes de contratos CG no exceda el 100%
CREATE OR REPLACE FUNCTION validar_porcentaje_total_CG()
RETURNS TRIGGER AS $$
DECLARE
    suma_porcentajes NUMERIC(5, 2);
BEGIN
    SELECT COALESCE(SUM(porc_total_prod), 0)
    INTO suma_porcentajes
    FROM contratos
    WHERE id_prod = NEW.id_prod
      AND clasificacion = 'CG'
      AND cancelado = 'NO';

    IF (suma_porcentajes + NEW.porc_total_prod) > 100.00 THEN
        RAISE EXCEPTION 'La suma de todos los contratos CG para el productor no puede exceder el 100%%. Suma actual: %, nuevo contrato: %', suma_porcentajes, NEW.porc_total_prod;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_validar_porcentaje_total_CG
BEFORE INSERT ON contratos
FOR EACH ROW
WHEN (NEW.clasificacion = 'CG')
EXECUTE FUNCTION validar_porcentaje_total_CG();

--                                                                        MANEJO DE CONTRATOS. Relacion recursiva de contratos. Renovaciones.

--Funciones para validar renovacion de un contrato
--Que el id_padre exista, y coicidan en el mismo id_sub y id_prod
--Ademas, que la fecha de renovacion sea mayor a la fecha de creacion del contrato padre
--Y que ya haya pasado un año desde la creacion del contrato padre

--Funcion para asegurarse de que el contrato padre exista y que sean el mismo id_sub y id_prod y devolverá su fecha de creación
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION verificar_contrato_padre(
    p_id_contrato_padre INT,
    p_id_sub INT,
    p_id_prod INT
)
RETURNS DATE AS $$
DECLARE
    fecha_padre DATE;
    estado_cancelado VARCHAR(2);
BEGIN
    SELECT fecha_contrato, cancelado INTO fecha_padre, estado_cancelado
    FROM contratos
    WHERE id_contrato = p_id_contrato_padre 
      AND id_sub = p_id_sub 
      AND id_prod = p_id_prod;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El contrato padre con id % no existe para el productor % en la subastadora %', 
            p_id_contrato_padre, p_id_prod, p_id_sub;
    END IF;

    IF estado_cancelado = 'SI' THEN
        RAISE EXCEPTION 'No se puede renovar el contrato; el contrato original está cancelado.';
    END IF;

    RETURN fecha_padre;
END;
$$ LANGUAGE plpgsql;

--Procedimiento para validar si la fecha de renovación es mayor que la del contrato padre y si ha pasado un año desde su creación
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_fecha_renovacion(
    p_fecha_renovacion DATE,
    p_fecha_padre DATE
)
RETURNS VOID AS $$
BEGIN
    IF p_fecha_renovacion <= p_fecha_padre THEN
        RAISE EXCEPTION 'La fecha de renovación debe ser mayor a la fecha de creación del contrato original';
    END IF;

    IF p_fecha_renovacion < (p_fecha_padre + INTERVAL '1 year') THEN
        RAISE EXCEPTION 'Debe haber pasado al menos un año desde la creación del contrato original a renovar';
    END IF;
END;
$$ LANGUAGE plpgsql;


--Funcion para validar la renovacion de un contrato
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_renovacion_contrato()
RETURNS TRIGGER AS $$
DECLARE
    fecha_padre DATE;
BEGIN
    -- Verifica la existencia del contrato padre y obtiene su fecha
    fecha_padre := verificar_contrato_padre(NEW.id_contrato_padre, NEW.id_sub, NEW.id_prod);
    -- Valida la fecha de renovación
    PERFORM validar_fecha_renovacion(NEW.fecha_contrato, fecha_padre);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Crear el trigger para validar renovaciones de contrato
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_renovacion
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW
WHEN (NEW.id_contrato_padre IS NOT NULL)  -- Solo aplicar si hay un contrato padre
EXECUTE FUNCTION validar_renovacion_contrato();





--Funcion para renovar un contrato
--SELECT renovar_contrato(1, 1, 1, 'CB', 75.00); -- Ejemplo de renovación del contrato con ID 1
--Para saber que contratos estan a punto de vencerse llamar a contratos_por_vencer(30); -- 30 dias antes de vencerse
CREATE OR REPLACE FUNCTION renovar_contrato_nuevos_datos(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT,
    p_nueva_categoria VARCHAR(2),
    p_nuevo_porcentaje NUMERIC(5,2)
) RETURNS VOID AS $$
DECLARE
    v_fecha_contrato DATE;
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN
    -- Validar que el contrato original existe y obtener los nombres
    SELECT 
        c.fecha_contrato, 
        p.nombre_prod, 
        s.nombre_sub
    INTO 
        v_fecha_contrato, v_nombre_prod, v_nombre_sub
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        c.id_sub = p_id_sub 
        AND c.id_prod = p_id_prod 
        AND c.id_contrato = p_id_contrato;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Contrato no encontrado con ID %', p_id_contrato;
    END IF;

    -- Insertar un nuevo contrato con la nueva categoría y porcentaje
    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre)
    VALUES (p_id_sub, p_id_prod, CURRENT_DATE, p_nueva_categoria, p_nuevo_porcentaje, 'NO', p_id_contrato);

    RAISE NOTICE 'Contrato renovado exitosamente para el productor % (ID: %) en la subastadora % (ID: %) con la nueva categoría %.', 
                 v_nombre_prod, p_id_prod, v_nombre_sub, p_id_sub, p_nueva_categoria;

END;
$$ LANGUAGE plpgsql;



--Procedure para renovar contrato manteniendo los datos originales
--SELECT renovar_contrato_manteniendo_datos(1, 1, 1); -- Ejemplo de renovación del contrato con ID 1
CREATE OR REPLACE PROCEDURE renovar_contrato_manteniendo_datos(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT
) AS $$
DECLARE
    v_fecha_contrato DATE;
    v_clasificacion VARCHAR(2);
    v_porcentaje NUMERIC(5,2);
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN
    -- Validar que el contrato original existe y obtener sus datos
    SELECT 
        c.fecha_contrato, 
        c.clasificacion, 
        c.porc_total_prod, 
        p.nombre_prod, 
        s.nombre_sub
    INTO 
        v_fecha_contrato, 
        v_clasificacion, 
        v_porcentaje,
        v_nombre_prod,
        v_nombre_sub
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        c.id_sub = p_id_sub 
        AND c.id_prod = p_id_prod 
        AND c.id_contrato = p_id_contrato;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Contrato no encontrado con ID %', p_id_contrato;
    END IF;

    -- Insertar un nuevo contrato manteniendo los mismos datos
    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre)
    VALUES (p_id_sub, p_id_prod, CURRENT_DATE, v_clasificacion, v_porcentaje, 'NO', p_id_contrato);
    
    RAISE NOTICE 'Contrato renovado exitosamente para el productor % (ID: %) en la subastadora % (ID: %) con la clasificacion % para la fecha %', 
                 v_nombre_prod, p_id_prod, v_nombre_sub, p_id_sub, v_clasificacion;

END;
$$ LANGUAGE plpgsql;

--                                                                                           MANEJO DE CONTRATOS. Auxiliares

--Funcion auxiliar para  poder cancelar contratos 
CREATE OR REPLACE FUNCTION cancelar_contrato(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT
) RETURNS VOID AS $$
DECLARE
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN
    -- Obtener los nombres del productor y subastador
    SELECT p.nombre_prod, s.nombre_sub
    INTO v_nombre_prod, v_nombre_sub
    FROM contratos c
    JOIN productores p ON c.id_prod = p.id_prod
    JOIN subastadoras s ON c.id_sub = s.id_sub
    WHERE c.id_sub = p_id_sub 
      AND c.id_prod = p_id_prod 
      AND c.id_contrato = p_id_contrato;

    -- Verifica si el contrato existe y no está ya cancelado
    IF FOUND THEN
        -- Actualiza el estado del contrato a 'SI' (cancelado)
        UPDATE contratos
        SET cancelado = 'SI'
        WHERE id_sub = p_id_sub 
          AND id_prod = p_id_prod 
          AND id_contrato = p_id_contrato;
          
        RAISE NOTICE 'Contrato % cancelado exitosamente para el productor % y la subastadora %.', 
                     p_id_contrato, v_nombre_prod, v_nombre_sub;
    ELSE
        RAISE EXCEPTION 'El contrato especificado no existe o ya está cancelado para el productor % y la subastadora %.', 
                        v_nombre_prod, v_nombre_sub;
    END IF;
END;
$$ LANGUAGE plpgsql;

--Funcion auxiliar para obtener una tabla con los contratos activos actualmente
--Llamar con SELECT * FROM obtener_contratos_activos();
CREATE OR REPLACE FUNCTION obtener_contratos_activos()
RETURNS TABLE (
    contrato_id_sub INT,
    contrato_id_prod INT,
    contrato_id_contrato INT,
    contrato_fecha_contrato DATE,
    contrato_clasificacion VARCHAR(2),
    contrato_porc_total_prod NUMERIC(5, 2),
    productor_nombre VARCHAR(100),
    subastador_nombre VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_sub, 
        c.id_prod, 
        c.id_contrato, 
        c.fecha_contrato, 
        c.clasificacion, 
        c.porc_total_prod, 
        p.nombre_prod,
        s.nombre_sub  
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        c.cancelado = 'NO'
      AND 
        c.fecha_contrato <= CURRENT_DATE
      AND 
        c.fecha_contrato + INTERVAL '1 year' >= CURRENT_DATE;  
END;
$$ LANGUAGE plpgsql;


--Funcion para obtener una tabla con los contratos vencidos
CREATE OR REPLACE FUNCTION obtener_contratos_vencidos()
RETURNS TABLE (
    contrato_id_sub INT,
    contrato_id_prod INT,
    contrato_id_contrato INT,
    contrato_fecha_contrato DATE,
    contrato_clasificacion VARCHAR(2),
    contrato_porc_total_prod NUMERIC(5, 2),
    productor_nombre VARCHAR(100),
    subastador_nombre VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_sub, 
        c.id_prod, 
        c.id_contrato, 
        c.fecha_contrato, 
        c.clasificacion, 
        c.porc_total_prod, 
        p.nombre_prod,
        s.nombre_sub 
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        c.cancelado = 'NO'
      AND 
        c.fecha_contrato + INTERVAL '1 year' < CURRENT_DATE;  
END;
$$ LANGUAGE plpgsql;




--Funcion Auxiliar para obtener los contratos que estan por vencer en un numero de dias especificado
--SELECT * FROM contratos_por_vencer(30);
CREATE OR REPLACE FUNCTION contratos_por_vencer(dias_aviso INT)
RETURNS TABLE (
    id_contrato INT,
    id_sub INT,
    id_prod INT,
    nombre_productor VARCHAR,
    nombre_subastadora VARCHAR,
    fecha_contrato DATE,
    fecha_vencimiento DATE,
    dias_restantes INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_contrato,
        c.id_sub,
        c.id_prod,
        p.nombre_prod AS nombre_productor,       
        s.nombre_sub AS nombre_subastadora,    
        c.fecha_contrato,
        (c.fecha_contrato + INTERVAL '1 year')::DATE AS fecha_vencimiento,
        ((c.fecha_contrato + INTERVAL '1 year')::DATE - CURRENT_DATE) AS dias_restantes
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        (c.fecha_contrato + INTERVAL '1 year')::DATE BETWEEN CURRENT_DATE AND CURRENT_DATE + dias_aviso;
END;
$$ LANGUAGE plpgsql;




--                                                                                              CONTROL DE PAGOS Y COMISIONES.

--Al crearse un contrato, se crea su pago de membresia automaticamente
CREATE OR REPLACE FUNCTION crear_pago_mem()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, monto_euros, tipo)
    VALUES (NEW.id_sub, NEW.id_prod, NEW.id_contrato, NEW.fecha_contrato, 500.00, 'MEM');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_pago_membresia_contrato
AFTER INSERT ON contratos
FOR EACH ROW
EXECUTE FUNCTION crear_pago_mem();


--Funcion para validar que la fecha de pago de un contrato este entre la fecha de contrato y su validez de un año
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_fecha_pago()
RETURNS TRIGGER AS $$
DECLARE
    fecha_contrato DATE;
BEGIN
    SELECT c.fecha_contrato INTO fecha_contrato
    FROM contratos c
    WHERE c.id_contrato = NEW.id_contrato; 

    IF NEW.fecha_pago < fecha_contrato OR NEW.fecha_pago > fecha_contrato + INTERVAL '1 year' THEN
        RAISE EXCEPTION 'La fecha de pago debe estar entre % y % para dicho contrato', fecha_contrato, fecha_contrato + INTERVAL '1 year';
    END IF;

    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;
--Trigger para validar que la fecha de pago concuerde con un contrato
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_fecha_pago
BEFORE INSERT ON pagos_multas
FOR EACH ROW EXECUTE FUNCTION validar_fecha_pago();



--Funcion para calcular el total de ventas mensuales de un productor. OJO: Agarra el mes anterior a la fecha de pago introducida
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION calcular_ventas_mensuales(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT,
    p_fecha_pago DATE
) RETURNS FLOAT AS $$
DECLARE
    v_total_ventas FLOAT;
BEGIN
    SELECT SUM(l.precio_final)
    INTO v_total_ventas
    FROM lotes_flor l
    JOIN contratos c ON l.id_sub = c.id_sub 
                     AND l.id_prod = c.id_prod 
                     AND l.id_contrato = c.id_contrato
    JOIN facturas_subastas f ON l.num_factura = f.num_factura
    WHERE c.id_sub = p_id_sub 
      AND c.id_prod = p_id_prod 
      AND c.id_contrato = p_id_contrato
      AND DATE_TRUNC('month', f.fecha_emision) = DATE_TRUNC('month', p_fecha_pago) - INTERVAL '1 month'
      AND EXTRACT(YEAR FROM f.fecha_emision) = EXTRACT(YEAR FROM p_fecha_pago);

    RETURN COALESCE(v_total_ventas, 0); -- Retorna 0 si no hay ventas
END;
$$ LANGUAGE plpgsql;



--Funcion para calcular el monto de la comision
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION calcular_comision(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT,
    p_fecha_pago DATE
) RETURNS FLOAT AS $$
DECLARE
    v_total_ventas FLOAT;
    v_comision_rate FLOAT;
    v_monto_euros FLOAT;
    v_clasificacion VARCHAR(2);
BEGIN
    -- Obtiene las ventas mensuales
    v_total_ventas := calcular_ventas_mensuales(p_id_sub, p_id_prod, p_id_contrato, p_fecha_pago);
    -- Obtiene la clasificación del productor
    SELECT c.clasificacion
    INTO v_clasificacion
    FROM contratos c
    WHERE c.id_sub = p_id_sub AND c.id_prod = p_id_prod AND c.id_contrato = p_id_contrato;

    -- Indica porcentaje comision según la clasificación
    IF v_clasificacion = 'CA' THEN
        v_comision_rate := 0.005;
    ELSIF v_clasificacion = 'CB' THEN
        v_comision_rate := 0.01;
    ELSIF v_clasificacion = 'CC' THEN
        v_comision_rate := 0.02;
    ELSIF v_clasificacion = 'CG' THEN
        v_comision_rate := 0.05;
    ELSIF v_clasificacion = 'KA' THEN
        v_comision_rate := 0.0025;
    ELSE
        RAISE EXCEPTION 'Clasificación no válida';
    END IF;

    -- Calcula el monto de la comisión
    v_monto_euros := v_total_ventas * v_comision_rate;

    RETURN v_monto_euros;
END;
$$ LANGUAGE plpgsql;
--Funcion trigger para que devuelva los registros modificados
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION trg_calcular_comision()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'COM' THEN
        NEW.monto_euros := calcular_comision(NEW.id_sub, NEW.id_prod, NEW.id_contrato, NEW.fecha_pago);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Crear el trigger que llama a la funcion trg_calcular_comision() al insertar un pago del tipo COM, calula el monto de la comision al insertar el pago
--Monto tiene ser calculado a partir de unos porcentajes y las ventas mensuales de la productora
--PROBADO Y APROBADO
CREATE TRIGGER trigger_calcular_comision
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'COM')
EXECUTE FUNCTION trg_calcular_comision();




--Funcion para verificar que la multa es valida, corresponde a una comision atrasada
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_pago_mul()
RETURNS TRIGGER AS $$
DECLARE
    pago_com_existente INT;
BEGIN
    SELECT COUNT(*)
    INTO pago_com_existente
    FROM pagos_multas
    WHERE id_sub = NEW.id_sub
      AND id_prod = NEW.id_prod
      AND id_contrato = NEW.id_contrato
      AND tipo = 'COM'
      AND fecha_pago > (date_trunc('month', fecha_pago) + interval '5 days');

    IF pago_com_existente = 0 THEN
        RAISE EXCEPTION 'No se puede registrar una multa (tipo "MUL") sin un pago de comisión atrasado correspondiente.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Triggers para validar que MUL corresponde a una comision atrasada, insert manual
--PROBADO Y APROBADO
CREATE TRIGGER trigger_validar_pago_mul
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'MUL') 
EXECUTE FUNCTION validar_pago_mul();





--Funcion para calcular el monto de la multa
CREATE OR REPLACE FUNCTION calcular_multa(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT,
    p_fecha_pago DATE
) RETURNS FLOAT AS $$
DECLARE
    v_total_ventas FLOAT;
    v_monto_euros FLOAT;
BEGIN
    v_total_ventas := calcular_ventas_mensuales(p_id_sub, p_id_prod, p_id_contrato, p_fecha_pago);
    v_monto_euros := v_total_ventas * 0.20;

    RETURN v_monto_euros;
END;
$$ LANGUAGE plpgsql;
--Funcion para ejecutar el trigger de calcular multa
CREATE OR REPLACE FUNCTION trg_calcular_multa()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'MUL' THEN
        NEW.monto_euros := calcular_multa(NEW.id_sub, NEW.id_prod, NEW.id_contrato, NEW.fecha_pago);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Trigger para calcular monto una vez se inserta un pago de tipo MUL
CREATE TRIGGER trigger_calcular_multa
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'MUL') 
EXECUTE FUNCTION trg_calcular_multa();






-- calcule las comisiones y determine si hay multas pendientes
CREATE OR REPLACE FUNCTION calcular_comision_pendiente(
    p_id_sub INT,
    p_id_prod INT,
    p_fecha DATE
) RETURNS TABLE(comision FLOAT, multa FLOAT) AS $$
DECLARE
    v_ventas_mensuales FLOAT;
    v_comision FLOAT := 0;
    v_multa FLOAT := 0;
    v_fecha_inicio DATE := DATE_TRUNC('month', p_fecha);
    v_fecha_limite DATE := v_fecha_inicio + INTERVAL '5 days';
BEGIN
    -- Obtener las ventas del mes anterior
    v_ventas_mensuales := calcular_ventas_mensuales(p_id_sub, p_id_prod, NULL, p_fecha);

    -- Calcular la comisión si hay ventas
    IF v_ventas_mensuales > 0 THEN
        v_comision := calcular_comision(p_id_prod, v_ventas_mensuales, 
                                         (SELECT clasificacion FROM contratos WHERE id_sub = p_id_sub AND id_prod = p_id_prod LIMIT 1));
    END IF;

    -- Verificar si la fecha actual está más allá del límite de pago
    IF CURRENT_DATE > v_fecha_limite AND v_comision > 0 THEN
        v_multa := v_comision * 0.20;  -- Por ejemplo, 20% de la comisión
    END IF;

    RETURN QUERY SELECT v_comision, v_multa;
END;
$$ LANGUAGE plpgsql;


--CALL revisar_estado_productor(1, 1, CURRENT_DATE);  -- Revisa el estado del productor 1 en la subastadora 1
CREATE OR REPLACE PROCEDURE revisar_estado_productor(
    p_id_sub INT,
    p_id_prod INT,
    p_fecha DATE
) AS $$
DECLARE
    v_comision_pendiente FLOAT;
    v_multa_pendiente FLOAT;
    v_monto_pagado_comisiones FLOAT := 0;
    v_monto_pagado_multas FLOAT := 0;
BEGIN
    -- Calcular la comisión y la multa pendiente
    SELECT * INTO v_comision_pendiente, v_multa_pendiente
    FROM calcular_comision_pendiente(p_id_sub, p_id_prod, p_fecha);

    -- Obtener el monto total pagado en comisiones
    SELECT COALESCE(SUM(monto_euros), 0) INTO v_monto_pagado_comisiones
    FROM pagos_multas
    WHERE id_sub = p_id_sub AND id_prod = p_id_prod AND tipo = 'COM';

    -- Obtener el monto total pagado en multas
    SELECT COALESCE(SUM(monto_euros), 0) INTO v_monto_pagado_multas
    FROM pagos_multas
    WHERE id_sub = p_id_sub AND id_prod = p_id_prod AND tipo = 'MUL';

    -- Calcular la deuda total
    v_comision_pendiente := v_comision_pendiente - v_monto_pagado_comisiones;
    v_multa_pendiente := v_multa_pendiente - v_monto_pagado_multas;

    RAISE NOTICE 'Estado del productor %: Comisión pendiente: %, Multa pendiente: %', 
                 p_id_prod, v_comision_pendiente, v_multa_pendiente;

    -- Estado de solvente
    IF v_comision_pendiente > 0 OR v_multa_pendiente > 0 THEN
        RAISE NOTICE 'El productor % no está solvente.', p_id_prod;
    ELSE
        RAISE NOTICE 'El productor % está solvente.', p_id_prod;
    END IF;

END;
$$ LANGUAGE plpgsql;


--                                                                                                         OTROS

--procedure para verificar que el registro de un lote es valido
CREATE OR REPLACE PROCEDURE registrar_lote(
    p_cantidad NUMERIC(3),
    p_precio_inicial NUMERIC(6,2),
    p_BI NUMERIC(3,2),
    p_precio_final FLOAT,
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT,
    p_vbn INT,
    p_num_factura NUMERIC(12)
) AS $$
DECLARE
    v_contrato_activo BOOLEAN;
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN

    SELECT p.nombre_prod, s.nombre_sub
    INTO v_nombre_prod, v_nombre_sub
    FROM productores p
    JOIN subastadoras s ON s.id_sub = p_id_sub
    WHERE p.id_prod = p_id_prod;

    -- Verifica que existe un contrato activo
    SELECT EXISTS (
        SELECT 1
        FROM contratos
        WHERE id_sub = p_id_sub
          AND id_prod = p_id_prod
          AND id_contrato = p_id_contrato
          AND cancelado = 'NO' 
          AND CURRENT_DATE BETWEEN fecha_contrato AND fecha_contrato + INTERVAL '1 year'
    ) INTO v_contrato_activo;

    IF NOT v_contrato_activo THEN
        RAISE EXCEPTION 'No se puede registrar el lote. No hay un contrato activo entre el productor % (% ID) y la subastadora % (% ID).', 
                        v_nombre_prod, p_id_prod, v_nombre_sub, p_id_sub;
    END IF;

    -- Insertar el nuevo lote
    INSERT INTO lotes_flor (cantidad, precio_inicial, BI, precio_final, id_sub, id_prod, id_contrato, vbn, num_factura)
    VALUES (p_cantidad, p_precio_inicial, p_BI, p_precio_final, p_id_sub, p_id_prod, p_id_contrato, p_vbn, p_num_factura);

    RAISE NOTICE 'Lote registrado exitosamente para el productor % (% ID) en la subastadora % (% ID).', 
                 v_nombre_prod, p_id_prod, v_nombre_sub, p_id_sub;
END;
$$ LANGUAGE plpgsql;








