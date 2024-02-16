\c postgres

drop database if exists editorial;

create database editorial;

\c editorial

create table if not exists empleado(
    num_emp serial primary key,
    nombre varchar(50) not null,
    apellidos varchar(50) not null,
    direccion varchar(50) not null,
    fecha_alta date not null
);

create table if not exists director(
    num_emp int primary key,
    titulacion varchar(50),
    supervisor int,
    foreign key (num_emp) references empleado (num_emp),
    foreign key (supervisor) references director (num_emp)
);

create table if not exists oficina(
    codigo serial primary key,
    direccion varchar(50) not null,
    telefono char(9) not null,
    fecha_aper date not null,
    director int not null,
    foreign key (director) references director (num_emp)
);

create table if not exists vendedor(
    num_emp int primary key,
    turno varchar(20) not null,
    oficina int,
    foreign key (num_emp) references empleado (num_emp),
    foreign key (oficina) references oficina (codigo)
);

create table if not exists cliente(
    dni char(9) primary key,
    nombre varchar(50) not null,
    apellidos varchar(50) not null,
    direccion varchar(50) not null,
    telefono char(9) not null,
    email varchar(50) not null
);

create table if not exists venta(
    codigo serial primary key,
    fecha date not null,
    descuento decimal,
    forma_pago varchar(50) not null,
    vendedor int,
    cliente char(9) not null,
    foreign key (vendedor) references vendedor (num_emp),
    foreign key (cliente) references cliente (dni)
);

create table if not exists autor(
    codigo serial primary key,
    nombre varchar(50) not null,
    sexo char(1),
    nacionalidad varchar(50)
);

create table if not exists libro(
    codigo serial primary key,
    isbn char(12) unique not null,
    titulo varchar(100) unique not null,
    edicion smallint unique not null,
    autor int not null,
    foreign key (autor) references autor (codigo)
);

create table if not exists contiene(
    cod_libro int,
    cod_venta int,
    unidades smallint not null,
    precio_venta decimal not null,
    foreign key (cod_libro) references libro (codigo),
    foreign key (cod_venta) references venta (codigo),
    primary key (cod_libro, cod_venta)
);

--1
alter table autor rename sexo to genero;

--2
alter table director drop titulacion;

--3
alter table empleado add email varchar(50) unique not null;

--4


--5
alter table contiene add check(unidades between 1 and 50);

alter table contiene alter unidades set default 1;

--6
alter table empleado alter fecha_alta type timestamp;

--7
alter table venta add constraint venta_fecha_ck check(fecha <= current_timestamp);

--8
alter table venta rename constraint venta_fecha_ck to ven_fec_check;

--9
alter table venta drop constraint ven_fec_check;

--10
create domain d_turno as varchar(9)
not null
check(value in('mañana','tarde','intensivo','partido'))
default 'intensivo';

alter table vendedor alter turno type d_turno;

--11
alter table venta add check(descuento in (0,10,25,50));

alter table venta alter descuento set default 0;

--12
alter table contiene alter precio_venta type decimal(5,2);

--13
alter table autor alter nacionalidad set not null;

--14
alter table oficina alter telefono drop not null;

--15
alter table venta alter descuento drop default;