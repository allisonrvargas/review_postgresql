-- Verificaciones de la clínica veterinaria. Se ejecuta después de los scripts de los 4 reviews.
DO $$
DECLARE
    v_mascota INT; v_vet INT; v_consultas_antes INT; v_edad INT; v_esperada INT;
BEGIN
    -- 1. Datos de ejemplo cargados
    ASSERT (SELECT COUNT(*) FROM veterinarios) > 0, 'veterinarios vacía';
    ASSERT (SELECT COUNT(*) FROM clientes)     > 0, 'clientes vacía';
    ASSERT (SELECT COUNT(*) FROM mascotas)     > 0, 'mascotas vacía';
    ASSERT (SELECT COUNT(*) FROM consultas)    > 0, 'consultas vacía';

    -- 2. Vista de mascotas activas: solo activas, una fila por mascota
    ASSERT (SELECT COUNT(*) FROM vw_mascotas_activas) = (SELECT COUNT(*) FROM mascotas WHERE activo), 'la vista no coincide con las mascotas activas';
    ASSERT (SELECT COUNT(*) FROM vw_mascotas_activas WHERE dueño IS NULL) = 0, 'hay mascotas activas sin dueño en la vista';

    -- 3. Vista de resumen por veterinario: totales coherentes con las tablas
    ASSERT (SELECT COUNT(*) FROM vw_resumen_veterinarios) = (SELECT COUNT(*) FROM veterinarios), 'debe haber una fila por veterinario';
    ASSERT (SELECT SUM(total_consultas) FROM vw_resumen_veterinarios) = (SELECT COUNT(*) FROM consultas), 'el total de consultas no coincide';
    ASSERT (SELECT SUM(total_facturado) FROM vw_resumen_veterinarios) = (SELECT COALESCE(SUM(costo), 0) FROM consultas), 'el total facturado no coincide';

    -- 4. Procedimiento: registra una consulta nueva
    SELECT id INTO v_mascota FROM mascotas ORDER BY id LIMIT 1;
    SELECT id INTO v_vet FROM veterinarios ORDER BY id LIMIT 1;
    SELECT COUNT(*) INTO v_consultas_antes FROM consultas;
    CALL sp_registrar_consulta(v_mascota, v_vet, CURRENT_DATE, 'Control anual', 'Saludable', 130.00);
    ASSERT (SELECT COUNT(*) FROM consultas) = v_consultas_antes + 1, 'el procedimiento no registró la consulta';
    ASSERT (SELECT costo FROM consultas ORDER BY id DESC LIMIT 1) = 130.00, 'el costo registrado no es el esperado';
    ASSERT (SELECT total_consultas FROM vw_resumen_veterinarios WHERE id = v_vet) = (SELECT COUNT(*) FROM consultas WHERE veterinario_id = v_vet), 'la vista no refleja la consulta nueva';

    -- 5. Procedimiento: una mascota inexistente se rechaza por la clave foránea
    BEGIN
        CALL sp_registrar_consulta(-1, v_vet, CURRENT_DATE, 'x', 'x', 1);
        RAISE EXCEPTION 'FALLO: se aceptó una mascota inexistente';
    EXCEPTION WHEN foreign_key_violation THEN NULL;
    END;

    -- 6. Función de edad: coincide con un cálculo independiente y devuelve NULL si la mascota no existe
    SELECT id INTO v_mascota FROM mascotas WHERE fecha_nacimiento IS NOT NULL ORDER BY id LIMIT 1;
    v_edad := fn_edad_mascota(v_mascota);
    SELECT EXTRACT(YEAR FROM CURRENT_DATE)::INT - EXTRACT(YEAR FROM fecha_nacimiento)::INT
           - CASE WHEN (EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(DAY FROM CURRENT_DATE)) < (EXTRACT(MONTH FROM fecha_nacimiento), EXTRACT(DAY FROM fecha_nacimiento)) THEN 1 ELSE 0 END
      INTO v_esperada FROM mascotas WHERE id = v_mascota;
    ASSERT v_edad = v_esperada, format('edad %s distinta de la esperada %s', v_edad, v_esperada);
    ASSERT fn_edad_mascota(-1) IS NULL, 'una mascota inexistente debe dar NULL';

    RAISE NOTICE 'Veterinaria: todas las verificaciones pasaron';
END $$;