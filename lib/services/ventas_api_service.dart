import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class VentasApiService {
  VentasApiService(this._client);

  final ApiClient _client;

  Future<Response> crear(Map<String, dynamic> data) {
    return _client.dio.post(ApiEndpoints.ventas, data: data);
  }

  Future<Response> listar({String? estado, int page = 1}) {
    return _client.dio.get(ApiEndpoints.ventas, queryParameters: {
      'estado': ?estado,
      'page': page,
    });
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.venta(id));

  Future<Response> estadisticas() => _client.dio.get(ApiEndpoints.ventasEstadisticas);

  Future<Response> productosMasVendidos(String periodo) {
    return _client.dio.get(
      ApiEndpoints.ventasProductosMasVendidos,
      queryParameters: {'periodo': periodo},
    );
  }

  Future<Response> estadisticasMensuales() =>
      _client.dio.get(ApiEndpoints.ventasEstadisticasMensuales);

  Future<Response> anular(String id, String motivo) {
    return _client.dio.post(ApiEndpoints.ventaAnular(id), data: {'motivo': motivo});
  }
}
