SELECT apellido1, apellido2, nombre, tipo FROM persona WHERE tipo = "alumno" ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
SELECT apellido1, apellido2, nombre, tipo, telefono FROM persona WHERE tipo = "alumno" AND telefono IS NULL;
SELECT apellido1, apellido2, nombre, tipo, fecha_nacimiento FROM persona WHERE tipo = "alumno" AND YEAR (fecha_nacimiento) = 1999;
SELECT apellido1, apellido2, nombre, tipo, nif, telefono FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND nif LIKE '%K';
SELECT nombre, cuatrimestre, curso, id_grado FROM asignatura WHERE id_grado = 7 AND cuatrimestre = 1 AND curso = 3;
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS nombre_departamento FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
SELECT persona.nombre, persona.apellido1, nif, asignatura.nombre AS nombre_asignatura, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.nif = '26902806M';
SELECT DISTINCT departamento.nombre AS nombre_departamento, persona.nombre, persona.apellido1 FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id JOIN persona on profesor.id_profesor = persona.id WHERE grado.nombre = "Grado en Ingeniería Informática (Plan 2015)";
SELECT DISTINCT persona.apellido1, persona.apellido2, persona.nombre FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = 2018 and curso_escolar.anyo_fin = 2019;
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS nombre_departamento FROM persona left JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN  departamento ON profesor.id_departamento = departamento.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_departamento IS NULL ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
SELECT departamento.nombre AS nombre_departamneto FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL ORDER BY departamento.nombre;
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
SELECT asignatura.nombre AS nombre_asignatura FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL ORDER BY asignatura.nombre;
SELECT DISTINCT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL ORDER BY departamento.nombre;
SELECT COUNT(*) AS numero_de_alumnos FROM persona WHERE persona.tipo = "alumno";
SELECT COUNT(*) AS numero_de_alumnos_1999 FROM persona WHERE persona.tipo = "alumno" AND YEAR(persona.fecha_nacimiento) = 1999;
SELECT departamento.nombre AS nombre_departamento, COUNT(profesor.id_profesor) AS numero_profesores FROM departamento JOIN profesor ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY numero_profesores DESC;
SELECT departamento.nombre AS nombre_departamento, COUNT(profesor.id_profesor) AS numero_profesores FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY numero_profesores DESC;
SELECT grado.nombre AS nombre_de_grado, COUNT(asignatura.id) AS numero_de_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY numero_de_asignaturas DESC;
SELECT grado.nombre AS nombre_de_grado, COUNT(asignatura.id) AS numero_de_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING numero_de_asignaturas > 40;
SELECT grado.nombre AS nombre_de_grado, asignatura.tipo, SUM(asignatura.creditos) AS numero_creditos FROM grado JOIN asignatura ON grado.ID = asignatura.id_grado GROUP BY nombre_de_grado, asignatura.tipo ORDER BY numero_creditos;
SELECT curso_escolar.anyo_inicio AS año_inicio_curso, COUNT(alumno_se_matricula_asignatura.id_alumno) AS numero_alumnos FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY año_inicio_curso;
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS numero_asignaturas FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY persona.id, nombre, apellido1, apellido2 ORDER BY numero_asignaturas;
SELECT DISTINCT persona.* FROM persona JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE fecha_nacimiento = (SELECT MIN(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');