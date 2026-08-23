import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/validation_errors.dart';
import '../../providers/empleados_providers.dart';

class EmpleadoFormScreen extends ConsumerStatefulWidget {
  const EmpleadoFormScreen({super.key});

  @override
  ConsumerState<EmpleadoFormScreen> createState() => _EmpleadoFormScreenState();
}

class _EmpleadoFormScreenState extends ConsumerState<EmpleadoFormScreen> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comisionController = TextEditingController();

  String _role = 'cajero';
  bool _guardando = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _comisionController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (_nombreController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Completá nombre, email y una contraseña de al menos 6 caracteres'),
      ));
      return;
    }

    setState(() => _guardando = true);

    try {
      await ref.read(empleadosRepositoryProvider).crear(
            name: _nombreController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            role: _role,
            comisionPorcentaje: int.tryParse(_comisionController.text.trim()),
          );

      ref.invalidate(empleadosListProvider);

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo guardar: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo empleado')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña temporal',
              helperText: 'El empleado va a poder cambiarla después desde su Perfil',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _role,
            decoration: const InputDecoration(labelText: 'Rol', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'cajero', child: Text('Empleado')),
              DropdownMenuItem(value: 'admin_comercio', child: Text('Administrador')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _role = value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _comisionController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Comisión sobre sus ventas (%)',
              hintText: 'Vacío = sin comisión',
              border: OutlineInputBorder(),
            ),
          ),
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
