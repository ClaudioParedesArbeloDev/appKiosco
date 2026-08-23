import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class ProveedoresApiService {
  ProveedoresApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({String? search, bool? activo}) {
    return _client.dio.get(ApiEndpoints.proveedores, queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
      'activo': ?activo,
    });
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.proveedor(id));

  Future<Response> compras(String id) => _client.dio.get(ApiEndpoints.proveedorCompras(id));

  Future<Response> cuentaCorriente(String id) =>
      _client.dio.get(ApiEndpoints.proveedorCuentaCorriente(id));

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.proveedores, data: data);

  Future<Response> actualizar(String id, Map<String, dynamic> data) =>
      _client.dio.put(ApiEndpoints.proveedor(id), data: data);

  Future<Response> eliminar(String id) => _client.dio.delete(ApiEndpoints.proveedor(id));

  Future<Response> registrarPago(
    String id, {
    required int monto,
    required String formaPago,
    String? nota,
    String? deviceId,
  }) {
    return _client.dio.post(ApiEndpoints.proveedorPagos(id), data: {
      'monto': monto,
      'forma_pago': formaPago,
      'nota': nota,
      'device_id': deviceId,
    });
  }
}
