import 'articulo_model.dart';

/// Resultado de `GET /articulos/buscar-codigo/{codigo}`. El backend hace una
/// cascada: primero busca en los artículos del propio comercio, después en
/// el catálogo global cacheado, y por último en Open Food Facts.
class ProductoLookupResult {
  const ProductoLookupResult({
    required this.origen,
    this.articulo,
    this.sugerenciaDescripcion,
    this.sugerenciaMarca,
    this.sugerenciaImagenUrl,
  });

  /// 'comercio' | 'catalogo' | 'openfoodfacts'
  final String origen;

  /// Solo viene cuando `origen == 'comercio'`: el comercio ya tiene un
  /// artículo cargado con este código de barras.
  final ArticuloModel? articulo;

  final String? sugerenciaDescripcion;
  final String? sugerenciaMarca;
  final String? sugerenciaImagenUrl;

  bool get esArticuloPropio => origen == 'comercio' && articulo != null;

  factory ProductoLookupResult.fromJson(Map<String, dynamic> json) {
    final origen = json['origen'] as String;

    if (origen == 'comercio') {
      return ProductoLookupResult(
        origen: origen,
        articulo: ArticuloModel.fromJson(json['articulo'] as Map<String, dynamic>),
      );
    }

    final sugerencia = json['sugerencia'] as Map<String, dynamic>;

    return ProductoLookupResult(
      origen: origen,
      sugerenciaDescripcion: sugerencia['descripcion'] as String?,
      sugerenciaMarca: sugerencia['marca'] as String?,
      sugerenciaImagenUrl: sugerencia['imagen_url'] as String?,
    );
  }
}
