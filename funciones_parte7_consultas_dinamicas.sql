
\c oficina 

CREATE OR REPLACE FUNCTION consultarTablaOrdenada(nombre_tabla VARCHAR, campo_ordenacion VARCHAR)
RETURNS VOID AS
$$
DECLARE
    consulta TEXT;
    fila RECORD;
    contador INT := 0;
BEGIN
    -- Construir la consulta dinámicamente
    consulta := 'SELECT * FROM ' || nombre_tabla || ' ORDER BY ' || campo_ordenacion;
    
    -- Ejecutar la consulta dinámica
    FOR fila IN EXECUTE consulta LOOP
        -- Mostrar los resultados
        RAISE NOTICE 'Registro: % - %', contador, fila;
        contador := contador + 1;
    END LOOP;
END;
$$
LANGUAGE plpgsql;
