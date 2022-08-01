USE `Empresa`;
Select * from departamento;
Select * from empleado;

-- LEFT outer join

SELECT *
FROM empleado LEFT JOIN departamento
ON empleado.codigo_departamento = departamento.codigo;

-- RIGHT outer JOIN

SELECT *
FROM empleado RIGHT JOIN departamento
ON empleado.codigo_departamento = departamento.codigo;

-- 1. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
-- Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

SELECT *
FROM empleado LEFT JOIN departamento
ON empleado.codigo_departamento = departamento.codigo;

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

UPDATE empleado
		SET codigo_departamento = null
			where codigo=1;
        
SELECT *
FROM empleado LEFT JOIN departamento
ON empleado.codigo_departamento = departamento.codigo
WHERE codigo_departamento is null;

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

UPDATE empleado
		SET codigo_departamento = null
			where codigo=6;
            
SELECT departamento.nombre
FROM empleado RIGHT JOIN departamento
ON empleado.codigo_departamento = departamento.codigo
WHERE codigo_departamento is null;

-- 4. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
-- 	  El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que 
--    no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

SELECT E.*, D.nombre as nombre_dept
FROM empleado E left JOIN departamento D
ON E.codigo_departamento = D.codigo
union
SELECT E.*, D.nombre as nombre_dept
FROM empleado E right JOIN departamento D
ON E.codigo_departamento = D.codigo
order by nombre_dept;
   
-- 5. Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que 
--    no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
SELECT E.*, D.nombre as nombre_dept
FROM empleado E left JOIN departamento D
ON E.codigo_departamento = D.codigo
where E.codigo_departamento is null
union
SELECT E.*, D.nombre as nombre_dept
FROM empleado E right JOIN departamento D
ON E.codigo_departamento = D.codigo
where E.codigo_departamento is null
order by nombre_dept;