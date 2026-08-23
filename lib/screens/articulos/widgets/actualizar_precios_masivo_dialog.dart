import 'package:flutter/material.dart';

/// Pide los datos para actualizar precios de varios artículos a la vez.
/// Devuelve el filtro + la variación con `Navigator.pop`, o null si se
/// cancela. Sin marca/rubro = aplica a todo el catálogo.
class ActualizarPreciosMasivoDialog extends StatefulWidget {
  const ActualizarPreciosMasivoDialog({super.key});

  @override
  State<ActualizarPreciosMasivoDialog> createState() =>
      _ActualizarPreciosMasivoDialogState();
}

class _ActualizarPreciosMasivoDialogState extends State<ActualizarPreciosMasivoDialog> {
  final _marcaController = TextEditingController();
  final _rubroController = TextEditingController();
  final _valorController = TextEditingController();

  String _campo = 'precio_venta';
  String _tipo = 'porcentaje';

  @override
  void dispose() {
    _marcaController.dispose();
    _rubroController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final valor = int.tryParse(_valorController.text.trim());
    if (valor == null || valor == 0) return;

    Navigator.of(context).pop((
      marca: _marcaController.text.trim().isEmpty ? null : _marcaController.text.trim(),
      rubro: _rubroController.text.trim().isEmpty ? null : _rubroController.text.trim(),
      campo: _campo,
      tipo: _tipo,
      valor: valor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualizar precios masivo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sin marca ni rubro se aplica a todo el catálogo.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _rubroController,
              decoration: const InputDecoration(
                labelText: 'Rubro (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _campo,
              decoration: const InputDecoration(labelText: 'Campo', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'precio_venta', child: Text('Precio de venta')),
                DropdownMenuItem(value: 'precio_costo', child: Text('Precio de costo')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _campo = value);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _tipo,
              decoration: const InputDecoration(labelText: 'Tipo', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'porcentaje', child: Text('Porcentaje (%)')),
                DropdownMenuItem(value: 'monto', child: Text('Monto fijo (\$)')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _tipo = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _valorController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                labelText: 'Valor',
                hintText: 'Ej: 10 para +10%, -10 para -10%',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Aplicar')),
      ],
    );
  }
}
