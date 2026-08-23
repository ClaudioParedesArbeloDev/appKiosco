import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'api_base_url.dart';

/// Config de conexión al servidor de WebSockets (Laravel Reverb) que usa
/// `app_kiosco` para el emparejamiento celular↔PC del POS. Espeja el mismo
/// patrón de [ApiBaseUrl] (mismo host, puerto distinto).
class RealtimeConfig {
  RealtimeConfig._();

  static const _isProduction = true;
  static const _productionHost = 'claudioparedes.site';
  static const _productionScheme = 'wss';
  static const _productionPort = 443;
  static const _devPort = 8080;

  /// Clave pública de la app de Reverb — no es un secreto (equivalente a un
  /// app key de Pusher), es seguro tenerla hardcodeada en el cliente.
  static const appKey = 'arbelokioscoreverbkey01';

  static String get scheme => _isProduction ? _productionScheme : 'ws';

  static int get port => _isProduction ? _productionPort : _devPort;

  static String get host {
    if (_isProduction) return _productionHost;

    if (kIsWeb) return 'localhost';
    if (Platform.isAndroid) return ApiBaseUrl.devLanIp;
    if (Platform.isIOS) return ApiBaseUrl.devLanIp;
    return 'localhost';
  }

  /// El endpoint de autorización de canales privados vive bajo la misma API
  /// que todo lo demás (`/api/broadcasting/auth`), no bajo el puerto de Reverb.
  static String get broadcastingAuthUrl => '${ApiBaseUrl.value}/broadcasting/auth';
}
