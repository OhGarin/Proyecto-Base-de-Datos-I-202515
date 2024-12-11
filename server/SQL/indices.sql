--INDICES PARA FACILITAR REPORTES DE CATALOGO DE PRODUCTOR

-- Índice para el nombre del productor en tabla de productores
CREATE INDEX idx_nombre_prod ON productores(nombre_prod);

-- Índice para el id_productor en catalogo productor
CREATE INDEX idx_id_productor ON catalogos_productores(id_productor);

-- Índice para el id_flor en catalogo_productor
CREATE INDEX idx_id_flor ON catalogos_productores(id_flor);

-- Índice para el genero_especie en tabla flores corte
CREATE INDEX idx_genero_especie ON flores_corte(genero_especie);

-- Índice compuesto para id_productor y id_flor en tabla catalago productor
CREATE INDEX idx_productor_flor ON catalogos_productores(id_productor, id_flor);