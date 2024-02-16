\c postgres

drop database compras;

create database compras;

\c compras;
create domain dNivelEmp as varchar(15)
default 'basico'
check (value in ('basico', 'intermedio', 'gerente'));

create table if not exists empleado(
	codigo serial primary key,
    nombre varchar(20) not null,
    apellidos varchar(40) not null,
    salario decimal(6,2),
    fecha_cont date not null,
    nivel dNivelEmp
); 

create table if not exists cliente(
	codigo serial primary key,
    nombre varchar(20) not null,
    apellidos varchar(40) not null,
    fecha_nac date not null
); 

create table if not exists proveedor(
	codigo serial primary key,
    nombre varchar(50) not null,
    ciudad varchar(20)
);

create table if not exists producto(
	codigo serial primary key,
    nombre varchar(50) not null,
    precioCom decimal(6,2) not null,
    precioVen decimal(6,2) not null,
    stock smallint not null,
    cod_prov int not null
);

create table if not exists compra(
	codigo serial primary key,
    fec_hora timestamp default current_timestamp,
    descuento decimal(5,2),
    cod_cli int not null,
    cod_emp int not null,
    constraint Com_Cli_FK foreign key(cod_cli) references cliente(codigo) on delete cascade,
    constraint Com_Emp_FK foreign key(cod_emp) references empleado(codigo)
);

create table if not exists contiene(
	cod_com int,
    cod_pro int,
    unidades smallint default 1,
    constraint Con_PK primary key(cod_com,cod_pro),
    constraint Con_Com_FK foreign key(cod_com) references compra(codigo),
    constraint Con_Pro_FK foreign key(cod_pro) references producto(codigo)
);


insert into cliente(nombre,apellidos,fecha_nac)
values	('Antonio','López Pérez','1992-05-25'),
		('Ana','García Torres','2001-09-10'),
		('Luis','Antón García','1978-02-11'),
		('Gregorio','Fuentes Salinas','1982-06-12'),
		('Jimena','Castro Hidalgo','1999-04-21'),
		('Rebeca','López Toledano','2003-06-05'),
		('Pedro','Pérez Ruíz','1999-09-09'),
		('Julia','García Muñoz','2000-06-30');
    
insert into empleado(nombre,apellidos,salario,fecha_cont,nivel)
values	('Juan','Blanco Pérez',2000,'2021-01-01','gerente'),
		('Ana','López Pérez',1500,'2021-02-02','intermedio'),
        ('Luisa','Pérez Villarejo',1600,'2021-03-03','intermedio'),
        ('Ángel','García López',1000,'2021-12-05',default),
        ('Jorge','Fernández Pla',null,'2022-03-23',default);
        
insert into proveedor(nombre,ciudad)
values  ('Atlantis S.L.','Bailén'),
		('IMS','Linares'),
        ('APP Informática','Linares'),
        ('Componentes del Sur S.L.','Andújar'),
        ('InfoTec S.L.','Baena');

insert into producto(nombre,precioCom,precioVen,stock,cod_prov)
values	('Disco Duro SSD 256 Gb',140,220,6,1),
		('Impresora 3D Nantius',580,760,2,2),
        ('Ratón Genius',10,15,9,1),
        ('Teclado Radius',30,50,6,3),
        ('Placa Base Neox',180,300,6,4),
        ('Tarjeta Gráfica Nvidia',80,150,10,3),
        ('Disco Duro SSD 512 Gb',180,260,9,1),
        ('Monitor Samsung',160,240,5,2);
        
insert into compra(fec_hora,descuento,cod_emp,cod_cli)
values	('2022-03-10 11:30:00',0,1,1),
		('2022-03-10 12:30:00',0,2,2),
        ('2022-03-10 17:00:00',20,3,3),
        ('2022-02-11 09:30:00',20,1,1),
        ('2022-02-11 16:30:00',20,2,4),
        ('2022-02-13 11:30:00',0,3,5),
        ('2022-02-13 08:30:00',0,4,2),
        ('2022-02-11 10:30:00',10,4,6),
        ('2022-01-20 14:30:00',10,2,7);
        
insert into contiene(cod_com,cod_pro,unidades)
values	(1,2,1),
		(1,4,2),
        (2,5,1),
        (3,7,3),
        (3,1,2),
        (4,2,1),
        (5,6,3),
        (6,4,1),
        (7,1,1),
        (7,3,2),
        (7,5,3),
        (8,8,1),
        (8,7,1),
        (9,8,3);

--Ejercicio 1 implicita=no poner nombre campo

insert into compra values
(default, default, null, 2,3);


--Ejercicio 2

insert into empleado(nombre, apellidos, fecha_cont) values
('Antonio', 'González Jimenez', now());





insert into cliente values 
(default, 'Antonio', 'López Pérez', '1992-05-25'),
(default, 'Ana', 'García Torres', '2001-09-10');

insert into empleado values
(default, 'Juan', 'Blaco Pérez', 2000, '20221-01-01','gerente');

insert into compra values
(default, default, null, 1, 1);

insert into compra(cod_emp, cod_cli)
values(1,2);

insert into cliente(nombre, apellidos, fecha_nac) values
('Luis', 'Antón García', now());

/*
/*
update cliente
set nombre='Ana';*/

/*
update cliente
set nombre='Rosa'
where codigo = 2;*/

select codigo
from cliente
where codigo not in (select co_cli 
                     from compra);

update cliente
set nombre= 'Pepe', apellidos='García García'
where codigo not in (select co_cli 
                     from compra);

delete from cliente
where codigo in(select cod_cli, from compra, group by cod_cli, having count(*)=1);


create table if not exists cliente_historico(
    codigo int primary key,
    nombre varchar(20) not null,
    apellidos varchar(40) not null
    fecha_baja date not null,
    motivo varchar(40)
);

insert into cliente_historico
select codigo, nombre, apellidos, now(), 'Demasiada publi'
from cliente
where codigo in (select cod_cli
                 from compra
                 group by co_cli
                 having count (*)=1);


*/

--6
-- Creamos la tabal ofertas
create table ofertas(
    cod_pro int,
    fecha_ini date,
    fecha_fin date,
    descuento int, 
    precioOferta decimal(6,2),
    primary key(cod_pro, fecha_ini),
    foreign key (cod_pro) references producto
);

insert into ofertas
select codigo, now(), now()+cast('20 days' as INTERVAL), 20, precioVen*0.8
from producto
where lower(nombre) like '%disco duro%';

--UPDATES
--1
update empleado
set salario =salario *1.1
where nivel ='intermedio';

--2
update producto
set precioVen = 20, stock=20
where lower(nombre)= 'ratón genius';

--3
update producto
set precioVen= precioVen +5
where codigo in( select)

--4
update proveedor
set nombre = 'Componentes Infórmaticos S.L'
where lower(ciudad)='baena';


--BORRADO
--1 Elimina todo los datos de la tabla Ofertas
delete from ofertas;

--2
delete from contiene
where cod_pro=5;

delete from producto
where codigo=5;

--3

delete from compra
where cod_emp in(
                    select codigo
                    from empleado
                    where nombre = 'Antonio'
);

delete from empleado
where nombre='Antonio';

--4

delete from contiene
where cod_com in (
    select codigo
    from compra
    where fec_hora:: date='2022-02-13' and 
    cod_cli in (select cliente
                from cliente
                where nombre ='Ana' and apellidos ='García Torres'
    )

)and cod_pro in (select codigo from producto where nombre='Ratón Genius');

--5

delete from contiene 