
\c oficina 

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

create or replace function cambiar_departamento_sincursor(pdeptAnterior empleado.dept%TYPE, pdeptNuevo empleado.dept%TYPE)
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
            -- Hacemos la modificación. Lo que no podemos usar es el RETURNING INTO
            UPDATE empleado
            SET dept = pdeptNuevo
            WHERE dept = pdeptAnterior;
            
            -- Si el UPDATE no se ha ejecutado sobre ningún empleadoes porque el departamento 
            -- sí existe pero ningún empleado tiene asignado ese departamento
            IF NOT FOUND THEN
                RAISE NOTICE 'No tiene asignado ningún empleado';
            ELSE
                RAISE NOTICE 'Departamentos modificados';
            END IF;
        END IF;
    END IF;
END;
$$
LANGUAGE plpgsql;
