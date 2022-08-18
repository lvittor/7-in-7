CREATE TABLE IF NOT EXISTS empleado (
    legajo integer,
    nombre varchar(30),
    sueldo float
);

explain verbose select nombre, sueldo from empleado where legajo = 10;
--                            QUERY PLAN                            
-- -----------------------------------------------------------------
--  Seq Scan on public.empleado  (cost=0.00..18.62 rows=3 width=86)
--    Output: nombre, sueldo
--    Filter: (empleado.legajo = 10)
-- (3 rows)

alter table empleado add primary key(legajo);

explain verbose select nombre, sueldo from empleado where legajo = 10;
--                                       QUERY PLAN                                      
-- --------------------------------------------------------------------------------------
--  Index Scan using empleado_pkey on public.empleado  (cost=0.15..8.17 rows=1 width=86)
--    Output: nombre, sueldo
--    Index Cond: (empleado.legajo = 10)
-- (3 rows)

alter table empleado drop constraint empleado_pkey cascade, add primary key(legajo, nombre);

explain verbose select nombre, sueldo from empleado where legajo = 10;
--                                  QUERY PLAN                                 
-- ----------------------------------------------------------------------------
--  Bitmap Heap Scan on public.empleado  (cost=4.17..11.28 rows=3 width=86)
--    Output: nombre, sueldo
--    Recheck Cond: (empleado.legajo = 10)
--    ->  Bitmap Index Scan on empleado_pkey  (cost=0.00..4.17 rows=3 width=0)
--          Index Cond: (empleado.legajo = 10)
-- (5 rows)