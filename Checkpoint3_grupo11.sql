-- ================= BASE DE DATOS I - PROYECTO - LA APROBACION ================== --
-- =============================== CHECKPOINT III ================================ --
-- Base de datos: la_aprobacion.sql
-- Equipo N°:
-- Integrantes: 

set sql_mode = 'ONLY_FULL_GROUP_BY'; 

-- 1. Listar los servicios básicos de la habitación número 25.
-- rows:

select habitacion_numero, servicio_basico_id, id, nombre from habitacion_x_servicio_basico
join servicio_basico on habitacion_x_servicio_basico.servicio_basico_id = servicio_basico.id
where habitacion_numero = 25;

-- Muestra 4 registros

-- 2. Listar absolutamente todos los servicios básicos y la cantidad de habitaciones en las que están instalados. Mostrar solo el nombre del servicio básico y cantidad
-- rows:

select nombre as nombre_servicio_basico, count(habitacion_numero) as cantidad from habitacion_x_servicio_basico
join servicio_basico on habitacion_x_servicio_basico.servicio_basico_id = servicio_basico.id
group by nombre;

-- Muestra 10 resgistros.

-- 3. Listar todos los huéspedes que tengan tres o más check-in. Mostrar el número de huésped, apellido y nombre separado por un espacio dentro de una misma columna denominada "Cliente" y, la cantidad de check-in que posee.
-- rows:

select huesped_id as numero_de_huésped, concat(apellido, " ", nombre ) as cliente, count(checkin.id) as cantidad_de_chekin from checkin
join huesped on checkin.huesped_id = huesped.id
group by huesped_id
having cantidad_de_chekin > 3;	

-- Muestra 14 registros.

-- 4. Listar todos los huéspedes que no tengan un check-in. Mostrar el número de huésped, apellido y nombre en mayúsculas dentro de una misma columna denominada "huésped sin check-in".
-- rows:

select huesped.id as "numero de huesped", upper(concat(apellido, " ", nombre )) as "huésped sin check-in"  from huesped
left join checkin on huesped.id = checkin.huesped_id
where checkin.id is null;

-- Muestra 16 registros

-- 5. Listar todos los huéspedes que tengan al menos un check-in que corresponda a la habitación de clase 'Classic'. Se debe mostrar el número de huésped, apellido, nombre, número de habitación y la clase.
-- rows:

select huesped.id as numeroHuesped, huesped.apellido, huesped.nombre, checkin.habitacion_numero as numeroHabitacion, clase.nombre from huesped
join checkin on huesped.id = checkin.huesped_id
join habitacion on checkin.habitacion_numero = habitacion.numero
join clase on habitacion.clase_id = clase.id
where checkin.id > 1 and clase.nombre = 'Classic';

-- Muestra 47 registros.

-- 6. Listar los huéspedes que tengan una o más reservas y que en la segunda letra de su apellido contenga una "u". Se debe mostrar el número de huésped, apellido, nombre, nombre del servicio.
-- rows:

select reserva.huesped_id as "numero de huesped", huesped.apellido, huesped.nombre, servicio_extra.nombre as "nombre del servicio" from reserva
join huesped on reserva.huesped_id = huesped.id
join servicio_extra on reserva.servicio_extra_id = servicio_extra.id
group by huesped.id
having count(reserva.id > 1) and huesped.apellido like "_u%";

-- Muestra 5 resgistros

-- 7. Listar absolutamente todos los países y la cantidad de huéspedes que tengan.
-- rows:

select pais.nombre, count(huesped.id) as cantidadHuesped from huesped 
join pais on huesped.pais_id = pais.id
group by pais.nombre;

-- Muestra 4 registros

-- 8. Calcular el importe total y la cantidad de reservas realizadas en el mes de marzo por cada huésped. Mostrar el apellido del huésped, importe total y cantidad de reservas.
-- rows:

select huesped.apellido as apellido, sum(reserva.importe) as importe_total, count(reserva.id) as cantidad_reservas from huesped 
join reserva on reserva.huesped_id = huesped.id 
where EXTRACT(MONTH FROM reserva.fecha) = 3
group by huesped.id;

-- Muestra 9 registros.

-- 9. Calcular el importe total recaudado por mes (fecha de entrada) para la habitación número 22. Mostrar el número de habitación, nombre de la decoración, clase, nombre del mes y el importe total.
-- rows:

select checkin.habitacion_numero, decoracion.nombre as decoracion, clase.nombre as clase, MONTHNAME(checkin.fecha_entrada) as mes, sum(checkin.importe) as importeTotal from huesped 
join checkin on huesped.id = checkin.huesped_id
join habitacion on habitacion.numero = checkin.habitacion_numero
join decoracion on habitacion.decoracion_id = decoracion.id
join clase on habitacion.clase_id = clase.id
where habitacion.numero = 22
group by mes;

-- Muestra 3 registros

-- 10. Determinar la recaudación total por país para las habitaciones número 5, 10 y 22. Mostrar nombre del país, número de habitación y el total recaudado.
-- rows:

select pais.nombre, checkin.habitacion_numero, sum(checkin.importe) from pais
join huesped on pais.id = huesped.pais_id
join reserva on reserva.huesped_id = huesped.id
join checkin on huesped.id = checkin.huesped_id
where checkin.habitacion_numero in (5,10,22)
group by checkin.habitacion_numero, pais.nombre;

--  Muestra 7 registros

-- 11. Calcular la recaudación total de cada forma de pago para las reservas. Mostrar la forma de pago y el total.
-- rows:

select forma_pago.nombre as formaDePago, sum(reserva.importe) as total from forma_pago
join reserva on forma_pago.id = reserva.forma_pago_id
group by formaDePago;

-- Muestra 4 registros.

-- 12. Listar los empleados del sector 'administración' que su país de origen sea 'Argentina'. Mostrar el número de legajo, apellido, la primera inicial del primer nombre y un punto, nombre de su país de origen y el nombre del sector. 
-- rows:

SELECT legajo, apellido, CONCAT(LEFT(empleado.nombre,1), ".") AS inicial_nombre, pais.nombre, sector.nombre
FROM empleado
JOIN sector ON sector.id=empleado.sector_id
JOIN pais ON pais.id=empleado.pais_id
WHERE sector.nombre = "Administración" AND pais.nombre = "Argentina";

-- Muestra 3 registros.

-- 13. Listar todos los servicios básicos que tienen las habitaciones (desde la 20 hasta la 24) y su clase. Mostrar número de habitación, clase y el nombre de los servicios básicos. Ordenar por número de habitación y servicio.
-- rows:

SELECT habitacion.numero AS habitacion, clase.nombre AS clase, servicio_basico.nombre AS servicio
FROM habitacion_x_servicio_basico
JOIN habitacion ON habitacion_x_servicio_basico.habitacion_numero=habitacion.numero
JOIN servicio_basico ON servicio_basico.id= habitacion_x_servicio_basico.servicio_basico_id
JOIN clase ON clase.id= habitacion.clase_id
WHERE habitacion.numero BETWEEN 20 AND 24
ORDER BY habitacion.numero , servicio_basico.nombre;

-- Muestra 28 registros.

-- 14. Listar las decoraciones que no están aplicadas en ninguna habitación.
-- rows:

SELECT decoracion.nombre as nombreDecoracion, habitacion.numero as numeroDeHabitacion FROM decoracion
LEFT JOIN habitacion ON habitacion.decoracion_id=decoracion.id
WHERE numero IS NULL;

-- Muestra 2 registros

-- 15. Listar todos los empleados categorizados por edad. Las categorías son: 'junior' (hasta 35 años), 'semi-senior' (entre 36 a 40 años) y 'senior' (más de 40). Mostrar el apellido, nombre, edad, categoría y ordenar de mayor a menor por categoría y edad.
-- rows:

SELECT apellido, nombre, ROUND (DATEDIFF(curdate(),fecha_nacimiento)/365) AS edad,
CASE
	WHEN ROUND (DATEDIFF(curdate(),fecha_nacimiento)/365) <=35 THEN "junior"
	WHEN ROUND (DATEDIFF(curdate(),fecha_nacimiento)/365) BETWEEN 36 AND 40 THEN "semi-senior"
    ELSE "senior"
    END AS categoria
FROM empleado
ORDER BY edad, categoria;

-- Muestra 25 registros.

-- 16. Calcular la cantidad y el promedio de cada forma de pago para los check-in. Mostrar la forma de pago, cantidad y el promedio formateado con dos decimales.
-- rows:

select forma_pago.nombre as formaDePago, count(checkin.id) as cantidad, round(avg(checkin.importe),2) as promedio from forma_pago
join checkin on forma_pago.id = checkin.forma_pago_id
group by formaDePago;

-- Muestra 4 registros.

-- 17. Calcular la edad de los empleados de Argentina. Mostrar el apellido, nombre y la edad del empleado.
-- rows:

SELECT apellido, empleado.nombre, ROUND (DATEDIFF(CURDATE(),fecha_nacimiento)/365) AS edad, pais.nombre AS pais
FROM empleado
JOIN pais ON pais.id=empleado.pais_id
WHERE pais.nombre = "Argentina";

-- 18. Calcular el importe total para los check-in realizados por el huésped 'Mercado Joel'. Mostrar apellido, nombre, importe total y el país de origen.
-- rows:

SELECT huesped.apellido, huesped.nombre, SUM(checkin.importe) AS importe_total, pais.nombre
FROM checkin
JOIN huesped ON huesped.id=checkin.huesped_id
JOIN pais ON pais.id = huesped.pais_id
WHERE huesped.nombre = "Joel" AND huesped.apellido = "Mercado"
group by pais.nombre;

-- 19. Listar la forma de pago empleada por cada servicio extra. Se debe mostrar el nombre del servicio extra, nombre de la forma de pago y calcular la cantidad y total recaudado.
-- rows:

select servicio_extra.nombre as nombreServicioExtra, forma_pago.nombre as nombreFormaDePago, count(servicio_extra.id) as cantidad, sum(reserva.importe) as total from forma_pago
join reserva on forma_pago.id = reserva.forma_pago_id
join servicio_extra on reserva.servicio_extra_id = servicio_extra.id
group by nombreServicioExtra, nombreFormaDePago;

-- Muestra 16 registros.

-- 20. Listar la forma de pago empleada para el servicio extra 'Sauna' y los huéspedes correspondientes. Se debe mostrar el nombre del servicio extra, nombre de la forma de pago, numero del cliente e importe total.
-- rows:

SELECT servicio_extra.nombre As servicio, forma_pago.nombre AS formaDePago, reserva.huesped_id AS cliente, reserva.importe AS importe
FROM servicio_extra
JOIN reserva ON reserva.servicio_extra_id=servicio_extra.id
JOIN forma_pago ON forma_pago.id=reserva.forma_pago_id
WHERE servicio_extra.nombre = "Sauna";

