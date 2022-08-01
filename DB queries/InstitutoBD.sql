DROP DATABASE IF EXISTS instituto;
CREATE DATABASE instituto CHARACTER SET utf8mb4;
USE instituto;
CREATE TABLE alumno (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
fecha_nacimiento DATE NOT NULL,
es_repetidor ENUM('sí', 'no') NOT NULL,
teléfono VARCHAR(9)
);
INSERT INTO alumno VALUES(1, 'María', 'Sánchez', 'Pérez',
'1990/12/01', 'no', NULL);
INSERT INTO alumno VALUES(2, 'Juan', 'Sáez', 'Vega',
'1998/04/02', 'no', 618253876);
INSERT INTO alumno VALUES(3, 'Pepe', 'Ramírez', 'Gea',
'1988/01/03', 'no', NULL);
INSERT INTO alumno VALUES(4, 'Lucía', 'Sánchez', 'Ortega',
'1993/06/13', 'sí', 678516294);
INSERT INTO alumno VALUES(5, 'Paco', 'Martínez', 'López',
'1995/11/24', 'no', 692735409);
INSERT INTO alumno VALUES(6, 'Irene', 'Gutiérrez', 'Sánchez',
'1991/03/28', 'sí', NULL);
INSERT INTO alumno VALUES(7, 'Cristina', 'Fernández',
'Ramírez', '1996/09/17', 'no', 628349590);
INSERT INTO alumno VALUES(8, 'Antonio', 'Carretero', 'Ortega',
'1994/05/20', 'sí', 612345633);
INSERT INTO alumno VALUES(9, 'Manuel', 'Domínguez',
'Hernández', '1999/07/08', 'no', NULL);
INSERT INTO alumno VALUES(10, 'Daniel', 'Moreno', 'Ruiz',
'1998/02/03', 'no', NULL);

select lower(concat_ws(' ',nombre, apellido1, apellido2)) as columna1 from alumno;
select upper(concat_ws(' ',nombre, apellido1, apellido2)) as columna2 from alumno;
UPDATE alumno SET apellido2 = null WHERE id = 6;
select concat(' ',nombre, apellido1, apellido2) or lower(concat_ws(' ',nombre, apellido1, apellido2)) from alumno; 

-- 13/07/22
-- 1. Devuelve los datos del alumno cuyo id es igual a 1.
select * from alumno where id = 1;
-- 2. 2. Devuelve los datos del alumno cuyo teléfono es igual a 692735409.
select * from alumno where teléfono = 692735409;
-- 3. Devuelve un listado de todos los alumnos que son repetidores.
select * from alumno where es_repetidor = 'si';
-- 4. Devuelve un listado de todos los alumnos que no son repetidores.
select * from alumno where es_repetidor = 'no';
-- 5. Devuelve el listado de los alumnos que han nacido antes del 1 de
-- enero de 1993.
	select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento
			from alumno 
				where fecha_nacimiento < '1993/01/01'; 
-- 6. Devuelve el listado de los alumnos que han nacido después del 1
-- de enero de 1994.
	select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento 
			from alumno 
				where fecha_nacimiento > '1994/01/01'; 
-- 7. Devuelve el listado de los alumnos que han nacido después del 1
-- de enero de 1994 y no son repetidores.
	select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_repetidores 
			from alumno 
				where fecha_nacimiento > '1994/01/01' and es_repetidor = 'no'; 
-- 8. Devuelve el listado de todos los alumnos que nacieron en 1998.
	select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento 
			from alumno 
				where fecha_nacimiento between '1998/01/01' and '1998/12/31';
-- 9. Devuelve el listado de todos los alumnos que no nacieron en 1998.
	select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento 
			from alumno 
				where fecha_nacimiento not between '1998/01/01' and '1998/12/31';
-- 1. Devuelve los datos de los alumnos que hayan nacido entre el 1 de
-- enero de 1998 y el 31 de mayo de 1998.
select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento 
			from alumno 
				where fecha_nacimiento between '1998/01/01' and '1998/05/31';
-- 2. Devuelve los datos de los alumnos que no hayan nacido entre el
-- 1 de enero de 1998 y el 31 de mayo de 1998.
select concat_ws(' ',nombre, apellido1, apellido2) 
		as Listado_nacimiento 
			from alumno 
				where fecha_nacimiento not between '1998/01/01' and '1998/12/31';
-- 1. Devuelve un listado con dos columnas, donde aparezca en la
-- primera columna el nombre de los alumnos y en la segunda, el
-- nombre con todos los caracteres invertidos.
	select nombre, 
		reverse(nombre) as n_invertido
			from alumno;
-- 2. Devuelve un listado con dos columnas, donde aparezca en la
-- primera columna el nombre y los apellidos de los alumnos y en la
-- segunda, el nombre y los apellidos con todos los caracteres
-- invertidos.
	select concat_ws(' ', nombre, apellido1, apellido2) as nombre,
		concat_ws(' ', reverse (nombre), reverse(apellido1), reverse(apellido2)) as nom_reverse
			from alumno;
-- 3. Devuelve un listado con dos columnas, donde aparezca en la
-- primera columna el nombre y los apellidos de los alumnos en
-- mayúscula y en la segunda, el nombre y los apellidos con todos
-- los caracteres invertidos en minúscula.
	select upper(concat_ws(' ', nombre, apellido1, apellido2)) as nombre,
		lower(concat_ws(' ', reverse (nombre), reverse(apellido1), reverse(apellido2))) as nom_reverse
			from alumno;
-- 4. Devuelve un listado con tres columnas, donde aparezca en la
-- primera columna el nombre y los apellidos de los alumnos, en la
-- segunda, el número de caracteres que tiene en total el nombre y
-- los apellidos y en la tercera el número de bytes que ocupa en
-- total.
	select concat_ws(' ', nombre, apellido1, apellido2) as nombre,
			char_length(concat_ws(nombre, apellido1, apellido2)) as num_char,
            length(concat_ws(nombre, apellido1, apellido2)) as bytes
				from alumno;
-- 5. Devuelve un listado con dos columnas, donde aparezca en la
-- primera columna el nombre y los dos apellidos de los alumnos. En
-- la segunda columna se mostrará una dirección de correo
-- electrónico que vamos a calcular para cada alumno. La dirección
-- de correo estará formada por el nombre y el primer apellido,
-- separados por el carácter . y seguidos por el
-- dominio @iescelia.org . Tenga en cuenta que la dirección de
-- correo electrónico debe estar en minúscula. Utilice un alias
-- apropiado para cada columna.
	select concat_ws(' ', nombre, apellido1, apellido2) as nombre,
			lower(concat(nombre, '.', apellido1,'@iescelia.org')) as correo
				from alumno;			
-- 6. Lo anterior + una tercera columna será una contraseña que vamos a generar
-- formada por los caracteres invertidos del segundo apellido,
-- seguidos de los cuatro caracteres del año de la fecha de
-- nacimiento. Utilice un alias apropiado para cada columna.
	select concat_ws(' ', nombre, apellido1, apellido2) as nombre,
			lower(concat(nombre, '.', apellido1,'@iescelia.org')) as correo,
            concat(reverse(apellido2),left(fecha_nacimiento, 4)) as contraseña
				from alumno;