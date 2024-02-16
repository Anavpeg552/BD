\c postgres

drop database if exists clinica_veterinaria;

create database clinica_veterinaria;

\c clinica_veterinaria;

create table if not exists cliente(
	dni char(9) primary key,
    nombre varchar(25) not null,
    apellidos varchar(25) not null,
    localidad varchar(25),
    fec_nac date
);
create domain dsexo as varchar(10)
not null
check (value in ('hembra', 'macho'));

create table if not exists animal(
	cod_animal serial primary key,
    nombre varchar(25),
    raza varchar(25) default 'Perro',
    sexo dsexo,
    fec_nac date,
    propietario char(9) not null,
    constraint Cli_Ani_FK foreign key(propietario) references cliente(dni)
);

create domain despecialidad as varchar(15)
default 'general'
check (value in('cirugia', 'general', 'traumatologia'));

create table if not exists veterinario(
	num_licencia char(4) primary key,
    nombre varchar(25) not null,
    apellidos varchar(50) not null,
    especialidad despecialidad,
    salario decimal(6,2) not null
);

create domain dmotivo as varchar(15)
default 'revision'
check (value in ('vacuna','revision','cirugia'));

create table if not exists Consulta(
	codigo serial primary key,
    descripcion varchar(200),
    fecha_hora timestamp not null,
    motivo dmotivo,
    importe decimal(7,2),
    animal int not null,
    veterinario char(4) not null,
    constraint Ani_Con_FK foreign key(animal) references animal(cod_animal),
    constraint Vet_Con_FK foreign key(veterinario) references veterinario(num_licencia)
);