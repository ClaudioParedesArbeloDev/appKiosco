import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/sync_providers.dart';

enum SyncEstado { desconocido, sincronizando, sincronizado, sinConexion, error }

class SyncState {
  const SyncState({required this.online, required this.estado, this.ultimoSyncAt, this.error});

  final bool online;
  final SyncEstado estado;
  final DateTime? ultimoSyncAt;
  final String? error;
}

/// Dispara la sincronización sola — al arrancar, cada vez que vuelve la
/// conexión, y cada 2 minutos mientras haya conexión (red de contención
/// por si algo se perdió el evento de conectividad). No hace falta
/// llamarlo a mano desde ningún botón para el uso normal.
class SyncController extends Notifier<SyncState> {
  Timer? _timer;
  StreamSubscription<bool>? _connectivitySub;

  @override
  SyncState build() {
    ref.onDispose(() {
      _timer?.cancel();
      _connectivitySub?.cancel();
    });

    _connectivitySub = ref.read(connectivityServiceProvider).cambios.listen((online) {
      if (online) sincronizar();
    });

    _timer = Timer.periodic(const Duration(minutes: 2), (_) => sincronizar());

    // No bloquear build() con la primera sincronización.
    Future.microtask(sincronizar);

    return const SyncState(online: true, estado: SyncEstado.desconocido);
  }

  Future<void> sincronizar() async {
    final online = await ref.read(connectivityServiceProvider).tieneConexion();
    if (!online) {
      state = SyncState(online: false, estado: SyncEstado.sinConexion, ultimoSyncAt: state.ultimoSyncAt);
      return;
    }

    state = SyncState(online: true, estado: SyncEstado.sincronizando, ultimoSyncAt: state.ultimoSyncAt);
    try {
      await ref.read(syncServiceProvider).sincronizar();
      state = SyncState(online: true, estado: SyncEstado.sincronizado, ultimoSyncAt: DateTime.now());
    } catch (e) {
      state = SyncState(
        online: true,
        estado: SyncEstado.error,
        ultimoSyncAt: state.ultimoSyncAt,
        error: '$e',
      );
    }
  }
}

final syncControllerProvider = NotifierProvider<SyncController, SyncState>(SyncController.new);
