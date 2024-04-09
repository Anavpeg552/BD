
-- Ejercicio 1
-- Función llamada porcentaje reciba dos parametros con nombre
-- ( numero decimal, valor entero[1-100])
create or replace FUNCTION porcentaje(num INT, pocentaje INT)
RETURNS DECIMAL -- devolver decimal
AS
$$
BEGIN
    RETURN (num*pocentaje)/100;
-- devuelve el porcentaje del primer argumento
END;
$$
LANGUAGE plpgsql;


create or replace FUNCTION porcentaje2(INT,INT) -- parametros sin nombre
RETURNS DECIMAL 
AS
$$
BEGIN
    RETURN ($1*$2)/100;
END;
$$
LANGUAGE plpgsql;


create or replace FUNCTION porcentaje3(INT,INT) -- parametros sin nombre
RETURNS DECIMAL 
AS
$$
DECLARE --parametros con alias
    n1 alias for $1;
    n2 alias for $2;
BEGIN
    RETURN (n1*n2)/100;
END;
$$
LANGUAGE plpgsql;

--Ejercicio 2
-- Funcion mostrar_calificai