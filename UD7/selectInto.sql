create or replace function buscaDepartamento(id int)
returns varchar
AS
$$
declare
    vnombre varchar;
begin
    select nombre into vnombre
    from departamento
    where iddept = id;

    return vnombre;
end
$$
language plpgsql;

create or replace function buscaDepartamento2(id int)
returns varchar
AS
$$
declare
    vnombre departamento.nombre%TYPE;
begin
    select nombre into vnombre
    from departamento
    where iddept = id;

    if not found then
        return 'No Encontrado';
    else
        return vnombre;
    end if;
end
$$
language plpgsql;

create or replace function buscaDepartamento3(id int)
returns varchar
AS
$$
declare
    vnombre departamento.nombre%TYPE;
    vciudad departamento.ciudad%TYPE;
begin
    select nombre, ciudad into vnombre, vciudad
    from departamento
    where iddept = id;

    if not found then
        return 'No Encontrado';
    else
        return vnombre || ' ' || vciudad;
    end if;
end
$$
language plpgsql;

create or replace function buscaDepartamento4(id int)
returns varchar
AS
$$
declare
    vdep departamento%ROWTYPE;
    -- vdep departamento;
begin
    select * into vdep
    from departamento
    where iddept = id;

    if not found then
        return 'No Encontrado';
    else
        return vdep.iddept || ' ' || vdep.nombre || ' ' || vdep.ciudad;
    end if;
end
$$
language plpgsql;

create or replace function buscaDepartamento4(id int)
returns varchar
AS
$$
declare
    vdep RECORD;
begin
    select nombre, ciudad into strict vdep
    from departamento
    where iddept = id;

    if not found then
        return 'No Encontrado';
    else
        return vdep.nombre || ' ' || vdep.ciudad;
    end if;
end
$$
language plpgsql;