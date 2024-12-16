--Vista para Obtener Todos los Catálogos de un Productor
-- vista que incluye la fecha de inicio de la relación con la subastadora y el tipo de clasificación del productor.
CREATE OR REPLACE VIEW vista_catalogos_productor AS
SELECT DISTINCT
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais, 
    f.genero_especie AS tipo_flor_corte,
    c.fecha_contrato AS fecha_inicio_relacion,
    c.clasificacion AS clasificacion_productor
FROM 
    productores p
JOIN 
    catalogos_productores cp ON p.id_prod = cp.id_productor
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    paises pa ON p.id_pais = pa.id_pais
JOIN 
    contratos c ON c.id_prod = p.id_prod;



--Vista para Obtener Flores de un Catálogo con su VBN
CREATE OR REPLACE VIEW vista_flores_catalogo AS
SELECT 
    cp.nombre_propio AS nombre_flor,
    cp.vbn AS vbn_flor,
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais,  
    UPPER(f.nombre_comun) AS tipo_flor_corte,
    c.clasificacion AS clasificacion_productor
FROM 
    catalogos_productores cp
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    productores p ON cp.id_productor = p.id_prod
JOIN 
    paises pa ON p.id_pais = pa.id_pais
JOIN 
    contratos c ON c.id_prod = p.id_prod;


--Vista para Obtener Detalles de una Flor
CREATE OR REPLACE VIEW vista_detalles_flor AS
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
    cp.nombre_propio AS nombre_propio,
    s.descripcion AS significado
FROM 
    catalogos_productores cp
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    productores p ON cp.id_productor = p.id_prod
JOIN 
    paises pa ON p.id_pais = pa.id_pais
LEFT JOIN 
    enlaces e ON f.id_flor_corte = e.id_flor_corte  
LEFT JOIN 
    significados s ON e.id_significado = s.id_significado;  

--Vista para Obtener Facturas Subastas
--Vista para incluir información sobre el productor y el precio final de cada lote.
CREATE OR REPLACE VIEW vista_facturas_subastas AS
SELECT 
    l.id_lote AS id_lote,
    l.cantidad AS cantidad_lote,
    l.precio_final AS precio_lote,
    cp.nombre_propio AS nombre_flor_productor,
    fc.nombre_comun AS tipo_flor_corte,
    fs.num_factura AS num_fact,
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen
FROM 
    lotes_flor l  
JOIN 
    facturas_subastas fs ON l.num_factura = fs.num_factura
JOIN 
    catalogos_productores cp ON l.id_prod = cp.id_productor AND l.vbn = cp.vbn
JOIN 
    flores_corte fc ON cp.id_flor = fc.id_flor_corte
JOIN 
    productores p ON cp.id_productor = p.id_prod;
