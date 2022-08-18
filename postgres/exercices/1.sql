CREATE TABLE IF NOT EXISTS materia (
    codigo integer PRIMARY KEY,
    nombre varchar(40)
);

INSERT INTO materia (codigo, nombre) VALUES 
(10, 'Introduccion a la Computacion'),
(20, 'Programacion I'),
(30, 'Estructura de Datos y Algoritmos'),
(40, 'Base de Datos I'),
(50, 'Programacion IV'),
(60, 'Base de Datos II');


explain select * from materia;
--                          QUERY PLAN                         
-- ------------------------------------------------------------
--  Seq Scan on materia  (cost=0.00..16.20 rows=620 width=102)
-- (1 row)

explain verbose select * from materia;
--                             QUERY PLAN                             
-- -------------------------------------------------------------------
--  Seq Scan on public.materia  (cost=0.00..16.20 rows=620 width=102)
--    Output: codigo, nombre
-- (2 rows)

explain analyze select * from materia;
--                                               QUERY PLAN                                              
-- ------------------------------------------------------------------------------------------------------
--  Seq Scan on materia  (cost=0.00..16.20 rows=620 width=102) (actual time=0.002..0.002 rows=0 loops=1)
--  Planning time: 0.019 ms
--  Execution time: 0.008 ms
-- (3 rows)



