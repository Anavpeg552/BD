--ejecicio2

insert into compra(fecha_hora, cod_cliente)values
('2023-03-20 18:30', 2);

insert into contiene(cod_compra, cod_producto, cantidad) values
(1, 1, 2),
(1, 2, 2);

update cod_producto
set stock =stock - 2
where codigo in (1,2);

--Ejercicio 3

insert into compra(fecha_hora, cod_cliente)
select '2023-03-22 11:30', codigo
from cod_cliente
where nombre = 'Pedro' and telefono = '666000111'

insert into contiene(cod_compra, cod_producto, cantidad)
select 2, codigo, 3
from cod_producto
where precioVenta=15 and cod_proveedor in ( select codigo
                                            from cod_proveedor      
                                            where localidad = 'Linares');

update producto
set stock =stock - 3
where cod_proveedor in( 
    select codigo
    from cod_proveedor
    where localidad='Linares'
);

--Ejercicio 4
update compra
set descuento =20
where cod_cliente in (
    select codigo
    from cliente
    where extract(month from fecha_nac)=03
);

--Ejercicio 5

update cod_proveedorset localidad


--Ejercicio 8
update producto
set 


--Ejercicio 12


--Ejercicio 13

delete from contiene
where cod_compra in (
    select codigo
    from compra
    where cod_cliente in(
        select codigo
        from cliente
        where nombre=
    )
)


delete from compra
where cod_cliente in (select cliente
                        where nombre='Adolfo');

delete from cliente
where nombre = 'Adolfo';



