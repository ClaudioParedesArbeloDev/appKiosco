import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

/// 'rubro' | 'marca' | 'zona' | 'vendedor'
enum TipoReporte { rubro, marca, zona, vendedor }

class ReportesApiService {
  ReportesApiService(this._client);

  final ApiClient _client;

  Future<Response> ventasPor(TipoReporte tipo, {DateTime? desde, DateTime? hasta}) {
    final endpoint = switch (tipo) {
      TipoReporte.rubro => ApiEndpoints.reporteVentasPorRubro,
      TipoReporte.marca => ApiEndpoints.reporteVentasPorMarca,
      TipoReporte.zona => ApiEndpoints.reporteVentasPorZona,
      TipoReporte.vendedor => ApiEndpoints.reporteVentasPorVendedor,
    };

    return _client.dio.get(endpoint, queryParameters: {
      if (desde != null) 'desde': desde.toIso8601String().substring(0, 10),
      if (hasta != null) 'hasta': hasta.toIso8601String().substring(0, 10),
    });
  }
}
