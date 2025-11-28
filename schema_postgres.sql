-- ----------------------------------------------------------
-- MDB Tools - A library for reading MS Access database files
-- Copyright (C) 2000-2011 Brian Bruns and others.
-- Files in libmdb are licensed under LGPL and the utilities under
-- the GPL, see COPYING.LIB and COPYING files respectively.
-- Check out http://mdbtools.sourceforge.net
-- ----------------------------------------------------------

SET client_encoding = 'UTF-8';

CREATE TABLE IF NOT EXISTS "accesos"
 (
	"id"			SERIAL, 
	"idlegajos"			VARCHAR (12), 
	"sensor"			VARCHAR (15), 
	"fecha"			DATE, 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"puerto"			VARCHAR (50), 
	"accion"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"tipo"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"horainternet"			BOOLEAN NOT NULL, 
	"neutro"			BOOLEAN NOT NULL, 
	"stat"			DOUBLE PRECISION, 
	"legajo"			DOUBLE PRECISION, 
	"diahora"			VARCHAR (20), 
	"duplicado"			BOOLEAN NOT NULL, 
	"idviejo"			VARCHAR (12), 
	"usuario"			VARCHAR (50), 
	"worktyte"			VARCHAR (10)
);

-- CREATE INDEXES ...
CREATE INDEX "accesos_id_idx" ON "accesos" ("idlegajos");
ALTER TABLE "accesos" ADD CONSTRAINT "accesos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "areaaut"
 (
	"id"			SERIAL, 
	"user"			VARCHAR (100), 
	"idarea"			INTEGER, 
	"usuario"			VARCHAR (100)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "areas"
 (
	"id"			SERIAL, 
	"area"			VARCHAR (50), 
	"ubicacion"			VARCHAR (50), 
	"responsable"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "areas_id_idx" ON "areas" ("id");
ALTER TABLE "areas" ADD CONSTRAINT "areas_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "artic"
 (
	"id"			SERIAL, 
	"cod"			VARCHAR (50), 
	"barra"			VARCHAR (50), 
	"descrip"			VARCHAR (255), 
	"rubro"			VARCHAR (10), 
	"aplic"			VARCHAR (250), 
	"venta1"			DOUBLE PRECISION, 
	"costo1"			DOUBLE PRECISION, 
	"cant"			DOUBLE PRECISION, 
	"fpv1"			TIMESTAMP WITHOUT TIME ZONE, 
	"fpc"			TIMESTAMP WITHOUT TIME ZONE
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "auditoria"
 (
	"id"			SERIAL, 
	"dia"			TIMESTAMP WITHOUT TIME ZONE, 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"tipo"			VARCHAR (1), 
	"interno"			VARCHAR (255), 
	"user"			VARCHAR (50), 
	"nombre"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "clientesred"
 (
	"id"			SERIAL, 
	"nombre"			VARCHAR (100), 
	"ruta"			VARCHAR (255)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "codigodebarra"
 (
	"id"			SERIAL, 
	"fecha"			TIMESTAMP WITHOUT TIME ZONE, 
	"codigobarra"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"idlegajo"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "copia de accesos"
 (
	"id"			SERIAL, 
	"idlegajos"			VARCHAR (12), 
	"sensor"			VARCHAR (15), 
	"fecha"			DATE, 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"puerto"			VARCHAR (50), 
	"accion"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"tipo"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"horainternet"			BOOLEAN NOT NULL, 
	"neutro"			BOOLEAN NOT NULL, 
	"stat"			DOUBLE PRECISION, 
	"legajo"			DOUBLE PRECISION, 
	"diahora"			VARCHAR (20), 
	"duplicado"			BOOLEAN NOT NULL, 
	"idviejo"			VARCHAR (12), 
	"usuario"			VARCHAR (50), 
	"worktyte"			VARCHAR (10)
);

-- CREATE INDEXES ...
CREATE INDEX "copia de accesos_id_idx" ON "copia de accesos" ("idlegajos");
ALTER TABLE "copia de accesos" ADD CONSTRAINT "copia de accesos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "empresa"
 (
	"id"			SERIAL, 
	"empresa"			VARCHAR (100), 
	"direccion"			VARCHAR (100), 
	"localidad"			VARCHAR (100), 
	"provincia"			VARCHAR (100), 
	"cp"			VARCHAR (100), 
	"telefonos"			VARCHAR (100), 
	"cuit"			VARCHAR (13)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enroll"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"user"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "enroll_id_idx" ON "enroll" ("id");
CREATE INDEX "enroll_idlegajo_idx" ON "enroll" ("idlegajo");
ALTER TABLE "enroll" ADD CONSTRAINT "enroll_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "enrollcid"
 (
	"id"			INTEGER, 
	"idcid"			INTEGER, 
	"user_id"			INTEGER, 
	"finger_position"			INTEGER, 
	"finger_type"			INTEGER, 
	"template"			TEXT
);

-- CREATE INDEXES ...
ALTER TABLE "enrollcid" ADD CONSTRAINT "enrollcid_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "enrollmb"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"user"			VARCHAR (50), 
	"posicion"			DOUBLE PRECISION, 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollmbf"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"user"			VARCHAR (50), 
	"posicion"			DOUBLE PRECISION, 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollni"
 (
	"marcaz"			VARCHAR (1), 
	"id"			INTEGER, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"dia"			TIMESTAMP WITHOUT TIME ZONE
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollpb"
 (
	"id"			SERIAL, 
	"huella"			BYTEA, 
	"idlegajo"			INTEGER, 
	"orden"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollt"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"user"			VARCHAR (50), 
	"ruta"			TEXT
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollw"
 (
	"id"			SERIAL, 
	"template"			TEXT, 
	"idlegajo"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrollzk"
 (
	"id"			SERIAL, 
	"template"			TEXT, 
	"idlegajo"			INTEGER, 
	"user"			VARCHAR (50), 
	"posicion"			DOUBLE PRECISION, 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "excepciones"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"turno"			VARCHAR (250), 
	"fecha"			TIMESTAMP WITHOUT TIME ZONE, 
	"motivo"			VARCHAR (250), 
	"user"			VARCHAR (50), 
	"idviejo"			VARCHAR (12), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "faces"
 (
	"id"			SERIAL, 
	"features"			BYTEA, 
	"idlegajos"			INTEGER, 
	"faceid"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "feriado"
 (
	"id"			SERIAL, 
	"fecha"			TIMESTAMP WITHOUT TIME ZONE, 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "fotos"
 (
	"id"			SERIAL, 
	"idlegajos"			INTEGER, 
	"foto"			BYTEA, 
	"pathfoto"			VARCHAR (255)
);

-- CREATE INDEXES ...
CREATE INDEX "fotos_id_idx" ON "fotos" ("idlegajos");
ALTER TABLE "fotos" ADD CONSTRAINT "fotos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "fpusb"
 (
	"id"			SERIAL, 
	"huella"			BYTEA, 
	"idlegajo"			INTEGER, 
	"orden"			INTEGER, 
	"idviejo"			VARCHAR (12)
);

-- CREATE INDEXES ...
CREATE INDEX "fpusb_id_idx" ON "fpusb" ("id");
CREATE INDEX "fpusb_idlegajo_idx" ON "fpusb" ("idlegajo");
CREATE INDEX "fpusb_idviejo_idx" ON "fpusb" ("idviejo");

CREATE TABLE IF NOT EXISTS "francorotativo"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"fecha"			TIMESTAMP WITHOUT TIME ZONE, 
	"motivo"			VARCHAR (250), 
	"user"			VARCHAR (50), 
	"idviejo"			VARCHAR (12), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "idiomas"
 (
	"id"			SERIAL, 
	"controlname"			VARCHAR (50), 
	"formulario"			VARCHAR (50), 
	"idioma"			VARCHAR (50), 
	"valor"			VARCHAR (255)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "imagenhuella"
 (
	"id"			SERIAL, 
	"huella"			BYTEA, 
	"idlegajo"			INTEGER, 
	"orden"			INTEGER, 
	"idviejo"			VARCHAR (12)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "justificaciones"
 (
	"id"			SERIAL, 
	"justificacion"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "justificaciones_id_idx" ON "justificaciones" ("id");
ALTER TABLE "justificaciones" ADD CONSTRAINT "justificaciones_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "legajos"
 (
	"id"			SERIAL, 
	"cod"			VARCHAR (11), 
	"nombre"			VARCHAR (35), 
	"direc"			VARCHAR (35), 
	"pcia"			VARCHAR (17), 
	"cp"			VARCHAR (8), 
	"loc"			VARCHAR (50), 
	"telef"			TEXT, 
	"impos"			VARCHAR (50), 
	"cuit"			VARCHAR (13), 
	"area"			VARCHAR (50), 
	"turno"			VARCHAR (50), 
	"come"			TEXT, 
	"imagen"			BYTEA, 
	"tipo"			VARCHAR (50), 
	"estado"			VARCHAR (1), 
	"diaestado"			TIMESTAMP WITHOUT TIME ZONE, 
	"horaestado"			TIMESTAMP WITHOUT TIME ZONE, 
	"fechanac"			TIMESTAMP WITHOUT TIME ZONE, 
	"bloquea"			BOOLEAN NOT NULL, 
	"horae"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae1"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae2"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae3"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae4"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae5"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae6"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae7"			TIMESTAMP WITHOUT TIME ZONE, 
	"perfil"			VARCHAR (50), 
	"clavemanual"			VARCHAR (10), 
	"interno"			VARCHAR (50), 
	"relacion"			VARCHAR (50), 
	"otronombre"			VARCHAR (50), 
	"costeo"			DOUBLE PRECISION, 
	"proyecto"			DOUBLE PRECISION, 
	"user"			VARCHAR (50), 
	"inactivo"			BOOLEAN NOT NULL, 
	"tipodni"			VARCHAR (30), 
	"dni"			VARCHAR (30), 
	"idorigen"			INTEGER, 
	"tolerancia"			DOUBLE PRECISION, 
	"bloqueatarde"			BOOLEAN NOT NULL, 
	"cierraauto"			BOOLEAN NOT NULL, 
	"horaauto"			TIMESTAMP WITHOUT TIME ZONE, 
	"actividad"			VARCHAR (50), 
	"vencecuota"			TIMESTAMP WITHOUT TIME ZONE, 
	"email"			VARCHAR (50), 
	"tarjeta"			VARCHAR (10), 
	"esadministrador"			BOOLEAN NOT NULL, 
	"tipoprocesamiento"			VARCHAR (1), 
	"toleranciacuota"			DOUBLE PRECISION, 
	"validacuota"			BOOLEAN NOT NULL, 
	"grupohorario"			VARCHAR (50), 
	"usuario"			VARCHAR (50), 
	"fechaingreso"			TIMESTAMP WITHOUT TIME ZONE, 
	"txthoras"			VARCHAR (50), 
	"sueldo"			VARCHAR (50), 
	"canthoras"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "legajos_id_idx" ON "legajos" ("id");
ALTER TABLE "legajos" ADD CONSTRAINT "legajos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "legaut"
 (
	"id"			SERIAL, 
	"user"			VARCHAR (100), 
	"idlegajo"			INTEGER, 
	"usuario"			VARCHAR (100)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "lissp"
 (
	"id"			SERIAL, 
	"cartera"			INTEGER, 
	"avisapedido"			BOOLEAN NOT NULL, 
	"avisanegat"			BOOLEAN NOT NULL, 
	"dolaralprincipio"			BOOLEAN NOT NULL, 
	"cantauto"			REAL, 
	"incluyeiva"			BOOLEAN NOT NULL, 
	"pregmensa"			BOOLEAN NOT NULL, 
	"nroremfac"			BOOLEAN NOT NULL, 
	"multidepo"			BOOLEAN NOT NULL, 
	"trabalista1"			BOOLEAN NOT NULL, 
	"contable"			BOOLEAN NOT NULL, 
	"verificasaldo"			BOOLEAN NOT NULL, 
	"clave"			VARCHAR (50), 
	"incivacf"			BOOLEAN NOT NULL, 
	"decimales"			INTEGER, 
	"boniauto"			BOOLEAN NOT NULL, 
	"plan"			BOOLEAN NOT NULL, 
	"nroasi"			INTEGER, 
	"plazopago"			BOOLEAN NOT NULL, 
	"comissuper"			BOOLEAN NOT NULL, 
	"ciclico"			BOOLEAN NOT NULL, 
	"moduloimpresion"			VARCHAR (50), 
	"ciclicofactu"			BOOLEAN NOT NULL, 
	"multiplica"			INTEGER, 
	"avisamaquina"			BOOLEAN NOT NULL, 
	"clienteautorizado"			BOOLEAN NOT NULL, 
	"empresa"			VARCHAR (50), 
	"imprimeloteprop"			BOOLEAN NOT NULL, 
	"imprimeloteconf"			BOOLEAN NOT NULL, 
	"tolerancia"			INTEGER, 
	"smtp"			VARCHAR (50), 
	"cuenta"			VARCHAR (50), 
	"nombremail"			VARCHAR (50), 
	"grabani"			BOOLEAN NOT NULL, 
	"pwd"			VARCHAR (50), 
	"bienvenida"			INTEGER, 
	"repeticion"			INTEGER, 
	"altolegajos"			INTEGER, 
	"superpone"			BOOLEAN NOT NULL, 
	"repesino"			BOOLEAN NOT NULL, 
	"clavemanual"			BOOLEAN NOT NULL, 
	"avisaultimo"			BOOLEAN NOT NULL, 
	"valorultimo"			INTEGER, 
	"duracionultimo"			INTEGER, 
	"proyectos"			BOOLEAN NOT NULL, 
	"tarifador"			BOOLEAN NOT NULL, 
	"valorhora"			DOUBLE PRECISION, 
	"toleranciah"			INTEGER, 
	"logo"			VARCHAR (255), 
	"periodo"			INTEGER, 
	"copiaalinicio"			BOOLEAN NOT NULL, 
	"dircopia"			VARCHAR (255), 
	"ticket"			BOOLEAN NOT NULL, 
	"clienteservidor"			VARCHAR (255), 
	"cadahoracliente"			BOOLEAN NOT NULL, 
	"rutaserver"			VARCHAR (255), 
	"alinicioserver"			BOOLEAN NOT NULL, 
	"logsincronizac"			BOOLEAN NOT NULL, 
	"logsincronizas"			BOOLEAN NOT NULL, 
	"filtrodni"			BOOLEAN NOT NULL, 
	"avon"			BOOLEAN NOT NULL, 
	"sensor"			VARCHAR (255), 
	"validacuota"			BOOLEAN NOT NULL, 
	"toleranciacuota"			INTEGER, 
	"popup"			BOOLEAN NOT NULL, 
	"tray"			BOOLEAN NOT NULL, 
	"soloingresa"			BOOLEAN NOT NULL, 
	"horainternet"			BOOLEAN NOT NULL, 
	"gtm"			VARCHAR (10), 
	"version"			VARCHAR (10), 
	"sonidonombre"			BOOLEAN NOT NULL, 
	"sucursal"			DOUBLE PRECISION, 
	"sonido"			BOOLEAN NOT NULL, 
	"repeticionusb"			BOOLEAN NOT NULL, 
	"permiteresta"			BOOLEAN NOT NULL
);

-- CREATE INDEXES ...
CREATE INDEX "lissp_clave_idx" ON "lissp" ("clave");
CREATE INDEX "lissp_id_idx" ON "lissp" ("id");
ALTER TABLE "lissp" ADD CONSTRAINT "lissp_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "mailauto"
 (
	"id"			SERIAL, 
	"informe"			VARCHAR (250), 
	"maildestino"			VARCHAR (250), 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"diasatras"			INTEGER, 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "movimien"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"diae"			TIMESTAMP WITHOUT TIME ZONE, 
	"dias"			TIMESTAMP WITHOUT TIME ZONE, 
	"horae"			TIMESTAMP WITHOUT TIME ZONE, 
	"horas"			TIMESTAMP WITHOUT TIME ZONE, 
	"tipo"			VARCHAR (50), 
	"interno"			VARCHAR (50), 
	"relacion"			VARCHAR (50), 
	"idproyecto"			DOUBLE PRECISION, 
	"user"			VARCHAR (50), 
	"valor"			DOUBLE PRECISION, 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "perfiles"
 (
	"id"			SERIAL, 
	"perfil"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "permisosevent"
 (
	"id"			SERIAL, 
	"idusuario"			INTEGER, 
	"acceso"			VARCHAR (50), 
	"inicio"			TIMESTAMP WITHOUT TIME ZONE, 
	"fin"			TIMESTAMP WITHOUT TIME ZONE, 
	"desde"			DATE, 
	"hasta"			DATE, 
	"autorizo"			VARCHAR (50), 
	"pases"			INTEGER, 
	"uso"			INTEGER, 
	"fechaultimopase"			TIMESTAMP WITHOUT TIME ZONE, 
	"user"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "permisosevent_id_idx" ON "permisosevent" ("id");
ALTER TABLE "permisosevent" ADD CONSTRAINT "permisosevent_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "permisoshab"
 (
	"id"			SERIAL, 
	"idusuario"			INTEGER, 
	"acceso"			VARCHAR (50), 
	"dia"			VARCHAR (50), 
	"inicio"			TIMESTAMP WITHOUT TIME ZONE, 
	"fin"			TIMESTAMP WITHOUT TIME ZONE, 
	"caduca"			DATE, 
	"user"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "permisoshab_id_idx" ON "permisoshab" ("id");
ALTER TABLE "permisoshab" ADD CONSTRAINT "permisoshab_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "provincias"
 (
	"id"			SERIAL, 
	"provincia"			VARCHAR (17)
);

-- CREATE INDEXES ...
ALTER TABLE "provincias" ADD CONSTRAINT "provincias_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "proyectos"
 (
	"id"			SERIAL, 
	"estado"			BOOLEAN NOT NULL, 
	"numero"			VARCHAR (10), 
	"descripcion"			VARCHAR (100), 
	"serie"			VARCHAR (100), 
	"destino"			VARCHAR (100), 
	"cliente"			VARCHAR (100), 
	"fini"			TIMESTAMP WITHOUT TIME ZONE, 
	"ffin"			TIMESTAMP WITHOUT TIME ZONE, 
	"valor"			DOUBLE PRECISION, 
	"come"			TEXT, 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "reemplazo"
 (
	"id"			SERIAL, 
	"horatipo"			VARCHAR (50), 
	"reemplazo"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "rubros"
 (
	"id"			SERIAL, 
	"cod"			VARCHAR (50), 
	"descrip"			VARCHAR (255)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "sanciones"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"fecha"			TIMESTAMP WITHOUT TIME ZONE, 
	"motivo"			VARCHAR (250), 
	"user"			VARCHAR (50), 
	"idviejo"			VARCHAR (12), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "sensores"
 (
	"id"			SERIAL, 
	"sensor"			VARCHAR (10), 
	"ubicacion"			VARCHAR (50), 
	"tipo"			VARCHAR (1), 
	"puerto"			VARCHAR (50), 
	"si"			INTEGER, 
	"duracionsi"			INTEGER, 
	"no"			INTEGER, 
	"duracionno"			INTEGER, 
	"panico"			INTEGER, 
	"duracionpanico"			INTEGER, 
	"noidentifica"			INTEGER, 
	"duracionnoidentifica"			INTEGER, 
	"bloquea"			BOOLEAN NOT NULL, 
	"entra"			INTEGER, 
	"duracionentra"			INTEGER, 
	"sale"			INTEGER, 
	"duracionsale"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "sensores_id_idx" ON "sensores" ("id");
ALTER TABLE "sensores" ADD CONSTRAINT "sensores_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "temporal"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"stat"			VARCHAR (10), 
	"diahora"			TIMESTAMP WITHOUT TIME ZONE, 
	"worktyte"			VARCHAR (10), 
	"backupcode"			VARCHAR (10), 
	"terminal"			VARCHAR (50), 
	"neutro"			BOOLEAN NOT NULL, 
	"borrar"			BOOLEAN NOT NULL
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "temptarde"
 (
	"id"			SERIAL, 
	"idlegajo"			INTEGER, 
	"dia"			VARCHAR (20), 
	"horae"			VARCHAR (20), 
	"horacumplir"			VARCHAR (20), 
	"demoradoh"			VARCHAR (20), 
	"demoradom"			VARCHAR (20)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "timbres"
 (
	"id"			SERIAL, 
	"motivo"			VARCHAR (50), 
	"dia"			VARCHAR (50), 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"caduca"			TIMESTAMP WITHOUT TIME ZONE, 
	"duracion"			INTEGER, 
	"puerto"			VARCHAR (50), 
	"salida"			INTEGER, 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "tipohora"
 (
	"id"			SERIAL, 
	"1"			VARCHAR (50), 
	"2"			VARCHAR (50), 
	"3"			VARCHAR (50), 
	"4"			VARCHAR (50), 
	"5"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "tramos"
 (
	"id"			SERIAL, 
	"idturno"			INTEGER, 
	"tramo"			VARCHAR (50), 
	"inicio"			TIMESTAMP WITHOUT TIME ZONE, 
	"fin"			TIMESTAMP WITHOUT TIME ZONE, 
	"lunes"			BOOLEAN NOT NULL, 
	"martes"			BOOLEAN NOT NULL, 
	"miercoles"			BOOLEAN NOT NULL, 
	"jueves"			BOOLEAN NOT NULL, 
	"viernes"			BOOLEAN NOT NULL, 
	"sabado"			BOOLEAN NOT NULL, 
	"domingo"			BOOLEAN NOT NULL, 
	"dia"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"usuarios"			VARCHAR (50), 
	"resta"			TIMESTAMP WITHOUT TIME ZONE
);

-- CREATE INDEXES ...
CREATE INDEX "tramos_id_idx" ON "tramos" ("id");
ALTER TABLE "tramos" ADD CONSTRAINT "tramos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "tramosperfiles"
 (
	"id"			SERIAL, 
	"idperfil"			INTEGER, 
	"turno"			VARCHAR (50), 
	"inicio"			TIMESTAMP WITHOUT TIME ZONE, 
	"fin"			TIMESTAMP WITHOUT TIME ZONE, 
	"user"			VARCHAR (50), 
	"usuarios"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "turnos"
 (
	"id"			SERIAL, 
	"area"			VARCHAR (50), 
	"turno"			VARCHAR (50), 
	"user"			VARCHAR (50), 
	"usuarios"			VARCHAR (50), 
	"color"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "turnos_id_idx" ON "turnos" ("id");
ALTER TABLE "turnos" ADD CONSTRAINT "turnos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "usuarios"
 (
	"id"			SERIAL, 
	"nombre"			VARCHAR (50), 
	"clave"			VARCHAR (50), 
	"1"			BOOLEAN NOT NULL, 
	"2"			BOOLEAN NOT NULL, 
	"3"			BOOLEAN NOT NULL, 
	"4"			BOOLEAN NOT NULL, 
	"5"			BOOLEAN NOT NULL, 
	"6"			BOOLEAN NOT NULL, 
	"7"			BOOLEAN NOT NULL, 
	"8"			BOOLEAN NOT NULL, 
	"9"			BOOLEAN NOT NULL, 
	"10"			BOOLEAN NOT NULL, 
	"11"			BOOLEAN NOT NULL, 
	"12"			BOOLEAN NOT NULL, 
	"13"			BOOLEAN NOT NULL, 
	"14"			BOOLEAN NOT NULL, 
	"15"			BOOLEAN NOT NULL, 
	"16"			BOOLEAN NOT NULL, 
	"17"			BOOLEAN NOT NULL, 
	"18"			BOOLEAN NOT NULL, 
	"19"			BOOLEAN NOT NULL, 
	"20"			BOOLEAN NOT NULL, 
	"21"			BOOLEAN NOT NULL, 
	"22"			BOOLEAN NOT NULL, 
	"23"			BOOLEAN NOT NULL, 
	"24"			BOOLEAN NOT NULL, 
	"25"			BOOLEAN NOT NULL, 
	"26"			BOOLEAN NOT NULL, 
	"27"			BOOLEAN NOT NULL, 
	"28"			BOOLEAN NOT NULL, 
	"29"			BOOLEAN NOT NULL, 
	"30"			BOOLEAN NOT NULL, 
	"31"			BOOLEAN NOT NULL, 
	"32"			BOOLEAN NOT NULL, 
	"33"			BOOLEAN NOT NULL, 
	"34"			BOOLEAN NOT NULL, 
	"35"			BOOLEAN NOT NULL, 
	"36"			BOOLEAN NOT NULL, 
	"37"			BOOLEAN NOT NULL, 
	"38"			BOOLEAN NOT NULL, 
	"39"			BOOLEAN NOT NULL, 
	"40"			BOOLEAN NOT NULL, 
	"41"			BOOLEAN NOT NULL, 
	"42"			BOOLEAN NOT NULL, 
	"43"			BOOLEAN NOT NULL, 
	"44"			BOOLEAN NOT NULL, 
	"45"			BOOLEAN NOT NULL, 
	"46"			BOOLEAN NOT NULL, 
	"47"			BOOLEAN NOT NULL, 
	"48"			BOOLEAN NOT NULL, 
	"49"			BOOLEAN NOT NULL, 
	"50"			BOOLEAN NOT NULL, 
	"51"			BOOLEAN NOT NULL, 
	"52"			BOOLEAN NOT NULL, 
	"53"			BOOLEAN NOT NULL, 
	"54"			BOOLEAN NOT NULL, 
	"55"			BOOLEAN NOT NULL, 
	"56"			BOOLEAN NOT NULL, 
	"57"			BOOLEAN NOT NULL, 
	"58"			BOOLEAN NOT NULL, 
	"59"			BOOLEAN NOT NULL, 
	"60"			BOOLEAN NOT NULL, 
	"61"			BOOLEAN NOT NULL, 
	"62"			BOOLEAN NOT NULL, 
	"63"			BOOLEAN NOT NULL, 
	"64"			BOOLEAN NOT NULL, 
	"65"			BOOLEAN NOT NULL, 
	"66"			BOOLEAN NOT NULL, 
	"67"			BOOLEAN NOT NULL, 
	"68"			BOOLEAN NOT NULL, 
	"69"			BOOLEAN NOT NULL, 
	"70"			BOOLEAN NOT NULL, 
	"71"			BOOLEAN NOT NULL, 
	"72"			BOOLEAN NOT NULL, 
	"73"			BOOLEAN NOT NULL, 
	"74"			BOOLEAN NOT NULL, 
	"75"			BOOLEAN NOT NULL, 
	"76"			BOOLEAN NOT NULL, 
	"77"			BOOLEAN NOT NULL, 
	"78"			BOOLEAN NOT NULL, 
	"79"			BOOLEAN NOT NULL, 
	"80"			BOOLEAN NOT NULL, 
	"81"			BOOLEAN NOT NULL, 
	"82"			BOOLEAN NOT NULL, 
	"83"			BOOLEAN NOT NULL, 
	"84"			BOOLEAN NOT NULL, 
	"85"			BOOLEAN NOT NULL, 
	"86"			BOOLEAN NOT NULL, 
	"87"			BOOLEAN NOT NULL, 
	"88"			BOOLEAN NOT NULL, 
	"89"			BOOLEAN NOT NULL, 
	"90"			BOOLEAN NOT NULL, 
	"91"			BOOLEAN NOT NULL, 
	"92"			BOOLEAN NOT NULL, 
	"93"			BOOLEAN NOT NULL, 
	"94"			BOOLEAN NOT NULL, 
	"95"			BOOLEAN NOT NULL, 
	"96"			BOOLEAN NOT NULL, 
	"97"			BOOLEAN NOT NULL, 
	"98"			BOOLEAN NOT NULL, 
	"99"			BOOLEAN NOT NULL, 
	"100"			BOOLEAN NOT NULL, 
	"user"			VARCHAR (50), 
	"usuario"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "avisos"
 (
	"id"			SERIAL, 
	"motivo"			VARCHAR (50), 
	"persona"			VARCHAR (250), 
	"destino"			VARCHAR (250), 
	"caduca"			TIMESTAMP WITHOUT TIME ZONE, 
	"user"			VARCHAR (50), 
	"fini"			TIMESTAMP WITHOUT TIME ZONE, 
	"ffin"			TIMESTAMP WITHOUT TIME ZONE, 
	"hora"			TIMESTAMP WITHOUT TIME ZONE, 
	"dias"			VARCHAR (10), 
	"informe"			VARCHAR (50), 
	"diasatras"			DOUBLE PRECISION, 
	"aux"			VARCHAR (10)
);

-- CREATE INDEXES ...
ALTER TABLE "avisos" ADD CONSTRAINT "avisos_pkey" PRIMARY KEY ("id");

CREATE TABLE IF NOT EXISTS "enrolldp"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"idlegajo"			INTEGER, 
	"panic"			BOOLEAN NOT NULL, 
	"user"			VARCHAR (50)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "enrolltemp"
 (
	"id"			SERIAL, 
	"template"			BYTEA, 
	"ruta"			TEXT
);

-- CREATE INDEXES ...
CREATE INDEX "enrolltemp_id_idx" ON "enrolltemp" ("id");

CREATE TABLE IF NOT EXISTS "fotos2"
 (
	"id"			SERIAL, 
	"foto"			BYTEA, 
	"idlegajo"			INTEGER, 
	"idviejo"			VARCHAR (12)
);

-- CREATE INDEXES ...

CREATE TABLE IF NOT EXISTS "lan"
 (
	"id"			SERIAL, 
	"ip"			VARCHAR (250), 
	"ubicacion"			VARCHAR (250), 
	"iddispositivo"			VARCHAR (250), 
	"sincroalinicio"			BOOLEAN NOT NULL, 
	"fechasincro"			TIMESTAMP WITHOUT TIME ZONE, 
	"cuantos"			INTEGER, 
	"neutro"			BOOLEAN NOT NULL, 
	"apertura"			BOOLEAN NOT NULL, 
	"sensorinicial"			BOOLEAN NOT NULL, 
	"punto"			VARCHAR (255), 
	"serie"			VARCHAR (250), 
	"activacion"			VARCHAR (250), 
	"modelo"			VARCHAR (250), 
	"puerto"			VARCHAR (10), 
	"traetarjeta"			BOOLEAN NOT NULL, 
	"usuario"			VARCHAR (10), 
	"pwd"			VARCHAR (10), 
	"traptype"			VARCHAR (10)
);

-- CREATE INDEXES ...


-- CREATE Relationships ...
ALTER TABLE "MSysNavPaneGroups" ADD CONSTRAINT "msysnavpanegroups_groupcategoryid_fk" FOREIGN KEY ("groupcategoryid") REFERENCES "MSysNavPaneGroupCategories"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "MSysNavPaneGroupToObjects" ADD CONSTRAINT "msysnavpanegrouptoobjects_groupid_fk" FOREIGN KEY ("groupid") REFERENCES "MSysNavPaneGroups"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
