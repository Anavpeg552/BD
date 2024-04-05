DO
$$
DECLARE
    -- Declaración de variables
    num1 INT := 4;
    num2 INT := 6;
BEGIN
    -- Instrucciones
    RAISE NOTICE 'La suma de % y % es %', num1, num2, num1+num2;
END
$$
LANGUAGE plpgsql

