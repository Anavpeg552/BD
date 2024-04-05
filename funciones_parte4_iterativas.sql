\c oficina

create or replace function suma_10_num()
returns INT AS
$$
DECLARE
    suma INT := 0;
    num INT := 1;
BEGIN
    LOOP
        suma := suma + num;
        num := num + 1;
        EXIT WHEN num > 10;
    END LOOP;

    return suma;
END;
$$
LANGUAGE plpgsql;

create or replace function suma_10_num_v2()
returns INT AS
$$
DECLARE
    suma INT := 0;
    num INT := 1;
BEGIN
    LOOP
        suma := suma + num;
        num := num + 1;
        IF (num > 10) THEN
            return suma;
        END IF;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

create or replace function suma_10_num_menos_div3()
returns INT AS
$$
DECLARE
    suma INT := 0;
    num INT := 0;
BEGIN
    LOOP
        num := num + 1;
        CONTINUE WHEN num % 3 = 0;
        EXIT WHEN num > 10;
        suma := suma + num;
    END LOOP;

    return suma;
END;
$$
LANGUAGE plpgsql;

create or replace function contar_pares(final INT)
returns VOID AS
$$
DECLARE
    num INT := 1;
BEGIN
    WHILE num <= final LOOP
        IF(num % 2 = 0) THEN
            RAISE NOTICE '% ', num;
        END IF;
        num := num + 1;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

create or replace function mostrar_num_hasta(final INT)
returns VOID AS
$$
BEGIN
    --La variable indice del for es la única que no es obligatorio declarar
    FOR indice IN 1 .. final LOOP
	    RAISE NOTICE '% ', indice;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

create or replace function mostrar_pares_hasta_mitad(final INT)
returns VOID AS
$$
BEGIN
    --La variable indice del for es la única que no es obligatorio declarar
    FOR indice IN 2 .. final/2 BY 2 LOOP
	    RAISE NOTICE '% ', indice;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

create or replace function mostrar_pares_desde_mitad(final INT)
returns VOID AS
$$
BEGIN
    --La variable indice del for es la única que no es obligatorio declarar
    FOR indice IN REVERSE final/2 .. 2 BY 2 LOOP
	    RAISE NOTICE '% ', indice;
    END LOOP;
END;
$$
LANGUAGE plpgsql;


