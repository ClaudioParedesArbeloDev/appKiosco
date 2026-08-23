import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class ClientesApiService {
  ClientesApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({String? search, bool? activo}) {
    return _client.dio.get(ApiEndpoints.clientes, queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
      'activo': ?activo,
    });
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.cliente(id));

  Future<Response> ventas(String id) => _client.dio.get(ApiEndpoints.clienteVentas(id));

  Future<Response> estadisticas(String id) =>
      _client.dio.get(ApiEndpoints.clienteEstadisticas(id));

  Future<Response> cuentaCorriente(String id) =>
      _client.dio.get(ApiEndpoints.clienteCuentaCorriente(id));

  Future<Response> registrarPago(
    String id, {
    required int monto,
    required String formaPago,
    String? nota,
    String? deviceId,
  }) {
    return _client.dio.post(ApiEndpoints.clientePagos(id), data: {
      'monto': monto,
      'forma_pago': formaPago,
      'nota': nota,
      'device_id': deviceId,
    });
  }

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.clientes, data: data);

  Future<Response> actualizar(String id, Map<String, dynamic> data) =>
      _client.dio.put(ApiEndpoints.cliente(id), data: data);

  Future<Response> eliminar(String id) => _client.dio.delete(ApiEndpoints.cliente(id));
}
