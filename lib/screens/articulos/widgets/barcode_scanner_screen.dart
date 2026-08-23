import 'package:flutter/material.dart';
import '../../../core/widgets/barcode_scanner_core.dart';

/// Pantalla de cámara para escanear un código de barras una sola vez.
/// Devuelve el código escaneado con `Navigator.pop`, o null si el usuario cancela.
class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  bool _devuelto = false;

  void _onDetect(String codigo) {
    if (_devuelto) return;
    _devuelto = true;
    Navigator.of(context).pop(codigo);
  }

  @override
  Widget build(BuildContext context) {
    return BarcodeScannerCore(
      title: 'Escanear código de barras',
      onDetect: _onDetect,
    );
  }
}
