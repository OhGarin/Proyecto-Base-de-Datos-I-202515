--SECUENCIAS INICIO
DROP SEQUENCE IF EXISTS seq_paises;
CREATE SEQUENCE seq_paises START WITH 1 INCREMENT BY 1;
	
DROP SEQUENCE IF EXISTS seq_flores_corte;
CREATE SEQUENCE seq_flores_corte START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_significados;
CREATE SEQUENCE seq_significados START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_subastadoras;
CREATE SEQUENCE seq_subastadoras START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_productores;
CREATE SEQUENCE seq_productores START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_floristerias;
CREATE SEQUENCE seq_floristerias START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_contactos_emp;
CREATE SEQUENCE seq_contactos_emp START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_enlace;
CREATE SEQUENCE seq_enlace START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_catalogoprod;
CREATE SEQUENCE seq_catalogoprod START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_contratos;
CREATE SEQUENCE seq_contratos START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_lotes;
CREATE SEQUENCE seq_lotes START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_pagos;
CREATE SEQUENCE seq_pagos START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_catalogofloristeria;
CREATE SEQUENCE seq_catalogofloristeria START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_bouquet;
CREATE SEQUENCE seq_bouquet START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_cliente_natural;
CREATE SEQUENCE seq_cliente_natural START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_cliente_compania;
CREATE SEQUENCE seq_cliente_compania START WITH 1 INCREMENT BY 1;

DROP SEQUENCE IF EXISTS seq_detfacturas_floristeria;
CREATE SEQUENCE seq_detfacturas_floristeria START WITH 1 INCREMENT BY 1;
--SECUENCIAS FIN

--TABLAS INICIO
CREATE TABLE paises(	
	 id_pais INT DEFAULT nextval('seq_paises') CONSTRAINT pk_pais PRIMARY KEY,
 	 nombre_pais VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE colores(
	codigo_color VARCHAR(6) CONSTRAINT pk_colores PRIMARY KEY,
	nombre VARCHAR(15) NOT NULL UNIQUE,
	descripcion VARCHAR(300) NOT NULL
);

CREATE TABLE flores_corte(
	id_flor_corte INT DEFAULT nextval('seq_flores_corte') CONSTRAINT pk_florcorte PRIMARY KEY,
	nombre_comun VARCHAR(40) NOT NULL UNIQUE,
	genero_especie VARCHAR(40) NOT NULL UNIQUE,
	etimologia VARCHAR(250) NOT NULL,
	tem_conservacion NUMERIC(4,2) NOT NULL,
	colores VARCHAR(250) NOT NULL
);

CREATE TABLE significados(
	id_significado SMALLINT DEFAULT nextval('seq_significados') CONSTRAINT pk_significados PRIMARY KEY,
	tipo VARCHAR(4) NOT NULL,
	descripcion VARCHAR(300) NOT NULL,
	CONSTRAINT check_tipo CHECK(tipo in('ocas','sent'))
);

CREATE TABLE subastadoras(
	id_sub INT DEFAULT nextval('seq_subastadoras') CONSTRAINT pk_subastadoras PRIMARY KEY,
	nombre_sub VARCHAR(40) NOT NULL,
	id_pais SMALLINT NOT NULL,
	url_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE productores(
	id_prod INT DEFAULT nextval('seq_productores') CONSTRAINT pk_productores PRIMARY KEY,
	nombre_prod VARCHAR(40) NOT NULL UNIQUE,
	pagweb_prod VARCHAR(40) NOT NULL UNIQUE,
	id_pais SMALLINT NOT NULL,
	url_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE floristerias(
	id_floristeria INT DEFAULT nextval('seq_floristerias') CONSTRAINT pk_floristerias PRIMARY KEY,
	nombre_floristeria VARCHAR(40) NOT NULL UNIQUE,
	pagweb_floristeria VARCHAR(40) NOT NULL UNIQUE,
	telefono_floristeria VARCHAR(15) NOT NULL UNIQUE,
	email_floristeria VARCHAR(40) NOT NULL UNIQUE,
	id_pais SMALLINT NOT NULL,
	url_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE contactos_empleados(
	id_floristeria INT NOT NULL,
	id_representante INT DEFAULT nextval('seq_contactos_emp') NOT NULL,
	primer_nombre_rep VARCHAR(15) NOT NULL,
	primer_apellido VARCHAR(20) NOT NULL,
	seg_apellido VARCHAR(20) NOT NULL,
	doc_id_rep NUMERIC(10) NOT NULL UNIQUE,
	telef_rep VARCHAR(15) NOT NULL UNIQUE,
	CONSTRAINT pk_contacto_emp PRIMARY KEY (id_floristeria, id_representante)
);

CREATE TABLE enlaces(
	id_significado INT NOT NULL,
	id_enlace INT DEFAULT nextval('seq_enlace') NOT NULL,
	descripcion VARCHAR(300),
	id_flor_corte INT,
	codigo_color VARCHAR(6),
	CONSTRAINT pk_enlace PRIMARY KEY (id_significado, id_enlace)
);

CREATE TABLE catalogos_productores(
	id_productor INT NOT NULL,
	vbn INT NOT NULL,
	nombre_propio VARCHAR(40) NOT NULL UNIQUE,
	descripcion VARCHAR(300) NOT NULL,
	id_flor INT NOT NULL,
	codigo_color VARCHAR(6) NOT NULL,
	CONSTRAINT pk_catalogo_prod PRIMARY KEY (id_productor, vbn)
);

CREATE TABLE contratos(
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT DEFAULT nextval('seq_contratos') NOT NULL UNIQUE,
	fecha_contrato DATE NOT NULL,
	clasificacion VARCHAR(2) NOT NULL,
	porc_total_prod NUMERIC(5,2) NOT NULL,
	cancelado VARCHAR(2),
	id_contrato_padre INT references contratos(id_contrato) UNIQUE,
	CONSTRAINT check_clasificacion CHECK (clasificacion in('CA','CB','CC','CG','KA')),
	CONSTRAINT check_cancelado CHECK (cancelado in ('SI','NO')),
	CONSTRAINT pk_contratos PRIMARY KEY (id_sub,id_prod,id_contrato),
	CONSTRAINT check_porcentaje CHECK (porc_total_prod>0 AND porc_total_prod<=100)
);

CREATE TABLE det_contratos( 
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT NOT NULL,
	vbn INT NOT NULL,
	cantidad NUMERIC(4) NOT NULL,
	CONSTRAINT pk_det_contratos PRIMARY KEY (id_sub,id_prod,id_contrato,vbn)
);

CREATE TABLE afiliacion(
	id_sub INT NOT NULL,
	id_floristeria INT NOT NULL,
	CONSTRAINT pk_afiliacion PRIMARY KEY(id_sub, id_floristeria)
);

CREATE TABLE facturas_subastas(
	num_factura NUMERIC(12) CONSTRAINT pk_facturasub PRIMARY KEY,
	fecha_emision DATE NOT NULL,
	total FLOAT NOT NULL,
	id_sub INT NOT NULL,
	id_floristeria INT NOT NULL,
	envio VARCHAR(2),
	CONSTRAINT check_envio CHECK (envio in('SI','NO')),
	CONSTRAINT check_total_factura CHECK (total>0)
);

CREATE TABLE lotes_flor( 
	id_lote INT DEFAULT nextval('seq_lotes') CONSTRAINT pk_lote PRIMARY KEY,
	cantidad NUMERIC(3) NOT NULL,
	precio_inicial NUMERIC(6,2) NOT NULL,
	BI NUMERIC(3,2) NOT NULL,
	precio_final FLOAT NOT NULL,
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT NOT NULL,
	vbn INT NOT NULL,
	num_factura NUMERIC(12) NOT NULL,
	CONSTRAINT check_bi CHECK(BI >= 0.5 AND BI <=1),
	CONSTRAINT check_precio_inicial CHECK(precio_inicial>0),
	CONSTRAINT check_precio_final CHECK(precio_final>0)
);

CREATE TABLE pagos_multas(
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT NOT NULL,
	id_pagos INT DEFAULT nextval('seq_pagos') NOT NULL,
	fecha_pago DATE NOT NULL,
	monto_euros FLOAT NOT NULL,
	tipo VARCHAR(3) NOT NULL,
	CONSTRAINT check_pagos CHECK(tipo in('MEM','MUL','COM')),
	CONSTRAINT pk_pagos PRIMARY KEY (id_sub,id_prod,id_contrato,id_pagos),
	CONSTRAINT check_monto CHECK(monto_euros>0)
);

CREATE TABLE catalogos_floristerias(
	id_floristeria INT NOT NULL,
	id_catalogo INT DEFAULT nextval('seq_catalogofloristeria') NOT NULL,
	nombre VARCHAR(40) NOT NULL UNIQUE,
	id_flor_corte INT NOT NULL,
	codigo_color VARCHAR(6) NOT NULL,
	CONSTRAINT pk_catalogo_floristeria PRIMARY KEY (id_floristeria, id_catalogo)
);

CREATE TABLE historicos_precio(
	id_floristeria INT NOT NULL,
	id_catalogo INT NOT NULL,
	fecha_inicio TIMESTAMP NOT NULL,
	precio_unitario NUMERIC(5,2) NOT NULL,
	tamano_tallo NUMERIC(5,2),
	fecha_final TIMESTAMP,
	CONSTRAINT pk_historico_precio PRIMARY KEY (id_floristeria,id_catalogo,fecha_inicio),
	CONSTRAINT check_precio_unitario_flor CHECK(precio_unitario>0),
	CONSTRAINT check_tamano_tallo CHECK(tamano_tallo>0)
);

CREATE TABLE bouquets(
	id_floristeria INT NOT NULL,
	id_catalogo INT NOT NULL,
	id_bouquet INT DEFAULT nextval('seq_bouquet') NOT NULL,
	cantidad NUMERIC(3) NOT NULL,
	descripcion VARCHAR(300),
	tamano_tallo NUMERIC(5,2),
	CONSTRAINT pk_bouquet PRIMARY KEY (id_floristeria, id_catalogo, id_bouquet),
	CONSTRAINT check_tamano_tallo CHECK(tamano_tallo>0),
	CONSTRAINT check_cantidad CHECK (cantidad>0)
);

CREATE TABLE clientes_natural_floristerias(
	num_cliente NUMERIC(3) CONSTRAINT pk_cliente_natural PRIMARY KEY,
	doc_identidad NUMERIC(12) NOT NULL UNIQUE,
	primer_nombre VARCHAR(15) NOT NULL,
	primer_apellido VARCHAR(20) NOT NULL,
	segundo_apellido VARCHAR(20) NOT NULL
);

CREATE TABLE clientes_compania_floristerias(
	num_empresa NUMERIC(4) CONSTRAINT pk_cliente_empresa PRIMARY KEY,
	nombre_empresa VARCHAR(50) NOT NULL,
	razon_social VARCHAR(70) NOT NULL
);

CREATE TABLE facturas_floristerias(
	id_floristeria INT NOT NULL,
	num_factura NUMERIC(4) NOT NULL,
	fecha_emision DATE NOT NULL,
	monto_total NUMERIC(6,2) NOT NULL,
	num_cliente NUMERIC(3),
	num_empresa NUMERIC(3),
	CONSTRAINT pk_facturas_floristerias PRIMARY KEY(id_floristeria, num_factura)
);

CREATE TABLE det_facturas_floristerias(
	id_det_factura INT DEFAULT nextval('seq_detfacturas_floristeria') NOT NULL,
	cantidad NUMERIC(3) NOT NULL,
	id_floristeria INT NOT NULL,
	num_factura NUMERIC(12) NOT NULL,
	id_catalogo INT,
	id_bouquet INT,
	subtotal NUMERIC(5,2),
	valor_calidad NUMERIC(2,1),
	valor_precio NUMERIC(2,1),
	promedio NUMERIC(2,1),
	CONSTRAINT pk_detfacturas_floristerias PRIMARY KEY (id_floristeria, num_factura, id_det_factura),
	CONSTRAINT check_valor_calidad CHECK (valor_calidad BETWEEN 1 AND 5),  
	CONSTRAINT check_valor_precio CHECK (valor_precio BETWEEN 1 AND 5),     
	CONSTRAINT check_promedio CHECK (promedio BETWEEN 1 AND 5)               
);
--TABLAS FIN

--ALTERS INICIO
ALTER TABLE subastadoras
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE productores
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE floristerias
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE contactos_empleados 
	ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria);

ALTER TABLE enlaces 
	ADD CONSTRAINT fk_significado FOREIGN KEY (id_significado) REFERENCES significados(id_significado);

ALTER TABLE enlaces 
	ADD CONSTRAINT fk_flor_corte FOREIGN KEY (id_flor_corte) REFERENCES flores_corte(id_flor_corte);

ALTER TABLE enlaces 	
	ADD CONSTRAINT fk_codigo_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color);

ALTER TABLE catalogos_productores 
	ADD CONSTRAINT fk_productor FOREIGN KEY (id_productor) REFERENCES productores(id_prod);

ALTER TABLE catalogos_productores 
	ADD CONSTRAINT fk_flor FOREIGN KEY (id_flor) REFERENCES flores_corte(id_flor_corte);

ALTER TABLE catalogos_productores 
	ADD CONSTRAINT fk_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color);

ALTER TABLE contratos 
	ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub);

ALTER TABLE contratos 
	ADD CONSTRAINT fk_prod FOREIGN KEY (id_prod) REFERENCES productores(id_prod);

ALTER TABLE det_contratos
	 ADD CONSTRAINT fk_contrato FOREIGN KEY (id_sub, id_prod, id_contrato) REFERENCES contratos(id_sub, id_prod, id_contrato);

ALTER TABLE det_contratos 
	ADD CONSTRAINT fk_cat_prod FOREIGN KEY (id_prod, vbn) REFERENCES catalogos_productores(id_productor, vbn);

ALTER TABLE afiliacion 
	ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub);

ALTER TABLE afiliacion 
	ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria);

ALTER TABLE facturas_subastas
	ADD CONSTRAINT fk_afiliacion FOREIGN KEY (id_sub, id_floristeria) REFERENCES afiliacion(id_sub, id_floristeria);

ALTER TABLE lotes_flor 
	ADD CONSTRAINT fk_detcontrato FOREIGN KEY (id_sub, id_prod, id_contrato, vbn) REFERENCES det_contratos(id_sub, id_prod, id_contrato, vbn);

ALTER TABLE lotes_flor 
	ADD CONSTRAINT fk_facturasubasta FOREIGN KEY (num_factura) REFERENCES facturas_subastas(num_factura);

ALTER TABLE pagos_multas
	ADD CONSTRAINT fk_contratos FOREIGN KEY (id_sub,id_prod,id_contrato) REFERENCES contratos(id_sub,id_prod,id_contrato);

ALTER TABLE catalogos_floristerias 	
	ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria);

ALTER TABLE catalogos_floristerias 
	ADD CONSTRAINT fk_florcorte FOREIGN KEY (id_flor_corte) REFERENCES flores_corte(id_flor_corte);

ALTER TABLE catalogos_floristerias 
	ADD CONSTRAINT fk_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color);
	
ALTER TABLE historicos_precio
	ADD CONSTRAINT fk_catalogo_floristeria FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria,id_catalogo);

ALTER TABLE bouquets
	ADD CONSTRAINT fk_catalogo FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria,id_catalogo);

ALTER TABLE facturas_floristerias
	ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria);

ALTER TABLE facturas_floristerias
	ADD CONSTRAINT fk_num_cliente FOREIGN KEY (num_cliente) REFERENCES clientes_natural_floristerias(num_cliente);

ALTER TABLE facturas_floristerias
	ADD CONSTRAINT fk_num_empresa FOREIGN KEY (num_empresa) REFERENCES clientes_compania_floristerias(num_empresa);

ALTER TABLE det_facturas_floristerias
	ADD CONSTRAINT fk_factura FOREIGN KEY (id_floristeria, num_factura) REFERENCES facturas_floristerias(id_floristeria, num_factura);

ALTER TABLE det_facturas_floristerias
	ADD CONSTRAINT fk_catalogo_floristeria FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria, id_catalogo);	

ALTER TABLE det_facturas_floristerias
	ADD CONSTRAINT fk_bouquet FOREIGN KEY (id_floristeria, id_catalogo, id_bouquet) REFERENCES bouquets(id_floristeria, id_catalogo, id_bouquet);	
--ALTERS FIN

--VIEWS INICIO

--VIEWS FIN

--TRIGGERS Y PROGRAMAS ALMACENADOS INICIO
--                                                   MANEJO DE CONTRATOS.

--VALIDACIONES PARA PODER CREAR UN CONTRATO
--Funcion para validar que una productora no tenga más de un contrato activo si la clasificacion es CA, CB, CC, KA
CREATE OR REPLACE FUNCTION validar_contrato_activo()
RETURNS TRIGGER AS $$
DECLARE
    contrato_activo RECORD;
BEGIN
    -- Cuenta contratos activos para el productor en las categorías especificadas
    SELECT c.id_prod, c.clasificacion, c.id_contrato, p.nombre_prod, s.nombre_sub
    INTO contrato_activo
    FROM contratos c
    JOIN productores p ON c.id_prod = p.id_prod
    JOIN subastadoras s ON c.id_sub = s.id_sub
    WHERE c.id_prod = NEW.id_prod
      AND c.clasificacion IN ('CA', 'CB', 'CC', 'KA')
      AND c.cancelado = 'NO'
      AND NEW.fecha_contrato BETWEEN c.fecha_contrato AND (c.fecha_contrato + INTERVAL '1 year')
    LIMIT 1; 

    IF FOUND THEN
        RAISE EXCEPTION 'El productor % ya tiene un contrato activo de categoría % con la subastadora %.',
            contrato_activo.nombre_prod, contrato_activo.clasificacion, contrato_activo.nombre_sub;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_contrato_activo
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_contrato_activo();

--Funcion para validar que si en un contrato la categoria esta clasificada como KA, que sea holandesa
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
            RAISE EXCEPTION 'El productor debe ser de Holanda para clasificaciones KA en el contrato.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_clasificacion_KA
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW EXECUTE FUNCTION validar_clasificacion_KA();

--Funcion para validar el porcentaje total ofrecido en un contrato
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
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND fecha_contrato >= NOW() - INTERVAL '1 year';  

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

--Funcion para validar que no exista un contrato activo CG para el productor y la subastadora
CREATE OR REPLACE FUNCTION validar_unico_contrato_CG()
RETURNS TRIGGER AS $$
DECLARE
    contrato_existente INT;
BEGIN
    SELECT COUNT(*)
    INTO contrato_existente
    FROM contratos
    WHERE id_sub = NEW.id_sub
      AND id_prod = NEW.id_prod
      AND clasificacion = 'CG'
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND NEW.fecha_contrato BETWEEN fecha_contrato AND (fecha_contrato + INTERVAL '1 year');

    IF contrato_existente > 0 THEN
        RAISE EXCEPTION 'Ya existe un contrato activo CG para el productor % y la subastadora %. No se puede insertar un nuevo contrato.', NEW.id_prod, NEW.id_sub;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_unico_contrato_CG
BEFORE INSERT ON contratos
FOR EACH ROW
WHEN (NEW.clasificacion = 'CG')
EXECUTE FUNCTION validar_unico_contrato_CG();

--Validar que un productor no tenga un contrato activo de tipo CG si le quiere cambiar la categoria a la renovacion
CREATE OR REPLACE FUNCTION validar_contrato_CG()
RETURNS TRIGGER AS $$
DECLARE
    contrato_CG RECORD;
BEGIN
    -- Verificar si el productor tiene un contrato activo de tipo CG
    SELECT c.id_prod, c.clasificacion, c.id_contrato
    INTO contrato_CG
    FROM contratos c
    WHERE c.id_prod = NEW.id_prod
      AND c.clasificacion = 'CG'
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND NEW.fecha_contrato BETWEEN c.fecha_contrato AND (c.fecha_contrato + INTERVAL '1 year')
    LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION 'El productor % ya tiene un contrato activo de tipo CG y no puede tener otro contrato de diferente categoría.',
            NEW.id_prod;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_contrato_CG
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW
WHEN (NEW.clasificacion <> 'CG')  
EXECUTE FUNCTION validar_contrato_CG();

--Funcion auxiliar para buscar los ids de la subastadora y productora pedidos
CREATE OR REPLACE FUNCTION obtener_ids(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40)
) RETURNS TABLE (
    id_sub INT,
    id_prod INT
) AS $$
BEGIN
    SELECT 
        s.id_sub,
        p.id_prod
    INTO 
        id_sub, id_prod
    FROM 
        subastadoras s
    JOIN 
        productores p ON lower(p.nombre_prod) = lower(p_nombre_prod)
    WHERE 
        lower(s.nombre_sub) = lower(p_nombre_sub);

    IF id_sub IS NULL OR id_prod IS NULL THEN
        RAISE EXCEPTION 'Productor o subastadora no encontrados: % - %', p_nombre_prod, p_nombre_sub;
    END IF;

    RETURN NEXT; 
END;
$$ LANGUAGE plpgsql;

--VALIDACIONES PARA RENOVAR UN CONTRATO.

--Funcion para asegurarse de que el contrato padre exista y que sean el mismo id_sub y id_prod y devolverá su fecha de creación
CREATE OR REPLACE FUNCTION verificar_contrato_padre(
    p_id_contrato_padre INT,
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40)
)
RETURNS DATE AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    fecha_padre DATE;
    estado_cancelado VARCHAR(2);
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT fecha_contrato, cancelado INTO fecha_padre, estado_cancelado
    FROM contratos
    WHERE id_contrato = p_id_contrato_padre 
      AND id_sub = v_id_sub 
      AND id_prod = v_id_prod;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El contrato al que se referencia para la renovación con ID % no existe para el productor % en la subastadora %', 
            p_id_contrato_padre, p_nombre_prod, p_nombre_sub;
    END IF;

    IF estado_cancelado = 'SI' THEN
        RAISE EXCEPTION 'No se puede renovar el contrato; el contrato original (ID: %) está cancelado.', 
            p_id_contrato_padre;
    END IF;

    RETURN fecha_padre;
END;
$$ LANGUAGE plpgsql;

--Procedimiento para validar si la fecha de renovación es mayor que la del contrato padre y si ha pasado un año desde su creación
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
CREATE OR REPLACE FUNCTION validar_renovacion_contrato()
RETURNS TRIGGER AS $$
DECLARE
    fecha_padre DATE;
BEGIN
    fecha_padre := verificar_contrato_padre(NEW.id_contrato_padre, NEW.id_sub, NEW.id_prod);
    PERFORM validar_fecha_renovacion(NEW.fecha_contrato, fecha_padre);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_renovacion
BEFORE INSERT OR UPDATE ON contratos
FOR EACH ROW
WHEN (NEW.id_contrato_padre IS NOT NULL) 
EXECUTE FUNCTION validar_renovacion_contrato();

--DESACTIVARLO PARA COLOCAR LOS INSERTS DE CONTRATOS
ALTER TABLE contratos DISABLE TRIGGER trigger_validar_renovacion;

--CREACION DE CONTRATOS
CREATE OR REPLACE PROCEDURE crear_contrato(
    p_nombre_prod VARCHAR(40),
    p_nombre_sub VARCHAR(40),
    p_fecha_contrato DATE,
    p_clasificacion VARCHAR(2),
    p_porcentaje NUMERIC(5,2)
) AS $$
DECLARE
    v_id_prod INT;
    v_id_sub INT;
    v_id_contrato INT;
BEGIN
 
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod)
    VALUES (v_id_sub, v_id_prod, p_fecha_contrato, p_clasificacion, p_porcentaje)
    RETURNING id_contrato INTO v_id_contrato;

    RAISE NOTICE 'Se creó un nuevo contrato (ID: %) para el productor % en la subastadora %.', 
                 v_id_contrato, p_nombre_prod, p_nombre_sub;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'No se pudo crear el contrato para el productor % en la subastadora %. Puede que ya exista uno activo.', 
                     p_nombre_prod, p_nombre_sub;
END;
$$ LANGUAGE plpgsql;

--RENOVACION DE CONTRATOS
--Funcion para renovar un contrato con categoria y/o porcentajes nuevos
CREATE OR REPLACE PROCEDURE renovar_contrato_nuevos_datos(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_nueva_categoria VARCHAR(2),
    p_nuevo_porcentaje NUMERIC(5,2)
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato_padre INT;
    v_fecha_contrato DATE;
    v_fecha_nueva DATE;
BEGIN

    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato, fecha_contrato INTO v_id_contrato_padre, v_fecha_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod 
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND fecha_contrato >= CURRENT_DATE - INTERVAL '1 year'
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un contrato activo y no cancelado para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    v_fecha_nueva := DATE_TRUNC('year', v_fecha_contrato) + INTERVAL '1 year' + (v_fecha_contrato - DATE_TRUNC('year', v_fecha_contrato)) + INTERVAL '2 days';

    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre)
    VALUES (v_id_sub, v_id_prod, v_fecha_nueva, p_nueva_categoria, p_nuevo_porcentaje, 'NO', v_id_contrato_padre);

    RAISE NOTICE 'Contrato renovado exitosamente para el productor % (ID: %) en la subastadora % (ID: %) con la nueva categoría % para la fecha %.', 
                 p_nombre_prod, v_id_prod, p_nombre_sub, v_id_sub, p_nueva_categoria, v_fecha_nueva;

END;
$$ LANGUAGE plpgsql;

--Procedure para validar contratos y renovarlos manteniendo los datos de clasificacion y porcentaje
CREATE OR REPLACE PROCEDURE renovar_contrato_manteniendo_datos(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40)
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato_padre INT;
    v_fecha_padre DATE;
    v_clasificacion VARCHAR(2);
    v_porcentaje NUMERIC(5,2);
    v_fecha_nueva DATE;
BEGIN

    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato, fecha_contrato INTO v_id_contrato_padre, v_fecha_padre
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod 
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND fecha_contrato >= CURRENT_DATE - INTERVAL '1 year'
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un contrato activo y no cancelado para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    SELECT 
        c.clasificacion, 
        c.porc_total_prod
    INTO 
        v_clasificacion, 
        v_porcentaje
    FROM 
        contratos c
    WHERE 
        c.id_contrato = v_id_contrato_padre;

    v_fecha_nueva := DATE_TRUNC('year', v_fecha_padre) + INTERVAL '1 year' + (v_fecha_padre - DATE_TRUNC('year', v_fecha_padre)) + INTERVAL '2 days';

    INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre)
    VALUES (v_id_sub, v_id_prod, v_fecha_nueva, v_clasificacion, v_porcentaje, 'NO', v_id_contrato_padre);

    RAISE NOTICE 'Contrato renovado exitosamente para el productor % (ID: %) en la subastadora % (ID: %) con la clasificación % para la fecha %', 
                 p_nombre_prod, v_id_prod, p_nombre_sub, v_id_sub, v_clasificacion, v_fecha_nueva;

END;
$$ LANGUAGE plpgsql;

--Funcion para cancelar un contrato activo
CREATE OR REPLACE FUNCTION cancelar_contrato(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40)
) RETURNS VOID AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
    v_nombre_prod VARCHAR(100);
    v_nombre_sub VARCHAR(100);
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT c.id_contrato, p.nombre_prod, s.nombre_sub
    INTO v_id_contrato, v_nombre_prod, v_nombre_sub
    FROM contratos c
    JOIN productores p ON c.id_prod = p.id_prod
    JOIN subastadoras s ON c.id_sub = s.id_sub
    WHERE c.id_sub = v_id_sub 
      AND c.id_prod = v_id_prod 
      AND (c.cancelado = 'NO' OR c.cancelado IS NULL)
      AND c.fecha_contrato >= NOW() - INTERVAL '1 year'  
    LIMIT 1; 

    IF FOUND THEN
        UPDATE contratos
        SET cancelado = 'SI'
        WHERE id_sub = v_id_sub 
          AND id_prod = v_id_prod 
          AND id_contrato = v_id_contrato;
          
        RAISE NOTICE 'Contrato % cancelado exitosamente para el productor % y la subastadora %.', 
                     v_id_contrato, v_nombre_prod, v_nombre_sub;
    ELSE
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % y la subastadora % dentro del último año.', 
                        p_nombre_prod, p_nombre_sub;
    END IF;
END;
$$ LANGUAGE plpgsql;

--AUXILIARES PARA EL MANEJO DE CONTRATOS

--Funcion auxiliar para obtener una tabla con los contratos activos actualmente
CREATE OR REPLACE FUNCTION obtener_contratos_activos()
RETURNS TABLE (
    contrato_id_sub INT,
    subastador_nombre VARCHAR(100),
    contrato_id_prod INT,
    productor_nombre VARCHAR(100),
    contrato_id_contrato INT,
    contrato_fecha_contrato DATE,
    contrato_fecha_vencimiento DATE,
    contrato_clasificacion VARCHAR(2),
    contrato_porc_total_prod NUMERIC(5, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_sub, 
        s.nombre_sub, 
        c.id_prod, 
        p.nombre_prod,
        c.id_contrato, 
        c.fecha_contrato, 
        (c.fecha_contrato + INTERVAL '1 year')::DATE AS contrato_fecha_vencimiento,
        c.clasificacion, 
        c.porc_total_prod
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
        c.cancelado = 'NO' OR c.cancelado IS NULL 
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
    subastador_nombre VARCHAR(100),
    contrato_id_prod INT,
    productor_nombre VARCHAR(100),
    contrato_id_contrato INT,
    contrato_fecha_contrato DATE,
    contrato_fecha_vencimiento DATE,
    contrato_clasificacion VARCHAR(2),
    contrato_porc_total_prod NUMERIC(5, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_sub, 
        s.nombre_sub,
        c.id_prod, 
        p.nombre_prod,
        c.id_contrato, 
        c.fecha_contrato, 
        (c.fecha_contrato + INTERVAL '1 year')::DATE AS contrato_fecha_vencimiento, 
        c.clasificacion, 
        c.porc_total_prod
    FROM 
        contratos c
    JOIN 
        productores p ON c.id_prod = p.id_prod
    JOIN 
        subastadoras s ON c.id_sub = s.id_sub
    WHERE 
         c.cancelado = 'NO' OR c.cancelado IS NULL 
      AND 
        c.fecha_contrato + INTERVAL '1 year' < CURRENT_DATE;  
END;
$$ LANGUAGE plpgsql;

--Funcion Auxiliar para obtener los contratos que estan por vencer en un numero de dias especificado
CREATE OR REPLACE FUNCTION contratos_por_vencer(dias_aviso INT)
RETURNS TABLE (
    id_sub INT,
    nombre_subastadora VARCHAR,
    id_prod INT,
    nombre_productor VARCHAR,
    id_contrato INT,
    fecha_contrato DATE,
    fecha_vencimiento DATE,
    dias_restantes INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_sub,
        s.nombre_sub AS nombre_subastadora,   
        c.id_prod,
        p.nombre_prod AS nombre_productor,        
        c.id_contrato,
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

--                                                    CONTROL DE PAGOS Y COMISIONES

--VALIDACIONES PARA CREAR UN PAGO
--Funcion para validar que la fecha de pago de un contrato este entre la fecha de contrato y su validez de un año
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

CREATE TRIGGER trigger_validar_fecha_pago
BEFORE INSERT ON pagos_multas
FOR EACH ROW EXECUTE FUNCTION validar_fecha_pago();

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

--CALCULOS DE VENTAS MENSUALES, COMISIONES Y MULTAS.

--Funcion para calcular las ventas mensuales basado en un contrato
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

    RETURN COALESCE(v_total_ventas, 0);
END;
$$ LANGUAGE plpgsql;

--Funcion para calcular la comision basado en un contrato y las ventas mensuales
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

    v_total_ventas := calcular_ventas_mensuales(p_id_sub, p_id_prod, p_id_contrato, p_fecha_pago);

    SELECT c.clasificacion
    INTO v_clasificacion
    FROM contratos c
    WHERE c.id_sub = p_id_sub AND c.id_prod = p_id_prod AND c.id_contrato = p_id_contrato;

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
    END IF;

    v_monto_euros := v_total_ventas * v_comision_rate;

    RETURN v_monto_euros;
END;
$$ LANGUAGE plpgsql;

--Funcion trigger para calcular la comision cuando se ingrese un pago tipo 'COM'
CREATE OR REPLACE FUNCTION trg_calcular_comision()
RETURNS TRIGGER AS $$
DECLARE
    v_monto_multa FLOAT;
    v_existente BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM pagos_multas
        WHERE id_sub = NEW.id_sub
          AND id_prod = NEW.id_prod
          AND id_contrato = NEW.id_contrato
          AND tipo = 'COM'
          AND DATE_TRUNC('month', fecha_pago) = DATE_TRUNC('month', NEW.fecha_pago)
    ) INTO v_existente;

    IF v_existente THEN
        RAISE EXCEPTION 'Ya existe una comisión registrada para el mes % de %.', 
            TO_CHAR(NEW.fecha_pago, 'Month YYYY'), NEW.id_prod;
    END IF;

    IF NEW.tipo = 'COM' THEN
        NEW.monto_euros := calcular_comision(NEW.id_sub, NEW.id_prod, NEW.id_contrato, NEW.fecha_pago);
        
        IF NEW.monto_euros = 0 THEN
            RAISE EXCEPTION 'Las ventas mensuales del mes fueron 0, no se registrara la comisión y seguira solvente.';
        END IF;

        IF EXTRACT(DAY FROM NEW.fecha_pago) > 5 THEN
            RAISE NOTICE 'Aviso: La fecha de pago % es posterior al día 5 del mes. Se puede aplicar una multa del 20%% de las ventas del siguiente mes.', NEW.fecha_pago;
        END IF;

        RAISE NOTICE 'Pago registrado exitosamente: Monto de la comisión es %', NEW.monto_euros;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcular_comision
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'COM')
EXECUTE FUNCTION trg_calcular_comision();

--Procedure para registrar una comision 
CREATE OR REPLACE PROCEDURE registrar_comision(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_fecha_pago DATE
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato INTO v_id_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod 
      AND (cancelado = 'NO' OR cancelado IS NULL)
      AND fecha_contrato >= CURRENT_DATE - INTERVAL '1 year'
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF v_id_contrato IS NULL THEN
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;
    
    INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo)
    VALUES (v_id_sub, v_id_prod, v_id_contrato, p_fecha_pago, 'COM');
END;
$$ LANGUAGE plpgsql;

--Funcion para calcular la multa basado en un contrato y las ventas mensuales
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

CREATE OR REPLACE FUNCTION trg_calcular_multa()
RETURNS TRIGGER AS $$
DECLARE
    v_total_ventas FLOAT;
BEGIN
    IF NEW.tipo = 'MUL' THEN
        v_total_ventas := calcular_ventas_mensuales(NEW.id_sub, NEW.id_prod, NEW.id_contrato, NEW.fecha_pago);
        NEW.monto_euros := v_total_ventas * 0.20;

        IF NEW.monto_euros = 0 THEN
            RAISE NOTICE 'No se puede registrar la multa porque no hubo ventas en el mes correspondiente. La multa sigue pendiente. Intente registrarla en el próximo mes con ventas mensuales.';
            RETURN NULL; 
        END IF;

        RAISE NOTICE 'Pago de multa calculado: Monto de la multa es %', NEW.monto_euros;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcular_multa
BEFORE INSERT ON pagos_multas
FOR EACH ROW
WHEN (NEW.tipo = 'MUL') 
EXECUTE FUNCTION trg_calcular_multa();

--Procedure a llamar para registrar una multa
CREATE OR REPLACE PROCEDURE registrar_multa(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_fecha_pago DATE
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
BEGIN

    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato INTO v_id_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod 
      AND (cancelado = 'NO' OR cancelado IS NULL)
      ORDER BY fecha_contrato DESC
      LIMIT 1;

    IF v_id_contrato IS NULL THEN
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo)
    VALUES (v_id_sub, v_id_prod, v_id_contrato, p_fecha_pago, 'MUL');
END;
$$ LANGUAGE plpgsql;

--AUXILIARES PARA VER VENTAS MENSUALES

--Muestra si un productor tiene ventas en un mes especifico
CREATE OR REPLACE PROCEDURE consultar_ventas_mensuales(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_mes INT,  
    p_anio INT  
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
    v_ventas_mensuales NUMERIC;
    v_fecha_inicio DATE;
    v_fecha_fin DATE;
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato INTO v_id_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod
      AND (cancelado = 'NO' OR cancelado IS NULL)
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF v_id_contrato IS NULL THEN
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    v_fecha_inicio := DATE_TRUNC('month', TO_DATE(p_anio || '-' || p_mes || '-01', 'YYYY-MM-DD'));
    v_fecha_fin := (v_fecha_inicio + INTERVAL '1 month') - INTERVAL '1 day';

    SELECT SUM(l.precio_final) INTO v_ventas_mensuales
    FROM lotes_flor l
    JOIN facturas_subastas f ON l.num_factura = f.num_factura
    WHERE l.id_sub = v_id_sub
      AND l.id_prod = v_id_prod
      AND l.id_contrato = v_id_contrato
      AND f.fecha_emision BETWEEN v_fecha_inicio AND v_fecha_fin; 

    IF v_ventas_mensuales IS NULL OR v_ventas_mensuales = 0 THEN
        RAISE NOTICE 'El productor % no tiene ventas registradas en el mes %/% para la subastadora %.',
                     p_nombre_prod, p_mes, p_anio, p_nombre_sub;
    ELSE
        RAISE NOTICE 'El productor % tiene ventas registradas de % euros en el mes %/% para la subastadora %.',
                     p_nombre_prod, v_ventas_mensuales, p_mes, p_anio, p_nombre_sub;
    END IF;
END;
$$ LANGUAGE plpgsql;

--AUXILIARES PARA CONSEGUIR EL ESTADO DE UN PRODUCTOR

CREATE OR REPLACE FUNCTION analizar_ventas_mensuales(
    p_id_contrato INT,
    p_fecha_consulta DATE
) RETURNS TABLE (
    mes DATE,
    ventas NUMERIC
) AS $$
DECLARE
    v_fecha_inicio DATE;
    v_fecha_fin DATE;
BEGIN
    SELECT fecha_contrato INTO v_fecha_inicio
    FROM contratos
    WHERE id_contrato = p_id_contrato;

    v_fecha_fin := DATE_TRUNC('month', p_fecha_consulta)  - INTERVAL '1 day';

    WHILE v_fecha_inicio <= v_fecha_fin LOOP

        RETURN QUERY SELECT 
            v_fecha_inicio AS mes,
              CAST(COALESCE(SUM(l.precio_final), 0) AS NUMERIC) AS ventas
        FROM lotes_flor l
        JOIN facturas_subastas f ON l.num_factura = f.num_factura
        WHERE f.fecha_emision >= v_fecha_inicio
          AND f.fecha_emision < v_fecha_inicio + INTERVAL '1 month'
          AND l.id_contrato = p_id_contrato;

        v_fecha_inicio := v_fecha_inicio + INTERVAL '1 month';
    END LOOP;

END;
$$ LANGUAGE plpgsql;

--   EVALUAR ESTADO DE UN PRODUCTOR ANTE UNA SUBASTADORA

--Funcion que devuelve una tabla con el desglose del estatus de un productor segun sus pagos de comisiones
CREATE OR REPLACE FUNCTION estatus_productor_comisiones(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_fecha_consulta DATE
) RETURNS TABLE (
    fecha_pago DATE, 
    comision_pendiente NUMERIC,
    comision_pagada NUMERIC,
    total_acumulado NUMERIC,
    estatus TEXT
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
    v_porcentaje_comision NUMERIC;
    v_tipo_productor VARCHAR(2);
    v_comision_total NUMERIC;
    v_comision_pagada NUMERIC;
    v_acumulado NUMERIC := 0;
    v_ventas NUMERIC; 
    mes DATE; 
	morosos_count INT := 0; 
    solventes_count INT := 0;  
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato INTO v_id_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod
      AND (cancelado = 'NO' OR cancelado IS NULL)
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF v_id_contrato IS NULL THEN
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    SELECT clasificacion INTO v_tipo_productor
    FROM contratos
    WHERE id_contrato = v_id_contrato;

    CASE v_tipo_productor
        WHEN 'CA' THEN v_porcentaje_comision := 0.005;
        WHEN 'CB' THEN v_porcentaje_comision := 0.01;
        WHEN 'CC' THEN v_porcentaje_comision := 0.02;
        WHEN 'CG' THEN v_porcentaje_comision := 0.05;
        WHEN 'KA' THEN v_porcentaje_comision := 0.0025;
        ELSE v_porcentaje_comision := 0;
    END CASE;

    FOR mes, v_ventas IN 
        SELECT * FROM analizar_ventas_mensuales(v_id_contrato, p_fecha_consulta)
    LOOP
        IF EXTRACT(DAY FROM p_fecha_consulta) <= 5 AND EXTRACT(MONTH FROM p_fecha_consulta) - 1 = EXTRACT(MONTH FROM mes) THEN
            CONTINUE; 
        END IF;

        v_comision_total := CAST(v_ventas * v_porcentaje_comision AS NUMERIC);

        SELECT COALESCE(MAX(p.fecha_pago), NULL) INTO fecha_pago
        FROM pagos_multas p
        WHERE p.id_contrato = v_id_contrato
          AND p.fecha_pago >= mes
          AND p.fecha_pago < mes + INTERVAL '1 month'
          AND p.tipo = 'COM';

        IF fecha_pago IS NULL THEN
            fecha_pago := date_trunc('month', mes + INTERVAL '1 month');  
        END IF;

        SELECT COALESCE(SUM(p.monto_euros), 0) INTO v_comision_pagada
        FROM pagos_multas p
        WHERE p.id_contrato = v_id_contrato
          AND p.fecha_pago >= mes
          AND p.fecha_pago < mes + INTERVAL '1 month'
          AND p.tipo = 'COM';

        v_comision_total := v_comision_total - v_comision_pagada;

        v_acumulado := v_acumulado + GREATEST(v_comision_total, 0);

        IF v_acumulado > 0 THEN
            estatus := 'Moroso';
			 morosos_count := morosos_count + 1; 
        ELSE
            estatus := 'Solvente';
			 solventes_count := solventes_count + 1; 
        END IF;

        RETURN QUERY SELECT 
            fecha_pago AS fecha_,  
            GREATEST(v_comision_total, 0) AS comision_pendiente,
            v_comision_pagada,
            v_acumulado AS total_acumulado,
            estatus;
    END LOOP;

		IF morosos_count > 0 THEN
    RAISE NOTICE 'El estado general (en cuanto a comisiones) del productor % ante la subastadora % en la fecha % es : MOROSO',
	p_nombre_prod, p_nombre_sub, p_fecha_consulta;
	ELSE 
	 RAISE NOTICE 'El estado general (en cuanto a comisiones) del productor % ante la subastadora % en la fecha % es : SOLVENTE',
	p_nombre_prod, p_nombre_sub, p_fecha_consulta;
	END IF;

END;
$$ LANGUAGE plpgsql;

--Funcion que devuelve una tabla con el desglose del estatus de un productor segun sus pagos de multas
CREATE OR REPLACE FUNCTION estatus_productor_multas(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_fecha_consulta DATE
) RETURNS TABLE (
    fecha_pago_tardio DATE,
    multa_pendiente NUMERIC,
    multa_pagada NUMERIC,
    total_acumulado NUMERIC,
    estatus TEXT,
    mensaje TEXT
) AS $$
DECLARE
    v_id_sub INT;
    v_id_prod INT;
    v_id_contrato INT;
    v_tipo_productor VARCHAR(2);
    v_ventas NUMERIC; 
    mes DATE; 
    v_multa_total NUMERIC := 0;
    v_multa_pagada NUMERIC := 0;
    v_acumulado NUMERIC := 0;
    v_ventas_actual NUMERIC;
    v_fecha_pago DATE;
    v_fecha_limite DATE; 
	morosos_count INT := 0; 
    solventes_count INT := 0;  
BEGIN
    SELECT * INTO v_id_sub, v_id_prod FROM obtener_ids(p_nombre_sub, p_nombre_prod);

    SELECT id_contrato INTO v_id_contrato
    FROM contratos
    WHERE id_sub = v_id_sub 
      AND id_prod = v_id_prod
      AND (cancelado = 'NO' OR cancelado IS NULL)
    ORDER BY fecha_contrato DESC
    LIMIT 1;

    IF v_id_contrato IS NULL THEN
        RAISE EXCEPTION 'No se encontró un contrato activo para el productor % en la subastadora %.', 
            p_nombre_prod, p_nombre_sub;
    END IF;

    SELECT clasificacion, fecha_contrato INTO v_tipo_productor, v_fecha_limite
    FROM contratos
    WHERE id_contrato = v_id_contrato;

    v_fecha_limite := v_fecha_limite + INTERVAL '1 year';
	
    FOR mes, v_ventas IN 
        SELECT * FROM analizar_ventas_mensuales(v_id_contrato, p_fecha_consulta)
    LOOP
        v_multa_total := 0;
        v_multa_pagada := 0;

        SELECT COALESCE(MAX(p.fecha_pago), NULL) INTO v_fecha_pago
        FROM pagos_multas p
        WHERE p.id_contrato = v_id_contrato
          AND p.fecha_pago >= date_trunc('month', mes) + INTERVAL '1 month'
          AND p.fecha_pago < date_trunc('month', mes) + INTERVAL '2 months'
          AND p.tipo = 'COM';
		  
        IF (EXTRACT(DAY FROM v_fecha_pago) > 5 OR v_fecha_pago IS NULL) AND v_ventas > 0 THEN
		
            mes := date_trunc('month', v_fecha_pago);

            WHILE mes < v_fecha_limite LOOP
		      SELECT COALESCE(SUM(l.precio_final), 0) INTO v_ventas_actual
	                FROM lotes_flor l
	                JOIN facturas_subastas f ON l.num_factura = f.num_factura
	                WHERE f.fecha_emision >= mes 
	                  AND f.fecha_emision < mes + INTERVAL '1 month'
	                  AND l.id_contrato = v_id_contrato; 

	                IF v_ventas_actual > 0 AND (v_fecha_pago > mes + INTERVAL '4 days' OR v_fecha_pago IS NULL) 
					AND p_fecha_consulta > (mes + INTERVAL '1 month') THEN
	                    v_multa_total := v_ventas_actual * 0.20; 
	                    mensaje := 'Multa calculada en base a las ventas del mes.';
	                    EXIT;  
	                END IF;
	                mes := mes + INTERVAL '1 month';
            END LOOP;
        END IF;

        SELECT COALESCE(SUM(p.monto_euros), 0) INTO v_multa_pagada
        FROM pagos_multas p
        WHERE p.id_contrato = v_id_contrato
          AND p.fecha_pago >= date_trunc('month', mes) + INTERVAL '1 month'
          AND p.fecha_pago < p_fecha_consulta
          AND p.tipo = 'MUL';

        v_acumulado := v_acumulado + GREATEST(v_multa_total - v_multa_pagada, 0);

        IF (v_acumulado > 0) OR (p_fecha_consulta < date_trunc('month', mes) + INTERVAL '1 month' 
		AND v_multa_total = 0 AND EXTRACT(DAY FROM p_fecha_consulta) > 5 ) THEN
            estatus := 'Moroso';
			morosos_count := morosos_count + 1; 
        ELSE IF v_multa_pagada > 0 AND v_acumulado = 0 THEN
            estatus := 'Solvente';
		    solventes_count := solventes_count + 1; 		
		 END IF;
       END IF;

		IF v_fecha_pago IS NULL THEN
			v_fecha_pago =  date_trunc('month', mes);
		END IF;
		
        IF p_fecha_consulta < date_trunc('month', mes) + INTERVAL '1 month' 
		AND v_multa_total = 0 AND EXTRACT(DAY FROM p_fecha_consulta) > 5 THEN
		
            RETURN QUERY SELECT 
                v_fecha_pago AS fecha_pago_tardio,  
                GREATEST(v_multa_total - v_multa_pagada, 0) AS multa_pendiente, 
                v_multa_pagada AS multa_pagada,
                v_acumulado AS total_acumulado,
                estatus,
                'Tiene una multa pendiente. El monto se dará cuando se consiga el próximo mes con ventas.' AS mensaje;  
        ELSE
			IF v_multa_total > 0 THEN
            RETURN QUERY SELECT 
                v_fecha_pago AS fecha_pago_tardio, 
                GREATEST(v_multa_total - v_multa_pagada, 0) AS multa_pendiente,
                v_multa_pagada AS multa_pagada,
                v_acumulado AS total_acumulado,
                estatus,
                mensaje;
			END IF;
        END IF;
    END LOOP;
	
	IF morosos_count > 0 THEN
    RAISE NOTICE 'El estado general (en cuanto a multas) del productor % ante la subastadora % en la fecha % es : MOROSO',
	p_nombre_prod, p_nombre_sub, p_fecha_consulta;
	ELSE 
	 RAISE NOTICE 'El estado general (en cuanto a multas) del productor % ante la subastadora % en la fecha % es : SOLVENTE',
	p_nombre_prod, p_nombre_sub, p_fecha_consulta;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Funcion que devuelve el estado general de un productor, sin desglose
CREATE OR REPLACE FUNCTION estatus_general_productor(
    p_nombre_sub VARCHAR(40),
    p_nombre_prod VARCHAR(40),
    p_fecha_consulta DATE
) RETURNS VOID AS $$
DECLARE
    v_morosos_count_multas INT;
    v_solventes_count_multas INT;
    v_morosos_count_comisiones INT;
    v_solventes_count_comisiones INT;
    v_estatus_general TEXT;
    v_mensaje TEXT;
BEGIN
    SELECT 
        COUNT(CASE WHEN estatus = 'Moroso' THEN 1 END),
        COUNT(CASE WHEN estatus = 'Solvente' THEN 1 END)
    INTO v_morosos_count_multas, v_solventes_count_multas
    FROM estatus_productor_multas(p_nombre_sub, p_nombre_prod, p_fecha_consulta);

    SELECT 
        COUNT(CASE WHEN estatus = 'Moroso' THEN 1 END),
        COUNT(CASE WHEN estatus = 'Solvente' THEN 1 END)
    INTO v_morosos_count_comisiones, v_solventes_count_comisiones
    FROM estatus_productor_comisiones(p_nombre_sub, p_nombre_prod, p_fecha_consulta);

    -- Determina el estatus general
    IF v_morosos_count_multas > 0 OR v_morosos_count_comisiones > 0 THEN
        v_estatus_general := 'Moroso';
    ELSE
        v_estatus_general := 'Solvente';
    END IF;

    v_mensaje := 'El productor ' || p_nombre_prod || ' ante la subastadora ' || 
                 p_nombre_sub || ' en la fecha ' || p_fecha_consulta || 
                 ' tiene ' || v_morosos_count_multas || ' estados morosos por multas y ' || 
                 v_morosos_count_comisiones || ' estados morosos por comisiones. ' ||
                 ' El estatus general es: ' || v_estatus_general || '.';
    RAISE NOTICE '%', v_mensaje;
END;
$$ LANGUAGE plpgsql;

--RECOMENDADOR
CREATE OR REPLACE FUNCTION recomendar_flores(
	nombre_florist VARCHAR(40),
	colores_deseados VARCHAR(15)[],
	descripciones_significados VARCHAR(300)[]
)
RETURNS TABLE(nombre_propio_flor VARCHAR(40), nombre_comun_flor VARCHAR(40), genero_especie_flor VARCHAR(40), tamano_tallo_flor NUMERIC(5, 2), precio_flor NUMERIC(5,2)) AS $$
DECLARE
	flores flor[];
	flor flor;
    idflorist INT;
BEGIN
    -- Obtiene el id de la floristería
    SELECT f.id_floristeria INTO idflorist
    FROM floristerias f
    WHERE f.nombre_floristeria = nombre_florist;

	FOR flor IN
		SELECT cf.nombre as nombre_propio, fc.nombre_comun, fc.genero_especie, hp.tamano_tallo, hp.precio_unitario, 0 AS coincidencias
		FROM catalogos_floristerias cf
		JOIN flores_corte fc ON cf.id_flor_corte = fc.id_flor_corte
		JOIN historicos_precio hp ON cf.id_catalogo = hp.id_catalogo
		WHERE cf.id_floristeria = idflorist
		AND hp.fecha_final IS NULL
	LOOP
		IF colores_deseados IS NOT NULL AND array_length(colores_deseados, 1) > 0 THEN
			IF flor.nombre_propio IN (
				SELECT cf.nombre
				FROM enlaces e
				JOIN colores c ON e.codigo_color = c.codigo_color
				JOIN flores_corte fc ON e.id_flor_corte = fc.id_flor_corte
				JOIN catalogos_floristerias cf ON e.id_flor_corte = cf.id_flor_corte
				WHERE lower(c.nombre) in (SELECT lower(nombre) FROM unnest(colores_deseados) AS nombre)
                AND cf.id_floristeria = idflorist
			) THEN
				flor.coincidencias := flor.coincidencias + 1;
			END IF;
		END IF;
		IF descripciones_significados IS NOT NULL AND array_length(descripciones_significados, 1) > 0 THEN
			IF flor.nombre_propio IN (
				SELECT cf.nombre
				FROM enlaces e
				JOIN significados s ON e.id_significado = s.id_significado
				JOIN flores_corte fc ON e.id_flor_corte = fc.id_flor_corte
				JOIN catalogos_floristerias cf ON e.id_flor_corte = cf.id_flor_corte
				WHERE lower(s.descripcion) in (SELECT lower(descripcion) FROM unnest(descripciones_significados) AS descripcion)
                AND cf.id_floristeria = idflorist
			) THEN
				flor.coincidencias := flor.coincidencias + 1;
			END IF;
		END IF;
		flores := flores || flor;
	END LOOP;

	-- Si hay coincidencias, se retornan las flores ordenadas por coincidencias.

	RETURN QUERY SELECT nombre_propio as nombre_propio_flor, nombre_comun as nombre_comun_flor, genero_especie as genero_especie_flor, tamano_tallo as tamano_tallo_flor, precio as precio_flor
	FROM unnest(flores) AS f
	WHERE f.coincidencias > 0
	ORDER BY f.coincidencias DESC;

	-- Si no hay coincidencias, se retornan todas las flores de la floristería en orden aleatorio.

	IF NOT FOUND THEN
		RETURN QUERY SELECT nombre_propio as nombre_propio_flor, nombre_comun as nombre_comun_flor, genero_especie as genero_especie_flor, tamano_tallo as tamano_tallo_flor, precio as precio_flor
		FROM unnest(flores) AS f
        ORDER BY random();
	END IF;
END;
$$ LANGUAGE plpgsql;

--TRIGGERS Y PROGRAMAS ALMACENADOS FIN

--INSERTS INICIO
INSERT INTO paises (nombre_pais) VALUES 
('Holanda'),
('Ecuador'),
('Alemania'),
('Estados Unidos'),
('Inglaterra'),
('Colombia'),
('Mexico'),
('España'),
('Argentina')
;

INSERT INTO colores (codigo_color, nombre, descripcion) VALUES
('ca1b1b', 'Rojo', 'Color rojo brillante, asociado con la pasión y el amor.'),
('c5388b ', 'Rosa', 'Color rosa claro, a menudo relacionado con la dulzura y la ternura.'),
('ffffff', 'Blanco', 'Color blanco puro, simboliza la paz y la pureza.'),
('fbf500', 'Amarillo', 'Color amarillo brillante, asociado con la alegría y la felicidad.'),
('ffa500', 'Naranja', 'Color naranja vibrante, a menudo asociado con la energía y el entusiasmo.'),
('800080', 'Púrpura', 'Color púrpura, a menudo relacionado con la realeza y la sofisticación.'),
('a52a2a', 'Marrón', 'Color marrón, que evoca la tierra y la estabilidad.'),
('0000ff', 'Azul', 'Color azul brillante, asociado con la calma y la serenidad.'),
('e6e6fa', 'Lavanda', 'Color lavanda, suave y relajante, asociado con la tranquilidad.'),
('008000', 'Verde', 'Color verde, asociado con la naturaleza y el crecimiento.');
;

INSERT INTO flores_corte (nombre_comun, genero_especie, etimologia, tem_conservacion, colores) VALUES
('Rosa', 'Rosa spp.', 'La rosa lleva su nombre en honor a la diosa romana de la belleza. Cultivada en diversas culturas, simboliza amor y pasión, apreciada por su fragancia y belleza a lo largo de la historia.', 18.00, 'Presenta colores como rojo, rosa, blanco y amarillo. Cada color tiene matices y combinaciones. Las rosas rojas simbolizan amor profundo, mientras que las blancas representan pureza y las amarillas, alegría.'),
('Clavel', 'Dianthus caryophyllus', 'El clavel proviene del griego "dianthus", que significa "flor divina". Cultivada desde la antigüedad, es valorada por su belleza y durabilidad, siendo un símbolo de amor y admiración en muchas culturas.', 14.00, 'Viene en colores como rojo, rosa, blanco y amarillo. Cada color tiene variaciones. Los claveles rojos simbolizan amor profundo, los blancos son un signo de pureza y gratitud, y los amarillos, desprecio.'),
('Lirio', 'Lilium spp.', 'El lirio proviene del latín "lilium", que significa "lirio". Esta flor ha sido venerada en muchas culturas, simbolizando pureza y renacimiento, y se asocia frecuentemente con la Virgen María en el arte.', 10.00, 'Se presenta en colores como blanco, amarillo, naranja y rojo. Cada flor puede tener un solo color o patrones. Los lirios blancos simbolizan inocencia, mientras que los rojos representan amor y pasión.'),
('Tulipán', 'Tulipa spp.', 'El tulipán deriva del turco "tülbent", que significa "turbante". Esta flor se ha convertido en un símbolo de elegancia, destacándose en jardines y arreglos florales, simbolizando amor perfecto.', 12.00, 'Viene en colores como rojo, amarillo, rosa y púrpura, a menudo mostrando combinaciones. Los rojos simbolizan amor verdadero, mientras que los amarillos representan alegría, cada uno con su propio atractivo.'),
('Girasol', 'Helianthus annuus', 'El nombre girasol proviene del griego "helios" (sol) y "anthos" (flor). Con su forma que sigue al sol, simboliza adoración y lealtad, siendo un emblema de energía y alegría en jardines.', 20.00, 'Predominantemente amarillo, con un centro marrón que añade contraste. Algunas variedades son naranjas, aportando un toque vibrante. Los girasoles son conocidos por atraer la atención y transmitir felicidad.'),
('Margarita', 'Bellis perennis', 'La margarita proviene del latín "bellus", que significa "hermoso". Esta flor simboliza inocencia y pureza, siendo apreciada por su simplicidad y encanto en jardines y arreglos florales.', 15.00, 'Comúnmente blancas con un centro amarillo, aunque hay variedades en tonos rosados y amarillos. Cada color aporta un matiz especial, simbolizando alegría y esperanza en diversas decoraciones florales.'),
('Freesia', 'Freesia spp.', 'La freesia fue nombrada en honor al botánico alemán Friedrich Freese. Conocida por su fragancia dulce, simboliza amistad y confianza, siendo popular en arreglos florales por su belleza.', 15.00, 'Presenta colores como amarillo, blanco, rosa y lavanda. A menudo tienen tonos combinados, lo que las hace aún más atractivas. Su diversidad de colores y fragancia las convierte en favoritas en decoraciones.'),
('Hortensia', 'Hydrangea macrophylla', 'El nombre hortensia proviene del griego "hydor" (agua) y "angeion" (recipiente). Con grandes cabezas florales, estas flores cambian de color según el pH del suelo, simbolizando versatilidad.', 20.00, 'Pueden ser azules, rosas o blancas, dependiendo de la acidez del suelo. Su colorido vibrante las hace populares en decoraciones. Azules simbolizan comprensión, rosas amor y blancas pureza en jardines.'),
('Crisantemo', 'Chrysanthemum morifolium', 'Proviene del griego "chrysos" (oro) y "anthemon" (flor). Venerada en muchas culturas, especialmente en Asia, simboliza longevidad y felicidad, siendo parte de diversas tradiciones.', 16.00, 'Viene en colores diversos como amarillo, blanco, rosa y púrpura. Cada color tiene sus variaciones y simbolismos, aportando rica diversidad a arreglos florales y celebraciones en muchas culturas.')
;

INSERT INTO significados (tipo, descripcion) VALUES
('sent', 'amor'),
('sent', 'pasión'),
('sent', 'alegría'),
('sent', 'dulzura'),
('sent', 'serenidad'),
('sent', 'pureza'),
('sent', 'entusiasmo'),
('sent', 'gratitud'),
('sent', 'esperanza'),
('sent', 'nostalgia'),
('ocas', 'aniversario'),
('ocas', 'cortejo'),
('ocas', 'cumpleaños'),
('ocas', 'felicitaciones'),
('ocas', 'dia de la madre'),
('ocas', 'funeral'),
('ocas', 'graduacion'),
('ocas', 'matrimonio'),
('ocas', 'consuelo')
;

INSERT INTO subastadoras (nombre_sub, id_pais, url_imagen) VALUES 
('VGB Flowers', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://www.vgb.nl/files/logo.png'),
('Royal FloraHolland', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSldh0qE2r5VrLUPAR8AfXJqdzZWF02_gc5Ag&s'),
('Borst Bloembollen', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://borstbloembollen.nl/wp-content/uploads/2020/09/BorstBloembollen-1x1-1.jpg')
;

INSERT INTO productores (nombre_prod, pagweb_prod, id_pais, url_imagen) VALUES 
('Flor Ecuador', 'florecuador.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Ecuador'),'https://everbloomroses.com/wp-content/uploads/2021/03/Logo-colores-1024x738.png'),
('Dutch Flower Group', 'dutchflowergroup.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/012023/dutch_flower_group.png?LOC6P60HFzYitYuX7hcEO0dxJQTArFu0&itok=yMVHa8Ps'),
('Kordes Roses', 'kordesroses.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Alemania'), 'https://www.garten-schlueter.de/media/image/ab/a3/3f/99_Manufacturer.jpg')
;

INSERT INTO floristerias (nombre_floristeria, pagweb_floristeria, telefono_floristeria, email_floristeria, id_pais, url_imagen) VALUES 
('Fleura Metz', 'fleura.com', '1234567890', 'info@fleura.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Estados Unidos'), 'https://play-lh.googleusercontent.com/mAttURxzmRPVodxxeHdacFBjLcfoKd9Grri22J7RuiJUcUoTjOY6mHTMo2qXVUicJoI'),
('Interflora', 'interflora.co.uk', '0987654321', 'contact@interflora.co.uk', (SELECT id_pais FROM paises WHERE nombre_pais = 'Inglaterra'), 'https://descuentos.abc.es/static/shop/10354/logo/C%C3%B3digo_descuento_Interflora_-_Logo_.png'),
('Floreria San Telmo', 'santelmo.com', '1122334455', 'info@santelmo.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Argentina'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwrHmxgzykj32vJwbtX6c1oT9QkAzZNBOJJg&s'),
('Sunshine Bouquets', 'sunshinebouquets.com', '2233445566', 'info@sunshinebouquets.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Colombia'), 'https://media.licdn.com/dms/image/v2/C4D0BAQFn9Mo7DknFMA/company-logo_200_200/company-logo_200_200/0/1630525340234/sunshinebouquetcompany_logo?e=2147483647&v=beta&t=70V5QV2dC26SFYEbXC00S6PpqP8t9tmf_NZEW4Uw1tE'),
('Les Fleurs', 'lesfleurs.mx', '3344556677', 'info@lesfleurs.mx', (SELECT id_pais FROM paises WHERE nombre_pais = 'Mexico'), 'https://lesfleurs.com.mx/cdn/shop/files/Logo-oro-_1_1_50396ee2-c96e-4036-bad6-6a45b4c9edcc_1080x.png?v=1675447413'),
('FloraQueen', 'floraqueen.com', '4455667788', 'info@floraqueen.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'España'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7lmYXbDsX4bKXIDA_RZTiOyAaMwIhAfdynQ&s')
;

INSERT INTO contactos_empleados (id_floristeria, primer_nombre_rep, primer_apellido, seg_apellido, doc_id_rep, telef_rep) VALUES
(1, 'John', 'Smith', 'Doe', 123456789, '001234567890'),  -- USA
(2, 'Emma', 'Johnson', 'Williams', 234567890, '004412345678'),  -- England
(3, 'Carlos', 'González', 'Pérez', 345678901, '01123456789'),  -- Argentina
(4, 'Ana', 'Torres', 'Martínez', 456789012, '005712345678'),  -- Colombia
(5, 'Luis', 'Hernández', 'Díaz', 567890123, '005212345678'),  -- Mexico
(6, 'Laura', 'Jiménez', 'Cruz', 678901234, '0034912345678'),  -- Spain
(2, 'Peter', 'Brown', 'Jones', 789012345, '004412345679'),  -- England
(4, 'Sofía', 'Rojas', 'Torres', 890123456, '005712345679'),  -- Colombia
(6, 'Javier', 'Salinas', 'Paredes', 901234567, '0034912345679'),  -- Spain
(1, 'Isabel', 'Mendoza', 'López', 987654321, '001234567891')  -- USA
;

INSERT INTO enlaces (id_significado, descripcion, id_flor_corte, codigo_color) VALUES
(1, 'rosas rojas', 1, 'ca1b1b'),  
(1, 'rosas blancas', 1, 'ffffff'),  
(2, 'claveles rosas', 2, 'c5388b'),  
(5, 'lirios blancos', 3, 'ffffff'),  
(7, 'tulipanes rojos', 4, 'ca1b1b'),  
(8, 'girasoles amarillos', 5, 'fbf500'),  
(8, 'girasoles naranjas', 5, 'ffa500'), 
(9, 'margaritas amarillas', 6, 'fbf500'), 
(10, 'freesias lavanda', 7, 'e6e6fa')
;

INSERT INTO catalogos_productores (id_productor, vbn, nombre_propio, descripcion, id_flor, codigo_color) VALUES
(1, 101705, 'Velvet Rose', 'Símbolo eterno del amor y la pasión, cautiva con su belleza intensa y fragancia dulce', 1, 'ca1b1b'), -- Rosa, color rojo, catalogo de rosas del productor 1
(1, 102940, 'Aurora Rose', 'Símbolo de lo imposible y lo misterioso, fascina con su color único y enigmático', 1, '0000ff'), -- Rosa, color azul, catalogo de rosas del productor 1

(1, 101818, 'Joy', 'Símbolo de alegría y optimismo, irradia energía y luz', 5, 'fbf500'), -- Girasol, color amarillo, catalogo de girasoles del productor 1
(1, 105986, 'Garden Oasis', 'Con su tono cálido y terroso, evoca la rusticidad y la conexión con la naturaleza', 5, 'a52a2a'), -- Girasol, color marron, catalogo de girasoles del productor 1

(2, 100603, 'Sunny', 'Símbolo de alegría y amistad, destaca por su brillo radiante y su simplicidad encantadora', 6, 'fbf500'), -- Margarita, color amarillo, catalogo de margaritas del productor 2
(2, 102210, 'Daring Delight', 'Símbolo de pureza y inocencia, cautiva con su delicadeza y frescura', 6, 'ffffff'), -- Margarita, color blanco, catalogo de margaritas del productor 2

(2, 102603, 'Luna', 'Con su vibrante color y forma exuberante, simboliza la gratitud y la comprensión', 8, '0000ff'), -- Hortensia, color azul, catalogo de hortensias del productor 2
(2, 102004, 'Celestial Bloom', 'Con su suave tono morado y fragancia sutil, evoca serenidad y encanto', 8, 'e6e6fa'), -- Hortensia, color lavanda, catalogo de hortensias del productor 2

(3, 102706, 'Berry Blush', 'Símbolo de amor y admiración, destaca por su delicada belleza y fragancia dulce', 2, 'c5388b'), -- Clavel, color rosa, catalogo de claveles del productor 3
(3, 102412, 'Sunshine Sorbet', 'Símbolo de amistad y alegría, resplandece con su vibrante color y forma elegante', 2, 'fbf500'), -- Clavel, color amarillo, catalogo de claveles del prodcutor 3

(3, 102205, 'Scarlet', 'Con su brillante color y forma elegante, simboliza la energía y la alegría', 4, 'ffa500'), -- Tulipán, color naranja, catalogo de tulipanes del pruductor 3
(3, 101402, 'Floral Breeze', 'Símbolo de nobleza y misterio, cautiva con su profundo color y elegancia', 4, '800080') -- Tulipan, color purpura, catalogo de tulipanes del productor 3
;

INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(3, 2, '2022-12-12', 'CC', 18.00, 'SI', NULL ), --Productor 2 con Subastador 3, cancelado
(1, 1, '2023-01-15', 'CB', 35.00, 'SI', NULL), -- Productor 1 con Subastador 1, cancelado

(2, 1, '2023-06-15', 'CA', 65.00, 'NO', NULL ), -- Productor 1 con Subastador 2, vencido
(2, 3, '2023-05-17', 'CG', 30.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, vencido

(1, 3, '2023-12-18', 'CG', 15.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, valido 
(2, 1, '2024-06-16', 'CA', 60.00, 'NO', 3), -- Productor 1 con Subastador 2,  valido
(2, 2, '2024-06-16', 'KA', 100.00, 'NO', NULL), -- Productor 2 con Subastador 2, ofrece el 100% aca, valido
(3, 3, '2024-09-24', 'CG', 20.00, 'NO', NULL), -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
(2, 3, '2024-05-18', 'CG', 30.00, 'NO', 4) -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
;

INSERT INTO det_contratos (id_sub, id_prod, id_contrato, vbn, cantidad) VALUES
(3, 2, 1, 100603, 1000), --Productor 2 ofreciendo su Catalogo de Margaritas Sunny a Subastador 3, relacion en contrato 1 cancelado

(1, 1, 2, 101705, 1500), --Productor 1 ofreciendo su Catalogo de Rosas Velvet Rose a Subastador 1, relacion en contrato 2 cancelado

(2, 1, 3, 102940, 800), --Productor 1 ofreciendo su Catalogo de Rosas Aurora Rose a Subastador 2, relacion en contrato 3 vencido

(2, 3, 4, 102706, 850), --Productor 3 ofreciendo su catalogo de Claveles Berry Blush a Subastador 2, relacion en contrato 4 vencido 
(2, 3, 4, 102412, 700), --Productor 3 ofreciendo su catalogo de Claveles Sunshine Sorbet a Subastador 2, relacion en contrato 4 vencido 

(1, 3, 5, 102205, 600), --Productor 3 ofreciendo su catalogo de Tulipanes Scarlet a Subastador 1, relacion en contrato 5 valido
(1, 3, 5, 101402, 1200), --Productor 3 ofreciendo su catalogo de Tulipanes Floral Breeze a Subastador 1, relacion en contrato 5 valido

(2, 1, 6, 101705, 1350), --Productor 1 ofreciendo su catalogo de Rosas Velvet Rose a Subastador 2, relacion en contrato 6 valido
(2, 1, 6, 102940, 1350), --Productor 1 ofreciendo su catalogo de Rosas Aurora Rose a Subastador 2, relacion en contrato 6 valido
(2, 1, 6, 101818, 1600), --Productor 1 ofreciendo su catalogo de Girasoles Joy a Subastador 2, relacion en contrato 6 valido
(2, 1, 6, 105986, 1600), --Productor 1 ofreciendo su catalogo de Girasoles Garden Oasis a Subastador 2, relacion en contrato 6 valido

(2, 2, 7, 100603, 2000), --Productor 2 ofreciendo su catalogo de Margaritas Sunny a Subastador 2, relacion en contrato 7 valido
(2, 2, 7, 102210, 2000), --Productor 2 ofreciendo su catalogo de Margaritas Daring Delight a Subastador 2, relacion en contrato 7 valido
(2, 2, 7, 102603, 1700), --Productor 2 ofreciendo su catalogo de Hortensias Luna a Subastador 2, relacion en contrato 7 valido
(2, 2, 7, 102004, 1700), --Productor 2 ofreciendo su catalogo de Hortensias Celestial Bloom a Subastador 2, relacion en contrato 7 valido

(3, 3, 8, 102706, 850), --Productor 3 ofreciendo su catalogo de Claveles Berry Blush a Subastador 3, relacion en contrato 8 valido
(3, 3, 8, 102412, 850), --Productor 3 ofreciendo su catalogo de Claveles Sunshine Sorbet a Subastador 3, relacion en contrato 8 valido

(2, 3, 9, 102205, 600), --Productor 3 ofreciendo su catalogo de Tulipanes Scarlet a Subastador 2, relacion en contrato 9 valido
(2, 3, 9, 101402, 600) --Productor 3 ofreciendo su catalogo de Tulipanes Floral Breeze a Subastador 2, relacion en contrato 9 valido
;

INSERT INTO afiliacion (id_sub, id_floristeria) VALUES
(1, 1), --Subastadora 1 con Floristeria 1
(1, 3), --Subastadora 1  con Floristeria 3
(1, 5), --Subastadora 1 con Floristeria 5
(2, 2), --Subastadora 2 con Floristeria 2
(2, 4), --Subastadora 2 con Floristeria 4
(2, 6), --Subastadora 2 con Floristeria 6
(3, 1), --Subastadora 3 con Floristeria 1
(3, 2), --Subastadora 3 con Floristeria 2
(3, 3), --Subastadora 3 con Floristeria 3
(3, 4) --Subastadora 3 con Floristeria 4 
;

INSERT INTO facturas_subastas (num_factura, fecha_emision, total, id_sub, id_floristeria, envio) VALUES
(20241016, '2024-10-15', 440, 3 , 1, 'SI'), --Factura Subastadora 3 a Floristeria 1
(20241017, '2024-04-01', 700, 1, 3, 'NO'), --Factura Subastadora 1 a Floristeria 3
(20241018, '2024-05-10', 770, 1, 5 , 'SI'), --Factura Subastadora 1 a Floristeria 5
(20241019, '2024-06-17', 800, 2, 2, 'NO'), --Factura Subastadora 2 a Floristeria 2
(20241020, '2024-11-01', 715, 3, 4 , 'SI'), --Factura Subastadora 3 a Floristeria 4
(20241021, '2024-07-19', 550, 2, 6 , 'SI'), --Factura Subastadora 2 a Floristeria 6

(20241022, '2024-06-03', 1200, 1, 5, 'NO'), --Factura Subastadora 1 a Floristeria 5
(20241023, '2024-06-18', 1100, 2, 2, 'SI'), --Factura Subastadora 2 a Floristeria 2
(20241024, '2024-06-27', 800, 1, 1 , 'NO'), --Factura Subastadora 1 a Floristeria 1
(20241025, '2024-11-10', 880, 3, 4 , 'SI'), --Factura Subastadora 3 a Floristeria 4
(20241026, '2024-09-28', 500, 3, 3, 'NO'), --Factura Subastadora 3 a Floristeria 3
(20241027, '2024-11-25', 1210, 2, 6, 'SI') --Factura Subastadora 2 a Floristeria 6
;

INSERT INTO lotes_flor (cantidad, precio_inicial, BI, precio_final, id_sub, id_prod, id_contrato, vbn, num_factura) VALUES
-- Lotes para la Factura 20241016
(100, 50.00, 0.70, 200, 3, 3, 8, 102706, 20241016),  
(200, 40.00, 0.80, 200, 3, 3, 8, 102706, 20241016),  

--Lotes para la Factura 20241017
(150, 40.00, 0.85, 300, 1, 3, 5, 102205, 20241017),  
(200, 60.00, 0.90, 400, 1, 3, 5, 102205, 20241017),  

--Lotes para la Factura 20241018
(300, 50.00, 0.75, 300, 1, 3, 5, 102205, 20241018),  
(400, 70.00, 0.60, 400, 1, 3, 5, 101402, 20241018),  

--Lotes para la Factura 20241019
(280, 40.00, 0.90, 400, 2, 1, 6, 101705, 20241019),  
(120, 30.00, 0.95, 400, 2, 1, 6, 101818, 20241019),  

--Lotes para la Factura 20241020
(400, 50.00, 0.70, 200, 3, 3, 8, 102706, 20241020),  
(450, 60.00, 0.80, 450, 3, 3, 8, 102706, 20241020),  

--Lotes para la Factura 20241021
(300, 40.00, 0.85, 200, 2, 2, 7, 102603, 20241021), 
(400, 60.00, 0.90, 300, 2, 1, 6, 105986, 20241021),  

--Lotes para la Factura 20241022
(500, 50.00, 0.95, 700, 1, 3, 5, 102205, 20241022),  
(700, 60.00, 0.85, 500, 1, 3, 5, 101402, 20241022),  

--Lotes para la Factura 20241023
(550, 40.00, 0.75, 400, 2, 2, 7, 102210, 20241023),  
(600, 50.00, 0.80, 600, 2, 2, 7, 102603, 20241023),  

--Lotes para la Factura 20241024
(300, 60.00, 0.70, 450, 1, 3, 5, 101402, 20241024),  
(550, 55.00, 0.68, 350, 1, 3, 5, 101402, 20241024),  

--Lotes para la Factura 20241025
(350, 70.00, 0.75, 350, 3, 3, 8, 102412, 20241025),  
(300, 75.00, 0.80, 400, 3, 3, 8, 102412, 20241025),  

--Lotes para la Factura 20241026
(200, 40.00, 0.85, 200, 3, 3, 8, 102706, 20241026),  
(300, 60.00, 0.90, 300, 3, 3, 8, 102412, 20241026),

--Lotes para la Factura 20241027
(600, 50.00, 0.95, 700, 2, 1, 6, 102940, 20241027),  
(400, 60.00, 0.85, 300, 2, 3, 9, 101402, 20241027)
;

INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo) VALUES
(1, 3, 5, '2024-05-01', 'COM'),
(1, 3, 5, '2024-06-01', 'COM'),
(1, 3, 5, '2024-07-01', 'COM'),

(2, 1, 6, '2024-07-06', 'COM'), 
(2, 1, 6, '2024-08-04', 'COM'),
(2, 1, 6, '2024-12-06', 'COM'),

(2, 2, 7, '2024-07-05', 'COM'),
(2, 2, 7, '2024-08-05', 'COM'),

(3, 3, 8, '2024-10-05', 'COM'),  
(3, 3, 8, '2024-11-05', 'COM'),  
(3, 3, 8, '2024-12-05', 'COM'),  

(2, 3, 9, '2024-12-08', 'COM')  
;

INSERT INTO catalogos_floristerias (id_floristeria, nombre, id_flor_corte, codigo_color) VALUES
(1, 'Radiant Carnation', 2, 'c5388b'), --Clavel Rosado de la Floristeria 1
(1, 'Brilliant Tulip', 4, '800080'), --Tulipan Purpura de la Floristeria 1

(2, 'Darling Rose', 1,'ca1b1b'), --Rosa Roja de la Floristeria 2
(2,'Summer Sunflower', 5,'fbf500'), --Girasol Amarillo de la Floristeria 2
(2, 'Joyful Daisy', 6,'ffffff'), --Margarita Blanca de la Floristeria 2
(2, 'Magical Hydrangea', 8,'0000ff'), --Hortensia Azul de la Floristeria 2

(3, 'Radiant Tulip', 4,'ffa500'), --Tulipan Naranja de la Floristeria 3
(3, 'Charming Carnation', 2,'c5388b'), -- Clavel Rosa de la Floristeria 3
(3, 'Golden Carnation', 2,'fbf500'), --Clavel Amarillo de la Floristeria 3

(4, 'Blushing Carnation' , 2,'c5388b'), --Clavel Rosa de la Floristeria 4
(4, 'Blinding Carnation', 2,'fbf500'), --Clavel Amarillo de la Floristeria 4

(5,'Vibrant Tulip', 4,'ffa500'), --Tulipan Naranja de la Floristeria 5
(5, 'Serenity Tulip', 4,'800080'), --Tulipan Purpura de la Floristeria 5

(6, 'Aqua Hydrangea', 8,'0000ff'), --Hortensia azul de la Floristeria 6
(6, 'Mistery Sunflower', 5,'a52a2a') --Girasol Marron de la Floristeria 6
;

INSERT INTO historicos_precio (id_floristeria, id_catalogo, fecha_inicio, precio_unitario, tamano_tallo, fecha_final) VALUES
-- Radiant Carnation de 50cm
(1, 1, '2024-01-01 08:00:00', 1.20, 50.0, '2024-03-31 17:30:00'),  
(1, 1, '2024-04-01 09:15:00', 1.30, 50.0, NULL),           
-- Brilliant Tulip
(1, 2, '2024-01-15 10:00:00', 0.85, 45.0, '2024-03-15 14:45:00'), 
(1, 2, '2024-03-16 11:30:00', 1.00, 45.0, NULL),          
-- Darling Rose
(2, 3, '2024-01-10 12:00:00', 1.50, 60.0, '2024-04-10 16:00:00'), 
(2, 3, '2024-04-11 13:15:00', 1.60, 60.0, NULL),           
-- Summer Sunflower
(2, 4, '2024-02-01 14:30:00', 2.00, 70.0, '2024-05-01 19:00:00'),  
(2, 4, '2024-05-02 15:45:00', 2.30, 70.0, NULL),           
-- Joyful Daisy
(2, 5, '2024-01-20 16:00:00', 0.50, 30.0, '2024-03-20 20:15:00'),  
(2, 5, '2024-03-21 17:30:00', 0.65, 30.0, NULL),           
-- Magical Hydrangea
(2, 6, '2024-02-10 18:00:00', 2.30, 80.0, '2024-04-10 21:45:00'), 
(2, 6, '2024-04-11 19:15:00', 2.50, 80.0, NULL),           
-- Radiant Tulip
(3, 7, '2024-01-05 20:00:00', 0.90, 45.0, '2024-03-05 23:30:00'),
(3, 7, '2024-03-06 21:45:00', 1.00, 45.0, NULL),
-- Charming Carnation
(3, 8, '2024-01-15 22:00:00', 1.00, 50.0, '2024-04-15 10:00:00'),
(3, 8, '2024-04-16 23:15:00', 1.20, 50.0, NULL),
-- Golden Carnation
(3, 9, '2024-02-01 08:30:00', 1.10, 50.0, '2024-05-01 11:30:00'),
(3, 9, '2024-05-02 14:00:00', 1.15, 50.0, NULL),
-- Blushing Carnation
(4, 10, '2024-01-25 09:00:00', 1.00, 50.0, '2024-03-25 12:45:00'),
(4, 10, '2024-03-26 15:30:00', 1.25, 50.0, NULL),
-- Blinding Carnation
(4, 11, '2024-02-15 18:15:00', 0.95, 50.0, '2024-04-15 20:00:00'),
(4, 11, '2024-04-16 22:30:00', 1.00, 50.0, NULL),
-- Vibrant Tulip
(5, 12, '2024-01-30 07:45:00', 0.70, 45.0, '2024-03-30 09:30:00'),
(5, 12, '2024-03-31 11:00:00', 0.85, 45.0, NULL),
-- Serenity Tulip
(5, 13, '2024-02-20 13:00:00', 0.75, 45.0, '2024-05-20 15:15:00'),
(5, 13, '2024-05-21 17:45:00', 0.80, 45.0, NULL),
-- Aqua Hydrangea
(6, 14, '2024-02-05 19:00:00', 2.10, 80.0, '2024-04-05 20:30:00'),
(6, 14, '2024-04-06 22:00:00', 2.15, 80.0, NULL),
-- Mistery Sunflower
(6, 15, '2024-03-01 08:00:00', 1.15, 70.0, '2024-06-01 09:30:00'),
(6, 15, '2024-06-02 10:45:00', 1.20, 70.0, NULL);

INSERT INTO bouquets (id_floristeria, id_catalogo, cantidad, descripcion, tamano_tallo) VALUES
(1, 1, 20, 'Bouquet Radiant Carnations', 50),
(1, 1, 18, 'Bouquet Radiant Carnations', 30), 
(1, 2, 5, 'Bouquet Brilliant Tulips', 45),

(2, 3, 15, 'Bouquet Darling Roses', 60),
(2, 3, 19, 'Bouquet Darling Roses', 50), --
(2, 4, 10, 'Bouquet Summer Sunflowers', 70),
(2, 5, 20,'Bouquet Joyful Daisys', 30),
(2, 6, 15, 'Bouquet Magical Hydrangeas', 80),

(3, 7, 5, 'Bouquet Radiant Tulips', 45),
(3, 9, 10, 'Bouquet Golden Carnations', 50),

(4, 10, 15, 'Bouquet Blushing Carnations', 50 ),
(4, 11, 10, 'Bouquet Blinding Carnations', 55),

(5, 12, 25, 'Bouquet Vibrant Tulips', 45),
(5, 13, 30, 'Bouquet Serenity Tulips', 45),

(6, 14, 30, 'Bouquet Aqua Hydrangeas', 80),
(6, 15,  25, 'Bouquet Mistery Sunflowers', 70)
;

INSERT INTO clientes_natural_floristerias (num_cliente, doc_identidad, primer_nombre, primer_apellido, segundo_apellido) VALUES
(1, 12345678901, 'John', 'Doe', 'Smith'),          -- USA
(2, 23456789012, 'Jane', 'Smith', 'Johnson'),      -- USA
(3, 34567890123, 'Emily', 'Davis', 'Brown'),        -- Inglaterra
(4, 45678901234, 'Oliver', 'Jones', 'Taylor'),     -- Inglaterra
(5, 56789012345, 'Sofía', 'González', 'Martínez'),  -- Argentina
(6, 67890123456, 'Mateo', 'López', 'Fernández'),    -- Argentina
(7, 78901234567, 'Camila', 'Rodríguez', 'García'),  -- Colombia
(8, 89012345678, 'Juan', 'Pérez', 'Hernández'),     -- Colombia
(9, 90123456789, 'Luis', 'Martínez', 'Sánchez')     -- México
;

INSERT INTO clientes_compania_floristerias (num_empresa, nombre_empresa, razon_social) VALUES
(1, 'Event Solutions USA', 'Event Solutions LLC'),            -- USA
(2, 'Celebration Events Ltd.', 'Celebration Events Limited'),   -- Inglaterra
(3, 'Eventos Argentinos S.A.', 'Eventos Argentinos Sociedad Anónima'), -- Argentina
(4, 'Fiestas y Eventos Colombia S.A.S.', 'Fiestas y Eventos SAS'),       -- Colombia
(5, 'Mundo de Eventos México S.A. de C.V.', 'Mundo de Eventos S.A. de C.V.'), -- México
(6, 'Eventos España S.L.', 'Eventos España Sociedad Limitada'),       -- España
(7, 'Premier Event Planning', 'Premier Event Planning LLC'),      -- USA
(8, 'The Event Company', 'The Event Company Ltd.'),      -- Inglaterra
(9, 'Ramo de Eventos S.R.L.', 'Ramo de Eventos Sociedad de Responsabilidad Limitada') -- Argentina
;

INSERT INTO facturas_floristerias (id_floristeria, num_factura, fecha_emision, monto_total, num_cliente, num_empresa) VALUES
(1, 1001, '2024-01-10', 150.75, 2, NULL),
(1, 1002, '2024-01-15', 200.50, NULL, 1),

(2, 1003, '2024-01-20', 120.00, 3, NULL),
(2, 1004, '2024-01-25', 180.25, NULL, 8),

(3, 1005, '2024-02-01', 99.99, 6, NULL),
(3, 1006, '2024-02-05', 250.00, NULL, 3),

(4, 1007, '2024-02-10', 300.40, 7, NULL),
(4, 1008, '2024-02-15', 175.60, NULL, 4),

(5, 1009, '2024-02-20', 220.30, 9, NULL),
(5, 1010, '2024-02-25', 95.15, NULL, 5),

(6, 1011, '2024-12-01', 400, NULL, 6)
;

INSERT INTO det_facturas_floristerias (cantidad, id_floristeria, num_factura, id_catalogo, id_bouquet, subtotal, valor_calidad, valor_precio, promedio) VALUES
(1, 1, 1001, 1, NULL, 100.75, 4.5, 4.0, 4.25),  -- Detalle 1 para factura 1001
(1, 1, 1001, 2, NULL, 50.00, 4.0, 4.5, 4.25),   -- Detalle 2 para factura 1001

(1, 1, 1002, 1, 1, 150.50, 4.0, 4.5, 4.25),  -- Detalle 1 para factura 1002
(1, 1, 1002, 1, 2, 50.00, 4.0, 4.0, 4.00),   -- Detalle 2 para factura 1002

(1, 2, 1003, 3, NULL, 60.00, NULL, NULL, NULL),   -- Detalle 1 para factura 1003
(1, 2, 1003, 4, NULL, 60.00, 4.0, 4.0, 4.00),   -- Detalle 2 para factura 1003

(1, 2, 1004, 6, 8, 90.25, NULL, NULL, NULL),   -- Detalle 1 para factura 1004
(1, 2, 1004, 5, 7, 90.00, 4.0, 4.5, 4.25),   -- Detalle 2 para factura 1004

(1, 3, 1005, 7, NULL, 49.99, 3.0, 4.0, 3.50),   -- Detalle 1 para factura 1005
(1, 3, 1005, 8, NULL, 50.00, 3.5, 4.0, 3.75),  -- Detalle 2 para factura 1005

(1, 3, 1006, 9, 10, 250.00, 5.0, 5.0, 5.00), -- Detalle 1 para factura 1006

(1, 4, 1007, 10, NULL, 150.40, 4.0, 4.0, 4.00), -- Detalle 1 para factura 1007
(1, 4, 1007, 11, NULL, 150.00, 4.5, 4.5, 4.50), -- Detalle 2 para factura 1007

(1, 4, 1008, 10, 11, 100.60, 4.0, 4.0, 4.00), -- Detalle 1 para factura 1008
(1, 4, 1008, 11, 12, 75.00, 4.5, 4.5, 4.25),  -- Detalle 2 para factura 1008

(1, 5, 1009, 12, NULL, 110.30, 5.0, 5.0, 5.00), -- Detalle 1 para factura 1009
(1, 5, 1009, 13, NULL, 110.00, 4.0, 4.0, 4.00),  -- Detalle 2 para factura 1009

(1, 5, 1010, 12, 13, 80.00, 3.5, 4.0, 3.75),  -- Detalle 1 para factura 1010
(1, 5, 1010, 13, 14, 15.15, 4.0, 4.0, 4.00),  -- Detalle 2 para factura 1010

(1, 6, 1011, 14, NULL, 200.00, 5.0, 5.0, 5.00),  -- Detalle 1 para factura 1011
(1, 6, 1011, 14, NULL, 200.00, 5.0, 5.0, 5.00)  -- Detalle 2 para factura 1011
;
--INSERTS FIN

ALTER TABLE contratos DISABLE TRIGGER trigger_validar_renovacion;

--QUERYS PARA REPORTES INICIO

--Reporte Catalogo de Productor. Nivel 1.
--Query para obtener todos los catalogos de un productor
SELECT DISTINCT
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais, 
    f.genero_especie AS tipo_flor_corte
FROM 
    productores p
JOIN 
    catalogos_productores cp ON p.id_prod = cp.id_productor
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    paises pa ON p.id_pais = pa.id_pais  
WHERE 
    LOWER(p.nombre_prod) = LOWER($P{nombreProductor})  
ORDER BY 
    f.genero_especie;

--Subreporte #1 Catalogo de Productor. Nivel 2.
--Query para obtener las flores de un catalogo con su vbn
SELECT 
    cp.nombre_propio AS nombre_flor,
    cp.vbn AS vbn_flor,
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais,  
    UPPER(f.nombre_comun) AS tipo_flor_corte
FROM 
    catalogos_productores cp
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    productores p ON cp.id_productor = p.id_prod
 JOIN 
    paises pa ON p.id_pais = pa.id_pais
WHERE 
    f.nombre_comun = $P{tipo_flor_corte} 
    AND  LOWER(p.nombre_prod) = LOWER($P{nombre_productor}) 
ORDER BY 
    cp.nombre_propio;

--Subreporte #2 Catalogo de Productor. Nivel 3.
--Query para obtener los detalles de una flor. 
SELECT 
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais,
    UPPER(f.nombre_comun) AS nombre_comun,
    f.genero_especie AS tipo_flor_corte,
    f.etimologia AS etimologia,
    f.tem_conservacion AS temperatura,
    f.colores AS colores,
    cp.nombre_propio AS nombre_propio
FROM 
    catalogos_productores cp
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    productores p ON cp.id_productor = p.id_prod
JOIN 
    paises pa ON p.id_pais = pa.id_pais
WHERE 
    cp.nombre_propio = $P{nombre_flor} 
    AND  LOWER(p.nombre_prod) = LOWER($P{nombre_productor}) 
ORDER BY 
    f.nombre_comun;

--Reporte Catalogo de Floristeria. Nivel 1.
--Query para obtener todas las floristerias
SELECT 
    f.nombre_floristeria,
    p.nombre_pais
FROM 
    floristerias f
JOIN 
    paises p ON f.id_pais = p.id_pais;

--Subreporte #1 Catalogo de Floristeria. Nivel 2.
--Query para obtener las flores disponibles en una floristeria con su valoracion
SELECT 
    f.nombre_floristeria,
    f.pagweb_floristeria,
    f.telefono_floristeria,
    f.email_floristeria,
    p.nombre_pais, 
    f.url_imagen,
    fc.nombre_comun AS nombre_flor,
    ROUND(AVG(d.promedio), 2) AS valoracion_promedio
FROM 
    catalogos_floristerias c
JOIN 
    flores_corte fc ON c.id_flor_corte = fc.id_flor_corte
LEFT JOIN 
    det_facturas_floristerias d ON c.id_floristeria = d.id_floristeria AND c.id_catalogo = d.id_catalogo
JOIN 
    floristerias f ON c.id_floristeria = f.id_floristeria
JOIN 
    paises p ON f.id_pais = p.id_pais 
WHERE 
    f.id_floristeria = (
        SELECT id_floristeria 
        FROM floristerias 
        WHERE nombre_floristeria = $P{nombre_floristeria} 
    )
GROUP BY 
    f.nombre_floristeria, 
    f.pagweb_floristeria,
    f.telefono_floristeria,
    f.email_floristeria,
    p.nombre_pais, 
    f.url_imagen,
    fc.nombre_comun
ORDER BY 
    CASE 
        WHEN AVG(d.promedio) IS NOT NULL THEN 0 
        ELSE 1 
    END,
    ROUND(AVG(d.promedio), 2) DESC,
    fc.nombre_comun ASC;

--Subreporte #2 Catalogo de Floristeria. Nivel 3. 
SELECT f.nombre_floristeria AS nombre_floristeria,
	f.email_floristeria AS email_floristera,
	p.nombre_pais AS pais,
	f.url_imagen AS logo_floristeria,
	fc.nombre_comun AS nombre_flor,
	cf.nombre AS nombre_catalogo_flor,
	fc.genero_especie AS categoria,
	c.codigo_color AS codigo_color,
	c.nombre AS color
FROM floristerias f
	JOIN paises p ON 
	 f.id_pais = p.id_pais 
	JOIN catalogos_floristerias cf ON 
	 f.id_floristeria = cf.id_floristeria 
	JOIN flores_corte fc ON 
	 cf.id_flor_corte = fc.id_flor_corte 
	JOIN colores c ON 
	 cf.codigo_color = c.codigo_color 
WHERE 
	 f.nombre_floristeria = $P{nombre_floristeria} 
	 AND fc.nombre_comun = $P{nombre_flor};

--Subreporte de Info Flores
SELECT 
    cf.nombre AS nombre_catalogo_flor,
    fc.nombre_comun AS nombre_flor,
    hp.precio_unitario AS precio_por_unidad,
    hp.tamano_tallo AS tamano_tallo_flor
FROM 
    historicos_precio hp
JOIN 
    catalogos_floristerias cf ON hp.id_floristeria = cf.id_floristeria 
                             AND hp.id_catalogo = cf.id_catalogo
JOIN 
    flores_corte fc ON cf.id_flor_corte = fc.id_flor_corte
JOIN 
    floristerias f ON cf.id_floristeria = f.id_floristeria
WHERE 
    hp.fecha_final IS NULL 
    AND f.nombre_floristeria = $P{nombre_floristeria} 
    AND fc.nombre_comun = $P{nombre_flor} 
    AND cf.nombre =  $P{nombre_catalogo_flor} 
ORDER BY 
    hp.tamano_tallo;

--Subreporte de info bouquets
SELECT 
    b.descripcion AS descripcion_bouquet,
    b.cantidad AS cantidad_flores,
    b.tamano_tallo AS tamano_tallo_bouquet,
    COALESCE(pv.total_precios_validos, 0) AS total_precios_validos
FROM 
    bouquets b
LEFT JOIN (
    SELECT 
        hp.id_floristeria,
        hp.id_catalogo,
        COUNT(*) AS total_precios_validos
    FROM 
        historicos_precio hp
    WHERE 
        hp.fecha_final IS NULL
    GROUP BY 
        hp.id_floristeria,
        hp.id_catalogo
) pv ON b.id_floristeria = pv.id_floristeria 
     AND b.id_catalogo = pv.id_catalogo
JOIN 
    catalogos_floristerias cf ON b.id_floristeria = cf.id_floristeria 
                             AND b.id_catalogo = cf.id_catalogo
JOIN 
    flores_corte fc ON cf.id_flor_corte = fc.id_flor_corte
JOIN 
    floristerias f ON cf.id_floristeria = f.id_floristeria
WHERE 
    f.nombre_floristeria = $P{nombre_floristeria} 
    AND fc.nombre_comun = $P{nombre_flor} 
    AND cf.nombre = $P{nombre_catalogo_flor} 
    AND COALESCE(pv.total_precios_validos, 0) > 0 
ORDER BY 
    b.descripcion;

--Reporte de Facturas de Subastas segun una floristeria y un intervalo dado
SELECT 
    l.id_lote AS id_lote,
    l.precio_final AS precio_lote,
    cp.nombre_propio AS nombre_flor_productor,
    fc.nombre_comun AS tipo_flor_corte,
    fs.num_factura AS num_factura,
    fs.fecha_emision AS fecha_factura,
    fs.total AS total_factura,
    f.nombre_floristeria AS nombre_cliente,
    f.telefono_floristeria AS telefono_cliente,
    f.email_floristeria AS email_cliente,
    s.url_imagen AS logo_subastador,
    s.nombre_sub AS nombre_subastador,
    pa_sub.nombre_pais AS pais_subastador,
    pa_flo.nombre_pais AS pais_cliente,
    CASE 
        WHEN fs.envio = 'SI' THEN fs.total * 0.10
        ELSE 0 
    END AS recargo,
    CASE 
        WHEN fs.envio = 'SI' THEN fs.total - (fs.total * 0.10)
        ELSE fs.total 
    END AS subtotal
FROM 
    lotes_flor l
JOIN 
    facturas_subastas fs ON l.num_factura = fs.num_factura
JOIN 
    floristerias f ON fs.id_floristeria = f.id_floristeria
JOIN 
    subastadoras s ON fs.id_sub = s.id_sub
JOIN 
    catalogos_productores cp ON l.id_prod = cp.id_productor AND l.vbn = cp.vbn
JOIN 
    flores_corte fc ON cp.id_flor = fc.id_flor_corte
JOIN 
    paises pa_sub ON s.id_pais = pa_sub.id_pais 
JOIN 
    paises pa_flo ON f.id_pais = pa_flo.id_pais
WHERE 
    LOWER(f.nombre_floristeria) = LOWER($P{nombre_floristeria})
    AND fs.fecha_emision BETWEEN $P{fecha_inicio} AND $P{fecha_fin}
ORDER BY 
    l.id_lote;
--QUERYS PARA REPORTES FIN
