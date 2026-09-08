-- =========================================================
-- Review 2 - Consultas (JOIN, GROUP BY, HAVING, subconsultas)
-- =========================================================

-- 1. Listar cada mascota junto con el nombre completo de su dueño.
SELECT m.nombre AS mascota, c.nombre || ' ' || c.apellido AS dueño
FROM mascotas m
JOIN clientes c ON m.cliente_id = c.id;

-- 2. Listar cada consulta con el nombre de la mascota y el veterinario que la atendió.
SELECT co.fecha, m.nombre AS mascota, v.nombre || ' ' || v.apellido AS veterinario, co.motivo
FROM consultas co
JOIN mascotas m ON co.mascota_id = m.id
JOIN veterinarios v ON co.veterinario_id = v.id
ORDER BY co.fecha;

-- 3. Contar cuántas mascotas tiene registradas cada cliente.
SELECT c.nombre || ' ' || c.apellido AS cliente, COUNT(m.id) AS total_mascotas
FROM clientes c
LEFT JOIN mascotas m ON m.cliente_id = c.id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY total_mascotas DESC;

-- 4. Calcular el total facturado por cada veterinario.
SELECT v.nombre || ' ' || v.apellido AS veterinario, SUM(co.costo) AS total_facturado
FROM consultas co
JOIN veterinarios v ON co.veterinario_id = v.id
GROUP BY v.id, v.nombre, v.apellido
ORDER BY total_facturado DESC;

-- 5. Calcular el costo promedio de consulta por especie de mascota.
SELECT m.especie, ROUND(AVG(co.costo), 2) AS costo_promedio
FROM consultas co
JOIN mascotas m ON co.mascota_id = m.id
GROUP BY m.especie
ORDER BY costo_promedio DESC;

-- 6. Listar los clientes que tienen más de 1 mascota registrada.
SELECT c.nombre || ' ' || c.apellido AS cliente, COUNT(m.id) AS total_mascotas
FROM clientes c
JOIN mascotas m ON m.cliente_id = c.id
GROUP BY c.id, c.nombre, c.apellido
HAVING COUNT(m.id) > 1;

-- 7. Listar los veterinarios que no han atendido ninguna consulta.
SELECT v.nombre || ' ' || v.apellido AS veterinario
FROM veterinarios v
LEFT JOIN consultas co ON co.veterinario_id = v.id
WHERE co.id IS NULL;

-- 8. Identificar la mascota con mayor número de consultas registradas.
SELECT m.nombre, COUNT(co.id) AS total_consultas
FROM mascotas m
JOIN consultas co ON co.mascota_id = m.id
GROUP BY m.id, m.nombre
ORDER BY total_consultas DESC
LIMIT 1;
