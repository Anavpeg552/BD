\c postgres

DROP DATABASE IF EXISTS atletismo;

CREATE DATABASE atletismo;

\c atletismo

create domain dsexo CHARACTER
check (value in ('F', 'M'));
create domain dobstaculos CHARACTER
check (value in ('S', 'N'));

CREATE TABLE universidad(
codigo varchar(4) PRIMARY KEY,
nombre varchar(40) UNIQUE,
entrenador varchar(40),
provincia varchar(40),
comunidad varchar(50),
puntos_acumulados int check (puntos_acumulados >= 0));

CREATE TABLE atleta(
dorsal varchar(6) primary key,
nombre varchar(20),
apellidos varchar(20),
sexo dsexo,
fec_nac date not null,
universidad varchar(20),
constraint atl_uni_FK foreign key (universidad)
references universidad(codigo) on delete set null);

CREATE TABLE prueba(
codigo varchar(10) primary key,
distancia smallint check (distancia >= 0),
obstaculos dobstaculos,
categoria dsexo,
fec_hora timestamp,
rec_universitario time,
rec_nacional time);

CREATE TABLE competir(
dorsal_atl varchar(6),
codigo_pru varchar(6),
marca_personal time,
posicion smallint,
puntos int,
constraint com_dor_cod_PK primary key(dorsal_atl, codigo_pru),
constraint com_dor_FK foreign key(dorsal_atl)
references ATLETA (dorsal) on delete cascade,
constraint com_cod_FK foreign key(codigo_pru)
references PRUEBA (codigo) on delete cascade);

CREATE TABLE podium(
nombre varchar(20),
apellidos varchar(20),
universidad varchar(20),
posicion smallint,
prueba varchar(10),
marca_personal time
);

INSERT INTO universidad VALUES ('UA','Universidad de Alicante','Pedro Pérez Blanes','Alicante','Comunidad Valenciana',NULL);
INSERT INTO universidad VALUES ('UAM','Universidad Autónoma de Madrid','Luis Sobera Linde', 'Madrid','Comunidad de Madrid',NULL);
INSERT INTO universidad VALUES ('UAB','Universidad Autónoma de Barcelona','María Guerrero Sempere','Barcelona','Cataluña',NULL);
INSERT INTO universidad VALUES ('UAL','Universidad de Almería','José Luis Rodríguez Sainz','Almería','Andalucía',NULL);
INSERT INTO universidad VALUES ('UGR','Universidad de Granada','Marta Benítez Pérez','Granada','Andalucía',NULL);
INSERT INTO universidad VALUES ('UIB','Universidad de Islas Baleares','Jaime López Valenzuela','Mallorca','Islas Baleares',NULL);
INSERT INTO universidad VALUES ('UPV','Universidad Politécnica de Valencia','Claudia Lareda Expósito','Valencia','Comunidad Valenciana',NULL);
INSERT INTO universidad VALUES ('US','Universidad de Sevilla','Jorge Luengo Valdivia','Sevilla','Andalucía',NULL);

INSERT INTO atleta VALUES ('0151', 'Jaime','Pérez López','M','1998-01-20','UAL');
INSERT INTO atleta VALUES ('0152', 'Lucía','Gil Martínez','F','1998-01-15','UA');
INSERT INTO atleta VALUES ('0153', 'Adrián','Ruíz García','M','1995-02-11','UA');
INSERT INTO atleta VALUES ('0154', 'Pedro','Sanz Lorenzo','M','1996-02-01','UAM');
INSERT INTO atleta VALUES ('0155', 'Carmen','Aguirre Soria','F','1997-03-02','UPV');
INSERT INTO atleta VALUES ('0156', 'Carlos','Beltrán Gómez','M','1998-03-12','UAB');
INSERT INTO atleta VALUES ('0157', 'José','Gómez Gil','M','1998-03-11','UA');
INSERT INTO atleta VALUES ('0158', 'Manuel','Rodríguez Castilla','M','1997-04-21','UPV');
INSERT INTO atleta VALUES ('0159', 'Sara','Castro Ramírez','F','1996-04-28','UAB');
INSERT INTO atleta VALUES ('0160', 'María','Valenzuela Garó','F','1996-05-26','UA');
INSERT INTO atleta VALUES ('0161', 'Juan','Martínez García','M','1997-05-12','UGR');
INSERT INTO atleta VALUES ('0162', 'Luis','Suliman Tez','M','1996-06-11','US');
INSERT INTO atleta VALUES ('0163', 'Diego','Arganda Ruíz','M','1997-06-10','UIB');
INSERT INTO atleta VALUES ('0164', 'Vicente','Gómez Romero','M','1995-07-08','UIB');
INSERT INTO atleta VALUES ('0165', 'Laura','Valle Suárez','F','1998-08-09','UAB');
INSERT INTO atleta VALUES ('0166', 'Carlota','Campillo Pérez','F','1998-08-10','UAL');
INSERT INTO atleta VALUES ('0167', 'Vanesa','Pérez Soriano','F','1996-09-12','US');
INSERT INTO atleta VALUES ('0168', 'Jorge','Prieto Lillo','M','1997-09-24','UAM');
INSERT INTO atleta VALUES ('0169', 'Sergio','Blanco Rodríguez','M','1997-10-25','UAM');
INSERT INTO atleta VALUES ('0170', 'Alex','Castillo Giménez','M','1996-11-26','UGR');
INSERT INTO atleta VALUES ('0171', 'Mauro','Silva Torres','M','1996-11-27','US');
INSERT INTO atleta VALUES ('0172', 'Silvia','Sanz Barberó','F','1996-12-11','US');
INSERT INTO atleta VALUES ('0173', 'Luisa','Fernández López','F','1996-03-01','UA');
INSERT INTO atleta VALUES ('0174', 'Carolina','Estévez Peláez','F','1998-11-03','UIB');
INSERT INTO atleta VALUES ('0175', 'Alba','Gil Muñoz','F','1997-10-12','US');
INSERT INTO atleta VALUES ('0176', 'Mar','Palao Yuste','F','1996-10-03','UAB');
INSERT INTO atleta VALUES ('0177', 'Candela','Martínez Gómez','F','1996-08-23','UAM');
INSERT INTO atleta VALUES ('0178', 'Carla','Suárez Pineda','F','1997-07-14','UAM');


INSERT INTO prueba VALUES ('100LM',100,'N','M','2017-02-03 09:00:00', '00:00:10.110','00:00:10.060');
INSERT INTO prueba VALUES ('100LF',100,'N','F','2017-02-03 09:30:00', '00:00:12.020','00:00:11.060');
INSERT INTO prueba VALUES ('400VM',400,'S','M','2017-02-03 10:00:00', '00:00:50.080','00:00:48.870');
INSERT INTO prueba VALUES ('400VF',400,'S','F','2017-02-03 10:30:00', '00:00:57.198','00:00:55.230');
INSERT INTO prueba VALUES ('1500M',1500,'N','M','2017-02-04 12:00:00', '00:04:02.380','00:03:28.950');
INSERT INTO prueba VALUES ('1500F',1500,'N','F','2017-02-04 9:00:00', '00:04:37.010','00:03:59.410');
INSERT INTO prueba VALUES ('3000OM',3000,'S','M','2017-02-04 11:00:00', '00:10:13.830','00:08:07.440');
INSERT INTO prueba VALUES ('3000OF',3000,'S','F','2017-02-05 09:00:00', '00:11:12.380','00:09:07.320');

INSERT INTO competir VALUES ('0151','100LM','00:00:10.560',2,20);
INSERT INTO competir VALUES ('0153','100LM','00:00:10.210',1,30);
INSERT INTO competir VALUES ('0157','100LM','00:00:10.610',3,15);
INSERT INTO competir VALUES ('0158','100LM','00:00:12.410',8,0);
INSERT INTO competir VALUES ('0161','100LM','00:00:10.790',4,10);
INSERT INTO competir VALUES ('0162','100LM','00:00:10.990',5,5);
INSERT INTO competir VALUES ('0163','100LM','00:00:11.230',6,0);
INSERT INTO competir VALUES ('0168','100LM','00:00:11.980',7,0);
INSERT INTO competir VALUES ('0152','100LF','00:00:12.100',1,30);
INSERT INTO competir VALUES ('0155','100LF','00:00:14.050',8,0);
INSERT INTO competir VALUES ('0160','100LF','00:00:12.120',2,20);
INSERT INTO competir VALUES ('0166','100LF','00:00:12.560',4,10);
INSERT INTO competir VALUES ('0167','100LF','00:00:13.790',5,5);
INSERT INTO competir VALUES ('0172','100LF','00:00:13.880',6,0);
INSERT INTO competir VALUES ('0176','100LF','00:00:12.220',3,15);
INSERT INTO competir VALUES ('0177','100LF','00:00:14.000',7,0);
INSERT INTO competir VALUES ('0151','400VM','00:00:53.890',8,0);
INSERT INTO competir VALUES ('0153','400VM','00:00:50.420',1,30);
INSERT INTO competir VALUES ('0154','400VM','00:00:52.080',6,0);
INSERT INTO competir VALUES ('0156','400VM','00:00:50.780',2,20);
INSERT INTO competir VALUES ('0158','400VM','00:00:51.390',4,10);
INSERT INTO competir VALUES ('0163','400VM','00:00:51.120',3,15);
INSERT INTO competir VALUES ('0164','400VM','00:00:52.020',5,5);
INSERT INTO competir VALUES ('0170','400VM','00:00:53.000',7,0);
INSERT INTO competir VALUES ('0159','400VF','00:00:58.500',4,10);
INSERT INTO competir VALUES ('0165','400VF','00:00:57.340',2,20);
INSERT INTO competir VALUES ('0166','400VF','00:00:58.550',5,5);
INSERT INTO competir VALUES ('0167','400VF','00:00:58.230',3,15);
INSERT INTO competir VALUES ('0172','400VF','00:00:59.580',8,0);
INSERT INTO competir VALUES ('0178','400VF','00:00:59.330',7,0);
INSERT INTO competir VALUES ('0176','400VF','00:00:59.100',6,0);
INSERT INTO competir VALUES ('0174','400VF','00:00:57.230',1,30);
INSERT INTO competir VALUES ('0153','1500M','00:04:03.380',1,30);
INSERT INTO competir VALUES ('0171','1500M','00:04:09.380',2,20);
INSERT INTO competir VALUES ('0169','1500M','00:04:17.380',5,5);
INSERT INTO competir VALUES ('0168','1500M','00:04:15.380',4,10);
INSERT INTO competir VALUES ('0162','1500M','00:04:12.380',3,15);
INSERT INTO competir VALUES ('0161','1500M','00:04:22.380',6,0);
INSERT INTO competir VALUES ('0156','1500M','00:04:31.380',7,0);
INSERT INTO competir VALUES ('0151','1500M','00:04:55.380',8,0);
INSERT INTO competir VALUES ('0154','1500M','00:05:02.380',9,0);
INSERT INTO competir VALUES ('0157','1500M','00:05:52.380',10,0);
INSERT INTO competir VALUES ('0153','3000OM','00:10:43.030',4,10);
INSERT INTO competir VALUES ('0171','3000OM','00:10:32.130',2,20);
INSERT INTO competir VALUES ('0169','3000OM','00:11:42.000',8,0);
INSERT INTO competir VALUES ('0168','3000OM','00:10:14.120',1,30);
INSERT INTO competir VALUES ('0162','3000OM','00:10:40.460',3,15);
INSERT INTO competir VALUES ('0161','3000OM','00:11:15.220',6,0);
INSERT INTO competir VALUES ('0156','3000OM',NULL,NULL,NULL);
INSERT INTO competir VALUES ('0151','3000OM','00:12:40.100',11,0);
INSERT INTO competir VALUES ('0154','3000OM','00:11:22.540',7,0);
INSERT INTO competir VALUES ('0157','3000OM','00:12:05.020',10,0);
INSERT INTO competir VALUES ('0158','3000OM','00:10:59.230',5,5);
INSERT INTO competir VALUES ('0164','3000OM','00:11:53.130',9,0);
INSERT INTO competir VALUES ('0173','1500F','00:04:55.210',2,20);
INSERT INTO competir VALUES ('0174','1500F','00:04:59.350',3,15);
INSERT INTO competir VALUES ('0175','1500F','00:06:13.050',10,0);
INSERT INTO competir VALUES ('0178','1500F','00:06:04.600',9,0);
INSERT INTO competir VALUES ('0167','1500F','00:05:57.880',8,0);
INSERT INTO competir VALUES ('0165','1500F','00:05:27.110',6,0);
INSERT INTO competir VALUES ('0159','1500F','00:05:38.450',7,0);
INSERT INTO competir VALUES ('0152','1500F','00:04:39.230',1,30);
INSERT INTO competir VALUES ('0160','1500F','00:05:03.140',4,10);
INSERT INTO competir VALUES ('0166','1500F','00:05:23.440',5,5);
INSERT INTO competir VALUES ('0173','3000OF','00:11:45.100',4,10);
INSERT INTO competir VALUES ('0174','3000OF','00:12:20.050',7,0);
INSERT INTO competir VALUES ('0175','3000OF','00:11:48.550',5,5);
INSERT INTO competir VALUES ('0178','3000OF','00:12:34.120',8,0);
INSERT INTO competir VALUES ('0167','3000OF','00:11:22.180',1,30);
INSERT INTO competir VALUES ('0165','3000OF','00:11:32.115',3,15);
INSERT INTO competir VALUES ('0159','3000OF','00:12:55.320',9,0);
INSERT INTO competir VALUES ('0152','3000OF','00:11:24.290',2,20);
INSERT INTO competir VALUES ('0160','3000OF','00:12:09.170',6,0);
INSERT INTO competir VALUES ('0166','3000OF',null,null,null);
INSERT INTO competir VALUES ('0172','3000OF','00:13:22.150',10,0);
INSERT INTO competir VALUES ('0176','3000OF',null,null,null);