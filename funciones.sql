create or replace function suma()
returns void
AS
$$
declare
    vn1 int :=10;
    vn2 int :=5;
begin
    raise notice '% + % = %', vn1,vn2, vn1+vn2;
end
$$
language plpgsql;

create or replace function suma2()
returns int
AS
$$
declare
    vn1 int :=10;
    vn2 int :=5;
begin
    return vn1+vn2;
end
$$
language plpgsql;

create or replace function suma3(pn1 int, pn2 int)
returns int
AS
$$
begin
    return pn1+pn2;
end
$$
language plpgsql;

--Parámetros sin nombre con alias
create or replace function suma5(int, int)
returns int
AS
$$
declare
    num1 alias for $1;
    num1 alias for $2;
begin
    return num1+num2;
end
$$
language plpgsql;

--Parámetros de salida, entrada y salida/entrada
create or replace function suma6( IN n1 int, IN n2 int,OUT resultado int)
AS
$$
begin
    return := n1+n2;
end
$$
language plpgsql;


create or replace fuction esPositivo(n int)
returns varchar
AS
$$
begin 
    if n>0 then 
        return 'POSITIVO';
    end if;
    return '';
end
$$
language plpgsql;



create or replace fuction esPositivoNegativo(n int)
returns varchar
AS
$$
begin 
    if n>0 then 
        return 'POSITIVO';
    else
        return 'NEGATIVO';
    end if;
end
$$
language plpgsql;




create or replace fuction esPositivoNegativoCero(n int)
returns varchar
AS
$$
begin 
    if n>0 then 
        return 'POSITIVO';
    elseif n=0 then
        return 'CERO';
    else
        return 'NEGATIVO';
    end if;
end
$$
language plpgsql;


create or replace fuction intensidad(volumen int)
returns varchar
AS
$$
begin 
    case vol
end
$$
language plpgsql;

