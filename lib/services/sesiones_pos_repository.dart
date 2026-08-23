import '../models/sesion_pos_model.dart';
import 'sesiones_pos_api_service.dart';

class SesionesPosRepository {
  SesionesPosRepository(this._api);

  final SesionesPosApiService _api;

  Future<SesionPosModel> crear() async {
    final response = await _api.crear();
    return SesionPosModel.fromJson(response.data);
  }

  /// Devuelve el id de la sesión asociada a [pairingToken].
  Future<String> parear(String pairingToken) async {
    final response = await _api.parear(pairingToken);
    return response.data['id'] as String;
  }

  Future<void> scan(String sesionId, String codigo) async {
    await _api.scan(sesionId, codigo);
  }

  Future<void> eliminar(String sesionId) async {
    await _api.eliminar(sesionId);
  }
}
