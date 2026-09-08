-- =========================================================
-- Review 1 - CRUD
-- Esquema: Clínica Veterinaria
-- =========================================================

CREATE TABLE veterinarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(60),
    fecha_contratacion DATE,
    telefono VARCHAR(15)
);

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    fecha_registro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE mascotas (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES clientes(id),
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raza VARCHAR(50),
    fecha_nacimiento DATE,
    peso NUMERIC(5,2),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    mascota_id INT NOT NULL REFERENCES mascotas(id),
    veterinario_id INT NOT NULL REFERENCES veterinarios(id),
    fecha DATE NOT NULL,
    motivo VARCHAR(100),
    diagnostico VARCHAR(200),
    costo NUMERIC(8,2)
);
