import '../../models/venta_model.dart';
import 'fiscal_printer_driver.dart';

/// Placeholder para una marca sin driver implementado — separado de "no
/// hay impresora configurada" para poder mostrarle al usuario un mensaje
/// distinto en cada caso.
class _SinImplementar implements FiscalPrinterDriver {
  const _SinImplementar(this.marca);

  final String marca;

  @override
  Future<void> imprimirTicket(VentaModel venta, FiscalPrinterConfig config) async {
    throw FiscalPrinterNoImplementadoException(marca);
  }
}

/// Marcas que el comercio puede elegir en la configuración. Se mantiene
/// separado del registro de drivers reales para que la lista de opciones
/// en el formulario no dependa de qué ya está implementado.
const marcasImpresoraFiscalDisponibles = {
  'hasar': 'Hasar',
  'epson': 'Epson',
  'custom': 'Custom',
};

/// Devuelve el driver para una marca, o el placeholder "no implementado"
/// si todavía no se construyó ninguno real (hoy: ninguna).
FiscalPrinterDriver driverParaMarca(String marca) {
  return _SinImplementar(marcasImpresoraFiscalDisponibles[marca] ?? marca);
}
