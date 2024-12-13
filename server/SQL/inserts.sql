--INSERTS DE PAISES
BEGIN;
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
COMMIT;

--INSERTS DE FLORES DE CORTE
BEGIN;
INSERT INTO flores_corte (nombre_comun, genero_especie, etimologia, tem_conservacion, colores) VALUES
('Rosa', 'Rosa spp.', 'Llamada así en honor a la diosa romana de la belleza.', 18.00, 'Rojo, rosa, blanco, amarillo'),
('Clavel', 'Dianthus caryophyllus', 'El nombre proviene del griego "dianthus", que significa "flor divina".', 14.00, 'Rojo, rosa, blanco, amarillo'),
('Lirio', 'Lilium spp.', 'Proviene del latín "lilium", que significa "lirio".', 10.00, 'Blanco, amarillo, naranja, rojo'),
('Tulipán', 'Tulipa spp.', 'Deriva del turco "tülbent", que significa "turbante".', 12.00, 'Rojo, amarillo, rosa, púrpura'),
('Girasol', 'Helianthus annuus', 'Su nombre proviene del griego "helios" (sol) y "anthos" (flor).', 20.00, 'Amarillo, marrón, naranja'),
('Margarita', 'Bellis perennis', 'Su nombre proviene del latín "bellus", que significa "hermoso".', 15.00, 'Blanco, amarillo'),
('Freesia', 'Freesia spp.', 'Nombrada en honor al botánico alemán Friedrich Freese.', 15.00, 'Amarillo, blanco, rosa, lavanda'),
('Hortensia', 'Hydrangea macrophylla', 'El nombre proviene del griego "hydor" (agua) y "angeion" (recipiente).', 20.00, 'Azul, rosa, blanco, púrpura'),
('Crisantemo', 'Chrysanthemum morifolium', 'Proviene del griego "chrysos" (oro) y "anthemon" (flor).', 16.00, 'Amarillo, blanco, rosa, púrpura')
;
COMMIT;

--INSERTS DE COLORES
BEGIN;
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
COMMIT;

--INSERTS DE SIGNIFICADOS
BEGIN;
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
COMMIT;

--INSERTS DE SUBASTADORAS
BEGIN;
INSERT INTO subastadoras (nombre_sub, id_pais, url_imagen) VALUES 
('VGB Flowers', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://www.vgb.nl/files/logo.png'),
('Royal FloraHolland', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSldh0qE2r5VrLUPAR8AfXJqdzZWF02_gc5Ag&s'),
('Borst Bloembollen', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://borstbloembollen.nl/wp-content/uploads/2020/09/BorstBloembollen-1x1-1.jpg')
;
COMMIT;

--INSERTS DE PRODUCTORES
BEGIN;
INSERT INTO productores (nombre_prod, pagweb_prod, id_pais, url_imagen) VALUES 
('Flor Ecuador', 'florecuador.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Ecuador'),'https://everbloomroses.com/wp-content/uploads/2021/03/Logo-colores-1024x738.png'),
('Dutch Flower Group', 'dutchflowergroup.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Holanda'), 'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/012023/dutch_flower_group.png?LOC6P60HFzYitYuX7hcEO0dxJQTArFu0&itok=yMVHa8Ps'),
('Kordes Roses', 'kordesroses.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Alemania'), 'https://www.garten-schlueter.de/media/image/ab/a3/3f/99_Manufacturer.jpg')
;
COMMIT;

--INSERTS DE FLORISTERIAS
BEGIN;
INSERT INTO floristerias (nombre_floristeria, pagweb_floristeria, telefono_floristeria, email_floristeria, id_pais, url_imagen) VALUES 
('Fleura Metz', 'fleura.com', '1234567890', 'info@fleura.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Estados Unidos'), 'https://media.licdn.com/dms/image/v2/C4D0BAQHQipnwGts1Zg/company-logo_200_200/company-logo_200_200/0/1630567322813/fleurametz_logo?e=2147483647&v=beta&t=lYp7vlJiZGtjBm02dJaVVm0G5jN90KEEgQ_eVRTr4J8'),
('Interflora', 'interflora.co.uk', '0987654321', 'contact@interflora.co.uk', (SELECT id_pais FROM paises WHERE nombre_pais = 'Inglaterra'), 'https://descuentos.abc.es/static/shop/10354/logo/C%C3%B3digo_descuento_Interflora_-_Logo_.png'),
('Floreria San Telmo', 'santelmo.com', '1122334455', 'info@santelmo.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Argentina'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwrHmxgzykj32vJwbtX6c1oT9QkAzZNBOJJg&s'),
('Sunshine Bouquets', 'sunshinebouquets.com', '2233445566', 'info@sunshinebouquets.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Colombia'), 'https://media.licdn.com/dms/image/v2/C4D0BAQFn9Mo7DknFMA/company-logo_200_200/company-logo_200_200/0/1630525340234/sunshinebouquetcompany_logo?e=2147483647&v=beta&t=70V5QV2dC26SFYEbXC00S6PpqP8t9tmf_NZEW4Uw1tE'),
('Les Fleurs', 'lesfleurs.mx', '3344556677', 'info@lesfleurs.mx', (SELECT id_pais FROM paises WHERE nombre_pais = 'Mexico'), 'https://lesfleurs.com.mx/cdn/shop/files/Logo-oro-_1_1_50396ee2-c96e-4036-bad6-6a45b4c9edcc_1080x.png?v=1675447413'),
('FloraQueen', 'floraqueen.com', '4455667788', 'info@floraqueen.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'España'), 'https://gsg-wl.chollometro.com/cupones/images/fit-in/256x/images/f/Floraqueen_Logo.png')
;
COMMIT;

--INSERTS DE CONTRATOS
BEGIN;
INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(3, 2, '2022-12-12', 'CC', 18.00, 'SI', NULL ), --Productor 2 con Subastador 3, cancelado
(1, 1, '2023-01-15', 'CB', 35.00, 'SI', NULL) -- Productor 1 con Subastador 1, cancelado
;
COMMIT;
BEGIN;
INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(2, 1, '2023-01-15', 'CA', 65.00, 'NO', NULL ), -- Productor 1 con Subastador 2, vencido
(2, 3, '2023-05-17', 'CG', 30.00, 'NO', NULL) -- Productor 3 que tiene contratos con v companias, vencido
;
COMMIT;
BEGIN;
INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(1, 3, '2023-12-29', 'CG', 15.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, valido SUBASTADORA 1
(2, 1, '2024-01-16', 'CA', 60.00, 'NO', 3), -- Productor 1 con Subastador 2,  valido 
(2, 2, '2024-01-16', 'KA', 100.00, 'NO', NULL), -- Productor 2 con Subastador 2, ofrece el 100% aca, valido
(3, 3, '2024-03-06', 'CG', 20.00, 'NO', NULL), -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
(2, 3, '2024-05-17', 'CG', 30.00, 'NO', 4) -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
;
COMMIT;

--INSERTS DE PAGOS MULTAS 
BEGIN;
INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo, monto_euros) VALUES
--Pagos de Membresias
(3, 2, 1, '2022-12-12', 'MEM', 500),
(1, 1, 2, '2023-01-15', 'MEM', 500),
(2, 1, 3, '2023-01-15', 'MEM', 500 ),
(2, 3, 4, '2023-05-17', 'MEM', 500),
(1, 3, 5, '2023-12-29', 'MEM', 500),
(2, 1, 6, '2024-01-15', 'MEM', 500),
(2, 2, 7, '2024-01-16','MEM', 500),
(3, 3, 8, '2024-03-06', 'MEM', 500),
(2, 3, 9, '2024-05-17', 'MEM', 500)
;
COMMIT;

BEGIN;
INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo, monto_euros) VALUES
--Pagos de Comisiones
(2, 1, 3, '2023-02-01', 'COM',24),
(2, 1, 3, '2023-03-01', 'COM', 25),
(2, 1, 3, '2023-04-01' , 'COM', 100),
(2, 1, 3, '2023-05-01', 'COM', 150),
(2, 1, 3, '2023-06-01' ,'COM', 70),
(2, 1, 3, '2023-07-01', 'COM', 50),
(2, 1, 3, '2023-08-01', 'COM', 50),
(2, 1, 3, '2023-09-01', 'COM',49.78),
(2, 1, 3, '2023-10-01', 'COM', 60),
(2, 1, 3, '2023-11-01',  'COM',65),
(2, 1, 3, '2023-12-01', 'COM',102),

(2, 3, 4, '2023-06-04', 'COM', 75),
(2, 3, 4, '2023-07-04', 'COM', 50),
(2, 3, 4, '2023-08-04', 'COM', 65),
(2, 3, 4, '2023-09-04','COM', 20),
(2, 3, 4, '2023-10-04','COM', 45),
(2, 3, 4, '2023-11-04','COM', 65),
(2, 3, 4, '2023-12-04','COM',94),
(2, 3, 4, '2024-01-04','COM', 65),
(2, 3, 4, '2024-02-04','COM', 37),
(2, 3, 4, '2024-03-04','COM', 61.2),
(2, 3, 4, '2024-04-04','COM', 98),
(2, 3, 4, '2024-05-04','COM', 54),

(1, 3, 5, '2024-01-05', 'COM', 89),
(1, 3, 5, '2024-02-05','COM', 200),
(1, 3, 5, '2024-02-05','COM', 175),
(1, 3, 5, '2024-04-05','COM', 300),
(1, 3, 5, '2024-05-05','COM', 450),
(1, 3, 5, '2024-06-05','COM', 320),
(1, 3, 5, '2024-07-05','COM', 210),
(1, 3, 5, '2024-08-05','COM', 100),
(1, 3, 5, '2024-09-05','COM', 162),
(1, 3, 5, '2024-10-05','COM', 196),
(1, 3, 5, '2024-11-05','COM', 150),
(1, 3, 5, '2024-12-05','COM', 102),

(2, 1, 6, '2024-02-03','COM', 560),
(2, 1, 6, '2024-03-03', 'COM', 460),
(2, 1, 6, '2024-04-10','COM', 608),
(2, 1, 6, '2024-05-03','COM', 562),
(2, 1, 6, '2024-06-03','COM', 589),
(2, 1, 6, '2024-07-03', 'COM', 498),
(2, 1, 6, '2024-08-03', 'COM', 563),
(2, 1, 6, '2024-09-03', 'COM', 498),
(2, 1, 6, '2024-10-10', 'COM', 420),
(2, 1, 6, '2024-11-03', 'COM', 360),
(2, 1, 6, '2024-12-03', 'COM', 250),

(2, 2, 7, '2024-02-02', 'COM', 360),
(2, 2, 7, '2024-03-02','COM', 708),
(2, 2, 7, '2024-04-07','COM', 750),
(2, 2, 7, '2024-05-08', 'COM', 800),
(2, 2, 7, '2024-06-10', 'COM', 675),
(2, 2, 7, '2024-07-02', 'COM', 499),
(2, 2, 7, '2024-08-02', 'COM', 437),
(2, 2, 7, '2024-09-02', 'COM', 213),
(2, 2, 7, '2024-10-02', 'COM', 200),
(2, 2, 7, '2024-11-02', 'COM', 75),
(2, 2, 7, '2024-12-02', 'COM', 106),

(3, 3, 8, '2024-04-06','COM', 269 ),
(3, 3, 8, '2024-05-01','COM', 521),
(3, 3, 8, '2024-06-01','COM', 365),
(3, 3, 8, '2024-07-01','COM', 608),
(3, 3, 8, '2024-08-01','COM', 806),
(3, 3, 8, '2024-09-01','COM', 532),
(3, 3, 8, '2024-10-01','COM', 200),
(3, 3, 8, '2024-11-01','COM', 194),
(3, 3, 8, '2024-12-06','COM', 100),

(2, 3, 9, '2024-06-01','COM', 200), 
(2, 3, 9, '2024-07-01','COM', 300), 
(2, 3, 9, '2024-08-01','COM', 205), 
(2, 3, 9, '2024-09-01','COM', 362), 
(2, 3, 9, '2024-10-01','COM', 215), 
(2, 3, 9, '2024-11-01','COM', 234), 
(2, 3, 9, '2024-12-01','COM', 256)
;
COMMIT;

--faltan los de multas


--INSERTS DE AFILIACIONES
BEGIN;
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
COMMIT;

--INSERTS DE CONTACTOS EMPLEADOS
BEGIN;
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
COMMIT;

--INSERTS DE ENLACES. Revisar.
BEGIN;
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
COMMIT;

BEGIN;
--INSERTS DE CATALOGOS DE PRODUCTORES
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
COMMIT;

--INSERTS DE DETALLES CONTRATOS
BEGIN;
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
COMMIT;

--INSERTS DE FACTURAS DE SUBASTAS
BEGIN;
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
COMMIT;

--INSERTS DE LOTES FLORES
BEGIN;
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
COMMIT;

--INSERTS DE CATALOGOS FLORISTERIAS. 
BEGIN;
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
COMMIT;

--INSERTS DE HISTORICOS PRECIOS. 
BEGIN;
INSERT INTO historicos_precio (id_floristeria, id_catalogo, fecha_inicio, precio_unitario, tamano_tallo, fecha_final) VALUES
-- Radiant Carnation
(1, 1, '2024-01-01', 12.50, 50.0, '2024-03-31'),  
(1, 1, '2024-04-01 00:00:00', 13.00, 50.0, NULL),           
(1, 1, '2024-04-01 00:00:01', 10.00, 30.0, NULL),           
-- Brilliant Tulip
(1, 2, '2024-01-15', 10.00, 45.0, '2024-03-15'), 
(1, 2, '2024-03-16', 11.00, 45.0, NULL),          
-- Darling Rose
(2, 3, '2024-01-10', 15.00, 60.0, '2024-04-10'), 
(2, 3, '2024-04-11', 16.00, 60.0, NULL),           
-- Summer Sunflower
(2, 4, '2024-02-01', 8.00, 70.0, '2024-05-01'),  
(2, 4, '2024-05-02 00:00:00', 9.00, 70.0, NULL),           
(2, 4, '2024-05-02 00:00:01', 10.00, 80.0, NULL),           
--Joyful Daisy
(2, 5, '2024-01-20', 5.00, 30.0, '2024-03-20'),  
(2, 5, '2024-03-21', 5.50, 30.0, NULL),           
-- Magical Hydrangea
(2, 6, '2024-02-10', 20.00, 80.0, '2024-04-10'), 
(2, 6, '2024-04-11', 21.00, 80.0, NULL),           
-- Radiant Tulip
(3, 7, '2024-01-05', 10.50, 45.0, '2024-03-05'),
(3, 7, '2024-03-06 00:00:00', 11.50, 45.0, NULL),
(3, 7, '2024-03-06 00:00:01', 13.00, 60.0, NULL),
-- Charming Carnation
(3, 8, '2024-01-15', 12.75, 50.0, '2024-04-15'),
(3, 8, '2024-04-16', 13.25, 50.0, NULL),
-- Golden Carnation
(3, 9, '2024-02-01', 13.00, 50.0, '2024-05-01'),
(3, 9, '2024-05-02', 13.50, 50.0, NULL),
-- Blushing Carnation
(4, 10, '2024-01-25', 12.25, 50.0, '2024-03-25'),
(4, 10, '2024-03-26', 12.75, 50.0, NULL),
-- Blinding Carnation
(4, 11, '2024-02-15', 12.50, 50.0, '2024-04-15'),
(4, 11, '2024-04-16', 13.00, 50.0, NULL),
-- Vibrant Tulip
(5, 12, '2024-01-30', 11.00, 45.0, '2024-03-30'),
(5, 12, '2024-03-31', 11.50, 45.0, NULL),
-- Serenity Tulip
(5, 13, '2024-02-20', 10.75, 45.0, '2024-05-20'),
(5, 13, '2024-05-21', 11.25, 45.0, NULL),
-- Aqua Hydrangea
(6, 14, '2024-02-05', 22.00, 80.0, '2024-04-05'),
(6, 14, '2024-04-06 00:00:00', 23.00, 80.0, NULL),
(6, 14, '2024-04-06 00:00:01', 25.00, 85.0, NULL),
-- Mistery Sunflower
(6, 15, '2024-03-01', 9.00, 70.0, '2023-06-01'),
(6, 15, '2023-06-02', 9.50, 70.0, NULL);


--INSERTS DE BOUQUETS. 
BEGIN;
INSERT INTO bouquets (id_floristeria, id_catalogo, cantidad, descripcion, tamano_tallo) VALUES
(1, 1, 20, 'Bouquet Radiant Carnations', 50),
(1, 1, 20, 'Bouquet Radiant Carnations', 30),
(1, 2, 5, 'Bouquet Brilliant Tulips', 70),

(2, 3, 15, 'Bouquet Darling Roses', 40),
(2, 3, 15, 'Bouquet Darling Roses', 50),
(2, 4, 10, 'Bouquet Summer Sunflowers', 60),
(2, 5, 20,'Bouquet Joyful Daisys', 30),
(2, 6, 15, 'Bouquet Magical Hydrangeas', 50),

(3, 7, 30, 'Bouquet Radiant Tulips', 70),
(3, 9, 10, 'Bouquet Golden Carnations', 60),

(4, 10, 40, 'Bouquet Blushing Carnations', 20 ),
(4, 11, 45, 'Bouquet Blinding Carnations', 45),

(5, 12, 55, 'Bouquet Vibrant Tulips', 50),
(5, 13, 30, 'Bouquet Serenity Tulips', 70),

(6, 14, 30, 'Bouquet Aqua Hydrangeas', 45),
(6, 15,  25, 'Bouquet Mistery Sunflowers', 65)
;
COMMIT;

--INSERTS DE CLIENTE NATURAL FLORISTERIA
BEGIN;
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
COMMIT;

--INSERTS DE CLIENTES COMPANIAS DE FLORISTERIA
BEGIN;
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
COMMIT;

--INSERTS DE FACTURAS FLORISTERIAS
BEGIN;
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
COMMIT;

--INSERTS DE DETALLES FACTURAS FLORISTERIAS
BEGIN;
INSERT INTO det_facturas_floristerias (cantidad, id_floristeria, num_factura, id_catalogo, id_bouquet, subtotal, valor_calidad, valor_precio, promedio) VALUES
(1, 1, 1001, 1, NULL, 100.75, 4.5, 4.0, 4.25),  -- Detalle 1 para factura 1001
(1, 1, 1001, 2, NULL, 50.00, 4.0, 4.5, 4.25),   -- Detalle 2 para factura 1001

(1, 1, 1002, 1, 1, 150.50, 4.0, 4.5, 4.25),  -- Detalle 1 para factura 1002
(1, 1, 1002, 1, 2, 50.00, 4.0, 4.0, 4.00),   -- Detalle 2 para factura 1002

(1, 2, 1003, 3, NULL, 60.00, 3.5, 4.0, 3.75),   -- Detalle 1 para factura 1003
(1, 2, 1003, 4, NULL, 60.00, 4.0, 4.0, 4.00),   -- Detalle 2 para factura 1003

(1, 2, 1004, 6, 8, 90.25, 3.0, 3.5, 3.25),   -- Detalle 1 para factura 1004
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
COMMIT;