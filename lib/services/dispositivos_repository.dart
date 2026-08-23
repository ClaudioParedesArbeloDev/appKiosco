import '../models/dispositivo_model.dart';
import 'dispositivos_api_service.dart';

class DispositivosRepository {
  DispositivosRepository(this._api);

  final DispositivosApiService _api;

  Future<List<DispositivoModel>> listar() async {
    final response = await _api.listar();
    return (response.data as List).map((d) => DispositivoModel.fromJson(d)).toList();
  }

  Future<void> desactivar(String id) => _api.desactivar(id);
  Future<void> reactivar(String id) => _api.reactivar(id);
}
