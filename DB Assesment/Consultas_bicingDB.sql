-- --------------------------------------------------------------------------------
-- Consultas para una base de datos de gestión del Servicio de Bicing de Barcelona
-- --------------------------------------------------------------------------------

USE `Model_Bicing` ;

-- --------------------------------------------------------------------------------
-- 10 consultas de una tabla.
-- --------------------------------------------------------------------------------

-- 1. Calcular la Edad de los usuarios de Bicing

	Select nombre, round(datediff(current_date, fecha_nacimiento)/365) as Edad 
		from USUARIO;
    
-- 2. Obtener el nombre de los usuarios mayores a 18 años 

	Select nombre 
		from USUARIO 
		where year(current_date)-year(fecha_nacimiento) > 18;
        
-- 3. Obtener el nombre de los usuarios menores a 18 años

	Select nombre 
		from USUARIO 
			where year(current_date)-year(fecha_nacimiento) < 18;
            
-- 4. Contar cuantas bicicletas están en estado activo

	Select count(estado) as Biciletas_Activas 
		from BICICLETA 
			where estado = 1;
    
-- 5. Contar cuantos usuarios no tienen una tarifa activa.

	Select count(usuario_dni) as Usuarios_Activos 
		from TARJETAS 
			where alta_tarifa is null 
				or expiracion_tarifa < current_date();
                
-- 6. Mostrar los nombres de los usuarios que nacieron antes del 
-- 	  2001 ordenados por edad de menor a mayor:

	Select nombre from usuario 
		where Fecha_nacimiento<"2001-01-01" 
			order by Fecha_nacimiento desc;

-- 7. Mostrar el nombre y el apellido de los usuarios en columnas 
--    separadas y en mayusculas:

	Select upper(substring_index(nombre, " ", 1)) 
		as Nombre, upper(substring_index(nombre, " ", -1)) as Apellido 
			from usuario 
				order by Nombre;

-- 8. Mostrar el nombre y la direccion en una sola columna de los 2 usuarios más jovenes:

	Select concat_ws(" - ", nombre, direccion) as nombre_direccion 
		from usuario 
			order by Fecha_nacimiento desc limit 2;

-- 9. Mostrar el codigo y el defecto de la bicicleta que ha estado en mantenimiento más de 1 mes:
	
    Select bicicleta_id_bici, defecto 
		from mantenimiento 
			where month(fecha_alta)-month(fecha_baja)>1;

-- 10. Contar cuantas bicicletas hay en la estación 3 que sean electricas (1)

	Select count(*) as total from bicicleta 
		where ESTACION_ID_Estacion=3 and tipo=1;       
         
-- --------------------------------------------------------------------------------
-- 10 consultas varias tablas, composición interna
-- --------------------------------------------------------------------------------

-- 1. Mostrar la ubicación de las estaciones donde se encuentran las bicicletas que 
-- 	  han recibido un mantenimiento por más de 5 días

	Select localizacion from ESTACION 
		inner join BICICLETA
			on Id_estacion = ESTACION_Id_estacion
		inner join MANTENIMIENTO
			on Id_bici = BICICLETA_Id_bici
		where datediff(fecha_alta, fecha_baja) > 5;
    
-- 2. Seleccionar el DNI y los nombres de todos los usuarios que hayan realizado 
--    un viaje equivalente o superior a 30 min.
   
	Select dni, nombre from USUARIO
		inner join ALQUILER
			ON dni = usuario_dni
		where Total_viaje >= '00:30:00';

-- 3. Mostrar el nombre y DNI de los tutores de aquellos usuarios menores de edad 
--    que tengan una tarifa activa.

	Select dni_tutor, nombre_tutor from AUTORIZACIONES A
		inner join TARJETAS T
			ON A.usuario_dni = T.usuario_dni
		where expiracion_tarifa > current_date();
        
			-- Actualización de la tabla para comprobar que la consulta funciona
				INSERT INTO `Model_Bicing`.`TARJETAS` 
					(`ID_Tarjeta`, `Fecha_alta`, `Alta_tarifa`, `Expiracion_tarifa`, `USUARIO_DNI`, `TARIFAS_ID_Tarifa`) 
						VALUES (DEFAULT, '2021-10-17', '2022-02-15', '2023-02-15', '71829371T', 1);
 
 -- 4. Muestra los tipos de bicicleta que han hecho un viaje entre 30 min y 2 horas
 
	Select A.total_viaje, B.tipo from ALQUILER A
		inner join BICICLETA B 
			on B.id_bici = A.bicicleta_id_bici
		where B.tipo = 1 and A.total_viaje between '00:30:00' and '02:00:00';
    
--  5. Muestra el nombre, Dni y total de los usuarios que tengan generada una factura
 
	Select dni, nombre, total from USUARIO
    inner join ALQUILER
    on dni = usuario_dni
    inner join FACTURACION
    on idfacturacion = facturacion_idfacturacion;
    
-- 6. Muestra el nombre de los usuarios que han alquilado una bicicleta y el tipo de esta:
	
    Select nombre, tipo from usuario u 
    join alquiler a join bicicleta b
	on u.dni=a.usuario_dni and b.id_bici=a.BICICLETA_ID_Bici;

-- 7. Muestra la localizacion y la cantidad de bicicletas de cada estacion:
	
    Select localizacion, count(*) as total from bicicleta b 
    join estacion e
	on b.ESTACION_ID_Estacion=e.ID_Estacion 
    group by ESTACION_ID_Estacion;

-- 8. Muestra el username de los usuarios que su apellido empiece por M:
	
    Select username, email from cuenta c 
    join usuario u
	on c.USUARIO_DNI=u.DNI 
    where substring_index(nombre, " ", -1) like 'M%';

-- 9. Muestra la direccion del usuario y la localizacion de la estacion de 
--   la bicicleta que se ha alquilado por mayor tiempo:
	
    Select nombre, direccion, localizacion from usuario u 
    join alquiler a join bicicleta b join estacion e
	on u.dni=a.USUARIO_DNI and b.ID_Bici=a.BICICLETA_ID_Bici and b.ESTACION_ID_Estacion=e.ID_Estacion
	order by total_viaje desc limit 1;

-- 10. Muestra los datos de los usuarios que tengan una autorizacion, una tarjeta 
--     y hayan alquilado una bicicleta;

	Select u.* from usuario u 
    join autorizaciones s 
    on s.USUARIO_DNI=u.dni 
    join tarjetas t 
    on t.USUARIO_DNI=s.USUARIO_DNI 
    join alquiler a 
    on a.USUARIO_DNI=u.dni;
		
        -- Actualización de la tabla para comprobar que la consulta funciona
		insert into autorizaciones VALUES (DEFAULT, 'Marcelita', '99999999P', '2019-04-24', '26543194K');
		select * from autorizaciones;
        
-- --------------------------------------------------------------------------------
-- 10 consultas varias tablas composición externa
-- --------------------------------------------------------------------------------

-- 1. Muestra el tipo y los datos del mantenimiento de las bicicletas que lo han recibido

	Select tipo, m.* from bicicleta b left join mantenimiento m on m.BICICLETA_ID_Bici=b.ID_Bici;

-- 2. Muestra los datos de los usuarios que tengan una autorización
	
    Select * from usuario u right join autorizaciones a on a.USUARIO_DNI=u.dni;

-- --------------------------------------------------------------------------------
-- 5 consultas resumen
-- --------------------------------------------------------------------------------



-- --------------------------------------------------------------------------------
-- 5 consultas con subconsultas
-- --------------------------------------------------------------------------------
