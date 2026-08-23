import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/cliente_model.dart';
import '../../../providers/clientes_providers.dart';

/// Cliente opcional para asociar a la venta. Sin selección queda como
/// "Consumidor final" (cliente_id null) — el comportamiento de siempre.
class ClienteSelectorField extends ConsumerWidget {
  const ClienteSelectorField({super.key, required this.cliente, required this.onChanged});

  final ClienteModel? cliente;
  final ValueChanged<ClienteModel?> onChanged;

  void _elegir(BuildContext context) {
    showDialog<void>(
      context: context,
      // onSeleccionar hace el pop y avisa al padre en el mismo paso —
      // así "Consumidor final" (null) y "Cancelar" (no hacer nada) no se
      // confunden compartiendo el mismo valor de retorno del showDialog.
      builder: (_) => _ClienteBuscadorDialog(onSeleccionar: onChanged),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _elegir(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Cliente',
          border: const OutlineInputBorder(),
          suffixIcon: cliente == null
              ? const Icon(Icons.search)
              : IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Quitar cliente',
                  onPressed: () => onChanged(null),
                ),
        ),
        child: Text(
          cliente?.nombre ?? 'Consumidor final',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _ClienteBuscadorDialog extends ConsumerStatefulWidget {
  const _ClienteBuscadorDialog({required this.onSeleccionar});

  final ValueChanged<ClienteModel?> onSeleccionar;

  @override
  ConsumerState<_ClienteBuscadorDialog> createState() => _ClienteBuscadorDialogState();
}

class _ClienteBuscadorDialogState extends ConsumerState<_ClienteBuscadorDialog> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<ClienteModel> _resultados = [];
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
      final resultado = await ref.read(clientesRepositoryProvider).listar(search: query);
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
      title: const Text('Elegir cliente'),
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
                hintText: 'Buscar por nombre o DNI/CUIT...',
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
                        final cliente = _resultados[index];
                        return ListTile(
                          title: Text(cliente.nombre),
                          subtitle: cliente.dniCuit == null ? null : Text(cliente.dniCuit!),
                          onTap: () {
                            widget.onSeleccionar(cliente);
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
        TextButton(
          onPressed: () async {
            final nuevo = await showDialog<ClienteModel>(
              context: context,
              builder: (_) => const _NuevoClienteDialog(),
            );
            if (nuevo != null && context.mounted) {
              widget.onSeleccionar(nuevo);
              Navigator.of(context).pop();
            }
          },
          child: const Text('+ Nuevo cliente'),
        ),
        TextButton(
          onPressed: () {
            widget.onSeleccionar(null);
            Navigator.of(context).pop();
          },
          child: const Text('Consumidor final'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

/// Alta mínima de cliente desde el POS, sin salir de la venta — funciona
/// también sin conexión (ver `ClientesRepository.crear`, que cae a modo
/// offline solo). Pide lo justo para poder facturarle/contactarlo después;
/// el resto de los datos se completan más tarde desde la ficha completa.
class _NuevoClienteDialog extends ConsumerStatefulWidget {
  const _NuevoClienteDialog();

  @override
  ConsumerState<_NuevoClienteDialog> createState() => _NuevoClienteDialogState();
}

class _NuevoClienteDialogState extends ConsumerState<_NuevoClienteDialog> {
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  bool _guardando = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final nombre = _nombreController.text.trim();
    if (nombre.isEmpty) return;

    setState(() => _guardando = true);
    try {
      final cliente = await ref.read(clientesRepositoryProvider).crear({
        'nombre': nombre,
        'condicion_iva': 'consumidor_final',
        'telefono': ?(_telefonoController.text.trim().isEmpty ? null : _telefonoController.text.trim()),
      });
      if (mounted) Navigator.of(context).pop(cliente);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No pudimos crear el cliente: $e')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo cliente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _telefonoController,
            keyboardType: TextInputType.phone,
            decoration:
                const InputDecoration(labelText: 'Teléfono (opcional)', border: OutlineInputBorder()),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _guardando ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _guardando ? null : _guardar,
          child: _guardando
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Guardar'),
        ),
      ],
    );
  }
}
