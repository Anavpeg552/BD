select codigo, nombre, ciudad
from concesionario;

select *
from cliente
where lower(ciudad) = 'madrid';

select nombre
from distribuidora
order by nombre;

select c.codigo, c.nombre
from concesionario c join stock s on c.codigo=s.cod_conce
where s.cantidad>9;

select c.codigo, c.nombre
from concesionario c join stock s on c.codigo=s.cod_conce
where s.cantidad between 10 and 18;

select codigo, nombre, nombre, modelo, cantidad
from concesionario c join 