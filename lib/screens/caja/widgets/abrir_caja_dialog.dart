import 'package:flutter/material.dart';
import '../../../services/secure_storage_service.dart';

/// Pide el monto inicial (en pesos) y el nombre de este mostrador/PC para
/// abrir una caja nueva — cada dispositivo tiene la suya, independiente de
/// las demás. Devuelve `(montoInicial en centavos, nombreDispositivo)` con
/// `Navigator.pop`, o null si se cancela. El nombre se guarda localmente
/// para no tener que volver a escribirlo la próxima vez.
class AbrirCajaDialog extends StatefulWidget {
  const AbrirCajaDialog({super.key});

  @override
  State<AbrirCajaDialog> createState() => _AbrirCajaDialogState();
}

class _AbrirCajaDialogState extends State<AbrirCajaDialog> {
  final _montoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _cargarNombreGuardado();
  }

  Future<void> _cargarNombreGuardado() async {
    final nombre = await _storage.getDeviceNombre();
    if (mounted && nombre != null) setState(() => _nombreController.text = nombre);
  }

  @override
  void dispose() {
    _montoController.dispose();
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    final monto = double.tryParse(_montoController.text.replaceAll(',', '.'));
    if (monto == null || monto < 0) return;

    final nombre = _nombreController.text.trim();
    if (nombre.isNotEmpty) await _storage.saveDeviceNombre(nombre);

    if (mounted) {
      Navigator.of(context).pop((
        montoInicial: (monto * 100).round(),
        nombreDispositivo: nombre.isEmpty ? null : nombre,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Abrir caja'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre de este mostrador (opcional)',
              hintText: 'Ej: Mostrador 1',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _montoController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Monto inicial',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Abrir')),
      ],
    );
  }
}
