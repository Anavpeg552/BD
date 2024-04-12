
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

-- Ejercicio 2
-- Funcion mostrar_calificacion
-- parametros (nota decimal)

create or replace FUNCTION mostrar_calificacion(nota DECIMAL)
RETURNS VARCHAR 
AS
$$
DECLARE
    calificacion VARCHAR;
BEGIN
    IF(nota<0) THEN
        calificacion :='No válida';
    ELSEIF (nota<5) THEN
        calificacion :='Suspenso';
    ELSEIF (nota<7) THEN
        calificacion :='Aprobado';
    ELSEIF (nota<9) THEN
        calificacion :='Notable';
    ELSEIF (nota<10) THEN
        calificacion :='Sobresaliente';
    ELSE
        calificacion :='No válida';
    END IF;
    
    return calificacion; --devuelve calificacion
END;
$$
LANGUAGE plpgsql;

-- Ejercicio 3
-- implemetar funcion nombre_mes
-- parametro (mes)
-- usar CASE

create or replace FUNCTION nombre_mes(mes INT)
RETURNS VARCHAR 
AS
$$
DECLARE
    mes_escrito VARCHAR;
BEGIN
    CASE mes
        WHEN 1 THEN 
            mes_escrito :='Enero';
        WHEN 2 THEN 
            mes_escrito :='Febrero';
        WHEN 3 THEN 
            mes_escrito :='Marzo';
        WHEN 4 THEN 
            mes_escrito :='Abril';
        WHEN 5 THEN 
            mes_escrito :='Mayo';
        WHEN 6 THEN 
            mes_escrito :='Junio';
        WHEN 7 THEN 
            mes_escrito :='Julio';
        WHEN 8 THEN 
            mes_escrito :='Agosto';
        WHEN 9 THEN 
            mes_escrito :='Septiembre';
        WHEN 10 THEN 
            mes_escrito :='Octubre';
        WHEN 11 THEN 
            mes_escrito :='Noviembre';
        WHEN 12 THEN 
            mes_escrito :='Diciembre';
        ELSE
            mes_escrito :='Mes introducido NO valido';
        END CASE;

    return mes_escrito;
END;
$$
LANGUAGE plpgsql;

-- parametro de salida OUT mes_escrito
create or replace FUNCTION nombre_mes2(IN mes INT, OUT mes_escrito VARCHAR)
AS
$$

BEGIN
    CASE mes
        WHEN 1 THEN 
            mes_escrito :='Enero';
        WHEN 2 THEN 
            mes_escrito :='Febrero';
        WHEN 3 THEN 
            mes_escrito :='Marzo';
        WHEN 4 THEN 
            mes_escrito :='Abril';
        WHEN 5 THEN 
            mes_escrito :='Mayo';
        WHEN 6 THEN 
            mes_escrito :='Junio';
        WHEN 7 THEN 
            mes_escrito :='Julio';
        WHEN 8 THEN 
            mes_escrito :='Agosto';
        WHEN 9 THEN 
            mes_escrito :='Septiembre';
        WHEN 10 THEN 
            mes_escrito :='Octubre';
        WHEN 11 THEN 
            mes_escrito :='Noviembre';
        WHEN 12 THEN 
            mes_escrito :='Diciembre';
        ELSE
            mes_escrito :='Mes introducido NO valido';
        END CASE;
    
END;
$$
LANGUAGE plpgsql;


--Ejercicio 4
-- funcion estacion
-- parametro fecha
create or replace FUNCTION estacion(fecha DATE)
RETURNS VARCHAR
AS
$$
DECLARE 
    mes INT;
    
BEGIN

    IF mes BETWEEN 3 AND 5 THEN
        RETURN 'Primavera';
    ELSEIF mes BETWEEN 6 AND 8 THEN
        RETURN 'Verano';
    ELSEIF mes BETWEEN 9 AND 11 THEN
        RETURN 'Otoño';
    ELSE
        RETURN 'Invierno';
    END IF;
END;
$$
LANGUAGE plpgsql;

--Ejercicio 5
-- funcion contar_hasta 
-- parametro(numero)
create or replace FUNCTION contar_hasta(numero INT)
RETURNS VOID AS $$
DECLARE
    num INT :=2;
BEGIN
    WHILE numero>=num LOOP
        RAISE NOTICE ' %',num;
        num := num+1;
    END LOOP;
END;
$$
LANGUAGE plpgsql;
