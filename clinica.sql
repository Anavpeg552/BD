\c postgres;


-- Creamos la bd mercado
drop database if exists clinica;

-- Creamos la BD
create database clinica; 

-- Seleccionamos la BD
\c clinica; 
create schema if not exists pacientes;
create domain tipo_ap as varchar(50)
not null
check(value in('Garcia', 'Rodríguez','López'))
default 'Garcia';

create sequence serialv2 as int
increment by 5
minvalue 100
maxvalue 900
start with 150
cache 20
no cycle;


create table if not exists pacientes.paciente(
    codigo int primary key default nextval('serialv2'),
    num_seg_soc char(16) unique not null,
    nombre varchar(50) not null,
    apellido1 tipo_ap,
    apelido2 tipo_ap,
    direccion varchar(100) not null,
    fec_nac date not null,
    check (fec_nac between '1900-01-01' and '2300-12-31')
);

create table if not exists medico(
    cod_medico serial primary key, 
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) not null,
    telefono char(9) unique not null,
    especialidad varchar(12) not null default 'General',
    check (especialidad in ('General', 'Cirujano', 'Digestivo', 'Ginecologia'))
);

create table if not exists ingreso(
    cod_pac int,
    fecha timestamp default current_timestamp,
    num_hab smallint not null,
    num_cama char(1) not null,
    fecha_alta timestamp,
    cod_med int not null,
    primary key(cod_pac, fecha),
    foreign key(cod_pac) references pacientes.paciente,
    check(fecha_alta > fecha),
    check(num_cama in ('A', 'B', 'C')),
    check(num_hab between 1 and 200)
);

create table if not exists prueba(
    codigo bigserial primary key,
    fecha timestamp not null,
    resultado varchar(200),
    finalizada boolean not null,
    fecha_ing timestamp not null,
    cod_pac int not null,
    foreign key(cod_pac, fecha_ing) references ingreso
);

create table if not exists categoria(
    codigo smallserial primary key,
    nombre varchar(100) not null,
    descripcion varchar(200) not null,
    unique(nombre, descripcion)
);

create table if not exists pertenece(
    cod_cat smallint,
    cod_pru bigint,
    primary key(cod_cat, cod_pru),
    foreign key(cod_cat) references categoria,
    foreign key(cod_pru) references prueba
);

--renombrar una tabla 
alter table if exists pertenece rename to contiene;

--renombrar una columna
alter table if exists contiene rename column cod_cat to categoria;

--renombrar una restriccion
alter table if exists contiene rename constraint pertenece_cod_cat_fkey to pepito;

--añadimos una columna
alter table if exists medico add column if not exists email varchar(50) not null;

--eliminamos una columna
alter table if exists medico drop column if exists email;

-- añadir restriccion
alter table if exists ingreso add constraint restriccion_hora check(fecha <= current_timestamp);

-- borrar una restriccion 
alter table if exists ingreso drop constraint if exists restriccion_hora;

-- modificar columnas
--Eliminando y añadiendo restricciones not null
alter table if exists medico alter apellido2 drop not null;

alter table if exists medico alter apellido2 set not null;

--Eliminando y añadiendo restricciones default
alter table if exists categoria alter nombre set default 'Sin_nombre';

alter table if exists categoria alter nombre drop default;

--Modificar el tipo de datos 
alter table if exists categoria alter descripcion type varchar(300);

--modificar el esquema de una tabla 
alter table medico set schema pacientes;
