\c oficina

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

create or replace function obtener_calificacion(nota INT)
returns VARCHAR AS
$$
DECLARE
    calificacion VARCHAR;
BEGIN
    CASE nota
        WHEN 1,2,3,4 THEN
            calificacion := 'Suspenso';
        WHEN 5,6 THEN
            calificacion := 'Aprobado';
        WHEN 7,8 THEN
            calificacion := 'Notable';
        WHEN 9,10 THEN
            calificacion := 'Sobresaliente';
        ELSE
            calificacion := 'No válida';
    END CASE;
    
    return calificacion;
END;
$$
LANGUAGE plpgsql;

create or replace function tipo_habitacion(metros DECIMAL)
returns varchar AS
$$
DECLARE
    tipo VARCHAR;
BEGIN
    CASE
        WHEN metros >= 100 THEN
            tipo := 'Suite Presidencial';
        WHEN metros >= 50 THEN
            tipo := 'Suite';
        WHEN metros >= 30 THEN
            tipo := 'Suite Junior';
        WHEN metros >= 20 THEN
            tipo := 'Doble Familiar';
        ELSE
            tipo := 'Individual';
    END CASE;
    
    return tipo;
END;
$$
LANGUAGE plpgsql;


