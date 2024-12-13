CREATE TABLE paises(	
	 id_pais SMALLINT DEFAULT nextval('seq_paises') CONSTRAINT pk_pais PRIMARY KEY,
 	 nombre_pais VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE colores(
	codigo_color VARCHAR(6) CONSTRAINT pk_colores PRIMARY KEY,
	nombre VARCHAR(15) NOT NULL UNIQUE,
	descripcion VARCHAR(300) NOT NULL
);

CREATE TABLE significados(
	id_significado SMALLINT DEFAULT nextval('seq_significados') CONSTRAINT pk_significados PRIMARY KEY,
	tipo VARCHAR(4) NOT NULL,
	descripcion VARCHAR(300) NOT NULL,
	CONSTRAINT check_tipo CHECK(tipo in('ocas','sent'))
);

CREATE TABLE flores_corte(
	id_flor_corte INT DEFAULT nextval('seq_flores_corte') CONSTRAINT pk_florcorte PRIMARY KEY,
	nombre_comun VARCHAR(40) NOT NULL UNIQUE,
	genero_especie VARCHAR(40) NOT NULL UNIQUE,
	etimologia VARCHAR(200) NOT NULL,
	tem_conservacion NUMERIC(4,2) NOT NULL,
	colores VARCHAR(200) NOT NULL
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

CREATE TABLE pagos_multas(
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT NOT NULL,
	id_pagos INT DEFAULT nextval('seq_pagos') NOT NULL,
	fecha_pago DATE NOT NULL,
	monto_euros FLOAT NOT NULL,
	tipo VARCHAR(3) NOT NULL,
	CONSTRAINT check_pagos CHECK(tipo in('MEM','MUL','COM')),
	CONSTRAINT pk_pagos PRIMARY KEY (id_sub,id_prod,id_contrato,id_pagos)
	--CONSTRAINT check_monto CHECK(monto_euros>0)
);

CREATE TABLE afiliacion(
	id_sub INT NOT NULL,
	id_floristeria INT NOT NULL,
	CONSTRAINT pk_afiliacion PRIMARY KEY(id_sub, id_floristeria)
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

CREATE TABLE det_contratos( 
	id_sub INT NOT NULL,
	id_prod INT NOT NULL,
	id_contrato INT NOT NULL,
	vbn INT NOT NULL,
	cantidad NUMERIC(4) NOT NULL,
	CONSTRAINT pk_det_contratos PRIMARY KEY (id_sub,id_prod,id_contrato,vbn)
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

