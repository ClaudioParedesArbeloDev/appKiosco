import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../core/offline/app_database.dart';
import '../core/offline/offline_queue.dart';
import '../models/articulo_model.dart';
import '../models/movimiento_stock_model.dart';
import '../models/paginated_response.dart';
import '../models/producto_lookup_result.dart';
import 'articulos_api_service.dart';

class ArticulosRepository {
  ArticulosRepository(this._api, this._db);

  final ArticulosApiService _api;
  final AppDatabase _db;

  /// El POS busca acá para armar el carrito — sin esto, "vender offline"
  /// no serviría de nada porque el cajero no podría encontrar qué vender.
  /// Sin conexión, cae al catálogo cacheado localmente (`LocalArticulos`,
  /// que se llena en cada sync exitoso — ver `SyncService._pullArticulos`).
  Future<PaginatedResponse<ArticuloModel>> listar({
    String? search,
    String? rubro,
    bool? activo,
  }) async {
    try {
      final response = await _api.listar(search: search, rubro: rubro, activo: activo);
      return PaginatedResponse.fromJson(response.data, ArticuloModel.fromJson);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _listarOffline(search: search, rubro: rubro, activo: activo);
    }
  }

  Future<PaginatedResponse<ArticuloModel>> _listarOffline({
    String? search,
    String? rubro,
    bool? activo,
  }) async {
    final query = _db.select(_db.localArticulos);

    if (activo != null) {
      query.where((t) => t.activo.equals(activo));
    }
    if (rubro != null && rubro.isNotEmpty) {
      query.where((t) => t.rubro.equals(rubro));
    }
    if (search != null && search.trim().isNotEmpty) {
      final termino = '%${search.trim()}%';
      query.where(
        (t) =>
            t.descripcion.like(termino) |
            t.codigoBarras.like(termino) |
            t.codigoInterno.like(termino),
      );
    }

    final filas = await query.get();
    final modelos = filas.map(_articuloModelFromLocal).toList();

    return PaginatedResponse(
      data: modelos,
      currentPage: 1,
      lastPage: 1,
      total: modelos.length,
    );
  }

  ArticuloModel _articuloModelFromLocal(LocalArticulo fila) {
    final hoy = DateTime.now();
    final promocionVigente = fila.precioPromocional != null &&
        (fila.promocionDesde == null || !hoy.isBefore(fila.promocionDesde!)) &&
        (fila.promocionHasta == null || !hoy.isAfter(fila.promocionHasta!));

    return ArticuloModel(
      id: fila.id,
      descripcion: fila.descripcion,
      codigoBarras: fila.codigoBarras,
      codigoInterno: fila.codigoInterno,
      marca: fila.marca,
      rubro: fila.rubro,
      imagenUrl: fila.imagenUrl,
      precioCosto: fila.precioCosto,
      precioVenta: fila.precioVenta,
      precioPromocional: fila.precioPromocional,
      promocionDesde: fila.promocionDesde,
      promocionHasta: fila.promocionHasta,
      activo: fila.activo,
      stockActual: fila.stockActual,
      precioVigente: promocionVigente ? fila.precioPromocional : fila.precioVenta,
      promocionVigente: promocionVigente,
    );
  }

  Future<ArticuloModel> ver(String id) async {
    final response = await _api.ver(id);
    return ArticuloModel.fromJson(response.data);
  }

  Future<List<MovimientoStockModel>> movimientos(String id) async {
    final response = await _api.movimientos(id);
    return (response.data['data'] as List)
        .map((e) => MovimientoStockModel.fromJson(e))
        .toList();
  }

  Future<ArticuloModel> crear(Map<String, dynamic> data) async {
    final response = await _api.crear(data);
    return ArticuloModel.fromJson(response.data);
  }

  Future<ArticuloModel> actualizar(String id, Map<String, dynamic> data) async {
    final response = await _api.actualizar(id, data);
    return ArticuloModel.fromJson(response.data);
  }

  Future<void> eliminar(String id) => _api.eliminar(id);

  Future<void> ajustarStock(String id, int cantidad, String nota) =>
      _api.ajustarStock(id, cantidad, nota);


  Future<ProductoLookupResult?> buscarPorCodigo(String codigo) async {
    try {
      final response = await _api.buscarPorCodigo(codigo);
      return ProductoLookupResult.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<List<int>> exportar() async {
    final response = await _api.exportar();
    return response.data ?? [];
  }

  Future<({int actualizados, List<String> noEncontrados})> importar(
    List<int> bytes,
    String filename,
  ) async {
    final response = await _api.importar(bytes, filename);
    return (
      actualizados: response.data['actualizados'] as int,
      noEncontrados: (response.data['no_encontrados'] as List).cast<String>(),
    );
  }

  Future<int> actualizarPreciosMasivo({
    String? marca,
    String? rubro,
    required String campo,
    required String tipo,
    required int valor,
  }) async {
    final response = await _api.actualizarPreciosMasivo({
      'marca': marca,
      'rubro': rubro,
      'campo': campo,
      'tipo': tipo,
      'valor': valor,
    });
    return response.data['actualizados'] as int;
  }
}
