DO
$$
declare
--declarar las variables que usemos
--OPCIONAL, solo cuando necesitamos variables en el código.
    vnombre varchar := 'Pepe';
    -- vnombre varchar default 'Pepe';
begin
-- las instrucciones
--OBLIGATORIO
    raise notice 'Hola mundo %', vnombre;
end
$$
language plpgsql;