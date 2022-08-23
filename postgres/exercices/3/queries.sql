-- A
SELECT
    provincia.nombre,
    tiempo.sepi_apertura,
    ((COUNT(*) FILTER ( WHERE fallecido = 1::BIT ))::numeric /
        COUNT(*) FILTER ( WHERE confirmado = 1::BIT ))::decimal(10, 4) AS indice_letalidad
FROM casos_covid
    JOIN tiempo ON casos_covid.id_fecha = tiempo.id
    JOIN provincia ON casos_covid.id_provincia = provincia.id
GROUP BY provincia.nombre, tiempo.sepi_apertura
ORDER BY tiempo.sepi_apertura, provincia.nombre;

-- B
SELECT
    tiempo.sepi_apertura,
    ((COUNT(*) FILTER ( WHERE confirmado = 1::BIT ))::numeric /
        COUNT(*))::decimal(10, 4) AS indice_positividad
FROM casos_covid
    JOIN tiempo ON casos_covid.id_fecha = tiempo.id
GROUP BY tiempo.sepi_apertura
ORDER BY tiempo.sepi_apertura;

-- C
SELECT
    provincia.nombre,
    ((COUNT(*) FILTER ( WHERE fallecido = 1::BIT ))::numeric /
        provincia.habitantes)::decimal(10, 7) AS indice_muertes
FROM casos_covid
    JOIN provincia ON casos_covid.id_provincia = provincia.id
GROUP BY provincia.nombre, provincia.habitantes
ORDER BY provincia.nombre;
