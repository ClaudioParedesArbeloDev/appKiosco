import 'cuenta_corriente_movimiento_model.dart';
import 'paginated_response.dart';

class ClienteCuentaCorrienteModel {
  const ClienteCuentaCorrienteModel({
    required this.saldo,
    required this.movimientos,
    this.limite,
  });

  /// En centavos. Positivo = el cliente debe.
  final int saldo;
  final int? limite;
  final PaginatedResponse<CuentaCorrienteMovimientoModel> movimientos;

  double get saldoPesos => saldo / 100;
  double? get limitePesos => limite == null ? null : limite! / 100;

  bool get superaLimite => limite != null && saldo > limite!;

  factory ClienteCuentaCorrienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteCuentaCorrienteModel(
      saldo: json['saldo'] as int,
      limite: json['limite'] as int?,
      movimientos: PaginatedResponse.fromJson(
        json['movimientos'],
        CuentaCorrienteMovimientoModel.fromJson,
      ),
    );
  }
}
