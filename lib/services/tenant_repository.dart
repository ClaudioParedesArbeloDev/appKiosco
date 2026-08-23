import 'tenant_api_service.dart';

class TenantRepository {
  TenantRepository(this._api);

  final TenantApiService _api;

  Future<String> actualizarLogo({required List<int> bytes, required String filename}) async {
    final response = await _api.actualizarLogo(bytes: bytes, filename: filename);
    return response.data['logo_url'] as String;
  }

  Future<void> actualizarNombre(String nombreComercio) => _api.actualizarNombre(nombreComercio);

  Future<void> actualizarImpresoraFiscal({
    required String nombreComercio,
    String? marca,
    String? puerto,
    int? baudRate,
  }) =>
      _api.actualizarImpresoraFiscal(
        nombreComercio: nombreComercio,
        marca: marca,
        puerto: puerto,
        baudRate: baudRate,
      );
}
