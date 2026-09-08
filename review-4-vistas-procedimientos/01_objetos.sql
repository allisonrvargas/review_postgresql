-- =========================================================
-- Review 4 - Vistas, procedimientos y funciones
-- =========================================================

-- 1. Vista: mascotas activas junto con los datos de su dueño.
CREATE VIEW vw_mascotas_activas AS
SELECT m.id, m.nombre AS mascota, m.especie, m.raza,
       c.nombre || ' ' || c.apellido AS dueño, c.telefono
FROM mascotas m
JOIN clientes c ON m.cliente_id = c.id
WHERE m.activo = TRUE;

-- Uso:
-- SELECT * FROM vw_mascotas_activas;

-- 2. Vista: resumen de consultas y facturación por veterinario.
CREATE VIEW vw_resumen_veterinarios AS
SELECT v.id, v.nombre || ' ' || v.apellido AS veterinario,
       COUNT(co.id) AS total_consultas,
       COALESCE(SUM(co.costo), 0) AS total_facturado
FROM veterinarios v
LEFT JOIN consultas co ON co.veterinario_id = v.id
GROUP BY v.id, v.nombre, v.apellido;

-- Uso:
-- SELECT * FROM vw_resumen_veterinarios ORDER BY total_facturado DESC;

-- 3. Procedimiento: registrar una nueva consulta para una mascota.
CREATE OR REPLACE PROCEDURE sp_registrar_consulta(
    p_mascota_id INT,
    p_veterinario_id INT,
    p_fecha DATE,
    p_motivo VARCHAR,
    p_diagnostico VARCHAR,
    p_costo NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO consultas (mascota_id, veterinario_id, fecha, motivo, diagnostico, costo)
    VALUES (p_mascota_id, p_veterinario_id, p_fecha, p_motivo, p_diagnostico, p_costo);
END;
$$;

-- Uso:
-- CALL sp_registrar_consulta(2, 3, CURRENT_DATE, 'Control anual', 'Saludable', 130.00);

-- 4. Función: calcular la edad en años de una mascota a partir de su fecha de nacimiento.
CREATE OR REPLACE FUNCTION fn_edad_mascota(p_mascota_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_edad INT;
BEGIN
    SELECT DATE_PART('year', AGE(CURRENT_DATE, fecha_nacimiento))
    INTO v_edad
    FROM mascotas
    WHERE id = p_mascota_id;

    RETURN v_edad;
END;
$$;

-- Uso:
-- SELECT nombre, fn_edad_mascota(id) AS edad_años FROM mascotas;
