--INSERTS DE PAISES
INSERT INTO paises (nombre_pais) VALUES 
('Holanda'),
('Ecuador'),
('Alemania'),
('Estados Unidos'),
('Inglaterra'),
('Colombia'),
('Mexico'),
('España'),
('Argentina');

--INSERTS DE FLORES DE CORTE

INSERT INTO flores_corte (nombre_comun, genero_especie, etimologia, tem_conservacion, colores) VALUES
('Rosa', 'Rosa spp.', 'Llamada así en honor a la diosa romana de la belleza.', 18.00, 'rojo, rosa, blanco, amarillo'),
('Clavel', 'Dianthus caryophyllus', 'El nombre proviene del griego "dianthus", que significa "flor divina".', 14.00, 'rojo, rosa, blanco, amarillo'),
('Lirio', 'Lilium spp.', 'Proviene del latín "lilium", que significa "lirio".', 10.00, 'blanco, amarillo, naranja, rojo'),
('Tulipán', 'Tulipa spp.', 'Deriva del turco "tülbent", que significa "turbante".', 12.00, 'rojo, amarillo, rosa, púrpura'),
('Girasol', 'Helianthus annuus', 'Su nombre proviene del griego "helios" (sol) y "anthos" (flor).', 20.00, 'amarillo, marrón, naranja'),
('Margarita', 'Bellis perennis', 'Su nombre proviene del latín "bellus", que significa "hermoso".', 15.00, 'blanco, amarillo'),
('Freesia', 'Freesia spp.', 'Nombrada en honor al botánico alemán Friedrich Freese.', 15.00, 'amarillo, blanco, rosa, lavanda'),
('Hortensia', 'Hydrangea macrophylla', 'El nombre proviene del griego "hydor" (agua) y "angeion" (recipiente).', 20.00, 'azul, rosa, blanco, púrpura'),
('Crisantemo', 'Chrysanthemum morifolium', 'Proviene del griego "chrysos" (oro) y "anthemon" (flor).', 16.00, 'amarillo, blanco, rosa, púrpura');

--INSERTS DE COLORES

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

--INSERTS DE SIGNIFICADOS

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
('ocas', 'consuelo');
--INSERTS DE SUBASTADORAS

INSERT INTO subastadoras (nombre_sub, id_pais) VALUES 
('VGB Flowers', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda')),
('Royal FloraHolland', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda')),
('Borst Bloembollen', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'));

--INSERTS DE PRODUCTORES
INSERT INTO productores (nombre_prod, pagweb_prod, id_pais) VALUES 
('Flor Ecuador', 'florecuador.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Ecuador')),
('Dutch Flower Group', 'dutchflowergroup.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda')),
('Kordes Roses', 'kordesroses.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Alemania'));

--INSERTS DE FLORISTERIAS

INSERT INTO floristerias (nombre_floristeria, pagweb_floristeria, telefono_floristeria, email_floristeria, id_pais) VALUES 
('Fleura Metz', 'fleura.com', '1234567890', 'info@fleura.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Estados Unidos')),
('Interflora', 'interflora.co.uk', '0987654321', 'contact@interflora.co.uk', (SELECT id_pais FROM paises WHERE nombre_pais = 'Inglaterra')),
('Floreria San Telmo', 'santelmo.com', '1122334455', 'info@santelmo.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Argentina')),
('Sunshine Bouquets', 'sunshinebouquets.com', '2233445566', 'info@sunshinebouquets.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Colombia')),
('Bouquet de Fleurs', 'bouquetdefleurs.mx', '3344556677', 'info@bouquetdefleurs.mx', (SELECT id_pais FROM paises WHERE nombre_pais = 'Mexico')),
('FloraQueen', 'floraqueen.com', '4455667788', 'info@floraqueen.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'España'));

--INSERTS DE CONTRATOS

INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(3, 2, '2022-12-12', 'CC', 18.00, 'SI', NULL ), --Productor 2 con Subastador 3, cancelado
(1, 1, '2023-01-15', 'CB', 35.00, 'SI', NULL), -- Productor 1 con Subastador 1, cancelado
;
INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(2, 1, '2023-01-15', 'CA', 65.00, 'NO', NULL ), -- Productor 1 con Subastador 2, vencido
(2, 3, '2023-05-17', 'CG', 30.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, vencido
;

INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(1, 3, '2023-12-29', 'CG', 15.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, valido SUBASTADORA 1
(2, 1, '2024-01-16', 'CA', 60.00, 'NO', 3), -- Productor 1 con Subastador 2,  valido 
(2, 2, '2024-01-16', 'KA', 100.00, 'NO', NULL), -- Productor 2 con Subastador 2, ofrece el 100% aca, valido
(3, 3, '2024-03-06', 'CG', 20.00, 'NO', NULL), -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
(2, 3, '2024-05-17', 'CG', 30.00, 'NO', 4) -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
;

--INSERTS DE PAGOS MULTAS 

INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo) VALUES
--Pagos de Membresias
(3, 2, 1, '2022-12-12', 'MEM'),
(1, 1, 2, '2023-01-15', 'MEM'),
(2, 1, 3, '2023-01-15', 'MEM' ),
(2, 3, 4, '2023-05-17', 'MEM'),
(1, 3, 5, '2023-12-29', 'MEM'),
(2, 1, 6, '2024-01-15', 'MEM'),
(2, 2, 7, '2024-01-16','MEM'),
(3, 3, 8, '2024-03-06', 'MEM'),
(2, 3, 9, '2024-05-17', 'MEM'),

INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo) VALUES
--Pagos de Comisiones
(2, 1, 3, '2023-02-01', 'COM'),
(2, 1, 3, '2023-03-01', 'COM'),
(2, 1, 3, '2023-04-01' , 'COM'),
(2, 1, 3, '2023-05-01', 'COM'),
(2, 1, 3, '2023-06-01' 'COM'),
(2, 1, 3, '2023-07-01', 'COM'),
(2, 1, 3, '2023-08-01', 'COM'),
(2, 1, 3, '2023-09-01', 'COM'),
(2, 1, 3, '2023-10-01', 'COM'),
(2, 1, 3, '2023-11-01',  'COM'),
(2, 1, 3, '2023-12-01', 'COM'),

(2, 3, 4, '2023-06-04', 'COM'),
(2, 3, 4, '2023-07-04', 'COM'),
(2, 3, 4, '2023-08-04', 'COM'),
(2, 3, 4, '2023-09-04','COM'),
(2, 3, 4, '2023-10-04','COM'),
(2, 3, 4, '2023-11-04','COM'),
(2, 3, 4, '2023-12-04','COM'),
(2, 3, 4, '2024-01-04','COM'),
(2, 3, 4, '2024-02-04','COM'),
(2, 3, 4, '2024-03-04','COM'),
(2, 3, 4, '2024-04-04','COM'),
(2, 3, 4, '2024-05-04','COM'),

(1, 3, 5, '2024-01-05', , 'COM'),
(1, 3, 5, '2024-02-05', , 'COM'),
(1, 3, 5, '2024-02-05', , 'COM'),
(1, 3, 5, '2024-04-05', , 'COM'),
(1, 3, 5, '2024-05-05', , 'COM'),
(1, 3, 5, '2024-06-05', , 'COM'),
(1, 3, 5, '2024-07-05', , 'COM'),
(1, 3, 5, '2024-08-05', , 'COM'),
(1, 3, 5, '2024-09-05', , 'COM'),
(1, 3, 5, '2024-10-05', , 'COM'),
(1, 3, 5, '2024-11-05', , 'COM'),
(1, 3, 5, '2024-12-05', , 'COM'),

(2, 1, 6, '2024-02-03', , 'COM'),
(2, 1, 6, '2024-03-03', , 'COM'),
(2, 1, 6, '2024-04-10', , 'COM'),
(2, 1, 6, '2024-05-03', , 'COM'),
(2, 1, 6, '2024-06-03', , 'COM'),
(2, 1, 6, '2024-07-03', , 'COM'),
(2, 1, 6, '2024-08-03', , 'COM'),
(2, 1, 6, '2024-09-03', , 'COM'),
(2, 1, 6, '2024-10-10', , 'COM'),
(2, 1, 6, '2024-11-03', , 'COM'),
(2, 1, 6, '2024-12-03', , 'COM'),

(2, 2, 7, '2024-02-02', , 'COM'),
(2, 2, 7, '2024-03-02', , 'COM'),
(2, 2, 7, '2024-04-07', , 'COM'),
(2, 2, 7, '2024-05-08', , 'COM'),
(2, 2, 7, '2024-06-10', , 'COM'),
(2, 2, 7, '2024-07-02', , 'COM'),
(2, 2, 7, '2024-08-02', , 'COM'),
(2, 2, 7, '2024-09-02', , 'COM'),
(2, 2, 7, '2024-10-02', , 'COM'),
(2, 2, 7, '2024-11-02', , 'COM'),
(2, 2, 7, '2024-12-02', , 'COM'),

(3, 3, 8, '2024-04-06' , , 'COM'),
(3, 3, 8, '2024-05-01' , , 'COM'),
(3, 3, 8, '2024-06-01' , , 'COM'),
(3, 3, 8, '2024-07-01' , , 'COM'),
(3, 3, 8, '2024-08-01' , , 'COM'),
(3, 3, 8, '2024-09-01' , , 'COM'),
(3, 3, 8, '2024-10-01' , , 'COM'),
(3, 3, 8, '2024-11-01' , , 'COM'),
(3, 3, 8, '2024-12-06' , , 'COM'),

(2, 3, 9, '2024-06-01', ,'COM'), 
(2, 3, 9, '2024-07-01', ,'COM'), 
(2, 3, 9, '2024-08-01', ,'COM'), 
(2, 3, 9, '2024-09-01', ,'COM'), 
(2, 3, 9, '2024-10-01', ,'COM'), 
(2, 3, 9, '2024-11-01', ,'COM'), 
(2, 3, 9, '2024-12-01', ,'COM')
;

--faltan los de multas


--INSERTS DE AFILIACIONES

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

--INSERTS DE CONTACTOS EMPLEADOS

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
(1, 'Isabel', 'Mendoza', 'López', 987654321, '001234567891');  -- USA


--INSERTS DE ENLACES. Revisar.
INSERT INTO enlaces (id_significado, descripcion, id_flor_corte, codigo_color) VALUES
(1, 'rosas rojas', 1, 'ca1b1b'),  
(1, 'rosas blancas', 1, 'ffffff'),  
(2, 'claveles rosas', 2, 'c5388b'),  
(5, 'lirios blancos', 3, 'ffffff'),  
(7, 'tulipanes rojos', 4, 'ca1b1b'),  
(8, 'girasoles amarillos', 5, 'fbf500'),  
(8, 'girasoles naranjas', 5, 'ffa500'), 
(9, 'margaritas amarillas', 6, 'fbf500'), 
(10, 'freesias lavanda', 7, 'e6e6fa');

--INSERTS DE CATALOGOS PRODUCTORES

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
(3, 101402, 'Floral Breeze', 'Símbolo de nobleza y misterio, cautiva con su profundo color y elegancia', 4, '800080'); -- Tulipan, color purpura, catalogo de tulipanes del productor 3

--INSERTS DE DETALLES CONTRATOS

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


INSERT INTO facturas_subastas (num_factura, fecha_emision, total, id_sub, id_floristeria, envio) VALUES
(20241016, '2024-03-15', 440, 3 , 1, 'SI'), --Factura Subastadora 3 a Floristeria 1
(20241017, '2024-04-01', 700, 1, 3, 'NO'), --Factura Subastadora 1 a Floristeria 3
(20241018, '2024-05-10', 770, 1, 5 , 'SI'), --Factura Subastadora 1 a Floristeria 5
(20241019, '2024-05-17', 800, 2, 2, 'NO'), --Factura Subastadora 2 a Floristeria 2
(20241020, '2024-06-01', 715, 3, 4 , 'SI'), --Factura Subastadora 3 a Floristeria 4
(20241021, '2024-07-19', 550, 2, 6 , 'SI'), --Factura Subastadora 2 a Floristeria 6

(20241022, '2024-06-03', 1200, 1, 5, 'NO'), --Factura Subastadora 1 a Floristeria 5
(20241023, '2024-06-18', 1100, 2, 2, 'SI'), --Factura Subastadora 2 a Floristeria 2
(20241024, '2024-06-27', 800, 1, 1 , 'NO'), --Factura Subastadora 1 a Floristeria 1
(20241025, '2024-06-29', 880, 3, 4 , 'SI'), --Factura Subastadora 3 a Floristeria 4
(20241026, '2024-07-02', 500, 3, 3, 'NO'), --Factura Subastadora 3 a Floristeria 3
(20241027, '2024-11-30', 1210, 2, 6, 'SI') --Factura Subastadora 2 a Floristeria 6
;

--INSERTS DE LOTES FLORES

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

--INSERTS DE CATALOGOS FLORISTERIAS. Revisar.

INSERT INTO catalogos_floristerias (id_floristeria, nombre, id_flor_corte, codigo_color) VALUES
(1, 'Salina', 7, '008000'),  -- Verde
(1, 'Bengala', 2, 'ca1b1b'),  -- Rojo
(2, 'Darling', 1, 'c5388b'),      -- Rosa
(3, 'Teddy Bear', 5, 'fbf500'),  -- Amarillo
(3, 'Blue blush', 7, '0000ff'),    -- Azul
(4, 'Avalanche', 1, 'ffffff'),     -- Blanca
(4, 'Clarisa', 8, 'e6e6fa'),     -- Lavanda
(5, 'Lirio amatista', 3, '800080'),     -- Púrpura
(5, 'Cairo', 2, 'a52a2a'),      -- Marrón
(6, 'Margarita clasica', 6, 'ffffff'); -- Blanco

--INSERTS DE HISTORICOS PRECIOS. Revisar

INSERT INTO historicos_precio (id_floristeria, id_catalogo, fecha_inicio, precio_unitario, tamano_tallo, fecha_final) VALUES
(1, 1, 05/11/2024, 77.02, 23, NULL),  
(2, 2, 11/6/2024, 80.55, 14.5, 24/11/2024),  
(2, 2, 24/11/2024, 66.7, 14.5, NULL),  
(3, 2, 17/02/2024, 20.74, 30.22, 02/05/2024),  
(3, 2, 02/05/2024, 15.5, 30.13, NULL),   
(4, 1, 07/12/2024, 22.6, 5.5, NULL),   
(5, 3, 30/01/2024, 32.5, 100, NULL),  
(5, 4, 08/07/2024, 21.1, 20, NULL),  
(6, 5, 01/02/2024, 10.9, 75.45, NULL),  
(6, 7, 22/01/2024, 52.6, 41.8, NULL); 

--INSERTS DE BOUQUETS. Revisar.

INSERT INTO bouquets (id_floristeria, id_catalogo, cantidad, descripcion, tamano_tallo) VALUES
(1, 1, 10, 'Bouquet de flores tropicales', 23),  
(1, 1, 5, 'Bouquet de flores tropicales', 14),  
(2, 1, 20, 'Bouquet de flores tropicales', 55),  
(2, 2, 5, 'Bouquet de flores primaverales', 30),  
(3, 2, 7, 'Bouquet de flores primaverales', 10),   
(4, 3, 25, 'Bouquet de rosas', 5),   
(4, 3, 4, 'Bouquet de rosas', 100),  
(5, 4, 3, 'Bouquet de girasoles', 250),  
(5, 5, 5, 'Bouquet de freesias', 75),  
(5, 7, 5, 'Bouquet de hortensias', 41); 

