import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  LocalArticulos,
  LocalClientes,
  LocalCajas,
  LocalCajaMovimientos,
  LocalVentas,
  LocalVentaItems,
  SyncQueueItems,
  OperacionesPendientes,
  SyncMeta,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // Fase 2: soporte offline de caja/ventas/clientes — instalaciones
            // que ya tenían la DB en versión 1 (solo artículos) reciben las
            // tablas nuevas sin perder lo que ya había.
            await m.createTable(localClientes);
            await m.createTable(localCajas);
            await m.createTable(localCajaMovimientos);
            await m.createTable(localVentas);
            await m.createTable(localVentaItems);
            await m.createTable(operacionesPendientes);
          }
        },
      );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_kiosco');
}
