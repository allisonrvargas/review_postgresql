# Reviews de PostgreSQL - Clínica Veterinaria

Repositorio destinado a documentar y almacenar la resolución de los reviews de bases de datos asignados en clase, usando como caso de estudio una clínica veterinaria.

## 👨‍💻 Información del Estudiante

* **Nombre:** Allison Rocio Vargas Mejía
* **Usuario GitHub:** allisonrvargas
* **Rol:** Estudiante de Desarrollo de Software y Bases de Datos

## 📂 Estructura y Progreso de los Reviews

| Review | Estado | Tema |
| :--- | :---: | :--- |
| **Review 1** | ✅ Completado | CRUD: consultas SELECT, UPDATE y DELETE |
| **Review 2** | ✅ Completado | Consultas: JOIN, GROUP BY, HAVING |
| **Review 3** | ✅ Completado | Funciones de ventana y CTE |
| **Review 4** | ✅ Completado | Vistas, procedimientos y funciones |

## 🗂️ Estructura del repositorio

```
mi-review/
├── review-1-crud/
│   ├── 01_esquema.sql       # DDL: creación de tablas
│   ├── 02_datos.sql         # DML: datos de prueba
│   └── 03_ejercicios.sql    # SELECT, UPDATE, DELETE
├── review-2-consultas/
│   └── 01_consultas.sql     # JOIN, GROUP BY, HAVING, subconsultas
├── review-3-ventana-cte/
│   └── 01_consultas.sql     # Funciones de ventana y CTE
├── review-4-vistas-procedimientos/
│   └── 01_objetos.sql       # Vistas, procedimiento y función
└── README.md
```

## 🗃️ Modelo de datos

- **veterinarios**: personal médico de la clínica
- **clientes**: dueños de las mascotas
- **mascotas**: pacientes de la clínica, asociados a un cliente
- **consultas**: historial de visitas, cada una ligada a una mascota y a un veterinario
