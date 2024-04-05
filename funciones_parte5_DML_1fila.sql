
\c oficina 

create or replace function mostrar_nombre_dep(pid departamento.iddept%TYPE)
returns departamento.nombre%TYPE AS
$$
DECLARE
    vnombre departamento.nombre%TYPE;
BEGIN
    SELECT nombre INTO vnombre
    FROM departamento
    WHERE iddept = pid;

    return vnombre;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_datos_emp(pid empleado.idemp%TYPE)
RETURNS varchar AS
$$
DECLARE
    vnombreEmp empleado.nombre%TYPE;
    vemail empleado.email%TYPE;
    vnombreDep departamento.nombre%TYPE;
    vciudad departamento.ciudad%TYPE;
BEGIN
    SELECT e.nombre, e.email, d.nombre, d.ciudad 
    INTO vnombreEmp, vemail, vnombreDep, vciudad
    FROM departamento d JOIN empleado e ON d.iddept=e.dept
    WHERE idemp = pid;

    -- El operador || sirve para concatenar cadenas (como + en java)
    return 'Nombre: '||vnombreEmp||'. Email:  '||vemail||
    '. Departamento:  '||vnombreDep||'. Ciudad:  '||vciudad;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_datos_emp_v2(pid empleado.idemp%TYPE)
RETURNS varchar AS
$$
DECLARE
    vdatos RECORD;
BEGIN
    -- Tengo que crear dos alias para el nombre del departamento y el del empleado
    -- ya que al tener el mismo nombre, necesito distinguirlos dentro de la variable RECORD
    SELECT e.nombre as "nombreemp", e.email, d.nombre as "nombredep", d.ciudad INTO vdatos
    FROM departamento d JOIN empleado e ON d.iddept=e.dept
    WHERE idemp = pid;

    -- Para acceder a cada uno de los campos se usa el operacor punto(.)
    return 'Nombre: '||vdatos.nombreemp||'. Email:  '||vdatos.email||
    '. Departamento:  '||vdatos.nombredep||'. Ciudad:  '||vdatos.ciudad;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_datos_dep(pid departamento.iddept%TYPE)
RETURNS varchar AS
$$
DECLARE
    vdatos departamento%ROWTYPE;
BEGIN
    SELECT * INTO vdatos
    FROM departamento
    WHERE iddept = pid;

    -- Para acceder a cada uno de los campos se usa el operacor punto(.)
    return 'ID: '||vdatos.iddept||'. Nombre:  '||vdatos.nombre||
    '. Ciudad:  '||vdatos.ciudad;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION mostrar_datos_emp_dep(pid departamento.iddept%TYPE)
RETURNS varchar AS
$$
DECLARE
    vdatos empleado%ROWTYPE;
BEGIN
    SELECT * INTO vdatos
    FROM empleado
    WHERE dept = pid;

    -- Para acceder a cada uno de los campos se usa el operacor punto(.)
    return 'Nombre: '||vdatos.nombre||' '||vdatos.apellidos||
    '. Móvil:  '||vdatos.movil||'. Email:  '||vdatos.email;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_datos_emp_dep_strict(pid departamento.iddept%TYPE)
RETURNS varchar AS
$$
DECLARE
    vdatos empleado%ROWTYPE;
BEGIN
    --Colocamos STRICT justo después de la pablabra INTO
    SELECT * INTO STRICT vdatos
    FROM empleado
    WHERE dept = pid;

    -- Para acceder a cada uno de los campos se usa el operacor punto(.)
    return 'Nombre: '||vdatos.nombre||' '||vdatos.apellidos||
    '. Móvil:  '||vdatos.movil||'. Email:  '||vdatos.email;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_dep(pnombre departamento.nombre%TYPE, pciudad departamento.ciudad%TYPE)
RETURNS varchar AS
$$
DECLARE
    vIdNuevoDep departamento.iddept%TYPE;
BEGIN
    INSERT INTO departamento 
    VALUES(default, pnombre, pciudad)
    RETURNING iddept INTO vIdNuevoDep;

    return 'Se ha insertado un nuevo departamento con id: '||vIdNuevoDep;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_ciudad_dep(pid departamento.iddept%TYPE, pciudadnueva departamento.ciudad%TYPE)
RETURNS varchar AS
$$
DECLARE
    v departamento%ROWTYPE;
BEGIN
    UPDATE departamento
    SET ciudad = pciudadnueva
    WHERE iddept = pid
    RETURNING * INTO v;
    -- Tened en cuenta que los datos que se almacenan con RETURNING INTO son 
    -- de después de la modificación por lo que ciudad tendrá el valor nuevo

    return 'Se ha modificado la ciudad del departamento de '||v.nombre||'. Ahora su valor es: '||v.ciudad;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_dep(pid departamento.iddept%TYPE)
RETURNS varchar AS
$$
DECLARE
    v departamento%ROWTYPE;
BEGIN
    DELETE FROM departamento
    WHERE iddept = pid
    RETURNING * INTO v;
    -- Tened en cuenta que los datos que se almacenan con RETURNING INTO son 
    -- de después de la modificación por lo que ciudad tendrá el valor nuevo

    return 'Se ha eliminado el departamento de '||v.nombre;
END;
$$
LANGUAGE plpgsql;

create or replace function mostrar_nombre_dep_v2(pid departamento.iddept%TYPE)
returns departamento.nombre%TYPE AS
$$
DECLARE
    vnombre departamento.nombre%TYPE;
BEGIN
    SELECT nombre INTO vnombre
    FROM departamento
    WHERE iddept = pid;

    IF NOT FOUND THEN
        vnombre := 'Departamento no encontrado';
    END IF;

    return vnombre;  
END;
$$
LANGUAGE plpgsql;

create or replace function num_emp_dep(pid departamento.iddept%TYPE)
returns INT AS
$$
DECLARE
    vcantidad INT;
BEGIN
    -- Primero cmprobamos si existe el departamento
    PERFORM * FROM departamento WHERE iddept = pid;

    IF FOUND THEN
        -- Si existe se calcula el número de empleados de ese departamento
        select count(*) into vcantidad
        FROM empleado
        WHERE dept = pid;
    ELSE
        -- Si no existe se muestra un mensaje informado de ello
        RAISE NOTICE 'No existe ningún departamento con id %', pid;
    END IF;

    return vcantidad;  
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_dep_empleado(piddeptAntiguo empleado.dept%TYPE, piddeptNuevo empleado.dept%TYPE)
RETURNS varchar AS
$$
DECLARE
    v empleado%ROWTYPE;
BEGIN
    UPDATE empleado
    SET dept = piddeptNuevo
    WHERE dept = piddeptAntiguo
    RETURNING * INTO v;
    
    return 'Se ha modificado el departamento de '||v.nombre||'. Ahora su valor es: '||v.dept;
END;
$$
LANGUAGE plpgsql;