import fs from "fs";
import MDBReader from "mdb-reader";
import pg from "pg";

const { Client } = pg;

const mdb_path = "./base.mdb";
const PG_CONNECTION_STRING =
  process.env.PG_CONNECTION_STRING ||
  "postgresql://huellas_user:b77316DB44X-@localhost:5432/huellas_db";

function parseDiaHora(diaHora) {
  if (!diaHora) return null;
  if (diaHora instanceof Date) {
    if (isNaN(diaHora.getTime())) return null;

    const y = diaHora.getFullYear();
    const m = String(diaHora.getMonth() + 1).padStart(2, "0");
    const d = String(diaHora.getDate()).padStart(2, "0");
    const HH = String(diaHora.getHours()).padStart(2, "0");
    const MM = String(diaHora.getMinutes()).padStart(2, "0");
    const SS = String(diaHora.getSeconds()).padStart(2, "0");

    return `${y}-${m}-${d} ${HH}:${MM}:${SS}`;
  }

  if (typeof diaHora === "string") {
    const [fecha, hora] = diaHora.split(" ");
    if (!fecha || !hora) return null;

    const [d, m, y] = fecha.split("/");
    if (!d || !m || !y) return null;

    const year = Number(y.length === 2 ? `20${y}` : y);

    const [h, min, sRaw] = hora.split(":");
    if (!h || !min) return null;

    const seconds = sRaw ? sRaw : "00";

    const yyyy = year.toString().padStart(4, "0");
    const MM = m.padStart(2, "0");
    const dd = d.padStart(2, "0");
    const HH = h.padStart(2, "0");
    const mm2 = min.padStart(2, "0");
    const ss = seconds.padStart(2, "0");

    return `${yyyy}-${MM}-${dd} ${HH}:${mm2}:${ss}`;
  }
}

console.log(parseDiaHora("02/01/25 06:58:20"));

async function main() {
  const buffer = fs.readFileSync(mdb_path);
  const reader = new MDBReader(buffer);

  const accesosTable = reader.getTable("ACCESOS");
  const legajosTable = reader.getTable("LEGAJOS");

  const accesosRows = accesosTable.getData();
  const legajosRows = legajosTable.getData();

  console.log(`Read ${accesosRows.length} rows from Accesos table`);

  const client = new Client({
    connectionString: PG_CONNECTION_STRING,
  });
  await client.connect();

  try {
    await client.query("BEGIN");

    console.log("sincronizando legajos...");
    for (const row of legajosRows) {
      const cod = row.COD ?? null;
      if (!cod) continue;

      let fechaIngreso = row.FECHA_INGRESO;
      if (fechaIngreso instanceof Date && isNaN(fechaIngreso.getTime())) {
        fechaIngreso = null;
      }

      await client.query(
        `
                INSERT INTO huella.legajo (
                cod, nombre, area, turno, estado, inactivo, fecha_ingreso, dni, email)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
                ON CONFLICT (cod) DO UPDATE SET
                    nombre = EXCLUDED.nombre,
                    area = EXCLUDED.area,
                    turno = EXCLUDED.turno,
                    estado = EXCLUDED.estado,
                    inactivo = EXCLUDED.inactivo,
                    fecha_ingreso = EXCLUDED.fecha_ingreso,
                    dni = EXCLUDED.dni,
                    email = EXCLUDED.email  
                                                          
                `,
        [
          cod,
          row.NOMBRE ?? null,
          row.AREA ?? null,
          row.TURNO ?? null,
          row.ESTADO ?? null,
          row.INACTIVO ?? null,
          fechaIngreso,
          row.DNI ?? null,
          row.EMAIL ?? null,
        ]
      );
    }
    console.log("legajos sincronizados.");

    console.log("sincronizando accesos...");

    for (const row of accesosRows) {
      const id = row.Id ?? row.ID ?? null;
      if (!id) continue;

      const legajo = (row.idLegajos ?? row.IDLEGAJOS ?? row.LEGAJO ?? "")
        .toString()
        .trim();
      if (!legajo) continue;

      const diaHora = row.DIAHORA ?? row.diaHora ?? null;
      const ts = parseDiaHora(diaHora);

      if (!ts) continue;

      const tipo = row.TIPO ?? null;
      const sensor = row.SENSOR ?? row.sensor ?? null;
      const duplicado = row.duplicado ?? row.DUPLICADO ?? null;

      await client.query(
        `
                    INSERT INTO huella.marcas (
                        id, legajo, ts, tipo, sensor, duplicado
                    ) VALUES ($1, $2, $3::timestamp, $4, $5, $6)
                    ON CONFLICT (id) DO NOTHING
                `,
        [id, legajo, ts, tipo, sensor, duplicado]
      );
    }

    console.log("accesos sincronizados.");
    await client.query("COMMIT");
    console.log("Sincronización completada exitosamente.");
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Error durante la sincronización:", error);
  } finally {
    await client.end();
  }
}

main().catch(console.error);
