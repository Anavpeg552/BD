--1
select entrenador, nombre
from universidad
group by codigo;

--2
select codigo, distancia, obstaculos, categoria, fec_hora
from prueba
order by fec_hora;

--3
select  u.codigo, u.nombre, count(a.dorsal)
from universidad u join atleta a on a.universidad = u.codigo
group by u.codigo;
order by 3 desc;


--4
select a.nombre, a.apellidos, u.nombre
from universidad u join atleta a on a.universidad = u.codigo
where lower(u.comunidad) = 'andalucía';


--5
select a.nombre, a.apellidos, c.posicion, c.codigo_pru
from atleta a join competir c on a.dorsal = c.dorsal_atl
where c.posicion in (1,2,3)
order by c.codigo_pru, c.posicion;

--6
select p.distancia, count(c.dorsal_alt)
from competir c join prueba p on p.codigo=c.codigo_pru
group by p.distancia
order by p.distancia desc;

--7
select p.codigo, a.dorsal, c.arca_personal, p.rec_universitario, p.rec_universitario
from competir c join prueba p on p.codigo = c.codigo_pru
where c.posicion = 1;



