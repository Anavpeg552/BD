\c postgres
drop database if exists ud7;
create database ud7;
\c ud7;
CREATE TABLE IF NOT EXISTS departamento(
    iddept serial PRIMARY KEY,
    nombre varchar(50) not null unique,
    ciudad varchar(25)
);
CREATE TABLE IF NOT EXISTS empleado (
    idemp serial PRIMARY KEY,
    nombre varchar(25) not null,
    apellidos varchar(50) not null,
    movil char(9),
    email varchar(30),
    dept int,
    FOREIGN KEY (dept) references departamento(iddept)
);

insert into departamento (nombre, ciudad) values
('Ventas', 'Sevilla'),
('Marketing', 'Toledo'),
('Compras', 'Jaen');

insert into empleado (nombre,apellidos,movil,email, dept) values 
('Manolo','Perales Arenas','610325679','manper@yahoo.es', 1),
('Manolo','Hueso Robles','654783212','huesomajo@gmail.com', 1),
('Emilio','Iniesta Garcia','621465921','einival@yahoo.es', null),
('Gerard','Garcia Valero','610983676','gerardpr@hotmail.com', 2),
('Justino','Gallego Garcia','645202221','justinayto@gmail.com', 2),
('Paco','Mata Linares','699564735','pamatmat@yahoo.es', 2),
('Andres','Gazquez Romero','611419675','gazmarmol@gmail.com', 3);

/* CREATE TABLE IF NOT EXISTS modificaciones_agenda ( 
idmodifica serial PRIMARY KEY, 
codigoagenda integer not null, 
atributo_modificado varchar(10) not null, 
valor_antiguo_atributo varchar(50), 
valor_nuevo_atributo varchar(50), 
fecha_modificacion timestamp not null 
); */
