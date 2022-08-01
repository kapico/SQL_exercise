USE `Empresa`;

-- 1. Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).



-- 2. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.



-- 3. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
 
 
 
--   Subconsultas con ALL y ANY
 
-- 4. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT.



-- 5. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT.



-- 6. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).



-- 7. Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).

Select nombre from departamento where codigo != all (select codigo_departamento from empleado);
 
-- 	 Subconsultas con IN y NOT IN
 
-- 8. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).



-- 9. Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).


 
-- 	 Subconsultas con EXISTS y NOT EXISTS
 
-- 10. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).



-- 11. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).


