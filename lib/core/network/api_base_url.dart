import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ApiBaseUrl {
  ApiBaseUrl._();

  static const _isProduction = true;
  static const _productionUrl = 'https://claudioparedes.site/gestion/api';
  static const _port = 8000;

  /// IP en la red local de la PC que corre `php artisan serve`. `10.0.2.2`
  /// solo funciona en el emulador de Android — un celular físico necesita
  /// esta IP real (mismo WiFi que la PC). Si cambia la IP de la PC o el
  /// celular, actualizar acá. `php artisan serve` tiene que levantarse con
  /// `--host=0.0.0.0` para aceptar conexiones de la red, no solo localhost.
  static const devLanIp = '192.168.0.60';

  static String get value {
    if (_isProduction) return _productionUrl;

    if (kIsWeb) return 'http://localhost:$_port/api';
    if (Platform.isAndroid) return 'http://$devLanIp:$_port/api';
    if (Platform.isIOS) return 'http://$devLanIp:$_port/api';
    return 'http://localhost:$_port/api';
  }
}
