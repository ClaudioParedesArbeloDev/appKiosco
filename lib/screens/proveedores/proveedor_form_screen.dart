import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/proveedores_controller.dart';
import '../../models/proveedor_model.dart';
import '../../providers/proveedores_providers.dart';

class ProveedorFormScreen extends ConsumerStatefulWidget {
  const ProveedorFormScreen({super.key, this.proveedor});

  /// Si viene null, es alta. Si viene con datos, es edición.
  final ProveedorModel? proveedor;

  @override
  ConsumerState<ProveedorFormScreen> createState() => _ProveedorFormScreenState();
}

class _ProveedorFormScreenState extends ConsumerState<ProveedorFormScreen> {
  late final _nombreController = TextEditingController(text: widget.proveedor?.nombre);
  late final _cuitController = TextEditingController(text: widget.proveedor?.cuit);
  late final _contactoController = TextEditingController(text: widget.proveedor?.contacto);
  late final _direccionController = TextEditingController(text: widget.proveedor?.direccion);
  late final _telefonoController = TextEditingController(text: widget.proveedor?.telefono);
  late final _emailController = TextEditingController(text: widget.proveedor?.email);

  late bool _activo = widget.proveedor?.activo ?? true;

  bool _guardando = false;

  bool get _esEdicion => widget.proveedor != null;

  @override
  void dispose() {
    _nombreController.dispose();
    _cuitController.dispose();
    _contactoController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
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
      if (_cuitController.text.trim().isNotEmpty) 'cuit': _cuitController.text.trim(),
      if (_contactoController.text.trim().isNotEmpty) 'contacto': _contactoController.text.trim(),
      if (_direccionController.text.trim().isNotEmpty)
        'direccion': _direccionController.text.trim(),
      if (_telefonoController.text.trim().isNotEmpty)
        'telefono': _telefonoController.text.trim(),
      if (_emailController.text.trim().isNotEmpty) 'email': _emailController.text.trim(),
      if (_esEdicion) 'activo': _activo,
    };

    try {
      final repository = ref.read(proveedoresRepositoryProvider);

      if (_esEdicion) {
        await repository.actualizar(widget.proveedor!.id, data);
        ref.invalidate(proveedorDetailProvider(widget.proveedor!.id));
      } else {
        await repository.crear(data);
      }

      ref.invalidate(proveedoresListProvider);

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
      appBar: AppBar(title: Text(_esEdicion ? 'Editar proveedor' : 'Nuevo proveedor')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cuitController,
            decoration: const InputDecoration(labelText: 'CUIT', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _contactoController,
            decoration:
                const InputDecoration(labelText: 'Contacto', border: OutlineInputBorder()),
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
