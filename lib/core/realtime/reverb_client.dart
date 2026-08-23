import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import '../network/realtime_config.dart';

/// Envoltorio fino sobre `dart_pusher_channels` (habla el protocolo Pusher,
/// que es el que usa Reverb) — aísla el detalle de protocolo del resto de
/// la app. Se eligió sobre `pusher_channels_flutter` porque ese paquete
/// envuelve los SDKs nativos de iOS/Android y no soporta Linux/Windows, que
/// es justo la plataforma que tiene que andar acá (la PC es quien escucha).
///
/// Maneja reconexión y ping/pong automáticamente (lo hace la librería) —
/// necesario porque Reverb cierra conexiones idle, y un cajero puede tardar
/// en escanear o el WiFi del local puede cortarse.
class ReverbClient {
  PusherChannelsClient? _client;
  StreamSubscription<ChannelReadEvent>? _subscription;
  StreamSubscription<void>? _connectionEstablishedSubscription;

  Future<void> conectarASesion({
    required String sesionId,
    required String token,
    required void Function(String codigo) onCodigoEscaneado,
  }) async {
    final client = PusherChannelsClient.websocket(
      options: PusherChannelsOptions.fromHost(
        scheme: RealtimeConfig.scheme,
        host: RealtimeConfig.host,
        port: RealtimeConfig.port,
        key: RealtimeConfig.appKey,
      ),
      // Ojo: la librería NO reintenta sola — solo avisa el error acá y
      // espera a que se llame explícitamente a `refresh()` para reconectar
      // (que sí respeta `minimumReconnectDelayDuration` internamente, así
      // que esto no termina en un loop apretado).
      connectionErrorHandler: (exception, trace, refresh) {
        debugPrint('ReverbClient: error de conexión: $exception');
        refresh();
      },
    );
    _client = client;

    final channel = client.privateChannel(
      'private-sesion-pos.$sesionId',
      authorizationDelegate: EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
        authorizationEndpoint: Uri.parse(RealtimeConfig.broadcastingAuthUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    _subscription = channel.bind('codigo.escaneado').listen((event) {
      debugPrint('ReverbClient: evento recibido: ${event.tryGetDataAsMap()}');
      final codigo = event.tryGetDataAsMap()?['codigo'] as String?;
      if (codigo != null && codigo.isNotEmpty) {
        onCodigoEscaneado(codigo);
      }
    });

    // La suscripción al canal NO sobrevive una reconexión sola — hay que
    // volver a pedirla cada vez que se restablece la conexión (incluida la
    // primera vez). subscribeIfNotUnsubscribed() es justo para este uso,
    // según la propia documentación del paquete.
    _connectionEstablishedSubscription = client.onConnectionEstablished.listen((_) {
      debugPrint('ReverbClient: conexión establecida, suscribiendo al canal $sesionId');
      channel.subscribeIfNotUnsubscribed();
    });

    await client.connect();
    debugPrint('ReverbClient: connect() completó para sesión $sesionId');
  }

  Future<void> desconectar() async {
    await _subscription?.cancel();
    _subscription = null;

    await _connectionEstablishedSubscription?.cancel();
    _connectionEstablishedSubscription = null;

    final client = _client;
    _client = null;

    if (client != null) {
      await client.disconnect();
      client.dispose();
    }
  }
}
