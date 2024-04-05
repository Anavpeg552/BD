
\c oficina 

create or replace function mostrar_empleados_ciudad(pciudad departamento.ciudad%TYPE)
returns VOID AS
$$
DECLARE
    -- Declaro el cursor asociandolo a la consulta
    curEmpleados CURSOR FOR SELECT * FROM empleado 
                            WHERE dept IN (
                                    SELECT iddept FROM departamento 
                                    WHERE ciudad = pciudad);
    -- Voy a declarar una variable para saber el número de empelados que son de esa ciudad
    numEmpleados INT := 0;
BEGIN
    FOR regEmp IN curEmpleados LOOP
        RAISE NOTICE 'Empleado: % %. Móvil: %. Email: %', regEmp.nombre, 
                        regEmp.apellidos, regEmp.movil, regEmp.email;
        numEmpleados := numEmpleados + 1;
    END LOOP;
    -- Si el For no se ha ejecutado ninguna vez es porque el cursor no tiene resultados
    -- es decir, no hay ningún empleado en esa ciudad
    IF NOT FOUND THEN
        RAISE NOTICE 'No hay ningún empleado en esa ciudad';
    ELSE
        RAISE NOTICE 'Número de empleados en %: %', pciudad, numEmpleados;
    END IF;
END;
$$
LANGUAGE plpgsql;
