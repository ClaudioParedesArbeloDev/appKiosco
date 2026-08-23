import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../core/offline/app_database.dart';
import '../core/offline/offline_queue.dart';
import '../models/cliente_cuenta_corriente_model.dart';
import '../models/cliente_estadisticas_model.dart';
import '../models/cliente_model.dart';
import '../models/paginated_response.dart';
import '../models/venta_model.dart';
import 'clientes_api_service.dart';
import 'secure_storage_service.dart';

class ClientesRepository {
  ClientesRepository(this._api, this._storage, this._db);

  final ClientesApiService _api;
  final SecureStorageService _storage;
  final AppDatabase _db;

  Future<PaginatedResponse<ClienteModel>> listar({String? search, bool? activo}) async {
    final response = await _api.listar(search: search, activo: activo);
    return PaginatedResponse.fromJson(response.data, ClienteModel.fromJson);
  }

  Future<ClienteModel> ver(String id) async {
    final response = await _api.ver(id);
    return ClienteModel.fromJson(response.data);
  }

  Future<PaginatedResponse<VentaModel>> ventas(String id) async {
    final response = await _api.ventas(id);
    return PaginatedResponse.fromJson(response.data, VentaModel.fromJson);
  }

  Future<ClienteEstadisticasModel> estadisticas(String id) async {
    final response = await _api.estadisticas(id);
    return ClienteEstadisticasModel.fromJson(response.data);
  }

  Future<ClienteModel> crear(Map<String, dynamic> data) async {
    try {
      final response = await _api.crear(data);
      return ClienteModel.fromJson(response.data);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _crearOffline(data);
    }
  }

  /// Sin conexión: se guarda local (visible de inmediato en el selector del
  /// POS) y se encola para crearse de verdad en el server al reconectar. El
  /// id generado acá es el id final — ver id passthrough en
  /// `ClienteController::store()`.
  Future<ClienteModel> _crearOffline(Map<String, dynamic> data) async {
    final id = const Uuid().v4();
    final ocurridaEn = DateTime.now();

    await _db.into(_db.localClientes).insert(
          LocalClientesCompanion.insert(
            id: id,
            nombre: data['nombre'] as String,
            dniCuit: Value(data['dni_cuit'] as String?),
            condicionIva: Value(data['condicion_iva'] as String? ?? 'consumidor_final'),
            direccion: Value(data['direccion'] as String?),
            telefono: Value(data['telefono'] as String?),
            email: Value(data['email'] as String?),
            zona: Value(data['zona'] as String?),
            porcentajeDescuento: Value(data['porcentaje_descuento'] as int? ?? 0),
            limiteCuentaCorriente: Value(data['limite_cuenta_corriente'] as int?),
            pendienteSync: const Value(true),
          ),
        );

    await encolarOperacion(
      _db,
      tipoOperacion: 'crear_cliente',
      entidadLocalId: id,
      payload: {...data, 'id': id, 'ocurrida_en': ocurridaEn.toIso8601String()},
      ocurridaEn: ocurridaEn,
    );

    return ClienteModel(
      id: id,
      nombre: data['nombre'] as String,
      condicionIva: data['condicion_iva'] as String? ?? 'consumidor_final',
      porcentajeDescuento: data['porcentaje_descuento'] as int? ?? 0,
      activo: true,
      dniCuit: data['dni_cuit'] as String?,
      direccion: data['direccion'] as String?,
      telefono: data['telefono'] as String?,
      email: data['email'] as String?,
      zona: data['zona'] as String?,
      limiteCuentaCorriente: data['limite_cuenta_corriente'] as int?,
    );
  }

  Future<ClienteModel> actualizar(String id, Map<String, dynamic> data) async {
    final response = await _api.actualizar(id, data);
    return ClienteModel.fromJson(response.data);
  }

  Future<void> eliminar(String id) => _api.eliminar(id);

  Future<ClienteCuentaCorrienteModel> cuentaCorriente(String id) async {
    final response = await _api.cuentaCorriente(id);
    return ClienteCuentaCorrienteModel.fromJson(response.data);
  }

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
