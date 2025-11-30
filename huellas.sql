create schema if not exists huella;

create table if not exists huella.legajo (
    cod text primary key,
    nombre text,
    area text,
    turno text,
    estado text,
    inactivo boolean,
    fecha_ingreso DATE,
    dni text,
    email TEXT
)

create table if not exists huella.marcas (
    id bigint primary key,
    legajo text not null,
    tipo text,
    sensor integer,
    ts timestamp not null,
    duplicado boolean not null default false
);

create index if not exists idx_marcacion_legajo_dia on huella.marcas (legajo, ts);

select count(*) from huella.marcas;

-- vista de marcaciones diarias por legajo

create or replace view huella.v_marcaciones_diarias as
select
    m.legajo,
    l.nombre,
    DATE (m.ts) as dia,
    min(m.ts) as primera_marca,
    max(m.ts) as ultima_marca,
    count(*) as total_marcas
from huella.marcas m
    left join huella.legajo l on l.cod = m.legajo
group by
    m.legajo,
    l.nombre,
    DATE (m.ts);

select
    nombre,
    dia,
    primera_marca,
    ultima_marca,
    total_marcas
from huella.v_marcaciones_diarias
where
    dia between '2025-11-01' and '2025-11-30'
order by dia, nombre;

-----------

-- calculo de horas trabajadas por día (aproximadamente)

create or replace view huella.v_asistencia_diaria as
select
    legajo,
    nombre,
    dia,
    primera_marca,
    ultima_marca,
    total_marcas,
    EXTRACT(
        EPOCH
        FROM (ultima_marca - primera_marca)
    ) / 3600 as horas_trabajadas
from huella.v_marcaciones_diarias;

select *
from huella.v_asistencia_diaria
where
    dia between '2025-11-01' and '2025-11-30'
ORDER BY nombre, dia;

-- ausentes por día

-- insertar dias no laborables de ejemplo (futuro)
create table if not exists huella.dias_no_laborables (
    fecha date primary key,
    descripcion text null
);

--- trabaja finde ?

create table huella.trabaja_finde (
    legajo text primary key,
    sabado boolean default false,
    domingo boolean default false
);

CREATE OR REPLACE VIEW huella.v_ausentes_diarios AS
WITH
    dias_con_marca AS (
        SELECT DISTINCT
            DATE (ts) AS dia
        FROM huella.marcas
    ),
    empleados_activos AS (
        select distinct
            legajo
        from huella.marcas
        where
            ts >= date_trunc('year', NOW())
    ),
    marcas_dias AS (
        SELECT DISTINCT
            legajo,
            DATE (ts) AS dia
        FROM huella.marcas
    )
SELECT l.cod AS legajo, l.nombre, d.dia
FROM
    huella.legajo l
    INNER JOIN empleados_activos ea ON ea.legajo = l.cod
    CROSS JOIN dias_con_marca d
    LEFT JOIN marcas_dias m ON m.legajo = l.cod
    AND m.dia = d.dia
    LEFT JOIN huella.trabaja_finde tf on tf.legajo = l.cod
WHERE
    m.legajo IS NULL -- el empleado no tiene marcas ese día
    AND COALESCE(l.inactivo, FALSE) = FALSE
    AND (
        EXTRACT(
            DOW
            FROM d.dia
        ) NOT IN (0, 6) -- lu a viernes
        OR (
            EXTRACT(
                DOW
                FROM d.dia
            ) = 6
            AND tf.sabado = true
        ) -- es sábado y trabaja sábado
        OR (
            EXTRACT(
                DOW
                FROM d.dia
            ) = 0
            AND tf.domingo = true
        ) -- es domingo y trabaja domingo
    )
ORDER BY d.dia, l.nombre;


drop view huella.v_ausentes_diarios

select *
from huella.v_ausentes_diarios
where
    dia between '2025-11-01' and '2025-11-30'
order by nombre, dia;