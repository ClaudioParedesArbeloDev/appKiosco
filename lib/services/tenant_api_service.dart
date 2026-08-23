import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class TenantApiService {
  TenantApiService(this._client);

  final ApiClient _client;

  Future<Response> actualizarLogo({required List<int> bytes, required String filename}) {
    final formData = FormData.fromMap({
      'logo': MultipartFile.fromBytes(bytes, filename: filename),
    });

    return _client.dio.post(ApiEndpoints.tenantLogo, data: formData);
  }

  Future<Response> actualizarNombre(String nombreComercio) {
    return _client.dio.put(ApiEndpoints.tenant, data: {'nombre_comercio': nombreComercio});
  }

  Future<Response> actualizarImpresoraFiscal({
    required String nombreComercio,
    String? marca,
    String? puerto,
    int? baudRate,
  }) {
    return _client.dio.put(ApiEndpoints.tenant, data: {
      // El backend valida nombre_comercio como requerido en el mismo
      // endpoint — se manda el valor actual para no pisarlo.
      'nombre_comercio': nombreComercio,
      'impresora_fiscal_marca': marca,
      'impresora_fiscal_puerto': puerto,
      'impresora_fiscal_baud_rate': baudRate,
    });
  }
}
