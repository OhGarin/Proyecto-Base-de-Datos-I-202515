DROP SEQUENCE IF EXISTS seq_paises;
CREATE SEQUENCE seq_paises
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;
	
DROP SEQUENCE IF EXISTS seq_flores_corte;
CREATE SEQUENCE seq_flores_corte 
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;

DROP SEQUENCE IF EXISTS seq_significados;
CREATE SEQUENCE seq_significados
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 40;

DROP SEQUENCE IF EXISTS seq_subastadoras;
CREATE SEQUENCE seq_subastadoras
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 3;

DROP SEQUENCE IF EXISTS seq_productores;
CREATE SEQUENCE seq_productores
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 3;

DROP SEQUENCE IF EXISTS seq_floristerias;
CREATE SEQUENCE seq_floristerias
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 6;

DROP SEQUENCE IF EXISTS seq_contratos;
CREATE SEQUENCE seq_contratos
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;

DROP SEQUENCE IF EXISTS seq_pagos;
CREATE SEQUENCE seq_pagos
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 20;

DROP SEQUENCE IF EXISTS seq_contactos_emp;
CREATE SEQUENCE seq_contactos_emp
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;

DROP SEQUENCE IF EXISTS seq_enlace;
CREATE SEQUENCE seq_enlace
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 15;

DROP SEQUENCE IF EXISTS seq_catalogoprod;
CREATE SEQUENCE seq_catalogoprod
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;

DROP SEQUENCE IF EXISTS seq_lotes;
CREATE SEQUENCE seq_lotes
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 15;

DROP SEQUENCE IF EXISTS seq_catalogofloristeria;
CREATE SEQUENCE seq_catalogofloristeria
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 10;

DROP SEQUENCE IF EXISTS seq_bouquet;
CREATE SEQUENCE seq_bouquet
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 15;
