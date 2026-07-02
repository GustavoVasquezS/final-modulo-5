-- A1: Actores que participaron en ambas teleseries, su sueldo en cada una y la suma de ambos sueldos, ordenado por nombre
SELECT
    sol.nombre,
    sol.sueldo AS sueldo_soltera_otra_vez,
    ricky.sueldo AS sueldo_papi_ricky,
    sol.sueldo + ricky.sueldo AS sueldo_total
FROM reparto_soltera_otra_vez sol
INNER JOIN reparto_papi_ricky ricky ON sol.nombre = ricky.nombre
ORDER BY sol.nombre;

--A2: Crear una consulta para obtener todos los actores que participaron exclusivamente en Soltera Otra Vez, con un sueldo mayor a 90.
SELECT sol.nombre, sol.sueldo
FROM reparto_soltera_otra_vez sol
LEFT JOIN reparto_papi_ricky ricky ON sol.nombre = ricky.nombre
WHERE sol.sueldo > 90
  AND ricky.nombre IS NULL;

  --A3: Crear una consulta para obtener solo los actores con sueldo inferior a 85 que actuaron en cualquiera de las dos teleseries, pero no en las dos.
SELECT
    CASE WHEN sol.nombre IS NOT NULL THEN sol.nombre ELSE ricky.nombre END AS nombre,
    CASE WHEN sol.nombre IS NOT NULL THEN sol.sueldo ELSE ricky.sueldo END AS sueldo,
    CASE WHEN sol.nombre IS NOT NULL THEN 'Soltera Otra Vez' ELSE 'Papi Ricky' END AS teleserie
FROM reparto_soltera_otra_vez sol
FULL OUTER JOIN reparto_papi_ricky ricky ON sol.nombre = ricky.nombre
WHERE (sol.nombre IS NULL OR ricky.nombre IS NULL)
  AND (sol.sueldo < 85 OR ricky.sueldo < 85);


-- PARTE 2: Modelo entidad relación

-- A1: Revisar immágen de modelo entidad relación adjunta como archivo drawio e imágen.

-- A2: Crear las tablas actores, teleseries y reparto_actores con sus respectivas relaciones y restricciones.

DROP TABLE IF EXISTS reparto_actores;
DROP TABLE IF EXISTS actores;
DROP TABLE IF EXISTS teleseries;

CREATE TABLE actores
(
    id_actor serial NOT NULL,
    nombre character varying(255) NOT NULL,
    PRIMARY KEY (id_actor),
    UNIQUE (nombre)
);

CREATE TABLE teleseries
(
    id_teleserie serial NOT NULL,
    nombre character varying(255) NOT NULL,
    unidad_medida character varying(20) NOT NULL,
    PRIMARY KEY (id_teleserie),
    UNIQUE (nombre)
);

CREATE TABLE reparto_actores
(
    id_actor integer NOT NULL,
    id_teleserie integer NOT NULL,
    participacion integer, -- cantidad expresada en la unidad_medida de la teleserie correspondiente
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (id_actor, id_teleserie),
    FOREIGN KEY (id_actor) REFERENCES actores (id_actor),
    FOREIGN KEY (id_teleserie) REFERENCES teleseries (id_teleserie)
);

-- Poblar teleseries
insert into teleseries (nombre, unidad_medida) values ('Soltera Otra Vez', 'temporadas');
insert into teleseries (nombre, unidad_medida) values ('Papi Ricky', 'capitulos');

-- Poblar con actores sin duplicar nombres, ya que algunos actores participaron en ambas teleseries. 
insert into actores (nombre) values ('Paz Bascuñán');
insert into actores (nombre) values ('Pablo Macaya');
insert into actores (nombre) values ('Cristián Arriagada');
insert into actores (nombre) values ('Josefina Montané');
insert into actores (nombre) values ('Loreto Aravena');
insert into actores (nombre) values ('Lorena Bosch');
insert into actores (nombre) values ('Nicolás Poblete');
insert into actores (nombre) values ('Héctor Morales');
insert into actores (nombre) values ('Aranzazú Yankovic');
insert into actores (nombre) values ('Luis Gnecco');
insert into actores (nombre) values ('Catalina Guerra');
insert into actores (nombre) values ('Solange Lackington');
insert into actores (nombre) values ('Ignacio Garmendia');
insert into actores (nombre) values ('Julio González');
insert into actores (nombre) values ('Antonella Orsini');
insert into actores (nombre) values ('Tamara Acosta');
insert into actores (nombre) values ('Silvia Santelices');
insert into actores (nombre) values ('Alejandro Trejo');
insert into actores (nombre) values ('Grimanesa Jiménez');
insert into actores (nombre) values ('Jorge Zabaleta');
insert into actores (nombre) values ('Belén Soto');
insert into actores (nombre) values ('María Elena Swett');
insert into actores (nombre) values ('Juan Falcón');
insert into actores (nombre) values ('Leonardo Perucci');
insert into actores (nombre) values ('Teresita Reyes');
insert into actores (nombre) values ('Remigio Remedy');
insert into actores (nombre) values ('María Paz Grandjean');
insert into actores (nombre) values ('César Caillet');
insert into actores (nombre) values ('José Tomás Guzmán');
insert into actores (nombre) values ('Manuel Aguirre');

-- Poblar reparto_actores: participacion = son temporadas en "Soltera Otra Vez" o capitulos en "Papi Ricky"
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Paz Bascuñán'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Pablo Macaya'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Cristián Arriagada'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 95);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Josefina Montané'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 90);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Loreto Aravena'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 95);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Lorena Bosch'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 90);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Nicolás Poblete'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 85);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Héctor Morales'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 80);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Aranzazú Yankovic'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 80);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Luis Gnecco'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 95);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Catalina Guerra'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 90);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Solange Lackington'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 70);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Ignacio Garmendia'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 2, true, 70);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Julio González'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 75);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Antonella Orsini'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 3, true, 70);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Tamara Acosta'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 1, false, 60);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Silvia Santelices'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 1, false, 55);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Alejandro Trejo'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 1, false, 55);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Grimanesa Jiménez'), (select id_teleserie from teleseries where nombre = 'Soltera Otra Vez'), 1, false, 60);

insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Jorge Zabaleta'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Belén Soto'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Tamara Acosta'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'María Elena Swett'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 100);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Juan Falcón'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 95);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Silvia Santelices'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 85);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Leonardo Perucci'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 85);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Teresita Reyes'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 80);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Luis Gnecco'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 75);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Alejandro Trejo'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 65);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Grimanesa Jiménez'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 60);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Remigio Remedy'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 60);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'María Paz Grandjean'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 55);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Héctor Morales'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 50);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'César Caillet'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 40);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'José Tomás Guzmán'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 25);
insert into reparto_actores (id_actor, id_teleserie, participacion, protagonico, sueldo)
values ((select id_actor from actores where nombre = 'Manuel Aguirre'), (select id_teleserie from teleseries where nombre = 'Papi Ricky'), 135, true, 30);

-- A3: Crear una consulta que muestre todas las teleseries y todos los actores de reparto asociados. No incluya los actores de rol secundario.
SELECT
    t.nombre AS teleserie,
    a.nombre AS actor
FROM teleseries t
LEFT JOIN reparto_actores ra ON ra.id_teleserie = t.id_teleserie
LEFT JOIN actores a ON a.id_actor = ra.id_actor
WHERE ra.protagonico = true
ORDER BY t.nombre, a.nombre;

