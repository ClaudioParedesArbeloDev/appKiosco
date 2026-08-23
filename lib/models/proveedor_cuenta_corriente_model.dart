import 'cuenta_corriente_movimiento_model.dart';
import 'paginated_response.dart';

class ProveedorCuentaCorrienteModel {
  const ProveedorCuentaCorrienteModel({required this.saldo, required this.movimientos});

  /// En centavos. Positivo = le debemos al proveedor.
  final int saldo;
  final PaginatedResponse<CuentaCorrienteMovimientoModel> movimientos;

  double get saldoPesos => saldo / 100;

  factory ProveedorCuentaCorrienteModel.fromJson(Map<String, dynamic> json) {
    return ProveedorCuentaCorrienteModel(
      saldo: json['saldo'] as int,
      movimientos: PaginatedResponse.fromJson(
        json['movimientos'],
        CuentaCorrienteMovimientoModel.fromJson,
      ),
    );
  }
}
