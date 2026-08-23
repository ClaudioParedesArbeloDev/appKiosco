import '../../models/venta_model.dart';

/// Config de conexión de la impresora fiscal de un comercio — viene de
/// `UserModel.impresoraFiscal*` (guardado en el tenant).
class FiscalPrinterConfig {
  const FiscalPrinterConfig({required this.puerto, this.baudRate = 9600});

  final String puerto;
  final int baudRate;
}

/// Excepción para cuando la marca configurada no tiene driver real
/// todavía. No es un error de conexión — es que ese trabajo no está hecho.
class FiscalPrinterNoImplementadoException implements Exception {
  const FiscalPrinterNoImplementadoException(this.marca);

  final String marca;

  @override
  String toString() =>
      'Todavía no hay soporte para imprimir en impresoras fiscales $marca. '
      'La venta se registró igual, pero el ticket fiscal hay que emitirlo '
      'por fuera de la app por ahora.';
}

/// Un driver sabe hablarle a UNA marca de impresora fiscal por su puerto
/// serie (COM en Windows, /dev/ttyUSB* en Linux). Cada marca tiene un
/// protocolo de comandos propio y no verificado contra hardware real
/// todavía — ver [[arbelo-backend-architecture]]. Antes de dar por buena
/// una implementación acá hay que probarla contra el equipo físico.
abstract class FiscalPrinterDriver {
  Future<void> imprimirTicket(VentaModel venta, FiscalPrinterConfig config);
}
