import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Pantalla de cámara reusable para leer códigos (de barras o QR). No hace
/// pop solo — llama a [onDetect] por cada código nuevo y sigue escaneando,
/// así sirve tanto para una lectura única (el que llama decide cuándo
/// cortar) como para escaneo continuo.
///
/// [cooldown] evita mandar el mismo código repetido mientras queda
/// encuadrado en cámara (mobile_scanner detecta varias veces por segundo).
class BarcodeScannerCore extends StatefulWidget {
  const BarcodeScannerCore({
    super.key,
    required this.onDetect,
    this.title = 'Escanear código',
    this.cooldown = const Duration(seconds: 2),
  });

  final ValueChanged<String> onDetect;
  final String title;
  final Duration cooldown;

  @override
  State<BarcodeScannerCore> createState() => _BarcodeScannerCoreState();
}

class _BarcodeScannerCoreState extends State<BarcodeScannerCore> {
  final _controller = MobileScannerController();
  String? _ultimoCodigo;
  DateTime? _ultimaDeteccion;

  void _onDetect(BarcodeCapture capture) {
    final codigo = capture.barcodes.firstOrNull?.rawValue;
    if (codigo == null || codigo.isEmpty) return;

    final ahora = DateTime.now();
    final esRepetidoReciente = codigo == _ultimoCodigo &&
        _ultimaDeteccion != null &&
        ahora.difference(_ultimaDeteccion!) < widget.cooldown;

    if (esRepetidoReciente) return;

    _ultimoCodigo = codigo;
    _ultimaDeteccion = ahora;
    widget.onDetect(codigo);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(controller: _controller, onDetect: _onDetect),
    );
  }
}

extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
