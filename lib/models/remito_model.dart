import 'remito_item_model.dart';

class RemitoModel {
  const RemitoModel({
    required this.id,
    required this.numero,
    required this.total,
    required this.estado,
    this.createdAt,
    this.subtotal,
    this.descuento,
    this.clienteNombre,
    this.vendedorNombre,
    this.ventaId,
    this.motivoAnulacion,
    this.anuladoAt,
    this.items,
  });

  final String id;
  final int numero;

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final String estado;
  final DateTime? createdAt;

  // Solo vienen completos en el detalle (GET /remitos/{id}).
  final int? subtotal;
  final int? descuento;
  final String? clienteNombre;
  final String? vendedorNombre;
  final String? ventaId;
  final String? motivoAnulacion;
  final DateTime? anuladoAt;
  final List<RemitoItemModel>? items;

  double get totalPesos => total / 100;
  bool get estaVigente => estado == 'vigente';
  bool get estaAnulado => estado == 'anulado';
  bool get estaConvertido => estado == 'convertido';

  factory RemitoModel.fromJson(Map<String, dynamic> json) {
    return RemitoModel(
      id: json['id'] as String,
      numero: json['numero'] as int,
      total: json['total'] as int,
      estado: json['estado'] as String? ?? 'vigente',
      createdAt:
          json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      subtotal: json['subtotal'] as int?,
      descuento: json['descuento'] as int?,
      clienteNombre: json['cliente']?['nombre'] as String?,
      vendedorNombre: json['vendedor']?['name'] as String?,
      ventaId: json['venta_id'] as String?,
      motivoAnulacion: json['motivo_anulacion'] as String?,
      anuladoAt:
          json['anulado_at'] == null ? null : DateTime.parse(json['anulado_at'] as String),
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((i) => RemitoItemModel.fromJson(i)).toList(),
    );
  }
}
