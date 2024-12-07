--PROGRAMAS ALMACENADOS PARA MANEJO DE CONTRATOS

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
    ELSIF NEW.clasificacion = 'CG' AND NEW.porc_total_prod < 0 THEN
        RAISE EXCEPTION 'El porcentaje total ofrecido para CG no puede ser negativo';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Funcion para validar que una productora no tenga más de un contrato activo si la clasificacion es CA, CB, CC, KA
--PROBADO Y ABPROBADO
CREATE OR REPLACE FUNCTION validar_unico_contrato()
RETURNS TRIGGER AS $$
DECLARE
    contratos_existentes INT;
BEGIN
    -- Cuenta contratos activos para el productor en las categorías especificadas
    SELECT COUNT(*)
    INTO contratos_existentes
    FROM contratos
    WHERE id_prod = NEW.id_prod
      AND clasificacion IN ('CA', 'CB', 'CC', 'KA')
      AND cancelado = 'NO'
      AND NEW.fecha_contrato BETWEEN fecha_contrato AND (fecha_contrato + INTERVAL '1 year'); -- los contratos son válidos por un año

    -- Si ya existe un contrato activo, lanza una excepción
    IF contratos_existentes > 0 THEN
        RAISE EXCEPTION 'El productor ya tiene un contrato activo de categoría CA, CB, CC o KA con una subastadora.';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

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

    -- Valida si la clasificación es 'KA' y el productor no es de Holanda
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
        RAISE EXCEPTION 'No se puede renovar el contrato; el contrato padre está cancelado.';
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
        RAISE EXCEPTION 'La fecha de renovación debe ser mayor a la fecha de creación del contrato padre';
    END IF;

    IF p_fecha_renovacion < (p_fecha_padre + INTERVAL '1 year') THEN
        RAISE EXCEPTION 'Debe haber pasado al menos un año desde la creación del contrato padre';
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

--Funcion auxiliar para  poder cancelar contratos 
--No se ejecuta automaticamente al no pagar las multas, solo se deja como opcion para el usuario
CREATE OR REPLACE FUNCTION cancelar_contrato(
    p_id_sub INT,
    p_id_prod INT,
    p_id_contrato INT
) RETURNS VOID AS $$
BEGIN
    -- Verifica si el contrato existe y no está ya cancelado
    IF EXISTS (
        SELECT 1 
        FROM contratos 
        WHERE id_sub = p_id_sub 
          AND id_prod = p_id_prod 
          AND id_contrato = p_id_contrato 
          AND cancelado = 'NO'
    ) THEN
        -- Actualiza el estado del contrato a 'SI' (cancelado)
        UPDATE contratos
        SET cancelado = 'SI'
        WHERE id_sub = p_id_sub 
          AND id_prod = p_id_prod 
          AND id_contrato = p_id_contrato;
          
        RAISE NOTICE 'Contrato % cancelado exitosamente.', p_id_contrato;
    ELSE
        RAISE EXCEPTION 'El contrato especificado no existe o ya está cancelado.';
    END IF;
END;
$$
 LANGUAGE plpgsql;

--PROGRAMAS ALMACENADOS PARA EL CONTROL DE PAGOS Y COMISIONES

--Funcion para validar que la fecha de pago de un contrato este entre la fecha de contrato y su validez de un anno
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
        RAISE EXCEPTION 'La fecha de pago debe estar entre % y %', fecha_contrato, fecha_contrato + INTERVAL '1 year';
    END IF;

    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

--Funcion para verificar que el monto de un pago de tipo MEM sea exactamente 500.00 euros
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION establecer_monto_mem()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'MEM' THEN
        NEW.monto_euros := 500.00;  
    END IF;

    RETURN NEW;  -- Retorna el nuevo registro modificado
END;
$$
 LANGUAGE plpgsql;

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

--Funcion para verificar que la multa es valida, corresponde a una comision atrasada
--PROBADO Y APROBADO
CREATE OR REPLACE FUNCTION validar_pago_mul()
RETURNS TRIGGER AS $$
DECLARE
    pago_com_existente INT;
BEGIN
    -- Verificar si existe un pago 'COM' atrasado para el mismo id_sub, id_prod, id_contrato
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





