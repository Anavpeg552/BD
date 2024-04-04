create or replace function mostrarRango(fin int)
returns varchar
AS
$$
declare
    vinicio int := 0;
    salida varchar := '';
begin
    loop
        vinicio := vinicio + 1;
        exit when vinicio > fin;
        continue when vinicio = 5;
        salida = salida || vinicio || ' ';
    end loop;
    return salida;
end
$$
language plpgsql;

create or replace function mostrarRangoWhile(fin int)
returns varchar
AS
$$
declare
    vinicio int := 0;
    salida varchar := '';
begin
    while vinicio < fin loop
        vinicio := vinicio + 1;
        salida = salida || vinicio || ' ';
    end loop;
    return salida;
end
$$
language plpgsql;

create or replace function mostrarRangoFor(fin int)
returns varchar
AS
$$
declare
    vinicio int := 1;
    salida varchar := '';
begin
    for i in vinicio .. fin loop
        salida = salida || i || ' ';
    end loop;
    return salida;
end
$$
language plpgsql;

create or replace function mostrarRangoFor2(fin int)
returns varchar
AS
$$
declare
    vinicio int := 1;
    salida varchar := '';
begin
    for i in vinicio .. fin by 2 loop
        salida = salida || i || ' ';
    end loop;
    return salida;
end
$$
language plpgsql;

create or replace function mostrarRangoFor3(fin int)
returns varchar
AS
$$
declare
    vinicio int := 1;
    salida varchar := '';
begin
    for i in reverse fin .. vinicio loop
        salida = salida || i || ' ';
    end loop;
    return salida;
end
$$
language plpgsql;