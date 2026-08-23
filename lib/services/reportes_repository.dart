import '../models/reporte_fila_model.dart';
import 'reportes_api_service.dart';

class ReportesRepository {
  ReportesRepository(this._api);

  final ReportesApiService _api;

  Future<List<ReporteFilaModel>> ventasPor(TipoReporte tipo, {DateTime? desde, DateTime? hasta}) async {
    final response = await _api.ventasPor(tipo, desde: desde, hasta: hasta);
    return (response.data as List).map((f) => ReporteFilaModel.fromJson(f)).toList();
  }
}
