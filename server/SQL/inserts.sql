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
('Fleura Metz', 'fleura.com', '1234567890', 'info@fleura.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Estados Unidos'), 'https://play-lh.googleusercontent.com/mAttURxzmRPVodxxeHdacFBjLcfoKd9Grri22J7RuiJUcUoTjOY6mHTMo2qXVUicJoI'),
('Interflora', 'interflora.co.uk', '0987654321', 'contact@interflora.co.uk', (SELECT id_pais FROM paises WHERE nombre_pais = 'Inglaterra'), 'https://descuentos.abc.es/static/shop/10354/logo/C%C3%B3digo_descuento_Interflora_-_Logo_.png'),
('Floreria San Telmo', 'santelmo.com', '1122334455', 'info@santelmo.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Argentina'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwrHmxgzykj32vJwbtX6c1oT9QkAzZNBOJJg&s'),
('Sunshine Bouquets', 'sunshinebouquets.com', '2233445566', 'info@sunshinebouquets.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'Colombia'), 'https://media.licdn.com/dms/image/v2/C4D0BAQFn9Mo7DknFMA/company-logo_200_200/company-logo_200_200/0/1630525340234/sunshinebouquetcompany_logo?e=2147483647&v=beta&t=70V5QV2dC26SFYEbXC00S6PpqP8t9tmf_NZEW4Uw1tE'),
('Les Fleurs', 'lesfleurs.mx', '3344556677', 'info@lesfleurs.mx', (SELECT id_pais FROM paises WHERE nombre_pais = 'Mexico'), 'https://lesfleurs.com.mx/cdn/shop/files/Logo-oro-_1_1_50396ee2-c96e-4036-bad6-6a45b4c9edcc_1080x.png?v=1675447413'),
('FloraQueen', 'floraqueen.com', '4455667788', 'info@floraqueen.com', (SELECT id_pais FROM paises WHERE nombre_pais = 'España'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7lmYXbDsX4bKXIDA_RZTiOyAaMwIhAfdynQ&s')
;
COMMIT;

--INSERTS DE CONTRATOS
BEGIN;
INSERT INTO contratos (id_sub, id_prod, fecha_contrato, clasificacion, porc_total_prod, cancelado, id_contrato_padre) VALUES
(3, 2, '2022-12-12', 'CC', 18.00, 'SI', NULL ), --Productor 2 con Subastador 3, cancelado
(1, 1, '2023-01-15', 'CB', 35.00, 'SI', NULL), -- Productor 1 con Subastador 1, cancelado

(2, 1, '2023-06-15', 'CA', 65.00, 'NO', NULL ), -- Productor 1 con Subastador 2, vencido
(2, 3, '2023-05-17', 'CG', 30.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, vencido

(1, 3, '2023-12-18', 'CG', 15.00, 'NO', NULL), -- Productor 3 que tiene contratos con v companias, valido SUBASTADORA 1. Ej de va al dia con sus pagos, se vence el dia de la evualucacion, para renovar
(2, 1, '2024-06-16', 'CA', 60.00, 'NO', 3), -- Productor 1 con Subastador 2,  valido EJ para que tenga comisiones no pagadas y multas, para cancelar contrato
(2, 2, '2024-06-16', 'KA', 100.00, 'NO', NULL), -- Productor 2 con Subastador 2, ofrece el 100% aca, valido
(3, 3, '2024-09-24', 'CG', 20.00, 'NO', NULL), -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
(2, 3, '2024-05-18', 'CG', 30.00, 'NO', 4) -- Productor 3 que tiene contratos con varias companias, valido SUBASTADORA 3
;
COMMIT;

--INSERTS DE PAGOS MULTAS 
BEGIN;
-- Pagos de Comisiones
INSERT INTO pagos_multas (id_sub, id_prod, id_contrato, fecha_pago, tipo) VALUES
(1, 3, 5, '2024-05-01', 'COM'),
(1, 3, 5, '2024-06-01', 'COM'),
(1, 3, 5, '2024-07-01', 'COM'),

(2, 1, 6, '2024-07-06', 'COM'), 
(2, 1, 6, '2024-08-04', 'COM'),
(2, 1, 6, '2024-12-06', 'COM'),

(2, 2, 7, '2024-07-05', 'COM'),
(2, 2, 7, '2024-08-05', 'COM'),

(3, 3, 8, '2024-10-05', 'COM'),  -- Comisión de Septiembre (pagada a tiempo)
(3, 3, 8, '2024-11-05', 'COM'),  -- Comisión de octubre (pagada a tiempo)
(3, 3, 8, '2024-12-05', 'COM'),  -- Comisión de octubre (pagada a tiempo)

(2, 3, 9, '2024-12-08', 'COM')  -- Comisión de noviembre (pagada tarde)
;
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

(1, 1, '2024-01-12 08:30:00', 0.80, 30.0, NULL),
(1, 2, '2024-10-22 09:45:00', 0.40, 20.0, NULL),
(2, 3, '2024-05-17 10:15:00', 1.10, 40.0, NULL),
(2, 4, '2024-03-06 11:00:00', 0.80, 25.0, NULL),
(2, 5, '2024-06-27 12:30:00', 0.80, 35.0, NULL),  -- Corregido el formato de fecha
(2, 6, '2024-04-21 14:00:00', 0.90, 30.0, NULL),
(3, 7, '2024-05-22 15:15:00', 0.70, 30.0, NULL),
(3, 8, '2024-01-15 16:45:00', 0.40, 15.0, NULL),
(3, 9, '2024-06-04 17:30:00', 0.60, 25.0, NULL),
(4, 10, '2024-05-14 18:00:00', 0.85, 30.0, NULL),
(4, 11, '2024-05-23 19:15:00', 0.60, 30.0, NULL),
(5, 12, '2024-10-19 20:30:00', 0.50, 25.0, NULL),
(5, 13, '2024-07-07 21:00:00', 0.30, 15.0, NULL),
(6, 14, '2024-01-12 22:00:00', 1.15, 40.0, NULL),
(6, 15, '2024-08-20 23:45:00', 0.70, 38.0, NULL);

--INSERTS DE BOUQUETS. 
BEGIN;
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