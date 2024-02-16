-- Consultar todos los datos de los empleados de la empresa
select *
from empleado;

-- Consultar nombre y salario de todos los empleados
select nombre, salario
from empleado;

-- Consultar el codigo de empleado y nombre renombrando la columna codigo
select cdemp as "Código de Empleado", nombre as empleado
from empleado;

-- Consultar todos los salarios sin repetir de los empleados 
select distinct salario
from empleado;

-- Mostrar las ciudades sin repetir donde se ubican los departamentos
select distinct ciudad
from departamento;

-- Mostrar el nombre de todos los proyectos y el código de departmaneto asociado
select nombre, cddep
from proyecto;

--Mostrar el código de departamento y su nombre asociado
select cddep, nombre
from departamento;

--Mostrar todos los códigos de empleados que son jefe sin repetición
select distinct cdjefe
from empleado;

--Ordenar registros
select * 
from empleado
order by nombre desc;

--Mostrar todos los datos de los empleados ordenados de mayor a menor salario
select *
from empleado
order by salario desc, nombre;

select nombre, fecha_ingreso, salario
from empleado
order by 3 desc, 1;

select nombre 
from empleado
order by salrio;

-- Mostrar todo el contenido de la tabla trabaja. Crear alias para los nombres
-- de las columnas de modo que el nombre que se muestre sea: Empleado, Proyecto, Numero de Horas.

select cdemp as "Empleado", cdpro as "Proyecto", nhoras as "Número de Horas"
from trabaja;

-- Mostrar el nombre de todos los empleados yt su código de departamento asociado.
-- Usar aliar para las columnas de modo que el nombre que se muestre sea Empleado y 
-- Departamento Asociado.

select nombre as "Empleado", cddep as "Departamento Asociado"
from departamento;

-- Ejercicio 2 ORDENACIÓN DE RESULTADOS

-- Mostrar los datos de todos los empleados ordenados de manera ascedente por su nombre


-- Ejercicio 3.1 FILTRADO DE DATOS 
-- Mostrar los datos de los empleados que ganan menos de 2000
select *
from empleado
where salario < 2000
order by salario;

-- Mostrar los datos de los empleados contratados en 1997
select *
from empleado
where fecha_ingreso between '1997-1-1' and '1997-12-31'

select *
from empleado
where salario != 2000;

select * from empleado where cdemp > 'B';

-- Mostrar los datos de todos los empleados cuyo salario sea menor a 1800
select *
from empleado
whre salario < 1800

-- EJERCICIO 3.2 OPERADORES DE COMPARACIÓN II: IN, LIKE , IS NULL.
select *
from empleado
where cdjefe is null;

select *
from empleado
where cddep is not null;

select *
from empleado
where cdjefe in ('A03','A11','A07');

select *
from empleado
where nombre like 'Pedro%';

select *
from empleado
where nombre like '%o_';

select nombre
from departamento
where nombre in ('Córdoba' , 'Granada');

-- Ejercicio 3.3

select * 
from empleado
where not like 

select
from empleado
where cdjefe not in('A03','A11','A07');

select *
from empleado
where nombre like 'Pedro%' and salario >= 2000;

select *
from empleado
where nombre like '%Rojo%' or salario <> 2000;

-- 1
select *
from departamento 
where ciudad not in ('Sevilla','Granada');

--2
select nombre, salario
from empleado
where salario not between 2000 and 2500;

--3
select nombre, salario, fecha_ingreso
from empleado
where 

-- Ejercicio 4.1

select sum(salario)
from empleado
where cddep = '01';

select count(*)
from empleado
where fecha_ingreso between '1997-1-1' and '1997-12-31';

select count(distinct salario), max(salario), min(salario), avg(salario)
from empleado;

select sum(salario)
from empleado;

select count(*)
from empleado;

select max(salario) as "Salario Máximo", min(salario)as "Salario Mínimo"
from empleado;

select round(avg(salario),2)
from empleado;

select max(salario)
from empleado
where cdjefe like 'A11';

select count(distinct salario)
from empleado;

select count(distinct cdjefe) as "Numero de jefes"
from empleado;

select count(empleado)
from empleado
where salario > 2000;

select count(empleado)


--Ejercicio 4.2 Cláusula GROUP BY

select max(salario), cddep
from empleado
where cddep is not null
group by cddep;

