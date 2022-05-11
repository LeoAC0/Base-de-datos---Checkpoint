SET sql_mode = 'ONLY_FULL_GROUP_BY';

-- Consigna - CheckPoint II
-- 1. Listar todos los huéspedes cuyo nombre comience con la letra "S". Se debe
-- mostrar id como "Número de huésped", apellido y nombre.

select id as "Número de huésped", apellido, nombre
from huesped
where nombre like "S%";

-- Arroja 4 registros

-- 2. Mostrar el número de legajo del empleado con domicilio "Av. Rosalind Franklin
-- 600".

select legajo
from empleado
where domicilio like "Av. Rosalind Franklin 600";

-- Muestra 1 resgistro, legajo 22.

-- 3. Se requiere saber cuál es el mayor importe registrado en las reservas.

select id, importe
from reserva
order by importe desc limit 1;

-- Muestra 1 registro, importe 15000.

-- 4. Listar las reservas realizadas con números 15, 19, 21, 35.

select *
from reserva
where id IN (15, 19, 21, 35);

-- Muestra 4 registros.

-- 5. Calcular el importe total recaudado para la habitación número 40. El reporte
-- debe tener dos columnas denominadas "Número de habitación " y el "Importe
-- Total".

select habitacion_numero as "Número de habitación ", sum(importe) as "Importe Total"
from checkin
where habitacion_numero = 40;

-- Muestra 1 registro 133440


-- 6. Listar de manera ordenada (fecha de nacimiento), los empleados que no
-- pertenezcan al sector 3 y que la fecha de nacimiento sea mayor que 3/9/1989 o
-- igual a 7/11/1986.

select *
from empleado
where sector_id != 3 and (fecha_nacimiento > "1989-09-03" or fecha_nacimiento = "1986-11-07")
order by fecha_nacimiento asc;

-- Muestra 4 registros.


-- 7. Listar los importes de las reservas con valor entre $10499,50 a $12000,00
-- (ordenarlos por el importe de mayor a menor).

select *
from reserva
where importe between 10499.50 and 12000
order by importe desc;

-- Muestra 16 registros.

-- 8. Mostrar el quinto importe del check-in realizado con menor valor.

select *
from checkin
order by importe asc
limit 1
offset 4;

-- Muestra el ID = 29.

-- 9. Mostrar el check-in con mayor importe. Este reporte debe contener el número
-- del check-in, fecha de entrada y el importe.

select id, fecha_entrada, importe
from checkin
order by importe desc
limit 1;

-- Muestra el ID = 6.

-- 10. Mostrar las diez reservas con menor importe. Este reporte debe contener el
-- número de reserva, importe y el número del servicio.

select id, importe, servicio_extra_id
from reserva
order by importe asc
limit 10;

-- Muestra 10 registros.

-- 11. Listar las reservas registradas entre 14/07/21 al 15/08/21 (ordenarlos por fecha)

select *
from reserva
order by fecha between "2021-07-14" and "2021-08-15", fecha asc;

-- Muestra 100 registros

-- 12. Listar en forma ordenada los check-in que tengan un importe superior o igual a
-- $34125,00 y con fecha de salida inferior a 26/6/2020.

select *
from checkin
where importe >= 34125 and fecha_salida < "2020-06-26"
order by fecha_entrada asc;

-- Muestra 9 registros.

-- 13. Listar todos los empleados cuyo nombre termine con los caracteres "ia". Se debe
-- mostrar el legajo, apellido, nombre y teléfono móvil.

select legajo, apellido, nombre, telefono_movil
from empleado
where nombre like "%ia";

-- Muestra 3 registros.

-- 14. Se desea conocer cuál es el importe promedio de las reservas que se hayan
-- pagado en efectivo.

select avg(importe)
from reserva
where forma_pago_id = 1;

-- Muestra 7140


-- 15. Mostrar el tercer check-in con mayor importe pagado con tarjeta de crédito.

select *
from checkin
where forma_pago_id = 3
order by importe desc
limit 1
offset 2;

-- Muestra el registro ID = 61.


-- 16. Calcular la cantidad de check-in que tiene la habitación número siete. El reporte
-- debe tener dos columnas denominadas "Habitación" y el "Cantidad".

select habitacion_numero as "Habitacion", count(habitacion_numero) as "Cantidad"
from checkin
where habitacion_numero = 7;

-- Muestra Cantidad = 4.

-- 17. Mostrar todos los domicilios de los huéspedes que contengan una palabra de
-- cinco caracteres, pero el tercer carácter debe ser igual a "n".

select domicilio from huesped where domicilio like '% __n__ %';

-- 18. Modificar el tipo de decoración "italiana" por "romana"

UPDATE decoracion
SET nombre = "romana"
WHERE nombre = "italiana";

-- 19. Agregar al huésped Palermo Díaz Ricardo Omar cuyo pasaporte es 28001555 y
-- fecha de nacimiento 5/1/1980, domiciliado en calle Av. Sarmiento 752 este -
-- Argentina, teléfono móvil +542645667714 y el correo electrónico es
-- pal1980sj@gmail.com.

INSERT INTO huesped (apellido, nombre, pasaporte, fecha_nacimiento, domicilio, pais_id, telefono_movil, email)
VALUES ("Diás Ricardo", "Omar", '28001555', "1980-01-05", "Av. Sarmiento 752", 1, "+542645667714", "pal1980sj@gmail.com");

-- 20. Eliminar el registro del servicio básico número 5

DELETE FROM servicio_basico
WHERE id = 5;


