import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/proveedor_model.dart';
import '../../../providers/proveedores_providers.dart';

/// Proveedor de la compra — a diferencia del cliente en una venta, acá es
/// obligatorio (no existe un "proveedor genérico").
class ProveedorSelectorField extends ConsumerWidget {
  const ProveedorSelectorField({super.key, required this.proveedor, required this.onChanged});

  final ProveedorModel? proveedor;
  final ValueChanged<ProveedorModel> onChanged;

  void _elegir(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => _ProveedorBuscadorDialog(onSeleccionar: onChanged),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _elegir(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Proveedor',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
        child: Text(
          proveedor?.nombre ?? 'Elegí un proveedor',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _ProveedorBuscadorDialog extends ConsumerStatefulWidget {
  const _ProveedorBuscadorDialog({required this.onSeleccionar});

  final ValueChanged<ProveedorModel> onSeleccionar;

  @override
  ConsumerState<_ProveedorBuscadorDialog> createState() => _ProveedorBuscadorDialogState();
}

class _ProveedorBuscadorDialogState extends ConsumerState<_ProveedorBuscadorDialog> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<ProveedorModel> _resultados = [];
  bool _buscando = false;

  void _onChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      setState(() => _resultados = []);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 350), () => _buscar(query));
  }

  Future<void> _buscar(String query) async {
    setState(() => _buscando = true);

    try {
      final resultado = await ref.read(proveedoresRepositoryProvider).listar(search: query);
      if (!mounted) return;
      setState(() => _resultados = resultado.data);
    } finally {
      if (mounted) setState(() => _buscando = false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Elegir proveedor'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _buscando
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 280,
              child: _resultados.isEmpty
                  ? const Center(child: Text('Buscá para ver resultados'))
                  : ListView.separated(
                      itemCount: _resultados.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final proveedor = _resultados[index];
                        return ListTile(
                          title: Text(proveedor.nombre),
                          subtitle: proveedor.cuit == null ? null : Text(proveedor.cuit!),
                          onTap: () {
                            widget.onSeleccionar(proveedor);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
      ],
    );
  }
}
