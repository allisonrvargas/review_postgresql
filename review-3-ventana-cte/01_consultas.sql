-- =========================================================
-- Review 3 - Funciones de ventana y CTE
-- =========================================================

-- 1. Ranking de veterinarios según el total facturado (mayor a menor).
WITH facturacion_vet AS (
    SELECT v.id, v.nombre || ' ' || v.apellido AS veterinario, SUM(co.costo) AS total
    FROM consultas co
    JOIN veterinarios v ON co.veterinario_id = v.id
    GROUP BY v.id, v.nombre, v.apellido
)
SELECT veterinario, total,
       RANK() OVER (ORDER BY total DESC) AS ranking
FROM facturacion_vet;

-- 2. Numerar las consultas de cada mascota en orden cronológico.
SELECT m.nombre AS mascota, co.fecha,
       ROW_NUMBER() OVER (PARTITION BY co.mascota_id ORDER BY co.fecha) AS numero_visita
FROM consultas co
JOIN mascotas m ON co.mascota_id = m.id
ORDER BY m.nombre, numero_visita;

-- 3. Calcular qué porcentaje representa cada consulta del total facturado por su veterinario.
SELECT co.id, v.nombre || ' ' || v.apellido AS veterinario, co.costo,
       ROUND(
           co.costo / SUM(co.costo) OVER (PARTITION BY co.veterinario_id) * 100,
           2
       ) AS porcentaje_del_total
FROM consultas co
JOIN veterinarios v ON co.veterinario_id = v.id
ORDER BY veterinario, porcentaje_del_total DESC;

-- 4. CTE: clientes cuyo gasto total en consultas supera Q400.
WITH gasto_cliente AS (
    SELECT c.id, c.nombre || ' ' || c.apellido AS cliente, SUM(co.costo) AS gasto_total
    FROM clientes c
    JOIN mascotas m ON m.cliente_id = c.id
    JOIN consultas co ON co.mascota_id = m.id
    GROUP BY c.id, c.nombre, c.apellido
)
SELECT cliente, gasto_total
FROM gasto_cliente
WHERE gasto_total > 400
ORDER BY gasto_total DESC;

-- 5. Diferencia de costo entre cada consulta y la consulta anterior de la misma mascota.
SELECT m.nombre AS mascota, co.fecha, co.costo,
       co.costo - LAG(co.costo) OVER (PARTITION BY co.mascota_id ORDER BY co.fecha) AS diferencia_vs_anterior
FROM consultas co
JOIN mascotas m ON co.mascota_id = m.id
ORDER BY mascota, co.fecha;

-- 6. CTE + ranking: top 3 mascotas con más consultas registradas.
WITH conteo_consultas AS (
    SELECT m.id, m.nombre, COUNT(co.id) AS total_consultas
    FROM mascotas m
    JOIN consultas co ON co.mascota_id = m.id
    GROUP BY m.id, m.nombre
)
SELECT nombre, total_consultas,
       RANK() OVER (ORDER BY total_consultas DESC) AS puesto
FROM conteo_consultas
ORDER BY puesto
LIMIT 3;
