import 'package:drift/drift.dart';

/// Espejo local de `articulos` (tabla editable en el sync — ver
/// `SyncController` en backGestion). `version` + `pendienteSync` son lo que
/// permite saber qué filas tienen cambios locales sin pushear todavía.
class LocalArticulos extends Table {
  TextColumn get id => text()();
  TextColumn get codigoBarras => text().nullable()();
  TextColumn get codigoInterno => text().nullable()();
  TextColumn get descripcion => text()();
  TextColumn get marca => text().nullable()();
  TextColumn get rubro => text().nullable()();
  TextColumn get imagenUrl => text().nullable()();
  IntColumn get precioCosto => integer()();
  IntColumn get precioVenta => integer()();
  IntColumn get precioPromocional => integer().nullable()();
  DateTimeColumn get promocionDesde => dateTime().nullable()();
  DateTimeColumn get promocionHasta => dateTime().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  /// Último stock conocido — lo calcula siempre el backend (suma de
  /// movimientos), acá es solo un valor cacheado para mostrar offline.
  IntColumn get stockActual => integer().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();

  /// true = esta fila tiene cambios locales que todavía no se subieron.
  BoolColumn get pendienteSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Espejo local de `clientes` — mismo patrón "tabla editable" que
/// `LocalArticulos`. Necesario para que el selector de cliente del POS
/// (buscar/elegir/crear) funcione sin conexión.
class LocalClientes extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get dniCuit => text().nullable()();
  TextColumn get condicionIva => text().withDefault(const Constant('consumidor_final'))();
  TextColumn get direccion => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get zona => text().nullable()();
  IntColumn get porcentajeDescuento => integer().withDefault(const Constant(0))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  IntColumn get limiteCuentaCorriente => integer().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get pendienteSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Espejo local de la caja del dispositivo — a diferencia de artículos y
/// clientes, no es "editable" en el sentido del `SyncController` genérico:
/// se crea/actualiza reproduciendo la misma llamada de siempre
/// (`POST /caja/abrir|cerrar`) vía `OperacionesPendientes`, nunca con un
/// insert crudo. Esta tabla es solo la vista local de "cómo quedó".
class LocalCajas extends Table {
  TextColumn get id => text()();
  IntColumn get montoInicial => integer()();
  IntColumn get montoFinalDeclarado => integer().nullable()();
  IntColumn get montoFinalCalculado => integer().nullable()();
  IntColumn get diferencia => integer().nullable()();

  /// 'abierta' | 'cerrada'
  TextColumn get estado => text()();
  TextColumn get deviceId => text()();
  TextColumn get nombreDispositivo => text().nullable()();
  DateTimeColumn get ocurridaEn => dateTime()();
  DateTimeColumn get cerradaEn => dateTime().nullable()();
  BoolColumn get pendienteSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Espejo local de `caja_movimientos` (ingresos/retiros manuales — las
/// ventas mueven caja del lado del server dentro de `POST /ventas`, no se
/// registran acá por separado).
class LocalCajaMovimientos extends Table {
  TextColumn get id => text()();
  TextColumn get cajaId => text()();

  /// 'ingreso' | 'retiro'
  TextColumn get tipo => text()();

  /// Positivo = entrada, negativo = salida (mismo signo que espera el server).
  IntColumn get monto => integer()();
  TextColumn get nota => text()();
  DateTimeColumn get ocurridaEn => dateTime()();
  BoolColumn get pendienteSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Espejo local de una venta hecha offline. `numero` queda null hasta que
/// el server la confirme (no se genera numeración secuencial offline, para
/// no arriesgar colisión entre dos dispositivos) — la UI muestra "pendiente"
/// mientras tanto.
class LocalVentas extends Table {
  TextColumn get id => text()();
  IntColumn get numero => integer().nullable()();
  TextColumn get clienteId => text().nullable()();
  TextColumn get formaPago => text()();
  TextColumn get tipoComprobante => text()();
  IntColumn get subtotal => integer()();
  IntColumn get descuento => integer()();
  IntColumn get total => integer()();
  TextColumn get deviceId => text().nullable()();
  DateTimeColumn get ocurridaEn => dateTime()();
  BoolColumn get pendienteSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalVentaItems extends Table {
  TextColumn get id => text()();
  TextColumn get ventaId => text()();
  TextColumn get articuloId => text()();
  IntColumn get cantidad => integer()();
  IntColumn get precioUnitario => integer()();
  IntColumn get subtotal => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cola de cambios locales pendientes de mandar a `POST /sync/push` — solo
/// para las tablas "editables" simples (`articulos`, `clientes`). Ventas,
/// caja y sus movimientos NO usan esta cola, ver `OperacionesPendientes`.
class SyncQueueItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tabla => text()();
  TextColumn get entidadId => text()();

  /// JSON con los campos a mandar — se arma en el momento de encolar, no
  /// se recalcula después (mismo dato que se hubiera mandado online).
  TextColumn get payload => text()();
  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();
  IntColumn get intentos => integer().withDefault(const Constant(0))();
}

/// Cola de operaciones de negocio diferidas (abrir/cerrar caja, movimiento
/// de caja, crear venta, crear cliente) — a diferencia de `SyncQueueItems`,
/// cada fila acá no es "una fila a insertar" sino "una llamada a reproducir"
/// contra el endpoint real de siempre, para que se ejecute toda la lógica
/// de negocio del server (precio, descuento, numeración, límite de plan,
/// movimientos de stock/caja) tal cual se ejecutaría online. `orden` fija
/// la secuencia estricta de replay (ej. crear_cliente antes que la
/// crear_venta que lo referencia).
class OperacionesPendientes extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 'crear_cliente' | 'abrir_caja' | 'registrar_movimiento' | 'crear_venta' | 'cerrar_caja'
  TextColumn get tipoOperacion => text()();

  /// Id local (= id final, por el id passthrough del backend) de la
  /// entidad que esta operación crea o afecta.
  TextColumn get entidadLocalId => text()();

  /// JSON con el mismo body que se manda al endpoint real.
  TextColumn get payload => text()();
  DateTimeColumn get ocurridaEn => dateTime()();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
  IntColumn get intentos => integer().withDefault(const Constant(0))();
  TextColumn get ultimoError => text().nullable()();

  /// 'pendiente' | 'fallida' — una fallida no se reintenta sola, queda para
  /// que el dueño la revise a mano (poco volumen esperado en un kiosco).
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
}

/// Metadatos del sync — hoy solo guarda cuándo fue el último pull exitoso,
/// para mandarlo como `?since=` la próxima vez.
class SyncMeta extends Table {
  TextColumn get clave => text()();
  TextColumn get valor => text()();

  @override
  Set<Column> get primaryKey => {clave};
}
