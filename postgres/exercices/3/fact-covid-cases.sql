create table casos_covid
(
    fallecido    bit     not null,
    confirmado   bit     not null,
    id_provincia integer not null
        constraint casos_covid_provincia_id_fk
            references provincia,
    id_fecha     integer not null
        constraint casos_covid_tiempo_id_fk
            references tiempo,
    id           serial
        constraint casos_covid_pk
            primary key
);

INSERT INTO casos_covid(fallecido, confirmado, id_provincia, id_fecha)
    SELECT
        CASE WHEN fallecido = 'SI' THEN 1::bit ELSE 0::bit END,
        CASE WHEN clasificacion_resumen = 'Confirmado' THEN 1::bit ELSE 0::bit END,
        carga_provincia_id,
        tiempo.id
    FROM "CasosCovidCondensado" NATURAL JOIN tiempo
    WHERE carga_provincia_id != 0;
