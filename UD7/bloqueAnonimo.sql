DO
$$
-- declare
-- declarar las variables que usemos
-- OPCIONAL, solo cuando necesitemos variables en el código
begin
-- las instrucciones
-- OBLIGATORIO
    raise notice 'Hola mundo';
end
$$
language plpgsql;