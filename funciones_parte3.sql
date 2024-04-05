-- Seleccionamos el nombre de la BD donde se va a almacenar la función
\c oficina

create or replace FUNCTION suma()
RETURNS void
AS
$$
DECLARE
    num1 INT := 5;
    num2 INT := 10;

BEGIN
    RAISE NOTICE 'El resultado de % más % es %', num1, num2, num1+num2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v2()
RETURNS INT
AS
$$
DECLARE
    num1 INT := 5;
    num2 INT := 10;

BEGIN
    RETURN num1+num2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v3(num1 INT, num2 INT)
RETURNS INT
AS
$$
-- En este ejemplo que puede hacerse sin variables he omitido el DECLARE
BEGIN
    RETURN num1+num2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v4(INT, INT)
RETURNS INT
AS
$$
BEGIN
    RAISE NOTICE 'El valor del primer parámetro es % y el del segundo %', $1, $2;
    RETURN $1+$2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v5(INT, numero2 INT)
RETURNS INT
AS
$$
DECLARE 
    n1 alias for $1;
    n2 alias for numero2;
BEGIN
    RAISE NOTICE 'El valor del primer parámetro es % y el del segundo %', n1, n2;
    RETURN n1+n2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v6(IN n1 INT, IN n2 INT, OUT suma INT, OUT mult INT)
RETURNS RECORD
-- El returns es de tipo record porque devuelve más de un campo
-- en ejemplos posteriores veremos ejemplos
AS
$$
BEGIN
    suma := n1 + n2;
    mult := n1 * n2;
END;
$$
LANGUAGE plpgsql;

create or replace FUNCTION suma_v7(VARIADIC numeros INT[])
RETURNS INT AS
$$
DECLARE
    suma INT := 0;
    num INT;
BEGIN
    foreach num IN ARRAY numeros
    loop
        suma := suma + num;
    end loop;
    return suma;
END;
$$
LANGUAGE plpgsql;