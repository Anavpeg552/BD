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

--1 Inserta de manera implícita los siguientes registros en la tabla Cliente.
insert into cliente values 
('11111111A', 'Antonio', 'Pérez Torralbo','Bailén', '2000-03-03'),
('22222222B', 'Pedro', 'Ramos López','Linares', '1998-08-16'),
('33333333C', 'Andrea', 'Vilches Ramos','Andújar', '1980-04-23'),
('44444444D', 'Carolina', 'Roja Torres','Linares', '1985-05-12');

--2 Inserta de manera explícita los siguientes animales

insert into animal(nombre,raza,sexo,fec_nac, propietario) values
('Rita', default, 'Hembra' ,'2019-08-24','11111111A'),
('Eva', default,'Macho' ,'2010-07-20','11111111A'),
('Peluso', 'Gato','Macho',null,'22222222B'),
('Rocky', 'Gato', 'Macho','2012-08-14','33333333C'),
('Anibal', 'Loro','Macho','2020-07-15','44444444D');


--3 Inserta los siguientes veterinarios
insert into veterinario values
(1234,'Alicia','Sánchez García', 'Cirugía',2100 ),
(1122,'Gonzalo','Torres Pérez','General',1800),
(1111,'Oscar','García Sánchez','Traumatología',2500);

--4


--5

--6
insert into consulta(descripcion, fecha_hora, importe, animal, veterinario)
select 'Evolucion favorable', now()::timestamp,303a.cod_animal,v.num_licencia+
from animal a, veterinario v
where a.nombre='Anibal' and v.nombre='Oscar';

