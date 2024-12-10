--EMPIEZAN QUERYS PARA REPORTE : CATALOGO DE PRODUCTOR

--Reporte. Nivel 1.
--Query para obtener todos los catalogos de un productor

--Por ID de productor. USADO.
SELECT DISTINCT
    p.nombre_prod AS nombre_productor,
    p.pagweb_prod AS pagina_web,
    p.url_imagen AS logo_imagen,
    pa.nombre_pais AS nombre_pais,  
    f.nombre_comun AS tipo_flor_corte
FROM 
    productores p
JOIN 
    catalogos_productores cp ON p.id_prod = cp.id_productor
JOIN 
    flores_corte f ON cp.id_flor = f.id_flor_corte
JOIN 
    paises pa ON p.id_pais = pa.id_pais  
WHERE 
   p.id_prod = $P{id_productor} 
ORDER BY 
    f.nombre_comun

--Por nombre de productor
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
    paises pa ON p.id_pais = pa.id_pais  -- JOIN adicional para obtener el nombre del país
WHERE 
    LOWER(p.nombre_prod) = LOWER($P{nombreProductor})  
ORDER BY 
    f.genero_especie;

--Subreporte #1. Nivel 2.
--Query para obtener las flores de un catalogo con su vbn

--Filtra por nombre comun de la flor. USADO
SELECT 
    cp.nombre_propio AS nombre_flor,
    cp.vbn AS vbn_flor,
 --   f.genero_especie AS tipo_flor_corte,
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
    AND p.id_prod = $P{id_productor}  
ORDER BY 
    cp.nombre_propio

--Subreporte #2. Nivel 3.
--Query para obtener los detalles de una flor. USADO

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
    AND p.id_prod = $P{id_productor}
ORDER BY 
    f.nombre_comun

--EMPIEZAN QUERYS PARA REPORTE : CATALOGO DE PRODUCTOR


