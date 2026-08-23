import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/clientes_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../models/cliente_estadisticas_model.dart';
import '../../models/cliente_model.dart';
import '../../providers/clientes_providers.dart';
import '../login/login_screen.dart';
import '../ventas/venta_detail_screen.dart';
import 'cliente_form_screen.dart';
import 'widgets/movimiento_cta_cte_item.dart';
import 'widgets/pago_cta_cte_dialog.dart';
import 'widgets/venta_historial_item.dart';

class ClienteDetailScreen extends ConsumerWidget {
  const ClienteDetailScreen({super.key, required this.clienteId});

  final String clienteId;

  Future<void> _registrarPago(BuildContext context, WidgetRef ref) async {
    final resultado = await showDialog<({int monto, String formaPago, String? nota})>(
      context: context,
      builder: (_) => const PagoCtaCteDialog(),
    );
    if (resultado == null) return;

    try {
      await ref.read(clientesRepositoryProvider).registrarPago(
            clienteId,
            monto: resultado.monto,
            formaPago: resultado.formaPago,
            nota: resultado.nota,
          );
      ref.invalidate(clienteCuentaCorrienteProvider(clienteId));
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
    final clienteAsync = ref.watch(clienteDetailProvider(clienteId));
    final ventasAsync = ref.watch(clienteVentasProvider(clienteId));
    final estadisticasAsync = ref.watch(clienteEstadisticasProvider(clienteId));
    final cuentaCorrienteAsync = ref.watch(clienteCuentaCorrienteProvider(clienteId));
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_clientes') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del cliente'),
        actions: [
          if (puedeEditar)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final cliente = clienteAsync.value;
                if (cliente == null) return;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ClienteFormScreen(cliente: cliente)),
                );
              },
            ),
        ],
      ),
      body: clienteAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (cliente) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(cliente.nombre, style: Theme.of(context).textTheme.headlineSmall),
                ),
                if (!cliente.activo)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Chip(label: Text('Inactivo')),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Condición IVA: ${condicionesIva[cliente.condicionIva] ?? cliente.condicionIva}'),
            if (cliente.dniCuit != null) Text('DNI/CUIT: ${cliente.dniCuit}'),
            if (cliente.direccion != null) Text('Dirección: ${cliente.direccion}'),
            if (cliente.telefono != null) Text('Teléfono: ${cliente.telefono}'),
            if (cliente.email != null) Text('Email: ${cliente.email}'),
            if (cliente.zona != null) Text('Zona: ${cliente.zona}'),
            if (cliente.porcentajeDescuento > 0)
              Text('Descuento: ${cliente.porcentajeDescuento}%'),
            const Divider(height: 32),
            Text('Total comprado', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            estadisticasAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error al cargar estadísticas: $error'),
              data: (estadisticas) => Row(
                children: [
                  Expanded(child: _ResumenPeriodoCard(titulo: 'Hoy', resumen: estadisticas.hoy)),
                  const SizedBox(width: 12),
                  Expanded(child: _ResumenPeriodoCard(titulo: 'Este mes', resumen: estadisticas.mes)),
                  const SizedBox(width: 12),
                  Expanded(child: _ResumenPeriodoCard(titulo: 'Este año', resumen: estadisticas.anio)),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Text(
                        'Saldo: \$${cuentaCorriente.saldoPesos.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cuentaCorriente.saldo > 0
                              ? (cuentaCorriente.superaLimite
                                  ? AppColors.danger
                                  : AppColors.warning)
                              : AppColors.success,
                        ),
                      ),
                      if (cuentaCorriente.limitePesos != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '(límite \$${cuentaCorriente.limitePesos!.toStringAsFixed(2)})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
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
            Text('Historial de ventas', style: Theme.of(context).textTheme.titleMedium),
            ventasAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Text('Error al cargar ventas: $error'),
              data: (result) => result.data.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Todavía no tiene ventas.'),
                    )
                  : Column(
                      children: result.data
                          .map(
                            (v) => VentaHistorialItem(
                              venta: v,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => VentaDetailScreen(ventaId: v.id),
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

class _ResumenPeriodoCard extends StatelessWidget {
  const _ResumenPeriodoCard({required this.titulo, required this.resumen});

  final String titulo;
  final ClienteResumenPeriodo resumen;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(
              '\$${resumen.totalPesos.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${resumen.cantidad} venta${resumen.cantidad == 1 ? '' : 's'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
