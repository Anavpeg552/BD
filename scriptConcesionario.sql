\c postgres

DROP DATABASE automoviles;

CREATE DATABASE automoviles;

\c automoviles;

CREATE TABLE cliente (
    dni char(9) primary key,
    nombre varchar(25) NOT NULL,
    apellido varchar(25) NOT NULL,
    ciudad varchar(25) NOT NULL
);


CREATE TABLE coche (
    codigo smallserial primary key,
    nombre varchar(25) NOT NULL,
    modelo varchar(25) NOT NULL
);


CREATE TABLE concesionario (
    codigo smallserial primary key,
    nombre varchar(25) NOT NULL,
    ciudad varchar(25) NOT NULL
);


CREATE TABLE stock (
    cod_conce smallint,
    cod_coche smallint,
    cantidad smallint NOT NULL,
    constraint dis_PK Primary Key(cod_conce,cod_coche),
    constraint dis_conc_FK foreign key(cod_conce) references concesionario(codigo),
    constraint dis_coc_FK foreign key(cod_coche) references coche(codigo)
);


CREATE TABLE distribuidora (
    codigo smallserial primary key,
    nombre varchar(25) NOT NULL,
    ciudad varchar(25) NOT NULL
);


CREATE TABLE distribuye (
    cod_distri smallint NOT NULL,
    cod_coche smallint NOT NULL,
    constraint mar_PK primary key(cod_distri,cod_coche),
    constraint mar_coc_FK foreign key(cod_coche) references coche(codigo),
    constraint mar_mar_FK foreign key(cod_distri) references distribuidora(codigo)
);

CREATE TABLE venta (
    cod_conce smallint,
    cod_coche smallint,
    dni_cli char(9),
    color varchar(25) NOT NULL,
    constraint ven_PK primary key(cod_conce,cod_coche,dni_cli),
    constraint ven_con_FK foreign key(cod_conce) references concesionario(codigo),
    constraint ven_coc_FK foreign key(cod_coche) references coche(codigo),
    constraint ven_cli_FK foreign key(dni_cli) references cliente(dni)
);

insert into cliente(dni,nombre,apellido,ciudad)
values
('11111111A','luis', 'garcía','madrid'),
('22222222B','antonio', 'lópez','valencia'),
('33333333C','juan', 'martín','madrid'),
('44444444D','maría', 'garcía','madrid'),
('55555555E','javier', 'gonzález','barcelona'),
('66666666F','ana', 'lópez','barcelona')
;

insert into coche(nombre, modelo)
values
('ibiza', 'glx'),
('ibiza','gti'),
('ibiza','gtd'),
('toledo','gtd'),
('cordoba','gti'),
('megane','1.6'),
('megane','gti'),
('laguna','gtd'),
('laguna','gtd'),
('laguna','td'),
('zx','16v'),
('zx','td'),
('xantia','gtd'),
('a4','1.8'),
('a4','2.8'),
('astra','caravan'),
('astra','gti'),
('corsa','1.4'),
('300','316i'),
('500','525i'),
('700','750i')
;

insert into concesionario (nombre, ciudad)
values
('acar','madrid'),
('bcar','madrid'),
('ccar','barcelona'),
('dcar','valencia'),
('ecar','bilbao')
;

insert into stock (cod_conce, cod_coche, cantidad) 
values
(1,1,3),
(1,5,7),
(1,6,7),
(2,6,5),
(2,8,10),
(2,	9,	10),
(3,	10,	5),
(3,	11,	3),
(3,	12,	5),
(4,	13,	10),
(4,	14,	5),
(5,	15,	10),
(5,	16,	20),
(5,	17,	8)
;

insert into distribuidora (nombre, ciudad) 
values
('seat','madrid'),
('renault','barcelona'),
('citroen','valencia'),
('audi','madrid'),
('opel','bilbao'),
('bmw','barcelona')
;

insert into distribuye (cod_distri, cod_coche) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(2,6),
(2,7),
(2,8),
(2,9),
(3,10),
(3,11),
(3,12),
(4,13),
(4,14),
(5,15),
(5,16),
(5,17),
(6,18),
(6,19),
(6,20)
;

insert into venta (cod_conce, cod_coche, dni_cli, color)
values
(1,1,'11111111A','blanco'),
(1,2,'55555555E','rojo'),
(2,3,'22222222B','blanco'),
(2,1,'66666666F','rojo'),
(3,4,'33333333C','rojo'),
(4,5,'44444444D','verde'),
(5,5,'44444444D','blanco')
;