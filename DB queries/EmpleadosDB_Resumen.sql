USE `Empresa`;
Select * from departamento;
Select * from empleado;

-- 1. 	Calcula la suma del presupuesto de todos los departamentos.

Select sum(presupuesto) from departamento;

-- 2. 	Calcula la media del presupuesto de todos los departamentos.

Select avg(presupuesto) from departamento;

-- 3. 	Calcula el valor mínimo del presupuesto de todos los departamentos.

Select min(presupuesto) from departamento;

-- 4. 	Calcula el nombre del departamento y el presupuesto que tiene asignado,
-- 		del departamento con menor presupuesto.

Select nombre, min(presupuesto) from departamento;

-- con subconsulta

Select nombre, presupuesto from departamento
where presupuesto = (select min(presupuesto) from departamento);

-- 5. 	Calcula el valor máximo del presupuesto de todos los departamentos.

Select max(presupuesto) from departamento;

-- 6. 	Calcula el nombre del departamento y el presupuesto que tiene asignado, 
-- 		del departamento con mayor presupuesto.

Select nombre, max(presupuesto) from departamento;

-- con subconsulta

Select nombre, presupuesto from departamento
where presupuesto = (select max(presupuesto) from departamento);

-- 7. 	Calcula el número total de empleados que hay en la tabla empleado.

Select count(*) from empleado;

-- 8. 	Calcula el número de empleados que no tienen NULL en su segundo apellido.

Select count(apellido2) from empleado;

-- 9. 	Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, 
-- 		una con el nombre del departamento y otra con el número de empleados que tiene asignados.

Select D.nombre, count(E.codigo_departamento)
from departamento D Join empleado E
on E.codigo_departamento = D.codigo group by D.codigo;

update empleado
set codigo_departamento = 1
where codigo =  2;

-- 10.  Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener 
-- 		dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.

Select D.nombre, count(E.codigo_departamento) as N_empleados
from departamento D Join empleado E
on E.codigo_departamento = D.codigo 
group by D.codigo
having N_empleados > 2;

update empleado
set codigo_departamento = 3
where codigo =  5;

-- 11.  Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta 
-- 		consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.

Select D.nombre, count(E.codigo_departamento)
from departamento D left Join empleado E
on E.codigo_departamento = D.codigo group by D.codigo;

update empleado
set codigo_departamento = null
where codigo =  2;

-- 12.  Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.

Select D.nombre, count(E.codigo_departamento) as N_empleados, D.presupuesto
from departamento D Join empleado E
on E.codigo_departamento = D.codigo 
group by D.codigo
having D.presupuesto > 200000;

update departamento
set presupuesto = 200001
where codigo =  2;