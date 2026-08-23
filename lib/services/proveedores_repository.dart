import '../models/compra_model.dart';
import '../models/paginated_response.dart';
import '../models/proveedor_cuenta_corriente_model.dart';
import '../models/proveedor_model.dart';
import 'proveedores_api_service.dart';
import 'secure_storage_service.dart';

class ProveedoresRepository {
  ProveedoresRepository(this._api, this._storage);

  final ProveedoresApiService _api;
  final SecureStorageService _storage;

  Future<PaginatedResponse<ProveedorModel>> listar({String? search, bool? activo}) async {
    final response = await _api.listar(search: search, activo: activo);
    return PaginatedResponse.fromJson(response.data, ProveedorModel.fromJson);
  }

  Future<ProveedorModel> ver(String id) async {
    final response = await _api.ver(id);
    return ProveedorModel.fromJson(response.data);
  }

  Future<PaginatedResponse<CompraModel>> compras(String id) async {
    final response = await _api.compras(id);
    return PaginatedResponse.fromJson(response.data, CompraModel.fromJson);
  }

  Future<ProveedorCuentaCorrienteModel> cuentaCorriente(String id) async {
    final response = await _api.cuentaCorriente(id);
    return ProveedorCuentaCorrienteModel.fromJson(response.data);
  }

  Future<ProveedorModel> crear(Map<String, dynamic> data) async {
    final response = await _api.crear(data);
    return ProveedorModel.fromJson(response.data);
  }

  Future<ProveedorModel> actualizar(String id, Map<String, dynamic> data) async {
    final response = await _api.actualizar(id, data);
    return ProveedorModel.fromJson(response.data);
  }

  Future<void> eliminar(String id) => _api.eliminar(id);

  Future<int> registrarPago(
    String id, {
    required int monto,
    required String formaPago,
    String? nota,
  }) async {
    final deviceId = await _storage.getOrCreateDeviceId();
    final response = await _api.registrarPago(
      id,
      monto: monto,
      formaPago: formaPago,
      nota: nota,
      deviceId: deviceId,
    );
    return response.data['saldo'] as int;
  }
}
