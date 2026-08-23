import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/proveedores_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/proveedores_providers.dart';
import '../clientes/widgets/movimiento_cta_cte_item.dart';
import '../clientes/widgets/pago_cta_cte_dialog.dart';
import '../compras/compra_detail_screen.dart';
import '../compras/widgets/compra_list_item.dart';
import '../login/login_screen.dart';
import 'proveedor_form_screen.dart';

class ProveedorDetailScreen extends ConsumerWidget {
  const ProveedorDetailScreen({super.key, required this.proveedorId});

  final String proveedorId;

  Future<void> _registrarPago(BuildContext context, WidgetRef ref) async {
    final resultado = await showDialog<({int monto, String formaPago, String? nota})>(
      context: context,
      builder: (_) => const PagoCtaCteDialog(),
    );
    if (resultado == null) return;

    try {
      await ref.read(proveedoresRepositoryProvider).registrarPago(
            proveedorId,
            monto: resultado.monto,
            formaPago: resultado.formaPago,
            nota: resultado.nota,
          );
      ref.invalidate(proveedorCuentaCorrienteProvider(proveedorId));
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Pago registrado')));
      }
    } catch (e) {
      if (context.mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo registrar: $mensaje')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proveedorAsync = ref.watch(proveedorDetailProvider(proveedorId));
    final comprasAsync = ref.watch(proveedorComprasProvider(proveedorId));
    final cuentaCorrienteAsync = ref.watch(proveedorCuentaCorrienteProvider(proveedorId));
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_proveedores') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del proveedor'),
        actions: [
          if (puedeEditar)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final proveedor = proveedorAsync.value;
                if (proveedor == null) return;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ProveedorFormScreen(proveedor: proveedor)),
                );
              },
            ),
        ],
      ),
      body: proveedorAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (proveedor) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(proveedor.nombre, style: Theme.of(context).textTheme.headlineSmall),
                ),
                if (!proveedor.activo)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Chip(label: Text('Inactivo')),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (proveedor.cuit != null) Text('CUIT: ${proveedor.cuit}'),
            if (proveedor.contacto != null) Text('Contacto: ${proveedor.contacto}'),
            if (proveedor.direccion != null) Text('Dirección: ${proveedor.direccion}'),
            if (proveedor.telefono != null) Text('Teléfono: ${proveedor.telefono}'),
            if (proveedor.email != null) Text('Email: ${proveedor.email}'),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cuenta corriente', style: Theme.of(context).textTheme.titleMedium),
                if (puedeEditar)
                  TextButton.icon(
                    onPressed: () => _registrarPago(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar pago'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            cuentaCorrienteAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error al cargar cuenta corriente: $error'),
              data: (cuentaCorriente) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo: \$${cuentaCorriente.saldoPesos.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: cuentaCorriente.saldo > 0 ? AppColors.warning : AppColors.success,
                    ),
                  ),
                  if (cuentaCorriente.movimientos.data.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Todavía no tiene movimientos.'),
                    )
                  else
                    Column(
                      children: cuentaCorriente.movimientos.data
                          .map((m) => MovimientoCtaCteItem(movimiento: m))
                          .toList(),
                    ),
                ],
              ),
            ),
            const Divider(height: 32),
            Text('Historial de compras', style: Theme.of(context).textTheme.titleMedium),
            comprasAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Text('Error al cargar compras: $error'),
              data: (result) => result.data.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Todavía no tiene compras.'),
                    )
                  : Column(
                      children: result.data
                          .map(
                            (c) => CompraListItem(
                              compra: c,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CompraDetailScreen(compraId: c.id),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
