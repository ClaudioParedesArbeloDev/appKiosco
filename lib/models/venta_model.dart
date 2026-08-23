import 'venta_item_model.dart';

class VentaModel {
  const VentaModel({
    required this.id,
    required this.numero,
    required this.total,
    required this.formaPago,
    required this.tipoComprobante,
    required this.estado,
    this.createdAt,
    this.subtotal,
    this.descuento,
    this.vendedorNombre,
    this.clienteNombre,
    this.motivoAnulacion,
    this.anuladaAt,
    this.items,
    this.pendienteSync = false,
  });

  final String id;

  /// Null mientras la venta está pendiente de sincronizar (se hizo sin
  /// conexión) — el número secuencial real lo asigna siempre el server, no
  /// se genera offline para no arriesgar colisión entre dispositivos.
  final int? numero;

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final String formaPago;
  final String tipoComprobante;
  final String estado;
  final DateTime? createdAt;

  // Estos solo vienen completos en el detalle (GET /ventas/{id}), no en el
  // listado — por eso son nullable acá.
  final int? subtotal;
  final int? descuento;
  final String? vendedorNombre;
  final String? clienteNombre;
  final String? motivoAnulacion;
  final DateTime? anuladaAt;
  final List<VentaItemModel>? items;

  /// true = todavía no llegó al server, se creó offline y está en la cola
  /// de sincronización. Nunca viene del JSON del server (que solo devuelve
  /// ventas ya confirmadas) — default false.
  final bool pendienteSync;

  double get totalPesos => total / 100;
  double? get subtotalPesos => subtotal == null ? null : subtotal! / 100;
  double? get descuentoPesos => descuento == null ? null : descuento! / 100;
  bool get estaAnulada => estado == 'anulada';

  factory VentaModel.fromJson(Map<String, dynamic> json) {
    return VentaModel(
      id: json['id'] as String,
      numero: json['numero'] as int,
      total: json['total'] as int,
      formaPago: json['forma_pago'] as String,
      tipoComprobante: json['tipo_comprobante'] as String,
      estado: json['estado'] as String? ?? 'completada',
      createdAt:
          json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      subtotal: json['subtotal'] as int?,
      descuento: json['descuento'] as int?,
      vendedorNombre: json['vendedor']?['name'] as String?,
      clienteNombre: json['cliente']?['nombre'] as String?,
      motivoAnulacion: json['motivo_anulacion'] as String?,
      anuladaAt:
          json['anulada_at'] == null ? null : DateTime.parse(json['anulada_at'] as String),
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((i) => VentaItemModel.fromJson(i)).toList(),
    );
  }
}
