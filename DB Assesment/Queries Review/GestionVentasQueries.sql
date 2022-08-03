-- --------------------------------------------------------------------------------
-- Consultas para la base de datos Gestión de Ventas
-- --------------------------------------------------------------------------------

USE GestionVentas;

-- --------------------------------------------------------------------------------
-- Consultas sobre una tabla
-- --------------------------------------------------------------------------------

-- 1. 	Devuelve un listado con todos los pedidos que se han realizado. Los pedidos 
--      deben estar ordenados por la fecha de realización, mostrando en primer 
--      lugar los pedidos más recientes.

		SELECT *
		FROM PEDIDO
		ORDER BY FECHA DESC;

-- 2. 	Devuelve todos los datos de los dos pedidos de mayor valor.

		SELECT *
        FROM PEDIDO
        ORDER BY CANTIDAD DESC LIMIT 2;

-- 3. 	Devuelve un listado con los identificadores de los clientes que han realizado 
--      algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén 
--      repetidos.

		SELECT DISTINCT ID_CLIENTE
        FROM PEDIDO;

-- 4. 	Devuelve un listado de todos los pedidos que se realizaron durante el año 
--      2017, cuya cantidad total sea superior a 500€.

		SELECT *
        FROM PEDIDO
        WHERE FECHA LIKE '2017%' AND CANTIDAD > 500;

-- 5. 	Devuelve un listado con el nombre y los apellidos de los comerciales que 
-- 		tienen una comisión entre 0.05 y 0.11.

		SELECT concat_ws(' ', NOMBRE, APELLIDO1, APELLIDO2) AS LISTADO
        FROM COMERCIAL
        WHERE COMISION >= 0.05 AND COMISION <= 0.11;

-- 6. 	Devuelve el valor de la comisión de mayor valor que existe en la tabla 
--      comercial.

		SELECT MAX(COMISION)
        FROM COMERCIAL;
        
-- 7. 	Devuelve el identificador, nombre y primer apellido de aquellos clientes 
--      cuyo segundo apellido no es NULL. El listado deberá estar ordenado 
--      alfabéticamente por apellidos y nombre.

		SELECT IDCLIENTE, CONCAT_WS(' ', APELLIDO1, NOMBRE) AS CLIENTES
        FROM CLIENTE
        WHERE APELLIDO2 IS NOT NULL
        ORDER BY APELLIDO1, NOMBRE ASC;

-- 8. 	Devuelve un listado de los nombres de los clientes que empiezan por A y 
--      terminan por n y también los nombres que empiezan por P. El listado 
--      deberá estar ordenado alfabéticamente.

		SELECT NOMBRE
        FROM CLIENTE
        WHERE NOMBRE LIKE 'A%N' OR NOMBRE LIKE 'P%'
        ORDER BY NOMBRE ASC;

-- 9. 	Devuelve un listado de los nombres de los clientes que no empiezan por A. 
--      El listado deberá estar ordenado alfabéticamente.

		SELECT NOMBRE
        FROM CLIENTE
        WHERE NOMBRE NOT LIKE 'A%'
        ORDER BY NOMBRE ASC;

-- 10.  Devuelve un listado con los nombres de los comerciales que terminan por EL 
--      o O. Tenga en cuenta que se deberán eliminar los nombres repetidos.

		SELECT DISTINCT NOMBRE
        FROM COMERCIAL
        WHERE NOMBRE LIKE '%EL' OR NOMBRE LIKE '%O';

-- --------------------------------------------------------------------------------
-- Consultas multitabla (Composición interna)
-- --------------------------------------------------------------------------------

-- 1. Devuelve un listado con el identificador, nombre y los apellidos de todos los 
--    clientes que han realizado algún pedido. El listado debe estar ordenado 
--    alfabéticamente y se deben eliminar los elementos repetidos.

		SELECT DISTINCT concat_ws(' ', NOMBRE, APELLIDO1, APELLIDO2) AS CLIENTES, IDCLIENTE
        FROM CLIENTE
        INNER JOIN PEDIDO ON IDCLIENTE = ID_CLIENTE;

-- 2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
--    El resultado debe mostrar todos los datos de los pedidos y del cliente. 
--    El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

		SELECT *
        FROM CLIENTE
        INNER JOIN PEDIDO ON IDCLIENTE = ID_CLIENTE
        ORDER BY NOMBRE, APELLIDO1, APELLIDO2 ASC;

-- 3. Devuelve un listado que muestre todos los pedidos en los que ha participado un 
--    comercial. El resultado debe mostrar todos los datos de los pedidos y de los 
--    comerciales. El listado debe mostrar los datos de los comerciales ordenados 
--    alfabéticamente.

		SELECT *
        FROM COMERCIAL
        INNER JOIN PEDIDO ON IDCOMERCIAL = ID_COMERCIAL
        ORDER BY NOMBRE, APELLIDO1, APELLIDO2 ASC;

-- 4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han  
--    realizado y con los datos de los comerciales asociados a cada pedido.

		SELECT 
			concat_ws(' ', C.NOMBRE, C.APELLIDO1, C.APELLIDO2) AS CLIENTE,
            IDCLIENTE, C.CIUDAD, CATEGORIA, 
            concat_ws(' ', CM.NOMBRE, CM.APELLIDO1, CM.APELLIDO2) AS COMERCIAL,
            IDCOMERCIAL, CM.CIUDAD, COMISION,
            IDPEDIDO, CANTIDAD, FECHA
        FROM CLIENTE C
        INNER JOIN PEDIDO P ON IDCLIENTE = ID_CLIENTE
        INNER JOIN COMERCIAL CM ON IDCOMERCIAL = ID_COMERCIAL
        ORDER BY FECHA DESC;

-- 5. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 
--    2017, cuya cantidad esté entre 300 € y 1000 €.

		SELECT concat_ws(' ', NOMBRE, APELLIDO1, APELLIDO2) AS CLIENTE
        FROM CLIENTE
        INNER JOIN PEDIDO ON IDCLIENTE = ID_CLIENTE
        WHERE FECHA LIKE '2017%' AND CANTIDAD BETWEEN 300 AND 1000;

-- 6. Devuelve el nombre y los apellidos de todos los comerciales que han participado en 
--    algún pedido realizado por María Santana Moreno.

		SELECT concat_ws(' ', CM.NOMBRE, CM.APELLIDO1, CM.APELLIDO2) AS COMERCIAL
        FROM COMERCIAL CM
        INNER JOIN PEDIDO ON IDCOMERCIAL = ID_COMERCIAL
        INNER JOIN CLIENTE C ON IDCLIENTE = ID_CLIENTE
        WHERE concat_ws(' ', C.NOMBRE, C.APELLIDO1, C.APELLIDO2) = 'María Santana Moreno';

-- 7. Devuelve el nombre de todos los clientes que han realizado algún pedido con el 
--    comercial Daniel Sáez Vega.

		SELECT DISTINCT concat_ws(' ', C.NOMBRE, C.APELLIDO1, C.APELLIDO2) AS CLIENTES
        FROM CLIENTE C
        INNER JOIN PEDIDO ON IDCLIENTE = ID_CLIENTE
        INNER JOIN COMERCIAL CM ON IDCOMERCIAL = ID_COMERCIAL
        WHERE concat_ws(' ', CM.NOMBRE, CM.APELLIDO1, CM.APELLIDO2) = 'Daniel Sáez Vega';

-- --------------------------------------------------------------------------------
-- Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN ó RIGHT JOIN.
-- --------------------------------------------------------------------------------

-- 1. Devuelve un listado con todos los clientes junto con los datos de los pedidos 
--    que han realizado. Este listado también debe incluir los clientes que no han 
--    realizado ningún pedido. El listado debe estar ordenado alfabéticamente por 
--    el primer apellido, segundo apellido y nombre de los clientes.

		SELECT *
        FROM PEDIDO
        RIGHT JOIN CLIENTE ON IDCLIENTE = ID_CLIENTE
        ORDER BY APELLIDO1, APELLIDO2, NOMBRE DESC;

-- 2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos 
--    que han realizado. Este listado también debe incluir los comerciales que no han 
--    realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el 
--    primer apellido, segundo apellido y nombre de los comerciales.

		SELECT *
        FROM PEDIDO
        RIGHT JOIN COMERCIAL ON IDCOMERCIAL = ID_COMERCIAL
        ORDER BY APELLIDO1, APELLIDO2, NOMBRE DESC;
		
        -- Actualización
		INSERT INTO Comercial VALUES(9, 'Génesis','Aveiga', 'Flores','Barcelona', 0.05);
        
-- 3. Devuelve un listado que solamente muestre los clientes que no han realizado 
--    ningún pedido.

		SELECT Cliente.*
        FROM Cliente
        LEFT JOIN Pedido ON idCliente = id_Cliente
        WHERE idPedido is null;

-- 4. Devuelve un listado que solamente muestre los comerciales que no han realizado 
--    ningún pedido.

		SELECT Comercial.*
        FROM Comercial
        LEFT JOIN Pedido ON idComercial = id_Comercial
        WHERE idPedido is null;

-- 5. Devuelve un listado con los clientes que no han realizado ningún pedido y de 
--    los comerciales que no han participado en ningún pedido. Ordene el listado 
--    alfabéticamente por los apellidos y el nombre. En el listado deberá diferenciar 
--    de algún modo los clientes y los comerciales.


		SELECT 
			'Cliente' as Type,
			concat_ws(' ', C.NOMBRE, C.APELLIDO1, C.APELLIDO2) as Nombre
        FROM Pedido
        RIGHT JOIN Cliente C ON idCliente = id_Cliente
        WHERE idPedido is null 
        UNION
			SELECT 
				'Comercial',
				concat_ws(' ', CM.NOMBRE, CM.APELLIDO1, CM.APELLIDO2) as Nombre
            FROM Pedido
            RIGHT JOIN Comercial CM ON idComercial = id_Comercial
            WHERE idPedido is null;

-- --------------------------------------------------------------------------------
-- Consultas resumen
-- --------------------------------------------------------------------------------

-- 1. Calcula la cantidad total de todos los pedidos que aparecen en la tabla pedido.

		Select	round(sum(Cantidad), 2) as Cantidad_Total from Pedido;

-- 2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.

		Select	round(avg(Cantidad), 2) as Cantidad_Total from Pedido;

-- 3. Calcula el total de comerciales distintos que aparecen en la tabla pedido.

		Select count(distinct id_Comercial) as Total_Comerciales from Pedido;

-- 4. Calcula el número total de clientes que aparecen en la tabla cliente.

		Select count(idCliente) from Cliente;

-- 5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.

		

-- 6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.



-- 7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades 
--    que aparece en la tabla cliente.



-- 8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo 
--    día para cada uno de los clientes. Es decir, el mismo cliente puede haber 
--    realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se 
--    calcule cuál es el pedido de máximo valor para cada uno de los días en los que 
--    un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, 
--    apellidos, la fecha y el valor de la cantidad.



-- 9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día 
--    para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar 
--    aquellos pedidos que superen la cantidad de 2000 €.



-- 10. Calcula el máximo valor de los pedidos realizados para cada uno de los  
--     comerciales durante la fecha 2016-08-17. Muestra el identificador del 
--     comercial, nombre, apellidos y total.



-- 11. Devuelve un listado con el identificador de cliente, nombre y apellidos y 
--     el número total de pedidos que ha realizado cada uno de los clientes. 
--     Tenga en cuenta que pueden existir clientes que no han realizado ningún 
--     pedido. Estos clientes también deben aparecer en el listado indicando que 
--     el número de pedidos realizados es 0.



-- 12. Devuelve un listado con el identificador de cliente, nombre y apellidos y 
--     el número total de pedidos que ha realizado cada uno de clientes durante 
--     el año 2017.


 
-- 13. Devuelve un listado que muestre el identificador de cliente, nombre, primer 
--     apellido y el valor de la máxima cantidad del pedido realizado por cada uno 
--     de los clientes. El resultado debe mostrar aquellos clientes que no han 
--     realizado ningún pedido indicando que la máxima cantidad de sus pedidos 
--     realizados es 0. Puede hacer uso de la función IFNULL.



-- 14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.



-- 15. Devuelve el número total de pedidos que se han realizado cada año.



-- --------------------------------------------------------------------------------
-- Subconsultas
-- Con operadores básicos de comparación
-- --------------------------------------------------------------------------------

-- 1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. 
--      (Sin utilizar INNER JOIN).



-- 2. Devuelve el número de pedidos en los que ha participado el comercial Daniel 
--    Sáez Vega. (Sin utilizar INNER JOIN)



-- 3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. 
--    (Sin utilizar INNER JOIN)



-- 4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el 
--    cliente Pepe Ruiz Santana.



-- 5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los 
--    clientes que han realizado un pedido durante el año 2017 con un valor mayor o 
--    igual al valor medio de los pedidos realizados durante ese mismo año.
 
-- --------------------------------------------------------------------------------
-- Subconsultas con ALL y ANY
-- --------------------------------------------------------------------------------
 
-- 6. Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX, 
--    ORDER BY ni LIMIT.



-- 7. Devuelve un listado de los clientes que no han realizado ningún pedido. 
--    (Utilizando ANY o ALL).



-- 8. Devuelve un listado de los comerciales que no han realizado ningún pedido. 
--    (Utilizando ANY o ALL).

-- -------------------------------------------------------------------------------- 
-- Subconsultas con IN y NOT IN
-- --------------------------------------------------------------------------------
 
-- 9. Devuelve un listado de los clientes que no han realizado ningún pedido. 
--   (Utilizando IN o NOT IN).


-- 10. Devuelve un listado de los comerciales que no han realizado ningún pedido. 
--     (Utilizando IN o NOT IN).
 
-- --------------------------------------------------------------------------------
-- Subconsultas con EXISTS y NOT EXISTS
-- --------------------------------------------------------------------------------
 
-- 11. Devuelve un listado de los clientes que no han realizado ningún pedido. 
--     (Utilizando EXISTS o NOT EXISTS).



-- 12. Devuelve un listado de los comerciales que no han realizado ningún pedido. 
--     (Utilizando EXISTS o NOT EXISTS).

