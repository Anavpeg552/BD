-- Funcion llamada pago_supera_cantidad
create or replace FUNCTION pago_supera_cantidad(dinero DECIMAL)
returns VOID AS
$$
DECLARE
    vpagos RECORD;
    cont_may INT := 0;
    cont_men INT := 0;
BEGIN
    FOR vpagos IN SELECT c.empresa, p.fecha, p.cantidad 
                  FROM pago p
                  JOIN cliente c ON  p.cod_cliente = c.codigo
    LOOP
        -- Comprobar si la cantidad del pago supera el parámetro
        IF vpagos.cantidad > dinero THEN
            -- Mostrar información del pago que supera la cantidad
            RAISE NOTICE 'Nombre empresa: %, Fecha: %, Cantidad: %',
                         vpagos.empresa, vpagos.fecha, vpagos.cantidad;
            cont_may := cont_may + 1;
        ELSE
            cont_men := cont_men + 1;
        END IF;
    END LOOP;
    
    -- Mostrar el numero de pagos que superan la cantida y el numero de pagos que no lo superan.
    RAISE NOTICE 'Número de pagos menores o iguales a % €: %', dinero, cont_men;
    RAISE NOTICE 'Número de pagos mayores que % €: %', dinero, cont_may;
END;
$$ LANGUAGE plpgsql;

--