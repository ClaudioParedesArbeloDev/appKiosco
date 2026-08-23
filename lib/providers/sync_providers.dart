import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/offline/app_database.dart';
import '../core/offline/connectivity_service.dart';
import '../core/offline/sync_service.dart';
import '../services/secure_storage_service.dart';
import '../services/sync_api_service.dart';
import 'auth_providers.dart';

/// Una sola instancia de la base local para toda la app — abrir el .sqlite
/// más de una vez rompe la sincronización entre streams de drift.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final connectivityServiceProvider = Provider((ref) => ConnectivityService());

final syncServiceProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return SyncService(
    ref.watch(appDatabaseProvider),
    SyncApiService(client),
    SecureStorageService(),
    client,
  );
});

/// Cuántas operaciones (ventas, caja, clientes hechos sin conexión) siguen
/// esperando para mandarse al server — reactivo: se actualiza solo apenas
/// se encola o se saca una fila, sin tener que refrescar a mano.
final operacionesPendientesCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final query = db.select(db.operacionesPendientes)
    ..where((t) => t.estado.equals('pendiente'))
    ..orderBy([(t) => OrderingTerm.asc(t.id)]);
  return query.watch().map((filas) => filas.length);
});
