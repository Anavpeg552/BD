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

create or replace function familia_numerosa(precio DECIMAL, numHijos INT)
returns DECIMAL AS
$$
BEGIN
    IF (numHijos >= 3 ) THEN
        precio := precio * 0.8;
    END IF;
    
    return precio;
END;
$$
LANGUAGE plpgsql;

create or replace function descuento(precio DECIMAL)
returns DECIMAL AS
$$
BEGIN
    IF (precio > 3 ) THEN
        precio := precio * 0.7;
    ELSE
        precio := precio * 0.9;
    END IF;
    
    return precio;
END;
$$
LANGUAGE plpgsql;

create or replace function descuento_hijos(precio DECIMAL, numHijos INT)
returns DECIMAL AS
$$
BEGIN
    IF (numHijos >= 2 ) THEN
        precio := precio * 0.8;
    ELSIF (numHijos >= 4) THEN
        precio := precio * 0.7;
    ELSIF (numHijos >= 6) THEN
        precio := precio * 0.5;
    ELSE
        precio := precio * 0.05;
    END IF;
    
    return precio;
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

-- FOUND

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

--PERFORM

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



-- CURSORES --

create or replace function mostrar_empleados(pdept empleado.dept%TYPE)
returns VOID AS
$$
DECLARE
    vdatos empleado%ROWTYPE;
BEGIN

    -- Primero comprobamos si existe el id de departamento
    PERFORM * FROM departamento WHERE iddept = pdept;

    IF FOUND THEN
        -- Si existe mediante un cursor implícito mostramos los datos de todos los empleados
        -- asignados a ese departamento
        RAISE NOTICE 'Mostrando los empleados del departamento %', pdept;
        
        FOR vdatos IN SELECT * FROM empleado WHERE dept = pdept
        LOOP
            RAISE NOTICE 'Empleado: % %. Móvil: %. Email: %', vdatos.nombre, 
                            vdatos.apellidos, vdatos.movil, vdatos.email;
        END LOOP;

        -- Si el FOR no se ha ejecutado ninguna vez es porque el departamento sí existe
        -- pero ningún empleado tiene asignado ese departamento
        IF NOT FOUND THEN
            RAISE NOTICE 'No tiene asignado ningún empleado';
        END IF;
    ELSE
        -- Si el departamento no existe se muestra un mensaje informando de ello
        RAISE NOTICE 'El departamento con id % no existe', pdept;
    END IF;
END;
$$
LANGUAGE plpgsql;

create or replace function cambiar_departamento(pdeptAnterior empleado.dept%TYPE, pdeptNuevo empleado.dept%TYPE)
returns VOID AS
$$
DECLARE
    -- Almacena el campo idemp de un empleado
    videmp empleado.idemp%TYPE;
    -- Almacena los datos de los empleados cuyo dept ha sido modificado
    -- Almacenará solo uno en cada iteración del FOR
    vempleado empleado%ROWTYPE;
BEGIN
    -- Primero comprobamos si existen los dos departamentos: el antiguo y el nuevo
    -- Primero comprobamos el anterior
    PERFORM * FROM departamento WHERE iddept = pdeptAnterior;

    IF NOT FOUND THEN
        -- No existe el departamento anterior
        RAISE NOTICE 'No existe el departamento con id: %', pdeptAnterior;
    ELSE
        -- Si existe el anterio, pasamos a comprobar el nuevo
        PERFORM * FROM departamento WHERE iddept = pdeptNuevo;
        IF NOT FOUND THEN
            -- No existe el departamento nuevo
            RAISE NOTICE 'No existe el departamento con id: %', pdeptNuevo;
        ELSE
            -- Si hemos llegado hasta aquí es porque ambos departamentos existen
            -- Recorremos con un cursor implícito todos los empleados que están en el departamento anterior
            FOR videmp IN SELECT idemp FROM empleado WHERE dept = pdeptAnterior
            LOOP
                -- Para cada id de empleado que hemos encontrado asignado al departamento anterior
                -- hacemos una modificación para cambiarlo al nuevo
                UPDATE empleado
                SET dept = pdeptNuevo
                WHERE idemp = videmp
                RETURNING * INTO vempleado;

                RAISE NOTICE 'El empleado % % ha sido movido del departamento % al %', 
                              vempleado.nombre, vempleado.apellidos, pdeptAnterior, vempleado.dept;
            END LOOP;
            -- Si el FOR no se ha ejecutado ninguna vez es porque el departamento sí existe
            -- pero ningún empleado tiene asignado ese departamento
            IF NOT FOUND THEN
                RAISE NOTICE 'No tiene asignado ningún empleado';
            END IF;
        END IF;
    END IF;
END;
$$
LANGUAGE plpgsql;

--SIN CURSORES