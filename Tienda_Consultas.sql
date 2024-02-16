--Ejercicio 1

select t.gerente, v.cliente_id
from venta v join tienda t on tienda_id= v.id
group by t.gerente like 'Antonio';



--Ejercicio 2

--Ejercicio 3

--Ejercicio 4
select c.nombre, c.apellidos
from cliente c join venta v on cliente_id= v.id;
order by c.nombre;



--5
select nombre, apellidos
from cliente

--6

select nombre, cantidad, 
from 

--7

select id_cliente, count(v.id)
from venta v join cliente c 



--8
select a.nombre, p.nombre
from articulo a join proveedor p on proveedor_id = p.id
where a.precioventa > ;



--9
select cantidad , articulo_id, ciudad, proveedor_id
from articulo a join articulovendido av on a.id = articulo_id
                join proveedor p on a.id = p.id
where p.ciudad='Madrid';


select * 
from proveedor;

--10
select a.nombre, v.fecha, av.articulo_id
from articulo a join articulovendido av on a.id = articulo_id
                join venta v on venta_id = v.id
where v.fecha = '2022-01-28';





-- Ejercicio 1

select count(id)
from venta
where tienda_id in (select id 
                    from tienda         
                    where lower(gerente) like 'antonio %');

-- Ejercicio 2
select distinct color
from articulo
where id in(select articulo_id
            where venta_id in (select id
                               from venta
                               where cliente_id))


-- Ejercicio 3
select t.id, a.nombre, sum(av.cantidad)
from tienda t join venta v on (t.id=v.tienda_id)
              join articulovendido av on (v.id=av.venta_id)
              join articulo a on (av.articulo_id=a.id)
group by t.id, a.nombre
having t.pais='Francia';

-- Ejercicio 4
select nombre, preciocompra
from articulo
where preciocompra > any (select preciocompra
                          from articulo 
                          where proveedor_id in (select id
                                                 from proveedor
                                                 where lower(nombre) like '%suministros%'));

-- Ejercicio 5
select c.nombre, c.apellidos
from cliente c, venta v
where c.id=v.cliente_id
group by c.id 
having count(*);


--Ejercicio 6


--Ejercicio 7
select cliente_id, count (*)
from venta
group by cliente_id
order by 2 desc
limit 3;



--Ejercicio 10

select nombre
from articulo
where id IN( select articulo_id
             from articulovendido
             where venta_id in (select id 
                                from venta
                                order by fecha desc)
);














































































 