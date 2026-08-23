import 'compra_item_model.dart';

class CompraModel {
  const CompraModel({
    required this.id,
    required this.total,
    required this.formaPago,
    required this.actualizaCosto,
    required this.estado,
    this.createdAt,
    this.numeroFactura,
    this.subtotal,
    this.proveedorNombre,
    this.usuarioNombre,
    this.motivoAnulacion,
    this.anuladaAt,
    this.items,
  });

  final String id;

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final String formaPago;
  final bool actualizaCosto;
  final String estado;
  final DateTime? createdAt;
  final String? numeroFactura;

  // Solo viene completo en el detalle (GET /compras/{id}), no en el listado.
  final int? subtotal;
  final String? proveedorNombre;
  final String? usuarioNombre;
  final String? motivoAnulacion;
  final DateTime? anuladaAt;
  final List<CompraItemModel>? items;

  double get totalPesos => total / 100;
  double? get subtotalPesos => subtotal == null ? null : subtotal! / 100;
  bool get estaAnulada => estado == 'anulada';

  factory CompraModel.fromJson(Map<String, dynamic> json) {
    return CompraModel(
      id: json['id'] as String,
      total: json['total'] as int,
      formaPago: json['forma_pago'] as String,
      actualizaCosto: json['actualiza_costo'] as bool? ?? true,
      estado: json['estado'] as String? ?? 'completada',
      createdAt:
          json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      numeroFactura: json['numero_factura'] as String?,
      subtotal: json['subtotal'] as int?,
      proveedorNombre: json['proveedor']?['nombre'] as String?,
      usuarioNombre: json['usuario']?['name'] as String?,
      motivoAnulacion: json['motivo_anulacion'] as String?,
      anuladaAt:
          json['anulada_at'] == null ? null : DateTime.parse(json['anulada_at'] as String),
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((i) => CompraItemModel.fromJson(i)).toList(),
    );
  }
}
