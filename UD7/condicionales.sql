create or replace function esPositivo(n int)
returns varchar
AS
$$
begin
    if n> 0 then
        return 'POSITIVO';
    end if;
    return '';
end
$$
language plpgsql;

create or replace function esPositivoNegativo(n int)
returns varchar
AS
$$
begin
    if n> 0 then
        return 'POSITIVO';
    else
        return 'NEGATIVO';
    end if;
end
$$
language plpgsql;

create or replace function esPositivoNegativoCero(n int)
returns varchar
AS
$$
begin
    if n> 0 then
        return 'POSITIVO';
    elsif n = 0 then
        return 'CERO';
    else
        return 'NEGATIVO';
    end if;
end
$$
language plpgsql;

create or replace function intensidad(volumen int)
returns varchar
AS
$$
begin
    case volumen
        when 1,2,3,4 then
            return 'BAJO';
        when 5,6 then
            return 'MEDIO';
        when 7,8 then
            return 'ALTO';
        when 9, 10 then
            return 'EXTREMO';
        else
            return 'INCORRECTO';
    end case; 
end
$$
language plpgsql;

create or replace function intensidad2(volumen int)
returns varchar
AS
$$
begin
    case 
        when volumen < 1 or volumen > 10 then
            return 'INCORRECTO';
        when volumen >= 1 and volumen <= 4 then
            return 'BAJO';
        when volumen <= 6 then
            return 'MEDIO';
        when volumen <= 8 then
            return 'ALTO';
        when volumen <= 10 then
            return 'EXTREMO';
    end case; 
end
$$
language plpgsql;

