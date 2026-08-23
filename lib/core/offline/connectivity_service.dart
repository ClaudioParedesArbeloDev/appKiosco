import 'package:connectivity_plus/connectivity_plus.dart';

/// Wrapper fino sobre `connectivity_plus` — solo informa si hay alguna
/// interfaz de red activa (wifi/ethernet/datos). No confirma que el
/// backend sea alcanzable de verdad (eso lo termina de decidir un pull
/// fallido/exitoso en `SyncService`), pero alcanza para decidir cuándo
/// intentar sincronizar.
class ConnectivityService {
  final _connectivity = Connectivity();

  Future<bool> tieneConexion() async {
    final resultados = await _connectivity.checkConnectivity();
    return resultados.any((r) => r != ConnectivityResult.none);
  }

  /// Emite cada vez que cambia el estado de conectividad.
  Stream<bool> get cambios => _connectivity.onConnectivityChanged
      .map((resultados) => resultados.any((r) => r != ConnectivityResult.none));
}
