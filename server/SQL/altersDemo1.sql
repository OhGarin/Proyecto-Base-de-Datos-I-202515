ALTER TABLE subastadoras
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE productores
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE floristerias
	ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais);

ALTER TABLE contratos 
	ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub);

ALTER TABLE contratos 
	ADD CONSTRAINT fk_prod FOREIGN KEY (id_prod) REFERENCES productores(id_prod);

ALTER TABLE pagos_multas
	ADD CONSTRAINT fk_contratos FOREIGN KEY (id_sub,id_prod,id_contrato) REFERENCES contratos(id_sub,id_prod,id_contrato);

ALTER TABLE afiliacion 
	ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub);

ALTER TABLE afiliacion 
	ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria);

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

ALTER TABLE det_contratos
	 ADD CONSTRAINT fk_contrato FOREIGN KEY (id_sub, id_prod, id_contrato) REFERENCES contratos(id_sub, id_prod, id_contrato);

ALTER TABLE det_contratos 
	ADD CONSTRAINT fk_cat_prod FOREIGN KEY (id_prod, vbn) REFERENCES catalogos_productores(id_productor, vbn);

ALTER TABLE facturas_subastas
	ADD CONSTRAINT fk_afiliacion FOREIGN KEY (id_sub, id_floristeria) REFERENCES afiliacion(id_sub, id_floristeria);

ALTER TABLE lotes_flor 
	ADD CONSTRAINT fk_detcontrato FOREIGN KEY (id_sub, id_prod, id_contrato, vbn) REFERENCES det_contratos(id_sub, id_prod, id_contrato, vbn);

ALTER TABLE lotes_flor 
	ADD CONSTRAINT fk_facturasubasta FOREIGN KEY (num_factura) REFERENCES facturas_subastas(num_factura);

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


--CON ON DELETE CASCADE POR SI ACASO 
ALTER TABLE subastadoras
    ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais) ON DELETE CASCADE;

ALTER TABLE productores
    ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais) ON DELETE CASCADE;

ALTER TABLE floristerias
    ADD CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES paises(id_pais) ON DELETE CASCADE;

ALTER TABLE contratos 
    ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub) ON DELETE CASCADE;

ALTER TABLE contratos 
    ADD CONSTRAINT fk_prod FOREIGN KEY (id_prod) REFERENCES productores(id_prod) ON DELETE CASCADE;

ALTER TABLE pagos_multas
    ADD CONSTRAINT fk_contratos FOREIGN KEY (id_sub,id_prod,id_contrato) REFERENCES contratos(id_sub,id_prod,id_contrato) ON DELETE CASCADE;

ALTER TABLE afiliacion 
    ADD CONSTRAINT fk_sub FOREIGN KEY (id_sub) REFERENCES subastadoras(id_sub) ON DELETE CASCADE;

ALTER TABLE afiliacion 
    ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria) ON DELETE CASCADE;

ALTER TABLE contactos_empleados 
    ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria) ON DELETE CASCADE;

ALTER TABLE enlaces 
    ADD CONSTRAINT fk_significado FOREIGN KEY (id_significado) REFERENCES significados(id_significado) ON DELETE CASCADE;

ALTER TABLE enlaces 
    ADD CONSTRAINT fk_flor_corte FOREIGN KEY (id_flor_corte) REFERENCES flores_corte(id_flor_corte) ON DELETE CASCADE;

ALTER TABLE enlaces     
    ADD CONSTRAINT fk_codigo_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color) ON DELETE CASCADE;

ALTER TABLE catalogos_productores 
    ADD CONSTRAINT fk_productor FOREIGN KEY (id_productor) REFERENCES productores(id_prod) ON DELETE CASCADE;

ALTER TABLE catalogos_productores 
    ADD CONSTRAINT fk_flor FOREIGN KEY (id_flor) REFERENCES flores_corte(id_flor_corte) ON DELETE CASCADE;

ALTER TABLE catalogos_productores 
    ADD CONSTRAINT fk_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color) ON DELETE CASCADE;

ALTER TABLE det_contratos
     ADD CONSTRAINT fk_contrato FOREIGN KEY (id_sub, id_prod, id_contrato) REFERENCES contratos(id_sub, id_prod, id_contrato) ON DELETE CASCADE;

ALTER TABLE det_contratos 
    ADD CONSTRAINT fk_cat_prod FOREIGN KEY (id_prod, vbn) REFERENCES catalogos_productores(id_productor, vbn) ON DELETE CASCADE;

ALTER TABLE facturas_subastas
    ADD CONSTRAINT fk_afiliacion FOREIGN KEY (id_sub, id_floristeria) REFERENCES afiliacion(id_sub, id_floristeria) ON DELETE CASCADE;

ALTER TABLE lotes_flor 
    ADD CONSTRAINT fk_detcontrato FOREIGN KEY (id_sub, id_prod, id_contrato, vbn) REFERENCES det_contratos(id_sub, id_prod, id_contrato, vbn) ON DELETE CASCADE;

ALTER TABLE lotes_flor 
    ADD CONSTRAINT fk_facturasubasta FOREIGN KEY (num_factura) REFERENCES facturas_subastas(num_factura) ON DELETE CASCADE;

ALTER TABLE catalogos_floristerias     
    ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria) ON DELETE CASCADE;

ALTER TABLE catalogos_floristerias 
    ADD CONSTRAINT fk_florcorte FOREIGN KEY (id_flor_corte) REFERENCES flores_corte(id_flor_corte) ON DELETE CASCADE;

ALTER TABLE catalogos_floristerias 
    ADD CONSTRAINT fk_color FOREIGN KEY (codigo_color) REFERENCES colores(codigo_color) ON DELETE CASCADE;
    
ALTER TABLE historicos_precio
    ADD CONSTRAINT fk_catalogo_floristeria FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria,id_catalogo) ON DELETE CASCADE;

ALTER TABLE bouquets
    ADD CONSTRAINT fk_catalogo FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria,id_catalogo) ON DELETE CASCADE;

ALTER TABLE facturas_floristerias
    ADD CONSTRAINT fk_floristeria FOREIGN KEY (id_floristeria) REFERENCES floristerias(id_floristeria) ON DELETE CASCADE;

ALTER TABLE facturas_floristerias
    ADD CONSTRAINT fk_num_cliente FOREIGN KEY (num_cliente) REFERENCES clientes_natural_floristerias(num_cliente) ON DELETE SET NULL;  

ALTER TABLE facturas_floristerias
    ADD CONSTRAINT fk_num_empresa FOREIGN KEY (num_empresa) REFERENCES clientes_compania_floristerias(num_empresa) ON DELETE SET NULL;  

ALTER TABLE det_facturas_floristerias
    ADD CONSTRAINT fk_factura FOREIGN KEY (id_floristeria, num_factura) REFERENCES facturas_floristerias(id_floristeria, num_factura) ON DELETE CASCADE;

ALTER TABLE det_facturas_floristerias
    ADD CONSTRAINT fk_catalogo_floristeria FOREIGN KEY (id_floristeria, id_catalogo) REFERENCES catalogos_floristerias(id_floristeria, id_catalogo);  

ALTER TABLE det_facturas_floristerias
    ADD CONSTRAINT fk_bouquet FOREIGN KEY (id_floristeria, id_catalogo, id_bouquet) REFERENCES bouquets(id_floristeria, id_catalogo, id_bouquet);  

--ALTERS DE SECUENCIAS 

ALTER SEQUENCE seq_paises RESTART WITH 1;
ALTER SEQUENCE seq_flores_corte RESTART WITH 1;
ALTER SEQUENCE seq_significados RESTART WITH 1;
ALTER SEQUENCE seq_subastadoras RESTART WITH 1;
ALTER SEQUENCE seq_productores RESTART WITH 1;
ALTER SEQUENCE seq_floristerias RESTART WITH 1;
ALTER SEQUENCE seq_contratos RESTART WITH 1;
ALTER SEQUENCE seq_pagos RESTART WITH 1;
ALTER SEQUENCE seq_contactos_emp RESTART WITH 1;
ALTER SEQUENCE seq_enlace RESTART WITH 1;
ALTER SEQUENCE seq_catalogoprod RESTART WITH 1;
ALTER SEQUENCE seq_lotes RESTART WITH 1;
ALTER SEQUENCE seq_catalogofloristeria RESTART WITH 1;
ALTER SEQUENCE seq_bouquet RESTART WITH 1;
ALTER SEQUENCE seq_detfacturas_floristeria RESTART WITH 1;