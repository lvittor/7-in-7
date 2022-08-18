alter table empleado drop constraint empleado_pkey cascade;

explain verbose select nombre, sueldo from empleado where nombre = 'maria' and legajo = 10;
--                                     QUERY PLAN                                    
-- ----------------------------------------------------------------------------------
--  Seq Scan on public.empleado  (cost=0.00..20.35 rows=1 width=86)
--    Output: nombre, sueldo
--    Filter: (((empleado.nombre)::text = 'maria'::text) AND (empleado.legajo = 10))
-- (3 rows)

alter table empleado add primary key(legajo, nombre);

explain verbose select nombre, sueldo from empleado where nombre = 'maria' and legajo = 10;
--                                       QUERY PLAN                                      
-- --------------------------------------------------------------------------------------
--  Index Scan using empleado_pkey on public.empleado  (cost=0.15..8.17 rows=1 width=86)
--    Output: nombre, sueldo
--    Index Cond: ((empleado.legajo = 10) AND ((empleado.nombre)::text = 'maria'::text))
-- (3 rows)