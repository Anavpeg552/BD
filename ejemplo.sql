\c postgres;


-- Creamos la bd mercado
drop database if exists mercado;

-- Creamos la BD
create database mercado; 

-- Seleccionamos la BD
\c mercado; 

-- Creamos la tabla Proveedor
create table if not exists proveedor(
    cif char(9) primary key,
    nombre varchar(50) not null unique,
    direcion varchar(100) not null
);

-- Creamos la tabla producto
create table if not exists producto(
    codigo serial primary key,
    nombre varchar(50) not null unique,
    precio decimal(6,2) not null check(precio>=0),
    tipo varchar(12) not null check(tipo in('alimentacion', 'bebida', 'higiene', 'limpieza')) default'alimentacion',
    descripcion varchar(100),
    cif_prov char(9) not null,
    foreign key(cif_prov) references proveedor(cif)
);

-- Creamos la tabla cliente
create table if not exists cliente(
    dni char(9) primary key,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) not null,
    edad smallint not null check(edad between 0 and 150),
    unique(nombre, apellido1, apellido2)
);

create table if not exists compra(
    dni char(9),
    codigo int,
    fecha timestamp default current_timestamp,
    unidades smallint not null check(unidades > 0),
    primary key(dni, codigo, fecha),
    foreign key(dni) references cliente(dni),
    foreign key(codigo) references producto(codigo)
);