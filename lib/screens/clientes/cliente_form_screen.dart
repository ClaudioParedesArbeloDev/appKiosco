import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/clientes_controller.dart';
import '../../models/cliente_model.dart';
import '../../providers/clientes_providers.dart';

class ClienteFormScreen extends ConsumerStatefulWidget {
  const ClienteFormScreen({super.key, this.cliente});

  /// Si viene null, es alta. Si viene con datos, es edición.
  final ClienteModel? cliente;

  @override
  ConsumerState<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends ConsumerState<ClienteFormScreen> {
  late final _nombreController = TextEditingController(text: widget.cliente?.nombre);
  late final _dniCuitController = TextEditingController(text: widget.cliente?.dniCuit);
  late final _direccionController = TextEditingController(text: widget.cliente?.direccion);
  late final _telefonoController = TextEditingController(text: widget.cliente?.telefono);
  late final _emailController = TextEditingController(text: widget.cliente?.email);
  late final _zonaController = TextEditingController(text: widget.cliente?.zona);
  late final _descuentoController = TextEditingController(
    text: widget.cliente != null && widget.cliente!.porcentajeDescuento > 0
        ? widget.cliente!.porcentajeDescuento.toString()
        : '',
  );
  late final _limiteCtaCteController = TextEditingController(
    text: widget.cliente?.limiteCuentaCorrientePesos?.toStringAsFixed(2) ?? '',
  );

  late String _condicionIva = widget.cliente?.condicionIva ?? 'consumidor_final';
  late bool _activo = widget.cliente?.activo ?? true;

  bool _guardando = false;

  bool get _esEdicion => widget.cliente != null;

  @override
  void dispose() {
    _nombreController.dispose();
    _dniCuitController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _zonaController.dispose();
    _descuentoController.dispose();
    _limiteCtaCteController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (_nombreController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('El nombre es obligatorio')));
      return;
    }

    setState(() => _guardando = true);

    final data = {
      'nombre': _nombreController.text.trim(),
      if (_dniCuitController.text.trim().isNotEmpty) 'dni_cuit': _dniCuitController.text.trim(),
      'condicion_iva': _condicionIva,
      if (_direccionController.text.trim().isNotEmpty)
        'direccion': _direccionController.text.trim(),
      if (_telefonoController.text.trim().isNotEmpty)
        'telefono': _telefonoController.text.trim(),
      if (_emailController.text.trim().isNotEmpty) 'email': _emailController.text.trim(),
      if (_zonaController.text.trim().isNotEmpty) 'zona': _zonaController.text.trim(),
      'porcentaje_descuento': int.tryParse(_descuentoController.text.trim()) ?? 0,
      'limite_cuenta_corriente': _limiteCtaCteController.text.trim().isEmpty
          ? null
          : ((double.tryParse(_limiteCtaCteController.text.trim().replaceAll(',', '.')) ?? 0) *
                  100)
              .round(),
      if (_esEdicion) 'activo': _activo,
    };

    try {
      final repository = ref.read(clientesRepositoryProvider);

      if (_esEdicion) {
        await repository.actualizar(widget.cliente!.id, data);
        ref.invalidate(clienteDetailProvider(widget.cliente!.id));
      } else {
        await repository.crear(data);
      }

      ref.invalidate(clientesListProvider);

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar cliente' : 'Nuevo cliente')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dniCuitController,
            decoration:
                const InputDecoration(labelText: 'DNI/CUIT', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _condicionIva,
            decoration:
                const InputDecoration(labelText: 'Condición IVA', border: OutlineInputBorder()),
            items: condicionesIva.entries
                .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _condicionIva = value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _direccionController,
            decoration:
                const InputDecoration(labelText: 'Dirección', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _telefonoController,
            keyboardType: TextInputType.phone,
            decoration:
                const InputDecoration(labelText: 'Teléfono', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _zonaController,
            decoration: const InputDecoration(labelText: 'Zona', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descuentoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Descuento (%)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _limiteCtaCteController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Límite de cuenta corriente',
              hintText: 'Vacío = sin límite',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
          ),
          if (_esEdicion) ...[
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Activo'),
              value: _activo,
              onChanged: (value) => setState(() => _activo = value),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _guardando ? null : _guardar,
            child: _guardando
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
