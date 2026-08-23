import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _sesionPosIdKey = 'sesion_pos_id';
  static const _sesionPosTokenKey = 'sesion_pos_pairing_token';
  static const _deviceIdKey = 'device_id';
  static const _deviceNombreKey = 'device_nombre';

  Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);
  Future<String?> getToken() => _storage.read(key: _tokenKey);
  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  /// Emparejamiento celular<->PC persistido para que dure todo el día en vez
  /// de tener que re-escanear el QR en cada venta o alta de artículo.
  Future<void> savePairingSession({required String id, required String pairingToken}) async {
    await _storage.write(key: _sesionPosIdKey, value: id);
    await _storage.write(key: _sesionPosTokenKey, value: pairingToken);
  }

  Future<String?> getPairingSessionId() => _storage.read(key: _sesionPosIdKey);
  Future<String?> getPairingSessionToken() => _storage.read(key: _sesionPosTokenKey);

  Future<void> deletePairingSession() async {
    await _storage.delete(key: _sesionPosIdKey);
    await _storage.delete(key: _sesionPosTokenKey);
  }

  /// Identifica a esta instalación (esta PC/mostrador) para el backend —
  /// cada dispositivo tiene su propia caja, independiente de las demás, y
  /// el plan del comercio puede limitar cuántos dispositivos distintos
  /// pueden abrir caja (`max_sucursales`). Cacheado acá para no consultar
  /// el SO en cada request, pero NO es la fuente de verdad: si el cache se
  /// borra, se vuelve a derivar el mismo id del hardware (ver
  /// `_idEstableDelSistema`), así que reinstalar la app o limpiar datos no
  /// alcanza para esquivar el límite del plan.
  Future<String> getOrCreateDeviceId() async {
    final existente = await _storage.read(key: _deviceIdKey);
    if (existente != null) return existente;

    final nuevo = await _idEstableDelSistema() ?? const Uuid().v4();
    await _storage.write(key: _deviceIdKey, value: nuevo);
    return nuevo;
  }

  /// UUID determinístico (v5, hash) derivado de un identificador estable
  /// del sistema operativo — mismo hardware siempre da el mismo resultado.
  /// Solo en desktop, que es donde vive el concepto de caja/mostrador; en
  /// mobile (celular como lector remoto) no aplica, se sigue generando un
  /// UUID random como antes. Null si la plataforma no expone nada estable
  /// o si algo falla al leerlo — en ese caso cae al UUID random.
  Future<String?> _idEstableDelSistema() async {
    try {
      final info = DeviceInfoPlugin();
      final String? crudo;

      if (Platform.isLinux) {
        crudo = (await info.linuxInfo).machineId;
      } else if (Platform.isWindows) {
        crudo = (await info.windowsInfo).deviceId;
      } else if (Platform.isMacOS) {
        crudo = (await info.macOsInfo).systemGUID;
      } else {
        crudo = null;
      }

      if (crudo == null || crudo.isEmpty) return null;

      return const Uuid().v5(Namespace.url.value, crudo);
    } catch (_) {
      return null;
    }
  }

  Future<String?> getDeviceNombre() => _storage.read(key: _deviceNombreKey);
  Future<void> saveDeviceNombre(String nombre) =>
      _storage.write(key: _deviceNombreKey, value: nombre);
}
