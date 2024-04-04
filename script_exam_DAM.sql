/*CREACIÓN DE LA BASE DE DATOS Y SUS TABLAS*/
\c postgres
DROP DATABASE if EXISTS restaurante;
CREATE DATABASE restaurante; 
\c restaurante

CREATE TABLE IF NOT EXISTS producto (
codigo char(3) PRIMARY KEY,
nombre VARCHAR(50) UNIQUE not null,
precio decimal(6,2) not null
);

CREATE TABLE IF NOT EXISTS empleado (
dni CHAR(9) PRIMARY KEY,
nombre VARCHAR(50),
nss VARCHAR(11) unique not null,
turno varchar(10) check (turno in('mañana', 'tarde','noche')) default 'tarde',
salario decimal(6,2)
);

CREATE TABLE IF NOT EXISTS repartidor (
dni CHAR(9) PRIMARY KEY,
nombre VARCHAR(50),
turno char(10) check (turno in('mañana', 'tarde','noche')),
incentivo decimal(6,2) default 0
);

CREATE TABLE IF NOT EXISTS pedido (
numero char(4) PRIMARY KEY,
fecha DATE NOT NULL,
importe decimal(6,2),
dni_etm CHAR(9),
dni_ep CHAR(9),
dni_r CHAR(9),
hora_tm time,
hora_pre time,
hora_rep time,
CONSTRAINT  Pe_dniETM_FK FOREIGN KEY (dni_etm) REFERENCES empleado(dni) ON DELETE CASCADE,
CONSTRAINT  Pe_dniEP_FK FOREIGN KEY (dni_ep) REFERENCES empleado(dni) ON DELETE CASCADE,
CONSTRAINT  Pe_dniR_FK FOREIGN KEY (dni_r) REFERENCES repartidor(dni) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS consta(
codigo_pr char(3),
numero_p char(4),
cantidad smallint,
CONSTRAINT CO_PK PRIMARY KEY (codigo_pr,numero_p),
CONSTRAINT  CO_coP_FK FOREIGN KEY (codigo_pr) REFERENCES producto(codigo) ON DELETE CASCADE,
CONSTRAINT  CO_nuP_FK FOREIGN KEY (numero_p) REFERENCES pedido(numero) ON DELETE CASCADE
);

CREATE TABLE ranking_productos(
    cod_prod char(3) primary key,
    nombre varchar(50) unique not null,
    total int,
    foreign key(cod_prod) references producto(codigo) ON DELETE CASCADE
);

/*INSERCCIÓN DE DATOS*/

/* VALORES EN TABLA PRODUCTO */
INSERT INTO PRODUCTO VALUES ('01','Hamburguesa',2.6);
INSERT INTO PRODUCTO VALUES ('02','Patatas',2.0);
INSERT INTO PRODUCTO VALUES ('03','tomate',0.50);
INSERT INTO PRODUCTO VALUES ('04','Queso',1.0);
INSERT INTO PRODUCTO VALUES ('05','Lechuga',0.50);
INSERT INTO PRODUCTO VALUES ('06','Pollo',3.6);
INSERT INTO PRODUCTO VALUES ('08','Bacon',1.5);
INSERT INTO PRODUCTO VALUES ('09','Coca cola',3.0);
INSERT INTO PRODUCTO VALUES ('19','Fanta',3.0);
INSERT INTO PRODUCTO VALUES ('10','Nestea',3.0);
INSERT INTO PRODUCTO VALUES ('18','Agua',2.0);
INSERT INTO PRODUCTO VALUES ('11','Menu de Pollo',5.0);
INSERT INTO PRODUCTO VALUES ('12','Menu de Hamburguesa con queso',6.0);
INSERT INTO PRODUCTO VALUES ('13','Menu de Pollo con queso',6.0);
INSERT INTO PRODUCTO VALUES ('14','Menu de Hamburguesa',6.0);
INSERT INTO PRODUCTO VALUES ('15','Helado',1.0);
INSERT INTO PRODUCTO VALUES ('16','Tarta',2.0);
INSERT INTO PRODUCTO VALUES ('17','Fruta',1.0);


/* VALORES EN TABLA EMPLEADO */
INSERT INTO EMPLEADO VALUES ('11111111Q','Luis Ramirez Pardo','23445556666' , 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('22222222S','Maria Sanchez Cid','11112223334' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('33333333M','Martin Guerrero Lopez','33344455566' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('04444444T','Ursula Delta Camacho', '11177788899', 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('55555555J','Carmen Hernandez Pio','99966633311' , 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('77777777M','Pedro Jimenez Ruiz','23456785432' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('99999999X','Raul Rodrigo Roca','55566677789' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('88888888O','Soledad Campillo Molina','00088877754' , 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('03232323P','Maria Luisa Galdon Ter','43534534567', 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('14567555L','Piedad Colmenero Zapillo','23456734534' , 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('14111155T','Sergio Lerida Campos','55577700089' , 'tarde', 1000);


/* VALORES EN TABLA REPARTIDOR */
INSERT INTO REPARTIDOR VALUES ('14188151T','Carlos Sanchez Ruiz', 'tarde', 300);
INSERT INTO REPARTIDOR VALUES ('11245621Q','Juan Pardo Rubio', 'noche', 400);
INSERT INTO REPARTIDOR VALUES('04477744T','Laura Jimenez Jimenez', 'noche', 400);
INSERT INTO REPARTIDOR VALUES('51235555J','Carmen Capel Pio', 'tarde', 300);
INSERT INTO REPARTIDOR VALUES('55675675J','Juan Sanchez Lopez', 'mañana', 200);
INSERT INTO REPARTIDOR VALUES('99009900J','Alejandro Pardo Lopez', 'mañana', 400);

/* VALORES EN TABLA PEDIDOS */
INSERT INTO PEDIDO VALUES('0001','2020-10-15',10,'11111111Q','04444444T','55675675J','12:00','12:15','12:45');
INSERT INTO PEDIDO VALUES('0002','2020-11-11',15,'22222222S','77777777M','99009900J','13:30','13:45','14:05');
INSERT INTO PEDIDO VALUES('0003','2020-10-15',13,'77777777M','22222222S','99009900J','15:00','15:15','15:45');
INSERT INTO PEDIDO VALUES('0004','2020-11-10',13,'99999999X','77777777M','04477744T','14:02','14:30','14:45');
INSERT INTO PEDIDO VALUES('0005','2020-09-05',14,'14567555L','03232323P','14188151T','19:02','19:30','19:45');
INSERT INTO PEDIDO VALUES('0006','2020-11-15',23,'14567555L','88888888O','04477744T','21:02','21:35','21:45');
INSERT INTO PEDIDO VALUES('0007','2020-09-25',17,'03232323P','88888888O','14188151T','23:05','23:12','23:35');
INSERT INTO PEDIDO VALUES('0008','2020-09-15',14,'99999999X','33333333M','11245621Q','18:02','18:30','18:45');
INSERT INTO PEDIDO VALUES('0009','2020-11-23',25,'04444444T','55555555J','99009900J','11:02','11:30','11:55');
INSERT INTO PEDIDO VALUES('0012','2020-09-23',25,'04444444T','55555555J','99009900J','11:02','11:30','11:45');
INSERT INTO PEDIDO VALUES('0010','2020-11-05',45,'88888888O','14567555L',null,'22:05','22:12',null);
INSERT INTO PEDIDO VALUES('0011','2020-11-05',45,'88888888O','14567555L',null,'22:05',null,null);

/* VALORES EN TABLA consta */
INSERT INTO consta VALUES ('11','0001',2);
INSERT INTO consta VALUES ('12','0001',1);
INSERT INTO consta VALUES ('11','0002',1);
INSERT INTO consta VALUES ('12','0002',2);
INSERT INTO consta VALUES ('15','0002',2);
INSERT INTO consta VALUES ('14','0003',2);
INSERT INTO consta VALUES ('17','0003',1);
INSERT INTO consta VALUES ('13','0004',3);
INSERT INTO consta VALUES ('04','0004',1);
INSERT INTO consta VALUES ('13','0005',2);
INSERT INTO consta VALUES ('12','0005',1);
INSERT INTO consta VALUES ('02','0005',1);
INSERT INTO consta VALUES ('12','0006',2);
INSERT INTO consta VALUES ('13','0006',1);
INSERT INTO consta VALUES ('19','0006',1);
INSERT INTO consta VALUES ('18','0006',1);
INSERT INTO consta VALUES ('12','0007',2);
INSERT INTO consta VALUES ('09','0007',1);
INSERT INTO consta VALUES ('02','0007',1);
INSERT INTO consta VALUES ('13','0008',2);
INSERT INTO consta VALUES ('11','0008',1);
INSERT INTO consta VALUES ('13','0009',4);
INSERT INTO consta VALUES ('15','0009',1);
INSERT INTO consta VALUES ('12','0010',3);
INSERT INTO consta VALUES ('13','0010',3);
INSERT INTO consta VALUES ('16','0010',3);
INSERT INTO consta VALUES ('04','0010',3);
INSERT INTO consta VALUES ('04','0011',2);

--Ejercicio 1
insert into empleado values 
('00000001A', 'Antonio Garcia Lopez', 'NS0000001A', default, 950),
('00000002B', 'Berta Garcia Lopez', 'NS0000002B', 'mañana', null),
('00000003C', 'Antonio Garcia Lopez', 'NS0000003C', null, 500);

insert into repartidor(dni, nombre, incentivo, turno) values
('00000004D', 'Daniel Garcia Lopez', default, null),
('00000005E', 'Ernesto Garcia Lopez', 23, 'mañana'),
('00000006F', 'Federico Garcia Lopez', null, 'tarde');

--Ejercicio 2
insert into pedido(numero, fecha, dni_etm, hora_tm) values
('0013', now(), '11111111Q', now());

insert into consta
select '09', numero_p, 1
from consta
where numero_p = numero;

insert into consta
select '01', numero_p, 1
from consta
where numero_p = numero;

--Ejercicio 3


--Ejercicio 4

update pedido
set importe = importe +10
where fecha =; 


--Ejercicio 5
update pedido
set importe= 
where 

--Ejercicio 6
update repartidor
set incentivo = incentivo+50
where dni in (select dni_r)

--Ejercicio 7

-- Ejercicio 8
update empleado
set salario =salario *1.1;
where ()

--Ejercicio 9

delete from pedido
where dni_r in(select dni
               from repartidor
               where nombre='Alejandro%');

--Ejercicio 10

delete from pedido
where numero in ( select numero_p
                 from consta
                 where codigo_pr in( select codigo
                                     from producto
                                     where nombre='Aqua'));