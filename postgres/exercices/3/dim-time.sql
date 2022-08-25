create table tiempo
(
    id             serial,
    fecha_apertura text    not null,
    sepi_apertura  integer not null
);

INSERT INTO tiempo (fecha_apertura, sepi_apertura)
	SELECT DISTINCT fecha_apertura, sepi_apertura
	FROM "CasosCovidCondensado"
	WHERE fecha_apertura IS NOT NULL AND sepi_apertura IS NOT NULL;
