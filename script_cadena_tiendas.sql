\c postgres postgres

drop database if exists cadenatiendas;

create database cadenatiendas encoding utf8;

\c cadenatiendas

/* Creamos las tablas */

CREATE TABLE cliente
(   
id SERIAL PRIMARY KEY,   
apellidos  VARCHAR(25) NOT NULL,   
nombre   VARCHAR(20) NOT NULL,   
ciudad VARCHAR(30) NOT NULL,
pais   VARCHAR(30) NOT NULL
);
     
CREATE TABLE tienda
( 
id SERIAL PRIMARY KEY,   
ciudad    VARCHAR(30) NOT NULL,   
pais   VARCHAR(30) NOT NULL,   
gerente   VARCHAR(25) NOT NULL
);

CREATE TABLE proveedor (
id SERIAL PRIMARY KEY,   
nombre   VARCHAR(25) NOT NULL,
ciudad    VARCHAR(30) NOT NULL,   
pais   VARCHAR(30) NOT NULL
);

CREATE TABLE peso
(
 id SERIAL PRIMARY KEY,
 nombre   VARCHAR(9) NOT NULL,
 peso_min    INT NOT NULL,
 peso_max    INT NOT NULL
);

CREATE TABLE articulo(
id SERIAL PRIMARY KEY,   
nombre    VARCHAR(50) NOT NULL,   
peso_id   INT NOT NULL REFERENCES peso(id),   
color    VARCHAR(15),   
preciocompra     INT NOT NULL,   
precioventa     INT NOT NULL,   
proveedor_id    INT REFERENCES proveedor(id)
);

CREATE TABLE venta
(
id SERIAL PRIMARY KEY,
cliente_id      INT,   
tienda_id      INT,   
fecha    DATE NOT NULL,
FOREIGN KEY (cliente_id) REFERENCES cliente (id),
FOREIGN KEY (tienda_id) REFERENCES tienda (id)
);

CREATE TABLE articulovendido
(
venta_id INT NOT NULL REFERENCES venta(id),
articulo_id INT NOT NULL REFERENCES articulo(id),
cantidad     INT NOT NULL DEFAULT 1,   
PRIMARY KEY(venta_id,articulo_id)
);


/* Insertamos los datos */
INSERT INTO cliente VALUES 
(DEFAULT,'Bedmar','Margarita','Madrid','España'),
(DEFAULT,'Castillo','Miguel','Madrid','España' ),
(DEFAULT,'Dupont','Jean','París','Francia' ),
(DEFAULT,'Dupret','Michel','Lyon','Francia' ),
(DEFAULT,'Llopis','Antonio','Barcelona','España'),
(DEFAULT,'Souris','Marcel','París','Francia'),
(DEFAULT,'Núñez','Pablo','Pamplona','España'),
(DEFAULT,'Courbon','Gerard','Lyon','Francia'),
(DEFAULT,'Román','Consuelo','Jaén','España'),
(DEFAULT,'Roca','Pau','Gerona','España'),
(DEFAULT,'Vera','Jorge','Valencia','España'),
(DEFAULT,'Camarero','Pablo','Barcelona','España'),
(DEFAULT,'Cortés','Diego','Madrid','España'),
(DEFAULT,'Fernández','Joaquín','Madrid','España'),
(DEFAULT,'Durán','Jacinto','Lugo','España'),
(DEFAULT,'Pérez','Pedro','Sevilla','España'),
(DEFAULT,'Casado','Nuria','Zaragoza','España'),
(DEFAULT,'Collado','José','Madrid','España'),
(DEFAULT,'Sequeira','Carla','Oporto','Portugal'),
(DEFAULT,'Marcelo','Vieira','San José','Brasil'),
(DEFAULT,'Campos','Almudena','Córdoba','España');


INSERT INTO tienda VALUES 
(DEFAULT,'Madrid-Este','España','Antonio Velasco'),       
(DEFAULT,'Madrid-Centro','España','Ana Bravo'),       
(DEFAULT,'Córdoba','España','Antonio Carmona'),       
(DEFAULT,'Jaén','España','Miguel Carrasco'),       
(DEFAULT,'Sevilla','España','Ana Sánchez'),       
(DEFAULT,'Huelva','España','Lucía Jiménez'),       
(DEFAULT,'Cádiz','España','Juana Beltrán'),      
(DEFAULT,'Málaga','España','Mónica Parrilla'),       
(DEFAULT,'Granada','España','Alberto Lozano'),       
(DEFAULT,'Almería','España','Angustias Gómez'),       
(DEFAULT,'Lyon','Francia','Manuel Perales'),       
(DEFAULT,'París','Francia','Paco Mata');       

INSERT INTO proveedor VALUES 
(DEFAULT,'Suministros Industriales','Albacete','España'),
(DEFAULT,'Suministros Generales','Toledo','España'),
(DEFAULT,'Royal Celso','Lyon','Francia'),
(DEFAULT,'Hermanos Jiménez','Santander','España'),
(DEFAULT,'Distribuciones Sur','Madrid','España'),
(DEFAULT,'Asociación Lester','París','Francia'),
(DEFAULT,'Productos CamSur','Sevilla','España');

INSERT INTO peso VALUES 
(DEFAULT,'leve',0,100),
(DEFAULT,'ligero',101,500),
(DEFAULT,'medio',501,2500);


INSERT INTO articulo VALUES 
(DEFAULT,'Monitor LG BX',2,'rojo',170,260,1),
(DEFAULT,'RAM 8GB DDR4',2,'negro',70,120,6),
(DEFAULT,'Disco Duro SSD 256GB',1,'blanco',140,220,2),
(DEFAULT,'Impresora 3D Nantius',3,'rojo',580,760,5),
(DEFAULT,'Multifunción Hp NX',3,'blanco',300,520,3),
(DEFAULT,'Teclado Radius',3,'azul',15,25,4),
(DEFAULT,'Ratón Genius',3,'verde',10,15,6),
(DEFAULT,'Impresora Samsung LX',1,'amarillo',200,240,5),
(DEFAULT,'Placa Base Neox',1,'gris',180,300,3),
(DEFAULT,'Tarjeta Gráfica Nvidia',1,'rojo',80,150,4),
(DEFAULT,'Disco Duro SSD 512GB',1,'azul',180,260,2),
(DEFAULT,'Monitor Samsung KD',1,'rojo',160,240,1),
(DEFAULT,'RAM 16GB DDR4',1,'verde',120,190,3),
(DEFAULT,'Placa Base Trux',1,'azul',150,260,5),
(DEFAULT,'Impresora 3D Kansas',1,'negro',360,480,6),
(DEFAULT,'Teclado Genius',3,'rosa',20,35,4);

INSERT INTO venta VALUES 
(DEFAULT,5,4,'2022/01/05'),
(DEFAULT,7,3,'2022/01/05'),
(DEFAULT,7,3,'2022/01/05'), 
(DEFAULT,7,3,'2022/01/05'),

(DEFAULT,8,11,'2022/01/10'),
(DEFAULT,6,12,'2022/01/10'),
(DEFAULT,6,12,'2022/01/10'),
(DEFAULT,13,1,'2022/01/10'),

(DEFAULT,13,1,'2022/01/15'),
(DEFAULT,1,2,'2022/01/15'),
(DEFAULT,1,2,'2022/01/15'),
(DEFAULT,1,2,'2022/01/15'),

(DEFAULT,4,11,'2022/01/20'),
(DEFAULT,4,11,'2022/01/20'),
(DEFAULT,3,7,'2022/01/20'),
(DEFAULT,3,7,'2022/01/20'),

(DEFAULT,1,2,'2022/01/22'),

(DEFAULT,7,8,'2022/01/22'),

(DEFAULT,4,5,'2022/01/23'),

(DEFAULT,10,11,'2022/01/23'),

(DEFAULT,6,7,'2022/01/23'),

(DEFAULT,3,4,'2022/01/24'),

(DEFAULT,9,10,'2022/01/24'),

(DEFAULT,2,3,'2022/01/25'),

(DEFAULT,8,9,'2022/01/25'),

(DEFAULT,5,6,'2022/01/26'),

(DEFAULT,19,7,'2022/01/27'),

(DEFAULT,17,4,'2022/01/28'),

(DEFAULT,18,1,'2022/01/28');

INSERT INTO articulovendido VALUES 
(1,3,DEFAULT),
(1,5,2),
(1,16,DEFAULT),
(1,10,2),
(2,1,DEFAULT),
(2,2,2),
(2,4,DEFAULT),
(2,5,3),
(3,9,DEFAULT),
(3,8,2),
(4,7,DEFAULT),
(4,6,3),
(5,5,DEFAULT),
(5,3,2),
(6,2,DEFAULT),
(6,13,3),
(6,12,DEFAULT),
(7,11,2),
(8,14,DEFAULT),
(8,15,3),
(8,11,DEFAULT),
(9,2,2),
(9,4,DEFAULT),
(10,5,DEFAULT),
(10,7,2),
(10,9,DEFAULT),
(10,11,DEFAULT),
(11,13,2),
(11,15,DEFAULT),
(12,16,DEFAULT),
(12,14,2),
(12,12,DEFAULT),
(12,10,DEFAULT),
(12,8,3),
(13,6,DEFAULT),
(13,4,DEFAULT),
(14,2,4),
(15,1,DEFAULT),
(15,5,DEFAULT),
(15,7,2),
(15,9,DEFAULT),
(16,11,DEFAULT),
(16,13,3),
(17,15,DEFAULT),
(17,4,DEFAULT),
(17,5,DEFAULT),
(18,7,2),
(19,8,DEFAULT),
(19,9,DEFAULT),
(19,11,2),
(20,12,DEFAULT),
(20,15,DEFAULT),
(20,16,2),
(20,1,DEFAULT),
(21,2,DEFAULT),
(21,4,2),
(21,5,DEFAULT),
(21,7,DEFAULT),
(22,8,DEFAULT),
(22,9,2),
(22,12,DEFAULT),
(23,13,DEFAULT),
(23,14,4),
(24,16,DEFAULT),
(24,3,DEFAULT),
(24,5,3),
(24,6,DEFAULT),
(24,7,DEFAULT),
(25,10,DEFAULT),
(25,11,2),
(25,13,DEFAULT),
(25,15,DEFAULT),
(25,16,2),
(25,1,DEFAULT),
(25,2,DEFAULT),
(26,5,2),
(26,6,DEFAULT),
(26,7,DEFAULT),
(26,10,3),
(26,11,DEFAULT),
(26,15,DEFAULT),
(27,16,2),
(27,2,DEFAULT),
(27,4,DEFAULT),
(27,6,3),
(28,8,DEFAULT),
(28,10,DEFAULT),
(28,13,3),
(28,14,DEFAULT),
(28,15,2),
(29,1,DEFAULT),
(29,2,DEFAULT),
(29,5,2),
(29,6,DEFAULT),
(29,8,2),
(29,9,DEFAULT);