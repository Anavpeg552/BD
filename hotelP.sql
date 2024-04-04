\c postgres;

drop database if exists hotelP;

create database hotelP;
\c hotelP;

create table if not exists categoria(
    id_categoria int primary key,
    descripcion varchar(200) not null,
    iva int not null
);

create table if not exists hotel(
    codigo serial primary key,
    nombre varchar(50) not null,
    direccion varchar(100) not null,
    telefono char(9) unique not null,
    anio char(4) not null,
    id_categoria varchar(50),
    foreign key(id_categoriac) references categoria

);

create table if not exists habitacion(
    n_hab int ,
    tam,
    precio,
    tipo,
    cod_hotel
);

create table if not exists cliente(
    dni,
    nombre,
    direccion,
    telefono
);

create table if not exists reserva(
    cod_hotel,
    n_hab,
    dni,
    f_ini,
    f_fin,
    importe
);