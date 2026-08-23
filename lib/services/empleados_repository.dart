import '../models/comision_empleado_model.dart';
import '../models/empleado_model.dart';
import 'empleados_api_service.dart';

class EmpleadosRepository {
  EmpleadosRepository(this._api);

  final EmpleadosApiService _api;

  Future<List<EmpleadoModel>> listar() async {
    final response = await _api.listar();
    return (response.data as List).map((e) => EmpleadoModel.fromJson(e)).toList();
  }

  Future<EmpleadoModel> crear({
    required String name,
    required String email,
    required String password,
    required String role,
    int? comisionPorcentaje,
  }) async {
    final response = await _api.crear({
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'comision_porcentaje': comisionPorcentaje,
    });
    return EmpleadoModel.fromJson(response.data);
  }

  Future<EmpleadoModel> cambiarRole(String id, String role) async {
    final response = await _api.actualizar(id, {'role': role});
    return EmpleadoModel.fromJson(response.data);
  }

  Future<EmpleadoModel> cambiarEstado(String id, String status) async {
    final response = await _api.actualizar(id, {'status': status});
    return EmpleadoModel.fromJson(response.data);
  }

  Future<EmpleadoModel> cambiarComision(String id, int? comisionPorcentaje) async {
    final response = await _api.actualizar(id, {'comision_porcentaje': comisionPorcentaje});
    return EmpleadoModel.fromJson(response.data);
  }

  Future<ComisionesReporteModel> comisiones({DateTime? desde, DateTime? hasta}) async {
    final response = await _api.comisiones(desde: desde, hasta: hasta);
    return ComisionesReporteModel.fromJson(response.data);
  }
}
