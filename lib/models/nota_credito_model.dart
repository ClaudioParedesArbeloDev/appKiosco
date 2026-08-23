import 'nota_credito_item_model.dart';

class NotaCreditoModel {
  const NotaCreditoModel({
    required this.id,
    required this.numero,
    required this.total,
    required this.motivo,
    this.createdAt,
    this.subtotal,
    this.clienteNombre,
    this.vendedorNombre,
    this.ventaNumero,
    this.items,
  });

  final String id;
  final int numero;

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final String motivo;
  final DateTime? createdAt;

  final int? subtotal;
  final String? clienteNombre;
  final String? vendedorNombre;
  final int? ventaNumero;
  final List<NotaCreditoItemModel>? items;

  double get totalPesos => total / 100;

  factory NotaCreditoModel.fromJson(Map<String, dynamic> json) {
    return NotaCreditoModel(
      id: json['id'] as String,
      numero: json['numero'] as int,
      total: json['total'] as int,
      motivo: json['motivo'] as String,
      createdAt:
          json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      subtotal: json['subtotal'] as int?,
      clienteNombre: json['cliente']?['nombre'] as String?,
      vendedorNombre: json['vendedor']?['name'] as String?,
      ventaNumero: json['venta']?['numero'] as int?,
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((i) => NotaCreditoItemModel.fromJson(i)).toList(),
    );
  }
}
