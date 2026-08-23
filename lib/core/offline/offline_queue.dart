import 'dart:convert';
import 'package:dio/dio.dart';
import 'app_database.dart';

/// `Dio` tira `DioException` tanto por falta de conexión como por un error
/// real del servidor (422, 500) — la diferencia es si llegó a haber
/// respuesta. Mismo patrón ya usado en login_screen/select_business_screen,
/// centralizado acá para no repetirlo en cada repository.
bool esErrorDeConexion(Object error) => error is DioException && error.response == null;

/// Encola una operación de negocio (abrir/cerrar caja, movimiento, crear
/// venta, crear cliente) para reproducirla contra el endpoint real cuando
/// vuelva la conexión — ver `SyncService._reproducirOperacionesPendientes`.
/// No es una fila a insertar: es la misma llamada de siempre, diferida, para
/// que el server ejecute toda su lógica de negocio (precio, descuento,
/// numeración, límite de plan) tal cual lo haría online.
Future<void> encolarOperacion(
  AppDatabase db, {
  required String tipoOperacion,
  required String entidadLocalId,
  required Map<String, dynamic> payload,
  required DateTime ocurridaEn,
}) async {
  await db.into(db.operacionesPendientes).insert(
        OperacionesPendientesCompanion.insert(
          tipoOperacion: tipoOperacion,
          entidadLocalId: entidadLocalId,
          payload: jsonEncode(payload),
          ocurridaEn: ocurridaEn,
        ),
      );
}
