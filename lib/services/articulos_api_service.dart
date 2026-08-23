import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class ArticulosApiService {
  ArticulosApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({String? search, String? rubro, bool? activo}) {
    return _client.dio.get(ApiEndpoints.articulos, queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
      'rubro': ?rubro,
      'activo': ?activo,
    });
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.articulo(id));

  Future<Response> movimientos(String id) =>
      _client.dio.get(ApiEndpoints.articuloMovimientos(id));

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.articulos, data: data);

  Future<Response> actualizar(String id, Map<String, dynamic> data) =>
      _client.dio.put(ApiEndpoints.articulo(id), data: data);

  Future<Response> eliminar(String id) => _client.dio.delete(ApiEndpoints.articulo(id));

  Future<Response> ajustarStock(String id, int cantidad, String nota) {
    return _client.dio.post(ApiEndpoints.articuloAjustarStock(id), data: {
      'cantidad': cantidad,
      'nota': nota,
    });
  }

  Future<Response> buscarPorCodigo(String codigo) =>
      _client.dio.get(ApiEndpoints.articuloBuscarCodigo(codigo));

  Future<Response<List<int>>> exportar() {
    return _client.dio.get<List<int>>(
      ApiEndpoints.articulosExportar,
      options: Options(responseType: ResponseType.bytes),
    );
  }

  Future<Response> importar(List<int> bytes, String filename) {
    final formData = FormData.fromMap({
      'archivo': MultipartFile.fromBytes(bytes, filename: filename),
    });
    return _client.dio.post(ApiEndpoints.articulosImportar, data: formData);
  }

  Future<Response> actualizarPreciosMasivo(Map<String, dynamic> data) {
    return _client.dio.post(ApiEndpoints.articulosActualizarPreciosMasivo, data: data);
  }
}
