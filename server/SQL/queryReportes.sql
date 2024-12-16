--EMPIEZAN QUERYS PARA REPORTE : CATALOGO DE PRODUCTOR

--Reporte. Nivel 1.
--Query para obtener todos los catalogos de un productor

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
    paises pa ON p.id_pais = pa.id_pais  
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
    AND  LOWER(p.nombre_prod) = LOWER($P{nombre_productor}) 
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
    AND  LOWER(p.nombre_prod) = LOWER($P{nombre_productor}) 
ORDER BY 
    f.nombre_comun

--TERMINAS QUERYS PARA REPORTE : CATALOGO DE PRODUCTOR
--EMPIEZAN QUERYS PARA REPORTE : CATALOGO DE FLORISTERIA

--Reporte. Nivel 1.
--Query para obtener todas las floristerias
SELECT 
    f.nombre_floristeria,
    p.nombre_pais
FROM 
    floristerias f
JOIN 
    paises p ON f.id_pais = p.id_pais

--Subreporte 1. Nivel 2.
--Query para obtener las flores disponibles en una floristeria con su valoracion

--Version actual, perdi el viejo xd
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
    fc.nombre_comun ASC

--Subreporte 2. Nivel 3. 

--Version actual
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
	 AND fc.nombre_comun = $P{nombre_flor}

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
    hp.tamano_tallo

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


--Version por si acaso
SELECT 
    c.nombre AS nombre_flor_catalogo,
    fc.nombre_comun AS nombre_flor,
    c.codigo_color AS codigo_color,
    co.nombre AS color,
    fc.genero_especie AS tipo_flor,
    f.nombre_floristeria AS nombre_floristeria,
    p.nombre_pais AS pais_floristeria,
    f.email_floristeria AS email_floristeria,
    f.url_imagen AS logo_floristeria,
  STRING_AGG(DISTINCT CONCAT(
        COALESCE(CAST(hp.tamano_tallo AS TEXT), 'Tamaño no disponible'), 
        ' cm - $', 
        COALESCE(CAST(hp.precio_unitario AS TEXT), '0')), 
    E' \n') AS detalles_flor,
    STRING_AGG(DISTINCT CONCAT(b.cantidad, ' flores      -      ', b.tamano_tallo, ' cm'),  E' \n ') AS detalles_bouquets
FROM 
    catalogos_floristerias c
JOIN 
    flores_corte fc ON c.id_flor_corte = fc.id_flor_corte
JOIN 
    colores co ON c.codigo_color = co.codigo_color
JOIN 
    floristerias f ON c.id_floristeria = f.id_floristeria
JOIN 
    paises p ON f.id_pais = p.id_pais
LEFT JOIN 
    historicos_precio hp ON c.id_floristeria = hp.id_floristeria 
    AND c.id_catalogo = hp.id_catalogo 
    AND hp.fecha_final IS NULL  
LEFT JOIN 
    bouquets b ON c.id_floristeria = b.id_floristeria 
    AND c.id_catalogo = b.id_catalogo
WHERE 
    f.nombre_floristeria = 'Floreria San Telmo' 
    AND fc.nombre_comun = 'Clavel'
GROUP BY 
    c.nombre, 
    fc.nombre_comun, 
    c.codigo_color, 
    co.nombre, 
    fc.genero_especie, 
    f.nombre_floristeria, 
    p.nombre_pais, 
    f.email_floristeria, 
    f.url_imagen
ORDER BY 
    fc.nombre_comun


--TERMINAN QUERYS PARA : CATALOGO DE FLORISTERIA

--COMIENZAN QUERYS PARA REPORTE : FACTURAS EN SUBASTAS

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
    l.id_lote

--TERMINAN QUERYS PARA REPORTE : FACTURAS EN SUBASTAS
