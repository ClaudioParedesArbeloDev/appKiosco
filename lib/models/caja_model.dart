import 'caja_resumen_model.dart';

class CajaModel {
  const CajaModel({
    required this.id,
    required this.montoInicial,
    required this.estado,
    this.montoFinalDeclarado,
    this.montoFinalCalculado,
    this.diferencia,
    this.cerradaAt,
    this.usuarioNombre,
    this.nombreDispositivo,
    this.resumen,
    this.pendienteSync = false,
  });

  final String id;
  final int montoInicial;
  final int? montoFinalDeclarado;
  final int? montoFinalCalculado;
  final int? diferencia;

  /// 'abierta' | 'cerrada'
  final String estado;
  final DateTime? cerradaAt;
  final String? usuarioNombre;

  /// Nombre que el mostrador/PC le puso a su caja (ej. "Mostrador 1") —
  /// cada dispositivo tiene la suya, independiente de las demás.
  final String? nombreDispositivo;

  /// Solo viene en `GET /caja/actual` y en la respuesta de `POST /caja/cerrar`.
  final CajaResumenModel? resumen;

  /// true = se abrió/cerró offline y está en la cola de sincronización.
  /// Nunca viene del JSON del server — default false.
  final bool pendienteSync;

  bool get estaAbierta => estado == 'abierta';

  double get montoInicialPesos => montoInicial / 100;
  double get montoFinalDeclaradoPesos => (montoFinalDeclarado ?? 0) / 100;
  double get montoFinalCalculadoPesos => (montoFinalCalculado ?? 0) / 100;
  double get diferenciaPesos => (diferencia ?? 0) / 100;

  factory CajaModel.fromJson(Map<String, dynamic> json) {
    return CajaModel(
      id: json['id'] as String,
      montoInicial: json['monto_inicial'] as int,
      montoFinalDeclarado: json['monto_final_declarado'] as int?,
      montoFinalCalculado: json['monto_final_calculado'] as int?,
      diferencia: json['diferencia'] as int?,
      estado: json['estado'] as String,
      cerradaAt: json['cerrada_at'] == null ? null : DateTime.parse(json['cerrada_at'] as String),
      usuarioNombre: (json['usuario'] as Map<String, dynamic>?)?['name'] as String?,
      nombreDispositivo: json['nombre_dispositivo'] as String?,
      resumen: json['resumen'] == null
          ? null
          : CajaResumenModel.fromJson(json['resumen'] as Map<String, dynamic>),
    );
  }
}
