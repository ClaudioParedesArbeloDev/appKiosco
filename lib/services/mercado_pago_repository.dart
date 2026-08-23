import '../models/point_device_model.dart';
import 'mercado_pago_api_service.dart';

/// Estados posibles de un intento de cobro en el Point, agrupados para no
/// tener que repartir por toda la app el conocimiento de los strings que
/// devuelve Mercado Pago.
enum PointPaymentEstado { esperando, aprobado, fallido }

class MercadoPagoRepository {
  MercadoPagoRepository(this._api);

  final MercadoPagoApiService _api;

  Future<String> obtenerUrlDeConexion() async {
    final response = await _api.connect();
    return response.data['authorization_url'] as String;
  }

  Future<bool> estaConectado() async {
    final response = await _api.status();
    return response.data['connected'] as bool;
  }

  Future<void> desconectar() => _api.disconnect();

  Future<List<PointDeviceModel>> listarDispositivos() async {
    final response = await _api.devices();
    final lista = response.data['devices'] as List;
    return lista.map((d) => PointDeviceModel.fromJson(d)).toList();
  }

  Future<String> crearCobro({required String deviceId, required int montoCentavos}) async {
    final response =
        await _api.crearPaymentIntent(deviceId: deviceId, montoCentavos: montoCentavos);
    return response.data['payment_intent_id'] as String;
  }

  /// Mercado Pago devuelve el estado del intento como un string de evento
  /// (ej. "PAYMENT_FINISHED", "PAYMENT_ERROR") — no hay una lista cerrada y
  /// documentada de todos los valores posibles, así que esto es una
  /// heurística por palabras clave. Falta validar los strings reales contra
  /// una cuenta y un Point físico antes de confiar en esto en producción.
  Future<PointPaymentEstado> consultarEstado(String paymentIntentId) async {
    final response = await _api.estadoPaymentIntent(paymentIntentId);
    final estado = (response.data['status'] as String? ?? '').toUpperCase();

    if (estado.contains('FINISH') || estado.contains('APPROVED')) {
      return PointPaymentEstado.aprobado;
    }
    if (estado.contains('ERROR') || estado.contains('CANCEL') || estado.contains('REJECT')) {
      return PointPaymentEstado.fallido;
    }
    return PointPaymentEstado.esperando;
  }
}
