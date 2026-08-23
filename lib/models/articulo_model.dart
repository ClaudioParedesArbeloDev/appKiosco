class ArticuloModel {
  const ArticuloModel({
    required this.id,
    required this.descripcion,
    required this.precioCosto,
    required this.precioVenta,
    required this.activo,
    this.codigoBarras,
    this.codigoInterno,
    this.marca,
    this.rubro,
    this.imagenUrl,
    this.precioPromocional,
    this.promocionDesde,
    this.promocionHasta,
    this.stockActual,
    int? precioVigente,
    bool? promocionVigente,
  })  : precioVigente = precioVigente ?? precioVenta,
        promocionVigente = promocionVigente ?? false;

  final String id;
  final String descripcion;
  final String? codigoBarras;
  final String? codigoInterno;
  final String? marca;
  final String? rubro;
  final String? imagenUrl;
  final int precioCosto;
  final int precioVenta;
  final int? precioPromocional;
  final DateTime? promocionDesde;
  final DateTime? promocionHasta;
  final bool activo;
  final int? stockActual;

  /// Precio que corresponde cobrar hoy: viene ya calculado por el backend
  /// (el promocional si está vigente, si no el de venta normal).
  final int precioVigente;
  final bool promocionVigente;

  factory ArticuloModel.fromJson(Map<String, dynamic> json) {
    return ArticuloModel(
      id: json['id'] as String,
      descripcion: json['descripcion'] as String,
      codigoBarras: json['codigo_barras'] as String?,
      codigoInterno: json['codigo_interno'] as String?,
      marca: json['marca'] as String?,
      rubro: json['rubro'] as String?,
      imagenUrl: json['imagen_url'] as String?,
      precioCosto: json['precio_costo'] as int,
      precioVenta: json['precio_venta'] as int,
      precioPromocional: json['precio_promocional'] == null
          ? null
          : (json['precio_promocional'] as num).toInt(),
      promocionDesde: json['promocion_desde'] == null
          ? null
          : DateTime.parse(json['promocion_desde'] as String),
      promocionHasta: json['promocion_hasta'] == null
          ? null
          : DateTime.parse(json['promocion_hasta'] as String),
      activo: json['activo'] as bool? ?? true,
      stockActual: json['stock_actual'] == null
          ? null
          : (json['stock_actual'] as num).toInt(),
      precioVigente: json['precio_vigente'] == null
          ? null
          : (json['precio_vigente'] as num).toInt(),
      promocionVigente: json['promocion_vigente'] as bool?,
    );
  }

  double get precioCostoPesos => precioCosto / 100;
  double get precioVentaPesos => precioVenta / 100;
  double get precioPromocionalPesos =>
      (precioPromocional ?? precioVenta) / 100;
  double get precioVigentePesos => precioVigente / 100;
}
