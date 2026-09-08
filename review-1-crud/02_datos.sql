-- =========================================================
-- Review 1 - CRUD
-- Datos de prueba
-- =========================================================

INSERT INTO veterinarios (nombre, apellido, especialidad, fecha_contratacion, telefono) VALUES
('Laura', 'Ramírez', 'Medicina General', '2021-03-10', '5501-1111'),
('Carlos', 'Estrada', 'Cirugía', '2019-07-22', '5501-2222'),
('Fernanda', 'Ochoa', 'Dermatología', '2022-01-15', '5501-3333'),
('Mario', 'Pineda', 'Odontología', '2020-11-05', '5501-4444'),
('Diana', 'Rosales', 'Medicina General', '2023-05-30', '5501-5555');

INSERT INTO clientes (nombre, apellido, telefono, email, fecha_registro) VALUES
('Ana', 'García', '5502-0001', 'ana.garcia@mail.com', '2024-01-12'),
('Luis', 'Martínez', '5502-0002', 'luis.martinez@mail.com', '2024-02-20'),
('Sofía', 'Hernández', '5502-0003', 'sofia.hernandez@mail.com', '2024-03-05'),
('Pedro', 'López', '5502-0004', 'pedro.lopez@mail.com', '2024-04-18'),
('Valeria', 'Cruz', '5502-0005', 'valeria.cruz@mail.com', '2025-01-09'),
('Jorge', 'Morales', '5502-0006', 'jorge.morales@mail.com', '2025-02-14'),
('Camila', 'Ríos', '5502-0007', 'camila.rios@mail.com', '2025-03-22'),
('Diego', 'Salazar', '5502-0008', 'diego.salazar@mail.com', '2025-04-11'),
('Paola', 'Vásquez', '5502-0009', 'paola.vasquez@mail.com', '2025-05-30'),
('Andrés', 'Fuentes', '5502-0010', 'andres.fuentes@mail.com', '2025-06-08');

INSERT INTO mascotas (cliente_id, nombre, especie, raza, fecha_nacimiento, peso, activo) VALUES
(1, 'Rocky', 'Perro', 'Labrador', '2020-05-14', 28.50, TRUE),
(1, 'Michi', 'Gato', 'Siamés', '2021-08-02', 4.20, TRUE),
(2, 'Toby', 'Perro', 'Poodle', '2019-11-30', 6.80, TRUE),
(3, 'Luna', 'Gato', 'Persa', '2022-02-10', 3.90, TRUE),
(3, 'Max', 'Perro', 'Bulldog', '2018-06-25', 22.10, FALSE),
(4, 'Kiwi', 'Ave', 'Periquito', '2023-01-05', 0.05, TRUE),
(5, 'Nina', 'Perro', 'Chihuahua', '2021-09-19', 2.30, TRUE),
(6, 'Simón', 'Gato', 'Mestizo', '2020-12-01', 5.10, TRUE),
(6, 'Coco', 'Conejo', 'Holandés', '2022-07-08', 1.80, TRUE),
(7, 'Zeus', 'Perro', 'Pastor Alemán', '2017-03-22', 34.60, TRUE),
(8, 'Mia', 'Gato', 'Mestizo', '2023-04-15', 3.40, TRUE),
(9, 'Bruno', 'Perro', 'Beagle', '2021-01-28', 12.90, TRUE),
(9, 'Pelusa', 'Conejo', 'Mestizo', '2022-10-11', 1.50, FALSE),
(10, 'Rex', 'Perro', 'Boxer', '2019-08-17', 26.40, TRUE),
(10, 'Nube', 'Gato', 'Angora', '2023-06-02', 3.10, TRUE);

INSERT INTO consultas (mascota_id, veterinario_id, fecha, motivo, diagnostico, costo) VALUES
(1, 1, '2025-06-01', 'Vacunación anual', 'Saludable', 150.00),
(2, 3, '2025-06-03', 'Alergia en la piel', 'Dermatitis leve', 220.00),
(3, 2, '2025-06-05', 'Cojera pata trasera', 'Esguince leve', 310.00),
(4, 1, '2025-06-08', 'Chequeo general', 'Saludable', 120.00),
(5, 2, '2025-06-10', 'Cirugía de esterilización', 'Recuperación normal', 850.00),
(6, 3, '2025-06-12', 'Plumaje opaco', 'Deficiencia nutricional', 90.00),
(7, 4, '2025-06-15', 'Revisión dental', 'Sarro leve', 180.00),
(8, 1, '2025-06-18', 'Vómito recurrente', 'Gastritis', 200.00),
(9, 1, '2025-06-20', 'Chequeo general', 'Saludable', 100.00),
(10, 2, '2025-06-22', 'Dolor articular', 'Displasia de cadera', 400.00),
(11, 3, '2025-06-24', 'Comezón excesiva', 'Dermatitis alérgica', 210.00),
(12, 4, '2025-06-26', 'Mal aliento', 'Gingivitis', 160.00),
(14, 2, '2025-06-28', 'Herida en pata', 'Sutura menor', 280.00),
(15, 3, '2025-06-30', 'Chequeo general', 'Saludable', 110.00),
(1, 4, '2025-07-02', 'Revisión dental', 'Saludable', 140.00),
(3, 1, '2025-07-05', 'Seguimiento esguince', 'Mejoría notable', 130.00),
(7, 2, '2025-07-08', 'Chequeo prequirúrgico', 'Apto para cirugía', 175.00),
(10, 1, '2025-07-10', 'Seguimiento cadera', 'Estable', 190.00),
(14, 3, '2025-07-12', 'Revisión herida', 'Cicatrización correcta', 95.00),
(4, 4, '2025-07-15', 'Revisión dental', 'Saludable', 115.00);
