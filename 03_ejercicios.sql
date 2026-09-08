-- =========================================================
-- Review 1 - CRUD
-- Ejercicios de SELECT, UPDATE y DELETE
-- =========================================================

-- 1. Listar id, nombre, especie y raza de todos los perros.
SELECT id, nombre, especie, raza
FROM mascotas
WHERE especie = 'Perro';

-- 2. Listar nombre, apellido y email de los clientes registrados desde el 2025.
SELECT nombre, apellido, email
FROM clientes
WHERE fecha_registro >= '2025-01-01';

-- 3. Listar nombre y peso de las mascotas ordenadas de mayor a menor peso.
SELECT nombre, peso
FROM mascotas
ORDER BY peso DESC;

-- 4. Listar las mascotas con peso entre 5 y 20 kg.
SELECT nombre, especie, peso
FROM mascotas
WHERE peso BETWEEN 5 AND 20;

-- 5. Listar las consultas cuyo costo supere los Q200.
SELECT id, fecha, motivo, costo
FROM consultas
WHERE costo > 200;

-- 6. Actualizar el peso de la mascota con id = 3 a 7.10 kg (control de peso).
UPDATE mascotas
SET peso = 7.10
WHERE id = 3;

-- 7. Actualizar el teléfono del veterinario con id = 2.
UPDATE veterinarios
SET telefono = '5501-9999'
WHERE id = 2;

-- 8. Marcar como inactiva (activo = FALSE) la mascota con id = 12.
UPDATE mascotas
SET activo = FALSE
WHERE id = 12;

-- 9. Eliminar la consulta con id = 6 (registrada por error).
DELETE FROM consultas
WHERE id = 6;

-- 10. Eliminar de la tabla mascotas los registros inactivos que no tengan consultas asociadas.
DELETE FROM mascotas
WHERE activo = FALSE
  AND id NOT IN (SELECT DISTINCT mascota_id FROM consultas);
